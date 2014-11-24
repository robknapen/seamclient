/*
 * wallace: NarrativeServiceArgs.as
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
import org.seamless_ip.services.transferobjects.seamproj.ExperimentNarrative;

/**
 * Class to manage parameter to be sent using dispatchRequestCompletedEvent in
 * class NarrativeService.
 */
public class NarrativeServiceArgs
{
    private var _calldescr: String;
    private var _experimentnarrative: ExperimentNarrative;
    private var _resultnumber: Number;
    private var _callfeedbackdescr: String;


    public function NarrativeServiceArgs(calldescr: String,
                                         experimentnarrative: ExperimentNarrative = null,
                                         resultnumber: Number = 0,
                                         callfeedbackdescr: String = "not assigned")
    {
        _calldescr = calldescr;
        _experimentnarrative = experimentnarrative;
        _resultnumber = resultnumber;
        _callfeedbackdescr = callfeedbackdescr;
    }


    public function get Calldescr(): String
    {
        return _calldescr;
    }

    public function get Experimentnarrative(): ExperimentNarrative
    {
        return _experimentnarrative;
    }

    public function get Resultnumber(): Number
    {
        return _resultnumber;
    }

    public function get Callfeedbackdescr(): String
    {
        return _callfeedbackdescr;
    }

    public function set Callfeedbackdescr(value :String): void
    {
        _callfeedbackdescr = value;
    }

}
}