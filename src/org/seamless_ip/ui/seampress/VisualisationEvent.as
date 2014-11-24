/*
 * wallace: VisualisationEvent.as
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
package org.seamless_ip.ui.seampress
{
import flash.events.Event;

/**
 * Events used by the SEAMPRESS components.
 *
 * @author Rob Knapen
 */
public class VisualisationEvent extends Event
{
    public static const VISUALISATION_CREATE:String = "createVisualization";
    public static const VISUALISATION_EDITED:String = "editVisualization";
    public static const VISUALISATION_OPEN:String = "openVisualization";

    // deprecated (?):
    public static const VISUALISATION_CLOSED:String = "closeVisualization";
    public static const VISUALISATION_VIEWED:String = "viewVisualization";
    public static const VISUALISATION_SAVED:String = "saveVisualization";

    public var visualisation:Visualisation;


    public function VisualisationEvent(type:String, visualisation:Visualisation)
    {
        super(type, true, true);
        this.visualisation = visualisation;
    }


    override public function clone():Event
    {
        return new VisualisationEvent(super.type, visualisation);
    }
}
}