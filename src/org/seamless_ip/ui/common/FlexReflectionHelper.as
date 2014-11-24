/*
 * wallace: FlexReflectionHelper.as
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
import org.seamless_ip.services.transferobjects.capri.ActivityGroup;
import org.seamless_ip.services.transferobjects.capri.BasicPremium;
import org.seamless_ip.services.transferobjects.capri.BilateralTariff;
import org.seamless_ip.services.transferobjects.capri.BiofuelDemand;
import org.seamless_ip.services.transferobjects.capri.Country;
import org.seamless_ip.services.transferobjects.capri.CountryAggregate;
import org.seamless_ip.services.transferobjects.capri.DemandShift;
import org.seamless_ip.services.transferobjects.capri.EnergyPrice;
import org.seamless_ip.services.transferobjects.capri.ExchangeRates;
import org.seamless_ip.services.transferobjects.capri.GlobalTariff;
import org.seamless_ip.services.transferobjects.capri.InflationRate;
import org.seamless_ip.services.transferobjects.capri.InputGroup;
import org.seamless_ip.services.transferobjects.capri.Modulation;
import org.seamless_ip.services.transferobjects.capri.PremiumGroup;
import org.seamless_ip.services.transferobjects.capri.QuotaCountry;
import org.seamless_ip.services.transferobjects.capri.SetAsideRegulation;
import org.seamless_ip.services.transferobjects.capri.SubsidisedExport;
import org.seamless_ip.services.transferobjects.capri.SupplyShift;
import org.seamless_ip.services.transferobjects.capri.TradeReformProposal;
import org.seamless_ip.services.transferobjects.capri.TradeReformProposalCut;
import org.seamless_ip.services.transferobjects.capri.YieldGrowth;
import org.seamless_ip.services.transferobjects.crop.Crop;
import org.seamless_ip.services.transferobjects.crop.CropProduct;
import org.seamless_ip.services.transferobjects.farm.FADNregion;
import org.seamless_ip.services.transferobjects.farm.NUTSregion;
import org.seamless_ip.services.transferobjects.farmopt.FarmConstraint;
import org.seamless_ip.services.transferobjects.farmopt.Penalty;
import org.seamless_ip.services.transferobjects.farmopt.SubsidyCrossCompliance;
import org.seamless_ip.services.transferobjects.farmopt.Tax;
import org.seamless_ip.services.transferobjects.farmopt.YieldTrend;
import org.seamless_ip.services.transferobjects.indi.Dimension;
import org.seamless_ip.services.transferobjects.indi.Domain;
import org.seamless_ip.services.transferobjects.indi.EndorsedIndicator;
import org.seamless_ip.services.transferobjects.indi.GenericTheme;
import org.seamless_ip.services.transferobjects.indi.IndicatorGroup;
import org.seamless_ip.services.transferobjects.indi.ModelVariable;
import org.seamless_ip.services.transferobjects.indi.Subtheme;
import org.seamless_ip.services.transferobjects.indi.Theme;
import org.seamless_ip.services.transferobjects.livestock.AnimalProduct;
import org.seamless_ip.services.transferobjects.pica.InstitutionalCompatibility;
import org.seamless_ip.services.transferobjects.pica.PICAIndicatorGeneral;
import org.seamless_ip.services.transferobjects.pica.PICAIndicatorValue;
import org.seamless_ip.services.transferobjects.pica.PICASpatialLevel;
import org.seamless_ip.services.transferobjects.pica.PICAassessment;
import org.seamless_ip.services.transferobjects.pica.PicaIndicator;
import org.seamless_ip.services.transferobjects.pica.PolicyType;
import org.seamless_ip.services.transferobjects.pica.PropertyRightsChanges;
import org.seamless_ip.services.transferobjects.prodent.NutrientManagement;
import org.seamless_ip.services.transferobjects.seamproj.ApplicationRole;
import org.seamless_ip.services.transferobjects.seamproj.Model;
import org.seamless_ip.services.transferobjects.seamproj.ModelChain;
import org.seamless_ip.services.transferobjects.seamproj.NarrativeOption;
import org.seamless_ip.services.transferobjects.seamproj.Permission;
import org.seamless_ip.services.transferobjects.seamproj.Problem;
import org.seamless_ip.services.transferobjects.seamproj.Project;
import org.seamless_ip.services.transferobjects.seamproj.ProjectRole;
import org.seamless_ip.services.transferobjects.seamproj.SpatialScale;
import org.seamless_ip.services.transferobjects.seamproj.TemporalScale;
import org.seamless_ip.services.transferobjects.seamproj.User;
import org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten;

/**
 * Unfortunatly with the current version of Flex (3) for reflection to work
 * properly an instance of each class needed must be created first...
 *
 * Note: BlazeDS uses reflection...that means if blaze isn't able to
 * cast incoming object as the correct instance (but only as Object) means
 * that probably the class has to be added in the initialize() function
 */
public class FlexReflectionHelper
{
    //this function has to be called at the startup of the *.mxml application
    public static function initialize(): void
    {
        // PLEASE DO NOT REMOVE (INIT OF MANAGED REMOTING CLASSES):

        // projects and models
        new Project();
        new Problem();
        new Model();
        new ModelChain();
        new ModelVariable();
        new SpatialScale();
        new TemporalScale();

        // indicators and framework
        new EndorsedIndicator();
        new IndicatorGroup();
        new Dimension();
        new Domain();
        new GenericTheme();
        new Theme();
        new Subtheme();

        // users and permissions
        new User();
        new ProjectRole();
        new ApplicationRole();
        new Permission();
        new NarrativeOption();

        // regions
        new Country();
        new FADNregion();
        new NUTSregion();

        // prodent
        new NutrientManagement();
        new Crop();

        // farmopt
        new Tax();
        new SubsidyCrossCompliance();
        new Penalty();


        // capri
        new ActivityGroup();
        new BasicPremium();
        new BilateralTariff();
        new BiofuelDemand();
        new Country();
        new CountryAggregate();
        new DemandShift();
        new SupplyShift();
        new EnergyPrice();
        new ExchangeRates();
        new GlobalTariff();
        new InflationRate();
        new InputGroup();
        new Modulation();
        new PremiumGroup();
        new QuotaCountry();
        new SetAsideRegulation();
        new SubsidisedExport();
        new TradeReformProposal();
        new TradeReformProposalCut();
        new YieldGrowth();
        new CropProduct();
        new YieldTrend();
        new FarmConstraint();
        new AnimalProduct();


        // PICA
        new InstitutionalCompatibility();
        new PICAassessment();
        new PICAIndicatorGeneral();
        new PicaIndicator();
        new PICAIndicatorValue();
        new PICASpatialLevel();
        new PropertyRightsChanges();
        new PolicyType();

		
		
		//other...
		new EditedCodeNotOverwritten();
    }

}
}