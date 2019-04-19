<%@ Language=VBScript CODEPAGE=65001 %>
<!--#include file="include/wmsLocStrings.inc"-->
<!--#include file="include/wmsServerHash.inc"-->
<!--#include file="include/wmsPlugins.inc"-->
<!--#include file="include/wmsHeader.inc"-->
<!--#include file="include/wmsRefresh.inc"-->
<!--#include file="include/wmsError.inc"-->
<!--#include file="include/wmsToolbar.inc"-->
<!--#include file="include/wmsPageBanner.inc"-->
<!--#include file="include/wmsTabs.inc"-->
<%
'+-------------------------------------------------------------------------
'
'  Microsoft Windows Media
'  Copyright (C) Microsoft Corporation. All rights reserved.
'
'  File:       PubPoint_Props.asp
'
'  Contents:    Implementation of Properties Tab at the publishing point level
'
'--------------------------------------------------------------------------

BeginErrorHandling
ClearError
ConnectToServer
ConnectToPubPoint

Const SHOWING_GENERAL = 0
Const SHOWING_PLUGINS = 1
Const SHOWING_LIMITS = 2
Const SHOWING_CACHEPROXYMGMT = 3
Const SHOWING_NETWORKING = 4
Const SHOWING_CREDENTIALS = 5
Const SHOWING_WIRELESS = 6

Dim strCategory
Dim strEncodedInstance
Dim strDecodedInstance
Dim dwQueryStringPluginIndex
Dim strPPStatus
Dim bBroadcastPubPoint
Dim bCacheProxyPubPoint
Dim bBroadcastPPStarted
Dim dwPPStatus 
Dim dwPPType
Dim iPluginCount
Dim strSubCategory
Dim iFormSelect
Dim strStartOnFirstConnectChecked
Dim strOp
Dim bPluginDisabledError
Dim bPluginRemovedError
Dim bPluginRemovedErrorEnable
Dim bPluginRenamedError
Dim bPluginDuplicateError
Dim dwDisplayMode
Dim blnRunningOnWhistlerAdvServer
Dim iGeneral
Dim iAuthorizers
Dim iLogging
Dim iEvent
Dim iAuthen
Dim iLimits
Dim iWireless
Dim iPlXform
Dim iCPMgmt
Dim iArchivers
Dim iMCast
Dim iNetworking
Dim iCredentials
Dim bDriveUpdateToTreeView
Dim bCheckedAnItem
Dim strLeft
Dim strRight
Dim objPPLimits
Dim strError
Dim strOnLoadProc

Dim dwNumPluginsDisplayed

Dim dwSizeLimText
Dim strPlayerConnections
Dim strDistConnections
Dim strAggPlayerBW
Dim strDistAggBW
Dim strPlayerBW
Dim strDistBW
Dim strRapidStartBW
Dim strDeliveryRate

Dim bAllowPlayerCaching
Dim bAllowStreamSplitting
Dim bAllowAutoStart
Dim bAllowDistributionCaching
Dim bAllowDirBrowse
Dim bAllowDownload
Dim bAllowStartupProfile
Dim bStartupProfileSupported
Dim bAllowVrootStart
Dim bVrootStartSupported

Dim strCurrentCheckedPluginName
Dim bCurSelCanBeDuplicated
Dim bCurSelCanBeRemoved
Dim bCurSelSupportsEnableDisable
Dim bCurSelSupportsProperties
Dim bCurSelEnabled
Dim bCurSelIsActiveScriptNoFilename

'////////////////////////////////////////////////////////////////
Function GenExpirationString( strValue )
    GenExpirationString = Replace( L_EXPIREIN_TEXT, "___", Server.HTMLEncode( trim( strValue ) ), 1 )
End Function
    
'////////////////////////////////////////////////////////////////
Sub Main
    strCurrentCheckedPluginName = "plugin_0"
    bCurSelCanBeDuplicated = TRUE
    bCurSelCanBeRemoved = TRUE
    bCurSelSupportsEnableDisable = FALSE
    bCurSelSupportsProperties = FALSE
    bCurSelEnabled = FALSE
    bCurSelIsActiveScriptNoFilename = FALSE

    on error resume next
    dwSizeLimText = CalcLenOfUnlimited

    bDriveUpdateToTreeView = FALSE
    if ( 0 = strcomp( "true", RemoveDangerousCharacters( qs("s") ), vbTextCompare ) ) then
        bDriveUpdateToTreeView = TRUE
    end if

    if( empty = g_objPubPoint ) then
        Server.Transfer( "pubpoint_collection.asp" )
    end if

    dwPPType = g_objPubPoint.Type

    if( 0 <> Len( trim( qs( "propChange" ) ) ) ) then
        if( 0 < Len( trim( qs( "playerCaching" ) ) ) ) then
            if( 0 = trim( qs( "playerCaching" ) ) ) then
                g_objPubPoint.AllowPlayerSideDiskCaching = FALSE
            else
                g_objPubPoint.AllowPlayerSideDiskCaching = TRUE
            end if
        elseif( 0 < Len( trim( qs( "distCaching" ) ) ) ) then
            if( 0 = trim( qs( "distCaching" ) ) ) then
                g_objPubPoint.AllowContentCaching = FALSE
            else
                g_objPubPoint.AllowContentCaching = TRUE
            end if
        elseif( 0 < Len( trim( qs( "dirBrowsing" ) ) ) ) then
            if( 0 = trim( qs( "dirBrowsing" ) ) ) then
                g_objPubPoint.EnableClientWildcardDirectoryAccess = FALSE
            else
                g_objPubPoint.EnableClientWildcardDirectoryAccess = TRUE
            end if
        elseif( 0 < Len( trim( qs( "allowDownloading" ) ) ) ) then
            if( 0 = trim( qs( "allowDownloading" ) ) ) then
                g_objPubPoint.EnableDownload = FALSE
            else
                g_objPubPoint.EnableDownload = TRUE
            end if
        elseif( 0 < Len( trim( qs( "allowStreamSplitting" ) ) ) ) then
            if( 0 = trim( qs( "allowStreamSplitting" ) ) ) then
                g_objPubPoint.AllowStreamSplitting = FALSE
            else
                g_objPubPoint.AllowStreamSplitting = TRUE
            end if
        elseif( 0 < Len( trim( qs( "allowAutoStart" ) ) ) ) then
            if( 0 = trim( qs( "allowAutoStart" ) ) ) then
                g_objPubPoint.AllowClientToStartAndStop = FALSE
            else
                g_objPubPoint.AllowClientToStartAndStop = TRUE
            end if
        elseif( 0 < Len( trim( qs( "allowStartupProfile" ) ) ) ) then
            if( 0 = trim( qs( "allowStartupProfile" ) ) ) then
                g_objPubPoint.AllowStartupProfile = FALSE
            else
                g_objPubPoint.AllowStartupProfile = TRUE                
            end if
        elseif( 0 < Len( trim( qs( "allowVrootStart" ) ) ) ) then
            if( 0 = trim( qs( "allowVrootStart" ) ) ) then
                g_objPubPoint.EnableStartVRootOnServiceStart = FALSE
            else
                g_objPubPoint.EnableStartVRootOnServiceStart = TRUE                
            end if            
        end if
        
        Response.Redirect( "pubpoint_props.asp?server=" & g_strQueryStringServer & "&ppID=" & g_strPubPointID & "&category=" & RemoveDangerousCharacters( qs("category" ) ) )
        Response.Flush    
    end if 

    bPluginDisabledError = FALSE
    bPluginRemovedError = FALSE
    bPluginRemovedErrorEnable = FALSE
    bPluginRenamedError = FALSE
    bPluginDuplicateError = FALSE

    strSubCategory = ""
    iFormSelect = -1

    '
    '  Determine the publishing point type
    '
    bCacheProxyPubPoint = FALSE
    if ( WMS_PUBLISHING_POINT_TYPE_CACHE_PROXY_BROADCAST = dwPPType ) or ( WMS_PUBLISHING_POINT_TYPE_CACHE_PROXY_ON_DEMAND = dwPPType ) then
        bCacheProxyPubPoint = TRUE
    end if

    bBroadcastPubPoint = FALSE
    if ( WMS_PUBLISHING_POINT_TYPE_BROADCAST = dwPPType ) or ( WMS_PUBLISHING_POINT_TYPE_CACHE_PROXY_BROADCAST = dwPPType ) then
        bBroadcastPubPoint = TRUE
        bAllowStreamSplitting = g_objPubPoint.AllowStreamSplitting
        bAllowAutoStart = g_objPubPoint.AllowClientToStartAndStop
        dwPPStatus = g_objPubPoint.BroadcastStatus
    else
        bAllowDistributionCaching = g_objPubPoint.AllowContentCaching
        bAllowDirBrowse = g_objPubPoint.EnableClientWildcardDirectoryAccess
        bAllowDownload = g_objPubPoint.EnableDownload
        dwPPStatus = g_objPubPoint.Status
    end if

    bAllowPlayerCaching = g_objPubPoint.AllowPlayerSideDiskCaching
    bAllowingConnections = g_objPubPoint.AllowClientsToConnect

   bStartupProfileSupported = true
   on error resume next   
   bAllowStartupProfile = g_objPubPoint.AllowStartupProfile
   if( 0 <> err.number ) then
       bStartupProfileSupported = false
       err.Clear
    end if   

   bVrootStartSupported = true
   on error resume next   
   bAllowVrootStart = g_objPubPoint.EnableStartVRootOnServiceStart
   if( 0 <> err.number ) then
       bVrootStartSupported = false
       err.Clear
    end if   

    if( empty = g_objServer ) then
        Server.Transfer( "include/server_stopped.asp" )
    end if
    on error resume next
    dwProductType = g_objServer.OSProductType
    if( 0 <> err.number ) then
        blnRunningOnWhistlerAdvServer = FALSE
        err.Clear
    else
        blnRunningOnWhistlerAdvServer = CBool( WMS_OS_PRODUCT_ADVANCED and dwProductType )
    end if
    on error resume next

    iGeneral = 0
    iAuthorizers = 1
    iLogging = 2
    iEvent = 3
    iAuthen = 4
    iLimits = 5

    iWireless = -1
    iPlXform = -1
    iCPMgmt = -1
    iArchivers = -1
    iMCast = -1
    iCredentials = -1
    iNetworking = -1

    if( blnRunningOnWhistlerAdvServer ) then
        iWireless = 6
        if( FALSE = bCacheProxyPubPoint ) then
            iPlXform = 7
            iCPMgmt = 8
        end if

        if( TRUE = bBroadcastPubPoint ) then
            if( FALSE = bCacheProxyPubPoint ) then
                iArchivers = 9
                iMCast = 10
                iCredentials = 11
                iNetworking = 12
            end if
        else
            if( FALSE = bCacheProxyPubPoint ) then
                iCredentials = 9
            end if
        end if
    else
        iPlXform = 6
        iCPMgmt = 7
        
        if( TRUE = bBroadcastPubPoint ) then
            iArchivers = 8
            iCredentials = 9
            iNetworking = 10
        else
            iCredentials = 8
        end if
    end if

    '
    ' Process the category
    '
    dwDisplayMode = SHOWING_PLUGINS

    on error resume next
    rem Set the category so that we can implement a default
    strCategory = RemoveDangerousCharacters( qs( "category" ) )
    strEncodedInstance = qs( "instance" )
    strDecodedInstance = SafeUnescape( strEncodedInstance )
    strPluginIndex = qs( "pluginIndex" )
    if( 7 < Len( strPluginIndex ) ) then
        dwQueryStringPluginIndex = CInt( Right( strPluginIndex, Len( strPluginIndex ) - 8 + 1 ) )
    else
        dwQueryStringPluginIndex = -1
    end if
    if( "" = strCategory ) then
        strCategory = CAT_GEN
    end if

    Select Case strCategory
        case CAT_GEN
            iFormSelect = iGeneral
            dwDisplayMode = SHOWING_GENERAL
            bCurSelCanBeDuplicated = FALSE
            bCurSelCanBeRemoved = FALSE
            bCurSelSupportsEnableDisable = FALSE
            bCurSelSupportsProperties = FALSE
        case CAT_AUTHORIZE
            iFormSelect = iAuthorizers
            Set g_objPluginCollection = g_objPubPoint.EventHandlers
            strSubCategory = AUTHORIZE_SUBCAT
            bCurSelSupportsEnableDisable = TRUE
        case CAT_LOGGING
            iFormSelect = iLogging
            Set g_objPluginCollection = g_objPubPoint.EventHandlers
            strSubCategory = LOGGING_SUBCAT
            bCurSelSupportsEnableDisable = TRUE
        case CAT_EVENT
            iFormSelect = iEvent
            Set g_objPluginCollection = g_objPubPoint.EventHandlers
            bCurSelSupportsEnableDisable = TRUE
        case CAT_AUTHEN
            iFormSelect = iAuthen
            Set g_objPluginCollection = g_objPubPoint.Authenticators
            bCurSelSupportsEnableDisable = TRUE
        case CAT_LIM
            iFormSelect = iLimits
            dwDisplayMode = SHOWING_LIMITS
            bCurSelCanBeDuplicated = FALSE
            bCurSelCanBeRemoved = FALSE
            bCurSelSupportsEnableDisable = FALSE
            bCurSelSupportsProperties = FALSE
        case CAT_WIRELESS
            if( blnRunningOnWhistlerAdvServer ) then
                iFormSelect = iWireless
                dwDisplayMode = SHOWING_WIRELESS
                bCurSelSupportsEnableDisable = TRUE
                bCurSelSupportsProperties = TRUE
            end if
        case CAT_PLAYXFORM
            iFormSelect = iPlXform
            Set g_objPluginCollection = g_objPubPoint.EventHandlers
            strSubCategory = PLAYLISTXFORM_SUBCAT
            bCurSelSupportsEnableDisable = TRUE
        case CAT_CACHEPROXYMGMT
            iFormSelect = iCPMgmt
            dwDisplayMode = SHOWING_CACHEPROXYMGMT
            bCurSelCanBeDuplicated = FALSE
            bCurSelSupportsEnableDisable = FALSE
            bCurSelSupportsProperties = TRUE
        case CAT_ARCH
            if( FALSE = bCacheProxyPubPoint ) and ( TRUE = bBroadcastPubPoint ) then
                iFormSelect = iArchivers
                Set g_objPluginCollection = g_objPubPoint.BroadcastDataSinks
                strSubCategory = ARCHIVER_SUBCAT
                bCurSelSupportsEnableDisable = TRUE
            end if
        case CAT_MCAST
            if( FALSE = bCacheProxyPubPoint ) and blnRunningOnWhistlerAdvServer and bBroadcastPubPoint then
                iFormSelect = iMCast
                Set g_objPluginCollection = g_objPubPoint.BroadcastDataSinks
                strSubCategory = MULTICAST_SUBCAT
                bCurSelSupportsEnableDisable = TRUE
            end if
        case CAT_CRED
            iFormSelect = iCredentials
            dwDisplayMode = SHOWING_CREDENTIALS
            bCurSelCanBeDuplicated = FALSE
            bCurSelCanBeRemoved = FALSE
            bCurSelSupportsEnableDisable = FALSE
            bCurSelSupportsProperties = TRUE
        case CAT_NET
            iFormSelect = iNetworking
            dwDisplayMode = SHOWING_NETWORKING
            bCurSelCanBeDuplicated = FALSE
            bCurSelCanBeRemoved = FALSE
            bCurSelSupportsEnableDisable = FALSE
            bCurSelSupportsProperties = TRUE
        case Else
            iFormSelect = iGeneral
            bCurSelCanBeDuplicated = FALSE
            bCurSelCanBeRemoved = FALSE
            bCurSelSupportsEnableDisable = TRUE
    End Select

    '
    ' In the case of limits, the checkbox value is submitted with the form.  Attempting to reload
    '  the page for every click would lose any changes the user had made to the limits settings.
    '
    if( SHOWING_LIMITS <> dwDisplayMode ) then
        if( TRUE = bBroadcastPubPoint ) then
            if "ON" = UCase( trim( qs("AutoStartPPCheckbox") ) ) then
                g_objPubPoint.AllowClientToStartAndStop = TRUE
            elseif "OFF" = UCase( trim( qs("AutoStartPPCheckbox") ) ) then
                g_objPubPoint.AllowClientToStartAndStop = FALSE    
            end if
        end if
    end if    
    
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    if SHOWING_LIMITS = dwDisplayMode then
        Err.clear
        set posting = Request.Form
        strOp = RemoveDangerousCharacters( trim( posting("limitOp") ) )
        strSubmit = RemoveDangerousCharacters( trim( posting("submit") ) )
        if( 0 < Len( strSubmit ) ) then
            set objPPLimits = g_objPubPoint.limits

    '        if( 0 = StrComp( strSubmit, Unescape( trim( L_APPLYBUTTON_TEXT ) ), vbTextCompare ) ) then

                objPPLimits.ConnectedPlayers = NormalizeLimitText( Trim( posting( "PlayerConnText" ) ) )
                if( ErrorDetected( "PlayerConn" ) ) then
                    ClearError
                end if

                objPPLimits.OutgoingDistributionConnections = NormalizeLimitText( Trim( posting( "DistConnText" ) ) )
                if( ErrorDetected( "DistConn" ) ) then
                end if

                objPPLimits.PlayerBandwidth = NormalizeLimitText( Trim( posting( "AggPlayerBWText" ) ) )
                if( ErrorDetected( "AggPlayerBW" ) ) then
                end if

                objPPLimits.OutgoingDistributionBandwidth = NormalizeLimitText( Trim( posting( "AggDistBWText" ) ) )
                if( ErrorDetected( "AggDistBW" ) ) then
                end if

                objPPLimits.PerPlayerConnectionBandwidth = NormalizeLimitText( Trim( posting( "PlayerBWText" ) ) )
                if( ErrorDetected( "PlayerBW" ) ) then
                end if

                objPPLimits.PerOutgoingDistributionConnectionBandwidth = NormalizeLimitText( Trim( posting( "DistBWText" ) ) )
                if( ErrorDetected( "DistBW" ) ) then
                end if

                on error resume next            
                strRapidStartBW = NormalizeLimitTextEx( Trim( posting( "RapidStartBWText" ) ), CStr( DEFAULT_RAPIDSTART_RATE ) ) 
                if( 0 = StrComp( DEFAULT_RAPIDSTART_RATE, strRapidStartBW, vbTextCompare ) ) then
                    objPPLimits.PerPlayerRapidStartBandwidth = CDbl( DEFAULT_RAPIDSTART_RATE )
                else
                    objPPLimits.PerPlayerRapidStartBandwidth = CDbl( strRapidStartBW )
                end if
    '            if( ErrorDetected( "RapidStartBW" ) ) then
                if( 0 <> err.number )then
                    err.clear
                end if
                
                strDeliveryRate = NormalizeLimitTextEx( Trim( posting("LimitDeliveryRateText" ) ), CStr( DEFAULT_DELIVERY_RATE ) )
                if( -1 = CInt( strDeliveryRate ) ) then
                    objPPLimits.PlayerCacheDeliveryRate = -1
                else
                    objPPLimits.PlayerCacheDeliveryRate = CInt( strDeliveryRate ) * 1000
                end if
     
                if( ErrorDetected( "DeliveryRate" ) ) then
                end if

                Response.Redirect( "pubpoint_props.asp?server=" & g_strQueryStringServer & "&ppID=" & g_strPubPointID & "&category=" & strCategory )
    '        end if
        
        end if
        
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    elseif ( SHOWING_PLUGINS = dwDisplayMode ) then

        strOp = RemoveDangerousCharacters( trim( qs("op") ) )
        Dim strClsID
        if "" <> strOp then
        
            on error resume next
            iPluginCount = g_objPluginCollection.Count

            Select Case strOp
                case "enable"
                    Dim strPluginCLSID
                    bDriveUpdateToTreeView = TRUE
                    ConnectToPlugin
                    err.clear
                    strPluginCLSID = CStr( g_objPlugin.CLSID )
                    if( 0 = StrComp( "{043cc79e-1e1b-11d3-9d0f-00c04f610d50}", strPluginCLSID, vbTextCompare ) ) then
                        Session( "DisplayMcastWarning" ) = TRUE
                    end if
                    g_objPlugin.Enabled = TRUE
                    if( ErrorDetected( "Enable" ) ) then
                        if( -2147014848 = Err.number ) then
                            err.Description = L_PORTINUSEERROR_TEXT
                            Session( "ErrorNumber" ) = err.Number
                            Session( "ErrorCulprit" ) = ""
                            Session( "ErrorDescription" ) = L_PORTINUSEERROR_TEXT
                            break
                        elseif( -2147024773 = Err.number ) then
                            err.Description = L_ACTSCRIPTPLERROR_TEXT
                            Session( "ErrorNumber" ) = err.Number
                            Session( "ErrorCulprit" ) = ""
                            Session( "ErrorDescription" ) = L_ACTSCRIPTPLERROR_TEXT
                            break
                        end if
                    end if
                case "disable"
                    bDriveUpdateToTreeView = TRUE
                    strError = CStr( trim( Session( "DisableError" ) ) )
                    Session( "DisableError" ) = ""
                    if( 0 < Len( strError ) ) then
                        bPluginDisabledError = TRUE
                    else
                        ClearError
                    end if
                case "remove"
                    bDriveUpdateToTreeView = TRUE
                    strError = CStr( trim( Session( "RemoveError" ) ) )
                    Session( "RemoveError" ) = ""
                    if( 0 = Len( strError ) ) then
                        ClearError
                    elseif( 0 = Len( qs("prompted") ) )then
                        bPluginRemovedError = TRUE
                    end if
                case "refresh"
                    bDriveUpdateToTreeView = TRUE
                case Else
            End Select

            if ( not bPluginRemovedError ) and ( not bPluginDisabledError ) then
                if( 0 <> Err.number ) then
                    ErrorDetected( "" )
                    Session( "PageReloadedToDisplayError" ) = 1
                else
                    Response.Redirect( "pubpoint_props.asp?server=" & g_strQueryStringServer & "&ppID=" & g_strPubPointID & "&category=" & strCategory & "&pluginIndex=" & qs("pluginIndex") & "&s=true" )
                    Response.Flush
                    err.clear
                end if
            end if
        end if
        
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    else
        ' Handle General operations
    end if

    if( SHOWING_LIMITS = dwDisplayMode ) then
        Set objPPLimits = g_objPubPoint.limits
        strPlayerConnections = AdjustLimitText( objPPLimits.ConnectedPlayers )
        strDistConnections = AdjustLimitText( objPPLimits.OutgoingDistributionConnections )
        strAggPlayerBW = AdjustLimitText( objPPLimits.PlayerBandwidth )
        strDistAggBW = AdjustLimitText( objPPLimits.OutgoingDistributionBandwidth )
        strPlayerBW = AdjustLimitText( objPPLimits.PerPlayerConnectionBandwidth )
        strDistBW = AdjustLimitText( objPPLimits.PerOutgoingDistributionConnectionBandwidth )

        on error resume next
        ' Bug work-around  <><>
        lRapidStartBW = objPPLimits.PerPlayerRapidStartBandwidth
        
        if( 0 <> err.number ) then
            err.Clear
            strRapidStartBW = CStr( L_DEFAULT_RAPIDSTART_RATE )
        else
            strRapidStartBW = AdjustLimitText( lRapidStartBW )
        end if

        if ( FALSE = bBroadcastPubPoint ) then
            strDeliveryRate = AdjustLimitText( objPPLimits.PlayerCacheDeliveryRate / 1000 )
        end if
    end if

    if( TRUE = bBroadcastPubPoint ) then
        if( TRUE = g_objPubPoint.AllowClientToStartAndStop ) then
            strStartOnFirstConnectChecked = " checked "
        end if
    end if
