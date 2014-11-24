/*
 * wallace: PicaService.as
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
package org.seamless_ip.ui.pica {
import mx.collections.ArrayCollection;
import mx.rpc.AsyncToken;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.RemoteObject;

import org.seamless_ip.services.remoting.RemotingBaseServices;
import org.seamless_ip.services.transferobjects.pica.CrucialInstitutionalAspect;
import org.seamless_ip.services.transferobjects.pica.InstitutionalCompatibility;
import org.seamless_ip.services.transferobjects.pica.NaturalResourceFocus;
import org.seamless_ip.services.transferobjects.pica.PICAIndicatorGeneral;
import org.seamless_ip.services.transferobjects.pica.PICASpatialLevel;
import org.seamless_ip.services.transferobjects.pica.PolicyType;
import org.seamless_ip.services.transferobjects.pica.PropertyRightsChanges;
import org.seamless_ip.services.transferobjects.seamproj.User;

/**
 * Class to read, edit and delete pica data linked to a project.
 *
 * @author Benny Jonsson
 */
public class PicaService extends RemotingBaseServices {
    private var _userId:User = null;
    private const _channelName:String = "picaService";
    private const _update:String = "update";
    private const _updateall:String = "updateAll";
    private const _findAllByProjectID:String = "findAllByProjectID";
    private const _create:String = "create";
    private const _createpicaspatiallevel:String = "createPICASpatialLevel";
    private const _getcipicaindicatorgeneral:String = "getCIPICAIndicatorGeneral";
    private const _updatepicaspatiallevels:String = "updatePICASpatialLevels";
    private const _remove:String = "remove";
    private const _getallcias:String = "getAllCIAs";
    private const _getallnaturalresourcefocus:String = "getAllNaturalResourceFocus";
    private const _getallpicaindicatorgeneral:String = "getAllPICAIndicatorGeneral";
    private const _getallpropertyrightschanges:String = "getAllPropertyRightsChanges";
    private const _getallpicaspatiallevel:String = "getAllPICASpatialLevel";
    private const _deletePICASpatialLevel:String = "deletePICASpatialLevel";
    private const _getallpolicytype:String = "getAllPolicyType";
    private const _getCIPICAIndicatorGeneral:String = "getCIPICAIndicatorGeneral";
    public static var FINDBYNAMEMSG:String = "loding pica data";
    public static var CREATEMSG:String = "creating pica instance";
    public static var CREATESPATIALLEVELMSG:String = "creating picaSpatialLevel instance";
    public static var RETPICADATA:String = "retriving pica data...";
    public static var FINDBYNAMEOKMSG:String = "pica data received";
    public static var CREATEOKMSG:String = "pica instance created";
    public static var UPDATEMSG:String = "Transfering PICA data";
    public static var UPDATEOKMSG:String = "pica data updated";
    public static var RETRIVEOKMSG:String = "pica data retrieved";

    /**
     * Constructor
     *
     */
    public function PicaService(userId:User) {
        _userId = userId;
    }

