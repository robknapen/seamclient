/*
 * wallace: PicaInstCompService.as
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
import org.seamless_ip.services.transferobjects.pica.InstitutionalCompatibility;
import org.seamless_ip.services.transferobjects.pica.PICAIndicatorValue;
import org.seamless_ip.services.transferobjects.pica.PICASpatialLevel;
import org.seamless_ip.services.transferobjects.pica.PICAassessment;
import org.seamless_ip.services.transferobjects.pica.PicaIndicator;
import org.seamless_ip.services.transferobjects.seamproj.User;

/**
 * Class to read, edit and delete pica data linked to a project.
 *
 * @author Benny Jonsson
 */
public class PicaInstCompService extends RemotingBaseServices
{
    private var _userId:User = null;
    private const _channelName:String = "picaService2";


    /**
     * Constructor
     *
     */
    public function PicaInstCompService(userId:User)
    {
        _userId = userId;
    }

    public function findAllByProjectID(id:String):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "findAllByProjectID", findAllByProjectIDHandler);
        var token:AsyncToken = ro.findAllByProjectID(id);
        token.id = id;
        dispatchRequestSendEvent(token, PicaInstCompEvent.GETINSTCOMP);
    }

    [Bindable]
    public var institutionalCompatibilities:ArrayCollection = null;

    public function findAllByProjectIDHandler(event:ResultEvent):void {
        if (event.result != null) {
            institutionalCompatibilities = (ArrayCollection)(event.result);
        }
        dispatchRequestCompletedEvent(null, 1, PicaInstCompEvent.GETINSTCOMPCOMPLETE);
        dispatchEvent(new PicaInstCompEvent(PicaInstCompEvent.GETINSTCOMPCOMPLETE));
    }

    // Delete
    private var _projectId:String = null;

    public function deleteInstComp(id:String, projectId:String):void {

        _projectId = projectId;

        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "deleteInstitutionalCompability", deleteHandler);

        var token:AsyncToken = ro.deleteInstitutionalCompability(id);
        token.id = id;
        dispatchRequestSendEvent(token, PicaInstCompEvent.DELETEINSTCOMP);
    }

    public function deleteHandler(event:ResultEvent):void {

        dispatchRequestCompletedEvent(null, 1, PicaInstCompEvent.DELETEINSTCOMPCOMPLETE);
        dispatchEvent(new PicaInstCompEvent(PicaInstCompEvent.DELETEINSTCOMPCOMPLETE));
        if (_projectId != null) {
            findAllByProjectID(_projectId);
            _projectId = null;
        }
    }

    // Find
    public function find(id:String) : void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "find", findHandler);

        var token:AsyncToken = ro.find(id);
        token.id = id;
        dispatchRequestSendEvent(token, PicaInstCompEvent.FINDINSTCOMP);
    }

    [Bindable]
    public var institutionalCompatibility:InstitutionalCompatibility = null;

    public function findHandler(event:ResultEvent):void {
        if (event.result != null) {
            institutionalCompatibility = (InstitutionalCompatibility)(event.result);
        }
        dispatchRequestCompletedEvent(null, 1, PicaInstCompEvent.FINDINSTCOMPCOMPLETE);
        dispatchEvent(new PicaInstCompEvent(PicaInstCompEvent.FINDINSTCOMPCOMPLETE));

    }

    // Update
    public function update(institutionalCompatibility:InstitutionalCompatibility):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "update", updateHandler);

        var token:AsyncToken = ro.update(institutionalCompatibility);
        token.id = "1";
        dispatchRequestSendEvent(token, PicaInstCompEvent.UPDATEINSTCOMP);
    }

    public function updateHandler(event:ResultEvent):void {
        var id:String = null;
        if (event.result != null) {
            id = (String)(event.result);
        }
        dispatchRequestCompletedEvent(null, 1, PicaInstCompEvent.UPDATEINSTCOMPCOMPLETE);
        dispatchEvent(new PicaInstCompEvent(PicaInstCompEvent.UPDATEINSTCOMPCOMPLETE));
    }

    // updatePICASpatialLevel
    public function updatePICASpatialLevel(spatialLevel:PICASpatialLevel) :void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "updatePICASpatialLevel", updatePICASpatialLevelHandler);

        var token:AsyncToken = ro.updatePICASpatialLevel(spatialLevel);
        token.id = "1";
        dispatchRequestSendEvent(token, PicaInstCompEvent.CREATEPICASPATIALLEVEL);
    }

    [Bindable]
    public var picaSpatialLevel:PICASpatialLevel = null;

    public function updatePICASpatialLevelHandler(event:ResultEvent):void {

        if (event.result != null) {
            picaSpatialLevel = (PICASpatialLevel)(event.result);
        }
        dispatchRequestCompletedEvent(null, 1, PicaInstCompEvent.CREATEPICASPATIALLEVELCOMPLETE);
        dispatchEvent(new PicaInstCompEvent(PicaInstCompEvent.CREATEPICASPATIALLEVELCOMPLETE));
    }

    public function deletePICASpatialLevel(spatialLevel:PICASpatialLevel) :void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "deletePICASpatialLevel", deletePICASpatialLevelHandler);

        var token:AsyncToken = ro.deletePICASpatialLevel(spatialLevel);
        token.id = "1";
        dispatchRequestSendEvent(token, PicaInstCompEvent.DELETEPICASPATIALLEVEL);
    }

    public function deletePICASpatialLevelHandler(event:ResultEvent):void {
        dispatchRequestCompletedEvent(null, 1, PicaInstCompEvent.DELETEPICASPATIALLEVELCOMPLETE);
        dispatchEvent(new PicaInstCompEvent(PicaInstCompEvent.DELETEPICASPATIALLEVELCOMPLETE));
    }

    // createPICASpatialLevel
    public function updatePICAassessment(picaAss:PICAassessment) :void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "updatePICAassessment", updatePICAassessmentHandler);

        var token:AsyncToken = ro.updatePICAassessment(picaAss);
        token.id = "1";
        dispatchRequestSendEvent(token, PicaInstCompEvent.UPDATEPICAASSESSMENT);
    }

    [Bindable]
    public var picaAssessment:PICAassessment = null;

    public function updatePICAassessmentHandler(event:ResultEvent):void {

        if (event.result != null) {
            picaAssessment = (PICAassessment)(event.result);
        }
        dispatchRequestCompletedEvent(null, 1, PicaInstCompEvent.UPDATEPICAASSESSMENTCOMPLETE);
        dispatchEvent(new PicaInstCompEvent(PicaInstCompEvent.UPDATEPICAASSESSMENTCOMPLETE));
    }

    //------------ PICA indicator Value

    public function getPicaIndicatorValues(picaIndicatorId:String):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "getPicaIndicatorValues", getPicaIndicatorValuesHandler);

        var token:AsyncToken = ro.getPicaIndicatorValues(picaIndicatorId);
        token.id = "1";
        dispatchRequestSendEvent(token, PicaInstCompEvent.GETPICAINDICATORVALUES);
    }

    [Bindable]
    public var picaIndicatorValues:ArrayCollection = null;

    public function getPicaIndicatorValuesHandler(event:ResultEvent):void {

        if (event.result != null) {
            picaIndicatorValues = (ArrayCollection)(event.result);
        }
        dispatchRequestCompletedEvent(null, 1, PicaInstCompEvent.GETPICAINDICATORVALUESCOMPLETE);
        dispatchEvent(new PicaInstCompEvent(PicaInstCompEvent.GETPICAINDICATORVALUESCOMPLETE));
    }

    public function updatePicaIndicatorValue(picaIndicatorValue:PICAIndicatorValue):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "updatePicaIndicatorValue", updatePicaIndicatorValueHandler);

        var token:AsyncToken = ro.updatePicaIndicatorValue(picaIndicatorValue);
        token.id = "1";
        dispatchRequestSendEvent(token, PicaNewIndicatorValueEvent.UPDATEPICAINDICATORVALUE);
    }

    public function updatePicaIndicatorValueHandler(event:ResultEvent):void {
        var pNIE:PicaNewIndicatorValueEvent =
                new PicaNewIndicatorValueEvent(PicaNewIndicatorValueEvent.UPDATEPICAINDICATORVALUECOMPLETE);
        if (event.result != null) {
            pNIE.picaIndicatorValue = (PICAIndicatorValue)(event.result);
        }
        dispatchRequestCompletedEvent(null, 1, PicaNewIndicatorValueEvent.UPDATEPICAINDICATORVALUECOMPLETE);
        dispatchEvent(pNIE);
    }

    public function updatePicaIndicatorValues(picaIndicatorValues:ArrayCollection, indicatorID:String):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "updatePicaIndicatorValues", updatePicaIndicatorValuesHandler);

        var token:AsyncToken = ro.updatePicaIndicatorValues(picaIndicatorValues, indicatorID);
        token.id = "1";
        dispatchRequestSendEvent(token, PicaInstCompEvent.UPDATEPICAINDICATORVALUES);
    }

    public function updatePicaIndicatorValuesHandler(event:ResultEvent):void {
        dispatchRequestCompletedEvent(null, 1, PicaInstCompEvent.UPDATEPICAINDICATORVALUESCOMPLETE);
        dispatchEvent(new PicaInstCompEvent(PicaInstCompEvent.UPDATEPICAINDICATORVALUESCOMPLETE));
    }

    // ------------------ Pica indicator

    public function updatePicaIndicator(picaIndicator:PicaIndicator):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "updatePicaIndicator", updatePicaIndicatorHandler);

        var token:AsyncToken = ro.updatePicaIndicator(picaIndicator);
        token.id = "1";
        dispatchRequestSendEvent(token, PicaInstCompEvent.UPDATEPICAINDICATOR);
    }

    [Bindable]
    public var picaIndicator:PicaIndicator = null;

    public function updatePicaIndicatorHandler(event:ResultEvent):void {

        if (event.result != null) {
            picaIndicator = (PicaIndicator)(event.result);
        }
        dispatchRequestCompletedEvent(null, 1, PicaInstCompEvent.UPDATEPICAINDICATORCOMPLETE);
        dispatchEvent(new PicaInstCompEvent(PicaInstCompEvent.UPDATEPICAINDICATORCOMPLETE));
    }

}
}
