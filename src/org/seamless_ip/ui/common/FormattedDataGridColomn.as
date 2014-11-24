/*
 * wallace: FormattedDataGridColomn.as
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
import mx.formatters.NumberFormatter;

public class FormattedDataGridColomn extends DataGridColumn
{
    private var nf:NumberFormatter;

    [Bindable]
    private var _percision:int = 2;


    public function FormattedDataGridColomn(columnName:String = null)
    {
        super(columnName);
        nf = new NumberFormatter();
        nf.precision = _percision;
        nf.useThousandsSeparator = false;
    }

    public function set percision(percision:int) : void {
        _percision = percision;
        nf.precision = _percision;
    }

    public function get perciosion(): int {
        return _percision;
    }

    override public function itemToLabel(data:Object):String
    {
        if (!data)
            return " ";

        if (labelFunction != null)
            return labelFunction(data, this);


        if (typeof(data) == "object" || typeof(data) == "xml")
        {
            try
            {
                data = data[dataField];
            }
            catch(e:Error)
            {
                data = null;
            }
        }

        if (data is String)
            if (!isNaN(parseFloat(data as String))) {
                return nf.format(data);
            } else {
                return String(data);
            }
        try
        {
            if (!isNaN(parseFloat(data.toString()))) {
                return nf.format(data);
            }
            return data.toString();
        }
        catch(e:Error)
        {
        }

        return " ";
    }
}
}