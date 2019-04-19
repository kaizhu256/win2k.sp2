<%@ Language=VBScript CODEPAGE=65001 %>
<!--#include file="include/wmsLocStrings.inc"-->
<!--#include file="include/wmsCommon.inc"-->
<!--#include file="include/wmsHeader.inc"-->
<!--#include file="include/wmsServerHash.inc"-->
<!--#include file="include/wmsPlugins.inc"-->
<!--#include file="include/wmsError.inc"-->
<%
'+-------------------------------------------------------------------------
'
'  Microsoft Windows Media
'  Copyright (C) Microsoft Corporation. All rights reserved.
'
'  File:       Plugin_Description.asp
'
'  Contents:   Pop-up window used to display limit, plug-in, and property descriptions
'
'--------------------------------------------------------------------------

BeginErrorHandling
on error resume next

Dim bDisplayPluginHelp
Dim bDisplayLimitHelp
Dim strLimitDescription
Dim strLimitName
Dim strPageTitle

bDisplayPluginHelp = FALSE
bDisplayLimitHelp = FALSE

if( 0 < Len( qs( "limit" ) ) ) then

    bDisplayPluginHelp = FALSE
    bDisplayLimitHelp = TRUE

    Dim dwWhichLimit
    dwWhichLimit = CInt( qs( "limit" ) )
    
    if ( 0 = dwWhichLimit ) then
        strLimitName = L_PLAYERCONNLIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC0_TEXT
    elseif ( 1 = dwWhichLimit ) then
        strLimitName = L_DISTCONNLIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC1_TEXT
    elseif ( 2 = dwWhichLimit ) then
        strLimitName = L_AGGPLAYERBWLIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC2_TEXT    
    elseif ( 3 = dwWhichLimit ) then
        strLimitName = L_DISTBWLIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC3_TEXT
    elseif ( 4 = dwWhichLimit ) then
        strLimitName = L_BWPERSTREAMPERPLAYERLIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC4_TEXT
    elseif ( 5 = dwWhichLimit ) then
        strLimitName = L_BWPEROUTDISTSTREAMLIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC5_TEXT
    elseif ( 6 = dwWhichLimit ) then
        strLimitName = L_CONNECTRATELIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC6_TEXT
    elseif ( 7 = dwWhichLimit ) then
        strLimitName = L_PLAYERINATOLIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC7_TEXT
    elseif ( 8 = dwWhichLimit ) then
        strLimitName = L_PLAYERCONNECTACKLIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC8_TEXT
    elseif ( 9 = dwWhichLimit ) then
        strLimitName = L_ODLIMCXNRATE_TEXT
        strLimitDescription = L_LIMITTEXTDESC9_TEXT
    elseif ( 10 = dwWhichLimit ) then
        strLimitName = L_SRVINCOMINGBW_TEXT
        strLimitDescription = L_LIMITTEXTDESC11_TEXT
    elseif ( 30 = dwWhichLimit ) then
        strLimitName = L_BWPERRAPIDSTARTLIMIT_TEXT
        strLimitDescription = L_LIMITTEXTDESC10_TEXT
    elseif ( 31 = dwWhichLimit ) then
        strLimitName = L_GENDISTCACHING_TEXT
        strLimitDescription = L_GENDISTCACHINGHELP_TEXT
        bDisplayPluginHelp = FALSE
        bDisplayLimitHelp = FALSE
    elseif ( 32 = dwWhichLimit ) then
        strLimitName = L_GENACCESSDIRWILD_TEXT
        bDisplayPluginHelp = FALSE
        bDisplayLimitHelp = FALSE
        strLimitDescription = L_GENACCESSDIRWILDHELP_TEXT
    elseif ( 34 = dwWhichLimit ) then
        strLimitName = L_GENSTRMSPLITTING_TEXT
        strLimitDescription = L_GENSTRMSPLITTINGHELP_TEXT
        bDisplayPluginHelp = FALSE
        bDisplayLimitHelp = FALSE
    elseif ( 35 = dwWhichLimit ) then
        strLimitName = L_GENAUTOSTARTPP_TEXT
        strLimitDescription = L_GENAUTOSTARTPPHELP_TEXT
        bDisplayPluginHelp = FALSE
        bDisplayLimitHelp = FALSE
    elseif ( 36 = dwWhichLimit ) then
        strLimitName = L_GENPLAYERCACHING_TEXT
        strLimitDescription = L_GENPLAYERCACHINGHELP_TEXT
        bDisplayPluginHelp = FALSE
        bDisplayLimitHelp = FALSE
    elseif ( 37 = dwWhichLimit ) then
        strLimitName = L_GENSTARTUP_PROFILE_TEXT
        strLimitDescription = L_GENSTARTUPPROFILEHELP_TEXT
        bDisplayPluginHelp = FALSE
        bDisplayLimitHelp = FALSE        
    elseif ( 38 = dwWhichLimit ) then
        strLimitName = L_GENSTARTUP_START_VROOT_TEXT
        strLimitDescription = L_GENSTARTUP_START_VROOTHELP_TEXT
        bDisplayPluginHelp = FALSE
        bDisplayLimitHelp = FALSE        
    elseif ( PPLIMDESCOFFSET = dwWhichLimit ) then
        strLimitName = L_PLAYERCONNLIMITNAME_TEXT
        strLimitDescription = L_LIMITPPTEXTDESC20_TEXT
    elseif ( ( PPLIMDESCOFFSET + 1 ) = dwWhichLimit ) then
        strLimitName = L_DISTCONNLIMITNAME_TEXT
        strLimitDescription = L_LIMITPPTEXTDESC21_TEXT
    elseif ( ( PPLIMDESCOFFSET + 2 ) = dwWhichLimit ) then
        strLimitName = L_AGGPLAYERBWLIMITNAME_TEXT
        strLimitDescription = L_LIMITPPTEXTDESC22_TEXT
    elseif ( ( PPLIMDESCOFFSET + 3 ) = dwWhichLimit ) then
        strLimitName = L_DISTBWLIMITNAME_TEXT
        strLimitDescription = L_LIMITPPTEXTDESC23_TEXT
    elseif ( ( PPLIMDESCOFFSET + 4 ) = dwWhichLimit ) then
        strLimitName = L_BWPERSTREAMPERPLAYERLIMITNAME_TEXT
        strLimitDescription = L_LIMITPPTEXTDESC24_TEXT
    elseif ( ( PPLIMDESCOFFSET + 5 ) = dwWhichLimit ) then
        strLimitName = L_BWPEROUTDISTSTREAMLIMITNAME_TEXT
        strLimitDescription = L_LIMITPPTEXTDESC25_TEXT
    elseif ( ( PPLIMDESCOFFSET + 6 ) = dwWhichLimit ) then
        strLimitName = L_CONNECTRATELIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC6_TEXT
    elseif ( ( PPLIMDESCOFFSET + 7 ) = dwWhichLimit ) then
        strLimitName = L_PLAYERINATOLIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC7_TEXT
    elseif ( ( PPLIMDESCOFFSET + 8 ) = dwWhichLimit ) then
        strLimitName = L_PLAYERCONNECTACKLIMITNAME_TEXT
        strLimitDescription = L_LIMITTEXTDESC8_TEXT
    elseif ( ( PPLIMDESCOFFSET + 9 ) = dwWhichLimit ) then
        strLimitName = L_ODLIMCXNRATE_TEXT
        strLimitDescription = L_LIMITTEXTDESC9_TEXT
    else
        strLimitName = "??"
        strLimitDescription = "??"
    end if

