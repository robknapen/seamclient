/*
 * wallace: ProjectRoleListMediator.as
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

import org.seamless_ip.services.transferobjects.seamproj.IRole;
import org.seamless_ip.services.transferobjects.seamproj.Project;
import org.seamless_ip.services.transferobjects.seamproj.ProjectRole;
import org.seamless_ip.services.transferobjects.seamproj.User;

/**
 * Mediator for the ProjectRoleList view.
 *
 * @author Michiel Rop
 */
public class ProjectRoleListMediator
{
    /** the view that this mediator controls */
    public var projectRoleList:ProjectRoleList;

    /* the service that this mediator uses to persist */
    private var userService:UserService;

    /* the one and only instance of this mediator */
    private static var instance:ProjectRoleListMediator;

    /**
     * get the one and only instance
     * makes sure that this constructor can only be called from
     * within this class by adding a privateclass the parameters
     *
     * @param userDefinition view that this mediator controls
     * @param privateClass assures that this constructor cannot be called by any other class
     */
    public function ProjectRoleListMediator(projectRoleList:ProjectRoleList, privateClass:PrivateClass) {
        this.projectRoleList = projectRoleList;
        userService = new UserService();


        //registerEventHandlers();
    }

    /**
     * creates instance of this mediator
     *
     * @param userDefintion view to control
     * @return the one and only instance of this mediator
     */
    public static function create(projectRoleList:ProjectRoleList):ProjectRoleListMediator {
        if (ProjectRoleListMediator.instance == null) {
            ProjectRoleListMediator.instance = new ProjectRoleListMediator(projectRoleList, new PrivateClass());
        }
        return ProjectRoleListMediator.instance;
    }

    /**
     * get the instance
     */
    public static function getInstance():ProjectRoleListMediator {
        return ProjectRoleListMediator.instance;
    }

    public function registerEventHandlers():void {
        var updateOperation:AbstractOperation;

        var userListMediator:UserListMediator;
        var userList:UserList;
        var userDefinition:UserDefinition;
        var userDefinitionMediator:UserDefinitionMediator;

        userDefinitionMediator = UserDefinitionMediator.getInstance();
        userDefinition = userDefinitionMediator.userDefinition;
        userListMediator = UserListMediator.getInstance();
        userList = userListMediator.userList;

        updateOperation = userService.getUpdateOperation();
        updateOperation.addEventListener(ResultEvent.RESULT, updateResultHandler, false, 0, true);
        updateOperation.addEventListener(FaultEvent.FAULT, updateFaultHandler, false, 0, true);

        projectRoleList.addEventListener(ProjectRoleList.DELETE, deleteHandler);
        projectRoleList.addEventListener(ProjectRoleList.CHANGE, changeHandler);
        userList.addEventListener(UserList.REFRESH, refreshHandler);
        userList.addEventListener(UserList.CHANGE, userListChangeHandler);

        userDefinition.addEventListener(UserDefinition.DISCARD, hide);
        userDefinition.addEventListener(UserDefinition.SAVE, hide);

    }

    private function hide(event:Event = null):void {

    }

    private function show(event:Event = null):void {
    }

    public function getProjectRoleVOs(roles:ArrayCollection):ArrayCollection {
        var role:IRole;
        var projectRole:ProjectRole;
        var projectRoleVO:ProjectRoleVO;
        var projectRoleVOs:ArrayCollection;
        var project:Project;
        var roleTitle:String;
        var projectTitle:String;
        var projectDescription:String;

        projectRoleVOs = new ArrayCollection();
        for each (role in roles) {
            if (( role is ProjectRole ) && ( role != null )) {
                projectRole = ProjectRole(role);
                project = projectRole.project;
                roleTitle = projectRole.title;
                projectTitle = project.title;
                projectDescription = project.description;
                projectRoleVO = new ProjectRoleVO(roleTitle, projectTitle, projectDescription);
                projectRoleVOs.addItem(projectRoleVO);
            }
        }
        return projectRoleVOs;
    }

    public function addProjectRole():void {

    }

    public function deleteHandler(event:Event = null) :void {
        // selected projectRole in projectRoleList
        var selectedProjectRole:ProjectRole;
        // index of selected projectRole
        var selectedProjectRoleIndex:int;
        // collection with all projectRoles
        var projectRoles:ArrayCollection;


        // get selected projectRole
        selectedProjectRole = projectRoleList.selectedProjectRole;

        projectRoles = projectRoleList.projectRoles;
        // get index of selectedProjectRole in the list
        selectedProjectRoleIndex = projectRoles.getItemIndex(selectedProjectRole);

        if (selectedProjectRoleIndex != -1) {
            projectRoles.removeItemAt(selectedProjectRoleIndex);
            projectRoleList.update();
        }
        // else do nothing...


    }

    private function changeHandler(event:Event = null):void {
        projectRoleList.removeButton.enabled = true;
    }


    private function updateResultHandler(event:ResultEvent):void {
        var user:User;
        var retrievedUser:User;
        var userListMediator:UserListMediator;
        var userList:UserList;

        // get selected user
        userListMediator = UserListMediator.getInstance();
        userList = userListMediator.userList;
        retrievedUser = event.result as User;
        userList.user = retrievedUser;

        projectRoleList.projectRoles = retrievedUser.roles;

    }

    private function updateFaultHandler(event:FaultEvent):void {

    }

    public function editProjectRole(projectRole:ProjectRole):void {

    }

    private function refreshHandler(event:Event = null):void {
        projectRoleList.projectRoles = null;
    }

    private function userListChangeHandler(event:Event = null):void {


    }
}
}
class PrivateClass
{
    public function PrivateClass() {
    }
}