End Sub

'/////////////////////////////////////////////////////////////////////////////////////
Function NoFilenameActiveScriptPlugin( ByRef EachPlugin )
    on error resume next
    
    NoFilenameActiveScriptPlugin = FALSE
    if( strCategory <> CAT_EVENT ) then
        Exit Function
    end if
    
    Dim pluginAdmin
    Dim strScriptFilename
    Set pluginAdmin = EachPlugin.CustomInterface
    if( 0 = err.number ) then
        strScriptFilename = pluginAdmin.FileName
        if( 0 = err.number ) then
            if( 0 = Len( strScriptFilename ) ) then
                NoFilenameActiveScriptPlugin = TRUE
            end if
        end if
    end if
    err.Clear
End Function

'/////////////////////////////////////////////////////////////////////////////////////
Function CalcLenOfUnlimited()
    Dim intLen
    Dim strUnlimited

    intLen = 0
    strUnlimited = L_UNLIMITED_TEXT
    intLen = Len( strUnlimited )

    if( intLen < MAX_LEN_LIMIT ) then
        intLen = MAX_LEN_LIMIT
    end if

    CalcLenOfUnlimited = intLen
end Function

'/////////////////////////////////////////////////////////////////////////////////////
Sub IsDisabled( strValue )
    if( 0 = StrComp( L_UNLIMITED_TEXT, strValue, vbTextCompare ) ) then
        Response.Write( " disabled " )
    end if
end sub


'/////////////////////////////////////////////////////////////////////////////////////
Sub IsDisabledEx( strValue, strDisabled )
    if( 0 = StrComp( strDisabled, strValue, vbTextCompare ) ) then
        Response.Write( " disabled " )
    end if
end sub


'/////////////////////////////////////////////////////////////////////////////////////
Sub CheckIfNotDefault( strValue, strDefaultValue )
    if( 0 <> strcomp( strValue, strDefaultValue, vbTextCompare ) ) then
        Response.Write( " checked " )
    end if
end sub


'/////////////////////////////////////////////////////////////////////////////////////
Sub IsCheckedYesNo( bValue )
    if( bValue ) then
        Response.Write( " checked " )
    end if
end sub

'/////////////////////////////////////////////////////////////////////////////////////
function CalcMaxInputLength( l )
    if ( 0 = StrComp( L_UNLIMITED_TEXT, l, vbTextCompare ) ) then
        CalcMaxInputLength = dwSizeLimText
    else
        CalcMaxInputLength = MAX_LEN_LIMIT
    end if
end function


'/////////////////////////////////////////////////////////////////////////////////////
function AdjustLimitText(l)
    if -1 = l then
        AdjustLimitText = L_UNLIMITED_TEXT
    else
        AdjustLimitText = l       
    end if
end function


'/////////////////////////////////////////////////////////////////////////////////////
function NormalizeLimitText( strText )
    
    if ( 0 = StrComp( L_UNLIMITED_TEXT, strText, vbTextCompare ) ) then
        NormalizeLimitText = "-1"
    else
        if IsEmpty( strText ) then
            NormalizeLimitText = "-1"
        elseif ( 0 = Len( strText ) ) then
            NormalizeLimitText = "-1"
        elseif CLng( strText ) < -1 then
            Err.Raise 13, "NormalizeLimitText", L_TYPEMISMATCH_TEXT
            NormalizeLimitText = strText
        else
            if( ( CDbl( strText ) <= MAX_LIMIT_VAL ) and ( CDbl( strText ) >= 0 ) ) then
                NormalizeLimitText = strText
            else
                Err.Raise 13, "NormalizeLimitText", L_TYPEMISMATCH_TEXT
                NormalizeLimitText = "-1"
            end if
        end if
    end if
end function

'/////////////////////////////////////////////////////////////////////////////////////
function NormalizeLimitTextEx( strText, strDefault )
    if ( 0 = StrComp( strText, strDefault, vbTextCompare ) ) then
        NormalizeLimitTextEx = strDefault
    else
        if IsEmpty( strText ) then
            NormalizeLimitTextEx = strDefault
        elseif ( 0 = Len( strText ) ) then
            NormalizeLimitTextEx = strDefault
        elseif ( 0 = StrComp( L_UNLIMITED_TEXT, strText, vbTextCompare ) ) then
            NormalizeLimitTextEx = -1
        elseif CLng( strText ) < -1 then
            Err.Raise 13, "NormalizeLimitTextEx", L_TYPEMISMATCH_TEXT
            NormalizeLimitTextEx = strText
        else
            if( ( CDbl( strText ) <= MAX_LIMIT_VAL ) and ( CDbl( strText ) >= 0 ) ) then
                NormalizeLimitTextEx = strText
            else
                Err.Raise 13, "NormalizeLimitTextEx", L_TYPEMISMATCH_TEXT
                NormalizeLimitTextEx = "-1"
            end if
        end if
    end if
end function

'/////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////
Main
WriteHTMLHeader( g_strDecodedServerName )
if( SHOWING_LIMITS <> dwDisplayMode ) then 
    WriteRefreshMetaTag
end if
%>
<link rel="stylesheet" type="text/css" href="<%= Session( "cssName" ) %>">
<script language="JavaScript" src="include/WMSCommon.js"></script>
<script language="JavaScript">
<!--
/*@cc_on @*/
var g_szPropertiesArgs = "";
var g_szCurPluginElementName; // do this server-side to overcome Mozilla upper-ascii escape() / unescape() bug
var g_bCurSelCanBeDuplicated;
var g_bCurSelCanBeRemoved;
var g_bCurSelSupportsEnableDisable;
var g_bCurSelSupportsProperties;
var g_bInError;
var g_bEnabled;
var g_bShowActiveScriptWarning;
var g_bAlreadySetFocus = false;

<% WriteCommonJSUtils %>

