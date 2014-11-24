/*
 * wallace: IndicatorValues.as
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
package org.seamless_ip.ui.seampress
{
//import flash.utils.Dictionary;

import flash.utils.Dictionary;

import mx.collections.ArrayCollection;
import mx.collections.Sort;
import mx.controls.Alert;
import mx.formatters.NumberBaseRoundType;
import mx.formatters.NumberFormatter;
import mx.utils.StringUtil;

/**
 * Class to store calculated values for indicators, per experiment. Can also
 * build dataproviders of the data for use in visualising the data.
 *
 * @author Rob Knapen
 */
public class IndicatorValues
{
    /**
     * Kinds of titles to be retrieved.
     */
    public static const EXPERIMENT_TITLE:int = 0;
    public static const INDICATOR_TITLE:int = 1;

    /**
     * Default number of digits used when formatting numerical values.
     */
    private const DEFAULT_PRECISION:int = 2;


    /**
     * Format strings to create dictionary keys.
     */
    private const _valuesKeyFormat:String = "exp{0}:ind{1}";
    private const _experimentKeyFormat:String = "exp{0}";
    private const _indicatorKeyFormat:String = "ind{0}";


    /**
     * Dictionary used to store indicator values retrieved from the server.
     */
    private var _datamap:Dictionary = new Dictionary();


    /**
     * Dictionary used to store titles of experiments and indicators.
     */
    private var _titlesmap:Dictionary = new Dictionary();


    /**
     * Formatter used internally to format values.
     */
    private var _formatter:NumberFormatter = new NumberFormatter();


    /**
     * Creates a dictionary key based on the specified ids for experiment
     * and indicator. The key is used to store indicator values in the
     * internal dictionary.
     *
     * @param experimentId to include in key
     * @param indicatorId to include in key
     * @return key based on experimentId and indicatorId
     */
    private function createValuesKey(experimentId:String, indicatorId:String):String {
        return StringUtil.substitute(_valuesKeyFormat, experimentId, indicatorId);
    }


    private function createTitlesKey(titleType:int, id:String):String {
        switch (titleType) {
            case EXPERIMENT_TITLE:
                return StringUtil.substitute(_experimentKeyFormat, id);
            case INDICATOR_TITLE:
                return StringUtil.substitute(_indicatorKeyFormat, id);
        }
        return null;
    }


    /**
     * Stores the values in the internal dictionary, with a key based on
     * the specified experiment and indicator information.
     *
     * @param experimentId to include in key
     * @param experimentTitle to store for experiment
     * @param indicatorId to include in key
     * @param indicatorTitle to store for indicator
     * @param values to store
     */
    public function storeValues(experimentId:String, experimentTitle:String,
                                indicatorId:String, indicatorTitle:String, values:ArrayCollection
            ):void {
        // store the values
        _datamap[createValuesKey(experimentId, indicatorId)] = values;
        // store the titles of experiment and indicator
        _titlesmap[createTitlesKey(EXPERIMENT_TITLE, experimentId)] = experimentTitle;
        _titlesmap[createTitlesKey(INDICATOR_TITLE, indicatorId)] = indicatorTitle;
    }


    /**
     * Retrieves values from the internal dictionary, for the specified
     * experiment and indicator ids.
     *
     * @param experimentId to retrieve values for
     * @param indicatorId to retrieve values for
     * @return values, zero length when no match found
     */
    public function retrieveValues(experimentId:String, indicatorId:String):ArrayCollection {
        var key:String = createValuesKey(experimentId, indicatorId);
        if (_datamap[key] == null)
            return new ArrayCollection();
        else
            return _datamap[key];
    }


    /**
     * Retrieves a single value from the internal dictionary, for the
     * specified experiment and indicator ids, and the given properties
     * hashcode.
     *
     * @param experimentId to retrieve value for
     * @param indicatorId to retrieve value for
     * @param hashCode (of properties) to retrieve value for
     * @return value, null when no match found
     */
    public function retrieveValue(experimentId:String, indicatorId:String, hashCode:String):Object {
        var values:ArrayCollection = retrieveValues(experimentId, indicatorId);
        for each (var value:Object in values) {
            if (value.hashCode == hashCode) {
                return value;
            }
        }
        return null;
    }


