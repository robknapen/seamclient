/*
 * wallace: User.as
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
[RemoteClass(alias="org.seamless_ip.services.transferobjects.seamproj.UserTO")]

public class User implements IClonable    {
	//If the class is not is not auto-generated...please add the following static field.
	//There is a call to it on class org.seamless_ip.services.transferobjects.utils.EditedCodeNotOverwritten
	//In this way the compiler will help to avoid the override of your code with the generated version!
	public static var notOverwriteUser:int;
	
    public function User()
    {
        roles = new ArrayCollection();
    }


    public var endDate: String;
    public var roles: ArrayCollection;
    public var institute: String;
    public var accountName: String;
    public var lastName: String;
    public var firstName: String;
    public var email: String;
    public var id: String;
    public var image: Image;
    public var password: String;


    public function Clone():IClonable
    {
        var clone: User = new User();
        var item:IClonable;
        clone.endDate = this.endDate;
        for each (item in this.roles)
            clone.roles.addItem(item.Clone());
        clone.institute = this.institute;
        clone.accountName = this.accountName;
        clone.lastName = this.lastName;
        clone.firstName = this.firstName;
        clone.email = this.email;
        clone.id = this.id;
        //clone.image = (Image)(this.image .Clone());
        clone.password = this.password;
        return clone;
    }

    public function canDo(task:String, right:String):Boolean
    {
        var role:IRole;
        var projectRole:ProjectRole;
        var permission:Permission;
        var roles:ArrayCollection;
        var permissions:ArrayCollection;


        // get all project roles
        roles = this.roles;
        for each (role in roles)
        {
            if (role.canDo(task, right)) {
                return true;
            }
        }
        return false;
    }


    public function canDoForProject(projectId:String, task:String, right:String):Boolean {
        for each (var obj:Object in roles) {
            if (obj is ProjectRole) {
                var p:Project = ProjectRole(obj).project;
                if ((p != null) && (p.id == projectId)) {
                    if (ProjectRole(obj).canDo(task, right)) {
                        // for published projects only allow reading
                        return (!p.published || task == "READ");
                    }
                }
            }
            if (obj is ApplicationRole) {
                if (ApplicationRole(obj).canDo(task, right))
                    return true;
            }
        }
        return false;
    }

}


}
