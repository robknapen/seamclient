/* wallace: CropProduct.as
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
package org.seamless_ip.services.transferobjects.crop
{
    import mx.collections.ArrayCollection;
    import org.seamless_ip.services.transferobjects.crop.Crop;
    import org.seamless_ip.services.transferobjects.crop.IProduct;
	import org.seamless_ip.services.transferobjects.utils.IClonable;

	[Bindable]
	[RemoteClass(alias="org.seamless_ip.services.transferobjects.crop.CropProductTO")]

	public class CropProduct implements IClonable, IProduct	{
		public function CropProduct()
		{
			isPartOfProductGroups = new ArrayCollection();
		}	
			
		
		public var id: String;
		public var isPartOfProductGroups: ArrayCollection;
		public var label_en: String;
		public var label_gms: String;
		public var ofCrop: Crop;





		public function Clone():IClonable
		{
			var clone: CropProduct = new CropProduct();
			var item:IClonable;  
			clone.id = this.id;
			for each (item in this.isPartOfProductGroups)
				clone.isPartOfProductGroups .addItem(item.Clone());
			clone.label_en = this.label_en;
			clone.label_gms = this.label_gms;
			clone.ofCrop = (Crop)(this.ofCrop .Clone());
			return clone;
		}
	}
	
	
}
