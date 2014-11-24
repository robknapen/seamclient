/*
 * wallace: EnumClassName.as
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
package org.seamless_ip.ui.enums
{
import mx.collections.ArrayCollection;

/**
 * Enumeration of names of classes that represent enumerations on the server
 * side. To be used with the IEnumServices to retrieve enumerations from the
 * database. Use the equals() method to compare instances (not ==).
 */
public class EnumClassName
{
    // names refer to Java seamfaces(!) classes on the server!
    public static const SPATIAL_SCALE:EnumClassName = new EnumClassName("org.seamless_ip.ontologies.seamproj.SpatialScale", "Spatial Scale");
    public static const TEMPORAL_SCALE:EnumClassName = new EnumClassName("org.seamless_ip.ontologies.seamproj.TemporalScale", "Temporal Scale");
    public static const DOMAIN:EnumClassName = new EnumClassName("org.seamless_ip.ontologies.indi.Domain", "Domain");
    public static const DIMENSION:EnumClassName = new EnumClassName("org.seamless_ip.ontologies.indi.Dimension", "Dimension");
    public static const GENERICTHEME:EnumClassName = new EnumClassName("org.seamless_ip.ontologies.indi.GenericTheme", "Generic Theme");
    public static const THEME:EnumClassName = new EnumClassName("org.seamless_ip.ontologies.indi.Theme", "Theme");
    public static const SUBTHEME:EnumClassName = new EnumClassName("org.seamless_ip.ontologies.indi.Subtheme", "Subtheme");
    public static const MODEL:EnumClassName = new EnumClassName("org.seamless_ip.ontologies.seamproj.Model", "Model");
    public static const MODELCHAIN:EnumClassName = new EnumClassName("org.seamless_ip.ontologies.seamproj.ModelChain", "Model Chain");

    // list of all enum classes
    public static const values:ArrayCollection = new ArrayCollection(
            [ SPATIAL_SCALE, TEMPORAL_SCALE, DOMAIN, DIMENSION, GENERICTHEME, THEME, SUBTHEME, MODEL, MODELCHAIN ]
            );

    private var _value:String;
    private var _caption:String;
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
     * Create an instance with the specified value.
     *
     * @param value of the enum instance
     */
    public function EnumClassName(value:String = null, caption:String = null) {
        if (_lock && value != null)
            throw new Error("Cannot instantiate Enum");

        _value = value;
        _caption = caption;
    }


    /**
     * Returns the value of the enum instance.
     *
     * @return value as text string
     */
    public function get value():String {
        return _value;
    }


    /**
     * Returns the caption of the enum instance.
     *
     * @return caption as text string
     */
    public function get caption():String {
        return _caption;
    }


    /**
     * Compare enum instance with the specified enum instance. This
     * checks the content of the value property, which gives better
     * result than by comparing instances using ==.
     *
     * @param enum to compare with
     * @return true when enum value properties are the same
     */
    public function equals(enum:EnumClassName):Boolean {
        if (enum == null)
            return false;

        return enum.value == _value;
    }
}
}