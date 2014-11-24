/*
 * wallace: ValueType.as
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
import mx.collections.ArrayCollection;

/**
 * Enumeration of types of values (absolute, relative to baseline, etc.) that
 * can be returned by the IndicatorValues class. It is used to drive internal
 * calculations done by this class.
 *
 * Note: Use the equals() method to compare instances (not ==).
 *
 * @author Rob Knapen
 */
public class ValueType
{
    public static const ABSOLUTE_VALUES:ValueType = new ValueType("Absolute", false);
    public static const RELATIVE_VALUES:ValueType = new ValueType("Absolute difference to baseline", false);
    public static const RELATIVE_PERCENTAGES:ValueType = new ValueType("Relative change to baseline (%)", true);

    // list of all enum values
    public static const values:ArrayCollection = new ArrayCollection(
            [ ABSOLUTE_VALUES, RELATIVE_VALUES, RELATIVE_PERCENTAGES ]
            );

    private var _label:String;
    private var _isPercentage:Boolean;
    private static var _lock:Boolean = false;


    /**
     * Static block, lock the class after initialisation. This is a work
     * around for the current actionscript limitations to have a proper
     * enum class / keyword.
     */
{
    _lock = true;
}


    /**
     * Create an instance with the specified label.
     *
     * @param label of the enum instance
     */
    public function ValueType(label:String = null, isPercentage:Boolean = false) {
        if (_lock && label != null)
            throw new Error("Cannot instantiate Enum");

        _label = label;
        _isPercentage = isPercentage;
    }


    /**
     * Returns the label of the enum instance.
     *
     * @return label as text string
     */
    public function get label():String {
        return _label;
    }


    /**
     * Returns if the enum indicates a percentage value type or not.
     */
    public function get isPercentage():Boolean {
        return _isPercentage;
    }


    /**
     * Compare enum instance with the specified enum instance. This
     * checks the content of the value property, which gives better
     * result than by comparing instances using ==.
     *
     * @param enum to compare with
     * @return true when enum value properties are the same
     */
    public function equals(enum:ValueType):Boolean {
        if (enum == null)
            return false;

        return (enum.label == _label);
    }
}
}