//////////////////////////////////////////////////////////////////////////
function Init()
{
    <% jsTRY %>
        SetInitialState();
        DrawCurrentToolbarSelection();
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function DrawCurrentToolbarSelection()
{
    <% jsTRY %>
        DrawEnableDisable( g_bCurSelSupportsEnableDisable, g_bEnabled, g_bInError );
        DrawDuplicate( g_bCurSelCanBeDuplicated );
        DrawRemove( g_bCurSelCanBeRemoved );
        DrawProps( g_bCurSelSupportsProperties );
        g_bToolbarLoaded = true;
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function DrawEnableDisable( bCurSelSupportsEnableDisable, bEnabled, bInError )
{
    <% jsTRY %>
        if( bCurSelSupportsEnableDisable )
        {
            EnableToolbarItem( 0, ! bEnabled || bInError );
            EnableToolbarItem( 1, bEnabled || bInError );
        }
        else
        {
            EnableToolbarItem( 0, false );
            EnableToolbarItem( 1, false );
        }
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function DrawRemove( bCurSelCanBeRemoved )
{
    <% jsTRY %>
    EnableToolbarItem( 2, bCurSelCanBeRemoved );
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function DrawDuplicate( bCurSelSupportsDuplicate )
{
    <% jsTRY %>
    EnableToolbarItem( 3, bCurSelSupportsDuplicate );
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function DrawProps( bCurSelSupportsProperties )
{
    <% jsTRY %>
    EnableToolbarItem( 4, bCurSelSupportsProperties );
    <% jsCATCH %>
}

<% if SHOWING_LIMITS = dwDisplayMode or SHOWING_GENERAL = dwDisplayMode then %>
//////////////////////////////////////////////////////////////////////////
function Cancel()
{
    <% jsTRY %>
    document.location.replace( "pubpoint_props.asp?server=<%= g_strQueryStringServer %>&ppID=<%= g_strPubPointID %>&category=<%= strCategory %>&pluginIndex=" + g_szCurPluginElementName );
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function SubmitGenCatChange( dwWhichProperty, theCheckbox, bEmulated )
{
    <% jsTRY %>
        var bChecked;
        var szExtraArgs;

        if( bEmulated )
        {
            theCheckbox.checked = ! theCheckbox.checked;
        }
        
        bChecked = theCheckbox.checked;
        
        szExtraArgs = String( "&propChange=1" );
        
        switch( dwWhichProperty )
        {
        case 30:
            szExtraArgs += "&playerCaching=";
            break;
        case 31:
            szExtraArgs += "&distCaching=";
            break;
        case 32:
            szExtraArgs += "&dirBrowsing=";
            break;
        case 34:
            szExtraArgs += "&allowStreamSplitting=";
            break;
        case 35:
            szExtraArgs += "&allowAutoStart=";
            break;
        case 36:
            szExtraArgs += "&allowStartupProfile=";
            break;
        case 37:
            szExtraArgs += "&allowVrootStart=";
            break;
            
        }
        
        if( bChecked )
        {
            szExtraArgs += "1";
        }
        else
        {
            szExtraArgs += "0";
        }
        
        document.location.replace( document.location + szExtraArgs );
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function IsValidEntry( theEditBox )
{
    <% jsTRY %>
        var szTextEdit;
        
        if( theEditBox.disabled )
        {
            return( true );
        }

        szTextEdit = new String( theEditBox.value );
        
        if ( ( "<%= L_UNLIMITED_TEXT %>" == szTextEdit ) && ( true == theEditBox.disabled ) )
        {
            return true;
        }
        
        if( "" == szTextEdit )
        {
            return false;
        }

        if( ! isFinite( szTextEdit ) )
        {
            return false;
        }
        
        if( ( "-0" == szTextEdit ) || ( 0 > szTextEdit ) )
        {
            return false;
        }

        if( 4294967295 <= szTextEdit )
        {
            return false;
        }
        
        return true;
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function AllEntriesAreValid( bAlertUserOnError )
{
    <% jsTRY %>
        var theForm;
        theForm = document.forms.mainForm;

        if( IsValidEntry( theForm.PlayerConnText ) &&
            IsValidEntry( theForm.DistConnText ) &&
            IsValidEntry( theForm.AggPlayerBWText ) &&
            IsValidEntry( theForm.AggDistBWText ) &&
            IsValidEntry( theForm.PlayerBWText ) &&
            IsValidEntry( theForm.DistBWText ) &&
            IsValidEntry( theForm.RapidStartBWText ) )
        {
            return true;
        }
        
        if( bAlertUserOnError )
        {
            window.alert( "<%= RemoveDangerousCharacters( L_PLEASEENTERVALUES_TEXT ) %>" );
        }
        
        return false;
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function EnableButtons( bAlertUserOnError )
{
    <% jsTRY %>
        var theForm;
        theForm = document.forms.mainForm;

        if( AllEntriesAreValid( bAlertUserOnError ) )
        {
            if( theForm.submit.disabled )
            {
                theForm.submit.disabled = false;
            }
            if( theForm.cancel.disabled )
            {
                theForm.cancel.disabled = false;
            }
        }
        else
        {
            if( ! theForm.submit.disabled )
            {
                theForm.submit.disabled = true;
            }
            if( theForm.cancel.disabled )
            {
                theForm.cancel.disabled = false;
            }
        }
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function InitLimits()
{
    <% jsTRY %>
        var theCheckBox;
        var theTextBox;
        
        theTextBox = document.mainForm.elements[ "PlayerConnText" ];
        theCheckBox = document.mainForm.elements[ "PlayerConnCheckbox" ];
        if( ! theCheckBox.checked )
        {
            theTextBox.disabled = true;
        }

        theTextBox = document.mainForm.elements[ "DistConnText" ];
        theCheckBox = document.mainForm.elements[ "DistConnCheckbox" ];
        if( ! theCheckBox.checked )
        {
            theTextBox.disabled = true;
        }

        theTextBox = document.mainForm.elements[ "AggPlayerBWText" ];
        theCheckBox = document.mainForm.elements[ "AggPlayerBWCheckbox" ];
        if( ! theCheckBox.checked )
        {
            theTextBox.disabled = true;
        }

        theTextBox = document.mainForm.elements[ "AggDistBWText" ];
        theCheckBox = document.mainForm.elements[ "AggDistBWCheckbox" ];
        if( ! theCheckBox.checked )
        {
            theTextBox.disabled = true;
        }

        theTextBox = document.mainForm.elements[ "RapidStartBWText" ];
        theCheckBox = document.mainForm.elements[ "RapidStartBWCheckbox" ];
        if( ! theCheckBox.checked )
        {
            theTextBox.disabled = true;
        }
        
        theTextBox = document.mainForm.elements[ "PlayerBWText" ];
        theCheckBox = document.mainForm.elements[ "PlayerBWCheckbox" ];
        if( ! theCheckBox.checked )
        {
            theTextBox.disabled = true;
        }

    <% if ( FALSE = bBroadcastPubPoint ) then %>
        theTextBox = document.mainForm.elements[ "LimitDeliveryRateText" ];
        theCheckBox = document.mainForm.elements[ "LimitDeliveryRateCheckbox" ];
        if( ! theCheckBox.checked )
        {
            theTextBox.disabled = true;
        }
    <% end if %>
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function GetFormElementID( theElement )
{
    <% jsTRY %>
        var i,dwNumElementsl
        var bFound;
        var eachElement;
        
        dwNumElements = document.mainForm.elements.length;
        
        bFound = false;
        for( i = 0; ( i < dwNumElements ) && ( ! bFound ); i++ )
        {
            eachElement = document.mainForm.elements[ i ];
            if( eachElement.name == theElement.name )
            {
                bFound = true;
                break;
            }
        }
        if( ! bFound )
        {
            return( -1 );
        }

        return( i );
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function CheckLimit( theCheckBox, theTextBox, szDefaultVal )
{
    <% jsTRY %>
        var x;
        var dwVal;
        var szVal;

        x = theTextBox.value;
        szVal = new String( x );
        if( 0 == szVal.length )
        {
            theTextBox.style.color="#000000";
            EnableButtons( false );
            return;
        }
        
        if ( "<%= L_UNLIMITED_TEXT %>" == szVal )
        {
            theCheckBox.checked = ( szDefaultVal != "<%= L_UNLIMITED_TEXT %>" );
            EnableButtons( false );
        }
        else if( "<%= L_INVALIDLIMIT_TEXT %>" != szVal )
        {
            if( isNaN( theTextBox.value ) )
            {
                theTextBox.style.color="#ff0000";
                EnableButtons( false );
                return;
            }
            
            dwVal = parseInt( szVal );
            if( ! ( ( 0 <= dwVal ) && ( 0xffffffff >= dwVal ) ) )
            {
                theTextBox.style.color="#ff0000";
                EnableButtons( false );
                return;
            }
            else
            {
                var szNewVal = new String( dwVal );
                if( theTextBox.value != szNewVal )
                {
    //                theTextBox.value = dwVal;
                }
            }
        }
        
        theTextBox.style.color="#000000";
        EnableButtons( false );
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function ToggleCheckboxEx( theCheckBox, theTextBox, szDefault )
{
    <% jsTRY %>
        var x;
        var dwVal;
        var dwCheckID, dwTextID;
        var theElement;
        var resolvedCheckBox;

        if( ! theTextBox )
        {
            return( false );
        }
        
        dwCheckID = GetFormElementID( theCheckBox );
        dwTextID = GetFormElementID( theTextBox );
        
        resolvedCheckBox = document.mainForm.elements[ dwCheckID ];

        if( resolvedCheckBox.checked )
        {
            theElement = document.mainForm.elements[ dwTextID ];

            theElement.disabled = false;
            theElement.value = szDefault;
            theElement.focus();
        }
        else
        {
            theElement = document.mainForm.elements[ dwTextID ];

            theElement.disabled = true;
            theElement.value = szDefault;
        }
        
        EnableButtons( false );
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function ToggleCheckbox( theCheckBox, theTextBox )
{
    <% jsTRY %>
        var x;
        var dwVal;
        var dwCheckID, dwTextID;
        var theElement;
        var resolvedCheckBox;

        if( ! theTextBox )
        {
            return( false );
        }
        
        dwCheckID = GetFormElementID( theCheckBox );
        dwTextID = GetFormElementID( theTextBox );
        
        resolvedCheckBox = document.mainForm.elements[ dwCheckID ];

        if( resolvedCheckBox.checked )
        {
            theElement = document.mainForm.elements[ dwTextID ];

            theElement.disabled = false;
            theElement.value = "";
            theElement.focus();
        }
        else
        {
            theElement = document.mainForm.elements[ dwTextID ];

            theElement.disabled = true;
            theElement.value = "<%= L_UNLIMITED_TEXT %>";
        }
        
        EnableButtons( false );
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function GetPropertyDescription( dwWhichProperty )
{
    <% jsTRY %>
        var win = null;
        var bReplace = true;
        var szWinName;
        
        szWinName = "PropertyDescription";
        
        szUrl = "../plugins/plugin_description.asp?server=<%= g_strQueryStringServer %>&limit=" + dwWhichProperty;
        
        if( ( <%= PPLIMDESCOFFSET %> <= dwWhichProperty ) && ( ( dwWhichProperty < ( <%= PPLIMDESCOFFSET %> + 17 ) ) || ( ( dwWhichProperty >= 30 ) && ( dwWhichProperty <= 38 ) ) ) )
        {
        <% if( brMSIE <> g_dwBrowserType ) then %>
            var szFeatures = "resizable,scrollbars=yes,height=<%= DESCRIPTIONDLGHEIGHT %>,width=350px<%'= DESCRIPTIONDLGWIDTH %>,outerHeight=<%= DESCRIPTIONDLGHEIGHT %>,innerHeight=<%= DESCRIPTIONDLGHEIGHT %>,outerWidth=<%= DESCRIPTIONDLGWIDTH %>,innerWidth=<%= DESCRIPTIONDLGWIDTH %>";
            win = window.open( szUrl, szWinName, szFeatures, true );
            if( ! win )
            {
                win = window.open( szUrl, szWinName, szFeatures, true );
            }
            else
            {
                win.focus();
            }
        <% else %>
            var szFeatures = "resizable:yes;status:no;help:no;scroll:yes;dialogHeight:<%= DESCRIPTIONDLGHEIGHT %>;dialogWidth:<%= DESCRIPTIONDLGWIDTH %>;edge:raised;center:yes";
            showModalDialog( szUrl, null, szFeatures )
        <% end if %>
        }
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function GetLimitDescription( dwWhichLimit )
{
    <% jsTRY %>
        var win = null;
        var bReplace = true;
        var szWinName;
        
        szWinName = "PluginDescription";
        
        szUrl = "../plugins/plugin_description.asp?server=<%= g_strQueryStringServer %>&limit=" + dwWhichLimit;
        
        if( ( <%= PPLIMDESCOFFSET %> <= dwWhichLimit ) && ( ( dwWhichLimit < ( <%= PPLIMDESCOFFSET %> + 17 ) ) || ( ( dwWhichLimit >= 30 ) && ( dwWhichLimit <= 35 ) ) ) )
        {
        <% if( brMSIE <> g_dwBrowserType ) then %>
            var szFeatures = "resizable,scrollbars=yes,height=<%= DESCRIPTIONDLGHEIGHT %>,width=350px<%'= DESCRIPTIONDLGWIDTH %>,outerHeight=<%= DESCRIPTIONDLGHEIGHT %>,innerHeight=<%= DESCRIPTIONDLGHEIGHT %>,outerWidth=<%= DESCRIPTIONDLGWIDTH %>,innerWidth=<%= DESCRIPTIONDLGWIDTH %>";
            win = window.open( szUrl, szWinName, szFeatures, true );
            if( ! win )
            {
                win = window.open( szUrl, szWinName, szFeatures, true );
            }
            else
            {
                win.focus();
            }
        <% else %>
            var szFeatures = "resizable:yes;status:no;help:no;scroll:yes;dialogHeight:<%= DESCRIPTIONDLGHEIGHT %>;dialogWidth:<%= DESCRIPTIONDLGWIDTH %>;edge:raised;center:yes";
            showModalDialog( szUrl, null, szFeatures )
        <% end if %>
        }
    <% jsCATCH %>
}

<% elseif ( SHOWING_CREDENTIALS = dwDisplayMode ) then %>
//////////////////////////////////////////////////////////////////////////
function GetCredentialsDescription( dwWhichLimit )
{
    <% jsTRY %>
        var win = null;
        var bReplace = true;
        var szWinName;
        
        szWinName = "PluginDescription";
        
        szUrl = "../plugins/plugin_description.asp?server=<%= g_strQueryStringServer %>&credentials=" + dwWhichLimit;
        
        if( ( 0 <= dwWhichLimit ) && ( dwWhichLimit < 6 ) )
        {
        <% if( brMSIE <> g_dwBrowserType ) then %>
            var szFeatures = "resizable,scrollbars=yes,height=<%= DESCRIPTIONDLGHEIGHT %>,width=350px<%'= DESCRIPTIONDLGWIDTH %>,outerHeight=<%= DESCRIPTIONDLGHEIGHT %>,innerHeight=<%= DESCRIPTIONDLGHEIGHT %>,outerWidth=<%= DESCRIPTIONDLGWIDTH %>,innerWidth=<%= DESCRIPTIONDLGWIDTH %>";
            win = window.open( szUrl, szWinName, szFeatures, true );
            if( ! win )
            {
                win = window.open( szUrl, szWinName, szFeatures, true );
            }
            else
            {
                win.focus();
            }
        <% else %>
            var szFeatures = "resizable:yes;status:no;help:no;scroll:yes;dialogHeight:<%= DESCRIPTIONDLGHEIGHT %>;dialogWidth:<%= DESCRIPTIONDLGWIDTH %>;edge:raised;center:yes";
            showModalDialog( szUrl, null, szFeatures )
        <% end if %>
        }
    <% jsCATCH %>
}

<% elseif ( SHOWING_CACHEPROXYMGMT = dwDisplayMode ) then %>
//////////////////////////////////////////////////////////////////////////
function GetCacheProxyDescription( dwWhichProp )
{
    <% jsTRY %>
        var win = null;
        var bReplace = true;
        var szWinName;
        
        szWinName = "PluginDescription";
        
        szUrl = "../plugins/plugin_description.asp?server=<%= g_strQueryStringServer %>&cacheproxyexp<% if FALSE = bBroadcastPubPoint then %>OD<% end if %>=" + dwWhichProp;
        
        if( ( 0 <= dwWhichProp ) && ( dwWhichProp < 6 ) )
        {
        <% if( brMSIE <> g_dwBrowserType ) then %>
            var szFeatures = "resizable,scrollbars=yes,height=<%= DESCRIPTIONDLGHEIGHT %>,width=350px<%'= DESCRIPTIONDLGWIDTH %>,outerHeight=<%= DESCRIPTIONDLGHEIGHT %>,innerHeight=<%= DESCRIPTIONDLGHEIGHT %>,outerWidth=<%= DESCRIPTIONDLGWIDTH %>,innerWidth=<%= DESCRIPTIONDLGWIDTH %>";
            win = window.open( szUrl, szWinName, szFeatures, true );
            if( ! win )
            {
                win = window.open( szUrl, szWinName, szFeatures, true );
            }
            else
            {
                win.focus();
            }
        <% else %>
            var szFeatures = "resizable:yes;status:no;help:no;scroll:yes;dialogHeight:<%= DESCRIPTIONDLGHEIGHT %>;dialogWidth:<%= DESCRIPTIONDLGWIDTH %>;edge:raised;center:yes";
            showModalDialog( szUrl, null, szFeatures )
        <% end if %>
        }
    <% jsCATCH %>
}

<% elseif ( SHOWING_NETWORKING = dwDisplayMode ) then %>
//////////////////////////////////////////////////////////////////////////
function GetNetworkingDescription( dwWhichProp )
{
    <% jsTRY %>
        var win = null;
        var bReplace = true;
        var szWinName;
        
        szWinName = "PluginDescription";
        
        szUrl = "../plugins/plugin_description.asp?server=<%= g_strQueryStringServer %>&networking=" + dwWhichProp;
        
        if( ( 0 <= dwWhichProp ) && ( dwWhichProp < 6 ) )
        {
        <% if( brMSIE <> g_dwBrowserType ) then %>
            var szFeatures = "resizable,scrollbars=yes,height=<%= DESCRIPTIONDLGHEIGHT %>,width=350px<%'= DESCRIPTIONDLGWIDTH %>,outerHeight=<%= DESCRIPTIONDLGHEIGHT %>,innerHeight=<%= DESCRIPTIONDLGHEIGHT %>,outerWidth=<%= DESCRIPTIONDLGWIDTH %>,innerWidth=<%= DESCRIPTIONDLGWIDTH %>";
            win = window.open( szUrl, szWinName, szFeatures, true );
            if( ! win )
            {
                win = window.open( szUrl, szWinName, szFeatures, true );
            }
            else
            {
                win.focus();
            }
        <% else %>
            var szFeatures = "resizable:yes;status:no;help:no;scroll:yes;dialogHeight:<%= DESCRIPTIONDLGHEIGHT %>;dialogWidth:<%= DESCRIPTIONDLGWIDTH %>;edge:raised;center:yes";
            showModalDialog( szUrl, null, szFeatures )
        <% end if %>
        }
    <% jsCATCH %>
}

<% elseif ( SHOWING_CREDENTIALS = dwDisplayMode ) then %>
//////////////////////////////////////////////////////////////////////////
function GetCredentialsDescription( dwWhichLimit )
{
    <% jsTRY %>
        var win = null;
        var bReplace = true;
        var szWinName;
        
        szWinName = "PluginDescription";
        
        szUrl = "../plugins/plugin_description.asp?server=<%= g_strQueryStringServer %>&cat=<%= CAT_CRED %>";
        
        if( ( 0 <= dwWhichLimit ) && ( dwWhichLimit < 6 ) )
        {
        <% if( brMSIE <> g_dwBrowserType ) then %>
            var szFeatures = "resizable,scrollbars=yes,height=<%= DESCRIPTIONDLGHEIGHT %>,width=350px<%'= DESCRIPTIONDLGWIDTH %>,outerHeight=<%= DESCRIPTIONDLGHEIGHT %>,innerHeight=<%= DESCRIPTIONDLGHEIGHT %>,outerWidth=<%= DESCRIPTIONDLGWIDTH %>,innerWidth=<%= DESCRIPTIONDLGWIDTH %>";
            win = window.open( szUrl, szWinName, szFeatures, true );
            if( ! win )
            {
                win = window.open( szUrl, szWinName, szFeatures, true );
            }
            else
            {
                win.focus();
            }
        <% else %>
            var szFeatures = "resizable:yes;status:no;help:no;scroll:yes;dialogHeight:<%= DESCRIPTIONDLGHEIGHT %>;dialogWidth:<%= DESCRIPTIONDLGWIDTH %>;edge:raised;center:yes";
            showModalDialog( szUrl, null, szFeatures )
        <% end if %>
        }
    <% jsCATCH %>
}

<% elseif ( SHOWING_WIRELESS = dwDisplayMode ) then %>
//////////////////////////////////////////////////////////////////////////
function GetWirelessDescription( dwWhichLimit )
{
    <% jsTRY %>
        var win = null;
        var bReplace = true;
        var szWinName;
        
        szWinName = "PluginDescription";
        
        szUrl = "../plugins/plugin_description.asp?server=<%= g_strQueryStringServer %>&wireless=" + String( dwWhichLimit );
        
        if( 0 == dwWhichLimit )
        {
        <% if( brMSIE <> g_dwBrowserType ) then %>
            var szFeatures = "resizable,scrollbars=yes,height=<%= DESCRIPTIONDLGHEIGHT %>,width=350px<%'= DESCRIPTIONDLGWIDTH %>,outerHeight=<%= DESCRIPTIONDLGHEIGHT %>,innerHeight=<%= DESCRIPTIONDLGHEIGHT %>,outerWidth=<%= DESCRIPTIONDLGWIDTH %>,innerWidth=<%= DESCRIPTIONDLGWIDTH %>";
            win = window.open( szUrl, szWinName, szFeatures, true );
            if( ! win )
            {
                win = window.open( szUrl, szWinName, szFeatures, true );
            }
            else
            {
                win.focus();
            }
        <% else %>
            var szFeatures = "resizable:yes;status:no;help:no;scroll:yes;dialogHeight:<%= DESCRIPTIONDLGHEIGHT %>;dialogWidth:<%= DESCRIPTIONDLGWIDTH %>;edge:raised;center:yes";
            showModalDialog( szUrl, null, szFeatures )
        <% end if %>
        }
    <% jsCATCH %>
}

<% elseif ( SHOWING_PLUGINS = dwDisplayMode ) then %>

//////////////////////////////////////////////////////////////////////////
function GetPluginDescription( szInstance )
{
    <% jsTRY %>
        var szInstance;
        var win = null;
        var bReplace = true;
        var szWinName;
        
        szWinName = "PluginDescription";
        
        szUrl = "../plugins/plugin_description.asp?server=<%= g_strQueryStringServer %>&ppID=<%= g_strPubPointID %>&category=" + "<%= strCategory %>&pluginIndex="  + szInstance;
        
        if( ( null != szInstance ) && ( 0 < szInstance.length ) )
        {
        <% if( brMSIE <> g_dwBrowserType ) then %>
            var szFeatures = "resizable,scrollbars=yes,height=<%= DESCRIPTIONDLGHEIGHT %>,width=350px<%'= DESCRIPTIONDLGWIDTH %>,outerHeight=<%= DESCRIPTIONDLGHEIGHT %>,innerHeight=<%= DESCRIPTIONDLGHEIGHT %>,outerWidth=<%= DESCRIPTIONDLGWIDTH %>,innerWidth=<%= DESCRIPTIONDLGWIDTH %>";
            win = window.open( szUrl, szWinName, szFeatures, true );
            if( ! win )
            {
                win = window.open( szUrl, szWinName, szFeatures, true );
            }
        <% else %>
            var szFeatures = "resizable:yes;status:no;help:no;scroll:yes;dialogHeight:<%= DESCRIPTIONDLGHEIGHT %>;dialogWidth:<%= DESCRIPTIONDLGWIDTH %>;edge:raised;center:yes";
            showModalDialog( szUrl, null, szFeatures )
        <% end if %>
        }
    <% jsCATCH %>
}
<% end if %>

//////////////////////////////////////////////////////////////////////////
function HilightCurrentCat( theEvent )
{
    <% jsTRY %>
<% if( brMSIE = g_dwBrowserType ) then %>
        if( 0 == theEvent.keyCode )
<% else %>
        if( 0 == theEvent.which )            
<% end if %>
        {
            return;
        }
        
        var i = <%= iFormSelect %>;
        document.mainForm.type[ i ].style.backgroundColor = "#6699ff";
        if( document.mainForm.type.selectedIndex != <%= iFormSelect %> )
        {
            document.mainForm.type.style.backgroundColor = "#F5F5F5";
        }
        else
        {
            document.mainForm.type.style.backgroundColor = "white";
        }
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function PluginTypeSelected( <% if( brMSIE <> g_dwBrowserType ) then %>event, <% end if %>bClick )
{
    <% jsTRY %>
        if( false == bClick )
        {
            // user entered a key
<% if( brMSIE = g_dwBrowserType ) then %>
            if( event.keyCode != 13 )
<% else %>
            if( event.which != 13 )            
<% end if %>
            {
                HilightCurrentCat( event );
                return;
            }
        }
        var i = document.mainForm.type.selectedIndex;
        var szNewLocation = "";
        <% 
        Dim strNewQueryString
        strNewQueryString = "pubpoint_props.asp?server=" & g_strQueryStringServer & "&ppID=" & g_strPubPointID & "&category="
        %>

        switch( i )
        {
            case <%= iGeneral %>: //(GENERAL)
                szNewLocation = "<%= strNewQueryString %><%= CAT_GEN %>";
                break;
            case <%= iAuthorizers %>:
                szNewLocation = "<%= strNewQueryString %><%= CAT_AUTHORIZE %>";
                break;
            case <%= iLogging %>:
                szNewLocation = "<%= strNewQueryString %><%= CAT_LOGGING %>";
                break;
            case <%= iEvent %>:
                szNewLocation = "<%= strNewQueryString %><%= CAT_EVENT %>";
                break;
            case <%= iAuthen %>:
                szNewLocation = "<%= strNewQueryString %><%= CAT_AUTHEN %>";
                break;
            case <%= iLimits %>: //(LIMITS)
                szNewLocation = "<%= strNewQueryString %><%= CAT_LIM %>";
                break;
    <% if( blnRunningOnWhistlerAdvServer ) then %>
            case <%= iWireless %>: //(WIRELESS)
                szNewLocation = "<%= strNewQueryString %><%= CAT_WIRELESS %>";
                break;
    <% end if %>
    <% if FALSE = bCacheProxyPubPoint then %>
            case <%= iPlXform %>:
                szNewLocation = "<%= strNewQueryString %><%= CAT_PLAYXFORM %>";
                break;
            case <%= iCPMgmt %>:
                szNewLocation = "<%= strNewQueryString %><%= CAT_CACHEPROXYMGMT %>";
                break;
    <% end if %>
    <% if ( FALSE = bCacheProxyPubPoint ) and ( TRUE = bBroadcastPubPoint ) then %>
            case <%= iArchivers %>:
                szNewLocation = "<%= strNewQueryString %><%= CAT_ARCH %>";
                break;
        <% if( ( FALSE = bCacheProxyPubPoint ) and blnRunningOnWhistlerAdvServer ) then %>
            case <%= iMCast %>:
                szNewLocation = "<%= strNewQueryString %><%= CAT_MCAST %>";
                break;
        <% end if %>
    <% end if %>
    <% if ( FALSE = bCacheProxyPubPoint ) then %>
            case <%= iCredentials %>:
                szNewLocation = "<%= strNewQueryString %><%= CAT_CRED %>";
                break;
    <% end if %>
            case <%= iNetworking %>:
                szNewLocation = "<%= strNewQueryString %><%= CAT_NET %>";
                break;
            default:
                window.alert( "<%= RemoveDangerousCharacters( L_ILLEGALSELECTION_TEXT ) %>" );
                document.location = document.location;
                break;
        }
        document.location.replace( szNewLocation );
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function SetFocusToCategory( dwNumTimesEntered )
{
<% if ( SHOWING_PLUGINS = dwDisplayMode ) then %>
//    return;
<% end if %>
    <% jsTRY %>
    <% if( ( SHOWING_PLUGINS = dwDisplayMode ) or ( SHOWING_CREDENTIALS = dwDisplayMode ) or ( SHOWING_CACHEPROXYMGMT = dwDisplayMode ) or ( SHOWING_NETWORKING = dwDisplayMode ) ) then %>
        if( ( null == GetCheckedItem() ) && ( document.mainForm.length ) )
        {
            var objPlugin;
    <% if SHOWING_PLUGINS = dwDisplayMode then %>
            document.mainForm.type.focus();
            return;
    <% elseif SHOWING_CREDENTIALS = dwDisplayMode then %>
            objPlugin = document.mainForm.credentials[ 0 ];
    <% elseif SHOWING_CACHEPROXYMGMT = dwDisplayMode then %>
            objPlugin = document.mainForm.cacheproxymgmt[ 0 ];
    <% elseif SHOWING_NETWORKING = dwDisplayMode then %>
            objPlugin = document.mainForm.networking[ 0 ];
    <% end if %>
            if( objPlugin )
            {
                objPlugin.checked = true;
            }
        }
    <% end if %>
        
        if( g_bAlreadySetFocus )
        {
            return;
        }
        
    <% if( brMSIE = g_dwBrowserType ) then %>
        if( document.activeElement.tagName != "SELECT" )
        {
            document.mainForm.type.focus();
            if( dwNumTimesEntered < 3 )
            {
                dwNumTimesEntered = dwNumTimesEntered + 1
                setTimeout( "SetFocusToCategory( " + dwNumTimesEntered + " )", 500, "JavaScript" );
            }
            return;
        }
    <% end if %>
        document.mainForm.type.focus();

    <% if SHOWING_LIMITS = dwDisplayMode then %>
        InitLimits();
    <% end if %>

    <% if ( "" <> qs("AutoStartPPCheckbox") ) then %>
        if( ( document.forms.mainForm.AutoStartPPCheckbox ) && ( ! document.forms.mainForm.AutoStartPPCheckbox.disabled ) )
        {
            document.forms.mainForm.AutoStartPPCheckbox.disabled = false;
            document.forms.mainForm.AutoStartPPCheckbox.focus();
        }
    <% end if %>
        g_bAlreadySetFocus = true;
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function HilightType()
{
    <% jsTRY %>
    <%if -1 <> iFormSelect then %>
    document.mainForm.type.options[ <%=iFormSelect%> ].selected = 1
    <%end if %>
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function WarnNoProps()
{
    <% jsTRY %>
    window.alert( "<%= RemoveDangerousCharacters( L_NOPROPERTYPAGE_TEXT ) %>" );
    <% jsCATCH %>
}

<% if SHOWING_PLUGINS = dwDisplayMode then %>
//////////////////////////////////////////////////////////////////////////
function HandlePluginClick( dwSpecifiedPluginIndex )
{
    <% jsTRY %>
    if( ( null != dwSpecifiedPluginIndex ) && ( 0 < dwSpecifiedPluginIndex.length ) )
    {
        document.location.replace( "../plugins/plugin_action.asp?server=<%= g_strQueryStringServer %>" + "&op=properties&category=" + "<%= strCategory %>" + "&pluginIndex=" + dwSpecifiedPluginIndex + "&ppID=<%= g_strPubPointID %>" + g_szPropertiesArgs );
    }
    else
    {
        window.alert( " <%= RemoveDangerousCharacters( L_PLEASESELECTAPLUGIN_TEXT ) %>" );
    }
    <% jsCATCH %>
}
<% end if %>

//////////////////////////////////////////////////////////////////////////
function Properties()
{
    <% jsTRY %>
<% if SHOWING_PLUGINS = dwDisplayMode then %>
    <% if( brMSIE = g_dwBrowserType ) then %>
    if( ! g_bCurSelSupportsProperties )
    {
        return;
    }
    <% end if %>
    var theItem;
    theItem = document.getElementById( g_szCurPluginElementName );
    if( theItem )
    {   <% if( brMSIE <> g_dwBrowserType ) then %>
        var szPropKey = new String( theItem.getAttribute( "proppage" ) );
        if( 0 == szPropKey.length )
        {
            WarnNoProps();
        }
        else
        {
            theItem.onclick();
        }
        <% else %>
        document.getElementById( g_szCurPluginElementName ).click();
        <% end if %>
    }
    return;
<% else %>
    var szInstance;    
    szInstance = new String( GetCheckedItem() );
    if( ( null != szInstance ) && ( 0 < szInstance.length ) )
    {
<% if SHOWING_CREDENTIALS = dwDisplayMode then %>
        document.location = "networking.asp?server=<%= g_strQueryStringServer %>" + "&op=properties&category=" + "<%= strCategory %>" + "&instance=" + szInstance + "&ppID=<%= g_strPubPointID %>";
<% elseif SHOWING_NETWORKING = dwDisplayMode then %>
        document.location = "networking.asp?server=<%= g_strQueryStringServer %>" + "&op=properties&category=" + "<%= strCategory %>" + "&instance=" + szInstance + "&ppID=<%= g_strPubPointID %>";
<% elseif SHOWING_CACHEPROXYMGMT = dwDisplayMode then %>
        document.location = "cacheexpiration.asp?server=<%= g_strQueryStringServer %>" + "&op=properties&category=" + "<%= strCategory %>" + "&instance=" + szInstance + "&ppID=<%= g_strPubPointID %>";
<% else' if SHOWING_WIRELESS = dwDisplayMode then %>
        document.location = "wireless.asp?server=<%= g_strQueryStringServer %>" + "&op=properties&category=" + "<%= strCategory %>" + "&ppID=<%= g_strPubPointID %>";
<% end if %>
    }
    else
    {
<% if SHOWING_WIRELESS = dwDisplayMode then %>
        document.location = "wireless.asp?server=<%= g_strQueryStringServer %>" + "&op=properties&category=" + "<%= strCategory %>" + "&instance=" + SafeEscape( "<%= L_FECNAME_TEXT %>" ) + "&ppID=<%= g_strPubPointID %>";
<% else %>
        window.alert( " <%= RemoveDangerousCharacters( L_PLEASESELECTAPLUGIN_TEXT ) %>" );
<% end if %>
    }
<% end if %>
    <% jsCATCH %>
} 

//////////////////////////////////////////////////////////////////////////
function Refresh()
{
    <% jsTRY %>
<% if SHOWING_PLUGINS = dwDisplayMode then %>
    if( ( null != g_szCurPluginElementName ) && ( 0 < g_szCurPluginElementName.length ) )
    {
        document.location.replace( "../plugins/plugin_action.asp?server=<%= g_strQueryStringServer %>&op=refresh&category=<%=strCategory%>&pluginIndex=" + g_szCurPluginElementName + "&ppID=<%= g_strPubPointID %>" );
    }
<% else %>
    var szInstance;
    szInstance = new String( GetCheckedItem() );
    if( ( null != szInstance ) && ( 0 < szInstance.length ) )
    {
        document.location.replace( "../plugins/plugin_action.asp?server=<%= g_strQueryStringServer %>&op=refresh&category=<%=strCategory%>&instance=" + szInstance + "&ppID=<%= g_strPubPointID %>" );
    }
<% end if %>
    else
    {
        document.location = document.location;
    }
    <% jsCATCH %>
} 

//////////////////////////////////////////////////////////////////////////
function ClickRadio( dwItem )
{
    <% jsTRY %>
    var e;
    
    if( dwItem < 0 )
    {
        return;
    }

    //if length is defined, iterate over the elements
    if( document.forms.mainForm.length )
    {
    <% if SHOWING_PLUGINS = dwDisplayMode then %>
        e = document.forms.mainForm.plugins[ dwItem ];
    <% elseif SHOWING_CREDENTIALS = dwDisplayMode then %>
        e = document.forms.mainForm.credentials[ dwItem ];
    <% elseif SHOWING_NETWORKING = dwDisplayMode then %>
        e = document.forms.mainForm.networking[ dwItem ];
    <% elseif SHOWING_CACHEPROXYMGMT = dwDisplayMode then %>
        e = document.forms.mainForm.cacheproxymgmt[ dwItem ];
    <% elseif SHOWING_WIRELESS = dwDisplayMode then %>
        e = document.forms.mainForm.wireless[ dwItem ];
    <% end if %>
        if( e )
        {
            e.checked = true;
        }
        return;
    }
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function GetCheckedItem()
{
    <% jsTRY %>
    var i;
    var e;
    
    //if length is defined, iterate over the elements
    if(document.forms.mainForm.length)
    {
<% if SHOWING_PLUGINS = dwDisplayMode then %>
        return( g_szCurPluginElementName );
<% else %>
<% if SHOWING_CREDENTIALS = dwDisplayMode then %>
        for(i = 0; i < document.forms.mainForm.credentials.length; i++)
<% elseif SHOWING_NETWORKING = dwDisplayMode then %>
        for(i = 0; i < document.forms.mainForm.networking.length; i++)
<% elseif SHOWING_CACHEPROXYMGMT = dwDisplayMode then %>
        for(i =0; i < document.forms.mainForm.cacheproxymgmt.length; i++)
<% else' if SHOWING_WIRELESS = dwDisplayMode then %>
        for(i = 0; i < document.forms.mainForm.wireless.length; i++)
<% end if %>
        {
<% if SHOWING_CREDENTIALS = dwDisplayMode then %>
            e = document.mainForm.credentials[i];
<% elseif SHOWING_NETWORKING = dwDisplayMode then %>
            e = document.mainForm.networking[i];
<% elseif SHOWING_CACHEPROXYMGMT = dwDisplayMode then %>
            e = document.mainForm.cacheproxymgmt[i];
<% elseif SHOWING_WIRELESS = dwDisplayMode then %>
            e = document.forms.mainForm.wireless[i];
<% end if %>
            if( e )
            {
                if (e.checked) 
                {<% if brMSIE = g_dwBrowserType then %>
                    return( SafeEscape( e.value ) );
                 <% else %>
                    return( e.value );
                 <% end if %>
                }   
            }
        }
    //length isn't defined, so there's only the dummy element
<% end if %>
    }
    return null;
    <% jsCATCH %>
}

<% if SHOWING_PLUGINS = dwDisplayMode then %>
//////////////////////////////////////////////////////////////////////////
function Rename()
{
    <% jsTRY %>
    var szNewName;
    szNewName = "";
    
    var szInstance;
    szInstance = new String( GetCheckedItem() );
    if( ( null != szInstance ) && ( 0 < szInstance.length ) )
    {
        document.location = "../plugins/plugin_dialog.asp?server=<%= g_strQueryStringServer %>&ppID=<%= g_strPubPointID %>&op=rename&category=<%= strCategory %>&pluginIndex=" + g_szCurPluginElementName + "&instance=" + szInstance;
        return;
    }
    else
    {
        window.alert( " <%= RemoveDangerousCharacters( L_PLEASESELECTAPLUGIN_TEXT ) %>" );
    }
    <% jsCATCH %>
}
<% end if %>

//////////////////////////////////////////////////////////////////////////
function HandlePendingOp()
{
    <% jsTRY %>
    if( "<%= EscBackslashChar( qs("pendingOp") ) %>" == "enable" )
    {
        g_bShowActiveScriptWarning = false;
        Enable();
    }
    <% jsCATCH %>
}


<% if SHOWING_PLUGINS = dwDisplayMode then %>
//////////////////////////////////////////////////////////////////////////
function Enable()
{
    <% jsTRY %>
    if( g_bCurSelSupportsEnableDisable && g_bEnabled && ! g_bInError )
    {
        return;
    }

    var szPluginIndex = -1;
    var bRedirectToProperties = false;

    if( g_bShowActiveScriptWarning )
    {
        bRedirectToProperties = window.confirm( "<%= RemoveDangerousCharacters( L_NOASCRIPTFILENAME_TEXT ) %>" );
    }
    if( bRedirectToProperties )
    {
        g_szPropertiesArgs = "&pendingOp=enable";
        Properties();
    }
    else
    {
        document.location = "pubpoint_props.asp?server=<%= g_strQueryStringServer %>" + "&op=enable&category=<%= strCategory %>&pluginIndex=" + g_szCurPluginElementName + "&ppID=<%= g_strPubPointID %>";
    }
    <% jsCATCH %>
}
<% else %>
//////////////////////////////////////////////////////////////////////////
function Enable()
{
    <% jsTRY %>
    if( g_bCurSelSupportsEnableDisable && g_bEnabled && ! g_bInError )
    {
        return;
    }

    var szInstance;
    szInstance = new String( GetCheckedItem() );
    if( ( null != szInstance ) && ( 0 < szInstance.length ) )
    {
<% if SHOWING_CREDENTIALS = dwDisplayMode then %>
        document.location = "networking.asp?server=<%= g_strQueryStringServer %>" + "&op=enable&category=" + "<%= strCategory %>" + "&instance=" + szInstance + "&ppID=<%= g_strPubPointID %>";
<% elseif SHOWING_NETWORKING = dwDisplayMode then %>
        document.location = "networking.asp?server=<%= g_strQueryStringServer %>" + "&op=enable&category=" + "<%= strCategory %>" + "&instance=" + szInstance + "&ppID=<%= g_strPubPointID %>";
<% elseif SHOWING_WIRELESS = dwDisplayMode then %>
        document.location = "wireless.asp?server=<%= g_strQueryStringServer %>" + "&op=enable&category=" + "<%= strCategory %>" + "&ppID=<%= g_strPubPointID %>";
<% end if %>
    }
    else
    {
        window.alert( " <%= RemoveDangerousCharacters( L_PLEASESELECTAPLUGIN_TEXT ) %>" );
    }
    <% jsCATCH %>
}
<% end if %>

//////////////////////////////////////////////////////////////////////////
function Disable()
{
    <% jsTRY %>
    if( ( ! g_bCurSelSupportsEnableDisable ) || ! g_bEnabled && ! g_bInError )
    {
        return;
    }
    
<% if SHOWING_PLUGINS = dwDisplayMode then %>
    document.location = "../plugins/plugin_action.asp?server=<%= g_strQueryStringServer %>" + "&op=disable&category=<%= strCategory %>&pluginIndex=" + g_szCurPluginElementName + "&referrer=<%= Server.URLEncode("../pubpoints/pubpoint_props.asp") %>&ppID=<%= g_strPubPointID %>";
<% else %>
    var szInstance;
    szInstance = new String( GetCheckedItem() );
    if( ( null != szInstance ) && ( 0 < szInstance.length ) )
    {
<% if SHOWING_CREDENTIALS = dwDisplayMode then %>
        document.location = "networking.asp?server=<%= g_strQueryStringServer %>" + "&op=disable&category=" + "<%= strCategory %>" + "&instance=" + szInstance + "&referrer=<%= Server.URLEncode("../pubpoints/pubpoint_props.asp") %>&ppID=<%= g_strPubPointID %>";
<% elseif SHOWING_NETWORKING = dwDisplayMode then %>
        document.location = "networking.asp?server=<%= g_strQueryStringServer %>" + "&op=disable&category=" + "<%= strCategory %>" + "&instance=" + szInstance + "&referrer=<%= Server.URLEncode("../pubpoints/pubpoint_props.asp") %>&ppID=<%= g_strPubPointID %>";
<% else' if SHOWING_WIRELESS = dwDisplayMode then %>
        document.location = "wireless.asp?server=<%= g_strQueryStringServer %>" + "&op=disable&category=" + "<%= strCategory %>" + "&referrer=<%= Server.URLEncode("../pubpoints/pubpoint_props.asp") %>&ppID=<%= g_strPubPointID %>";
<% end if %>
    }
    else
    {
        window.alert( " <%= RemoveDangerousCharacters( L_PLEASESELECTAPLUGIN_TEXT ) %>" );
    }
<% end if %>
    <% jsCATCH %>
}

<% if SHOWING_PLUGINS = dwDisplayMode then %>
//////////////////////////////////////////////////////////////////////////
function Remove()
{
    <% jsTRY %>
    if( ! g_bCurSelCanBeRemoved )
    {
        return;
    }

    var szPluginIndex;
    szPluginIndex = new String( GetCheckedItem() );
    if( ( null != szPluginIndex ) && ( 0 < szPluginIndex.length ) )
    {
        document.location = "../plugins/plugin_action.asp?server=<%= g_strQueryStringServer %>" + "&ppID=<%= g_strPubPointID %>&op=remove&category=<%= strCategory %>&pluginIndex=" + szPluginIndex;
    }
    else
    {
        window.alert( " <%= RemoveDangerousCharacters( L_PLEASESELECTAPLUGIN_TEXT ) %>" );
    }
    <% jsCATCH %>
}

//////////////////////////////////////////////////////////////////////////
function Duplicate()
{
    <% jsTRY %>
    if( ! g_bCurSelCanBeDuplicated )
    {
        return;
    }

    var szNewName;
    szNewName = "";
    
    var szPluginIndex;
    szPluginIndex = new String( GetCheckedItem() );
    if( ( null != szPluginIndex ) && ( 0 < szPluginIndex.length ) )
    {
        document.location = "../plugins/plugin_dialog.asp?server=<%= g_strQueryStringServer %>&ppID=<%= g_strPubPointID %>&op=duplicate&category=<%= strCategory %>&pluginIndex=" + szPluginIndex;
        return;
    }
    else
    {
        window.alert( " <%= RemoveDangerousCharacters( L_PLEASESELECTAPLUGIN_TEXT ) %>" );
    }
    <% jsCATCH %>
}

    <% if bPluginRemovedError then %>
//////////////////////////////////////////////////////////////////////////
function HandleRemoveError()
{
    <% jsTRY %>
    var szNewQueryString;

    window.alert( "<%= RemoveDangerousCharacters( L_CANNOTREMOVELASTINSTANCEOFAPLUGIN_TEXT ) %>" );
    
    szNewQueryString = "&category=<%= strCategory %>&pluginIndex=<%= qs( "pluginIndex" ) %>&ppID=<%= g_strPubPointID %>";
    document.location.replace( "pubpoint_props.asp?server=<%= g_strQueryStringServer %>" + szNewQueryString );
    <% jsCATCH %>
}
    <% elseif bPluginRenamedError then %>
//////////////////////////////////////////////////////////////////////////
function HandleRenameError()
{
    <% jsTRY %>
    var szNewQueryString;

    <%if "" = qs("message") then %>
    window.alert( "<%= RemoveDangerousCharacters( L_CANNOTRENAMEPLUGINERROR_TEXT ) & "\n" & Server.HTMLEncode( qs("message") ) %>" );
    <% else %>
    window.alert( "<%= RemoveDangerousCharacters( qs("message") ) %>" );
    <% end if %>

    szNewQueryString = "&ppID=<%= g_strPubPointID %>&category=<%= strCategory %>&pluginIndex=<%= qs( "pluginIndex" ) %>";
    document.location.replace( "pubpoint_props.asp?server=<%= g_strQueryStringServer %>" + szNewQueryString );
    <% jsCATCH %>
}
    <% elseif bPluginDuplicateError then %>
//////////////////////////////////////////////////////////////////////////
function HandleDuplicateError()
{
    <% jsTRY %>
    var newQueryString;

    <%if "" = qs("message") then %>
    window.alert( "<%= RemoveDangerousCharacters( L_CANNOTDUPLICATEERROR_TEXT ) %>" );
    <% else %>
    window.alert( "<%= RemoveDangerousCharacters( qs("message") ) %>" );
    <% end if %>

    szNewQueryString = "&category=<%= strCategory %>&instance=<%= pluginIndex %>&ppID=<%= qs( "pluginIndex" ) %>";
    document.location.replace( "pubpoint_props.asp?server=<%= g_strQueryStringServer %>" + szNewQueryString );
    <% jsCATCH %>
}
    <% end if %>
<% end if %>
-->
</script>
</head>
<%
if bPluginRemovedError then
    strOnLoadProc = "HandleRemoveError();"
elseif bPluginRenamedError then
    strOnLoadProc = "HandleRenameError();"
elseif bPluginDuplicateError then
    strOnLoadProc = "HandleDuplicateError();"
else
    strOnLoadProc = "SetFocusToCategory( 0 );"
end if
%><body bgcolor="<%= colorTabLight %>" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0" onLoad="JavaScript:<%if bDriveUpdateToTreeView then %>UpdateTreeView();<% end if %><%= strOnLoadProc %>Init();<% if 0 < Len( "pendingOp" ) then %>HandlePendingOp();<% end if %>" oncontextmenu="JavaScript:event.cancelBubble=true;return false;">
<%
' Draw the page banner and tabs
if bCacheProxyPubPoint then
    DrawCacheProxyPPNameBanner L_PROPERTIESTABTITLE_TEXT
else
    DrawPPNameBanner L_PROPERTIESTABTITLE_TEXT
end if
%>
<br>
<form name="mainForm" <% if SHOWING_LIMITS = dwDisplayMode then %>method="POST" <% end if %>>
<table bgcolor="#FFFFFF" width="100%" cellspacing="5" border="0" >
    <tr>
        <td>
        <table width="100%" cellspacing="0" cellpadding="0" border=0>
        <tr>
            <td>
                <span class="helptext"><%
                if SHOWING_LIMITS = dwDisplayMode then 
                    Response.Write( L_PPPROPSHELP_TEXT )
                elseif SHOWING_PLUGINS = dwDisplayMode then
                    Response.Write( L_PUBPOINTPLUGINHELP_TEXT )
                elseif SHOWING_WIRELESS = dwDisplayMode then
                    Response.Write( L_PPWIRELESSHELP_TEXT )
                elseif SHOWING_CREDENTIALS = dwDisplayMode then
                    Response.Write( L_PPCREDWORKINGHELP_TEXT )
                elseif SHOWING_NETWORKING = dwDisplayMode then
                    Response.Write( L_PPNETWORKINGHELP_TEXT )
                elseif SHOWING_CACHEPROXYMGMT = dwDisplayMode then
                    Response.Write( L_PPCPMGMTHELP_TEXT )
                else
                    Response.Write( L_PPGENHELP_TEXT )
                end if
                %>
                </span><br>&nbsp;
            </td>
        </tr>
        </table>

        <table bgcolor="#FFFFFF" cellspacing="0" cellpadding="0"  border="0" >
        <tr valign=top>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0" border="1" bgcolor="#FFFFFF">
                <tr>
                    <td>
                        <table width="100%" cellspacing="0" cellpadding="0" border="0" bgcolor="#FFFFFF">
                        <tr>
                            <td align="center" valign="top" nowrap bgcolor="#6699ff" class="colheadertext">
                                <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0" ID="Table5"><tr><td class="colheadertext" nowrap>
                                    <%= Server.HTMLEncode( L_CATEGORY_TEXT ) %>
                                </td><% 
                                if brOpera = g_dwBrowserType then %>
                                <td>
                                <input type="button" name="<%= Server.HTMLEncode( L_GOBUTTON_TEXT ) %>" value="<%= Server.HTMLEncode( L_GOBUTTON_TEXT ) %>" tabIndex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %> onclick="JavaScript:PluginTypeSelected( <% if( brMSIE <> g_dwBrowserType ) then %>event, <% end if %>true );" ID="Button2" NAME="Button1"></td>
                                <% 
                                end if %></tr></table>
                            </td>
                        </tr>
                        <tr><%
                        Dim dwNumOptionsAvailable
                        if( bBroadcastPubPoint ) then
                            if( bCacheProxyPubPoint ) then
                                dwNumOptionsAvailable = 7
                            else
                                if TRUE = blnRunningOnWhistlerAdvServer then
                                    dwNumOptionsAvailable = 13
                                else
                                    dwNumOptionsAvailable = 11
                                end if
                            end if
                        else
                            if( bCacheProxyPubPoint ) then
                                dwNumOptionsAvailable = 7
                            else
                                if TRUE = blnRunningOnWhistlerAdvServer then
                                    dwNumOptionsAvailable = 10
                                else
                                    dwNumOptionsAvailable = 9
                                end if
                            end if
                        end if
                        %>
                            <td bgcolor="#FFFFFF" align="middle" width="100%" valign="top">
                                <select 
                                    name="type" 
                                    tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> 
                                    class="propshand" 
                                    style="BACKGROUND-COLOR: #ffffff;" 
                                    size=<%= dwNumOptionsAvailable %> 
                                    onClick="JavaScript:PluginTypeSelected( <% if( brMSIE <> g_dwBrowserType ) then %>event, <% end if %>true );" 
                                    onKeyUp="JavaScript:PluginTypeSelected( <% if( brMSIE <> g_dwBrowserType ) then %>event, <% end if %>false );"
                                >
                                    <option value="<%= Server.HTMLEncode( CAT_GEN ) %>" <% if iGeneral = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_GENERAL_TEXT ) %>
                                    <option value="<%= Server.HTMLEncode( CAT_AUTHORIZE ) %>" <% if iAuthorizers = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_AUTHORIZERS_TEXT ) %>
                                    <option value="<%= Server.HTMLEncode( CAT_LOGGING ) %>" <% if iLogging = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_LOGGING_TEXT ) %>
                                    <option value="<%= Server.HTMLEncode( CAT_EVENT ) %>" <% if iEvent = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_EVENTSPHANDLERS_TEXT ) %>
                                    <option value="<%= Server.HTMLEncode( CAT_AUTHEN ) %>" <% if iAuthen = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_AUTHENTICATION_TEXT ) %>
                                    <option value="<%= Server.HTMLEncode( CAT_LIM ) %>" <% if iLimits = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_LIMITS_TEXT ) %>
                                    <% if TRUE = blnRunningOnWhistlerAdvServer then %>
                                    <option value="<%= Server.HTMLEncode( CAT_WIRELESS ) %>" <% if iWireless = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_WIRELESS_TEXT ) %>
                                    <% end if %>
                                    <% if ( FALSE = bCacheProxyPubPoint ) then %>
                                    <option value="<%= Server.HTMLEncode( CAT_PLAYXFORM ) %>" <% if iPlXform = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_PLAYLISTSPTRANSFORM_TEXT ) %>
                                    <option value="<%= Server.HTMLEncode( CAT_CACHEPROXYMGMT ) %>" <% if iCPMgmt = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_CACHEPROX_TEXT ) %>
                                        <% if ( TRUE = bBroadcastPubPoint ) then %>
                                    <option value="<%= Server.HTMLEncode( CAT_ARCH ) %>" <% if iArchivers = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_ARCHIVESPWRITERS_TEXT ) %>
                                            <% if blnRunningOnWhistlerAdvServer then %>
                                    <option value="<%= Server.HTMLEncode( CAT_MCAST ) %>" <% if iMCast = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_MULTICASTSPWRITERS_TEXT ) %>
                                            <% end if %>
                                        <% end if %>
                                    <% end if %>
									<% if( FALSE = bCacheProxyPubPoint ) then %>
                                    <option value="<%= Server.HTMLEncode( CAT_CRED ) %>" <% if iCredentials = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_CREDENTIALS_TEXT ) %>
									<% end if %>
                                    <% if ( FALSE = bCacheProxyPubPoint ) and ( TRUE = bBroadcastPubPoint ) then %>
                                    <option value="<%= Server.HTMLEncode( CAT_NET ) %>" <% if iNetworking = iFormSelect then Response.Write( "selected" ) end if %> > <%= Server.HTMLEncode( L_NETWORKING_TEXT ) %>
                                    <% end if %>
                                </select>
                            </td>
                        </tr>
                        </table>
                    </td>
                </tr>
                </table>
            </td>
        <td valign=top >
            &nbsp;&nbsp;
        </td>

<% if ( SHOWING_PLUGINS = dwDisplayMode ) then %>
        <td valign=top >
        <table width="100%" cellspacing="0" cellpadding="0" border="1" bgcolor="#FFFFFF">
        <tr>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0" border="0" cols="3">
                <tr>
                    <td align="left" valign="top" bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_PLUGIN_TEXT ) %>
                        </td></tr></table>
                    </td>
                    <td align="center" valign="top" bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            <center>&nbsp;&nbsp;<%= Server.HTMLEncode( L_STATUS_TEXT ) %>&nbsp;&nbsp;</center>
                        </td></tr></table>
                    </td>
                    <td align="center" valign="top" bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            <center>&nbsp;&nbsp;<%= Server.HTMLEncode( L_DESCRIPTION_TEXT ) %>&nbsp;&nbsp;</center>
                        </td></tr></table>
                    </td>
                </tr>
            <%
                on error resume next
                Dim iPluginIndex
                Dim strInputName, strPluginName, strMoniker, strSingleInstance
                Dim strCurrentSubCategory
                Dim dwPluginStatusFlags
                Dim bRemoved
                Dim bEnabled
                Dim bInError
                Dim bHideNTFSAuthPlugin
                Dim bIsActiveScriptNoFilename
                Dim bSingleInstance
                Dim bSupportsPropPage
                Dim bCannotLoadRequiresAdvServer
                Dim bProcessThisPlugin

                iPluginCount = g_objPluginCollection.Count
                strPluginName = ""
                dwNumPluginsDisplayed = 0
                bCheckedAnItem = FALSE
                iPluginIndex = 0
                bHideNTFSAuthPlugin = _
                    ( ( WMS_PUBLISHING_POINT_TYPE_CACHE_PROXY_BROADCAST = dwPPType ) or _
                      ( WMS_PUBLISHING_POINT_TYPE_BROADCAST = dwPPType ) ) and _
                    ( 0 = StrComp( strCategory, CAT_AUTHORIZE ) )
                for iPluginIndex = 0 to ( iPlugincount - 1 )
                    
                    strMoniker = CStr( "" )
                    strSingleInstance = CStr( "" )
                    Set EachPlugin = g_objPluginCollection( iPluginIndex )
                    strCurrentSubCategory = ""
                    bProcessThisPlugin = TRUE
                    if( IsEmpty( EachPlugin ) ) then
                        bProcessThisPlugin = FALSE
                    elseif ( bHideNTFSAuthPlugin and ( 0 = StrComp( "{16709971-12C0-11d3-B998-006008317860}", EachPlugin.CLSID, vbTextCompare ) ) ) then
                        bProcessThisPlugin = FALSE
                    end if
                    
                    strCurrentSubCategory = EachPlugin.Properties( "SubCategory" )

                    if( bProcessThisPlugin and _
                        ( ( ( "" = strCurrentSubCategory ) and ( "" = strSubCategory ) ) or _
                        ( 0 = strcomp( strCurrentSubCategory, strSubCategory, vbTextCompare ) ) ) ) then
                        
                        dwNumPluginsDisplayed = dwNumPluginsDisplayed + 1
                        strPluginName = EachPlugin.Name
                        bRemoved = CBool( WMS_PLUGIN_REMOVE_ON_SERVICE_RESTART and EachPlugin.Status )
                        strMoniker = CStr( EachPlugin.Properties("ASPMoniker") )
                        bSupportsPropPage = CBool( 0 < Len( strMoniker ) )

                        strSingleInstance = CStr( EachPlugin.Properties( "Singleton Instance" ) )
                        bSingleInstance = CBool( ( 0 < Len( strSingleInstance ) ) and ( 0 = StrComp( "1", strSingleInstance, vbTextCompare ) ) )
                        bCannotLoadRequiresAdvServer = not blnRunningOnWhistlerAdvServer and CBool( ( WMS_PLUGIN_SUPPORT_REQUIRES_ADVANCED_SERVER = EachPlugin.SupportStatus ) )
                        dwPluginStatusFlags = EachPlugin.Status
                        bEnabled = WMS_PLUGIN_ENABLED and dwPluginStatusFlags
                        bInError = WMS_PLUGIN_ERROR and dwPluginStatusFlags
                        bIsActiveScriptNoFilename = FALSE
                        bIsActiveScriptNoFilename = NoFilenameActiveScriptPlugin( EachPlugin )
                    %>
                    <tr>
                        <td width=<%= Server.HTMLEncode( MAX_LEN_PLUGINNAME ) %> bgcolor="#FFFFFF" valign="bottom">
                            <table width="100%" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF" border="0">
                            <tr>
                                <td width="100%" nowrap>
                                    <input 
                                        type="radio" 
                                        name="plugins" 
                                        id="radio_plugin_<%= iPluginIndex %>"<%
                                    if ( not bCheckedAnItem ) then
                                        if( ( CInt( dwQueryStringPluginIndex ) = CInt( iPluginIndex ) ) or ( CInt( ( iPluginCount ) - 1 ) = CInt( iPluginIndex ) ) ) then
                                            strCurrentCheckedPluginName = "plugin_" & iPluginIndex
                                            Response.Write( " checked " )
                                            bCurSelCanBeDuplicated = ( FALSE = bSingleInstance )
                                            bCurSelSupportsProperties = bSupportsPropPage
                                            bCurSelEnabled = bEnabled
                                            bCurSelInError = bInError
                                            bCurSelIsActiveScriptNoFilename = bIsActiveScriptNoFilename
                                            bCheckedAnItem = TRUE
                                        end if
                                    end if %>
                                        onClick="JavaScript:g_bEnabled=<%= BoolToText( bEnabled ) %>;g_szCurPluginElementName='plugin_<%= iPluginIndex %>';g_bCurSelCanBeRemoved=<%= BoolToText( not bRemoved ) %>;g_bCurSelCanBeDuplicated=<%= BoolToText( not bSingleInstance ) %>;g_bCurSelSupportsProperties=<%= BoolToText( bSupportsPropPage ) %>;g_bInError=<%= BoolToText( bInError ) %>;g_bShowActiveScriptWarning=<%= BoolToText( bIsActiveScriptNoFilename ) %>;DrawCurrentToolbarSelection();" 
                                        value="<%= strPluginName %>"
                                        tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> >
                                    <label 
                                        for="radio_plugin_<%= iPluginIndex %>"
                                        tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %>
                                        class="propshand<% if bRemoved or bCannotLoadRequiresAdvServer then %>disabled<% end if %>" 
                                        style="cursor:<% if bSupportsPropPage then %>hand<% else %>default<% end if %>;"
                                        id="plugin_<%= iPluginIndex %>" 
                                        name="plugin_<%= iPluginIndex %>" 
                                        proppage="<% 
                                        if bSupportsPropPage then 
                                            Response.Write( strPluginName )
                                        end if %>" <%
                                        if not bCannotLoadRequiresAdvServer then %> 
                                        onClick="JavaScript:ClickRadio( <%= dwNumPluginsDisplayed - 1 %> );<% if bSupportsPropPage then %>HandlePluginClick( 'plugin_<%= iPluginIndex %>' );<% else %>WarnNoProps();<% end if %>g_bEnabled=<%= BoolToText( bEnabled ) %>;g_szCurPluginElementName='plugin_<%= iPluginIndex %>';g_bCurSelCanBeRemoved=<%= BoolToText( not bRemoved ) %>;g_bCurSelCanBeDuplicated=<%= BoolToText( not bSingleInstance ) %>;g_bCurSelSupportsProperties=<%= BoolToText( bSupportsPropPage ) %>;g_bInError=<%= BoolToText( bInError ) %>;g_bShowActiveScriptWarning=<%= BoolToText( bIsActiveScriptNoFilename ) %>;DrawCurrentToolbarSelection();"<% end if %>><%
                                        if( brMSIE = g_dwBrowserType ) then
                                            Response.BinaryWrite( Server.HTMLEncode( SafeUnescape( strPluginName ) )  )
                                        else
                                            Response.Write( Server.HTMLEncode( strPluginName ) )
                                        end if
                                        %></label>
                                </td>
                            </tr>
                            </table>
                        </td>
                        <td bgcolor="#FFFFFF" nowrap class="props" align="center" valign="bottom">
                            <table width="100%" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF" border="0" ID="Table6">
                            <tr>
                                <td width="100%">
                                    <% if bCannotLoadRequiresAdvServer then %>
                                    <span class="propsdisabled">&nbsp;<%= L_REQADVSERVER_TEXT %>&nbsp;</span>
                                    <% elseif bRemoved then %>
                                    <span class="propsdisabled">&nbsp;<%= L_REMOVED_TEXT %>&nbsp;</span>
                                    <% elseif bInError then %>
                                    <span class="props">&nbsp;<%= L_INERROR_TEXT %>&nbsp;</span>
                                    <% elseif bEnabled then %>
                                    <span class="props">&nbsp;<%= L_ENABLED_TEXT %>&nbsp;</span>
                                    <% else %>
                                    <span class="props">&nbsp;<%= L_DISABLED_TEXT %>&nbsp;</span>
                                    <% end if %>
                                </td>
                            </tr>
                            </table>
                        </td>
                        <td bgcolor="#FFFFFF" nowrap class="propshelp" align="center" valign="bottom">
                            <table width="100%" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF" border="0" ID="Table7">
                            <tr>
                                <td width="100%">
                                    <center>
                                    <a nowrap 
                                    oncontextmenu="JavaScript:event.cancelBubble=true;return false;" 
                                    class="propshelp" 
                                    href="JavaScript:GetPluginDescription( 'plugin_<%= iPluginIndex %>');" 
                                    tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %>
                                    ><%= Server.HTMLEncode( L_DESCRIPTION_TEXT ) %></a>
                                    </center>
                                </td>
                            </tr>
                            </table>
                        </td>
                    </tr>
                    <%
                    end if
                    %>
            <% next %>
            <% if( 0 = dwNumPluginsDisplayed ) then %>
                    <tr>
                        <td width=<%= Server.HTMLEncode( MAX_LEN_PLUGINNAME ) %> bgcolor="#FFFFFF" >
                            <div class="small">&nbsp;<%
 
                            rem Netscape won't recognize this non-break dash character and will display a question mark
                            if( brMSIE = g_dwBrowserType ) then
                                Response.Write( SpacesToNonbreak( L_NOPLUGINS_TEXT ) )
                            else
                                Response.Write( SpacesToNonbreak( Server.HTMLEncode( L_NOPLUGINSMOZILLA_TEXT ) ) )
                            end if 
                            
                            %></div>
                        </td>
                        <td bgcolor="#FFFFFF">
                            &nbsp;
                        </td>
                    </tr>
            <% elseif( ( FALSE = bCheckedAnItem ) and ( 1 = dwNumPluginsDisplayed ) ) then
                strCurrentCheckedPluginName = "plugin_" & ( iPluginIndex - 1 )
                bCurSelCanBeDuplicated = ( FALSE = bSingleInstance )
                bCurSelSupportsProperties = bSupportsPropPage
                bCurSelEnabled = bEnabled
                bCurSelInError = bInError
                bCurSelIsActiveScriptNoFilename = bIsActiveScriptNoFilename
        end if 
        %>
            </table>
            </td>
            </tr>
            </table>
            
        </td>
<% elseif SHOWING_GENERAL = dwDisplayMode then %>
        <td valign=top >
        <table width="100%" cellspacing="0" cellpadding="0" border=1>
        <tr>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0" border=0>
                <tr>
                    <td align="left" valign="top" bgcolor="#6699ff" class="colheader" colspan="2">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_NAMEVALUE_TEXT ) %>&nbsp;
                        </td></tr></table>
                    </td>
                    <td align="center" valign="top" bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            <center>&nbsp;&nbsp;<%= Server.HTMLEncode( L_DESCRIPTION_TEXT ) %>&nbsp;&nbsp;</center>
                        </td></tr></table>
                    </td>
                </tr>
    <% if not bCacheProxyPubPoint then %>
    <% if ( FALSE = bBroadcastPubPoint ) then %>
<% ' Allow player caching %>
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               id="PlayerCachingCheckbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               name="PlayerCachingCheckbox" <% IsCheckedYesNo bAllowPlayerCaching %> 
                               value=""
                               onClick="JavaScript:SubmitGenCatChange(  30, this, false );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                               >
                    </td>
                    <td nowrap align="left">
                        <label for="PlayerCachingCheckbox" class="handcursor">
                            <% RenderWithErrorCheck Server.HTMLEncode( L_GENPLAYERCACHING_TEXT ), "PlayerCaching" %>
                        </label>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" class="propshelp" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> href="JavaScript:GetPropertyDescription( 36 );"><%= Server.HTMLEncode( L_DESCRIPTION_TEXT ) %></a>
                        </div>
                    </td>
                </tr>
<% ' Allow distribution caching %>
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               id="DistributionCachingCheckbox"
                               name="DistributionCachingCheckbox" <% IsCheckedYesNo bAllowDistributionCaching %> 
                               value=""
                               onClick="JavaScript:SubmitGenCatChange( 31, this, false );"
                               tabindex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td nowrap align="left">
                        <label for="DistributionCachingCheckbox" class="handcursor">
                            <% RenderWithErrorCheck Server.HTMLEncode( L_GENDISTCACHING_TEXT ), "DistributionCaching" %>
                        </label>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetPropertyDescription( 31 );"><%= L_DESCRIPTION_TEXT %></a>
                        </div>
                    </td>
                </tr>

<% ' Allow distribution caching %>
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               name="DirBrowseCheckbox" <% IsCheckedYesNo bAllowDirBrowse %> 
                               id="DirBrowseCheckbox"
                               value=""
                               onClick="JavaScript:SubmitGenCatChange( 32, this, false );"
                               tabindex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td nowrap align="left">
                        <label for="DirBrowseCheckbox" class="handcursor">
                            <% RenderWithErrorCheck Server.HTMLEncode( L_GENACCESSDIRWILD_TEXT ), "DirBrowse" %>
                        </label>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetPropertyDescription( 32 );"><%= L_DESCRIPTION_TEXT %></a>
                        </div>
                    </td>
                </tr>
<%' Allow startup profile %>
<% if (bStartupProfileSupported) then %>
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               name="StartupProfileCheckbox" <% IsCheckedYesNo bAllowStartupProfile %> 
                               id="StartupProfileCheckbox"
                               value=""
                               onClick="JavaScript:SubmitGenCatChange( 36, this, false );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                               >
                    </td>
                    <td nowrap align="left">
                        <label for="StartupProfileCheckbox" class="handcursor">
                            <% RenderWithErrorCheck Server.HTMLEncode( L_GENSTARTUP_PROFILE_TEXT ), "StartupProfile" %>
                        </label>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetPropertyDescription( 37 );"><%= L_DESCRIPTION_TEXT %></a>
                        </div>
                    </td>
                </tr>          
    <% end if %>                
    <% else ' BCPP %>
<% ' Stream splitting %>
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               name="StreamSplittingCheckbox" <% IsCheckedYesNo bAllowStreamSplitting %> 
                               id="StreamSplittingCheckbox"
                               value=""
                               onClick="JavaScript:SubmitGenCatChange( 34, this, false );"
                               tabindex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td nowrap align="left">
                        <label for="StreamSplittingCheckbox" class="handcursor">
                            <% RenderWithErrorCheck Server.HTMLEncode( L_GENSTRMSPLITTING_TEXT ), "StreamSplitting" %>
                        </label>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetPropertyDescription( 34 );"><%= L_DESCRIPTION_TEXT %></a>
                        </div>
                    </td>
                </tr>

<% ' Autostart %>
                <tr>
                    <td widh="16">
                        <input type="checkbox"
                               name="AutoStartCheckbox" <% IsCheckedYesNo bAllowAutoStart %> 
                               id="AutoStartCheckbox"
                               value=""
                               onClick="JavaScript:SubmitGenCatChange( 35, this, false );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                               >
                    </td>
                    <td nowrap align="left">
                        <label for="AutoStartCheckbox" class="handcursor">
                            <% RenderWithErrorCheck Server.HTMLEncode( L_GENAUTOSTARTPP_TEXT ), "AutoStart" %>
                        </label>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetPropertyDescription( 35 );"><%= L_DESCRIPTION_TEXT %></a>
                        </div>
                    </td>
                </tr>

<%' Allow Vroot Start %>
<% if (bVrootStartSupported) then %>

                <tr>
                    <td width="16">
                        <input type="checkbox"
                               name="VrootStartCheckbox" <% IsCheckedYesNo bAllowVrootStart %> 
                               id="StartupProfileCheckbox"
                               value=""
                               onClick="JavaScript:SubmitGenCatChange( 37, this, false );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                               >
                    </td>
                    <td nowrap align="left">
                        <label for="VrootStartCheckbox" class="handcursor">
                            <% RenderWithErrorCheck Server.HTMLEncode( L_GENSTARTUP_START_VROOT_TEXT ), "VrootStart" %>
                        </label>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetPropertyDescription( 38 );"><%= L_DESCRIPTION_TEXT %></a>
                        </div>
                    </td>
                </tr>    
<% end if ' bVrootStartSupported %>                                  

<% ' Allow player caching %>
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               name="PlayerCachingCheckbox" <% IsCheckedYesNo bAllowPlayerCaching %> 
                               id="PlayerCachingCheckbox"
                               value=""
                               onClick="JavaScript:SubmitGenCatChange( 30, this, false );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                               >
                    </td>
                    <td nowrap align="left">
                        <label for="PlayerCachingCheckbox" class="handcursor">
                            <% RenderWithErrorCheck Server.HTMLEncode( L_GENPLAYERCACHING_TEXT ), "PlayerCaching" %>
                        </label>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetPropertyDescription( 36 );"><%= L_DESCRIPTION_TEXT %></a>
                        </div>
                    </td>
                </tr>
<%' Allow startup profile %>
<% if (bStartupProfileSupported) then %>

                <tr>
                    <td width="16">
                        <input type="checkbox"
                               name="StartupProfileCheckbox" <% IsCheckedYesNo bAllowStartupProfile %> 
                               id="StartupProfileCheckbox"
                               value=""
                               onClick="JavaScript:SubmitGenCatChange( 36, this, false );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                               >
                    </td>
                    <td nowrap align="left">
                        <label for="StartupProfileCheckbox" class="handcursor">
                            <% RenderWithErrorCheck Server.HTMLEncode( L_GENSTARTUP_PROFILE_TEXT ), "StartupProfile" %>
                        </label>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetPropertyDescription( 37 );"><%= L_DESCRIPTION_TEXT %></a>
                        </div>
                    </td>
                </tr>    
    <% end if ' bStartupProfileSupported %>       
    <% end if 'BC Pub Point %>
    <% else %>
    <% if (bStartupProfileSupported) then %>

                <tr>
                    <td width="16">
                        <input type="checkbox"
                               name="StartupProfileCheckbox" <% IsCheckedYesNo bAllowStartupProfile %> 
                               id="StartupProfileCheckbox"
                               value=""
                               onClick="JavaScript:SubmitGenCatChange( 36, this, false );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                               >
                    </td>
                    <td nowrap align="left">
                        <label for="StartupProfileCheckbox" class="handcursor">
                            <% RenderWithErrorCheck Server.HTMLEncode( L_GENSTARTUP_PROFILE_TEXT ), "StartupProfile" %>
                        </label>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetPropertyDescription( 37 );"><%= L_DESCRIPTION_TEXT %></a>
                        </div>
                    </td>
                </tr>    
    <% else %>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td bgcolor="#FFFFFF">
                        &nbsp;
                    </td>
                </tr>
    <% end if %>
    <% end if %>    
                </table>
            </td>
        </tr>
        </table>
        </td>
<% elseif SHOWING_WIRELESS = dwDisplayMode then 
        bEnabled = g_objPubPoint.EnableFEC
%>
        <td valign=top >
        <table width="100%" cellspacing="0" cellpadding="0" border=1>
        <tr>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0" border=0>
                <tr>
                    <td width=<%= Server.HTMLEncode( MAX_LEN_PLUGINNAME ) %> align="left" valign="top" bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_NAMEVALUE_TEXT ) %>&nbsp;
                        </td></tr></table>
                    </td>
                    <td halign="right" valign="top" nowrap bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_STATUS_TEXT ) %>&nbsp;
                        </td></tr></table>
                    </td>
                    <td halign="right" valign="top" nowrap bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_DESCRIPTION_TEXT ) %>&nbsp;
                        </td></tr></table>
                    </td>
                </tr>
        
<% ' FEC %>
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="4" bgcolor="#FFFFFF" border="0">
                        <tr>
                            <td width="100%" nowrap class="propshand">
                                <input type="radio"
                                        name="wireless"
                                        id="wireless"
                                        value="<%= Server.HTMLEncode( L_FEC_TEXT ) %>"
                                        onClick="JavaScript:g_bEnabled=<%= BoolToText( not bEnabled ) %>;g_bSupportsProperties=true;DrawCurrentToolbarSelection();"
                                        tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                                        checked <% bCurSelEnabled = bEnabled %> >
                                <label 
                                    for="wireless" 
                                    nowrap 
                                    class="propshand" 
                                    style="cursor:hand;"
                                    nowrap 
                                    tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> onClick="JavaScript:Properties();"><% RenderWithErrorCheck Server.HTMLEncode( L_FEC_TEXT ), "FEC" %></label>
                            </td>
                        </tr>
                        </table>
                    </td>
                    <td bgcolor="#FFFFFF" nowrap class="props" align="center" valign="bottom">
                        <table width="100%" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF" border="0">
                        <tr>
                            <td width="100%">
                                <% if g_objPubPoint.EnableFEC then %>
                                <span tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> onClick="JavaScript:Properties();">&nbsp;<%= L_ENABLED_TEXT %>&nbsp;</span>
                                <% else %>
                                <span tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> onClick="JavaScript:Properties();">&nbsp;<%= L_DISABLED_TEXT %>&nbsp;</span>
                                <% end if %>
                            </td>
                        </tr>
                        </table>
                    </td>
                    <td bgcolor="#FFFFFF" nowrap class="propshelp" align="center" valign="bottom">
                        <table width="100%" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF" border="0">
                        <tr>
                            <td width="100%">
                            <center>
                                <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetWirelessDescription( 0 );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                            </td>
                        </tr>
                        </table>
                    </td>
                </tr>

                </table>
            </td>
        </tr>
        </table>
            
        </td>
<% elseif SHOWING_CREDENTIALS = dwDisplayMode then %>
        <td valign="top">
        <table width="100%" cellspacing="0" cellpadding="0" border="1">
        <tr>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td width=<%= Server.HTMLEncode( MAX_LEN_PLUGINNAME ) %> align="left" valign="top" bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_NAMEVALUE_TEXT ) %>&nbsp;
                        </td></tr></table>
                    </td>
                    <td halign="right" valign="top" nowrap bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_STATUS_TEXT ) %>&nbsp;
                        </td></tr></table>
                    </td>
                    <td halign="right" valign="top" nowrap bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_DESCRIPTION_TEXT ) %>&nbsp;
                        </td></tr></table>
                    </td>
                </tr>

<% ' Distribution credentials %>
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="3" bgcolor="#FFFFFF" border="0">
                        <tr>
                            <td width="100%" nowrap class="propshand">
                                <input type="radio"
                                    name="credentials"
                                    id="credentials"
                                    value="<%= Server.HTMLEncode( L_DISTCREDNONSPACE_TEXT ) %>"
                                    onClick="JavaScript:ClickRadio( 0 );Properties();"
                                    tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                                    checked >
                                <label 
                                    for="credentials" 
                                    class="propshand" 
                                    style="cursor:hand;"
                                    nowrap 
                                    tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> ><% RenderWithErrorCheck Server.HTMLEncode( L_DISTCREDENTIALS_TEXT ), "NetDistCred" %></label>
                            </td>
                        </tr>
                        </table>
                    </td>
                    <td bgcolor="#FFFFFF" nowrap class="props" align="center" valign="bottom">
                        <table width="100%" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF" border="0">
                        <tr>
                            <td width="100%" class="defaultcursor">
                                &nbsp;<% 
                                on error resume next
                                strDistUserName = g_objPubPoint.DistributionUserName
                                if( 0 < Len( strDistUserName ) ) then
                                    Response.Write( L_SPECIFIED_TEXT )
                                else
                                    Response.Write( L_NOTSPECIFIED_TEXT )
                                end if 
                                %>&nbsp;
                            </td>
                        </tr>
                        </table>
                    </td>
                    <td bgcolor="#FFFFFF" nowrap class="propshelp" align="center" valign="bottom">
                        <table width="100%" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF" border="0" ID="Table13">
                        <tr>
                            <td width="100%">
                            <center>
                                <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetCredentialsDescription( 0 );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                            </td>
                        </tr>
                        </table>
                    </td>
                </tr>
                
                </table>
            </td>
        </tr>
        </table>
            
        </td>
<% elseif SHOWING_NETWORKING = dwDisplayMode then %>
        <td valign=top >
        <table width="100%" cellspacing="0" cellpadding="0" border=1>
        <tr>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0" border=0>
                <tr>
                    <td width=<%= Server.HTMLEncode( MAX_LEN_PLUGINNAME ) %> align="left" valign="top" bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_NAMEVALUE_TEXT ) %>&nbsp;
                        </td></tr></table>
                    </td>
                    <td halign="right" valign="top" nowrap bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0" ID="Table3"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_STATUS_TEXT ) %>&nbsp;
                        </td></tr></table>
                    </td>
                    <td halign="right" valign="top" nowrap bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0" ID="Table4"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_DESCRIPTION_TEXT ) %>&nbsp;
                        </td></tr></table>
                    </td>
                </tr>