elseif( "" <> qs( "credentials" ) ) then
    
    bDisplayPluginHelp = FALSE
    bDisplayLimitHelp = FALSE

    Dim dwWhichCredOption
    dwWhichCredOption = CInt( qs( "credentials" ) )
    
    if ( 0 = dwWhichCredOption ) then
        strLimitName = L_DISTCREDENTIALSNAME_TEXT
        strLimitDescription = L_DISTCREDDESC0_TEXT
    else
        strLimitName = "??"
        strLimitDescription = "??"
    end if

elseif( "" <> qs( "networking" ) ) then
    
    bDisplayPluginHelp = FALSE
    bDisplayLimitHelp = FALSE

    strLimitName = L_BUFFERSPSETTING_TEXT
    strLimitDescription = L_BUFFERINGDESC_TEXT

elseif( "" <> qs( "cacheproxyexp" ) ) then
    
    bDisplayPluginHelp = FALSE
    bDisplayLimitHelp = FALSE

	strLimitName = L_CACHEPROXSPPROP_TEXT
    strLimitDescription = L_CPEXPIRDESC_TEXT
    
elseif( "" <> qs( "cacheproxyexpOD" ) ) then
    
    bDisplayPluginHelp = FALSE
    bDisplayLimitHelp = FALSE

	strLimitName = L_CACHEPROXSPPROPOD_TEXT
    strLimitDescription = L_CPEXPIRDESC_TEXT

