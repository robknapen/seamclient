/*
 * wallace: ProjectRoleDefinitionMediator.as
 * ==============================================================================
 * This work has been carried out as part of the SEAMLESS Integrated Framework
 * project, EU 6th Framework Programme, contract no. 010036-2 and/or as part
 * of the SEAMLESS association.
 *
 * Copyright (c) 2009 The SEAMLESS Association.
 *
 * For more information: http://www.seamlessassociation.org;
 * email: info@seamless-if.org
 *
 * The contents of this file is subject to the SEAMLESS Association License for
 * software infrastructure and model components Version 1.1 (the "License");
 * you may not use this file except in compliance with the License. You may
 * obtain a copy of the License at http://www.seamlessassociation.org/License.htm
 *
 * Software distributed under the License is distributed on an "AS IS"  basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific governing rights and limitations.
 *
 * The Initial Developers of the Original Code are:
 *  - Benny Johnsson; Lund University
 *  - Rob Knapen; Alterra, Wageningen UR
 *  - Michiel Rop; Alterra, Wageningen UR / ilionX
 *  - Lorenzo Ruinelli; IDSIA Dalle Molle Institute for Artificial Intelligence
 * ================================================================================
 * Contributor(s): N/A
 * ================================================================================
 */

package org.seamless_ip.ui.usermanagement
{
import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.rpc.AbstractOperation;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.seamless_ip.services.transferobjects.seamproj.PermisionGroup;
import org.seamless_ip.services.transferobjects.seamproj.Project;
import org.seamless_ip.services.transferobjects.seamproj.ProjectRole;
import org.seamless_ip.services.transferobjects.seamproj.User;

public class ProjectRoleDefinitionMediator
{
    /** the view that this mediator controls */
    public var projectRoleDefinition:ProjectRoleDefinition;

    /* the service that this mediator uses to persist */
    private var userService:UserService;

    private var projectService:ProjectService;

    /* active user, used for retrieving relevant set of projects and permissionGroups */
    private var _activeUser:User;

    /* the one and only instance of this mediator */
    private static var instance:ProjectRoleDefinitionMediator;

    public function set activeUser(user:User):void
    {
        var user_id:String;

        _activeUser = user;
        user_id = user.id;
        projectService.findAll(user_id);
    }

    public function get activeUser():User
    {
        return _activeUser;
    }

    /**
     * get the one and only instance
     * makes sure that this constructor can only be called from
     * within this class by adding a privateclass the parameters
     *
     * @param userDefinition view that this mediator controls
     * @param privateClass assures that this constructor cannot be called by any other class
     */
    public function ProjectRoleDefinitionMediator(projectRoleDefinition:ProjectRoleDefinition, privateClass:PrivateClass) {
        var userId:int;

        this.projectRoleDefinition = projectRoleDefinition;
        userService = new UserService();
        projectService = new ProjectService();


        // TODO replace by call to service
        projectRoleDefinition.permissionGroups = getPermissionGroups();

    }

    /**
     * creates instance of this mediator
     *
     * @param userDefintion view to control
     * @return the one and only instance of this mediator
     */
    public static function create(projectRoleDefinition:ProjectRoleDefinition):ProjectRoleDefinitionMediator {
        if (ProjectRoleDefinitionMediator.instance == null) {
            ProjectRoleDefinitionMediator.instance = new ProjectRoleDefinitionMediator(projectRoleDefinition, new PrivateClass());
        }
        return ProjectRoleDefinitionMediator.instance;
    }

    /**
     * get the instance
     */
    public static function getInstance():ProjectRoleDefinitionMediator {
        return ProjectRoleDefinitionMediator.instance;
    }

    public function getProjects():ArrayCollection {
        var projects:ArrayCollection;

        projects = new ArrayCollection();

        return projects;
    }

    public function getPermissionGroups():ArrayCollection {
        var permissionGroups:ArrayCollection;
        var viewerPermissionGroup:PermisionGroup;
        var projectManagerPermissionGroup:PermisionGroup;
        var modellerPermissionGroup:PermisionGroup;
        var administrationPermissionGroup:PermisionGroup;

        permissionGroups = new ArrayCollection();
        viewerPermissionGroup = new PermisionGroup();
        viewerPermissionGroup.label = "Viewer";
        permissionGroups.addItem(viewerPermissionGroup);

        projectManagerPermissionGroup = new PermisionGroup();
        projectManagerPermissionGroup.label = "Project Manager";
        permissionGroups.addItem(projectManagerPermissionGroup);


        modellerPermissionGroup = new PermisionGroup();
        modellerPermissionGroup.label = "Modeller";
        permissionGroups.addItem(modellerPermissionGroup);


        return permissionGroups;
    }

    public function registerEventHandlers():void {
        var findAllOperation:AbstractOperation;
        var saveOperation:AbstractOperation;
        var findAllProjectsOperation:AbstractOperation;
        var findAllUsersOperation:AbstractOperation;

        var userListMediator:UserListMediator;
        var userList:UserList;

        var projectRoleListMediator:ProjectRoleListMediator;
        var projectRoleList:ProjectRoleList;


        projectRoleListMediator = ProjectRoleListMediator.getInstance();
        projectRoleList = projectRoleListMediator.projectRoleList;

        userListMediator = UserListMediator.getInstance();
        userList = userListMediator.userList;

        projectRoleListMediator = ProjectRoleListMediator.getInstance();
        projectRoleList = projectRoleListMediator.projectRoleList;

        saveOperation = userService.getSaveOperation();
        findAllUsersOperation = userService.getFindAllOperation();
        findAllProjectsOperation = projectService.getFindAllOperation();

        findAllProjectsOperation.addEventListener(ResultEvent.RESULT, findAllProjectsResultHandler, false, 0, true);
        findAllProjectsOperation.addEventListener(FaultEvent.FAULT, findAllProjectsFaultHandler, false, 0, true);


        projectRoleList.addEventListener(ProjectRoleList.CHANGE, projectRoleListChangeHandler);
        projectRoleList.addEventListener(ProjectRoleList.CREATE, createHandler);
        projectRoleList.addEventListener(ProjectRoleList.UPDATE, updateHandler);

        projectRoleDefinition.addEventListener(ProjectRoleDefinition.SAVE, saveHandler);
        projectRoleDefinition.addEventListener(ProjectRoleDefinition.DISCARD, discardHandler);
    }


    public function updateHandler(event:Event):void {
        var projectRoleList:ProjectRoleList;
        var projectRoleListMediator:ProjectRoleListMediator;
        var selectedProjectRole:ProjectRole;

        projectRoleListMediator = ProjectRoleListMediator.getInstance();
        projectRoleList = projectRoleListMediator.projectRoleList;

        projectRoleDefinition.selectedProjectRole = projectRoleList.selectedProjectRole;

        projectRoleDefinition.editMode = true;

    }

    public function createHandler(event:Event):void {
        projectRoleDefinition.editMode = false;
    }


    private function saveHandler(event:Event):void {
        var userDefinition:UserDefinition;
        var userDefinitionMediator:UserDefinitionMediator;
        var selectedUser:User;
        var lastRetrievedUser:User;
        var projectRoleList:ProjectRoleList;
        var projectRoleListMediator:ProjectRoleListMediator;
        var selectedProjectRoleVO:ProjectRoleVO;
        var selectedProjectRole:ProjectRole;
        var roles:ArrayCollection;


        projectRoleListMediator = ProjectRoleListMediator.getInstance();
        projectRoleList = projectRoleListMediator.projectRoleList;

        // get selected user
        userDefinitionMediator = UserDefinitionMediator.getInstance();
        userDefinition = userDefinitionMediator.userDefinition;
        selectedUser = userDefinition.user;


        if (!projectRoleDefinition.editMode) {
            roles = selectedUser.roles;
            roles.addItem(projectRoleDefinition.selectedProjectRole);
        }
        projectRoleList.update();


    }

    private function discardHandler(event:Event = null):void {

    }

    private function findAllProjectsResultHandler(event:ResultEvent):void {
        var projects:ArrayCollection;
        var objects:ArrayCollection;
        var project:Project;


        projects = new ArrayCollection();
        objects = event.result as ArrayCollection;
        for each (var object:Object in objects) {
            project = Project(object);
            if (project.title == null) {
                project.title = "Not specified";
            }
            projects.addItem(project);
        }
        projectRoleDefinition.projects = projects;

    }

    private function findAllProjectsFaultHandler(event:FaultEvent):void
    {

    }


    private function projectRoleListChangeHandler(event:Event):void {
    }


}
}
class PrivateClass
{
    public function PrivateClass() {
    }
}
