
<%	'==================================================
    ' Module:	inc_debug.asp
    '
	' Synopsis:	Server Appliance Web Framework Error Handling
    '
	' Copyright (c) Microsoft Corporation.  All rights reserved.
	'================================================== 
%>
	

<%
'Server.ScriptTimeout = 300
'
' Global variables for Error handling support
'
Const MAX_TRACEFILE_SIZE = 500000
Const MINIMUM_SCRIPT_TIMEOUT = 300

'
' ReEntrancy check variable
DIM SA_INSIDE_DEBUG
SA_INSIDE_DEBUG = 0

' Last error code. 
' DO NOT access this variable directly, use SA_GetLastError
DIM SA_LASTERROR

' Function executing during last error
' DO NOT access this variable, it's for internal use only
DIM SA_LASTERROR_FUNCTION

' Tracing options
Const SA_TRACE_OUTPUT_NONE			= 0
Const SA_TRACE_OUTPUT_HTML			= 1
Const SA_TRACE_OUTPUT_FILE			= 2

'
' Debugging enabled, default is enabled.
' DO NOT access this variable, it's for internal use only.
'
' This variable is set in LoadRuntimeOptions() which
' is called below. We default to enabled just in case
' LoadRuntimeOptions failes to initialize.
DIM SA_DEBUG_ENABLED
SA_DEBUG_ENABLED = 0

' Tracing option, default is HTML
' DO NOT access this variable, it's for internal use only.
'
' This variable is set in LoadRuntimeOptions() which
' is called below. We default to enabled just in case
' LoadRuntimeOptions failes to initialize.
DIM SA_TRACE_OPTION
SA_TRACE_OPTION = SA_TRACE_OUTPUT_NONE

' Current Tracing output file
' DO NOT access this variable, it's for internal use only
DIM SA_TRACE_FILE

'
' Global constant error codes
Const gc_ERR_SUCCESS = 0


SA_LASTERROR = gc_ERR_SUCCESS


'
' Set the Runtime options
'
LoadRuntimeOptions()

'
' Set page level error handling
'
If (SA_DEBUG_ENABLED <> 0) Then
	'
	' Debugging mode
	'
	On Error goto 0
Else
	'
	' Release mode
	'
	On Error Resume Next
End If


' --------------------------------------------------------------
' 
' Function:	
'
' Synopsis:	
'
' Arguments: 
' 
' --------------------------------------------------------------
Private Function LoadRuntimeOptions()
	ON ERROR RESUME NEXT
	Dim objRegistry
	Dim dwDebugOption

	'
	' Prevent recursion into this module. Specifically, SA_TraceOut
	SA_EnterDebugModule()

	'
	' Disable for now
	'

	Set objRegistry = RegConnection()
	If (NOT IsObject(objRegistry)) Then
		SA_TraceOut "LoadRuntimeOptions", "RegConnection() failed " + "(" + Hex(Err.Number) + ")"
		Exit Function
	End If

	'
	' Fetch debugging flag
	'
	SA_DEBUG_ENABLED= GetRegkeyValue( objRegistry, _
								"SOFTWARE\Microsoft\ServerAppliance\WebFramework",_
								"Debug", CONST_DWORD)
	If (SA_DEBUG_ENABLED <> 0) Then
		'
		' Debugging mode
		'
		On Error goto 0
	Else
		'
		' Release mode
		'
		On Error Resume Next
	End If


	SA_TRACE_OPTION = GetRegkeyValue( objRegistry, _
								"SOFTWARE\Microsoft\ServerAppliance\WebFramework",_
								"TraceOption", CONST_DWORD)

	SA_TRACE_FILE = GetRegkeyValue( objRegistry, _
								"SOFTWARE\Microsoft\ServerAppliance\WebFramework",_
								"TraceFile", CONST_STRING)
								
	Dim iScriptTimeOut
	iScriptTimeOut = GetRegkeyValue( objRegistry, _
								"SOFTWARE\Microsoft\ServerAppliance\WebFramework",_
								"ScriptTimeOut", CONST_DWORD)
	If ( NOT IsNumeric(iScriptTimeOut) ) Then
		iScriptTimeOut = MINIMUM_SCRIPT_TIMEOUT
	ElseIf ( iScriptTimeOut < MINIMUM_SCRIPT_TIMEOUT ) Then
		iScriptTimeOut = MINIMUM_SCRIPT_TIMEOUT
	End If
	Server.ScriptTimeout = CInt(iScriptTimeOut)
	
	SA_ExitDebugModule()

	Set objRegistry = nothing
	
