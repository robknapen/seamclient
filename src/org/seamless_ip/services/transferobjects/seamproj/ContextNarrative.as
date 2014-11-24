/*
 * wallace: ContextNarrative.as
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

package org.seamless_ip.services.transferobjects.seamproj
{
import org.seamless_ip.services.transferobjects.seamproj.Narrative;
import org.seamless_ip.services.transferobjects.utils.IClonable;

[Bindable]
[RemoteClass(alias="org.seamless_ip.services.transferobjects.seamproj.ContextNarrativeTO")]

public class ContextNarrative implements IClonable {
	//If the class is not is not auto-generated...please add the following static field.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	public static var notOverwriteContextNarrative:int;

    public function ContextNarrative()
    {
        selected = false;
    }


    public var narrative: Narrative;
    public var theexperimentowner_isbaseline: Boolean;
    public var theprojectowner_id: Number;
    public var theprojectowner_title: String;
    public var id: String;
    public var selected: Boolean;


    public function Clone():IClonable
    {
        var clone: ContextNarrative = new ContextNarrative();
        var item:IClonable;
        clone.narrative = (Narrative)(this.narrative.Clone());
        clone.theexperimentowner_isbaseline = this.theexperimentowner_isbaseline;
        clone.theprojectowner_id = this.theprojectowner_id;
        clone.theprojectowner_title = this.theprojectowner_title;
        clone.id = this.id;
        return clone;
    }
}


}