    public function containsTitle(titleType:int, id:String):Boolean {
        return (retrieveTitle(titleType, id) != null);
    }


    public function retrieveTitle(titleType:int, id:String):String {
        switch (titleType) {
            case EXPERIMENT_TITLE:
                return _titlesmap[StringUtil.substitute(_experimentKeyFormat, id)];
            case INDICATOR_TITLE:
                return _titlesmap[StringUtil.substitute(_indicatorKeyFormat, id)];
        }
        return null;
    }


    /**
     * Checks if the internal dictionary contains values for the specified
     * experiment and indicator ids.
     *
     * @param experimentId to check for
     * @param indicatorId to check for
     * @return true when values are available
     */
    public function containsValues(experimentId:String, indicatorId:String):Boolean {
        return _datamap[createValuesKey(experimentId, indicatorId)] != null;
    }


    /**
     * Erases all data stored in the internal dictionaries.
     */
    public function clear():void {
        _datamap = new Dictionary();
        _titlesmap = new Dictionary();
    }


    /**
     * Removes the values for the specified experiment and indicator ids
     * from the internal dictionary.
     *
     * @param experimentId to remove values for
     * @param indicatorId to remove values for
     */
    public function removeValues(experimentId:String, indicatorId:String):void {
        delete _datamap[createValuesKey(experimentId, indicatorId)];
        // TODO check all dictionary keys and remove unused experiment and indicator titles
    }


    /**
     * Checks if the specified key should be considered as an internal
     * property, i.e. a field that only has internal meaning and not to
     * the user, unless it is for debugging purposes.
     *
     * @param key to check
     * @return true if the key is for an internal property
     */
    public function isInternalProperty(key:String):Boolean {
        if (key == "mx_internal_uid")
            return true;
        if (key == "hashCode")
            return true;
        if (key == "baselineExperimentId")
            return true;
        if (key.indexOf(":Id") >= 0)
            return true;
        if (key.indexOf(":MapFeatureId") >= 0)
            return true;

        return false;
    }