elseif( "" <> qs( "wireless" ) ) then
    
    bDisplayPluginHelp = FALSE
    bDisplayLimitHelp = FALSE

    strLimitName = L_FECNAME_TEXT
    strLimitDescription = L_FECDESC_TEXT

elseif( 0 = StrComp( qs("category"), CAT_CRED, vbTextCompare ) ) then
	
    strLimitName = L_CREDNAME_TEXT
    strLimitDescription = L_CREDDESC_TEXT

else
    bDisplayPluginHelp = TRUE
    bDisplayLimitHelp = FALSE
    ConnectToPlugin
end if
    
if bDisplayPluginHelp then
    strPageTitle = g_strDecodedInstance
else
    strPageTitle = strLimitName
end if

WriteHTMLHeader( SafeUnescape( strPageTitle ) )
%>
<link rel="stylesheet" type="text/css" href="<%= Session( "cssName" ) %>">
<% WritePluginJSUtils %>
<style>
BODY  
{
    color : #000000;
    background-color : #FFFFFF;
    border-style : none;
    font-size : x-small;
    font-family : Tahoma, Verdana, Century Gothic, Sans Serif;
    font-weight : normal;
    font-style : normal;
}
.dialog 
{
    color: #000000;
    background-color: #FFFFFF;
    border-color: #999999;
    border-style: none;
    border-width: 1px;
    font-size : x-small;
    font-weight : normal;
    margin-top: 0;
    margin-bottom: 0;
}
.subhead 
{
    border-style: none;
    color: #000000;
    font-size : x-small;
    font-weight : bold;
    margin-top: 0;
    margin-bottom: 0;
}
</style>
</head>
<body leftMargin="0" rightMargin="0" topMargin="0" bottomMargin="0" marginheight="0" marginwidth="0" topmargin="0" leftmargin="0" bgcolor="#ffffff" height="350" oncontextmenu="JavaScript:event.cancelBubble=true;return false;">
<form name="simple" method="get" action="JavaScript:window.close();">
<input type="hidden" name="op" value="apply">
<table height="100%" width="100%" align="left" valign="top" bgcolor="#FFFFFF" numcols="2" cols="2" height="<%= DESCRIPTIONDLGWIDTH %>" width="<%= DESCRIPTIONDLGHEIGHT %>" cellspacing="2" cellpadding="0" border="0" margin-bottom="0" margin-top="0">
<tr valign="top">
    <td align="left" valign="top" width="100%" class="dialog">
        <%' <!-- Begin Nested Table for Name, Author, Copyright--> %>
        <table class="dialog" bgcolor="#FFFFFF" cellspacing="1" cellpadding="1" border="0" width="100%" height="80px" cols=2>
        <tr valign="top">
            <td width="100%" valign="top">
                <table valign="top" class="dialog" bgcolor="#FFFFFF" cellspacing="1" cellpadding="1" border="0" width="100%" numcols="3" numrows="3">
                <tr valign="top">
                    <td class="subhead" nowrap>
                        <%
                        if( bDisplayPluginHelp ) then
                            Response.Write( Server.HTMLEncode( L_PLUGINNAMECOLON_TEXT ) )
                        elseif( bDisplayLimitHelp ) then
                            Response.Write( Server.HTMLEncode( L_LIMITNAMECOLON_TEXT ) )
                        else
                            Response.Write( Server.HTMLEncode( L_PROPNAMECOLON_TEXT ) )
                        end if
                        %>
                    </td>
                    <td>&nbsp;</td>
                    <td width="100%" class="dialog">
                        <%
                        if( bDisplayPluginHelp ) then
                            Response.Write( Server.HTMLEncode( g_objPlugin.Properties( "Name" ) ) )
                        else
                            Response.Write( Server.HTMLEncode( strLimitName ) )
                        end if %>
                    </td>
                </tr>
                <tr valign="top">
                    <td class="subhead" nowrap>
                        <%= L_AUTHORCOLON_TEXT %>
                    </td>
                    <td>&nbsp;</td>
                    <td width="100%" class="dialog">
                        <%
                        if( bDisplayPluginHelp ) then
                            Response.Write( Server.HTMLEncode( g_objPlugin.Properties( "Author" ) ) )
                        elseif( bDisplayLimitHelp ) then
                            Response.Write( Server.HTMLEncode( L_MICROSOFT_TEXT ) )
                        else
                            Response.Write( Server.HTMLEncode( L_MICROSOFT_TEXT ) )
                        end if
                        %>
                    </td>
                </tr>
                <tr valign="top">
                    <td class="subhead" nowrap>
                        <%= Server.HTMLEncode( L_COPYRIGHTCOLON_TEXT ) %>
                    </td>
                    <td>&nbsp;</td>
                    <td width="100%" class="dialog">
                        <%
                        if( bDisplayPluginHelp ) then
                            Response.Write( Server.HTMLEncode( g_objPlugin.Properties( "Copyright" ) ) )
                        elseif( bDisplayLimitHelp ) then
                            Response.Write( RemoveDangerousCharacters( L_COPYRIGHT_TEXT ) )
                        else
                            Response.Write( RemoveDangerousCharacters( L_COPYRIGHT_TEXT ) )
                        end if
                        %>
                    </td>
                </tr>
                </table>
            </td>
            <td class="dialog" align="right" valign="top" width="121" height="111">
                <img src="..\..\img\winmedia.gif" width="121" height="111" border="0" align="right">
            </td>
        </tr>
        </table>
    </td>
