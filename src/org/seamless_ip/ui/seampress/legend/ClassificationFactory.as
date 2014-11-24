/*
 * wallace: ClassificationFactory.as
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
 * Factory for creating classifications.
 *
 * @author Peter Verweij
 * @author Rob Knapen
 */
public class ClassificationFactory
{
    public static function loadClassification(classificationNode: XML): Classification
    {
        var classification: Classification;

        var type: String = classificationNode.@type;
        if (type == RangeClassification.PARAMNAME)
            classification = new RangeClassification();
        else if (type == CategoryClassification.PARAMNAME)
            classification = new CategoryClassification();
        else
            return null;

        classification.assignFromXml(classificationNode);
        return classification;
    }
}
}