End Function



' --------------------------------------------------------------
' 
' Function:	SA_EnterDebugModule
'
' Synopsis:	Mark us as inside the debug module. This is used for
'			reentrancy checks. We don't want to get caught in
'			a recussion loop if we have an error inside this module.
'
' Arguments: 
' 
' --------------------------------------------------------------
Private Function SA_EnterDebugModule()
	SA_INSIDE_DEBUG = 1
End Function

' --------------------------------------------------------------
' 
' Function:	SA_ExitDebugModule
'
' Synopsis:	Mark us as exiting the debug module. This is used for
'			reentrancy checks. We don't want to get caught in
'			a recussion loop if we have an error inside this module.
'
' Arguments: 
' 
' --------------------------------------------------------------
Private Function SA_ExitDebugModule()
	SA_INSIDE_DEBUG = 0
End Function

' --------------------------------------------------------------
' 
' Function:	SA_IsExecutingDebugModule
'
' Synopsis:	Check to see if we are reentering this module
'
' --------------------------------------------------------------
Private Function SA_IsExecutingDebugModule()
	SA_IsExecutingDebugModule = SA_INSIDE_DEBUG
End Function

' --------------------------------------------------------------
' 
' Function:	
'
' Synopsis:	
'
' Arguments: 
' 
' --------------------------------------------------------------
Public Function SA_IsDebugEnabled()
	SA_IsDebugEnabled = SA_DEBUG_ENABLED
End Function


' --------------------------------------------------------------
' 
' Function:	
'
' Synopsis:	
'
' Arguments: 
' 
' --------------------------------------------------------------
Public Function SA_EnableDebug(ByVal DebugEnabled)
	SA_DEBUG_ENABLED = DebugEnabled
	
	Dim objRegistry
	Dim rc
	
	Set objRegistry = RegConnection()
	If (NOT IsObject(objRegistry)) Then
		SA_TraceOut "SA_EnableDebug", "RegConnection() failed " + "(" + Hex(Err.Number) + ")"
		Exit Function
	End If
	
	rc = UpdateRegkeyValue( objRegistry, _
							"SOFTWARE\Microsoft\ServerAppliance\WebFramework",_
							"Debug", _
							DebugEnabled, _
							CONST_DWORD)

	Set objRegistry = nothing
	
	SA_EnableDebug = gc_ERR_SUCCESS
End Function


' --------------------------------------------------------------
' 
' Function:	
'
' Synopsis:	
'
' Arguments: 
' 
' --------------------------------------------------------------
Public Function SA_GetTraceOption()
	SA_GetTraceOption = SA_TRACE_OPTION
End Function


' --------------------------------------------------------------
' 
' Function:	SA_SetDebugOption
'
' Synopsis:	Set the debugging option.
'
' Arguments: [in] Option - Debugging option to use which can be a combination of
'			SA_TRACE_OUTPUT_HTML Debugging errors emitted with HTML response
'			SA_TRACE_OUTPUT_FILE Debugging errors emitted to output file
' 
' --------------------------------------------------------------
Public Function SA_SetDebugOption(ByVal DebugOption)
	SA_TRACE_OPTION = DebugOption
	
	Dim objRegistry
	Dim rc
	
	Set objRegistry = RegConnection()
	If (NOT IsObject(objRegistry)) Then
		SA_TraceOut "SA_SetDebugOption", "RegConnection() failed " + "(" + Hex(Err.Number) + ")"
		Exit Function
	End If
	
	rc = UpdateRegkeyValue( objRegistry, _
							"SOFTWARE\Microsoft\ServerAppliance\WebFramework",_
							"TraceOption", _
							DebugOption, _
							CONST_DWORD)

	Set objRegistry = nothing
	
	SA_SetDebugOption = gc_ERR_SUCCESS
End Function


' --------------------------------------------------------------
' 
' Function:	
'
' Synopsis:	
'
' Arguments: 
' 
' --------------------------------------------------------------
Public Function SA_GetTraceOutputFile()
	SA_GetTraceOutputFile = SA_TRACE_FILE
End Function


