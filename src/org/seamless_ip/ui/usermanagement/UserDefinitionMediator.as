/*
 * wallace: UserDefinitionMediator.as
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

import mx.controls.Alert;
import mx.rpc.AbstractOperation;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.seamless_ip.services.transferobjects.seamproj.User;

/**
 * Mediator for the UserDefinition view.
 *
 * @author Michiel Rop
 */
public class UserDefinitionMediator
{
    /** the view that this mediator controls */
    public var userDefinition:UserDefinition;

    /** the active user instance */
    public var activeUser:User;

    /* the service that this mediator uses to persist */
    private var userService:UserService;

    /* the one and only instance of this mediator */
    private static var instance:UserDefinitionMediator;

    /**
     * get the one and only instance
     * makes sure that this constructor can only be called from
     * within this class by adding a privateclass the parameters
     *
     * @param userDefinition view that this mediator controls
     * @param privateClass assures that this constructor cannot be called by any other class
     */
    public function UserDefinitionMediator(userDefinition:UserDefinition, privateClass:PrivateClass) {
        this.userDefinition = userDefinition;
        userService = new UserService();
        //registerEventHandlers();
    }

    /**
     * creates instance of this mediator
     *
     * @param userDefintion view to control
     * @return the one and only instance of this mediator
     */
    public static function create(userDefinition:UserDefinition):UserDefinitionMediator {
        if (UserDefinitionMediator.instance == null) {
            UserDefinitionMediator.instance = new UserDefinitionMediator(userDefinition, new PrivateClass());
        }
        return UserDefinitionMediator.instance;
    }

    /**
     * get the instance
     */
    public static function getInstance():UserDefinitionMediator {
        return UserDefinitionMediator.instance;
    }

    private function saveHandler(event:Event = null):void {
        var locallyUpdatedUser:User;
        var unUpdatedUser:User;

        locallyUpdatedUser = userDefinition.user;
        unUpdatedUser = userDefinition.unUpdatedUser;
        if (userDefinition.editMode) {
            userService.update(locallyUpdatedUser, unUpdatedUser);
        }
        else {
            userService.save(locallyUpdatedUser.Clone());
        }
    }

    private function discardHandler(event:Event = null):void {

        if (userDefinition.editMode) {
            userDefinition.update();
        }
        else {
            userDefinition.clear();
            userDefinition.user = null;
        }

    }


    /**
     * sets the user
     */
    public function setUser(user:User):void {
        userDefinition.user = user;
    }

    /**
     * switches view to editMode
     */
    public function setEditMode():void {
        userDefinition.editMode = true;
    }

    /**
     * switches view to createMode
     */
    public function setCreateMode():void {
        userDefinition.editMode = false;
    }

    public function registerEventHandlers():void {
        var updateOperation:AbstractOperation;
        var saveOperation:AbstractOperation;

        updateOperation = userService.getUpdateOperation();
        updateOperation.addEventListener(ResultEvent.RESULT, updateResultHandler, false, 0, true);
        updateOperation.addEventListener(FaultEvent.FAULT, updateFaultHandler, false, 0, true);

        saveOperation = userService.getSaveOperation();
        saveOperation.addEventListener(ResultEvent.RESULT, saveResultHandler, false, 0, true);
        saveOperation.addEventListener(FaultEvent.FAULT, saveFaultHandler, false, 0, true);

        userDefinition.addEventListener(UserDefinition.SAVE, saveHandler);
        userDefinition.addEventListener(UserDefinition.DISCARD, discardHandler);

    }

    private function updateResultHandler(event:ResultEvent):void {
        var userListMediator:UserListMediator;

        userListMediator = UserListMediator.getInstance();
        userListMediator.findAll();

    }

    private function updateFaultHandler(event:FaultEvent):void {
        var userListMediator:UserListMediator;

        Alert.show(event.message.toString());
        userListMediator = UserListMediator.getInstance();
        userListMediator.findAll();
    }

    private function saveResultHandler(event:ResultEvent):void {
        var userListMediator:UserListMediator;
        userListMediator = UserListMediator.getInstance();
        userListMediator.findAll();

    }

    private function saveFaultHandler(event:FaultEvent):void {
        var userListMediator:UserListMediator;


        Alert.show(event.message.toString());
        userListMediator = UserListMediator.getInstance();
        userListMediator.findAll();
    }


}
}
class PrivateClass
{
    public function PrivateClass() {
    }
}