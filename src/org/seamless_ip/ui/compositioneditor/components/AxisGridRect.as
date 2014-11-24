/*
 * wallace: AxisGridRect.as
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

package org.seamless_ip.ui.compositioneditor.components
{
	import flare.display.RectSprite;
	import flare.vis.axis.AxisGridLine;
	
	import flash.events.Event;

	/**
	 * Axis grid rect in an axis display.
	 */
	public class AxisGridRect extends RectSprite
	{
		private const CORNER_SIZE: int = 7;
		private const GAP        : int = 5;
		private const LINECOLOUR : Number = 0xffffff00;
		private const FILLCOLOUR : Number = 0x88ffff00;
		
		private var _barwidth    : int;
		private var _barColour   : Number;
		private var _line        : AxisGridLine;
		
		
		/**
		 * get an instance
		 */
		public function AxisGridRect (line: AxisGridLine, barwidth: int, barColour: Number)
		{
			_line = line;
			_barwidth = barwidth;
			_barColour = barColour;
		
			update(_line, _barwidth, _barColour);	

			line.addEventListener(Event.RENDER, handleRenderEvent);
			line.addChild(this);
		}
		
		private function update(line: AxisGridLine, barwidth: int, barColour: Number): void
		{
				cornerSize = CORNER_SIZE;
				lineColor  = barColour;
				fillColor  = barColour;
				
				if (line.x1 == line.x2)
				{
					// vertical line (column)
					w = barwidth - 2*GAP;
					h = (line.y1 - line.y2) - 2*GAP;
					x = line.x1 - .5*w;
					y = line.y2 + GAP;
				}
				else
				{
					// horizontal line (row)
					w = (line.x2 - line.x1) - 2*GAP;
					h = barwidth - 2*GAP;
					x = line.x1 + GAP;
					y = line.y1 - .5*h;
				}
		}
		
		private function handleRenderEvent(event: Event): void
		{
			update(_line, _barwidth, _barColour);	
		}
	}
}