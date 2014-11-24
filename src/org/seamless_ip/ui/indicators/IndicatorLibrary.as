/*
 * wallace: IndicatorLibrary.as
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
package org.seamless_ip.ui.indicators
{
import flash.events.Event;

import mx.collections.ArrayCollection;

import org.seamless_ip.services.remoting.RequestProgressEvent;
import org.seamless_ip.services.transferobjects.indi.Dimension;
import org.seamless_ip.services.transferobjects.indi.Domain;
import org.seamless_ip.services.transferobjects.indi.EndorsedIndicator;
import org.seamless_ip.services.transferobjects.indi.IIndicator;
import org.seamless_ip.services.transferobjects.indi.Subtheme;
import org.seamless_ip.services.transferobjects.indi.Theme;
import org.seamless_ip.services.transferobjects.seamproj.Model;
import org.seamless_ip.ui.enums.EnumClassName;
import org.seamless_ip.ui.enums.EnumManager;

/**
 * An in memory representation of the indicator library (reflects the content
 * of the corresponding database table on the server). It contains all the
 * "official" indicators that can be selected for a project, and additional a
 * list of all model variables (known variables exchanged between models) that
 * can be selected as "extra" indicators.
 */
public class IndicatorLibrary
{
    /**
     * Initialisation progress flag. True while the enumeration data is
     * being retrieved from the server, false when it is done. Download
     * starts when the instance is created.
     *
     * Binding can be used to track the variable, like so:
     *     BindingUtils.bindSetter(updateInitializeState, enumManager, "initInProgress");
     */
    [Bindable]
    public var initInProgress:Boolean = true;


    /**
     * Initialisation progress message.
     *
     * Binding can be used to track the variable, like so:
     *     BindingUtils.bindSetter(updateProgressMessage, enumManager, "progressMessage");
     */
    [Bindable]
    public var progressMessage:String = "Loading Indicator Data";


    [Bindable]
    private var _enumManager:EnumManager;


    /**
     * Instance of IndicatorServices used to retrieve and keep in memory the
     * values of several indicator classes.
     */
    [Bindable]
    private var _indiSrv:IndicatorServices;


    /**
     * Creates an instance.
     */
    public function IndicatorLibrary() {
        super();
    }


    /**
     * Initialises the indicator library. Starts the download of the
     * required enumerations and the indicator list from the server.
     */
    public function init():void {
        initInProgress = true;

        // Get the singleton instance of the enum manager. If needed
        // this starts the download of the enumeration values.
        _enumManager = EnumManager.instance;

        // use IndicatorServices to get all types of indicators
        _indiSrv = new IndicatorServices();
        _indiSrv.clear();
        _indiSrv.registerForEvents(requestProgressEventHandler);

        for each (var name:IndicatorClassName in IndicatorClassName.values)
            _indiSrv.updateForIndicatorClass(name);
    }


    /**
     * Handles download progress messages from the server.
     */
    private function requestProgressEventHandler(event:RequestProgressEvent):void {
        progressMessage = event.message;
        dispatchEvent(new Event("propertyChanged"));

        if (event.type == RequestProgressEvent.REQUEST_COMPLETED) {
            var inProgress:Boolean = (_indiSrv.openRequests > 0);
            if (initInProgress != inProgress) {
                initInProgress = inProgress;
                dispatchEvent(new Event("propertyChanged"));
            }
        }
    }


    /**
     * Gets all values for an enumeration class. Can be applied to all
     * the classes used as category information for the indicators. Use
     * the enumeration constants (DOMAIN_ENUM, DIMENSION_ENUM, etc.
     *
     * @param enumName Name of enumeration class
     * @return ArrayCollection with IEnumValue instances
     */
    public function getEnumValues(enumName:EnumClassName):ArrayCollection {
        return _enumManager.getEnumValues(enumName);
    }


    /**
     * Returns the list with all indicators.
     *
     * @return ArrayCollection of Indicator instances
     */
    public function allIndicators():ArrayCollection {
        return _indiSrv.getAllIndicatorClassInstances();
    }


