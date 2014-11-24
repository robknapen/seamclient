/*
 * wallace: CapriCountryMacro.as
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
	
	import org.seamless_ip.services.transferobjects.capri.Country;
	
	public class CapriCountryMacro extends AbstractCapriMacro
	{
	    private var _country:Country;
	
	
	    public function CapriCountryMacro(country:Country, abs:Number, rel:Number) {
	        super(abs, rel);
	        _country = country;
	    }
	
	
	    public function get country():Country {
	        return _country;
	    }
	
	
	    public function set country(country:Country):void {
	        _country = country;
	    }
	
	
	    public static function labelCountry(item:Object, column:DataGridColumn):String {
	        return ((CapriCountryMacro)(item)).country.name;
	    }
	
	
	    public static function sortCountry(obj1:Object, obj2:Object):int {
	        return ObjectUtil.stringCompare(((CapriCountryMacro)(obj1)).country.name, ((CapriCountryMacro)(obj2)).country.name);
	    }
	}
}