    /**
     * Creates a collection of values for use as a data provider to Flex
     * components like a OLAP/advanced datagrid or a columnchart.
     *
     * This function builds flat data consisting of a collection of
     * objects that have properties for Indicator, IndicatorValue
     * properties and values of all selected experiments. Like:
     * { Indicator:"<title>",
     *   [<properties>]*, [<experimentTitle>:"<value>"]* }
     *
     * @param experimentIds of values to include in the result
     * @param indicatorIds of values to include in the result
     * @param includeInternalProperties false to remove internal fields
     * @return values according to specified settings
     */
    public function createFlatDataProvider(
            experimentIds:ArrayCollection,
            indicatorIds:ArrayCollection,
            valueType:ValueType,
            includeInternalProperties:Boolean = false,
            filterOnHashCode:String = null,
            precision:int = DEFAULT_PRECISION
            ):ArrayCollection
    {
        // TODO functionality overlaps with the createDataProvider() method
        // probably need to remove one of them

        var result:ArrayCollection = new ArrayCollection();
        var values:ArrayCollection;
        var item:Object;
        var found:Boolean;
        var expTitle:String;
        var indTitle:String;

        _formatter.precision = precision;
        _formatter.useThousandsSeparator = false;
        _formatter.rounding = NumberBaseRoundType.NEAREST;

        for each (var expId:String in experimentIds) {
            expTitle = retrieveTitle(EXPERIMENT_TITLE, expId);
            for each (var indId:String in indicatorIds) {
                indTitle = retrieveTitle(INDICATOR_TITLE, indId);
                values = retrieveValues(expId, indId);
                for each (var value:Object in values) {
                    if ((filterOnHashCode != null) && (filterOnHashCode != value.hashCode))
                        continue;

                    // check if there is already an object for same indicator and hashcode
                    found = false;
                    for each (var resultItem:Object in result) {
                        if ((resultItem["Indicator"] == indTitle) && (resultItem.hashCode == value.hashCode)) {
                            found = true;
                            item = resultItem;
                        }
                    }
                    // if not found create a new result item
                    if (!found) {
                        item = new Object();
                        // set the indicator title
                        item.label = indTitle;
                        item["Indicator"] = indTitle;
                        // copy other properties
                        for (var key:String in value)
                            if ((key != "value") && (includeInternalProperties || !isInternalProperty(key)))
                                item[key] = value[key];
                        result.addItem(item);
                    }
                    // calculate value (relative to baseline or absolute)
                    var baselineValue:Object = retrieveValue(value.baselineExperimentId, indId, value.hashCode);
                    var calculatedValue:Number = NaN;
                    switch (valueType) {
                        case ValueType.ABSOLUTE_VALUES:
                            calculatedValue = value.value;
                            break;
                        case ValueType.RELATIVE_VALUES:
                            if ((baselineValue != null) && (!isNaN(baselineValue.value)))
                                calculatedValue = value.value - baselineValue.value;
                            break;
                        case ValueType.RELATIVE_PERCENTAGES:
                            if ((baselineValue != null) && (!isNaN(baselineValue.value)))
                                calculatedValue = (value.value - baselineValue.value) / baselineValue.value * 100;
                            break;
                    }

                    if (!isNaN(calculatedValue)) {
                        item[expTitle] = new Number(_formatter.format(calculatedValue));
                    } else {
                        item[expTitle] = "Not available";
                    }
                }
            }
        }
        return result;
    }


    /**
     * Creates a collection of values for use as a data provider to Flex
     * components like a OLAP/advanced datagrid or a columnchart.
     *
     * This function creates hierarchical objects based on the properties
     * hashcode, with child objects for each experiment. The experiment
     * object has the corresponding values for all indicators. Titles of
     * experiments and indicators are used as names of the fields.
     *
     * @param experimentIds of values to include in the result
     * @param indicatorIds of values to include in the result
     * @param valueType of outputs to return (e.g. absolute, relative)
     * @param includeInternalProperties false to remove internal fields
     * @return values according to specified settings
     */
    public function createHierarchicalDataProvider(
            experimentIds:ArrayCollection,
            indicatorIds:ArrayCollection,
            valueType:ValueType,
            includeInternalProperties:Boolean = false,
            precision:int = DEFAULT_PRECISION
            ):ArrayCollection
    {
        var result:ArrayCollection = new ArrayCollection();
        var values:ArrayCollection;
        var newItem:Object;
        var indiTitle:String;

        _formatter.precision = precision;
        _formatter.useThousandsSeparator = false;
        _formatter.rounding = NumberBaseRoundType.NEAREST;

        // use the hashcodes to construct the top level objects
        var hashcodes:Dictionary = createHashCodeInfo(experimentIds, indicatorIds);
        for (var hashcode:* in hashcodes) {
            newItem = new Object();
            // copy all hashcode info fields (e.g. label, Farm.Id, Farm.Description, etc.)
            for (var key:String in hashcodes[hashcode]) {
                newItem[key] = hashcodes[hashcode][key];
            }
            // for each experiment add a second level object
            for each (var expId:String in experimentIds) {
                var calculatedValue:Number;
                var percentage:Number;
                var baselineValue:Object = null;
                var found:Boolean = false;
                var duplicatesReported:Boolean = false;

                var expItem:Object = new Object();
                expItem["label"] = retrieveTitle(EXPERIMENT_TITLE, expId);

                // store indicator values for this experiment
                for each (var indId:String in indicatorIds) {
                    values = retrieveValues(expId, indId);
                    for each (var value:Object in values) {
                        if (value.hashCode == hashcode) {
                            // calculate value (relative to baseline or absolute)
                            baselineValue = retrieveValue(value.baselineExperimentId, indId, value.hashCode);
                            calculatedValue = NaN;
                            switch (valueType) {
                                case ValueType.ABSOLUTE_VALUES:
                                    calculatedValue = value.value;
                                    break;
                                case ValueType.RELATIVE_VALUES:
                                    if ((baselineValue != null) && (!isNaN(baselineValue.value)))
                                        calculatedValue = value.value - baselineValue.value;
                                    break;
                                case ValueType.RELATIVE_PERCENTAGES:
                                    if ((baselineValue != null) && (!isNaN(baselineValue.value)))
                                        calculatedValue = (value.value - baselineValue.value) / baselineValue.value * 100;
                                    break;
                            }

                            if (!isNaN(calculatedValue)) {
                                expItem[retrieveTitle(INDICATOR_TITLE, indId)] = new Number(_formatter.format(calculatedValue));
                            } else {
                                expItem[retrieveTitle(INDICATOR_TITLE, indId)] = "Not available";
                            }
                            break;
                        }
                    }
                }
                // add experiment data
                var expTitle:String = retrieveTitle(EXPERIMENT_TITLE, expId);
                newItem[expTitle] = expItem;
            }
            result.addItem(newItem);
        }

        return result;
    }


