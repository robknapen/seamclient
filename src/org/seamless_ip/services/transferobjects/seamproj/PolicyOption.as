/* wallace: PolicyOption.as
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
package org.seamless_ip.services.transferobjects.seamproj
{
    import mx.collections.ArrayCollection;
    import org.seamless_ip.services.transferobjects.seamproj.Narrative;
	import org.seamless_ip.services.transferobjects.utils.IClonable;

	[Bindable]
	[RemoteClass(alias="org.seamless_ip.services.transferobjects.seamproj.PolicyOptionTO")]

	public class PolicyOption implements IClonable	{
		public function PolicyOption()
		{
			basicPremiums = new ArrayCollection();
			bilateralTariffs = new ArrayCollection();
			couplingDegrees = new ArrayCollection();
			farmConstraints = new ArrayCollection();
			farmQuotas = new ArrayCollection();
			globalTariffs = new ArrayCollection();
			policyMeasures = new ArrayCollection();
			priceChange = new ArrayCollection();
			quotaCountries = new ArrayCollection();
			setAsideRegulations = new ArrayCollection();
			subsidies = new ArrayCollection();
			subsidisedExports = new ArrayCollection();
			tradeReformProposals = new ArrayCollection();
			yieldTrend = new ArrayCollection();
		}	
			
		
		public var basicPremiums: ArrayCollection;
		public var bilateralTariffs: ArrayCollection;
		public var couplingDegrees: ArrayCollection;
		public var farmConstraints: ArrayCollection;
		public var farmQuotas: ArrayCollection;
		public var globalTariffs: ArrayCollection;
		public var id: String;
		public var narrative: Narrative;
		public var policyMeasures: ArrayCollection;
		public var priceChange: ArrayCollection;
		public var quotaCountries: ArrayCollection;
		public var setAsideRegulations: ArrayCollection;
		public var subsidies: ArrayCollection;
		public var subsidisedExports: ArrayCollection;
		public var tradeReformActivated: Boolean;
		public var tradeReformProposals: ArrayCollection;
		public var yieldTrend: ArrayCollection;





		public function Clone():IClonable
		{
			var clone: PolicyOption = new PolicyOption();
			var item:IClonable;  
			for each (item in this.basicPremiums)
				clone.basicPremiums .addItem(item.Clone());
			for each (item in this.bilateralTariffs)
				clone.bilateralTariffs .addItem(item.Clone());
			for each (item in this.couplingDegrees)
				clone.couplingDegrees .addItem(item.Clone());
			for each (item in this.farmConstraints)
				clone.farmConstraints .addItem(item.Clone());
			for each (item in this.farmQuotas)
				clone.farmQuotas .addItem(item.Clone());
			for each (item in this.globalTariffs)
				clone.globalTariffs .addItem(item.Clone());
			clone.id = this.id;
			clone.narrative = (Narrative)(this.narrative .Clone());
			for each (item in this.policyMeasures)
				clone.policyMeasures .addItem(item.Clone());
			for each (item in this.priceChange)
				clone.priceChange .addItem(item.Clone());
			for each (item in this.quotaCountries)
				clone.quotaCountries .addItem(item.Clone());
			for each (item in this.setAsideRegulations)
				clone.setAsideRegulations .addItem(item.Clone());
			for each (item in this.subsidies)
				clone.subsidies .addItem(item.Clone());
			for each (item in this.subsidisedExports)
				clone.subsidisedExports .addItem(item.Clone());
			clone.tradeReformActivated = this.tradeReformActivated;
			for each (item in this.tradeReformProposals)
				clone.tradeReformProposals .addItem(item.Clone());
			for each (item in this.yieldTrend)
				clone.yieldTrend .addItem(item.Clone());
			return clone;
		}
	}
	
	
}
