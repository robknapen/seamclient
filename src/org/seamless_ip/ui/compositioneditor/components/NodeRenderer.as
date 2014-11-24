/*
 * wallace: NodeRenderer.as
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
	import flare.vis.data.DataSprite;
	import flare.vis.data.render.IRenderer;
	
	import flash.display.Graphics;
	
	import mx.charts.chartClasses.NumericAxis;

	public class NodeRenderer implements IRenderer
	{
		private const DEFAULTSIZE          : uint = 25;
//		private const DEFAULT_FILLCOLOUR   : Number = 0xff952703;
//		private const HIGHLIGHT_FILLCOLOUR : Number = 0xffe4ccbb;
//		private const DEFAULT_LINECOLOUR   : Number = 0xff651808;
		private const DEFAULT_FILLCOLOUR   : Number = 0xff3b91b6;
		private const HIGHLIGHT_FILLCOLOUR : Number = 0xffa8cee2;
		private const INACTIVE_FILLCOLOUR  : Number = 0xffbbbbbb;
		private const DEFAULT_LINECOLOUR   : Number = 0xff0071a1;
		private const HIGHLIGHT_LINEWIDTH  : Number = 3;
		
		private var _selected: Boolean = false;
		private var _active  : Boolean = true;
		
		public function NodeRenderer(selected: Boolean=false)
		{
			_selected = selected;
		}
		
		public function render(d:DataSprite): void
		{
			_active   = (d.data.active != "false");
			
			
			var lineAlpha:Number = d.lineAlpha;
			var fillAlpha:Number = d.fillAlpha;
			var size:Number = d.size * DEFAULTSIZE;

			var g: Graphics = d.graphics;
			g.clear();
//			if (fillAlpha > 0) g.beginFill(d.fillColor, fillAlpha);
//			if (lineAlpha > 0) g.lineStyle(d.lineWidth, d.lineColor, lineAlpha);
			if (fillAlpha > 0) g.beginFill(getFillColour(), fillAlpha);
			if (lineAlpha > 0) g.lineStyle(getLineWidth(d.lineWidth), DEFAULT_LINECOLOUR, lineAlpha);

			g.drawRoundRectComplex(-size, -.25*size, 2*size, .5*size, 7, 7, 7, 7);

			if (fillAlpha > 0) g.endFill();
		}

		private function getFillColour(): Number
		{
			if (!_active)
				return INACTIVE_FILLCOLOUR;
			else if (_selected)
				return HIGHLIGHT_FILLCOLOUR;
			else
				return DEFAULT_FILLCOLOUR;
		}
		
		private function getLineWidth(defaultLineWidth: int): Number
		{
			if (_selected)
				return HIGHLIGHT_LINEWIDTH;
			else
				return defaultLineWidth;
		}
		
		

	}
}