</tr>
<tr valign="top" height="1%">
    <td class="subhead" colspan="2" nowrap>
        &nbsp;<%= Server.HTMLEncode( L_DESCRIPTIONCOLON_TEXT ) %>
    </td>
</tr>
<tr valign="top" height="100%">
    <td class="dialog" colspan="2" align="left" valign="top">
        <table width="100%" border="0" valign="top" cols=3>
        <tr>
            <td width="4">
                <img src="..\..\img\WMSspacer.gif" width=4 border=0>
            </td>
            <td class="dialog" align="left" valign="top">
                <%
                if( bDisplayPluginHelp ) then 
                    strPluginDescription = Server.HTMLEncode( g_objPlugin.Properties( "Description" ) )
                    if( 0 = Len( strPluginDescription ) )then
                        strPluginDescription = "<i>" & Server.HTMLEncode( L_NODESCRIPTION_TEXT ) & "</i>"
                    end if
                    Response.Write( strPluginDescription )
                else 
                    Response.Write( Server.HTMLEncode( strLimitDescription ) )
                end if %>            
            </td>
            <td width="4px">
                <img src="..\..\img\WMSspacer.gif" width=4 border=0>
            </td>
        </tr>
        <tr valign="bottom">
            <td class="dialog" align="center" colspan="2" valign="top">
                <br><button align="center" value="" name="cancel" onclick="JavaScript:window.close();" tabIndex=1 ID="Submit1">&nbsp;<%= Server.HTMLEncode( L_CLOSEBUTTONSPACED_TEXT ) %>&#65279&nbsp;</button>
            </td>
        </tr>
        </table>
    </td>
</tr>
</table>
<!-- End Main Table -->
</form>
</body>
</html>

<%
PluginsASPCleanup
%>
