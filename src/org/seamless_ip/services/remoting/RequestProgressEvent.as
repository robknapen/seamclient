/*
 * wallace: RequestProgressEvent.as
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
import flash.events.Event;

/**
 * Event signalling steps in the asynchronous data retrieval and processing.
 */
public class RequestProgressEvent extends Event
{
    public static const REQUEST_SEND:String = "requestSend";
    public static const REQUEST_COMPLETED:String = "requestCompleted";
    public static const REQUEST_FAILED:String = "requestFailed";

    public var timestamp:Date;
    public var sender:String;
    public var message:String;
    public var processedItemsCount:uint;
    public var token:Object;

    /**
     * Creates an instance.
     *
     * @param type The type of the event
     * @param sender The sender of the event
     * @param message The text to display
     * @param token Of the concerning request
     */
    public function RequestProgressEvent(type:String, sender:String, message:String, token:Object)
    {
        super(type, true, true);
        this.timestamp = new Date();
        this.message = message;
        this.processedItemsCount = 0;
        this.sender = sender;
        this.token = token;
    }


    /**
     * Creates and returns a copy of the current instance.
     *
     * @return A copy of the current instance.
     */
    override public function clone():Event
    {
        var evt:RequestProgressEvent = new RequestProgressEvent(type, sender, message, token);
        evt.processedItemsCount = this.processedItemsCount;
        evt.timestamp = this.timestamp;
        return evt;
    }


    /**
     * Returns a String containing all the properties of the current
     * instance.
     *
     * @return A string representation of the current instance.
     */
    public override function toString():String
    {
        return formatToString("RequestProgressEvent", "timestamp", "type", "sender", "message", "receivedItemsCount", "token");
    }
}
}