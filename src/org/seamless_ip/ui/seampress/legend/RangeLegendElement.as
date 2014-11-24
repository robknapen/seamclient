/*
 * wallace: RangeLegendElement.as
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

/**
 * Legend element with lower and upper boundary value.
 *
 * @author Peter Verweij
 * @author Rob Knapen
 */
public class RangeLegendElement extends LegendElement
{
    private const PRECISION: uint = 2;
    private const SEPARATOR: String = ";"
    private const INCLUDE_MIN: String = "[";
    private const EXCLUDE_MIN: String = "<";
    private const INCLUDE_MAX: String = "]";
    private const EXCLUDE_MAX: String = ">";

    public var minValue: Number = 0;
    public var includeMinValue: Boolean = true;
    public var maxValue: Number = 0;
    public var includeMaxValue: Boolean = false;


    public function RangeLegendElement():void {
        formatter.precision = PRECISION;
        formatter.useThousandsSeparator = false;
        formatter.rounding = NumberBaseRoundType.NEAREST;
    }

    /**
     * accessor to caption
     */
    override public function get caption():String {
        var s:String = "";

        if (minValue.toFixed(PRECISION) == maxValue.toFixed(PRECISION))
            s += formatter.format(minValue);
        else {
            if (includeMinValue)
                s += INCLUDE_MIN;
            else
                s += EXCLUDE_MIN;

            s += formatter.format(minValue);
            s += SEPARATOR;
            s += formatter.format(maxValue);

            if (includeMaxValue)
                s += INCLUDE_MAX;
            else
                s += EXCLUDE_MAX;
        }

        return s;
    }


    public function includes(value: Number): Boolean
    {
        if ((value > minValue) && (value < maxValue))
            return true;

        if ((includeMinValue) && (minValue.toFixed(PRECISION) == value.toFixed(PRECISION)))
            return true;

        if ((includeMaxValue) && (maxValue.toFixed(PRECISION) == value.toFixed(PRECISION)))
            return true;

        return false
    }


    public function setRangeFromString(value: String): Boolean
    {
        var values: Array = value.split(SEPARATOR);

        if ((values.length == 1) && (!isNaN(parseFloat(value))))
        {
            minValue = parseFloat(value);
            includeMinValue = true;
            maxValue = minValue;
            includeMaxValue = true;
            return true;
        }

        if (values.length != 2)
            return false;

        // get min value
        var minString: String = values[0].toString();
        var minIn : Boolean = ((INCLUDE_MIN != null) && (INCLUDE_MIN.length >= 0) && (minString.indexOf(INCLUDE_MIN) >= 0));
        var minOut: Boolean = ((EXCLUDE_MIN != null) && (EXCLUDE_MIN.length >= 0) && (minString.indexOf(EXCLUDE_MIN) >= 0));
        if (minIn && minOut)
            return false;
        minString = minString.replace(INCLUDE_MIN, "");
        minString = minString.replace(EXCLUDE_MIN, "");
        var min: Number = parseFloat(minString);
        if (isNaN(min))
            return false;

        // get max value
        var maxString: String = values[1].toString();
        var maxIn : Boolean = ((INCLUDE_MAX != null) && (INCLUDE_MAX.length >= 0) && (maxString.indexOf(INCLUDE_MAX) >= 0));
        var maxOut: Boolean = ((EXCLUDE_MAX != null) && (EXCLUDE_MAX.length >= 0) && (maxString.indexOf(EXCLUDE_MAX) >= 0));
        if (maxIn && maxOut)
            return false;
        maxString = maxString.replace(INCLUDE_MAX, "");
        maxString = maxString.replace(EXCLUDE_MAX, "");
        var max: Number = parseFloat(maxString);
        if (isNaN(max))
            return false;

        // update properties
        minValue = min;
        includeMinValue = minIn;
        maxValue = max;
        includeMaxValue = maxIn;
        return true;
    }


    /**
     * get sample string representing a string
     *
     * use in conjunction with method 'setRangeFromString' to show example in user interface
     */
    public function sampleRangeString(): String
    {
        var r: RangeLegendElement = new RangeLegendElement();
        r.minValue = 1;
        r.maxValue = 7.3;
        return r.caption;
    }


    /**
     * assign properties based on xml
     */
    override public function assignFromXml(xml: XML): void
    {
        super.assignFromXml(xml);

        minValue = xml.minValue;
        includeMinValue = (xml.includeMinValue == "true");
        maxValue = xml.maxValue;
        includeMaxValue = (xml.includeMaxValue == "true");
    }


    /**
     * get xml representation of this object
     */
    override public function toXml(): XML
    {
        var xml: XML = super.toXml();

        var child:XML;
        child = <minValue>{minValue}</minValue>;
        xml.appendChild(child);

        child = <includeMinValue>{includeMinValue}</includeMinValue>;
        xml.appendChild(child);

        child = <maxValue>{maxValue}</maxValue>;
        xml.appendChild(child);

        child = <includeMaxValue>{includeMaxValue}</includeMaxValue>;
        xml.appendChild(child);

        return xml;
    }

}
}