/*
 * wallace: IPolicyMeasure.as
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

package org.seamless_ip.services.transferobjects.farmopt
{
import org.seamless_ip.services.transferobjects.farm.NUTSregion;
import org.seamless_ip.services.transferobjects.utils.IClonable;

[Bindable]
[RemoteClass(alias="org.seamless_ip.services.transferobjects.farmopt.IPolicyMeasureTO")]

public interface IPolicyMeasure extends IClonable    {
	//If the class is not is not auto-generated...please add the following method.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	function notOverwriteIPolicyMeasure():int;



    function set nitrogenUse(value: Number):void

    function get nitrogenUse(): Number;

    function set nitrogenUseOrganic(value: Number):void

    function get nitrogenUseOrganic(): Number;

    function set NUTSRegion(value: NUTSregion):void

    function get NUTSRegion(): NUTSregion;

    function set erosion(value: Number):void

    function get erosion(): Number;

    function set pesticidePressure(value: Number):void

    function get pesticidePressure(): Number;

    function set nitrateleaching(value: Number):void

    function get nitrateleaching(): Number;

    function set irrigationWaterAvailability(value: Number):void

    function get irrigationWaterAvailability(): Number;

    function set soilOrganicMatter(value: Number):void

    function get soilOrganicMatter(): Number;

    function set id(value: String):void

    function get id(): String;

    function set minimum(value: Boolean):void

    function get minimum(): Boolean;


}


}
