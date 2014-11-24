/*
 * wallace: DataGridColumnConceptSort.as
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

package org.seamless_ip.ui.common
{
import mx.controls.dataGridClasses.DataGridColumn;
import mx.utils.ObjectUtil;

import org.seamless_ip.services.transferobjects.capri.ActivityGroup;
import org.seamless_ip.services.transferobjects.capri.Country;
import org.seamless_ip.services.transferobjects.capri.CountryAggregate;
import org.seamless_ip.services.transferobjects.capri.InputGroup;
import org.seamless_ip.services.transferobjects.capri.PremiumGroup;
import org.seamless_ip.services.transferobjects.crop.IProduct;
import org.seamless_ip.services.transferobjects.crop.ProductGroup;
import org.seamless_ip.services.transferobjects.farm.FADNregion;
import org.seamless_ip.services.transferobjects.farm.NUTSregion;
import org.seamless_ip.services.transferobjects.farm.RepresentativeFarm;

public class DataGridColumnConceptSort extends DataGridColumn
{
    public function DataGridColumnConceptSort(columnName:String = null)
    {
        super(columnName);
        super.sortCompareFunction = sort;
    }

    // This doesn't work :-(
    private function sort(obj1:Object, obj2:Object):int {

        var str1:String = obj1.toString();
        var str2:String = obj2.toString();
        try {
            if (obj1 is NUTSregion) {
                str1 = (obj1 as NUTSregion).name;
                str2 = (obj2 as NUTSregion).name;
            } else if (obj1 is FADNregion) {
                str1 = (obj1 as FADNregion).name;
                str2 = (obj2 as FADNregion).name;
            } else if (obj1 is CountryAggregate) {
                str1 = (obj1 as CountryAggregate).name;
                str2 = (obj2 as CountryAggregate).name;
            } else if (obj1 is Country) {
                str1 = (obj1 as Country).name;
                str2 = (obj2 as Country).name;
            } else if (obj1 is ProductGroup) {
                str1 = (obj1 as ProductGroup).label_en;
                str2 = (obj2 as ProductGroup).label_en;
            } else if (obj1 is InputGroup) {
                str1 = (obj1 as InputGroup).label_en;
                str2 = (obj2 as InputGroup).label_en;
            } else if (obj1 is PremiumGroup) {
                str1 = (obj1 as PremiumGroup).label_en;
                str2 = (obj2 as PremiumGroup).label_en;
            } else if (obj1 is ActivityGroup) {
                str1 = (obj1 as ActivityGroup).label_en;
                str2 = (obj2 as ActivityGroup).label_en;
            } else if (obj1 is RepresentativeFarm) {
                str1 = (obj1 as RepresentativeFarm).description;
                str2 = (obj2 as RepresentativeFarm).description;
            } else if (obj1 is IProduct) {
                str1 = (obj1 as IProduct).label_en;
                str2 = (obj2 as IProduct).label_en;
            } else if (obj1 is ProductGroup) {
                str1 = (obj1 as ProductGroup).label_en;
                str2 = (obj2 as ProductGroup).label_en;
            }
        } catch (e:Error) {
            return 0;
        }
        return ObjectUtil.stringCompare(str1, str2);
    }


}
}