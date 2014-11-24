/*
 * wallace: IIndicator.as
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
import org.seamless_ip.services.transferobjects.seamproj.Model;
import org.seamless_ip.services.transferobjects.seamproj.SpatialScale;
import org.seamless_ip.services.transferobjects.seamproj.TemporalScale;

public interface IIndicator
{
	//If the class is not is not auto-generated...please add the following method.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	function notOverwriteIIndicator():int;
	
    function getId():String;

    function getLabel_en():String;

    function getDescription():String;

    function getModelOutputName():String;

    function getUnit():String;

    function getTemporalScale():TemporalScale;

    function getSpatialScale():SpatialScale;

    function getModel():Model;

    function getIndicatorValueType():String;

    // transient property, used in the GUI to track indicator selections
    function getSelected():Boolean;

    function setSelected(value:Boolean):void;

    // transient property, used in the GUI to track if indicator values are available
    function getHasValues():Boolean;

    function setHasValues(value:Boolean):void;

    // additional functions
    function isImplemented():Boolean;

    function isEndorsed():Boolean;
}
}
