/*
 * wallace: PolicyService.as
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
import org.seamless_ip.services.transferobjects.farm.NUTSregion;
import org.seamless_ip.services.transferobjects.seamproj.PolicyOption;

public class PolicyService  extends RemotingBaseServices
{
    private const _channelName:String = "policyOptionService";

    private const _update:String = "updatePolicyOption";
    private const _findById:String = "findById";
    private const _getAllNutsRegions:String = "getAllNutsRegions";

    public static var NUTSREGIONMSG: String = "getting nuts regions";
    public static var NUTSREGIONOKMSG: String = "nuts regions data received";

    public static const REQUEST_NUTS_REGION_SEND:String = "requestNutsSend";
    public static const REQUEST_NUTS_REGION_COMPLETED:String = "requestNutsCompleted";

    public static var FINDBYNAMEMSG: String = "loding policy data";
    public static var FINDBYNAMEOKMSG: String = "policy data received";

    public static var UPDATEMSG: String = "updating policy data";
    public static var UPDATEOKMSG: String = "policy data updated";


    public function PolicyService()
    {
    }

    public function getAllNutsRegions():void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _getAllNutsRegions, nutsResultHandler);
        var token:AsyncToken = ro.getAllNutsRegions();
        token.id = 0;
        dispatchRequestSendEvent(token, REQUEST_NUTS_REGION_SEND);
    }

    public function nutsResultHandler(event:ResultEvent):void
    {
        nutsRegions.removeAll();
        if (event.result != null)
        {
            for each (var nutsR:NUTSregion in (event.result)) {
                nutsRegions.addItem(nutsR);
            }
        }
        dispatchRequestCompletedEvent(null, 1, REQUEST_NUTS_REGION_COMPLETED);
    }

    private var _nuts:ArrayCollection = new ArrayCollection();

    [Bindable]
    public function get nutsRegions(): ArrayCollection
    {
        return _nuts;
    }

    private function set nutsRegions(nuts: ArrayCollection):void {
        _nuts = nuts;
    }

    public function updatePolicyOption(policyOption:PolicyOption):void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _update, updatePolicyOptionResultHandler);
        var token:AsyncToken = ro.updatePolicyOption(policyOption);
        token.id = policyOption.id;
        dispatchRequestSendEvent(token, UPDATEMSG);
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
        policyOptions.removeAll();
        if (event.result != null)
        {
            policyOptions.addItem((PolicyOption)(event.result));
        }
        dispatchRequestCompletedEvent(null, 1, FINDBYNAMEOKMSG);
    }

    public function updatePolicyOptionResultHandler(event:ResultEvent):void
    {
        var item:PolicyOption = (PolicyOption)(event.result);
        dispatchRequestCompletedEvent(null, 1, UPDATEOKMSG);
    }

    [Bindable]
    public function get policyOptions():ArrayCollection
    {
        return _items;
    }

    public function set policyOptions(value: ArrayCollection):void
    {
        _items = value
    }
}
}