    /**
     * Returns the list with all indicators.
     *
     * @return ArrayCollection of EndorsedIndicatorModel instances
     */
    public function allEndorsedIndicators():ArrayCollection {
        return getModelClasses(IndicatorClassName.ENDORSED_INDICATOR);
    }


    /**
     * Returns the list with all model variables.
     *
     * @return ArrayCollection of ModelVariableModel instances
     */
    public function allModelVariables():ArrayCollection {
        return getModelClasses(IndicatorClassName.MODEL_VARIABLE);
    }


    /**
     * Returns the list with all items.
     *
     * @param className Specify one of the available values
     * @return ArrayCollection with IIndicator instances
     */
    public function getModelClasses(className:IndicatorClassName):ArrayCollection {
        return _indiSrv.getIndicatorClassInstances(className);
    }


    /**
     * Finds the indicator in the library that matches the specified
     * name.
     *
     * @param className Specify one of the available values
     * @param name String with name to search for
     * @return Indicator when found, otherwise null
     */
    public function findByName(className:IndicatorClassName, name:String):IIndicator {
        for each(var indi:IIndicator in getModelClasses(className)) {
            if (indi.getLabel_en() == name) {
                return indi;
            }
        }
        return null;
    }


    /**
     * Finds the indicator in the library that matches the specified
     * id.
     *
     * @param className Specify one of the available values
     * @param id String with id to search for
     * @return Indicator when found, otherwise null
     */
    public function findById(className:IndicatorClassName, id:String):IIndicator {
        for each(var indi:IIndicator in getModelClasses(className)) {
            if (indi.getId() == id) {
                return indi;
            }
        }
        return null;
    }


    /**
     * Finds the indicator in the library that matches all the specified
     * parameters.
     *
     * @param models ArrayCollection of Model instances
     * @param spatialExtentName String with name of spatial extent
     * @param spatialResolutionName String with name of spatial resolution
     * @param domainName String with name of domain
     * @param dimensionName String with name of dimension
     * @param genericThemeName String with name of generic theme
     * @param themeName String with name of theme
     * @param includeSelected Boolean, true to search the already
     *           selected indicators as well
     * @return ArrayCollection with the matching EndorsedIndicatorModel instances
     */
    public function findByModelsAndScaleAndCategory(
            models:ArrayCollection,
            spatialExtentName:String,
            spatialResolutionName:String,
            domainName:String,
            dimensionName:String,
            genericThemeName:String,
            themeName:String,
            includeSelected:Boolean = false
            ):ArrayCollection {

        var col:ArrayCollection = new ArrayCollection();

        for each (var indi:EndorsedIndicator in allEndorsedIndicators()) {
            if ((models == null) || matchesModels(indi, models)) {
                if (matches(
                        indi,
                        spatialExtentName,
                        spatialResolutionName,
                        domainName,
                        dimensionName,
                        genericThemeName,
                        themeName)) {
                    if ((!indi.getSelected()) || (includeSelected))
                        col.addItem(indi);
                }
            }
        }
        return col;
    }


    /**
     * Checks if the specified indicator matches the given spatial scale
     * and domain arguments.
     */
    public function matchesSpatialScaleAndDomain(
            indicator:EndorsedIndicator,
            spatialExtentName:String,
            spatialResolutionName:String,
            domainName:String):Boolean {

        var match:Boolean = ((spatialExtentName == "") || (indicator.spatialScale.extent == spatialExtentName)) &&
                            ((spatialResolutionName == "") || (indicator.spatialScale.resolution == spatialResolutionName));
        if (!match) return false;

        match = (domainName == "") || containsDomain(indicator, domainName);
        return match;
    }


    /**
     * Checks if the specified indicator belongs to the given domain
     * category.
     */
    private function containsDomain(indicator:EndorsedIndicator, domainName:String):Boolean {
        if ((indicator != null) && (domainName != null)) {
            for each (var domain:Domain in indicator.groupDomains)
                if (domain.label_en == domainName)
                    return true;
        }
        return false;
    }


