/*
 * wallace: ExperimentQueueThreadService.as
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
package org.seamless_ip.ui.processingcenter
{
import mx.collections.ArrayCollection;
import mx.rpc.AsyncToken;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.mxml.RemoteObject;

import org.seamless_ip.services.remoting.RemotingBaseServices;

/**
 * Class to manage the process on the server.
 */
public class ExperimentQueueThreadService extends RemotingBaseServices
{
    [Bindable]
    public static var CHECKMSG: String = "to check the state of the execution process on the server";
    [Bindable]
    public static var TURNONMSG: String = "to turn on execution process on the server";
    [Bindable]
    public static var TURNOFFMSG: String = "to turn off execution process on the server";
    [Bindable]
    public static var RESTARTMSG: String = "to restart execution process on the server";

    public static var CHECKOKMSG: String = "execution process state on the server successfully checked";
    public static var TURNONOKMSG: String = "execution process on the server successfully turned on";
    public static var TURNOFFOKMSG: String = "execution process on the server successfully turned off";
    public static var RESTARTOKMSG: String = "execution process on the server successfully restarted";

    public static var CHECKREQMSG: String = "checking current execution process state on the server";
    public static var TURNONREQMSG: String = "turning on execution process on the server";
    public static var TURNOFFREQMSG: String = "turning off execution process on the server";
    public static var RESTARTREQMSG: String = "restarting execution process on the server";

    public static var NOTSYNCMSG: String = "the client isn't synchronized with the server, please push the 'synchonize' button and try again";

    private const _channelName:String = "experimentQueueThreadService";

    /* private var _runningprocess: uint;
     *
     * if _runningprocess == 0 -> no process is running on the server
     * else _runningprocess has the java hashcode of the process running on the server
     */
    [Bindable]
    private var _runningprocess: Number;

    public function get runningprocess():Number
    {
        return _runningprocess;
    }

    [Bindable]
    private var _consoleoutput: ArrayCollection;

    public function get consoleoutput():ArrayCollection
    {
        return _consoleoutput;
    }


    public function ExperimentQueueThreadService()
    {
        super();
        _runningprocess = -1;
        _consoleoutput = new ArrayCollection();
    }

    public function check():void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "check", checkResultHandler);
        var token:AsyncToken = ro.check();

        dispatchRequestSendEvent(token, CHECKREQMSG);
    }

    public function start():void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "start", startResultHandler);
        var token:AsyncToken = ro.start();

        dispatchRequestSendEvent(token, TURNONREQMSG);
    }


    public function stop():void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "stop", stopResultHandler);
        var token:AsyncToken = ro.stop();

        dispatchRequestSendEvent(1, TURNOFFREQMSG);
    }

    public function restart():void
    {
        var ro:RemoteObject;
        ro = createDataRequest(_channelName, "restart", restartResultHandler);
        var token:AsyncToken = ro.restart();

        dispatchRequestSendEvent(1, RESTARTREQMSG);
    }

    public function startResultHandler(event:ResultEvent):void
    {
        if (isTheLogOfAnError((ArrayCollection)(event.result)))
            _runningprocess = -1;
        else
            _runningprocess = 1;

        _consoleoutput = (ArrayCollection)(event.result);

        dispatchRequestCompletedEvent(TURNONOKMSG, 1, TURNONOKMSG);
    }

    public function checkResultHandler(event:ResultEvent):void
    {
        var isrunning:Boolean = (Boolean)(event.result);

        if (isrunning)
            _runningprocess = 1;
        else
            _runningprocess = 0;

        if (_consoleoutput != null)
            _consoleoutput.removeAll();

        dispatchRequestCompletedEvent(CHECKOKMSG, 1, CHECKOKMSG);
    }

    public function stopResultHandler(event:ResultEvent):void
    {
        if (isTheLogOfAnError((ArrayCollection)(event.result)))
            _runningprocess = -1;
        else
            _runningprocess = 0;

        _consoleoutput = (ArrayCollection)(event.result);

        dispatchRequestCompletedEvent(TURNOFFOKMSG, 1, TURNOFFOKMSG);
    }

    public function restartResultHandler(event:ResultEvent):void
    {
        if (isTheLogOfAnError((ArrayCollection)(event.result)))
            _runningprocess = -1;
        else
            _runningprocess = 1;

        _consoleoutput = (ArrayCollection)(event.result);

        dispatchRequestCompletedEvent(RESTARTOKMSG, 1, RESTARTOKMSG);
    }

    private function isTheLogOfAnError(logs:ArrayCollection):Boolean
    {
        for each (var log: String in logs)
        {
            if (log.search("HELPMSG") != -1)
                return true;
        }
        return false;
    }
}
}