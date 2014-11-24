/*
 * wallace: EndorsedIndicator.as
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

package org.seamless_ip.services.transferobjects.indi
{
import mx.collections.ArrayCollection;

import org.seamless_ip.services.transferobjects.seamproj.Model;
import org.seamless_ip.services.transferobjects.seamproj.SpatialScale;
import org.seamless_ip.services.transferobjects.seamproj.TemporalScale;

[Bindable]
[RemoteClass(alias="org.seamless_ip.services.transferobjects.indi.EndorsedIndicatorTO")]

public class EndorsedIndicator implements IIndicator
{
	//If the class is not is not auto-generated...please add the following method implementation.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	public function notOverwriteIIndicator():int{ return 1; }	
	
    public var id:String;
    public var label_en:String;
    public var description:String;
    public var modelOutputName:String;
    public var unit:String;
    public var temporalScale:TemporalScale = new TemporalScale();
    public var spatialScale:SpatialScale = new SpatialScale();
    public var model:Model = new Model();
    public var implemented:Boolean;

    // indicator group fields, read only
    public var groupId:String;
    public var groupLabel_en:String;
    public var groupDescription:String;
    public var groupFactsheet:String;
    public var groupDimensions:ArrayCollection = new ArrayCollection();
    public var groupDomains:ArrayCollection = new ArrayCollection();
    public var groupSubthemes:ArrayCollection = new ArrayCollection();

    // indicator value type, read only
    public var indicatorValueType:String;

    // transient properties
    public var selected:Boolean;
    public var hasValues:Boolean;


    public function getId():String {
        return id;
    }

    public function setId(value:String):void {
        id = value;
    }

    public function getLabel_en():String {
        return label_en;
    }

    public function setLabel_en(value:String):void {
        label_en = value;
    }

    public function getDescription():String {
        return description;
    }

    public function setDescription(value:String):void {
        description = value;
    }

    public function getModelOutputName():String {
        return modelOutputName;
    }

    public function setModelOutputName(value:String):void {
        modelOutputName = value;
    }

    public function getUnit():String {
        return unit;
    }

    public function setUnit(value:String):void {
        unit = value;
    }

    public function getTemporalScale():TemporalScale {
        return temporalScale;
    }

    public function setTemporalScale(value:TemporalScale):void {
        temporalScale = value;
    }

    public function getSpatialScale():SpatialScale {
        return spatialScale;
    }

    public function setSpatialScale(value:SpatialScale):void {
        spatialScale = value;
    }

    public function getModel():Model {
        return model;
    }

    public function setModel(value:Model):void {
        model = value;
    }

    public function getIndicatorValueType():String {
        return indicatorValueType;
    }

    public function setIndicatorValueType(value:String):void {
        indicatorValueType = value;
    }

    public function getSelected():Boolean {
        return selected;
    }

    public function setSelected(value:Boolean):void {
        selected = value;
    }

    public function getHasValues():Boolean {
        return hasValues;
    }

    public function setHasValues(value:Boolean):void {
        hasValues = value;
    }

    public function isImplemented():Boolean {
        return implemented;
    }

    public function isEndorsed():Boolean {
        return true;
    }
}
}