<% ' Buffer Setting %>
                <% if ( TRUE = bBroadcastPubPoint ) then %>
                <tr>
                    <td>
                        <div class="propshand">
                        <input type="radio"
                               name="networking"
                               id="networking"
                               value="<%= Server.HTMLEncode( L_BUFFERSETTING_TEXT ) %>"
                               onClick="JavaScript:ClickRadio( 1 );Properties();"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                               checked >
                               <label 
                                    for="networking"
                                    class="propshand" 
                                    style="cursor:hand;"
                                    nowrap 
                                    tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> ><% RenderWithErrorCheck Server.HTMLEncode( L_BUFFERSPSETTING_TEXT ), "NetBuffer" %></label>
                        </div>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="defaultcursor">
                        <center>&nbsp;<%
                            on error resume next
                            if( 1 = g_objPubPoint.BufferSetting ) then
                                Response.Write( Server.HTMLEncode( L_BUFFER_TEXT ) )
                            else
                                Response.Write( Server.HTMLEncode( L_NOBUFFER_TEXT ) )
                            end if 
                            %>&nbsp;
                        </center>
                        </div>
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetNetworkingDescription( 2 );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                        </div>
                    </td>
                </tr>
                <% end if %>
                </table>
            </td>
        </tr>
        </table>
            
        </td>
        
