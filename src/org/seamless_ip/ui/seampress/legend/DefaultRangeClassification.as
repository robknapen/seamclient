/*
 * wallace: DefaultRangeClassification.as
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
/**
 * Creates a default range classification.
 *
 * @author Peter Verweij
 * @author Rob Knapen
 */
public class DefaultRangeClassification extends RangeClassification
{
    private const COLOUR_RAMP: Array = [0xFEA8A8, 0xFED1A8, 0xFEF3A8, 0xE3FEA8, 0xACFEA8, 0xA8FEA8, 0xA8D7FE];


    /**
     * Gets an instance.
     */
    public function DefaultRangeClassification(minValue: Number, maxValue: Number, colourRamp: Array = null)
    {
        super();

        if (colourRamp == null)
            colourRamp = COLOUR_RAMP;
        var rangeSize: Number = getRangeSize(minValue, maxValue, colourRamp.length - 1);
        updateClassification(colourRamp, minValue, rangeSize);
    }


    /**
     * Gets the size of each range.
     *
     * return range size
     */
    private function getRangeSize(minValue: Number, maxValue: Number, numberOfRanges: uint): Number
    {
        var rangeSize:Number = (maxValue - minValue) / numberOfRanges;
        if (rangeSize > 1)
            rangeSize = Math.ceil(rangeSize);

        return rangeSize;
    }


    private function updateClassification(colourNumbers:Array, minValue: Number, rangeSize: Number): void
    {
        // clear existing legend elements
        removeAll();

        // add legend elements
        var value: Number = minValue;
        for each (var colour: Number in colourNumbers)
        {
            var range: RangeLegendElement = (RangeLegendElement)(addNew());
            range.colour = colour;
            range.minValue = value;
            range.includeMinValue = true;
            value += rangeSize;
            range.maxValue = value;
            range.includeMaxValue = false;
        }
    }
}
}