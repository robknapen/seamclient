/*
 * wallace: IndicatorCategory.as
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
package org.seamless_ip.ui.indicators
{
/**
 * Defines the possible values for indicator category. Eventually this should
 * be retrieved from the database or the ontology.
 */
public final class IndicatorCategory
{
    public static const UNDEFINED:IndicatorCategory = new IndicatorCategory(-1, "Undefined");
    public static const DOMAIN:IndicatorCategory = new IndicatorCategory(0, "Domain");
    public static const DIMENSION:IndicatorCategory = new IndicatorCategory(1, "Dimension");
    public static const GENERIC_THEME:IndicatorCategory = new IndicatorCategory(2, "Generic Theme");
    public static const THEME:IndicatorCategory = new IndicatorCategory(3, "Theme");
    public static const SUBTHEME:IndicatorCategory = new IndicatorCategory(4, "Subtheme");


    // convenience array to be able to iterate over the collection of values
    public static const values:Array = new Array(DOMAIN, DIMENSION, GENERIC_THEME, THEME, SUBTHEME);


    /**
     * Ordinal value of the enumeration item.
     */
    private var _index:int;

    /**
     * Name of the enumeration item.
     */
    private var _name:String;


    /**
     * Creates an instance with the specified index and name.
     *
     * @param index for the new instance
     * @param name for the new instance
     *
     */
    public function IndicatorCategory(index:int, name:String) {
        super();
        _index = index;
        _name = name;
    }


    /**
     * Gets the ordinal value of the item.
     *
     * @return int ordinal value
     */
    public function get index():int {
        return _index;
    }


    /**
     * Gets the name of the item.
     *
     * @return String with name of the item
     */
    public function get name():String {
        return _name;
    }


    /**
     * Finds the enumeration item with the specified index (ordinal)
     * value. This is returned, or UNDEFINED if no item with the
     * given index exists.
     *
     * @param index to find enumeration item for
     * @return IndicatorCategory instance with the specified index
     */
    public static function findByIndex(index:int):IndicatorCategory {
        for each (var item:IndicatorCategory in values) {
            if (item._index == index)
                return item;
        }
        return UNDEFINED;
    }


    /**
     * Returns the String identification for the object.
     *
     * @return String identifying the object
     */
    public function toString():String {
        return _name;
    }
}
}