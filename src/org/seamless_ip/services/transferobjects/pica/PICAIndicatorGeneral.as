/*
 * wallace: PICAIndicatorGeneral.as
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

import org.seamless_ip.services.transferobjects.pica.CrucialInstitutionalAspect;
import org.seamless_ip.services.transferobjects.utils.IClonable;

[Bindable]
[RemoteClass(alias="org.seamless_ip.services.transferobjects.pica.PICAIndicatorGeneralTO")]


public class PICAIndicatorGeneral implements IClonable {

	//If the class is not is not auto-generated...please add the following static field.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	public static var notOverwritePICAIndicatorGeneral:int;
	
    public function PICAIndicatorGeneral() {
        linkageCrucialInstitutionalAspects = new ArrayCollection();
    }

    public var unit:String;
    public var weblink:String;
    public var mainCrucialInstitutionalAspect:CrucialInstitutionalAspect;
    public var generalLinkage:String;
    public var linkageCrucialInstitutionalAspects:ArrayCollection;
    public var name:String;
    public var id:String;
    public var description:String;
    public var selected:Boolean = false;

    public function Clone():IClonable {
        var clone:PICAIndicatorGeneral = new PICAIndicatorGeneral();
        var item:IClonable;
        clone.unit = this.unit;
        clone.weblink = this.weblink;
        clone.mainCrucialInstitutionalAspect = (CrucialInstitutionalAspect)(this.mainCrucialInstitutionalAspect.Clone());
        clone.generalLinkage = this.generalLinkage;
        for each (item in this.linkageCrucialInstitutionalAspects)
            clone.linkageCrucialInstitutionalAspects.addItem(item.Clone());
        clone.name = this.name;
        clone.id = this.id;
        clone.description = this.description;
        return clone;
    }
}
}