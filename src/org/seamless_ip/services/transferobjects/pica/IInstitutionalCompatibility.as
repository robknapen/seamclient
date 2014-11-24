/*
 * wallace: IInstitutionalCompatibility.as
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
package org.seamless_ip.services.transferobjects.pica {
import mx.collections.ArrayCollection;

import org.seamless_ip.services.transferobjects.pica.NaturalResourceFocus;
import org.seamless_ip.services.transferobjects.pica.PolicyType;
import org.seamless_ip.services.transferobjects.pica.PropertyRightsChanges;
import org.seamless_ip.services.transferobjects.seamproj.Project;
import org.seamless_ip.services.transferobjects.utils.IClonable;

[Bindable]
[RemoteClass(alias="org.seamless_ip.services.transferobjects.pica.IInstitutionalCompatibilityTO")]


public interface IInstitutionalCompatibility extends IClonable {
	//If the class is not is not auto-generated...please add the following method.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	function notOverwriteIInstitutionalCompatibility():int;
	
    function set weblink(value:String):void

    function get weblink():String;

    function set assessmentSummary(value:String):void

    function get assessmentSummary():String;

    function set pICASpatialLevels(value:ArrayCollection):void

    function get pICASpatialLevels():ArrayCollection;

    function set propertyRightsChange(value:PropertyRightsChanges):void

    function get propertyRightsChange():PropertyRightsChanges;

    function set institutionalCompatibilityIndicatorValues(value:ArrayCollection):void

    function get institutionalCompatibilityIndicatorValues():ArrayCollection;

    function set policyType(value:PolicyType):void

    function get policyType():PolicyType;

    function set pICACIAThemes(value:ArrayCollection):void

    function get pICACIAThemes():ArrayCollection;

    function set naturalResourceFocus(value:NaturalResourceFocus):void

    function get naturalResourceFocus():NaturalResourceFocus;

    function set project(value:Project):void

    function get project():Project;

    function set name(value:String):void

    function get name():String;

    function set id(value:String):void

    function get id():String;

    function set date(value:String):void

    function get date():String;

    function set description(value:String):void

    function get description():String;
}
}