/*
 * wallace: OpenRequestsEvent.as
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

public class OpenRequestsEvent extends Event
{
    private var _openRequests:int = 0;
    public static const OPENREQUEST_SEND:String = "openRequestSend";

    public function OpenRequestsEvent(openRequests:int)
    {
        _openRequests = openRequests;
        super(OPENREQUEST_SEND, true, true);
    }

    public function get requests():int {
        return _openRequests;
    }

    /**
     * Creates and returns a copy of the current instance.
     *
     * @return A copy of the current instance.
     */
    override public function clone():Event
    {
        var evt:OpenRequestsEvent = new OpenRequestsEvent(_openRequests);
        return evt;
    }
}
}