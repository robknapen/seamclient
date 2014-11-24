/*
 * wallace: Configuration.as
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
package
{
import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

/**
 * General configuration settings for the S-IF User Interface.
 *
 * @author Lorenzo Ruinelli, Rob Knapen
 */
[Bindable]
public class Configuration {

    // default values
    private const APPLICATION_NAME:String = "SEAMLESS GUI";
    private const APPLICATION_VERSION:String = "DEVELOPMENT";
    private const APPLICATION_DATE:String = "(C) 2009";
    private const ERROR_REPORTING_URL:String = "http://dev.seamless-if.org/trac";
    private const ONTOLOGYBROWSER_URL:String = "http://delivered.seamless-ip.org:8060/browser/zul/main.zhtml";
    private const SAVEDZIP_URL:String = "http://dev.seamless-if.org/trac/experimentZip/";
    private const MANUAL_URL:String = "http://dev.seamless-ip.org/trac/trac.cgi/raw-attachment/wiki/HelpTopics/Manual%20SEAMLESS-IF.pdf";
    private const SEAMLESS_WEBSITE_URL:String = "http://www.seamless-if.org/";

    // variables with actual values
    public var applicationName:String = APPLICATION_DATE;
    public var applicationVersion:String = APPLICATION_VERSION;
    public var applicationDate:String = APPLICATION_DATE;
    public var errorReportingUrl:String = ERROR_REPORTING_URL;
    public var ontologyBrowserUrl:String = ONTOLOGYBROWSER_URL;
    public var savedZipUrl:String = SAVEDZIP_URL;
    public var manualUrl:String = MANUAL_URL;
    public var seamlessWebsiteUrl:String = SEAMLESS_WEBSITE_URL;


    /**
     * Overload default configuration values from the result contents of
     * the specified event (from reading of configuration.xml file).
     */
    public function init(event:ResultEvent):void {
        try {
            applicationName = event.result.applicationName;
            applicationVersion = event.result.applicationVersion;
            applicationDate = event.result.applicationDate;
            errorReportingUrl = event.result.errorReportingUrl;
            ontologyBrowserUrl = event.result.ontologyBrowserUrl;
            savedZipUrl = event.result.savedZipUrl;
            manualUrl = event.result.manualUrl;
            seamlessWebsiteUrl = event.result.seamlessWebsiteUrl;
        } catch (e:Error) {
            mx.controls.Alert.show("Warning: problem when reading configuration file, using default settings. Error: " + e);
        }
    }


    public function initDefault(event:FaultEvent):void {
        mx.controls.Alert.show("Warning: problem when reading configuration file, using default settings. Error: " + event.message);
        applicationName = APPLICATION_DATE;
        applicationVersion = APPLICATION_VERSION;
        applicationDate = APPLICATION_DATE;
        errorReportingUrl = ERROR_REPORTING_URL;
        ontologyBrowserUrl = ONTOLOGYBROWSER_URL;
        savedZipUrl = SAVEDZIP_URL;
        manualUrl = MANUAL_URL;
        seamlessWebsiteUrl = SEAMLESS_WEBSITE_URL;
    }
}
}