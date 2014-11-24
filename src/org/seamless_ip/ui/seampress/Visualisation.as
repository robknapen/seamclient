/*
 * wallace: Visualisation.as
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
 * Class to store settings for a visualisation of SEAMLESS data.
 *
 * @author Rob Knapen
 */
[Bindable]
[RemoteClass(alias="org.seamless_ip.services.transferobjects.seamproj.VisualisationTO")]
public class Visualisation {
    // for Java Bean compatibility - not used
    public var id:String;
    // general settings
    public var title:String = "New visualisation";
    public var description:String = "Please enter a description of the visualisation.";
    public var author:String = "Seamless";
    public var indicatorIds:ArrayCollection = new ArrayCollection();
    public var experimentIds:ArrayCollection = new ArrayCollection();
    public var baselineExperimentId:String;
    public var baselineExperimentTitle:String;
    public var properties:Object = new Object();

    public function isValid():Boolean {
        return (
                (experimentIds.length > 0) &&
                (indicatorIds.length > 0)
                );
    }
}
}