<% elseif SHOWING_CACHEPROXYMGMT = dwDisplayMode then %>
        <td valign=top >
        <table width="100%" cellspacing="0" cellpadding="0" border=1>
        <tr>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td width=<%= Server.HTMLEncode( MAX_LEN_PLUGINNAME ) %> valign=top nowrap class="colheader">
                        <div nowrap class="colheader">
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_NAMEVALUE_TEXT ) %>
                        </div>
                    </td>
                    <td halign=right valign=top nowrap class="colheader">
                        <div nowrap class="colheader">
                            <center>&nbsp;&nbsp;<%= Server.HTMLEncode( L_STATUS_TEXT ) %>&nbsp;&nbsp;</center>
                        </div>
                    </td>
                    <td halign=right valign=top nowrap class="colheader">
                        <div nowrap class="colheader">
                            <center>&nbsp;&nbsp;<%= Server.HTMLEncode( L_DESCRIPTION_TEXT ) %>&nbsp;&nbsp;</center>
                        </div>
                    </td>
                </tr>

<% ' Enable cache expiration %>
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="3" bgcolor="#FFFFFF" border="0">
                        <tr>
                            <td width="100%" nowrap class="propshand">
                                <input type="radio"
                                    name="cacheproxymgmt"
                                    id="cacheproxymgmt"
                                    value="<%= Server.HTMLEncode( L_CACHEPROXPROP_TEXT ) %>"
                                    onClick="JavaScript:ClickRadio( 1 );Properties();"
                                    tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> 
                                    checked
                                        >
                               <label 
                                    for="cacheproxymgmt" 
                                    class="propshand" 
                                    style="cursor:hand;"
                                    nowrap 
                                    tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> ><% 
                                if( TRUE = bBroadcastPubPoint ) then 
                                    strCache = L_CACHEPROXSPPROP_TEXT
                                else
                                    strCache = L_CACHEPROXSPPROPOD_TEXT
                                end if

                               RenderWithErrorCheck Server.HTMLEncode( strCache ), "CacheProxyExpiration" %></label>
                            </td>
                        </tr>
                        </table>
                    </td>
                    <td bgcolor="#FFFFFF" nowrap class="props" align="center" valign="bottom">
                        <table width="100%" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF" border="0" ID="Table1">
                        <tr>
                            <td width="100%" class="defaultcursor">
                                <center>
                                &nbsp;<% 
                                Dim lExpiration
                                lExpiration = g_objPubPoint.CacheProxyExpiration
                                if -1 = lExpiration then
                                    Response.Write( Server.HTMLEncode( L_NEVEREXPIRE_TEXT ) )
                                elseif 0 = lExpiration then
                                    Response.Write( Server.HTMLEncode( L_ALWAYSEXPIRE_TEXT ) )
                                else
                                    Response.Write( Server.HTMLEncode( GenExpirationString( lExpiration ) ) )
                                end if
                                %>&nbsp;
                                </center>
                            </td>
                        </tr>
                        </table>
                    </td>
                    <td bgcolor="#FFFFFF" nowrap class="propshelp" align="center" valign="bottom">
                        <table width="100%" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF" border="0" ID="Table2">
                        <tr>
                            <td width="100%">
                                <center>
                                <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetCacheProxyDescription( 0 );"><%= L_DESCRIPTION_TEXT %></a>
                                </center>
                            </td>
                        </tr>
                        </table>
                    </td>
                </tr>
                </table>
            </td>
        </tr>
        </table>
        </td>
        
