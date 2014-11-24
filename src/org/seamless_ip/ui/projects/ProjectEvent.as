/*
 * wallace: ProjectEvent.as
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
package org.seamless_ip.ui.projects
{
import flash.events.Event;

import org.seamless_ip.services.transferobjects.seamproj.Project;

/**
 * Event used by the project management components.
 *
 * @author Rob Knapen; Alterra, Wageningen UR
 */
public class ProjectEvent extends Event
{
    public static const PROJECT_OPENED:String = "projectOpened";
    public static const PROJECT_CLOSED:String = "projectClosed";
    public static const PROJECT_CREATE:String = "projectCreate";

    // project involved
    public var project:Project;

    /**
     * Constructor, creates an instance based on the specified arguments.
     */
    public function ProjectEvent(type:String, project:Project)
    {
        super(type, true, true);
        this.project = project;
    }


    /**
     * Creates a clone of the object.
     */
    override public function clone():Event
    {
        return new ProjectEvent(this.type, project);
    }
}
}