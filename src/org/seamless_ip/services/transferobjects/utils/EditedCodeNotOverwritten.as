/*
 * wallace: EditedCodeNotOverwritten.as
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
package org.seamless_ip.services.transferobjects.utils
{



import org.seamless_ip.services.transferobjects.farmopt.IPolicyMeasure;
import org.seamless_ip.services.transferobjects.farmopt.Tax;		
import org.seamless_ip.services.transferobjects.farmopt.Penalty;
import org.seamless_ip.services.transferobjects.farmopt.SubsidyCrossCompliance;

import org.seamless_ip.services.transferobjects.indi.GenericTheme;
import org.seamless_ip.services.transferobjects.indi.IIndicator;
import org.seamless_ip.services.transferobjects.indi.IndicatorGroup;
import org.seamless_ip.services.transferobjects.indi.ModelVariable;
import org.seamless_ip.services.transferobjects.indi.Subtheme;
import org.seamless_ip.services.transferobjects.indi.Theme;
import org.seamless_ip.services.transferobjects.indi.EndorsedIndicator;

import org.seamless_ip.services.transferobjects.pica.ICrucialInstitutionalAspect;
import org.seamless_ip.services.transferobjects.pica.IPICAassessment;
import org.seamless_ip.services.transferobjects.pica.IPicaIndicator;
import org.seamless_ip.services.transferobjects.pica.IPICASpatialLevel;
import org.seamless_ip.services.transferobjects.pica.IInstitutionalCompatibility;
import org.seamless_ip.services.transferobjects.pica.InstitutionalCompatibility;
import org.seamless_ip.services.transferobjects.pica.PICAIndicatorGeneral;
import org.seamless_ip.services.transferobjects.pica.PICASpatialLevel;
import org.seamless_ip.services.transferobjects.pica.CrucialInstitutionalAspect;
import org.seamless_ip.services.transferobjects.pica.PicaIndicator;
import org.seamless_ip.services.transferobjects.pica.PICAIndicatorValue;

import org.seamless_ip.services.transferobjects.prodent.NutrientManagementSelectedCrops;
import org.seamless_ip.services.transferobjects.prodent.SelectedCrops;
import org.seamless_ip.services.transferobjects.prodent.WaterManagementSelectedCrops;

import org.seamless_ip.services.transferobjects.seamproj.ExperimentNarrative;
import org.seamless_ip.services.transferobjects.seamproj.OutlookNarrative;
import org.seamless_ip.services.transferobjects.seamproj.ModelChain;
import org.seamless_ip.services.transferobjects.seamproj.Permission;
import org.seamless_ip.services.transferobjects.seamproj.Model;
import org.seamless_ip.services.transferobjects.seamproj.Problem;
import org.seamless_ip.services.transferobjects.seamproj.Project;
import org.seamless_ip.services.transferobjects.seamproj.SpatialScale;
import org.seamless_ip.services.transferobjects.seamproj.TemporalScale;
import org.seamless_ip.services.transferobjects.seamproj.ContextNarrative;
import org.seamless_ip.services.transferobjects.seamproj.PolicyAssessmentNarrative;
import org.seamless_ip.services.transferobjects.seamproj.PolicyOptionNarrative;
import org.seamless_ip.services.transferobjects.seamproj.User;
import org.seamless_ip.services.transferobjects.seamproj.IRole;
import org.seamless_ip.services.transferobjects.seamproj.ProjectRole;
import org.seamless_ip.services.transferobjects.seamproj.ApplicationRole;
import org.seamless_ip.services.transferobjects.seamproj.BiophysicalSimulationNarrative;





/**
 * Class to know which classes are generated automatically and which aren't.
 * If accidentally the class is overwritten the compiler will lanch an error
 * 
 * @author Lorenzo Ruinelli; IDSIA Dalle Molle Institute for Artificial Intelligence
 */
public class EditedCodeNotOverwritten
{
	

 
	public function EditedCodeNotOverwritten()
	{
	}
	
	//this is only a check...we use the compiler to find if some
	//handwritten class is overwritten by an automativally generated one
	//the method is never called!!!
	private function check():void
	{
		var res: int  = 1;
		var obj: Object  = new Object();
		
		
		//farmopt
		res = (obj as IPolicyMeasure).notOverwriteIPolicyMeasure();//"
		res = (obj as Tax).notOverwriteIPolicyMeasure();//...
		res = (obj as Penalty).notOverwriteIPolicyMeasure();
		res = (obj as SubsidyCrossCompliance).notOverwriteIPolicyMeasure();
		
		//indi
		res = IndicatorGroup.notOverwriteIndicatorGroup;
		res = Theme.notOverwriteTheme;//...
		res = Subtheme.notOverwriteSubtheme;
		res = GenericTheme.notOverwriteGenericTheme;		
		res = (obj as IIndicator).notOverwriteIIndicator();
		res = (obj as EndorsedIndicator).notOverwriteIIndicator();
		res = (obj as ModelVariable).notOverwriteIIndicator();
		
		//pica
		res = (obj as ICrucialInstitutionalAspect).notOverwriteICrucialInstitutionalAspect();
		res = (obj as IPICAassessment).notOverwriteIPICAassessment();
		res = (obj as IPicaIndicator).notOverwriteIPicaIndicator();
		res = (obj as IPICASpatialLevel).notOverwriteIPICASpatialLevel();
		res = (obj as IInstitutionalCompatibility).notOverwriteIInstitutionalCompatibility();
		res = PicaIndicator.notOverwritePicaIndicator;
		res = PICAIndicatorValue.notOverwritePICAIndicatorValue;
		res = InstitutionalCompatibility.notOverwriteInstitutionalCompatibility;
		res = PICAIndicatorGeneral.notOverwritePICAIndicatorGeneral;
		res = PICASpatialLevel.notOverwritePICASpatialLevel;
		res = CrucialInstitutionalAspect.notOverwriteCrucialInstitutionalAspect;

		//prodent		
		res = NutrientManagementSelectedCrops.notOverwriteNutrientManagementSelectedCrops;
		res = SelectedCrops.notOverwriteSelectedCrops;		
		res = WaterManagementSelectedCrops.notOverwriteWaterManagementSelectedCrops;		
		
		//seamproj						
		res = ContextNarrative.notOverwriteContextNarrative;
		res = PolicyAssessmentNarrative.notOverwritePolicyAssessmentNarrative;
		res = PolicyOptionNarrative.notOverwritePolicyOptionNarrative;
		res = User.notOverwriteUser;
		res = (obj as IRole).notOverwriteIRole();
		res = (obj as ApplicationRole).notOverwriteIRole();
		res = (obj as ProjectRole).notOverwriteIRole();
		res = ModelChain.notOverwriteModelChain;
		res = Permission.notOverwritePermission;
		res = Model.notOverwriteModel;
		res = Problem.notOverwriteProblem;
		res = Project.notOverwriteProject;
		res = SpatialScale.notOverwriteSpatialScale;
		res = TemporalScale.notOverwriteTemporalScale;
		res = ExperimentNarrative.notOverwriteExperimentNarrative;
		res = OutlookNarrative.notOverwriteOutlookNarrative;
	}
}
}
