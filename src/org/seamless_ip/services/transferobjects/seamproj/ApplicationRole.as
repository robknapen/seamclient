/*
 * wallace: ApplicationRole.as
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

package org.seamless_ip.services.transferobjects.seamproj
{
import mx.collections.ArrayCollection;

import org.seamless_ip.services.transferobjects.utils.IClonable;

[Bindable]
[RemoteClass(alias="org.seamless_ip.services.transferobjects.seamproj.ApplicationRoleTO")]

public class ApplicationRole implements IClonable, IRole    {
	//If the class is not is not auto-generated...please add the following static field.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	public function notOverwriteIRole():int { return 1; }
	
    public function ApplicationRole()
    {
        permissions = new ArrayCollection();
    }


    public var permissions: ArrayCollection;
    public var id: String;
    public var title: String;


    public function Clone():IClonable
    {
        var clone: ApplicationRole = new ApplicationRole();
        var item:IClonable;
        for each (item in this.permissions)
            clone.permissions.addItem(item.Clone());
        clone.id = this.id;
        clone.title = this.title;
        return clone;
    }

    public function canDo(task:String, right:String):Boolean
    {
        var permission:Permission;
        for each (permission in permissions)
        {
            if (permission.canDo(task, right))
            {
                return true;
            }
        }
        return false;
    }

    public function getId():String
    {
        return id;
    }

    public function setId(id:String):void
    {
        this.id = id;
    }

    public function getPermissions():ArrayCollection
    {
        return permissions;
    }

    public function setPermissions(permissions:ArrayCollection):void {
        this.permissions = permissions;
    }

    public function getTitle():String
    {
        return title;
    }

    public function setTitle(title:String):void
    {
        this.title = title;
    }
}


}
