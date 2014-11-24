/*
 * wallace: PicaIndicator.as
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
import org.seamless_ip.services.transferobjects.pica.InstitutionalCompatibility;
import org.seamless_ip.services.transferobjects.pica.PICAIndicatorGeneral;
import org.seamless_ip.services.transferobjects.utils.IClonable;

[Bindable]
[RemoteClass(alias="org.seamless_ip.services.transferobjects.pica.PicaIndicatorTO")]


public class PicaIndicator implements IClonable {
	//If the class is not is not auto-generated...please add the following static field.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	public static var notOverwritePicaIndicator:int;
	
    public function PicaIndicator() {
    }

    public var dataSource:String;
    public var PICaIndicatorGeneral:PICAIndicatorGeneral;
    public var geographicalScope:String;
    public var specificLinkage:String;
    public var institutionalCompatibility:InstitutionalCompatibility;
    public var dataSourceSpecification:String;
    public var id:String;
    public var description:String;

    public function Clone():IClonable {
        var clone:PicaIndicator = new PicaIndicator();
        var item:IClonable;
        clone.dataSource = this.dataSource;
        clone.PICaIndicatorGeneral = (PICAIndicatorGeneral)(this.PICaIndicatorGeneral.Clone());
        clone.geographicalScope = this.geographicalScope;
        clone.specificLinkage = this.specificLinkage;
        clone.institutionalCompatibility = (InstitutionalCompatibility)(this.institutionalCompatibility.Clone());
        clone.dataSourceSpecification = this.dataSourceSpecification;
        clone.id = this.id;
        clone.description = this.description;
        return clone;
    }
}
}