<% elseif SHOWING_LIMITS = dwDisplayMode then %>
        <td valign=top >
        <table width="100%" cellspacing="0" cellpadding="0" border=1>
        <tr>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0" border=0>
                <tr>
                    <td valign=top class="colheader" colspan="2">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            &nbsp;&nbsp;<%= Server.HTMLEncode( L_LIMIT_TEXT ) %>
                        </td></tr></table>
                    </td>
                    <td align="center" valign="top" bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            <center>&nbsp;&nbsp;<%= Server.HTMLEncode( L_VALUE_TEXT ) %>&nbsp;&nbsp;</center>
                        </td></tr></table>
                    </td>
                    <td align="center" valign="top" bgcolor="#6699ff" class="colheader">
                        <table cellspacing="1" cellpadding="1" bgcolor="#6699ff" border="0"><tr><td class="colheadertext" nowrap>
                            <center>&nbsp;&nbsp;<%= Server.HTMLEncode( L_DESCRIPTION_TEXT ) %>&nbsp;&nbsp;</center>
                        </td></tr></table>
                    </td>
                </tr>

<% ' Set player connections limit %>
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               id="PlayerConnCheckbox"
                               name="PlayerConnCheckbox" <% CheckIfNotDefault strPlayerConnections, L_UNLIMITED_TEXT %> 
                               value=""
                               onClick="ToggleCheckbox( document.mainForm.PlayerConnCheckbox, document.mainForm.PlayerConnText );"
                               tabindex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td class="propshand" align="left">
                        <label for="PlayerConnCheckbox"><% RenderWithErrorCheck Server.HTMLEncode( L_PLAYERCONNLIMIT_TEXT ), "AggPlayerBW" %></label>
                    </td>
                    <td align=right>
                        <input type="text" 
                               name="PlayerConnText"
                               value="<%= strPlayerConnections %>"
                               size=<%= dwSizeLimText %>
                               maxlength=<%= CalcMaxInputLength( strPlayerConnections ) %>
                               onChange="JavaScript:CheckLimit( document.mainForm.PlayerConnCheckbox, document.mainForm.PlayerConnText );"
                               onPaste="JavaScript:CheckLimit( document.mainForm.PlayerConnCheckbox, document.mainForm.PlayerConnText );"
                               onKeyUp="JavaScript:CheckLimit( document.mainForm.PlayerConnCheckbox, document.mainForm.PlayerConnText );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %><% IsDisabled( strPlayerConnections ) %> 
                               >
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetLimitDescription( <%= PPLIMDESCOFFSET %> );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                        </div>
                    </td>
                </tr>