    /**
     * Checks if the specified indicator belongs to the give dimension
     * category.
     */
    private function containsDimension(indicator:EndorsedIndicator, dimensionName:String):Boolean {
        if ((indicator != null) && (dimensionName != null)) {
            for each (var dimension:Dimension in indicator.groupDimensions)
                if (dimension.label_en == dimensionName)
                    return true;
        }
        return false;
    }


    /**
     * Checks if the specified indicator belongs to the given generic
     * theme and theme categories.
     */
    private function containsGenericThemeAndTheme(indicator:EndorsedIndicator, genericThemeName:String, themeName:String):Boolean {
        if (indicator != null) {
            for each (var subtheme:Subtheme in indicator.groupSubthemes) {
                var theme:Theme = subtheme.theme;
                if (
                        ((themeName == "") || (theme.label_en == themeName)) &&
                        ((genericThemeName == "") || (theme.genericTheme.label_en == genericThemeName))
                        )
                    return true;
            }
        }
        return false;
    }


    /**
     * Checks if the specified indicator matches all of the given
     * categories. Use an empty string for a category to allow all
     * values for it.
     */
    public function matches(
            indicator:EndorsedIndicator,
            spatialExtentName:String,
            spatialResolutionName:String,
            domainName:String,
            dimensionName:String,
            genericThemeName:String,
            themeName:String):Boolean {

        var match:Boolean = matchesSpatialScaleAndDomain(indicator, spatialExtentName, spatialResolutionName, domainName);
        if (!match) return false;

        match = (dimensionName == "") || containsDimension(indicator, dimensionName);
        if (!match) return false;

        match = containsGenericThemeAndTheme(indicator, genericThemeName, themeName);
        return match;
    }


    /**
     * Checks if the specified indicator matches one of the given models.
     * I.e. the indicator is calculated by that model.
     */
    public function matchesModels(indicator:IIndicator, models:ArrayCollection):Boolean {
        if (models != null) {
            for each (var model:Model in models) {
                if (indicator.getModel().id == model.id)
                    return true;
            }
        }
        return false;
    }


    /**
     * Checks if the specified indicator matches the given models and
     * spatial scale arguments. Use an empty string to allow all values
     * for spatial extent or resolution.
     */
    public function matchesModelsAndSpatialScale(
            indicator:IIndicator,
            models:ArrayCollection,
            spatialExtentName:String,
            spatialResolutionName:String):Boolean {

        var match:Boolean = matchesModels(indicator, models);
        if (!match) return false;

        match = ((spatialExtentName == "") || (indicator.getSpatialScale().extent == spatialExtentName)) &&
                ((spatialResolutionName == "") || (indicator.getSpatialScale().resolution == spatialResolutionName));

        return match;
    }


    /**
     * Returns the list of indicators that match the given models and
     * spatial scale arguments. Use an empty string to allow all values
     * for spatial extent or resolution. By default indicators that are
     * marked as selected are not included, unless the includeSelected
     * argument is set to true.
     */
    public function findByModelsAndScale(
            models:ArrayCollection,
            spatialExtentName:String,
            spatialResolutionName:String,
            includeSelected:Boolean = false
            ):ArrayCollection {

        var col:ArrayCollection = new ArrayCollection();

        for each (var indi:IIndicator in allIndicators()) {
            if (matchesModelsAndSpatialScale(indi, models, spatialExtentName, spatialResolutionName)) {
                if ((!indi.getSelected()) || (includeSelected))
                    col.addItem(indi);
            }
        }
        return col;
    }


    /**
     * Clears the selected state of all the items in the library.
     */
    public function clearSelection():void {
        var allIndicators:ArrayCollection = _indiSrv.getAllIndicatorClassInstances();
        for each (var item:IIndicator in allIndicators)
            item.setSelected(false);
    }

}
}