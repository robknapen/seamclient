/*
 * wallace: ContextService.as
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

package org.seamless_ip.ui.experimentdesigner
{
import mx.collections.ArrayCollection;
import mx.rpc.AsyncToken;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.RemoteObject;

import org.seamless_ip.services.remoting.RemotingBaseServices;
import org.seamless_ip.services.transferobjects.seamproj.Context;

public class ContextService extends RemotingBaseServices
{
    private const _channelName:String = "contextService";
    private const _update:String = "update";
    private const _findById:String = "findById";

    public static var FINDBYNAMEMSG: String = "loding conext data";
    public static var FINDBYNAMEOKMSG: String = "conext data received";

    public static var UPDATEMSG: String = "updating conext data";
    public static var UPDATEOKMSG: String = "conext data updated";


    public function ContextService()
    {
    }

    public function findById(experimentid:Number):void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _findById, findByIdResultHandler);
        var token:AsyncToken = ro.findById(experimentid);
        token.id = experimentid;
        dispatchRequestSendEvent(token, FINDBYNAMEMSG);
    }

    public function findByIdResultHandler(event:ResultEvent):void
    {
        contexts.removeAll();
        if (event.result != null)
        {
            contexts.addItem((Context)(event.result));
        }
        dispatchRequestCompletedEvent(null, 1, FINDBYNAMEOKMSG);
    }

    public function update(context:Context):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _update, updateResultHandler);
        var token:AsyncToken = ro.update(context, null);
        token.id = context.id;
        dispatchRequestSendEvent(token, UPDATEMSG);
    }

    public function updateResultHandler(event:ResultEvent):void
    {
        var item:Context = (Context)(event.result);
        dispatchRequestCompletedEvent(null, 1, UPDATEOKMSG);
    }

    [Bindable]
    public function get contexts():ArrayCollection
    {
        return _items;
    }

    public function set contexts(value: ArrayCollection):void
    {
        _items = value
    }
}
}