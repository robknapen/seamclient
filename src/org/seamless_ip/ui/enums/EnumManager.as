/*
 * wallace: EnumManager.as
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
package org.seamless_ip.ui.enums
{
import mx.collections.ArrayCollection;

import org.seamless_ip.services.remoting.RequestProgressEvent;

/**
 * Singleton class to manage all enumerations used in the GUI. The values of
 * enumerations are retrieved from the server and stored locally in memory.
 *
 * For practical reasons the rule is that the index (id) of the enumeration
 * values (and enumeration model classes) must match the index (or id) of the
 * value on the server (in the database). There is no guarantee that this is
 * numeric, sequential or starts with the value 1 (one).
 *
 * @author Rob Knapen
 */
public class EnumManager
{
    /**
     * Singleton instance of the class.
     */
    private static var _instance:EnumManager;


    /**
     * Initialisation progress flag. True while the enumeration data is
     * being retrieved from the server, false when it is done. Download
     * starts when the instance is created.
     *
     * Binding can be used to track the variable, like so:
     *     BindingUtils.bindSetter(updateInitializeState, enumManager, "initInProgress");
     */
    [Bindable]
    public var initInProgress:Boolean = false;


    /**
     * Initialisation progress message.
     *
     * Binding can be used to track the variable, like so:
     *     BindingUtils.bindSetter(updateProgressMessage, enumManager, "progressMessage");
     */
    [Bindable]
    public var progressMessage:String = "Caching Data";


    /**
     * Instance of EnumServices used to retrieve and keep in memory the
     * values of several enumeration classes.
     */
    private var _enumSrv:EnumServices;


    /**
     * Creates an instance. Uses a little trick to make sure that only
     * the class itself can call the constructor. This is needed because
     * Actionscript 3 does not support private constructors.
     *
     * @param pvt PrivateClass, only visible to the EnumManager
     */
    public function EnumManager(pvt:PrivateClass) {
        // void
    }


    /**
     * Gets the singleton instance of the class.
     */
    public static function get instance():EnumManager {
        if (_instance == null) {
            _instance = new EnumManager(new PrivateClass());
            _instance.init();
        }
        return _instance;
    }


    /**
     * Initialises the instance, starts the download of the values for
     * enumerations from the server.
     */
    public function init():void {
        initInProgress = true;
        dispatchEvent(new Event("propertyChanged"));

        // use EnumServices to get enumerations
        _enumSrv = new EnumServices();
        _enumSrv.clear();
        _enumSrv.registerForEvents(requestProgressEventHandler);

        for each (var name:EnumClassName in EnumClassName.values)
            _enumSrv.updateForEnumClass(name);
    }


    /**
     * Handler to receive and deal with download progress events.
     *
     * @param event
     */
    private function requestProgressEventHandler(event:RequestProgressEvent):void {
        progressMessage = event.message;
        dispatchEvent(new Event("propertyChanged"));

        if (event.type == RequestProgressEvent.REQUEST_COMPLETED) {
            var inProgress:Boolean = (_enumSrv.openRequests > 0);
            if (initInProgress != inProgress) {
                initInProgress = inProgress;
                dispatchEvent(new Event("propertyChanged"));
            }
        }
    }


    /**
     * Resets the service center to an uninitialized state.
     */
    public static function reset():void {
        _instance = null;
    }


    /**
     * Gets all values for an enumeration class. Can be applied to all
     * the classes handled by this EnumManager.
     *
     * @param enumName Name of an enumeration class
     * @return ArrayCollection with IEnumValue instances
     */
    public function getEnumValues(enumName:EnumClassName):ArrayCollection {
        return _enumSrv.getEnumClassValues(enumName);
    }
}
}


/**
 * This class is a trick to make the singleton a little bit more safe in
 * Actionscript 3, since it does not support private constructors.
 */
class PrivateClass
{
    /**
     * Constructor, creates a new instance.
     */
    public function PrivateClass() {
        // void
    }
}
