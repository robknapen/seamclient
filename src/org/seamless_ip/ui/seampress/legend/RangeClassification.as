/*
 * wallace: RangeClassification.as
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
 * Map classification based on ranges.
 *
 * @author Peter Verweij
 * @author Rob Knapen
 */
public class RangeClassification extends Classification
{
    public static const PARAMNAME: String = "Range";


    /**
     * find legend item for a legend value
     * returns null if not found
     */
    override public function findItemForValue(value: Object):LegendElement
    {
        if (value is Number)
        {
            var n: Number = Number(value);

            for each (var obj: Object in this)
                if ((obj is RangeLegendElement) && (RangeLegendElement(obj).includes(n)))
                    return RangeLegendElement(obj);
        }

        return super.findItemForValue(value);
    }


    /**
     * create a new legendElement; add it to the list; and return
     */
    override public function addNew(): LegendElement
    {
        var element: RangeLegendElement = new RangeLegendElement();
        addItem(element);
        return element;
    }

}
}