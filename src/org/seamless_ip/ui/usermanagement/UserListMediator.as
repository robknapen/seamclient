/*
 * wallace: UserListMediator.as
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
import mx.containers.VBox;
import mx.containers.ViewStack;
import mx.controls.Alert;
import mx.rpc.AbstractOperation;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.seamless_ip.services.transferobjects.seamproj.User;
import org.seamless_ip.ui.common.ServerProgressView;

/**
 * Mediator for the UserList view.
 *
 * @author Michiel Rop
 */
public class UserListMediator
{
    public var userList:UserList;

    private var requestsInProgress:Number = 0;


    private var userService:UserService;

    private static var instance:UserListMediator;

    /**
     * get the one and only instance
     * makes sure that this constructor can only be called from
     * within this class by adding a privateclass the parameters
     *
     * @param userList view that this mediator controls
     * @param privateClass assures that this constructor cannot be called by any other class
     */
    public function UserListMediator(userList:UserList, privateClass:PrivateClass) {
        this.userList = userList;
        userService = new UserService();
        //registerEventHandlers();

    }

    /**
     * creates instance of this mediator
     *
     * @param userList view to control
     * @return the one and only instance of this mediator
     */
    public static function create(userList:UserList):UserListMediator {
        if (UserListMediator.instance == null) {
            UserListMediator.instance = new UserListMediator(userList, new PrivateClass());
        }
        return UserListMediator.instance;
    }

    /**
     * get the instance
     */
    public static function getInstance():UserListMediator {
        return UserListMediator.instance;
    }

    public function findAll(event:Event = null):void {
        var userDefinition:UserDefinition;
        var userDefinitionMediator:UserDefinitionMediator;

        userDefinitionMediator = UserDefinitionMediator.getInstance();
        userDefinition = userDefinitionMediator.userDefinition;
        userDefinition.user = null;
        userList.user = null;

        userService.findAll();
        updateProgress();
    }

    public function editUser(user:User):void {
        var userList:UserList;
        var userListMediator:UserListMediator;

        var userDefinition:UserDefinition;
        var userDefinitionMediator:UserDefinitionMediator;

        var projectRoleList:ProjectRoleList;
        var projectRoleListMediator:ProjectRoleListMediator;

        var roles:ArrayCollection;

        projectRoleListMediator = ProjectRoleListMediator.getInstance();
        projectRoleList = projectRoleListMediator.projectRoleList;

        userDefinitionMediator = UserDefinitionMediator.getInstance();
        userDefinition = userDefinitionMediator.userDefinition;

        userListMediator = UserListMediator.getInstance();
        userList = userListMediator.userList;
        if (user == null) return;
        user = userList.user;
        userDefinition.user = user;
        userDefinition.editMode = true;
        roles = user.roles;
        projectRoleList.projectRoles = roles;
        projectRoleList.removeButton.enabled = false;
    }

    public function newUser():void {
        var userDefinitionMediator:UserDefinitionMediator;
        var newUser:User;

        newUser = new User();
        userDefinitionMediator = UserDefinitionMediator.getInstance();
        userDefinitionMediator.setUser(newUser);
        userDefinitionMediator.setCreateMode();
    }


    public function removeUser(user:User):void {
        if (user == null) return;
        userService.remove(user);
        findAll();
    }

    public function registerEventHandlers():void {
        var findAllOperation:AbstractOperation;
        var removeOperation:AbstractOperation;

        var userDefinitionMediator:UserDefinitionMediator;
        var userDefinition:UserDefinition;

        userDefinitionMediator = UserDefinitionMediator.getInstance();
        userDefinition = userDefinitionMediator.userDefinition;


        findAllOperation = userService.getFindAllOperation();
        findAllOperation.addEventListener(ResultEvent.RESULT, findAllResultHandler, false, 0, true);
        findAllOperation.addEventListener(FaultEvent.FAULT, findAllFaultHandler, false, 0, true);

        removeOperation = userService.getRemoveOperation();
        removeOperation.addEventListener(ResultEvent.RESULT, removeResultHandler, false, 0, true);
        removeOperation.addEventListener(FaultEvent.FAULT, removeFaultHandler, false, 0, true);

        userList.addEventListener(UserList.CREATE, createHandler);
        userList.addEventListener(UserList.DELETE, deleteHandler);
        userList.addEventListener(UserList.UPDATE, updateHandler);
        userList.addEventListener(UserList.REFRESH, findAll);
        //userList.addEventListener(UserList.CHANGE, hideUserList);

        userDefinition.addEventListener(UserDefinition.DISCARD, userDefinitionDiscardHandler, false, 0, true);


    }

    private function updateProgress(taskCompleted:Boolean = false):void {
        var progressMessage:String;
        var mainView:ViewStack;
        var usersView:VBox;
        var progressView:ServerProgressView;

        progressMessage = "Idle";
        mainView = userList.mainView;

        if (!taskCompleted) {
            requestsInProgress++;
        }
        else {
            if (requestsInProgress > 0)
                requestsInProgress--;
        }

        if (requestsInProgress > 0) {
            progressMessage = "Download in progress, " + requestsInProgress + " task(s) remaining";
            userList.progressMessage = progressMessage;
            userList.mainView.selectedIndex = 0;
            userList.downLoadInProgress = true;
            //userList.mainView.selectedChild = userList.mainView.progressView;
        }
        else {
            progressMessage = "Download completed";
            userList.progressMessage = progressMessage;
            userList.mainView.selectedIndex = 1;
            userList.downLoadInProgress = false;
            //userList.mainView.selectedChild = userList.mainView.userListView;
        }
    }

    private function hideUserList(event:Event = null):void {
        var userList:UserList;
        var userListMediator:UserListMediator;

        var userDefinition:UserDefinition;
        var userDefinitionMediator:UserDefinitionMediator;

        var projectRoleList:ProjectRoleList;
        var projectRoleListMediator:ProjectRoleListMediator;

        projectRoleListMediator = ProjectRoleListMediator.getInstance();
        projectRoleList = projectRoleListMediator.projectRoleList;

        userDefinitionMediator = UserDefinitionMediator.getInstance();
        userDefinition = userDefinitionMediator.userDefinition;

        var user:User;
        var roles:ArrayCollection;

        userListMediator = UserListMediator.getInstance();
        userList = userListMediator.userList;
        user = userList.user;
        userDefinition.user = user;
        roles = user.roles;
        projectRoleList.projectRoles = roles;
        projectRoleList.removeButton.enabled = false;

    }

    private function findAllResultHandler(event:ResultEvent):void {
        userList.users = event.result as ArrayCollection;
        updateProgress(true);
    }

    private function findAllFaultHandler(event:FaultEvent):void {
        Alert.show("Error retrieving data from server: " + event.fault.faultString, "Server error");
        updateProgress(true);
    }

    private function removeResultHandler(event:ResultEvent):void {

    }

    private function removeFaultHandler(event:FaultEvent):void {
        Alert.show("Error retrieving data from server: " + event.fault.faultString, "Server error");
        updateProgress(true);
    }

    private function createHandler(event:Event = null):void {
        newUser();
    }

    private function updateHandler(event:Event = null):void {
        editUser(userList.user);
    }

    private function deleteHandler(event:Event = null):void {
        var user:User;
        user = userList.user;
        removeUser(user);
    }

    private function userDefinitionDiscardHandler(event:Event = null):void {
    }


}
}
class PrivateClass
{
    public function PrivateClass() {
    }
}