    /**
     * Removes a InstitutionalCompatibility
     * @param id of the InstitutionalCompatibility to remove
     *
     */
    public function remove(id:Number):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _remove, removeHandler);
        var token:AsyncToken = ro.remove(_userId.id, id);
        token.id = id;
        dispatchRequestSendEvent(token, CREATEMSG);
    }

    /**
     * Remove handler
     * @param event
     *
     */
    public function removeHandler(event:ResultEvent):void {
        if (event.result != null) {
        }
        dispatchRequestCompletedEvent(null, 1, PicaEvent.DELETEINST);
        // Send pica event (listen to this to get the result)
        dispatchEvent(new PicaEvent(PicaEvent.DELETEINST));
    }

    /**
     * Creates a new InstitutionalCompatibility
     * @param projectId Id of the owner project
     *
     */
    public function create(projectId:Number):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _create, createHandler);
        var token:AsyncToken = ro.create(_userId.id, projectId);
        token.id = projectId;
        dispatchRequestSendEvent(token, CREATEMSG);
    }

    /**
     * Create handler
     * @param event
     *
     */
    public function createHandler(event:ResultEvent):void {
        if (event.result != null) {
            newInst = (InstitutionalCompatibility)(event.result);
        }
        dispatchRequestCompletedEvent(null, 1, CREATEOKMSG);
        // Send pica event (listen to this to get the result)
        dispatchEvent(new PicaEvent(PicaEvent.CREATEOKMSG));
    }

    [Bindable]
    public var newInst:InstitutionalCompatibility = null;

    /**
     *
     * @param projectId
     *
     */
    public function findAllByProjectID(projectId:Number):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _findAllByProjectID, findByIdResultHandler);
        var token:AsyncToken = ro.findAllByProjectID(_userId.id, projectId);
        token.id = projectId;
        dispatchRequestSendEvent(token, FINDBYNAMEMSG);
    }

    /**
     * findById handler
     * @param event
     *
     */
    public function findByIdResultHandler(event:ResultEvent):void {
        instutionalcompatibilities.removeAll();
        if (event.result != null) {
            for each (var inst:InstitutionalCompatibility in event.result) {
                instutionalcompatibilities.addItem(inst);
            }
        }
        dispatchRequestCompletedEvent(null, 1, FINDBYNAMEOKMSG);
        // Send pica event (listen to this to get the result)
        dispatchEvent(new PicaEvent(PicaEvent.INSTUTIONALCOMPATIBILITIES));
    }

    [Bindable]
    public function get instutionalcompatibilities():ArrayCollection {
        return _items;
    }

    public function set instutionalcompatibilities(value:ArrayCollection):void {
        _items = value
    }

    /**
     *
     * @param instutionalcompatibilities
     *
     */
    public function update(instutionalcompatibility:InstitutionalCompatibility):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _update, updateResultHandler);
        var token:AsyncToken = ro.update(_userId.id, instutionalcompatibility, null);
        token.id = instutionalcompatibility.id;
        dispatchRequestSendEvent(token, UPDATEMSG);
    }

    /**
     * update Result Handler
     * @param event
     *
     */
    public function updateResultHandler(event:ResultEvent):void {
        updatedInst = (InstitutionalCompatibility)(event.result);
        dispatchRequestCompletedEvent(null, 1, UPDATEOKMSG);
        // Send pica event (listen to this to get the result)
        dispatchEvent(new PicaEvent(PicaEvent.UPDATEINST));
    }

    [Bindable]
    public var updatedInst:InstitutionalCompatibility = null;

    /**
     *
     * @param instutionalcompatibilities
     *
     */
    public function updateAll(instutionalcompatibility:ArrayCollection):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _updateall, updateAllResultHandler);
        var token:AsyncToken = ro.updateAll(_userId.id, instutionalcompatibilities, null);
        token.id = instutionalcompatibility.length;
        dispatchRequestSendEvent(token, UPDATEMSG);
    }

    /**
     * update Result Handler
     * @param event
     *
     */
    public function updateAllResultHandler(event:ResultEvent):void {
        findByIdResultHandler(event);
        dispatchEvent(new PicaEvent(PicaEvent.UPDATEALLINST));
    }

    // ----------------------------------------------------------------------------
    // CIAs
    // ----------------------------------------------------------------------------
    [Bindable]
    public var cIAS:ArrayCollection = new ArrayCollection();

    /**
     *
     *
     */
    public function getAllCIAs():void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _getallcias, getAllCIAsHandler);
        var token:AsyncToken = ro.getAllCIAs(_userId.id);
        token.id = "1";
        dispatchRequestSendEvent(token, UPDATEMSG);
    }

    /**
     *
     * @param event
     *
     */
    public function getAllCIAsHandler(event:ResultEvent):void {
        cIAS.removeAll();
        if (event.result != null) {
            for each (var inst:CrucialInstitutionalAspect in event.result) {
                cIAS.addItem(inst);
            }
        }
        dispatchRequestCompletedEvent(null, 1, RETRIVEOKMSG);
        // Send pica event (listen to this to get the result)
        dispatchEvent(new PicaEvent(PicaEvent.CIAS));
    }

    // ----------------------------------------------------------------------------
    // NaturalResourceFocus
    // ----------------------------------------------------------------------------
    [Bindable]
    public var naturalResourceFocus:ArrayCollection = new ArrayCollection();

    /**
     *
     *
     */
    public function getAllNaturalResourceFocus():void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _getallnaturalresourcefocus, getAllNaturalResourceFocusHandler);
        var token:AsyncToken = ro.getAllNaturalResourceFocus(_userId.id);
        token.id = "1";
        dispatchRequestSendEvent(token, UPDATEMSG);
    }

    /**
     *
     * @param event
     *
     */
    public function getAllNaturalResourceFocusHandler(event:ResultEvent):void {
        naturalResourceFocus.removeAll();
        if (event.result != null) {
            for each (var inst:NaturalResourceFocus in event.result) {
                naturalResourceFocus.addItem(inst);
            }
        }
        dispatchRequestCompletedEvent(null, 1, RETRIVEOKMSG);
        // Send pica event (listen to this to get the result)
        dispatchEvent(new PicaEvent(PicaEvent.NATURALRESOURCEFOCUS));
    }

    // ----------------------------------------------------------------------------
    // PICAIndicatorGeneral
    // ----------------------------------------------------------------------------
    [Bindable]
    public var pICAIndicatorGeneral:ArrayCollection = new ArrayCollection();

    /**
     *
     *
     */
    public function getAllPICAIndicatorGeneral():void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _getallpicaindicatorgeneral, getAllPICAIndicatorGeneralHandler);
        var token:AsyncToken = ro.getAllPICAIndicatorGeneral(_userId.id);
        token.id = "1";
        dispatchRequestSendEvent(token, UPDATEMSG);
    }

    /**
     *
     * @param event
     *
     */
    public function getAllPICAIndicatorGeneralHandler(event:ResultEvent):void {
        pICAIndicatorGeneral.removeAll();
        if (event.result != null) {
            for each (var inst:PICAIndicatorGeneral in event.result) {
                pICAIndicatorGeneral.addItem(inst);
            }
        }
        dispatchRequestCompletedEvent(null, 1, RETRIVEOKMSG);
        // Send pica event (listen to this to get the result)
        dispatchEvent(new PicaEvent(PicaEvent.PICAINDICATORGENERAL));
    }

    // ----------------------------------------------------------------------------
    // PropertyRightsChanges
    // ----------------------------------------------------------------------------
    [Bindable]
    public var propertyRightsChanges:ArrayCollection = new ArrayCollection();

    /**
     *
     *
     */
    public function getAllPropertyRightsChanges():void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _getallpropertyrightschanges, getAllPropertyRightsChangesHandler);
        var token:AsyncToken = ro.getAllPropertyRightsChanges(_userId.id);
        token.id = "1";
        dispatchRequestSendEvent(token, UPDATEMSG);
    }

    /**
     *
     * @param event
     *
     */
    public function getAllPropertyRightsChangesHandler(event:ResultEvent):void {
        propertyRightsChanges.removeAll();
        if (event.result != null) {
            for each (var inst:PropertyRightsChanges in event.result) {
                propertyRightsChanges.addItem(inst);
            }
        }
        dispatchRequestCompletedEvent(null, 1, RETRIVEOKMSG);
        // Send pica event (listen to this to get the result)
        dispatchEvent(new PicaEvent(PicaEvent.PROPERTYRIGHTSCHANGES));
    }

    // ----------------------------------------------------------------------------
    // PolicyTypes
    // ----------------------------------------------------------------------------
    [Bindable]
    public var policyTypes:ArrayCollection = new ArrayCollection();

    /**
     *
     *
     */
    public function getAllPolicyType():void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _getallpolicytype, getAllPolicyTypeHandler);
        var token:AsyncToken = ro.getAllPolicyType(_userId.id);
        token.id = "1";
        dispatchRequestSendEvent(token, UPDATEMSG);
    }

    /**
     *
     * @param event
     *
     */
    public function getAllPolicyTypeHandler(event:ResultEvent):void {
        policyTypes.removeAll();
        if (event.result != null) {
            for each (var inst:PolicyType in event.result) {
                policyTypes.addItem(inst);
            }
        }
        dispatchRequestCompletedEvent(null, 1, RETRIVEOKMSG);
        // Send pica event (listen to this to get the result)
        dispatchEvent(new PicaEvent(PicaEvent.POLICYTYPES));
    }

    // ----------------------------------------------------------------------------
    // CIPICAIndicatorGeneral
    // ----------------------------------------------------------------------------
    public function getCIPICAIndicatorGeneral(institutionalCompatibilityId:Number):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _getcipicaindicatorgeneral, getCIPICAIndicatorGeneralHandler);
        var token:AsyncToken = ro.getCIPICAIndicatorGeneral(_userId.id, institutionalCompatibilityId);
        token.id = institutionalCompatibilityId;
        dispatchRequestSendEvent(token, RETPICADATA);
    }

    [Bindable]
    public var instCompPICAIndicatorGeneral:ArrayCollection = new ArrayCollection();

    public function getCIPICAIndicatorGeneralHandler(event:ResultEvent):void {
        instCompPICAIndicatorGeneral.removeAll();
        if (event.result != null) {
            for each (var pIG:PICAIndicatorGeneral in event.result) {
                instCompPICAIndicatorGeneral.addItem(pIG);
            }
        }
        dispatchRequestCompletedEvent(null, 1, RETPICADATA);
        dispatchEvent(new PicaEvent(PicaEvent.INSTCOMPPICAINDICATORGENERAL));
    }

    // ----------------------------------------------------------------------------
    // PICASpatialLevels
    // ----------------------------------------------------------------------------
    [Bindable]
    public var newPicaSpatialLevel:PICASpatialLevel = null;

    /**
     * Creates a new pica spatial level
     * PicaEvent.NEWSPATIALSCALE is fired when results are in newPicaSpatialLevel
     * @param institutionalCompatibilityId
     *
     */
    public function createPICASpatialLevel(institutionalCompatibilityId:Number):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _createpicaspatiallevel, createPicaSpatialLevelHandler);
        var token:AsyncToken = ro.createPICASpatialLevel(_userId.id, institutionalCompatibilityId);
        token.id = institutionalCompatibilityId;
        dispatchRequestSendEvent(token, CREATESPATIALLEVELMSG);
    }

    /**
     * createPicaSpatialLevel Handler "called from serverside"
     * @param event
     *
     */
    public function createPicaSpatialLevelHandler(event:ResultEvent):void {
        if (event.result != null) {
            newPicaSpatialLevel = event.result as PICASpatialLevel
        }
        dispatchRequestCompletedEvent(null, 1, CREATESPATIALLEVELMSG);
        dispatchEvent(new PicaEvent(PicaEvent.NEWSPATIALSCALE));
    }

    /**
     * Update PICASpatialLevels
     * @param userID
     * @param pICASpatialLevel
     *
     */
    public function updatePICASpatialLevels(pICASpatialLevel:PICASpatialLevel):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _updatepicaspatiallevels, updatePICASpatialLevelsHandler);
        var token:AsyncToken = ro.updatePICASpatialLevels(_userId.id, pICASpatialLevel);
        token.id = pICASpatialLevel.id;
        dispatchRequestSendEvent(token, RETPICADATA);
    }

    public function updatePICASpatialLevelsHandler(event:ResultEvent):void {
        dispatchRequestCompletedEvent(null, 1, RETPICADATA);
        dispatchEvent(new PicaEvent(PicaEvent.UPDATEPICASPATIALLEVEL));
    }

    [Bindable]
    public var pICASpatialLevel:ArrayCollection = new ArrayCollection();

    /**
     * Return all PICA Spatial Levels
     * PicaEvent.GETALLPICASPATIALLEVEL is fired when results are in pICASpatialLevel
     * @param instId
     *
     */
    public function getAllPICASpatialLevel(instId:int):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _getallpicaspatiallevel, getAllPICASpatialLevelHandler);
        var token:AsyncToken = ro.getAllPICASpatialLevel(_userId.id, instId);
        token.id = "1";
        dispatchRequestSendEvent(token, UPDATEMSG);
    }

    /**
     * getAllPICASpatialLevel Handler "called from serverside"
     * @param event
     *
     */
    public function getAllPICASpatialLevelHandler(event:ResultEvent):void {
        pICASpatialLevel.removeAll();
        if (event.result != null) {
            for each (var inst:PICASpatialLevel in event.result) {
                pICASpatialLevel.addItem(inst);
            }
        }
        dispatchRequestCompletedEvent(null, 1, RETRIVEOKMSG);
        // Send pica event (listen to this to get the result)
        dispatchEvent(new PicaEvent(PicaEvent.GETALLPICASPATIALLEVEL));
    }

    public function deletePICASpatialLevel(pICASpatialLevelid:int):void {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, _deletePICASpatialLevel, deletePICASpatialLevelHandler);
        var token:AsyncToken = ro.deletePICASpatialLevel(_userId.id, pICASpatialLevelid);
        token.id = pICASpatialLevelid;
        dispatchRequestSendEvent(token, UPDATEMSG);
    }

    public function deletePICASpatialLevelHandler(event:ResultEvent):void {
        dispatchRequestCompletedEvent(null, 1, RETRIVEOKMSG);
    }
}
}