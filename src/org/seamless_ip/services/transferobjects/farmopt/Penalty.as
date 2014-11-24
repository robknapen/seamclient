/*
 * wallace: Penalty.as
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
import org.seamless_ip.services.transferobjects.farmopt.IPolicyMeasure;
import org.seamless_ip.services.transferobjects.utils.IClonable;

[Bindable]
[RemoteClass(alias="org.seamless_ip.services.transferobjects.farmopt.PenaltyTO")]

public class Penalty implements IClonable, IPolicyMeasure    {
	//If the class is not is not auto-generated...please add the following method.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	public function notOverwriteIPolicyMeasure():int { return 1; }
	
    public function Penalty()
    {
    }


    public var nitrogenUse: Number;
    public var nitrogenUseOrganic: Number;
    public var NUTSRegion: NUTSregion;
    public var erosion: Number;
    public var pesticidePressure: Number;
    public var nitrateleaching: Number;
    public var irrigationWaterAvailability: Number;
    public var soilOrganicMatter: Number;
    public var penalty: Number;
    public var ruleLevel: Number;
    public var id: String;
    public var minimum: Boolean;


    public function Clone():IClonable
    {
        var clone: Penalty = new Penalty();
        var item:IClonable;
        clone.nitrogenUse = this.nitrogenUse;
        clone.nitrogenUseOrganic = this.nitrogenUseOrganic;
        clone.NUTSRegion = (NUTSregion)(this.NUTSRegion.Clone());
        clone.erosion = this.erosion;
        clone.pesticidePressure = this.pesticidePressure;
        clone.nitrateleaching = this.nitrateleaching;
        clone.irrigationWaterAvailability = this.irrigationWaterAvailability;
        clone.soilOrganicMatter = this.soilOrganicMatter;
        clone.penalty = this.penalty;
        clone.ruleLevel = this.ruleLevel;
        clone.id = this.id;
        clone.minimum = this.minimum;
        return clone;
    }
}


}