    public function getTitles(titleType:int, ids:ArrayCollection):ArrayCollection {
        var result:ArrayCollection = new ArrayCollection();
        var obj:Object;
        for each (var id:String in ids) {
            obj = new Object();
            obj.id = id;
            obj.label = retrieveTitle(titleType, id);
            result.addItem(obj);
        }

        result.sort = new Sort();
        result.refresh();

        return result;
    }


    /**
     * Gets a list of all properties that are shared by the values objects
     * for the specified experiments and indicators. Assumes that all
     * value objects for one experiment - indicator combination have the
     * same properties, so only checks the first object.
     */
    public function getSharedProperties(experimentIds:ArrayCollection, indicatorIds:ArrayCollection,
                                        includeInternalProperties:Boolean = false
            ):ArrayCollection {
        var result:ArrayCollection = new ArrayCollection();
        var values:ArrayCollection;
        var value:Object;

        for each (var expId:String in experimentIds) {
            for each (var indId:String in indicatorIds) {
                values = retrieveValues(expId, indId);
                if (values.length > 0) {
                    value = values[0];
                    for (var key:String in value)
                        if ((key != "value") && (includeInternalProperties || !isInternalProperty(key))) {
                            if (!result.contains(key))
                                result.addItem(key);
                        }
                }
            }
        }
        return result;
    }


