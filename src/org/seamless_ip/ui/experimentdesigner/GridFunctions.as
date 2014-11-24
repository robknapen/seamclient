/*
 * wallace: GridFunctions.as
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

import mx.controls.DataGrid;
import mx.controls.TextInput;
import mx.events.DataGridEvent;
import mx.events.DataGridEventReason;

public function validatGridInput(event:DataGridEvent, min:Number, max:Number, theDataGrid:DataGrid):void {
    // Check the reason for the event.
    if (event.reason == DataGridEventReason.CANCELLED)
    {
        // Do not update cell.
        return;
    }
    try {
        // Get the new data value from the editor.
        var newData:String =
                TextInput(event.currentTarget.itemEditorInstance).text;

        var newNumber:Number = new Number(newData);

        if (isNaN(newNumber)) {
            event.preventDefault();
            TextInput(theDataGrid.itemEditorInstance).errorString = "Invalid input";
            return;
        }
        // Determine if the new value is an empty String.
        if (newData == "" || newNumber < min || newNumber > max) {
            // Prevent the user from removing focus,
            // and leave the cell editor open.
            event.preventDefault();
            // Write a message to the errorString property.
            // This message appears when the user
            // mouses over the editor.
            var err:String;
            if (max == Number.MAX_VALUE) {
                "Enter valid input. Input must be between " + min + " and inf.";
            } else {
                "Enter valid input. Input must be between " + min + " and " + max + ".";
            }
            TextInput(theDataGrid.itemEditorInstance).errorString =
            "Enter valid input. Input must be between " + min + " and " + max + ".";
            return;
        }
    } catch (eX:Error) {
        event.preventDefault();
        TextInput(theDataGrid.itemEditorInstance).errorString = "Invalid input";
        return;
    }

}
