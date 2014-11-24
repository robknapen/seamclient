/*
 * wallace: RemotingBaseServices.as
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
package org.seamless_ip.services.remoting
{
import flash.events.EventDispatcher;
import flash.utils.getQualifiedClassName;

import mx.collections.ArrayCollection;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.mxml.RemoteObject;

/**
 * This is a base class for handling SeamFrame server services. Currently
 * the server only handles basic CRUD data requests and most business logic
 * must be build into the client(s). This class and subclasses are intended
 * to centralize the access to SeamFrame and facilitate maintenance.
 */
public class RemotingBaseServices extends EventDispatcher
{
    protected var _showErrorPopups:Boolean = true;
    protected var _items:ArrayCollection = new ArrayCollection();


    /**
     * Counter of the number of outstanding server requests.
     */
    private var _openRequests:uint = 0;


    /**
     * Returns the number of active server requests waiting for a
     * response. This is tracked by the events being dispatched.
     *
     * @return number of active server requests
     */
    [Bindable]
    public function get openRequests():uint
    {
        return _openRequests;
    }


    protected function set openRequests(requests:uint):void
    {
        _openRequests = requests;
    }


    public function get showErrorPopups():Boolean
    {
        return _showErrorPopups;
    }


    public function set showErrorPopups(state:Boolean):void
    {
        _showErrorPopups = state;
    }


    public function createDataRequest(channelName:String, methodName:String, resultListener:Function):RemoteObject
    {
        var ro:RemoteObject = new RemoteObject(channelName);

        ro.getOperation(methodName).addEventListener(ResultEvent.RESULT, resultListener, false, 0, true);
        ro.getOperation(methodName).addEventListener(FaultEvent.FAULT, readDataFaultHandler, false, 0, true);

        return ro;
    }


    /**
     * Register the listener method for all available events.
     */
    public function registerForEvents(listener:Function):void
    {
        addEventListener(RequestProgressEvent.REQUEST_SEND, listener, false, 0, true);
        addEventListener(RequestProgressEvent.REQUEST_COMPLETED, listener, false, 0, true);
        addEventListener(RequestProgressEvent.REQUEST_FAILED, listener, false, 0, true);
    }


    /**
     * Unregister the listener method for all available events.
     */
    public function unregisterForEvents(listener:Function):void
    {
        removeEventListener(RequestProgressEvent.REQUEST_SEND, listener);
        removeEventListener(RequestProgressEvent.REQUEST_COMPLETED, listener);
        removeEventListener(RequestProgressEvent.REQUEST_FAILED, listener);
    }


    /**
     * Sends a request send progress event.
     *
     * @param token The async token for the event
     * @param message Additional information to include
     */
    public function dispatchRequestSendEvent(token:Object, message:String = null):void
    {
        var fullMessage:String = "In Progress";

        _openRequests++;

        if ((message != null) && (message.length > 0))
            fullMessage = fullMessage + ": " + message;

        var rpe:RequestProgressEvent = new RequestProgressEvent(
                RequestProgressEvent.REQUEST_SEND,
                getQualifiedClassName(this),
                fullMessage,
                token
                );
        dispatchEvent(rpe);
        dispatchEvent(new Event("propertyChanged"));
        dispatchEvent(new OpenRequestsEvent(_openRequests));

    }


    /**
     * Sends a request completed progress event.
     *
     * @param token The async token for the event
     * @param itemCount The number of items processed
     * @param message Additional information to include
     */
    public function dispatchRequestCompletedEvent(token:Object, itemCount:uint, message:String = null):void
    {
        var fullMessage:String = "Finished";

        _openRequests--;

        if ((message != null) && (message.length > 0))
            fullMessage = fullMessage + " (" + message + ")";

        var rpe:RequestProgressEvent = new RequestProgressEvent(
                RequestProgressEvent.REQUEST_COMPLETED,
                getQualifiedClassName(this),
                fullMessage,
                token
                );
        rpe.processedItemsCount = itemCount;
        dispatchEvent(rpe);
        dispatchEvent(new Event("propertyChanged"));
        dispatchEvent(new OpenRequestsEvent(_openRequests));
    }


    /**
     * Sends a request failed progress event.
     *
     * @param token The async token for the event
     * @param message Additional information to include
     */
    public function dispatchRequestFailedEvent(token:Object, message:String = null):void
    {
        var fullMessage:String = "Server Error";

        _openRequests--;

        if ((message != null) && (message.length > 0))
            fullMessage = fullMessage + ": " + message;

        var rpe:RequestProgressEvent = new RequestProgressEvent(
                RequestProgressEvent.REQUEST_FAILED,
                getQualifiedClassName(this),
                fullMessage,
                token
                );
        rpe.processedItemsCount = 0;
        dispatchEvent(rpe);
        dispatchEvent(new Event("propertyChanged"));
        dispatchEvent(new OpenRequestsEvent(_openRequests));
    }


    /**
     * Default handler for fault events from the read data request.
     */
    public function readDataFaultHandler(event:FaultEvent):void
    {
        dispatchRequestFailedEvent(event.token, event.fault.faultString);

        if (_showErrorPopups)
        {
            /* var myPopUp:IFlexDisplayObject = PopUpManager.createPopUp(Application.application as DisplayObject, ServletErrorDlg, true);
             ServletErrorDlg(myPopUp).event = event;
             PopUpManager.centerPopUp(myPopUp); */
            // TODO migrate ServletErrorDlg to wallace
        }
    }


    public function baseFindById(id:String):Object
    {
        for each (var obj:Object in _items)
        {
            if (obj.id == id)
                return obj;
        }

        return null;
    }
}
}