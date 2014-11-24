/*
 * wallace: PicaMetaDataService.as
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

package org.seamless_ip.ui.pica
{
import mx.collections.ArrayCollection;
import mx.rpc.AsyncToken;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.RemoteObject;

import org.seamless_ip.services.remoting.RemotingBaseServices;
import org.seamless_ip.services.transferobjects.pica.CrucialInstitutionalAspect;
import org.seamless_ip.services.transferobjects.pica.NaturalResourceFocus;
import org.seamless_ip.services.transferobjects.pica.PICAIndicatorGeneral;
import org.seamless_ip.services.transferobjects.pica.PolicyType;
import org.seamless_ip.services.transferobjects.pica.PropertyRightsChanges;
import org.seamless_ip.services.transferobjects.seamproj.User;

/**
 * Class to read, edit and delete pica data linked to a project.
 *
 * @author Benny Jonsson
 */
public class PicaMetaDataService extends RemotingBaseServices
{
    private var _userId:User = null;

    private const _channelName:String = "picaService2";

    /**
     * Constructor
     *
     */
    public function PicaMetaDataService(userId:User)
    {
        _userId = userId;
    }

    public function getMetadata():void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "getMetadata", getMetadataHandler);
        var token:AsyncToken = ro.getMetadata();
        token.id = "1";
        dispatchRequestSendEvent(token, PicaMetaDataEvent.GETMETADATA);
    }

    [Bindable]
    public var crucialInstitutionalAspect:ArrayCollection = null;
    [Bindable]
    public var naturalResourceFocus:ArrayCollection = null;
    [Bindable]
    public var policyType:ArrayCollection = null;
    [Bindable]
    public var propertyRightsChanges:ArrayCollection = null;
    [Bindable]
    public var pICAIndicatorGeneral:ArrayCollection = null;

    [Bindable]
    public var defNaturalResourceFocus:NaturalResourceFocus = null;
    [Bindable]
    public var defPolicyType:PolicyType = null;
    [Bindable]
    public var defPropertyRightsChanges:PropertyRightsChanges = null;

    public function getMetadataHandler(event:ResultEvent):void {
        if (event.result != null) {
            for each (var o:Object in event.result) {
                if (o != null) {
                    if ((o as ArrayCollection)[0] is CrucialInstitutionalAspect) {
                        crucialInstitutionalAspect = (ArrayCollection)(o);

                    } else if ((o as ArrayCollection)[0] is NaturalResourceFocus) {
                        naturalResourceFocus = (ArrayCollection)(o);

                    } else if ((o as ArrayCollection)[0] is PolicyType) {
                        policyType = (ArrayCollection)(o);

                    } else if ((o as ArrayCollection)[0] is PropertyRightsChanges) {
                        propertyRightsChanges = (ArrayCollection)(o);

                    } else if ((o as ArrayCollection)[0] is PICAIndicatorGeneral) {
                        pICAIndicatorGeneral = (ArrayCollection)(o);
                    }
                }
            }
        }

        for each (var nat:NaturalResourceFocus in naturalResourceFocus) {
            if (nat.name.substr(0, 3) == "No ") {
                defNaturalResourceFocus = nat;
                break;
            }
        }

        for each (var pol:PolicyType in policyType) {
            if (pol.name.substr(0, 3) == "No ") {
                defPolicyType = pol;
                break;
            }
        }

        for each (var pro:PropertyRightsChanges in propertyRightsChanges) {
            if (pro.name.substr(0, 3) == "No ") {
                defPropertyRightsChanges = pro;
                break;
            }
        }


        dispatchRequestCompletedEvent(null, 1, PicaMetaDataEvent.GETMETADATACOMPLETE);
        dispatchEvent(new PicaMetaDataEvent(PicaMetaDataEvent.GETMETADATACOMPLETE));
    }
}
}