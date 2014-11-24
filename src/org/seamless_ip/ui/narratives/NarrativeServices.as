/*
 * wallace: NarrativeServices.as
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
package org.seamless_ip.ui.narratives
{
import flash.utils.Dictionary;

import mx.collections.ArrayCollection;
import mx.collections.Sort;
import mx.collections.SortField;
import mx.rpc.AsyncToken;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.mxml.RemoteObject;

import org.seamless_ip.services.remoting.RemotingBaseServices;
import org.seamless_ip.services.transferobjects.seamproj.ContextNarrative;
import org.seamless_ip.services.transferobjects.seamproj.ExperimentNarrative;
import org.seamless_ip.services.transferobjects.seamproj.OutlookNarrative;
import org.seamless_ip.services.transferobjects.seamproj.PolicyOptionNarrative;
import org.seamless_ip.services.transferobjects.utils.IClonable;

/**
 * Class to read and edit narrative data linked to an experiment of a project
 */
public class NarrativeServices extends RemotingBaseServices
{
    public static var FINDALLOKMSG: String = "Experiment(s) narrative data received";
    public static var UPDATEOKMSG: String = "Experiment narrative updated";
    public static var CREATEOKMSG: String = "Experiment narrative created";
    public static var DELETEOKMSG: String = "Experiment deleted";
    public static var DELETEFULLOKMSG: String = "Experiment fully deleted";

    public static var FINDALLREQMSG: String = "loading Experiment narrative data";
    public static var UPDATEREQMSG: String = "updating Experiment narrative";
    public static var CREATEREQMSG: String = "Experiment creation request (this operation may take a while)";
    public static var DELETEREQMSG: String = "Experiment deletion request";
    public static var DELETEFULLREQMSG: String = "Experiment full deletion request (this operation may take a while)";


    //experiment deletion feedback messages
    private static var DELETE_FEEDBACK_EXCEPTION_MSG: String = "An unknow exception occours during the deletion, the Experiment can not be deleted";
    private static var DELETE_FEEDBACK_ONQUEUE_MSG: String = "The Experiment can not be deleted because it is in the queue for an execution";


    private const _channelName:String = "narrativeService";

    private var _itemscloned:Dictionary;

    [Bindable]
    private static var _outlookforcomposition: ArrayCollection;

    public function get outlookforcomposition():ArrayCollection
    {
        return _outlookforcomposition;
    }

    [Bindable]
    private static var _contextforcomposition: ArrayCollection;

    public function get contextforcomposition():ArrayCollection
    {
        return _contextforcomposition;
    }

    [Bindable]
    private static var _policyoptionforcomposition: ArrayCollection;

    public function get policyoptionforcomposition():ArrayCollection
    {
        return _policyoptionforcomposition;
    }


    public function NarrativeServices() {
        super();
        _itemscloned = new Dictionary();

        //static...load only once!!!
        if (_outlookforcomposition == null) {
            _outlookforcomposition = new ArrayCollection();
            _contextforcomposition = new ArrayCollection();
            _policyoptionforcomposition = new ArrayCollection();
            getDatasForComposition();
        }
    }


