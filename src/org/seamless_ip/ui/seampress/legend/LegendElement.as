/*
 * wallace: LegendElement.as
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
package org.seamless_ip.ui.seampress.legend
{
import mx.formatters.NumberBaseRoundType;
import mx.formatters.NumberFormatter;
import mx.utils.UIDUtil;

/**
 * Base class for legend items.
 *
 * @author Peter Verweij
 * @author Rob Knapen
 */
public class LegendElement
{
    private const TAGNAME: String = "legendElement";

    public var formatter:NumberFormatter = new NumberFormatter();
    public var id:String;
    private var _colour:Number;
    private var _caption:String = "Undefined";

    public function LegendElement():void {
        formatter.precision = 2;
        formatter.rounding = NumberBaseRoundType.NEAREST;
        id = UIDUtil.createUID();
        _colour = 0xaaaaaa;
    }

    [Bindable]
    public function get colour():Number {
        return _colour;
    }

    public function set colour(value:Number):void {
        _colour = value;
    }

    /**
     * accessor to caption
     * override this method in specialisations
     */
    [Bindable]
    public function get caption():String {
        return _caption;
    }


    public function set caption(caption:String):void {
        _caption = caption;
    }


    /**
     * assign properties based on xml
     *
     * override this methid in specialisations
     */
    public function assignFromXml(xml:XML):void {
        colour = xml.colour;
    }

    /**
     * get xml representation of this object
     *
     * override this method in specialisations
     */
    public function toXml():XML {
        var xml: XML =
                <{TAGNAME}>
                    <colour>{colour}</colour>
                </{TAGNAME}>;

        return xml;
    }
}
}