' --------------------------------------------------------------
' 
' Function:	SA_SetDebugOutputFile
'
' Synopsis:	Set the debugging output file
'
' Arguments: [in] File - Filename to receive debugging output
' 
' --------------------------------------------------------------
Public Function SA_SetDebugOutputFile(ByVal File)
	SA_TRACE_FILE = File

	Dim objRegistry
	Dim rc
	
	Set objRegistry = RegConnection()
	If (NOT IsObject(objRegistry)) Then
		SA_TraceOut "SA_SetDebugOutputFile", "RegConnection() failed " + "(" + Hex(Err.Number) + ")"
		Exit Function
	End If
	
	rc = UpdateRegkeyValue( objRegistry, _
							"SOFTWARE\Microsoft\ServerAppliance\WebFramework",_
							"TraceFile", _
							File, _
							CONST_STRING)

	Set objRegistry = nothing

	
	SA_SetDebugOutputFile = gc_ERR_SUCCESS
End Function


' --------------------------------------------------------------
' 
' Function:	
'
' Synopsis:	
'
' Arguments: 
' 
' --------------------------------------------------------------
Function SA_ClearTraceLog()

































End Function


' --------------------------------------------------------------
' 
' Function:	
'
' Synopsis:	
'
' Arguments: 
' 
' --------------------------------------------------------------
Function SA_ShowTraceLog()

















































End Function


' --------------------------------------------------------------
' 
' Function:	
'
' Synopsis:	
'
' Arguments: 
' 
' --------------------------------------------------------------
Function SA_ShowRuntimeOptions()




























End Function


' --------------------------------------------------------------
' 
' Function:	SA_TraceOut
'
' Synopsis:	Output tracing information
'
' Arguments: [in] Module - Module/Function issuing the tracing message
'			[in] Message - Message to be output
' 
' --------------------------------------------------------------
Public Function SA_TraceOut(ByVal  Module, ByVal Message)









	SA_TraceOut = gc_ERR_SUCCESS
End Function

' --------------------------------------------------------------
' 
' Function:	SA_TraceErrorOut
'
' Synopsis:	Output tracing information for error conditions. Errors are
'			flaged with the keyword ISSUE.
'
' Arguments: [in] Module - Module/Function issuing the tracing message
'			[in] Message - Message to be output
' 
' --------------------------------------------------------------
Public Function SA_TraceErrorOut(ByVal  Module, ByVal Message)
	Dim rc
	
	rc = SA_TraceOut("ISSUE: " + Module, Message)
	
	SA_TraceErrorOut = rc
End Function


' --------------------------------------------------------------
' 
' Function:	SA_SetLastError
'
' Synopsis:	Set the last error code.
'
' Arguments: [in] ErrorCode - Error code
'			[in] FunctionName - Name of function where error occured
' 
' --------------------------------------------------------------
Public Function SA_GetLastError()
	SA_GetLastError = SA_LASTERROR
End Function


' --------------------------------------------------------------
' 
' Function:	SA_SetLastError
'
' Synopsis:	Set the last error code.
'
' Arguments: [in] ErrorCode - Error code
'			[in] FunctionName - Name of function where error occured
'
' Returns:	The error code specified in ErrorCode parameter
' 
' --------------------------------------------------------------
Public Function SA_SetLastError(ByVal ErrorCode, ByVal FunctionName )
	SA_LASTERROR = ErrorCode
	SA_LASTERROR_FUNCTION = FunctionName
	Err.Number = ErrorCode
	
	SA_SetLastError = ErrorCode

	'
	' If we had an error then emit trace output. An error is
	' any error code other than gc_ERR_SUCCESS.
	'
	If ( ErrorCode <> gc_ERR_SUCCESS ) Then
		SA_InternalTraceOut "ISSUE: "+FunctionName, CStr(ErrorCode)
	End If
	
End Function


' --------------------------------------------------------------
' 
' Function:	SA_SetLastError
'
' Synopsis:	Set the last error code.
'
' Arguments: [in] ErrorCode - Error code
'			[in] FunctionName - Name of function where error occured
' 
' --------------------------------------------------------------
Public Function SA_ClearError()
	SA_LASTERROR = gc_ERR_SUCCESS
	Err.Number = 0
	SA_ClearError = gc_ERR_SUCCESS
End Function


' --------------------------------------------------------------
' 
' Function:	_SA_InternalTraceOut
'
' Synopsis:	Internal function to handle output tracing.
'
' Arguments: [in] Module - Module/Function issuing the tracing message
'			[in] Message - Message to be output
' 
' --------------------------------------------------------------
Private Function SA_InternalTraceOut(ByVal  Module, ByVal Message)














































































	SA_InternalTraceOut = gc_ERR_SUCCESS
End Function

%>