    /**
     * Creates a collection of values for use as a data provider to Flex
     * components like a datagrid or a columnchart.
     *
     * Based on the mergeData setting the value objects will either have
     * a property for each experiment with the IndicatorValue Number, or,
     * when not merged, there will be a value property with the Number and
     * records for all the experiments.
     *
     * @param experimentIds of values to include in the result
     * @param indicatorId of values to include in the result
     * @param valueType of outputs to return (e.g. absolute, relative)
     * @param mergeData true to merge experiments into columns
     * @param includeInternalProperties false to remove internal fields
     * @return values according to specified settings
     */
    public function createDataProvider(
            experimentIds:ArrayCollection,
            indicatorId:String,
            valueType:ValueType,
            mergeData:Boolean = false,
            includeInternalProperties:Boolean = false,
            precision:int = DEFAULT_PRECISION
            ):ArrayCollection {

        var result:ArrayCollection = new ArrayCollection();

        _formatter.precision = precision;
        _formatter.useThousandsSeparator = false;
        _formatter.rounding = NumberBaseRoundType.NEAREST;

        var duplicatesReported:Boolean = false;
        var differentBaselinesReported:Boolean = false;
        var baselineId:String = null;
        var baselineKey:String = null;

        for each (var expId:String in experimentIds) {
            var calculatedValue:Number;
            var percentage:Number;
            var baselineValue:Object = null;
            var found:Boolean = false;

            var values:ArrayCollection = retrieveValues(expId, indicatorId);
            var experimentKey:String = retrieveTitle(EXPERIMENT_TITLE, expId);

            for each (var value:Object in values) {

                // all requested experiments should refer to the same baseline experiment
                if (!value.hasOwnProperty("baselineExperimentId")) {
                    baselineValue = null;
                } else {
                    if (baselineId == null) {
                        baselineId = value["baselineExperimentId"];
                        baselineKey = retrieveTitle(EXPERIMENT_TITLE, baselineId);
                    } else {
                        if ((baselineId != value["baselineExperimentId"]) && (!differentBaselinesReported)) {
                            // ohoh different baselines used
                            Alert.show(
                                    "Selected experiments use different baselines! " +
                                    "Please verify indicator value records for " +
                                    "experiment with id=" + expId + " " +
                                    "and indicator with id=" + indicatorId + ". " +
                                    "Results will be shown but might not be correct!"
                                    ,
                                    "Invalid experiments"
                                    );
                            duplicatesReported = true;
                        }
                    }
                    baselineValue = retrieveValue(value.baselineExperimentId, indicatorId, value.hashCode);
                }

                // calculate value (relative to baseline or absolute)
                calculatedValue = NaN;
                switch (valueType) {
                    case ValueType.ABSOLUTE_VALUES:
                        calculatedValue = value.value;
                        break;
                    case ValueType.RELATIVE_VALUES:
                        if ((baselineValue != null) && (!isNaN(baselineValue.value)))
                            calculatedValue = value.value - baselineValue.value;
                        break;
                    case ValueType.RELATIVE_PERCENTAGES:
                        if ((baselineValue != null) && (!isNaN(baselineValue.value)))
                            calculatedValue = (value.value - baselineValue.value) / baselineValue.value * 100;
                        break;
                }

                if (mergeData) {
                    found = false;
                    for each (var item:Object in result) {
                        if (item.hashCode == value.hashCode) {
                            // detect duplicate values in the database, report only once
                            if ((item.hasOwnProperty(experimentKey)) && (!duplicatesReported)) {
                                Alert.show(
                                        "Invalid database content detected! " +
                                        "Please verify duplicate indicator value records for " +
                                        "experiment with id=" + expId + " " +
                                        "and indicator with id=" + indicatorId + ". " +
                                        "Results will be shown but might not be correct!"
                                        ,
                                        "Invalid database"
                                        );
                                duplicatesReported = true;
                            }

                            if (!isNaN(calculatedValue)) {
                                item[experimentKey] = new Number(_formatter.format(calculatedValue));
                            } else {
                                item[experimentKey] = "Not available";
                            }
                            found = true;
                            break;
                        }
                    }
                }

                // when not found create a new object
                if (!found) {
                    var newItem:Object = new Object();

                    for (var key:String in value)
                        if (key != "value")
                            newItem[key] = value[key];

                    if (baselineValue != null) {
                        newItem[baselineKey] = new Number(_formatter.format(baselineValue.value));
                    } else {
                        newItem[baselineKey] = "Not in database";
                    }

                    if (mergeData) {
                        newItem[experimentKey] = new Number(_formatter.format(calculatedValue));
                    }
                    else {
                        newItem["Experiment"] = retrieveTitle(EXPERIMENT_TITLE, expId);
                        if (!isNaN(calculatedValue)) {
                            newItem["Calculated"] = new Number(_formatter.format(calculatedValue));
                        } else {
                            newItem["Calculated"] = "Not available";
                        }
                    }

                    result.addItem(newItem);
                }
            }
        }

        // assure that each value object has properties for every experiment
        if (mergeData)
            result = ensureExperimentProperties(result, experimentIds);

        // remove some properties that are more for debugging and internal use
        if (!includeInternalProperties)
            result = createFilteredData(result);

        return result;
    }


