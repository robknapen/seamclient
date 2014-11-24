/*
 * wallace: Classification.as
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
import mx.collections.ArrayCollection;

/**
 * Base class for collection of legend items.
 *
 * @author Peter Verweij
 * @author Rob Knapen
 */
public class Classification extends ArrayCollection
{
    public static const TAGNAME:String = "classification";
    public static const PARAMNAME: String = "";


    /**
     * find legend item for a legend value
     * returns UndefinedLegendElement singleton if not found
     *
     * override this method in specialisations
     */
    public function findItemForValue(value: Object):LegendElement
    {
        return UndefinedLegendElement.instance;
    }


    /**
     * create and add a new legend element
     * @return LegendElement
     *
     * override this method in specialisations
     */
    public function addNew(): LegendElement
    {
        return null;
    }


    /**
     * assign classification properties from xml
     *
     * override this method in specialisations
     */
    public function assignFromXml(xml: XML): void
    {
        removeAll();

        var list: XMLList = xml..legendElement;
        var element: LegendElement;
        for (var i: int = 0; i < list.length(); i++)
        {
            element = addNew();
            element.assignFromXml(list[i]);
        }
    }


    /**
     * write classificaiton properties to xml
     *
     * override this method in specialisations
     */
    public function toXml(): XML
    {
        var xml:XML =
                <{TAGNAME}>
                </{TAGNAME}>

        for each (var element: LegendElement in this)
            xml.appendChild(element.toXml());

        return xml;
    }
}
}