/*
 * wallace: PicaInstCompEvent.as
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

package org.seamless_ip.ui.pica
{
import flash.events.Event;

public class PicaInstCompEvent extends Event
{
    public static const GETINSTCOMP:String = "getinstcomp";
    public static const GETINSTCOMPCOMPLETE:String = "getinstcompcomplete";

    public static const DELETEINSTCOMP:String = "deleteinstcomp";
    public static const DELETEINSTCOMPCOMPLETE:String = "deleteinstcompcomplete";

    public static const FINDINSTCOMP:String = "findinstcomp";
    public static const FINDINSTCOMPCOMPLETE:String = "findinstcompcomplete";

    public static const UPDATEINSTCOMP:String = "updateinstcomp";

    public static const UPDATEINSTCOMPCOMPLETE:String = "updateinstcompcomplete";
    public static const FORCEREFRESH:String = "forcerefresh";


    public static const CREATEPICASPATIALLEVEL:String = "createpicaspatiallevel";
    public static const CREATEPICASPATIALLEVELCOMPLETE:String = "createpicaspatiallevelcomplete";

    public static const DELETEPICASPATIALLEVEL:String = "deletepicaspatiallevel";
    public static const DELETEPICASPATIALLEVELCOMPLETE:String = "deletepicaspatiallevelcomplete";

    public static const UPDATEPICAASSESSMENT:String = "updatepicaassessment";
    public static const UPDATEPICAASSESSMENTCOMPLETE:String = "updatepicaassessmentcomplete";


    public static const GETPICAINDICATORVALUES:String = "getpicaindicatorvalues";
    public static const GETPICAINDICATORVALUESCOMPLETE:String = "getpicaindicatorvaluescomplete";


    public static const UPDATEPICAINDICATOR:String = "updatepicaindicator";
    public static const UPDATEPICAINDICATORCOMPLETE:String = "updatepicaindicatorcomplete";

    public static const UPDATEPICAINDICATORVALUES:String = "updatepicaindicatorvalues";
    public static const UPDATEPICAINDICATORVALUESCOMPLETE:String = "updatepicaindicatorvaluescomplete";

    public function PicaInstCompEvent(type:String)
    {
        super(type, true, true);
    }

    override public function clone():Event
    {
        return new PicaInstCompEvent(this.type);
    }

}
}