/*
 * wallace: DataGridRowColor.as
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
import flash.display.Sprite;
import flash.events.KeyboardEvent;

import mx.collections.ArrayCollection;
import mx.controls.CheckBox;
import mx.controls.DataGrid;
import mx.controls.listClasses.IListItemRenderer;

public class DataGridRowColor extends DataGrid
{

    public static function Diff(n1:Number, n2:Number) : Number {

        if (n1 < n2) {
            return n2 - n1;
        } else {
            return n1 - n2;
        }
    }

    public static function DiffColor(n1:Number, n2:Number, color:uint): uint {

        if (Diff(n1, n2) >= 0.01) {
            return  0xADFF2F
        } else {
            return color;
        }
    }

    public static function Brightness(theV:Number, theB:Number, color:uint) : uint {
        if (theV != theB) {
            /* 	if (theB != 0) {
             var brightness:Number = 0;
             if (theV < theB) {
             brightness = 100 - (20 + ((theB - theV)/theB) * 80);
             } else {
             brightness = 100 - (20 + ((theV - theB)/theV) * 80);
             }
             return  ColorUtil.adjustBrightness2(0xADFF2F, brightness);

             } else { */
            return 0xADFF2F;
            /* } */
        }

        return color;
    }

    public function DataGridRowColor()
    {
        super();
    }

    private var _rowColorFunction:Function;

    public function set rowColorFunction(f:Function):void
    {
        this._rowColorFunction = f;
    }

    public function get rowColorFunction():Function
    {
        return this._rowColorFunction;
    }

    private var displayWidth:Number;

    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
    {
        super.updateDisplayList(unscaledWidth, unscaledHeight);
        if (displayWidth != unscaledWidth - viewMetrics.right - viewMetrics.left)
        {
            displayWidth = unscaledWidth - viewMetrics.right - viewMetrics.left;
        }
    }

    override protected function drawRowBackground(s:Sprite, rowIndex:int,
                                                  y:Number, height:Number, color:uint, dataIndex:int):void
    {
        if (this.rowColorFunction != null)
        {
            if (dataIndex < (this.dataProvider as ArrayCollection).length)
            {
                var item:Object = (this.dataProvider as ArrayCollection).getItemAt(dataIndex);
                color = this.rowColorFunction.call(this, item, color);
            }
        }

        super.drawRowBackground(s, rowIndex, y, height, color, dataIndex);
    }


    override protected function selectItem(item:IListItemRenderer,
                                           shiftKey:Boolean, ctrlKey:Boolean,
                                           transition:Boolean = true):Boolean
    {
        // only run selection code if a checkbox was hit and always
        // pretend we're using ctrl selection
        if (item is CheckBox)
            return super.selectItem(item, false, true, transition);
        return false;
    }

    // turn off selection indicator
    override protected function drawSelectionIndicator(
            indicator:Sprite, x:Number, y:Number,
            width:Number, height:Number, color:uint,
            itemRenderer:IListItemRenderer):void
    {
    }

    // whenever we draw the renderer, make sure we re-eval the checked state
    override protected function drawItem(item:IListItemRenderer,
                                         selected:Boolean = false,
                                         highlighted:Boolean = false,
                                         caret:Boolean = false,
                                         transition:Boolean = false):void
    {
        if (item is CheckBox) {
            CheckBox(item).invalidateProperties();
        }
        super.drawItem(item, selected, highlighted, caret, transition);
    }

    // fake all keyboard interaction as if it had the ctrl key down
    override protected function keyDownHandler(event:KeyboardEvent):void
    {
        // this is technically illegal, but works
        event.ctrlKey = true;
        event.shiftKey = false;
        super.keyDownHandler(event);
    }

}
}