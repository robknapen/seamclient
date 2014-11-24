/* wallace: Outlook.as
 * ==============================================================================
 * This class was manually updated to add the SupplyShifts, as a short term
 * work around. It should in the future be replaced by generated code.
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
    
    import org.seamless_ip.services.transferobjects.utils.IClonable;

	[Bindable]
	[RemoteClass(alias="org.seamless_ip.services.transferobjects.seamproj.OutlookTO")]

	public class Outlook implements IClonable {

		public var biofuelDemands: ArrayCollection;
		public var co2concentration: Number;
		public var demandShifts: ArrayCollection;
		public var supplyShifts: ArrayCollection;
		public var energyPrice: ArrayCollection;
		public var euGDPgrowth: Number;
		public var exchangeRates: ArrayCollection;
		public var id: String;
		public var inflationRates: ArrayCollection;
		public var modulations: ArrayCollection;
		public var yieldGrowth: ArrayCollection;

		
		public function Outlook() {
			biofuelDemands = new ArrayCollection();
			demandShifts = new ArrayCollection();
			supplyShifts = new ArrayCollection();
			energyPrice = new ArrayCollection();
			exchangeRates = new ArrayCollection();
			inflationRates = new ArrayCollection();
			modulations = new ArrayCollection();
			yieldGrowth = new ArrayCollection();
		}	
		

		public function Clone():IClonable {
			var clone: Outlook = new Outlook();
			var item:IClonable;
			
			for each (item in this.biofuelDemands)
				clone.biofuelDemands .addItem(item.Clone());
			clone.co2concentration = this.co2concentration;
			for each (item in this.demandShifts)
				clone.demandShifts .addItem(item.Clone());
			for each (item in this.supplyShifts)
				clone.supplyShifts .addItem(item.Clone());
			for each (item in this.energyPrice)
				clone.energyPrice .addItem(item.Clone());
			clone.euGDPgrowth = this.euGDPgrowth;
			for each (item in this.exchangeRates)
				clone.exchangeRates .addItem(item.Clone());
			clone.id = this.id;
			for each (item in this.inflationRates)
				clone.inflationRates .addItem(item.Clone());
			for each (item in this.modulations)
				clone.modulations .addItem(item.Clone());
			for each (item in this.yieldGrowth)
				clone.yieldGrowth .addItem(item.Clone());
			return clone;
		}
	}
}
