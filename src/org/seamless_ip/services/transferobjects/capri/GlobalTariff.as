/* wallace: GlobalTariff.as
 * ==============================================================================
 * (This code was generated by a tool)
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
package org.seamless_ip.services.transferobjects.capri
{
    import org.seamless_ip.services.transferobjects.capri.CountryAggregate;
    import org.seamless_ip.services.transferobjects.capri.ICAPRIParameter;
    import org.seamless_ip.services.transferobjects.crop.ProductGroup;
	import org.seamless_ip.services.transferobjects.utils.IClonable;

	[Bindable]
	[RemoteClass(alias="org.seamless_ip.services.transferobjects.capri.GlobalTariffTO")]

	public class GlobalTariff implements IClonable, ICAPRIParameter	{
		public function GlobalTariff()
		{
		}	
			
		
		public var adValorem: Number;
		public var baslineAdvalorem: Number;
		public var baslineSpecifictariff: Number;
		public var countryAggregate: CountryAggregate;
		public var id: String;
		public var productGroup: ProductGroup;
		public var specificTariff: Number;





		public function Clone():IClonable
		{
			var clone: GlobalTariff = new GlobalTariff();
			var item:IClonable;  
			clone.adValorem = this.adValorem;
			clone.baslineAdvalorem = this.baslineAdvalorem;
			clone.baslineSpecifictariff = this.baslineSpecifictariff;
			clone.countryAggregate = (CountryAggregate)(this.countryAggregate .Clone());
			clone.id = this.id;
			clone.productGroup = (ProductGroup)(this.productGroup .Clone());
			clone.specificTariff = this.specificTariff;
			return clone;
		}
	}
	
	
}
