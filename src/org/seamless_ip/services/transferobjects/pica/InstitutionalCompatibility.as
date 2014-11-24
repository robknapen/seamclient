/*
 * wallace: InstitutionalCompatibility.as
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
[RemoteClass(alias="org.seamless_ip.services.transferobjects.pica.InstitutionalCompatibilityTO")]


public class InstitutionalCompatibility implements IClonable {

	//If the class is not is not auto-generated...please add the following static field.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	public static var notOverwriteInstitutionalCompatibility:int;
	
    public function InstitutionalCompatibility() {
        PICASpatialLevels = new ArrayCollection();
        institutionalCompatibilityIndicatorValues = new ArrayCollection();
        PICACIAThemes = new ArrayCollection();
    }

    public var weblink:String;
    public var assessmentSummary:String;
    public var PICASpatialLevels:ArrayCollection;
    public var propertyRightsChange:PropertyRightsChanges;
    public var institutionalCompatibilityIndicatorValues:ArrayCollection;
    public var policyType:PolicyType;
    public var PICACIAThemes:ArrayCollection;
    public var naturalResourceFocus:NaturalResourceFocus;
    public var project:Project;
    public var name:String;
    public var id:String;
    public var date:String;
    public var description:String;

    public function Clone():IClonable {
        var clone:InstitutionalCompatibility = new InstitutionalCompatibility();
        var item:IClonable;
        clone.weblink = this.weblink;
        clone.assessmentSummary = this.assessmentSummary;
        for each (item in this.PICASpatialLevels)
            clone.PICASpatialLevels.addItem(item.Clone());
        clone.propertyRightsChange = (PropertyRightsChanges)(this.propertyRightsChange.Clone());
        for each (item in this.institutionalCompatibilityIndicatorValues)
            clone.institutionalCompatibilityIndicatorValues.addItem(item.Clone());
        clone.policyType = (PolicyType)(this.policyType.Clone());
        for each (item in this.PICACIAThemes)
            clone.PICACIAThemes.addItem(item.Clone());
        clone.naturalResourceFocus = (NaturalResourceFocus)(this.naturalResourceFocus.Clone());
        clone.project = (Project)(this.project.Clone());
        clone.name = this.name;
        clone.id = this.id;
        clone.date = this.date;
        clone.description = this.description;
        return clone;
    }
}
}