<% ' Set outgoing distribution connections limit %>
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               id="DistConnCheckbox"
                               name="DistConnCheckbox" <% CheckIfNotDefault strDistConnections, L_UNLIMITED_TEXT %> 
                               value=""
                               onClick="ToggleCheckbox( document.mainForm.DistConnCheckbox, document.mainForm.DistConnText );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td class="propshand" align="left">
                        <label for="DistConnCheckbox"><% RenderWithErrorCheck Server.HTMLEncode( L_DISTCONNLIMIT_TEXT ), "AggDistBW" %></label>
                    </td>
                    <td align=right>
                        <input type="text" 
                               name="DistConnText" 
                               value="<%= strDistConnections %>" 
                               size=<%= dwSizeLimText %>
                               maxlength=<%= CalcMaxInputLength( strDistConnections ) %> 
                               onChange="JavaScript:CheckLimit( document.mainForm.DistConnCheckbox, document.mainForm.DistConnText );" 
                               onPaste="JavaScript:CheckLimit( document.mainForm.DistConnCheckbox, document.mainForm.DistConnText );" 
                               onKeyUp="JavaScript:CheckLimit( document.mainForm.DistConnCheckbox, document.mainForm.DistConnText );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %><% IsDisabled( strDistConnections ) %> 
                               >
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetLimitDescription( <%= PPLIMDESCOFFSET %> + 1 );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                        </div>
                    </td>
                </tr>

<% ' Set aggregate player bandwidth limit (Kbps) %>
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               id="AggPlayerBWCheckbox"
                               name="AggPlayerBWCheckbox" <% CheckIfNotDefault strAggPlayerBW, L_UNLIMITED_TEXT %> 
                               value=""
                               onClick="ToggleCheckbox( document.mainForm.AggPlayerBWCheckbox, document.mainForm.AggPlayerBWText );"
                               tabindex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td class="propshand" align="left">
                        <label for="AggPlayerBWCheckbox"><% RenderWithErrorCheck Server.HTMLEncode( L_AGGPLAYERBWLIMIT_TEXT ), "PlayerBW" %></label>
                    </td>
                    <td align=right>
                        <input type="text" 
                               name="AggPlayerBWText" 
                               value="<%= strAggPlayerBW %>" 
                               size=<%= dwSizeLimText %>
                               maxlength=<%= CalcMaxInputLength( strAggPlayerBW ) %> 
                               onChange="JavaScript:CheckLimit( document.mainForm.AggPlayerBWCheckbox, document.mainForm.AggPlayerBWText );" 
                               onPaste="JavaScript:CheckLimit( document.mainForm.AggPlayerBWCheckbox, document.mainForm.AggPlayerBWText );" 
                               onKeyUp="JavaScript:CheckLimit( document.mainForm.AggPlayerBWCheckbox, document.mainForm.AggPlayerBWText );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %><% IsDisabled( strAggPlayerBW ) %> 
                               >
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetLimitDescription( <%= PPLIMDESCOFFSET %> + 2 );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                        </div>
                    </td>
                </tr>

<% ' Set outgoing distribution bandwidth limit (Kbps) %>                
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               id="AggDistBWCheckbox"
                               name="AggDistBWCheckbox" <% CheckIfNotDefault strDistAggBW, L_UNLIMITED_TEXT %> 
                               value=""
                               onClick="ToggleCheckbox( document.mainForm.AggDistBWCheckbox, document.mainForm.AggDistBWText );"
                               tabindex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td class="propshand" align="left">
                        <label for="AggDistBWCheckbox"><% RenderWithErrorCheck Server.HTMLEncode( L_DISTBWLIMIT_TEXT ), "DistBW" %></label>
                    </td>
                    <td align=right>
                        <input type="text" 
                               name="AggDistBWText" 
                               value="<%= strDistAggBW %>" 
                               size=<%= dwSizeLimText %>
                               maxlength=<%= CalcMaxInputLength( strDistAggBW ) %> 
                               onChange="JavaScript:CheckLimit( document.mainForm.AggDistBWCheckbox, document.mainForm.AggDistBWText );" 
                               onPaste="JavaScript:CheckLimit( document.mainForm.AggDistBWCheckbox, document.mainForm.AggDistBWText );" 
                               onKeyUp="JavaScript:CheckLimit( document.mainForm.AggDistBWCheckbox, document.mainForm.AggDistBWText );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %><% IsDisabled( strDistAggBW ) %> 
                               >
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetLimitDescription( <%= PPLIMDESCOFFSET %> + 3 );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                        </div>
                    </td>
                </tr>

<% ' Set bandwidth per stream per player limit (Kbps) %>                
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               id="PlayerBWCheckbox"
                               name="PlayerBWCheckbox" <% CheckIfNotDefault strPlayerBW, L_UNLIMITED_TEXT %> 
                               value=""
                               onClick="ToggleCheckbox( document.mainForm.PlayerBWCheckbox, document.mainForm.PlayerBWText );"
                               tabindex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td class="propshand" align="left">
                        <label for="PlayerBWCheckbox"><% RenderWithErrorCheck Server.HTMLEncode( L_BWPERSTREAMPERPLAYERLIMIT_TEXT ), "PlayerBW" %></label>
                    </td>
                    <td align=right>
                        <input type="text" 
                               name="PlayerBWText" 
                               value="<%= strPlayerBW %>" 
                               size=<%= dwSizeLimText %>
                               maxlength=<%= CalcMaxInputLength( strPlayerBW ) %> 
                               onChange="JavaScript:CheckLimit( document.mainForm.PlayerBWCheckbox, document.mainForm.PlayerBWText );" 
                               onPaste="JavaScript:CheckLimit( document.mainForm.PlayerBWCheckbox, document.mainForm.PlayerBWText );" 
                               onKeyUp="JavaScript:CheckLimit( document.mainForm.PlayerBWCheckbox, document.mainForm.PlayerBWText );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %><% IsDisabled( strPlayerBW ) %> 
                               >
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetLimitDescription( <%= PPLIMDESCOFFSET %> + 4 );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                        </div>
                    </td>
                </tr>

<% ' Set bandwidth per outgoing distribution stream (Kbps) %>                
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               id="DistBWCheckbox"
                               name="DistBWCheckbox" <% CheckIfNotDefault strDistBW, L_UNLIMITED_TEXT %> 
                               value=""
                               onClick="ToggleCheckbox( document.mainForm.DistBWCheckbox, document.mainForm.DistBWText );"
                               tabindex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td class="propshand" align="left">
                        <label for="DistBWCheckbox"><% RenderWithErrorCheck Server.HTMLEncode( L_BWPEROUTDISTSTREAMLIMIT_TEXT ), "DistConn" %></label>
                    </td>
                    <td align=right>
                        <input type="text" 
                               name="DistBWText" 
                               value="<%= strDistBW %>" 
                               size=<%= dwSizeLimText %>
                               maxlength=<%= CalcMaxInputLength( strDistBW ) %> 
                               onChange="JavaScript:CheckLimit( document.mainForm.DistBWCheckbox, document.mainForm.DistBWText );" 
                               onPaste="JavaScript:CheckLimit( document.mainForm.DistBWCheckbox, document.mainForm.DistBWText );" 
                               onKeyUp="JavaScript:CheckLimit( document.mainForm.DistBWCheckbox, document.mainForm.DistBWText );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %><% IsDisabled( strDistBW ) %> 
                               >
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetLimitDescription( <%= PPLIMDESCOFFSET %> + 5 );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                        </div>
                    </td>
                </tr>

<% ' Set Fast Start bandwidth per player (Kbps) %>                
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               id="RapidStartBWCheckbox"
                               name="RapidStartBWCheckbox" <% CheckIfNotDefault strRapidStartBW, DEFAULT_RAPIDSTART_RATE %> 
                               value=""
                               onClick="ToggleCheckboxEx( document.mainForm.RapidStartBWCheckbox, document.mainForm.RapidStartBWText, <%= DEFAULT_RAPIDSTART_RATE %> );"
                               tabindex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td class="propshand" align="left">
                        <label for="RapidStartBWCheckbox"><% RenderWithErrorCheck Server.HTMLEncode( L_BWPERRAPIDSTARTLIMIT_TEXT ), "RapidStart" %></label>
                    </td>
                    <td align=right>
                        <input type="text" 
                               name="RapidStartBWText" 
                               value="<%= strRapidStartBW %>" 
                               size=<%= dwSizeLimText %>
                               maxlength=<%= CalcMaxInputLength( strRapidStartBW ) %> 
                               onChange="JavaScript:CheckLimit( document.mainForm.RapidStartBWCheckbox, document.mainForm.RapidStartBWText );" 
                               onPaste="JavaScript:CheckLimit( document.mainForm.RapidStartBWCheckbox, document.mainForm.RapidStartBWText );" 
                               onKeyUp="JavaScript:CheckLimit( document.mainForm.RapidStartBWCheckbox, document.mainForm.RapidStartBWText );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %><% IsDisabled( strRapidStartBW ) %> 
                               >
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetLimitDescription( <%= PPLIMDESCOFFSET %> + 10 );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                        </div>
                    </td>
                </tr>

<% if ( FALSE = bBroadcastPubPoint ) then %>
<% ' OD Limit connection rate (per second) %>                
                <tr>
                    <td width="16">
                        <input type="checkbox"
                               title="<%= Server.HTMLEncode( L_CHECKBOXDESC_TEXT ) %>"
                               id="LimitDeliveryRateCheckbox"
                               name="LimitDeliveryRateCheckbox" <% CheckIfNotDefault strDeliveryRate, DEFAULT_DELIVERY_RATE %> 
                               value=""
                               onClick="ToggleCheckboxEx( document.mainForm.LimitDeliveryRateCheckbox, document.mainForm.LimitDeliveryRateText, <%= DEFAULT_DELIVERY_RATE %> );"
                               tabindex=<%= dwTabIndex %><% dwTabIndex = dwTabIndex + 1 %>
                               >
                    </td>
                    <td class="propshand" align="left">
                        <label for="LimitDeliveryRateCheckbox"><% RenderWithErrorCheck Server.HTMLEncode( L_ODLIMCXNRATE_TEXT ), "DeliveryRate" %></label>
                    </td>
                    <td align=right>
                        <input type="text" 
                               name="LimitDeliveryRateText" 
                               value="<%= strDeliveryRate %>" 
                               size=<%= dwSizeLimText %>
                               maxlength=<%= CalcMaxInputLength( strLimitDeliveryRate ) %> 
                               onChange="JavaScript:CheckLimit( document.mainForm.LimitDeliveryRateCheckbox, document.mainForm.LimitDeliveryRateText );" 
                               onPaste="JavaScript:CheckLimit( document.mainForm.LimitDeliveryRateCheckbox, document.mainForm.LimitDeliveryRateText );" 
                               onKeyUp="JavaScript:CheckLimit( document.mainForm.LimitDeliveryRateCheckbox, document.mainForm.LimitDeliveryRateText );"
                               tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> <% IsDisabledEx strLimitDeliveryRate, DEFAULT_DELIVERY_RATE %> 
                               >
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="propshelp" align=center>
                            <center>
                            <a oncontextmenu="JavaScript:event.cancelBubble=true;return false;" tabIndex="<%= dwTabIndex %>" <% dwTabIndex = dwTabIndex + 1 %> class="propshelp" href="JavaScript:GetLimitDescription( <%= PPLIMDESCOFFSET %> + 9 );"><%= L_DESCRIPTION_TEXT %></a>
                            </center>
                        </div>
                    </td>
                </tr>
