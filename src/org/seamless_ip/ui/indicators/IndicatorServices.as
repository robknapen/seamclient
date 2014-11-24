/*
 * wallace: IndicatorServices.as
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
//import flash.utils.Dictionary;

import flash.utils.Dictionary;

import mx.collections.ArrayCollection;
import mx.rpc.AsyncToken;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.mxml.RemoteObject;

import org.seamless_ip.services.remoting.RemotingBaseServices;

/**
 * Class that supports the reading (only) of data from the server by use of
 * the IndicatorDao. This class is specialised for reading indicator data.
 */
public class IndicatorServices extends RemotingBaseServices
{
    //this map will contains a list for each entity that can be managed by Enum
    private var _datamap:Dictionary;
    private const _channelName:String = "indicatorService";


    /**
     * Constructor, creates a new instance.
     */
    public function IndicatorServices() {
        super();
        _datamap = new Dictionary();
    }


    /**
     * Updates the service for the specified indicator class. This will
     * start a download of the indicator data from the server.
     *
     * @param className of indicator to retrieve
     */
    public function updateForIndicatorClass(className:IndicatorClassName):void {
        // load the data only once
        if (_datamap[className.value] == null) {
            _datamap[className.value] = new Object();
            var ro:RemoteObject;
            ro = createDataRequest(_channelName, "findAll", findAllResultHandler);
            var token:AsyncToken = ro.findAll(className.value);
            token.className = className;
            dispatchRequestSendEvent(token, "loading " + className.caption + " data");
        }
    }


    /**
     * Returns the instances of the indicator class with the
     * specified className, if available.
     *
     * @param className of indicator type to get instances for
     * @return collection of instances
     */
    public function getIndicatorClassInstances(className:IndicatorClassName):ArrayCollection {
        if (_datamap[className.value] == null)
            return new ArrayCollection();
        else
            return _datamap[className.value];
    }


    /**
     * Returns a list of all indicator instances.
     */
    public function getAllIndicatorClassInstances():ArrayCollection {
        var result:ArrayCollection = new ArrayCollection();

        for each (var className:IndicatorClassName in IndicatorClassName.values) {
            var subset:ArrayCollection = getIndicatorClassInstances(className);
            for each (var item:Object in subset)
                result.addItem(item);
        }
        return result;
    }


    /**
     * Checks if the internal storage contains an indicator class with
     * the specified className.
     *
     * @param className of indicator class to check
     * @return True if the indicator class is available
     */
    public function containsIndicatorClass(className:IndicatorClassName):Boolean {
        return _datamap[className.value] != null;
    }


    /**
     * Removes all items from the interal storage.
     */
    public function clear():void {
        _items.removeAll();
    }


    /**
     * Removes the indicator class with the specified className from
     * the internal storage (not from the server!).
     *
     * @param className of indicator to delete (locally)
     */
    public function removeIndicatorClass(className:IndicatorClassName):void {
        delete _datamap[className.value]; //removes the key
    }


    /**
     * Handles the result from the findAll remote method call.
     */
    public function findAllResultHandler(event:ResultEvent):void {
        _datamap[event.token.className.value] = event.result; // the result is an ArrayCollection of IIndicator
        dispatchRequestCompletedEvent(event.token.className.caption, 1, " indicator data received");
    }
}
}