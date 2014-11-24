/*
 * wallace: CredentialsServices.as
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
package org.seamless_ip.ui.login
{
import mx.collections.ArrayCollection;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.mxml.RemoteObject;

import org.seamless_ip.services.remoting.RemotingBaseServices;
import org.seamless_ip.services.transferobjects.seamproj.User;

/**
 * Implementation for handling user authentication.
 */
public class CredentialsServices extends RemotingBaseServices
{
    private const _channelName:String = "userService";
    private const _authenticationMethodName:String = "findByAccountNameAndPassword";


    public function CredentialsServices()
    {
        _items.removeAll();
    }


    /**
     * Refreshes the list of available items. It returns an Asynchronous
     * Completion Token when the update is handled through a call to a
     * remote server. When it is handled locally the return value will be
     * NULL.
     *
     * @return Object The token for the request
     */
    public function authenticate(accountName:String, password:String):Object
    {
        var ro:RemoteObject = createDataRequest(_channelName, _authenticationMethodName, authenticationResultHandler);
        ro.findByAccountNameAndPassword(accountName, password);
        return ro;
    }


    private function authenticationResultHandler(event:ResultEvent):void
    {
        _items.removeAll();
        if (event.result is User)
            _items.addItem(event.result);

        dispatchRequestCompletedEvent(event.token, _items.length, " item(s) received");
    }


    /**
     * Gets the list of users. Since the list is filled by requesting
     * Users that match a given accountname and password combination from
     * the server it should be either empty, or contain a single User.
     */
    public function get users():ArrayCollection
    {
        return _items;
    }

}
}