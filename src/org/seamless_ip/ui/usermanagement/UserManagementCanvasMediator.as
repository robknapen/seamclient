/*
 * wallace: UserManagementCanvasMediator.as
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

public class UserManagementCanvasMediator
{
    /** the view that this mediator controls */
    public var userManagementCanvas:UserManagementCanvas;


    /* the one and only instance of this mediator */
    private static var instance:UserManagementCanvasMediator;

    private var userListMediator:UserListMediator;
    private var userDefinitionMediator:UserDefinitionMediator;
    private var projectRoleListMediator:ProjectRoleListMediator;
    private var projectRoleDefinitionMediator:ProjectRoleDefinitionMediator;

    private var userList:UserList;
    private var userDefinition:UserDefinition;
    private var projectRoleList:ProjectRoleList;
    private var projectRoleDefinition:ProjectRoleDefinition;

    /**
     * get the one and only instance
     * makes sure that this constructor can only be called from
     * within this class by adding a privateclass the parameters
     *
     * @param userDefinition view that this mediator controls
     * @param privateClass assures that this constructor cannot be called by any other class
     */
    public function UserManagementCanvasMediator(userManagementCanvas:UserManagementCanvas, privateClass:PrivateClass) {
        this.userManagementCanvas = userManagementCanvas;
        userListMediator = UserListMediator.getInstance();
        userList = userListMediator.userList;

        userDefinitionMediator = UserDefinitionMediator.getInstance();
        userDefinition = userDefinitionMediator.userDefinition;

        projectRoleListMediator = ProjectRoleListMediator.getInstance();
        projectRoleList = projectRoleListMediator.projectRoleList;

        projectRoleDefinitionMediator = ProjectRoleDefinitionMediator.getInstance();
        projectRoleDefinition = projectRoleDefinitionMediator.projectRoleDefinition;
    }

    /**
     * creates instance of this mediator
     *
     * @param userDefintion view to control
     * @return the one and only instance of this mediator
     */
    public static function create(userManagementCanvas:UserManagementCanvas):UserManagementCanvasMediator {
        if (UserManagementCanvasMediator.instance == null) {
            UserManagementCanvasMediator.instance = new UserManagementCanvasMediator(userManagementCanvas, new PrivateClass());
        }
        return UserManagementCanvasMediator.instance;
    }

    /**
     * get the instance
     */
    public static function getInstance():UserManagementCanvasMediator {
        return UserManagementCanvasMediator.instance;
    }

    public function registerEvents():void {


        projectRoleDefinition.addEventListener(ProjectRoleDefinition.DISCARD, editUser);
        projectRoleDefinition.addEventListener(ProjectRoleDefinition.SAVE, editUser);

        userList.addEventListener(UserList.UPDATE, editUser);
        userList.addEventListener(UserList.CREATE, editUser);

        userDefinition.addEventListener(UserDefinition.DISCARD, editUserList);
        userDefinition.addEventListener(UserDefinition.SAVE, editUserList);

        projectRoleList.addEventListener(ProjectRoleList.CREATE, editProjectRole);
        projectRoleList.addEventListener(ProjectRoleList.UPDATE, editProjectRole);


    }

    private function closeHandler(event:Event = null):void {
        // make sure we end up with the user list
        editUserList();
    }

    private function editUser(event:Event = null):void {
        userList.hide();
        userDefinition.show();
        projectRoleList.show();
        projectRoleDefinition.hide();
        validate();
    }

    private function editProjectRole(event:Event = null):void {
        userList.hide();
        userDefinition.hide();
        projectRoleList.show();
        projectRoleDefinition.show();
        validate();
    }

    private function validate(event:Event = null):void {
        userManagementCanvas.invalidateSize();
        userManagementCanvas.invalidateDisplayList();
        userManagementCanvas.invalidateProperties();
    }

    private function editUserList(event:Event = null):void {
        userList.show();
        userDefinition.hide();
        projectRoleList.hide();
        ;
        projectRoleDefinition.hide();
        validate();
    }

}
}
class PrivateClass
{
    public function PrivateClass() {
    }
}