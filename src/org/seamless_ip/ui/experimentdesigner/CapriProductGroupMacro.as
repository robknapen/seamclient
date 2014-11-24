/*
 * wallace: CapriProductGroupMacro.as
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

package org.seamless_ip.ui.experimentdesigner
{
import mx.controls.dataGridClasses.DataGridColumn;
import mx.utils.ObjectUtil;

import org.seamless_ip.services.transferobjects.crop.ProductGroup;

public class CapriProductGroupMacro extends AbstractCapriMacro
{
    private var _productGroup:ProductGroup;

    public function CapriProductGroupMacro(productGroup:ProductGroup, abs:Number, rel:Number)
    {
        super(abs, rel);
        _productGroup = productGroup;
    }

    public function get productGroup() : ProductGroup {
        return _productGroup;
    }

    public function set productGroup(productGroup:ProductGroup) : void
    {
        _productGroup = productGroup;
    }

    public static function labelProductGroup(item:Object, column:DataGridColumn):String {
        return ((CapriProductGroupMacro)(item)).productGroup.label_en;
    }

    public static function sortProductGroup(obj1:Object, obj2:Object):int {
        return ObjectUtil.stringCompare(((CapriProductGroupMacro)(obj1)).productGroup.label_en, ((CapriProductGroupMacro)(obj2)).productGroup.label_en);
    }

}
}