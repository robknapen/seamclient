/* wallace: CouplingDegree.as
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
    import org.seamless_ip.services.transferobjects.capri.Country;
    import org.seamless_ip.services.transferobjects.capri.ICAPRIParameter;
    import org.seamless_ip.services.transferobjects.capri.PremiumGroup;
	import org.seamless_ip.services.transferobjects.utils.IBaseLineValue;
	import org.seamless_ip.services.transferobjects.utils.IClonable;

	[Bindable]
	[RemoteClass(alias="org.seamless_ip.services.transferobjects.capri.CouplingDegreeTO")]

	public class CouplingDegree implements IClonable, IBaseLineValue, ICAPRIParameter	{
		public function CouplingDegree()
		{
		}	
			
		
		public var baselineValue: Number;
		public var country: Country;
		public var id: String;
		public var premiumGroup: PremiumGroup;
		public var value: Number;






		public function get BaseLineValue(): Number
		{
			return baselineValue;
		}
		public function Clone():IClonable
		{
			var clone: CouplingDegree = new CouplingDegree();
			var item:IClonable;  
			clone.baselineValue = this.baselineValue;
			clone.country = (Country)(this.country .Clone());
			clone.id = this.id;
			clone.premiumGroup = (PremiumGroup)(this.premiumGroup .Clone());
			clone.value = this.value;
			return clone;
		}
	}
	
	
}