<% end if %>
                <tr>
                    <td colspan=4>
                        <table width="100%" border="1" cellspacing="0" cellpadding=0>
                        <tr>
                            <td>
                                <table width="100%" border="0" cellspacing=4 cellpadding=0>
                                <tr>
                                    <td width=40% align=right>
                                        <input type="submit" name="submit" action="<%= RemoveDangerousCharacters( g_strQueryString ) & "&limitOp=submit" %>" value="<%= Server.HTMLEncode( L_APPLYBUTTON_TEXT ) %>" tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %>  disabled ID="Submit1">
                                        <input type="button" name="cancel" value="<%= Server.HTMLEncode( L_CANCELBUTTONSPACED_TEXT ) %>" Onclick="JavaScript:Cancel();" tabindex=<%= dwTabIndex %> <% dwTabIndex = dwTabIndex + 1 %> disabled ID="Button1">
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                    </td>
                                </tr>
                                </table>
                            </td>
                        </tr>
                        </table>
                    </td>
                </tr>   
                </table>
            </td>
        </tr>
        </table>
        </td>
<% end if %>
        </table>
        <!-- Dummy element -->
        <input type="hidden" name="server" value="<%= RemoveSpecifiedChars( g_strQueryStringServer, "\f|\n|\r|<|>" ) %>">
        <input type="hidden" name="ppID" value="<%= RemoveSpecifiedChars( g_strPubPointID, "\f|\n|\r|<|>" ) %>">
        <input type="hidden" name="category" value="<%= RemoveSpecifiedChars( strCategory, "\f|\n|\r|<|>" ) %>"><%
        if( SHOWING_LIMITS <> dwDisplayMode ) then %>
        <input type="hidden" name="instance" value="<%= RemoveSpecifiedChars( strEncodedInstance, "\f|\n|\r|<|>" ) %>"><%
        end if %><%
        if( SHOWING_GENERAL = dwDisplayMode ) then %>
        <input type="hidden" name="general" value="&nbsp;"><%
        elseif( SHOWING_PLUGINS = dwDisplayMode ) then %>
        <input type="hidden" name="plugins" value="&nbsp;">
        <input type="hidden" name="pluginIndex" value="<% 
        if( 0 < Len( strCurrentCheckedPluginName ) ) then 
            Response.Write( RemoveDangerousCharacters( strCurrentCheckedPluginName ) )
        else 
            Response.Write( RemoveDangerousCharacters( qs("pluginIndex") ) )
        end if %>"><%
        elseif( SHOWING_CREDENTIALS = dwDisplayMode ) then %>
        <input type="hidden" name="credentials" value="&nbsp;"><%
        elseif( SHOWING_NETWORKING = dwDisplayMode ) then %>
        <input type="hidden" name="networking" value="&nbsp;"><%
        elseif( SHOWING_WIRELESS = dwDisplayMode ) then %>
        <input type="hidden" name="wireless" value="&nbsp;"><%
        elseif( SHOWING_LIMITS = dwDisplayMode ) then %>
        <input type="hidden" name="limits" value="&nbsp;"><%
        end if %>
        </td>
    </tr>
    <tr>
        <td>
            <%
if ( SHOWING_LIMITS = dwDisplayMode ) or _
   ( SHOWING_GENERAL = dwDisplayMode ) or _
   ( ( SHOWING_PLUGINS = dwDisplayMode ) and ( 0 = dwNumPluginsDisplayed ) ) then
            ToolbarButtonText ( 0 ) = L_BUTTONENABLE_TEXT
            ToolbarButtonImage( 0 ) = IMAGE_ENABLEG
            ToolbarButtonImageDisabled( 0 ) = IMAGE_ENABLEG
            ToolbarButtonLink ( 0 ) = ""
            if( SHOWING_PLUGINS = dwDisplayMode ) then
                ToolbarButtonAltText( 0 ) = L_ENABLEPLUGTT_TEXT
            else
                ToolbarButtonAltText( 0 ) = L_ENABLEPLUG_TEXT
            end if

            ToolbarButtonText ( 1 ) = L_BUTTONDISABLE_TEXT
            ToolbarButtonImage( 1 ) = IMAGE_DISABLEG
            ToolbarButtonImageDisabled( 1 ) = IMAGE_DISABLEG
            ToolbarButtonLink ( 1 ) = ""
            if( SHOWING_PLUGINS = dwDisplayMode ) then
                ToolbarButtonAltText( 1 ) = L_DISABLEPLUGTT_TEXT
            else
                ToolbarButtonAltText( 1 ) = L_DISABLEPLUG_TEXT
            end if

            ToolbarButtonText ( 2 ) = L_BUTTONREMOVE_TEXT
            ToolbarButtonImage( 2 ) = IMAGE_REMOVEG
            ToolbarButtonLink ( 2 ) = ""
            ToolbarButtonAltText( 2 ) = L_REMOVEPLUG_TEXT

            ToolbarButtonText ( 3 ) = L_BUTTONDUPLICATE_TEXT
            ToolbarButtonImage( 3 ) = IMAGE_PLUGINDUPLICATEG
            ToolbarButtonLink ( 3 ) = ""
            ToolbarButtonAltText( 3 ) = L_DUPPLUG_TEXT

            ToolbarButtonText ( 4 ) = L_BUTTONPROPERTIES_TEXT
            ToolbarButtonImage( 4 ) = IMAGE_PROPERTIESG
            ToolbarButtonLink ( 4 ) = ""
            ToolbarButtonAltText( 4 ) = L_VIEWPROPS_TEXT

            ToolbarButtonText ( 5 ) = L_BUTTONRENAME_TEXT
            ToolbarButtonImage( 5 ) = IMAGE_RENAMEG
            ToolbarButtonLink ( 5 ) = ""
            ToolbarButtonAltText( 5 ) = L_RENAMEPLUG_TEXT
elseif SHOWING_WIRELESS = dwDisplayMode then
            ToolbarButtonText ( 0 ) = L_BUTTONENABLE_TEXT
            ToolbarButtonImage( 0 ) = IMAGE_ENABLE
            ToolbarButtonImageDisabled( 0 ) = IMAGE_ENABLEG
            ToolbarButtonLink ( 0 ) = "Javascript:Enable()"
            if( SHOWING_PLUGINS = dwDisplayMode ) then
                ToolbarButtonAltText( 0 ) = L_ENABLEPLUGTT_TEXT
            else
                ToolbarButtonAltText(  ) = L_ENABLEPLUG_TEXT
            end if

            ToolbarButtonText ( 1 ) = L_BUTTONDISABLE_TEXT
            ToolbarButtonImage( 1 ) = IMAGE_DISABLE
            ToolbarButtonImageDisabled( 1 ) = IMAGE_DISABLEG
            ToolbarButtonLink ( 1 ) = "Javascript:Disable()"
            if( SHOWING_PLUGINS = dwDisplayMode ) then
                ToolbarButtonAltText( 1 ) = L_DISABLEPLUGTT_TEXT
            else
                ToolbarButtonAltText( 1 ) = L_DISABLEPLUG_TEXT
            end if

            ToolbarButtonText ( 2 ) = L_BUTTONREMOVE_TEXT
            ToolbarButtonImage( 2 ) = IMAGE_REMOVEG
            ToolbarButtonLink ( 2 ) = ""
            ToolbarButtonAltText( 2 ) = L_REMOVEPLUG_TEXT

            ToolbarButtonText ( 3 ) = L_BUTTONDUPLICATE_TEXT
            ToolbarButtonImage( 3 ) = IMAGE_PLUGINDUPLICATEG
            ToolbarButtonLink ( 3 ) = ""
            ToolbarButtonAltText( 3 ) = L_DUPPLUG_TEXT

            ToolbarButtonText ( 4 ) = L_BUTTONPROPERTIES_TEXT
            ToolbarButtonImage( 4 ) = IMAGE_PROPERTIES
            ToolbarButtonLink ( 4 ) = "Javascript:Properties()"
            ToolbarButtonAltText( 4 ) = L_VIEWPROPS_TEXT

            ToolbarButtonText ( 5 ) = L_BUTTONRENAME_TEXT
            ToolbarButtonImage( 5 ) = IMAGE_RENAMEG
            ToolbarButtonLink ( 5 ) = ""
            ToolbarButtonAltText( 5 ) = L_RENAMEPLUG_TEXT
else
    if( ( SHOWING_NETWORKING = dwDisplayMode ) or ( SHOWING_CACHEPROXYMGMT = dwDisplayMode ) or ( SHOWING_CREDENTIALS = dwDisplayMode ) ) then
            ToolbarButtonText ( 0 ) = L_BUTTONENABLE_TEXT
            ToolbarButtonImage( 0 ) = IMAGE_ENABLEG
            ToolbarButtonImageDisabled( 0 ) = IMAGE_ENABLEG
            ToolbarButtonLink ( 0 ) = ""
            ToolbarButtonAltText( 0 ) = L_ENABLEPLUG_TEXT

            ToolbarButtonText ( 1 ) = L_BUTTONDISABLE_TEXT
            ToolbarButtonImage( 1 ) = IMAGE_DISABLEG
            ToolbarButtonImageDisabled( 1 ) = IMAGE_DISABLEG
            ToolbarButtonLink ( 1 ) = ""
            ToolbarButtonAltText( 1 ) = L_DISABLEPLUG_TEXT
            
            ToolbarButtonText ( 2 ) = L_BUTTONREMOVE_TEXT
            ToolbarButtonImage( 2 ) = IMAGE_REMOVEG
            ToolbarButtonLink ( 2 ) = ""
            ToolbarButtonAltText( 2 ) = L_REMOVEPLUG_TEXT

            ToolbarButtonText ( 3 ) = L_BUTTONDUPLICATE_TEXT
            ToolbarButtonImage( 3 ) = IMAGE_PLUGINDUPLICATEG
            ToolbarButtonLink ( 3 ) = ""
            ToolbarButtonAltText( 3 ) = L_DUPPLUG_TEXT
            
    else
            ToolbarButtonText ( 0 ) = L_BUTTONENABLE_TEXT
            ToolbarButtonImage( 0 ) = IMAGE_ENABLE
            ToolbarButtonImageDisabled( 0 ) = IMAGE_ENABLEG
            ToolbarButtonLink ( 0 ) = "Javascript:Enable()"
            if( SHOWING_PLUGINS = dwDisplayMode ) then
                ToolbarButtonAltText( 0 ) = L_ENABLEPLUGTT_TEXT
            else
                ToolbarButtonAltText( 0 ) = L_ENABLEPLUG_TEXT
            end if

            ToolbarButtonText ( 1 ) = L_BUTTONDISABLE_TEXT
            ToolbarButtonImage( 1 ) = IMAGE_DISABLE
            ToolbarButtonImageDisabled( 1 ) = IMAGE_DISABLEG
            ToolbarButtonLink ( 1 ) = "Javascript:Disable()"
            if( SHOWING_PLUGINS = dwDisplayMode ) then
                ToolbarButtonAltText( 1 ) = L_DISABLEPLUGTT_TEXT
            else
                ToolbarButtonAltText( 1 ) = L_DISABLEPLUG_TEXT
            end if
            
            ToolbarButtonText ( 2 ) = L_BUTTONREMOVE_TEXT
            ToolbarButtonImage( 2 ) = IMAGE_REMOVE
            ToolbarButtonImageDisabled( 2 ) = IMAGE_REMOVEG
            ToolbarButtonLink ( 2 ) = "Javascript:Remove()"
            ToolbarButtonAltText( 2 ) = L_REMOVEPLUG_TEXT

            ToolbarButtonText ( 3 ) = L_BUTTONDUPLICATE_TEXT
            ToolbarButtonImage( 3 ) = IMAGE_PLUGINDUPLICATE
            ToolbarButtonImageDisabled( 3 ) = IMAGE_PLUGINDUPLICATEG
            ToolbarButtonLink ( 3 ) = "Javascript:Duplicate()"
            ToolbarButtonAltText( 3 ) = L_DUPPLUG_TEXT
    end if

            ToolbarButtonText ( 4 ) = L_BUTTONPROPERTIES_TEXT
            ToolbarButtonImage( 4 ) = IMAGE_PROPERTIES
            ToolbarButtonImageDisabled( 4 ) = IMAGE_PROPERTIESG
            ToolbarButtonLink ( 4 ) = "Javascript:Properties()"
            ToolbarButtonAltText( 4 ) = L_VIEWPROPS_TEXT

    if( ( SHOWING_PLUGINS = dwDisplayMode ) and ( 0 < dwNumPluginsDisplayed ) ) then
            ToolbarButtonText ( 5 ) = L_BUTTONRENAME_TEXT
            ToolbarButtonImage( 5 ) = IMAGE_RENAME
            ToolbarButtonLink ( 5 ) = "Javascript:Rename()"
            ToolbarButtonAltText( 5 ) = L_RENAMEPLUG_TEXT
    else            
            ToolbarButtonText ( 5 ) = L_BUTTONRENAME_TEXT
            ToolbarButtonImage( 5 ) = IMAGE_RENAMEG
            ToolbarButtonLink ( 5 ) = ""
            ToolbarButtonAltText( 5 ) = L_RENAMEPLUG_TEXT
    end if
end if
    Dim dwLastButton
    dwLastButton = 5
    if( SHOWING_PLUGINS = dwDisplayMode ) then
            ToolbarButtonText ( 6 ) = L_BUTTONREFRESH_TEXT
            ToolbarButtonImage( 6 ) = IMAGE_REFRESH
            ToolbarButtonLink ( 6 ) = "JavaScript:Refresh();"
            ToolbarButtonAltText( 6 ) = L_BUTTONREFRESHLIST_TEXT
            dwLastButton = 6
    end if
    if( Session( "ShowServerList" ) ) then
            dwLastButton = dwLastButton + 1
            ToolbarButtonText ( dwLastButton ) = L_BUTTONRETURNTOSERVERLIST_TEXT
            ToolbarButtonImage( dwLastButton ) = IMAGE_SERVERLIST
            ToolbarButtonLink ( dwLastButton ) = SERVERSLIST_PATH
            ToolbarButtonAltText( dwLastButton ) = L_RETURNTOSL_TEXT
    end if

            dwLastButton = dwLastButton + 1
            ToolbarButtonText ( dwLastButton ) = L_BUTTONHELP_TEXT
            ToolbarButtonImage( dwLastButton ) = IMAGE_HELP
            ToolbarButtonLink ( dwLastButton ) = HELPTOKEN
            ToolbarButtonAltText( dwLastButton ) = L_HELPALT_TEXT
            ToolbarHelpURL = H_PPPLUGINSHELPTOPIC
            ToolbarNesting = H_PPLEVEL
            %>
<% DrawToolbar TRUE, ( dwLastButton + 1 ) %>
          </td>
        </tr>
        </table>
        <!-- END TOOLBAR -->
    </td>

</tr>
</table>
</form><%
if ( SHOWING_LIMITS <> dwDisplayMode ) then
    DrawRefreshControl TRUE
end if
DrawCopyrightInfo
DrawStdFooter
%>
</body><%

if ( ( CAT_MCAST = strCategory ) and ( TRUE = Session( "DisplayMcastWarning" ) ) ) then 
    Session( "DisplayMcastWarning" ) = FALSE
    %>
<script language="JavaScript">
    window.alert( "<%= RemoveDangerousCharacters( L_ENABLEMCASTWARN_TEXT ) %>" );
</script>
<%
end if

if Session( "ErrorNumber" ) <> 0 then %>
<script language="JavaScript">
    UpdateTreeView();
</script>
<%
end if 

if( bPluginDisabledError ) then
    Session( "PageReloadedToDisplayError" ) = 1
    err.number = CDbl( strError )
    err.Description = Session( "ErrDisablePluginDesc" )
    Session( "ErrDisablePluginDesc" ) = ""
    ErrorDetected( "disable" )
end if

AlertUserWithPopupErrorDialog 

if( bPluginDisabledError ) then
    ClearError
end if
%>
<script language="JavaScript">
/*@cc_on @*/<%
if ( 0 = strComp( "nopluginui", qs("err"), vbTextCompare ) ) then
%>
window.alert( "<%= RemoveDangerousCharacters( L_NOPROPERTYPAGE_TEXT ) %>" );
document.location.replace( "<%= Request.ServerVariables( "PATH_INFO" ) & "?server=" & g_strQueryStringServer & "&ppID=" & qs("ppID") & "&category=" & strCategory & "&pluginIndex=" & strPluginIndex %>" );
<%
end if

if ( SHOWING_PLUGINS = dwDisplayMode ) and ( "enable" = qs("op") ) and ( Session( "ErrorNumber" ) <> 0 ) then %>
document.location.replace( "pubpoint_props.asp?server=<%= g_strQueryStringServer %>&ppID=<%= g_strPubPointID %>&category=<%= strCategory %>&pluginIndex=<%= strPluginIndex %>" );
<%
else
'    DumpQueryString
'    DumpFormPosting
    OnErrorGoBack 
end if

if( bPluginDisabledError ) then
    ClearError
end if
if Session( "ErrorNumber" ) <> 0 then        
%>
document.location.replace( "<%= Request.ServerVariables( "PATH_INFO" ) & "?server=" & g_strQueryStringServer & "&ppID=" & qs("ppID") & "&category=" & strCategory & "&instance=" & strEncodedInstance & "&pluginIndex=" & strPluginIndex %>" );
<%
end if %>

//////////////////////////////////////////////////////////////////////////
function SetInitialState()
{
    <% jsTRY %>
        g_szCurPluginElementName = new String( "<%= strCurrentCheckedPluginName %>" );
        g_bCurSelCanBeDuplicated = <%= BoolToText( bCurSelCanBeDuplicated ) %>;
        g_bCurSelCanBeRemoved = <%= BoolToText( bCurSelCanBeRemoved ) %>;
        g_bCurSelSupportsEnableDisable = <%= BoolToText( bCurSelSupportsEnableDisable ) %>;
        g_bCurSelSupportsProperties = <%= BoolToText( bCurSelSupportsProperties ) %>;
        g_bInError = <%= BoolToText( bCurSelInError ) %>;
        g_bEnabled = <%= BoolToText( bCurSelEnabled ) %>;
        g_bShowActiveScriptWarning = <%= BoolToText( bCurSelIsActiveScriptNoFilename ) %>;<%

if ( SHOWING_PLUGINS = dwDisplayMode ) then
    if( FALSE = bCheckedAnItem ) then %>
        if( document.mainForm.plugins && ( document.mainForm.plugins[ 0 ] ) )
        {
            if( document.mainForm.plugins[ 0 ] )
            {
                document.mainForm.plugins[ 0 ].checked = true;
                document.mainForm.plugins[ 0 ].onclick();
            }
        }
<% 
        end if 
    end if %>
    <% jsCATCH %>
}
</script>
</html><%
LatchCurrentPage "pubpoints/pubpoint_props.asp", qs
EndErrorHandling "pubpoint_props.asp" 

on error resume next
WMSServerHashASPCleanup
WMSConnectASPCleanup
%>
