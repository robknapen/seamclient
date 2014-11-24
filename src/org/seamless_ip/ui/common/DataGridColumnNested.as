/*
 * wallace: DataGridColumnNested.as
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

public class DataGridColumnNested extends DataGridColumn
{
    public function DataGridColumnNested(columnName:String = null)
    {
        super(columnName);
        this.sortable = false;
    }

    override public function itemToLabel(data:Object):String
    {
        var fields:Array;
        var attribute:String;
        var label:String;

        var dataFieldSplit:String = dataField;
        var currentData:Object = data;

        if ((dataFieldSplit == null) || (currentData == null))
            return "";

        if (dataField.indexOf("@") != -1)
        {
            fields = dataFieldSplit.split("@");
            dataFieldSplit = fields[0];
            attribute = fields[1];
        }

        if (dataField.indexOf(".") != -1)
        {
            fields = dataFieldSplit.split(".");

            for each(var f:String in fields)
                currentData = currentData[f];

            if (currentData is String)
                return String(currentData);
        }
        else
        {
            if (dataFieldSplit != "")
                currentData = currentData[dataFieldSplit];
        }

        if (attribute)
        {
            if (currentData is XML || currentData is XMLList)
                currentData = XML(currentData).attribute(attribute);
            else
                currentData = currentData[attribute];
        }

        try
        {
            label = currentData.toString();
        }
        catch(e:Error)
        {
            label = super.itemToLabel(data);
        }

        return label;
    }
}
}