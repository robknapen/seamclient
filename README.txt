-------------------------------------------------------------------------------
SEAMLESS WALLACE | Version: 1.3.0                        Release: April 2, 2010
-------------------------------------------------------------------------------
Copyright (c) 2009, The SEAMLESS Association. Please see the included license
files for LEGAL statements and disclaimers. It can also be obtained from the
website: http://www.seamlessassociation.org.
-------------------------------------------------------------------------------

1. Introduction

This is the source code for the SEAMLESS WALLACE module. "Wallace" is the
server part of the SEAMLESS-IF web application. The client part is named 
"Gromit", and is written in Java. Wallace communicates with Gromit to retrieve
information from the SEAMLESS database, present it to the user, and if needed
to save modified or new data. Transmitting data between server and client is
done using Adobe BlazeDS and the AMF format for performance reasons.

2. Remarks for this version

This component is fully functional. However take note that it is the result of
the SEAMLESS IP research project and not developed as production or mission
critical quality software. Many aspects can certainly be improved, amongst 
others to make the data exchange more efficient and faster. Some parts present
in the web client are already being updated, e.g. the processing environment
and PICA. These parts are currently disabled awaiting completion (or removal
from the code base). 

3. Available packages

- org.seamless_ip.events
	Global event classes used throughout the code.

- org.seamless_ip.services
	Shared classes for communication with the server, and all generated (and
	manually coded) tranfer objects.
	
- org.seamless_ip.ui
	All components of the user interface, separated into packages for each
	major component. A description of each component is beyond the scope of
	this file (for the moment). Please contact the SEAMLESS Association if
	you have specific interests and require more detailed information.
	
4. Building
This component and its source code is provided as an Eclipse (3.5) compatible
project, including all referenced libraries, project settings files and
classpath definition. It should be no problem to get started building and
using this library in the Eclipse IDE. An Ant build.xml file is also included
for building the source code. To use this build script you need the Antennae
templates, which can be downloaded from: http://code.google.com/p/antennae/. To
create documentation from the source code please run asdoc.
-------------------------------------------------------------------------------
