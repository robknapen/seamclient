/*
 * wallace: PicaEvent.as
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

import org.seamless_ip.services.transferobjects.pica.InstitutionalCompatibility;
import org.seamless_ip.services.transferobjects.pica.PICASpatialLevel;

public class PicaEvent extends Event
{
    public static const INSTUTIONALCOMPATIBILITIES:String = "instutionalcompatibilities";

    public static const CREATEOKMSG:String = "createokmsg";
    public static const CHANGEVIEWINSTS:String = "changeviewinst";
    public static const SAVEINSTCOMP:String = "saveInstComp";
    public static const DELETEINST:String = "deleteInst";
    public static const UPDATEINST:String = "updateInst";
    public static const UPDATEALLINST:String = "updateAllInst";
    public static const CIAS:String = "cias";
    public static const NATURALRESOURCEFOCUS:String = "naturalresourcefocus";
    public static const PICAINDICATORGENERAL:String = "picaindicatorgeneral";
    public static const PROPERTYRIGHTSCHANGES:String = "propertyrightschanges";
    public static const POLICYTYPES:String = "policytypes";
    public static const GETALLPICASPATIALLEVEL:String = "getpicaspatiallevel";

    public static const SAVESPATIALSCALE:String = "savespatialscale";
    public static const NEWSPATIALSCALE:String = "newspatialscale";
    public static const INSTCOMPPICAINDICATORGENERAL:String = "instcomppicaindicatorgeneral";
    public static const UPDATEPICASPATIALLEVEL:String = "updatepicaspatiallevel";

    public function PicaEvent(type:String)
    {
        super(type, true, true);
    }

    public var institutionalCompatibility:InstitutionalCompatibility = null;
    public var picaspatiallevel:PICASpatialLevel = null;

    override public function clone():Event
    {
        return new PicaEvent(this.type);
    }

}
}