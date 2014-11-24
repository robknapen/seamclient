/*
 * wallace: ApplicationInfoDialog.as
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
package org.seamless_ip.ui.about
{
import mx.containers.TitleWindow;
import mx.core.Application;
import mx.events.CloseEvent;
import mx.managers.PopUpManager;

/**
 * TitleWindow for showing application information like its name and
 * current version number.
 *
 * @author Rob Knapen
 */
public class ApplicationInfoDialog extends TitleWindow
{
    private const _versionPrefix:String = "Application version: ";
    private const _seamserverPrefix:String = "Using server at: ";

    private var _appName:String = "This Application";
    private var _appVersion:String = new Date().toDateString();
    private var _seamserverLocation:String = getServerUrl();


    /**
     * String containing customized version text.
     */
    [Bindable]
    public var versionText:String = _versionPrefix + _appVersion;

    /**
     * String with prefixed location (URL) of used seamserver
     */
    [Bindable]
    public var seamserverText:String = _seamserverPrefix + _seamserverLocation;


    /**
     * Creates an instance.
     */
    public function ApplicationInfoDialog()
    {
        super();
    }


    /**
     * Sets the name of the application to appear in the dialog.
     *
     * @param name of the application
     */
    public function set applicationName(name:String):void
    {
        if ((name != null) && (name.length > 0))
            _appName = name;
        title = "About " + _appName;
    }


    /**
     * Sets the version text to appear in the dialog.
     *
     * @param version of the application
     */
    public function set applicationVersion(version:String):void
    {
        if ((version != null) && (version.length > 0))
            _appVersion = version;

        versionText = _versionPrefix + _appVersion;
    }


    /**
     * Sets the location of used seamserver to appear in the dialog.
     *
     * @param location of the used seamserver
     */
    public function set seamserverLocation(location:String):void
    {
        if ((location != null) && (location.length > 0))
            _seamserverLocation = location;

        seamserverText = _seamserverPrefix + _seamserverLocation;
    }


    private function getServerUrl():String
    {
        var delimitedParts:Array = Application.application.url.split("/");
        return delimitedParts[0] + "//" + delimitedParts[2] + "/" + delimitedParts[3] + "/";
    }


    /**
     * Event handler that closes the popup.
     *
     * @param event CloseEvent
     */
    protected function closeMe(event:CloseEvent):void
    {
        PopUpManager.removePopUp(this);
    }

}
}