    public function findAll(problemid:Number):void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "findAll", findAllResultHandler);
        var token:AsyncToken = ro.findAll(problemid);
        token.id = problemid;
        dispatchRequestSendEvent(token, FINDALLREQMSG);
    }


    public function update(value:ExperimentNarrative):void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "update", updateResultHandler);
        var token:AsyncToken = ro.update(value, null);
        dispatchRequestSendEvent(token, UPDATEREQMSG);
    }

    public function createExperiment(problemid:Number):void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "createExperiment", createExperimentResultHandler);
        var token:AsyncToken = ro.createExperiment(problemid);
        dispatchRequestSendEvent(token, CREATEREQMSG);
    }

    public function createByCompositionExperiment(experiment_title:String, experiment_description:String, problemid:Number, contextid:Number, outlookid:Number, policyoptionid:Number):void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "createExperiment", createExperimentResultHandler);
        var token:AsyncToken = ro.createExperiment(experiment_title, experiment_description, problemid, contextid, outlookid, policyoptionid);
        dispatchRequestSendEvent(token, CREATEREQMSG);
    }

    /* public function deleteExperiment(experimentid:Number):void
     *
     *
     * This function delete only record from tables:
     *   experiment,
     *   experimentplantwoexperiments,
     *   experimentqueueexperimentruns,
     *   experimentrun
     *   policyassessmentfssimfarmindicators
     *   policyassessment
     *   biophysicalsimulation
     * is fast and user will attend the callback (a progress bar is showed)
     */
    public function deleteExperiment(experimentid:Number):void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "deleteExperiment", deleteExperimentResultHandler);
        var token:AsyncToken = ro.deleteExperiment(experimentid);
        dispatchRequestSendEvent(token, DELETEREQMSG);
    }

    /* public function deleteExperimentFull(context_id: Number,
     *                                       outlook_id: Number,
     *                                       policyoption_id: Number):void
     *
     *
     * This function delete all record linked to an experiment.
     * TO BE CALLED AFTER deleteExperiment
     *
     */
    public function deleteExperimentFull(context_id: Number,
                                         outlook_id: Number,
                                         policyoption_id: Number):void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "deleteExperimentFull", deleteExperimentFullResultHandler);
        var token:AsyncToken = ro.deleteExperimentFull(context_id, outlook_id, policyoption_id);
    }

    private function getDatasForComposition():void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "getDatasForComposition", getDatasForCompositionResultHandler);
        var token:AsyncToken = ro.getDatasForComposition();
    }


    [Bindable]
    public function get experiments():ArrayCollection
    {
        return _items;
    }

    public function set experiments(value: ArrayCollection):void
    {
        _items = value
    }

    public function restoreValues(exptorestore:ExperimentNarrative):void
    {
        _items.setItemAt(_itemscloned[exptorestore.id], _items.getItemIndex(exptorestore));
        _itemscloned[exptorestore.id] = ((ExperimentNarrative)(_itemscloned[exptorestore.id])).Clone();
    }


    private function findAllResultHandler(event:ResultEvent):void {
    	experiments.removeAll();
        if (event.result != null) {
            for each(var item:ExperimentNarrative in event.result) {
                experiments.addItem(item);
                _itemscloned[item.id] = (IClonable)(item).Clone();
            }
	        var titleSortField:SortField = new SortField("title", true, false, false);
	        var titleSort:Sort = new Sort();
	        titleSort.fields = [titleSortField];
	        experiments.sort = titleSort;
	        experiments.refresh();
        }
        dispatchRequestCompletedEvent(null, 1, FINDALLOKMSG);
    }


    private function updateResultHandler(event:ResultEvent):void {
        var item:ExperimentNarrative = (ExperimentNarrative)(event.result);
        _itemscloned[item.id] = ((ExperimentNarrative)(_itemscloned[item.id])).Clone();
        dispatchRequestCompletedEvent(null, 1, UPDATEOKMSG);
    }


    private function createExperimentResultHandler(event:ResultEvent):void {
        var item:ExperimentNarrative = (ExperimentNarrative)(event.result);
        experiments.addItem(item);
        _itemscloned[item.id] = item;

        var args:NarrativeServiceArgs = new NarrativeServiceArgs(CREATEOKMSG, item);

        //reload data for Experiment Composition dialog!
        getDatasForComposition();

        dispatchRequestCompletedEvent(args, 1, CREATEOKMSG);
    }

    private function deleteExperimentResultHandler(event:ResultEvent):void
    {
        var result:Number = (Number)(event.result);

        //result = -1 : exception during deletion
        //
        //result < -1 : experiment not deletable
        //	result = -2 : the experiment is in the queue for execution
        //
        //result > 0 : experiment successfully deleted (result is the id of the deleted experiment)
        var args : NarrativeServiceArgs = new NarrativeServiceArgs(DELETEOKMSG, null, result);

        if (result == -1)
            args.Callfeedbackdescr = DELETE_FEEDBACK_EXCEPTION_MSG;
        else if (result == -2)
            args.Callfeedbackdescr = DELETE_FEEDBACK_ONQUEUE_MSG;

        for each(var item:ExperimentNarrative in _items)
        {
            if (item.id == result.toString())
            {
                //now I can call the full deletion rutine...this will take lot of time
                //and is executed on the server
                deleteExperimentFull((Number)(item.biophysicalSimulation.context.id),
                        (Number)(item.biophysicalSimulation.outlook.id),
                        (Number)(item.policyAssessment.policyOption.id));
                //we can consider the experiment as deleted!
                _items.removeItemAt(_items.getItemIndex(item));
                break;
            }
        }

        //reload data for Experiment Composition dialog!
        getDatasForComposition();

        dispatchRequestCompletedEvent(args, 1, DELETEOKMSG);
    }

    private function deleteExperimentFullResultHandler(event:ResultEvent):void
    {
        var result:Number = (Number)(event.result);


        if (result == -1)
            trace("exception during the deletion process");
        else
            trace("experiment successfully fully deleted");
    }


    private function getDatasForCompositionResultHandler(event:ResultEvent):void {
        var result:ArrayCollection = (ArrayCollection)(event.result);
        _policyoptionforcomposition.removeAll();
        _contextforcomposition.removeAll();
        _outlookforcomposition.removeAll();
        
        for each (var item:Object in result) {
            if (item is OutlookNarrative)
                _outlookforcomposition.addItem(item);
            else if (item is ContextNarrative)
                _contextforcomposition.addItem(item);
            else if (item is PolicyOptionNarrative)
                _policyoptionforcomposition.addItem(item);
        }

		// sort the collections by narrative title        
        var narrativeSortField:SortField = new SortField("narrative.title", true, false, false);
        var narrativeTitleSort:Sort = new Sort();
        narrativeTitleSort.fields = [narrativeSortField];
        _outlookforcomposition.sort = narrativeTitleSort;
        _outlookforcomposition.refresh();
        _contextforcomposition.sort = narrativeTitleSort;
        _contextforcomposition.refresh();
        _policyoptionforcomposition.sort = narrativeTitleSort;
        _policyoptionforcomposition.refresh();
    }
}
}