    /**
     * Ensures that all objects in the items collection have a property
     * for all the experimentIds. This is needed when merging data where
     * not all experiments have been calculated for the same options. I.e.
     * uneven datasets that would not display correctly.
     *
     * @param items to process
     * @param experimentIds to ensure
     * @return new collection with updated items
     */
    private function ensureExperimentProperties(items:ArrayCollection, experimentIds:ArrayCollection):ArrayCollection {
        var result:ArrayCollection = new ArrayCollection();
        var newItem:Object;
        var experimentKey:String;

        for each (var item:Object in items) {
            newItem = new Object();
            // copy all properties
            for (var key:String in item)
                newItem[key] = item[key];

            // verify experiment properties
            for each (var expId:String in experimentIds) {
                experimentKey = retrieveTitle(EXPERIMENT_TITLE, expId);
                if (!newItem.hasOwnProperty(experimentKey))
                    newItem[experimentKey] = null;
            }

            result.addItem(newItem);
        }
        return result;
    }


    /**
     * Creates a new collection based on the specified items by removing
     * all properties that based on the key should be considered an
     * internal field.
     *
     * @param items to remove internal properties from
     * @return new collection with updated items
     */
    private function createFilteredData(items:ArrayCollection):ArrayCollection {
        var result:ArrayCollection = new ArrayCollection();
        var newItem:Object;

        for each (var item:Object in items) {
            newItem = new Object();
            for (var key:String in item)
                if (!isInternalProperty(key))
                    newItem[key] = item[key];

            result.addItem(newItem);
        }

        return result;
    }


    /**
     * Creates a dictionary of hashcode information, for the specified
     * experiment and indicator ids. It retrieves the stored values for
     * these ids. Each value has additional properties and a hashcode.
     * For each unique hashcode (the dictionary key) an object will be
     * stored in the dictionary with the additional properties as fields.
     * it will also have a generated label added.
     *
     * @param experimentIds
     * @param indicatorIds
     * @return dictionary with hashcode info
     */
    public function createHashCodeInfo(experimentIds:ArrayCollection, indicatorIds:ArrayCollection):Dictionary
    {
        var result:Dictionary = new Dictionary();

        if ((experimentIds != null) && (indicatorIds != null))
        {
            for each (var expId:String in experimentIds)
            {
                for each (var indId:String in indicatorIds)
                {
                    var values:ArrayCollection = retrieveValues(expId, indId);
                    for each (var value:Object in values)
                    {
                        if (result[value.hashCode] == null)
                        {
                            // create object with info for value properties
                            var info:Object = new Object();
                            info.label = createPropertiesLabel(value);

                            for (var key:String in value)
                            {
                                if ((key != "value") && (key != "hashCode"))
                                    info[key] = value[key];
                            }

                            result[value.hashCode] = info;
                        }
                    }
                }
            }
        }

        return result;
    }


    /**
     * Creates a label based on all the properties in the specified item.
     * It expects property keys like "Crop:Name", "Crop:Id", "FarmType:Id",
     * etc. For each key that includes "name" (preferred) or "id" (both
     * checked case insensitive) a text will be appended to the result
     * based on the uppercase characters and the value. E.g. for
     * item["Crop:Id"] = 42 -> "Crop:42".
     *
     * @param item to create label for
     * @return String with the label
     */
    private function createPropertiesLabel(item:Object):String
    {
        var pos:int;
        var key:String;

        // try to use the Crop label first
        for (key in item) {
            pos = key.toLowerCase().indexOf("crop:label_en");
            if (pos >= 0)
                return item[key];
        }

        // try to use a name property
        for (key in item) {
            pos = key.toLowerCase().indexOf(":name");
            if (pos >= 0)
                return item[key];
        }

        // try id next
        for (key in item) {
            pos = key.toLowerCase().indexOf(":id");
            if (pos >= 0)
                return key.substr(0, pos) + ":" + item[key];
        }

        // last resort, try to return hashcode
        if (item.hasOwnProperty("hashCode"))
            return item["hashCode"];
        else
            return "Unlabeled";
    }

}
}