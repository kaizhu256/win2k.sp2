;/*++
;
;Copyright (c) 1989-1998 Microsoft Corporation
;
;Module Name:
;
;    Schema.INI
;    Used for Configuring the DIT at install time       
;
;Abstract:
;-----
;    Contains the information necessary to set up the default objects in an
;    installed DIT.  Covers the following cases:
;
;    1) First DS in the first site
;    2) First DS in any other site.
;    3) Replicated DS in an existing site.
;
;Notes:
;-----
;    For each object, by default, the RDN is picked up from the section name.
;    To override this, you can add the line RDN-Of-Object=<RDN> in the section
;    This is useful when you need two objects with the same RDN (but not DN). In
;    this case, name the sections differently (since two sections in an ini file
;    cannot be named the same, or only the first one will be picked up always), but
;    add the RDN-Of-Object key to the section with the duplicate RDN appropriately.
;    As an example, look at the sections System and Well-Known-Security-Id-System,
;    both of which has the RDN System.
;
;--*/



;---------------------------------------------------------
; DEFAULT STRUCTURE OF THE ENTERPRISE DIT
;---------------------------------------------------------

;!--------------------------------------------------------
;! The tree under the root of the domain.
;!--------------------------------------------------------

[DEFAULTROOTDOMAIN]
objectClass = DomainDNS
objectCategory = Domain-DNS
NTSecurityDescriptor=O:DAG:DAD:(A;;RP;;;WD)(OA;;CR;1131f6aa-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6ab-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6ac-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6aa-9c07-11d1-f79f-00c04fc2dcd2;;BA)(OA;;CR;1131f6ab-9c07-11d1-f79f-00c04fc2dcd2;;BA)(OA;;CR;1131f6ac-9c07-11d1-f79f-00c04fc2dcd2;;BA)(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;DA)(A;CI;RPWPCRLCLOCCRCWDWOSDSW;;;BA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;CI;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;EA)(A;CI;LC;;;RU)(OA;CIIO;RP;037088f8-0ae1-11d2-b422-00a0c968f939;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;CIIO;RP;59ba2f42-79a2-11d0-9020-00c04fc2d3cf;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;CIIO;RP;bc0ac240-79a9-11d0-9020-00c04fc2d4cf;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;CIIO;RP;4c164200-20c0-11d0-a768-00aa006e0529;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;CIIO;RP;5f202010-79a5-11d0-9020-00c04fc2d4cf;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;;RP;c7407360-20bf-11d0-a768-00aa006e0529;;RU)(OA;CIIO;RPLCLORC;;bf967a9c-0de6-11d0-a285-00aa003049e2;RU)(A;;RPRC;;;RU)(OA;CIIO;RPLCLORC;;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(A;;LCRPLORC;;;ED)(OA;CIIO;RP;037088f8-0ae1-11d2-b422-00a0c968f939;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;CIIO;RP;59ba2f42-79a2-11d0-9020-00c04fc2d3cf;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;CIIO;RP;bc0ac240-79a9-11d0-9020-00c04fc2d4cf;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;CIIO;RP;4c164200-20c0-11d0-a768-00aa006e0529;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;CIIO;RP;5f202010-79a5-11d0-9020-00c04fc2d4cf;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;CIIO;RPLCLORC;;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;;RP;b8119fd0-04f6-4762-ab7a-4986c76b3f9a;;RU)(OA;;RP;b8119fd0-04f6-4762-ab7a-4986c76b3f9a;;AU)(OA;CIIO;RP;b7c69e6d-2cc7-11d2-854e-00a0c983f608;bf967aba-0de6-11d0-a285-00aa003049e2;ED)(OA;CIIO;RP;b7c69e6d-2cc7-11d2-854e-00a0c983f608;bf967a9c-0de6-11d0-a285-00aa003049e2;ED)(OA;CIIO;RP;b7c69e6d-2cc7-11d2-854e-00a0c983f608;bf967a86-0de6-11d0-a285-00aa003049e2;ED)(OA;;CR;1131f6ad-9c07-11d1-f79f-00c04fc2dcd2;;DD)(OA;;CR;1131f6ad-9c07-11d1-f79f-00c04fc2dcd2;;BA)(OA;;CR;e2a36dc9-ae17-47c3-b58b-be34c55ba633;;S-1-5-32-557)(OA;;CR;280f369c-67c7-438e-ae98-1d46f3c6f541;;AU)(OA;;CR;ccc2dc7d-a6ad-4a7a-8846-c04e3cc53501;;AU)(OA;;CR;05c74c5e-4deb-43b4-bd9f-86664c2a7fd5;;AU)S:(AU;SA;WDWOWP;;;WD)(AU;SA;CR;;;BA)(AU;SA;CR;;;DU)(OU;CISA;WP;f30e3bbe-9ff0-11d1-b603-0000f80367c1;bf967aa5-0de6-11d0-a285-00aa003049e2;WD)(OU;CISA;WP;f30e3bbf-9ff0-11d1-b603-0000f80367c1;bf967aa5-0de6-11d0-a285-00aa003049e2;WD)
;     WARNING: For downward compatibility, Domain-DNS objects are actually
;     stamped with the default SD from [Sam-Domain]. To avoid confusion,
;     keep the default SD on [Sam-Domain], the default SD on [Domain-DNS],
;     and the nTSecurityDescriptor on DEFAULTROOTDOMAIN in schema.ini
;     the same.
auditingPolicy=\x0001
nTMixedDomain=1
;Its a NC ROOT
instanceType=5
;Its the PDC, set FSMO role owner
fSMORoleOwner=$REGISTRY=Machine DN Name
wellKnownObjects=$EMBEDDED:32:a9d1ca15768811d1aded00c04fd8d5cd:cn=Users,<Root Domain
wellKnownObjects=$EMBEDDED:32:aa312825768811d1aded00c04fd8d5cd:cn=Computers,<Root Domain
wellKnownObjects=$EMBEDDED:32:a361b2ffffd211d1aa4b00c04fd7d83a:ou=Domain Controllers,<Root Domain
wellKnownObjects=$EMBEDDED:32:ab1d30f3768811d1aded00c04fd8d5cd:cn=System,<Root Domain
wellKnownObjects=$EMBEDDED:32:ab8153b7768811d1aded00c04fd8d5cd:cn=LostAndFound,<Root Domain
wellKnownObjects=$EMBEDDED:32:2fbac1870ade11d297c400c04fd8d5cd:cn=Infrastructure,<Root Domain
wellKnownObjects=$EMBEDDED:32:18e2ea80684f11d2b9aa00c04f79f805:cn=Deleted Objects,<Root Domain
wellKnownObjects=$EMBEDDED:32:22b70c67d56e4efb91e9300fca3dc1aa:cn=ForeignSecurityPrincipals,<Root Domain
wellKnownObjects=$EMBEDDED:32:09460c08ae1e4a4ea0f64aee7daa1e5a:CN=Program Data,<Root Domain
wellKnownObjects=$EMBEDDED:32:f4be92a4c777485e878e9421d53087db:CN=Microsoft,CN=Program Data,<Root Domain
wellKnownObjects=$EMBEDDED:32:6227f0af1fc2410d8e3bb10615bb5b0f:CN=NTDS Quotas,<Root Domain
gPLink=$REGISTRY=GPODomainLink
mS-DS-MachineAccountQuota=10
msDS-AllUsersTrustQuota=1000
msDS-PerUserTrustQuota=1
msDS-PerUserTrustTombstonesQuota=10
isCriticalSystemObject=True
msDs-Behavior-Version=0
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

;        every domain needs these in the root
CHILD= LostAndFound
CHILD= Deleted Objects
CHILD= Users
CHILD= Computers
CHILD= System
CHILD= Domain Controllers
CHILD= Infrastructure
CHILD= ForeignSecurityPrincipals
CHILD= Program Data
CHILD= NTDS Quotas domain

[LostAndFound]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass =lostAndFound
ObjectCategory =Lost-And-Found
description=Default container for orphaned objects
showInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[Deleted Objects]
; NOTE: This section is used for two objects, the Deleted Objects container
; in Root Domain NC and the deleted objects container in the Config NC.
nTSecurityDescriptor=O:SYG:SYD:P(A;;RPWPCCDCLCSWRCWDWOSD;;;SY)(A;;RPLC;;;BA)
objectClass =container
ObjectCategory =container
description=Default container for deleted objects
showInAdvancedViewOnly=True
isDeleted=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[Users]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPWPCRCCDCLCLORCWOWDSW;;;DA)(OA;;CCDC;bf967aba-0de6-11d0-a285-00aa003049e2;;AO)(OA;;CCDC;bf967a9c-0de6-11d0-a285-00aa003049e2;;AO)(OA;;CCDC;bf967aa8-0de6-11d0-a285-00aa003049e2;;PO)(A;;RPLCLORC;;;AU)(OA;;CCDC;4828CC14-1437-45bc-9B07-AD6F015E5F28;;AO)
objectClass =Container
ObjectCategory =Container
description=Default container for upgraded user accounts
ShowInAdvancedViewOnly=False
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[Computers]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPWPCRCCDCLCLORCWOWDSW;;;DA)(OA;;CCDC;bf967a86-0de6-11d0-a285-00aa003049e2;;AO)(OA;;CCDC;bf967aba-0de6-11d0-a285-00aa003049e2;;AO)(OA;;CCDC;bf967a9c-0de6-11d0-a285-00aa003049e2;;AO)(OA;;CCDC;bf967aa8-0de6-11d0-a285-00aa003049e2;;PO)(A;;RPLCLORC;;;AU)(OA;;CCDC;4828CC14-1437-45bc-9B07-AD6F015E5F28;;AO)
objectClass =Container
ObjectCategory =Container
description=Default container for upgraded computer accounts  
ShowInAdvancedViewOnly=False
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[System]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass =Container
ObjectCategory =Container
description=Builtin system settings 
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

CHILD= WinsockServices
CHILD= RpcServices
CHILD= FileLinks
CHILD= Default Domain Policy
CHILD= Meetings
CHILD= Policies
CHILD= RAS and IAS Servers Access Check
CHILD= File Replication Service
CHILD= Dfs-Configuration
CHILD= IP Security
CHILD= AdminSDHolder
CHILD= ComPartitions
CHILD= ComPartitionSets
CHILD= WMIPolicy
CHILD = DomainUpdates

[WinsockServices]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass =Container
ObjectCategory =Container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True

[RpcServices]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass =rpcContainer
ObjectCategory =Rpc-Container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[FileLinks]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = fileLinkTracking
ObjectCategory = File-Link-Tracking
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

CHILD=VolumeTable
CHILD=ObjectMoveTable

[VolumeTable]
nTSecurityDescriptor=O:DAG:DAD:P(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;CI;RPWPCRLCLOCCRCWDWOSDSW;;;BA)(A;CI;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;EA)
objectClass= linkTrackVolumeTable
ObjectCategory = Link-Track-Volume-Table
cn=VolumeTable
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[ObjectMoveTable]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= linkTrackObjectMoveTable
ObjectCategory= Link-Track-Object-Move-Table
cn= ObjectMoveTable
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[Default Domain Policy]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = domainPolicy
ObjectCategory = Domain-Policy
isCriticalSystemObject=True

CHILD=AppCategories

[AppCategories]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=classStore
ObjectCategory=Class-Store
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True

[Meetings]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass =Container
ObjectCategory =Container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True

[Policies]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;CC;;;PA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)S:(OU;SA;WDWOCCDCSDDT;f30e3bc2-9ff0-11d1-b603-0000f80367c1;;WD)(OU;CISA;WDWP;;f30e3bc2-9ff0-11d1-b603-0000f80367c1;WD)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_DOMAIN_DISALLOW_RENAME        |
;             FLAG_DOMAIN_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

CHILD={31B2F340-016D-11D2-945F-00C04FB984F9}
CHILD={6AC1786C-016F-11D2-945F-00C04fB984F9}

[{31B2F340-016D-11D2-945F-00C04FB984F9}]
nTSecurityDescriptor=O:DAG:DAD:P(A;CI;RPWPCCDCLCLOLORCWOWDSDDTSW;;;DA)(A;CI;RPWPCCDCLCLOLORCWOWDSDDTSW;;;EA)(A;CI;RPWPCCDCLCLOLORCWOWDSDDTSW;;;CO)(A;CI;RPWPCCDCLCLORCWOWDSDDTSW;;;SY)(A;CI;RPLCLORC;;;AU)(OA;CI;CR;edacfd8f-ffb3-11d1-b41d-00a0c968f939;;AU)(A;CI;LCRPLORC;;;ED)
objectClass=groupPolicyContainer
ObjectCategory=Group-Policy-Container
ShowInAdvancedViewOnly=True
displayName=Default Domain Policy
gPCFileSysPath=$REGISTRY=GPODomainFilePath
gPCFunctionalityVersion=2
gPCMachineExtensionNames=[{827D319E-6EAC-11D2-A4EA-00C04F79F83A}{803E14A0-B4FB-11D0-A0D0-00A0C90F574B}]
versionNumber=1
flags=0
isCriticalSystemObject=True
;systemFlags=FLAG_DOMAIN_DISALLOW_RENAME        |
;             FLAG_DOMAIN_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

CHILD=$REGISTRY=GPOUserName
CHILD=Machine

[{6AC1786C-016F-11D2-945F-00C04fB984F9}]
nTSecurityDescriptor=O:DAG:DAD:P(A;CI;RPWPCCDCLCLOLORCWOWDSDDTSW;;;DA)(A;CI;RPWPCCDCLCLOLORCWOWDSDDTSW;;;EA)(A;CI;RPWPCCDCLCLOLORCWOWDSDDTSW;;;CO)(A;CI;RPWPCCDCLCLORCWOWDSDDTSW;;;SY)(A;CI;RPLCLORC;;;AU)(OA;CI;CR;edacfd8f-ffb3-11d1-b41d-00a0c968f939;;AU)(A;CI;LCRPLORC;;;ED)
objectClass=groupPolicyContainer
ObjectCategory=Group-Policy-Container
ShowInAdvancedViewOnly=True
displayName=Default Domain Controllers Policy
gPCFileSysPath=$REGISTRY=GPODCFilePath
gPCFunctionalityVersion=2
gPCMachineExtensionNames=[{827D319E-6EAC-11D2-A4EA-00C04F79F83A}{803E14A0-B4FB-11D0-A0D0-00A0C90F574B}]
versionNumber=1
flags=0
isCriticalSystemObject=True
;systemFlags=FLAG_DOMAIN_DISALLOW_RENAME        |
;             FLAG_DOMAIN_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

CHILD=$REGISTRY=GPOUserName
CHILD=Machine

[$REGISTRY=GPOUserName]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;;LCRPLORC;;;ED)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_DOMAIN_DISALLOW_RENAME        |
;             FLAG_DOMAIN_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[Machine]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;;LCRPLORC;;;ED)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_DOMAIN_DISALLOW_RENAME        |
;             FLAG_DOMAIN_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[RAS and IAS Servers Access Check]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPWPCRLCLOCCDCRCWDWOSDSW;;;RS)(A;;RPLCLORC;;;RU)
objectClass=Container
objectCategory=Container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[File Replication Service]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= nTFRSSettings
objectCategory= NTFRS-Settings
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000


[Dfs-Configuration]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass =dfsConfiguration
ObjectCategory =Dfs-Configuration 
ShowInAdvancedViewOnly=False
isCriticalSystemObject=True

[AdminSDHolder]
nTSecurityDescriptor=O:DAG:DAD:P(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSWSD;;;BA)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(OA;;RP;037088f8-0ae1-11d2-b422-00a0c968f939;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;;RP;59ba2f42-79a2-11d0-9020-00c04fc2d3cf;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;;RP;bc0ac240-79a9-11d0-9020-00c04fc2d4cf;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;;RP;4c164200-20c0-11d0-a768-00aa006e0529;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;;RP;5f202010-79a5-11d0-9020-00c04fc2d4cf;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;;RPLCLORC;;bf967aba-0de6-11d0-a285-00aa003049e2;RU)(OA;;CR;ab721a53-1e2f-11d0-9819-00aa0040529b;;WD)(OA;;CR;ab721a53-1e2f-11d0-9819-00aa0040529b;;PS)(OA;;RPWP;bf967a7f-0de6-11d0-a285-00aa003049e2;;CA)(OA;;RP;037088f8-0ae1-11d2-b422-00a0c968f939;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;;RP;59ba2f42-79a2-11d0-9020-00c04fc2d3cf;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;;RP;bc0ac240-79a9-11d0-9020-00c04fc2d4cf;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;;RP;4c164200-20c0-11d0-a768-00aa006e0529;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;;RP;5f202010-79a5-11d0-9020-00c04fc2d4cf;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;;RPLCLORC;;4828CC14-1437-45bc-9B07-AD6F015E5F28;RU)(OA;;RP;46a9b11d-60ae-405a-b7e8-ff8a58d456d2;;S-1-5-32-560)(OA;;WPRP;6db69a1c-9422-11d1-aebd-0000f80367c1;;S-1-5-32-561)S:(AU;SA;WDWOWP;;;WD)
objectClass =Container
ObjectCategory =Container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[ComPartitions]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = Container
objectCategory = Container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[ComPartitionSets]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = Container
objectCategory = Container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[WMIPolicy]
nTSecurityDescriptor=O:DAD:P(A;;CCLCSWRPWPLORC;;;BA)(A;;CCLCSWRPWPLORC;;;PA)(A;CI;LCRPLORC;;;AU)(A;CI;LCRPLORC;;;SY)(A;CI;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;EA)(A;CI;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;DA)(A;CIIO;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;CO)
objectClass = Container
objectCategory = Container
ShowInAdvancedViewOnly=True

CHILD= PolicyTemplate
CHILD= SOM
CHILD= PolicyType
CHILD= WMIGPO

[PolicyTemplate]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;CC;;;PA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = Container
objectCategory = Container
ShowInAdvancedViewOnly=True

[SOM]
nTSecurityDescriptor=O:DAD:P(A;CI;LCRPLORC;;;AU)(A;CI;LCRPLORC;;;SY)(A;CI;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;DA)(A;CI;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;EA)(A;;CCLCSWRPWPLORC;;;BA)(A;;CCLCSWRPWPLORC;;;PA)(A;CIIO;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;CO)
objectClass = Container
objectCategory = Container
ShowInAdvancedViewOnly=True

[PolicyType]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;CC;;;PA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = Container
objectCategory = Container
ShowInAdvancedViewOnly=True

[WMIGPO]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;CC;;;PA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = Container
objectCategory = Container
ShowInAdvancedViewOnly=True

[IP Security]
nTSecurityDescriptor=O:DAG:DAD:(A;CI;RPLCLORC;;;DC)(A;CI;RPLCLORC;;;PA)(A;CI;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;CI;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = Container
objectCategory = Container
isCriticalSystemObject=True

CHILD= ipsecPolicy{72385230-70FA-11D1-864C-14A300000000}
CHILD= ipsecISAKMPPolicy{72385231-70FA-11D1-864C-14A300000000}
CHILD= ipsecNFA{72385232-70FA-11D1-864C-14A300000000}
CHILD= ipsecNFA{59319BE2-5EE3-11D2-ACE8-0060B0ECCA17}
CHILD= ipsecNFA{594272E2-071D-11D3-AD22-0060B0ECCA17}
CHILD= ipsecPolicy{72385236-70FA-11D1-864C-14A300000000}
CHILD= ipsecISAKMPPolicy{72385237-70FA-11D1-864C-14A300000000}
CHILD= ipsecNFA{59319C04-5EE3-11D2-ACE8-0060B0ECCA17}
CHILD= ipsecPolicy{7238523C-70FA-11D1-864C-14A300000000}
CHILD= ipsecISAKMPPolicy{7238523D-70FA-11D1-864C-14A300000000}
CHILD= ipsecNFA{7238523E-70FA-11D1-864C-14A300000000}
CHILD= ipsecNFA{59319BF3-5EE3-11D2-ACE8-0060B0ECCA17}
CHILD= ipsecNFA{6A1F5C6F-72B7-11D2-ACF0-0060B0ECCA17}
CHILD= ipsecNFA{594272FD-071D-11D3-AD22-0060B0ECCA17}
CHILD= ipsecNegotiationPolicy{59319BDF-5EE3-11D2-ACE8-0060B0ECCA17}
CHILD= ipsecNegotiationPolicy{59319BF0-5EE3-11D2-ACE8-0060B0ECCA17}
CHILD= ipsecNegotiationPolicy{59319C01-5EE3-11D2-ACE8-0060B0ECCA17}
CHILD= ipsecNegotiationPolicy{72385233-70FA-11D1-864C-14A300000000}
CHILD= ipsecNegotiationPolicy{7238523F-70FA-11D1-864C-14A300000000}
CHILD= ipsecNegotiationPolicy{7238523B-70FA-11D1-864C-14A300000000}
CHILD= ipsecFilter{7238523A-70FA-11D1-864C-14A300000000}
CHILD= ipsecFilter{72385235-70FA-11D1-864C-14A300000000}


[ipsecPolicy{72385230-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecPolicy
objectCategory= Ipsec-Policy
description= For all IP traffic, always request security using Kerberos trust. Allow unsecured communication with clients that do not respond to request.
ipsecDataType= 0x256
ipsecData= \x632120224c4fd111863b00a0248d302104000000302a000000
ipsecID= {72385230-70FA-11D1-864C-14A300000000}
ipsecName= Server (Request Security)
ipsecISAKMPReference= $EMBEDDED:CN=ipsecISAKMPPolicy{72385231-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNFAReference= $EMBEDDED:CN=ipsecNFA{72385232-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNFAReference= $EMBEDDED:CN=ipsecNFA{59319BE2-5EE3-11D2-ACE8-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
ipsecNFAReference= $EMBEDDED:CN=ipsecNFA{594272E2-071D-11D3-AD22-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True


[ipsecISAKMPPolicy{72385231-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecISAKMPPolicy
objectCategory= Ipsec-ISAKMP-Policy
ipsecDataType= 0x256
ipsecData= \xb820dc80c82ed111a89e00a0248d30214001000068d219511d07d311ad220060b0ecca170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000cdcd03000000400000000800000002000000400000000000000000000000000000000000000000cdcdcd02000000000000000000000080700000cdcdcdcd0000cdcd03000000400000000800000001000000400000000000000000000000000000000000000000cdcdcd02000000000000000000000080700000cdcdcdcd0000cdcd01000000400000000800000002000000400000000000000000000000000000000000000000cdcdcd01000000000000000000000080700000cdcdcdcd0000cdcd01000000400000000800000001000000400000000000000000000000000000000000000000cdcdcd01000000000000000000000080700000cdcdcdcd00
ipsecID= {72385231-70FA-11D1-864C-14A300000000}
ipsecOwnersReference= $EMBEDDED:CN=ipsecPolicy{72385230-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True


[ipsecNFA{72385232-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecNFA
objectCategory= Ipsec-NFA
description= For all IP traffic, always request security using Kerberos trust. Allow unsecured communication with clients that do not respond to request.
ipsecDataType= 0x256
ipsecData= \x00acbb118d49d111863900a0248d30212a0000000100000005000000020000000000fdffffff02000000000000000000000000000100000002000000000000
ipsecID= {72385232-70FA-11D1-864C-14A300000000}
ipsecName= Request Security (Optional) Rule
ipsecOwnersReference= $EMBEDDED:CN=ipsecPolicy{72385230-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyReference= $EMBEDDED:CN=ipsecNegotiationPolicy{72385233-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecFilterReference= $EMBEDDED:CN=ipsecFilter{7238523A-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True


[ipsecNFA{59319BE2-5EE3-11D2-ACE8-0060B0ECCA17}]
nTSecurityDescriptor=D:
objectClass= ipsecNFA
objectCategory= Ipsec-NFA
ipsecDataType= 0x256
ipsecData= \x00acbb118d49d111863900a0248d30212a0000000100000005000000020000000000fdffffff02000000000000000000000000000100000002000000000000
ipsecID= {59319BE2-5EE3-11D2-ACE8-0060B0ECCA17}
ipsecOwnersReference= $EMBEDDED:CN=ipsecPolicy{72385230-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyReference= $EMBEDDED:CN=ipsecNegotiationPolicy{59319BDF-5EE3-11D2-ACE8-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[ipsecNFA{594272E2-071D-11D3-AD22-0060B0ECCA17}]
nTSecurityDescriptor=D:
objectClass= ipsecNFA
objectCategory= Ipsec-NFA
description= Permit unsecure ICMP packets to pass through.
ipsecDataType= 0x256
ipsecData= \x00acbb118d49d111863900a0248d30212a0000000100000005000000020000000000fdffffff02000000000000000000000000000100000002000000000000
ipsecID= {594272E2-071D-11D3-AD22-0060B0ECCA17}
ipsecName= Permit unsecure ICMP packets to pass through.
ipsecOwnersReference= $EMBEDDED:CN=ipsecPolicy{72385230-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyReference= $EMBEDDED:CN=ipsecNegotiationPolicy{7238523B-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecFilterReference= $EMBEDDED:CN=ipsecFilter{72385235-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True


[ipsecNFA{6A1F5C6F-72B7-11D2-ACF0-0060B0ECCA17}]
nTSecurityDescriptor=D:
objectClass= ipsecNFA
objectCategory= Ipsec-NFA
description= Version Information Object
ipsecDataType= 0x256
ipsecData= \x6f5c1f6ab772d211acf00060b0ecca175000000000000100a666a6361a000000570069006e0064006f00770073002000320030003000300000001c000000410064006d0069006e006900730074007200610074006f0072000000060000000d000a00000000acbb118d49d111863900a0248d30212a0000000100000005000000020000000000fdffffff02000000000000000000000000000100000002000000000000
ipsecID= {6A1F5C6F-72B7-11D2-ACF0-0060B0ECCA17}
ipsecName= Version Information Object
isCriticalSystemObject=True


[ipsecPolicy{72385236-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecPolicy
objectCategory= Ipsec-Policy
description= Communicate normally (unsecured). Use the default response rule to negotiate with servers that request security. Only the requested protocol and port traffic with that server is secured.
ipsecDataType= 0x256
ipsecData= \x632120224c4fd111863b00a0248d302104000000302a000000
ipsecID= {72385236-70FA-11D1-864C-14A300000000}
ipsecName= Client (Respond Only)
ipsecISAKMPReference= $EMBEDDED:CN=ipsecISAKMPPolicy{72385237-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNFAReference= $EMBEDDED:CN=ipsecNFA{59319C04-5EE3-11D2-ACE8-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[ipsecISAKMPPolicy{72385237-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecISAKMPPolicy
objectCategory= Ipsec-ISAKMP-Policy
ipsecDataType= 0x256
ipsecData= \xb820dc80c82ed111a89e00a0248d30214001000073ec415f1d07d311ad220060b0ecca170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000cdcd03000000400000000800000002000000400000000000000000000000000000000000000000cdcdcd02000000000000000000000080700000cdcdcdcd0000cdcd03000000400000000800000001000000400000000000000000000000000000000000000000cdcdcd02000000000000000000000080700000cdcdcdcd0000cdcd01000000400000000800000002000000400000000000000000000000000000000000000000cdcdcd01000000000000000000000080700000cdcdcdcd0000cdcd01000000400000000800000001000000400000000000000000000000000000000000000000cdcdcd01000000000000000000000080700000cdcdcdcd00
ipsecID= {72385237-70FA-11D1-864C-14A300000000}
ipsecOwnersReference= $EMBEDDED:CN=ipsecPolicy{72385236-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[ipsecNFA{59319C04-5EE3-11D2-ACE8-0060B0ECCA17}]
nTSecurityDescriptor=D:
objectClass= ipsecNFA
objectCategory= Ipsec-NFA
ipsecDataType= 0x256
ipsecData= \x00acbb118d49d111863900a0248d30212a0000000100000005000000020000000000fdffffff02000000000000000000000000000100000002000000000000
ipsecID= {59319C04-5EE3-11D2-ACE8-0060B0ECCA17}
ipsecOwnersReference= $EMBEDDED:CN=ipsecPolicy{72385236-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyReference= $EMBEDDED:CN=ipsecNegotiationPolicy{59319C01-5EE3-11D2-ACE8-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[ipsecPolicy{7238523C-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecPolicy
objectCategory= Ipsec-Policy
description= For all IP traffic, always require security using Kerberos trust. Do NOT allow unsecured communication with untrusted clients.
ipsecDataType= 0x256
ipsecData= \x632120224c4fd111863b00a0248d302104000000302a000000
ipsecID= {7238523C-70FA-11D1-864C-14A300000000}
ipsecName= Secure Server (Require Security)
ipsecISAKMPReference= $EMBEDDED:CN=ipsecISAKMPPolicy{7238523D-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNFAReference= $EMBEDDED:CN=ipsecNFA{7238523E-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNFAReference= $EMBEDDED:CN=ipsecNFA{59319BF3-5EE3-11D2-ACE8-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
ipsecNFAReference= $EMBEDDED:CN=ipsecNFA{594272FD-071D-11D3-AD22-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[ipsecISAKMPPolicy{7238523D-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecISAKMPPolicy
objectCategory= Ipsec-ISAKMP-Policy
ipsecDataType= 0x256
ipsecData= \xb820dc80c82ed111a89e00a0248d302140010000f97242591d07d311ad220060b0ecca170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000cdcd03000000400000000800000002000000400000000000000000000000000000000000000000cdcdcd02000000000000000000000080700000cdcdcdcd0000cdcd03000000400000000800000001000000400000000000000000000000000000000000000000cdcdcd02000000000000000000000080700000cdcdcdcd0000cdcd01000000400000000800000002000000400000000000000000000000000000000000000000cdcdcd01000000000000000000000080700000cdcdcdcd0000cdcd01000000400000000800000001000000400000000000000000000000000000000000000000cdcdcd01000000000000000000000080700000cdcdcdcd00
ipsecID= {7238523D-70FA-11D1-864C-14A300000000}
ipsecOwnersReference= $EMBEDDED:CN=ipsecPolicy{7238523C-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[ipsecNFA{7238523E-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecNFA
objectCategory= Ipsec-NFA
description= Accepts unsecured communication, but always requires clients to establish trust and security methods.  Will NOT communicate with untrusted clients.
ipsecDataType= 0x256
ipsecData= \x00acbb118d49d111863900a0248d30212a0000000100000005000000020000000000fdffffff02000000000000000000000000000100000002000000000000
ipsecID= {7238523E-70FA-11D1-864C-14A300000000}
ipsecName= Require Security
ipsecOwnersReference= $EMBEDDED:CN=ipsecPolicy{7238523C-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyReference= $EMBEDDED:CN=ipsecNegotiationPolicy{7238523F-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecFilterReference= $EMBEDDED:CN=ipsecFilter{7238523A-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[ipsecNFA{59319BF3-5EE3-11D2-ACE8-0060B0ECCA17}]
nTSecurityDescriptor=D:
objectClass= ipsecNFA
objectCategory= Ipsec-NFA
ipsecDataType= 0x256
ipsecData= \x00acbb118d49d111863900a0248d30212a0000000100000005000000020000000000fdffffff02000000000000000000000000000100000002000000000000
ipsecID= {59319BF3-5EE3-11D2-ACE8-0060B0ECCA17}
ipsecOwnersReference= $EMBEDDED:CN=ipsecPolicy{7238523C-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyReference= $EMBEDDED:CN=ipsecNegotiationPolicy{59319BF0-5EE3-11D2-ACE8-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[ipsecNFA{594272FD-071D-11D3-AD22-0060B0ECCA17}]
nTSecurityDescriptor=D:
objectClass= ipsecNFA
objectCategory= Ipsec-NFA
description= Permit unsecure ICMP packets to pass through.
ipsecDataType= 0x256
ipsecData= \x00acbb118d49d111863900a0248d30212a0000000100000005000000020000000000fdffffff02000000000000000000000000000100000002000000000000
ipsecID= {594272FD-071D-11D3-AD22-0060B0ECCA17}
ipsecName= Permit unsecure ICMP packets to pass through.
ipsecOwnersReference= $EMBEDDED:CN=ipsecPolicy{7238523C-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyReference= $EMBEDDED:CN=ipsecNegotiationPolicy{7238523B-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecFilterReference= $EMBEDDED:CN=ipsecFilter{72385235-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[ipsecNegotiationPolicy{59319BDF-5EE3-11D2-ACE8-0060B0ECCA17}]
nTSecurityDescriptor=D:
objectClass= ipsecNegotiationPolicy
objectCategory= Ipsec-Negotiation-Policy
ipsecDataType= 0x256
ipsecData= \xb920dc80c82ed111a89e00a0248d3021e40100000600000000000000000000000000000000000000010000000300000002000000020000004000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000030000000100000002000000400000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000001000000020000000200000040000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000100000001000000020000004000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000020000000000000001000000400000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000001000000000000000100000040000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ipsecID= {59319BDF-5EE3-11D2-ACE8-0060B0ECCA17}
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{59319BE2-5EE3-11D2-ACE8-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyType= {62F49E13-6C37-11D1-864C-14A300000000}
ipsecNegotiationPolicyAction= {8A171DD3-77E3-11D1-8659-A04F00000000}
isCriticalSystemObject=True

[ipsecNegotiationPolicy{59319BF0-5EE3-11D2-ACE8-0060B0ECCA17}]
nTSecurityDescriptor=D:
objectClass= ipsecNegotiationPolicy
objectCategory= Ipsec-Negotiation-Policy
ipsecDataType= 0x256
ipsecData= \xb920dc80c82ed111a89e00a0248d3021e40100000600000000000000000000000000000000000000010000000300000002000000020000004000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000030000000100000002000000400000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000001000000020000000200000040000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000100000001000000020000004000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000020000000000000001000000400000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000001000000000000000100000040000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ipsecID= {59319BF0-5EE3-11D2-ACE8-0060B0ECCA17}
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{59319BF3-5EE3-11D2-ACE8-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyType= {62F49E13-6C37-11D1-864C-14A300000000}
ipsecNegotiationPolicyAction= {8A171DD3-77E3-11D1-8659-A04F00000000}
isCriticalSystemObject=True

[ipsecNegotiationPolicy{59319C01-5EE3-11D2-ACE8-0060B0ECCA17}]
nTSecurityDescriptor=D:
objectClass= ipsecNegotiationPolicy
objectCategory= Ipsec-Negotiation-Policy
ipsecDataType= 0x256
ipsecData= \xb920dc80c82ed111a89e00a0248d3021e40100000600000000000000000000000000000000000000010000000300000002000000020000004000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000030000000100000002000000400000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000001000000020000000200000040000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000100000001000000020000004000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000020000000000000001000000400000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000001000000000000000100000040000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ipsecID= {59319C01-5EE3-11D2-ACE8-0060B0ECCA17}
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{59319C04-5EE3-11D2-ACE8-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyType= {62F49E13-6C37-11D1-864C-14A300000000}
ipsecNegotiationPolicyAction= {8A171DD3-77E3-11D1-8659-A04F00000000}
isCriticalSystemObject=True

[ipsecNegotiationPolicy{72385233-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecNegotiationPolicy
objectCategory= Ipsec-Negotiation-Policy
description= Accepts unsecured communication, but requests clients to establish trust and security methods.  Will communicate insecurely to untrusted clients if they do not respond to request.
ipsecDataType= 0x256
ipsecData= \xb920dc80c82ed111a89e00a0248d3021940100000500000084030000a086010000000000000000000100000003000000020000000200000040000000080000005c00530065007200760069006300650073005c0050006f006c006900630079004100670065006e0084030000a086010000000000000000000100000001000000020000000200000040000000080000000000000055f4b2375c004c006f00630015000f0001000800200265002002650058c47605f8ce78052c010000a086010000000000000000000100000002000000000000000100000040000000080000002d0039004100430031002d0034004400360044002d0041003100420030002d0031003500380037002c010000a08601000000000000000000010000000100000000000000010000004000000008000000650074005c00530065007200760069006300650073005c0050006f006c006900630079004100670000000000000000000000000000000000000000000100000001000000020000004000000008000000360043002d0033004200390037002d0034003500350032002d0038004500340035002d003900390000
ipsecID= {72385233-70FA-11D1-864C-14A300000000}
ipsecName= Request Security (Optional)
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{72385232-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyType= {62F49E10-6C37-11D1-864C-14A300000000}
ipsecNegotiationPolicyAction= {3F91A81A-7647-11D1-864D-D46A00000000}
isCriticalSystemObject=True

[ipsecNegotiationPolicy{7238523F-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecNegotiationPolicy
objectCategory= Ipsec-Negotiation-Policy
description= Accepts unsecured communication, but always requires clients to establish trust and security methods.  Will NOT communicate with untrusted clients.
ipsecDataType= 0x256
ipsecData= \xb920dc80c82ed111a89e00a0248d3021440100000400000084030000a0860100000000000000000001000000030000000200000002000000400000000800000075007200720065006e00740043006f006e00740072006f006c005300650074005c0053006500720084030000a0860100000000000000000001000000030000000100000002000000400000000800000070007300650063004e00460041007b00370032003300380035003200330045002d0037003000460084030000a086010000000000000000000100000001000000020000000200000040000000080000006c006900630079005c004c006f00630061006c005c00690070007300650063004e00460041007b0084030000a08601000000000000000000010000000100000001000000020000004000000008000000650063004e00460041007b00420046004300370043003300350041002d0042003500390032002d0000
ipsecID= {7238523F-70FA-11D1-864C-14A300000000}
ipsecName= Require Security
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{7238523E-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyType= {62F49E10-6C37-11D1-864C-14A300000000}
ipsecNegotiationPolicyAction= {3F91A81A-7647-11D1-864D-D46A00000000}
isCriticalSystemObject=True

[ipsecNegotiationPolicy{7238523B-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecNegotiationPolicy
objectCategory= Ipsec-Negotiation-Policy
description= Permit unsecured IP packets to pass through.
ipsecDataType= 0x256
ipsecData= \xb920dc80c82ed111a89e00a0248d3021040000000000000000
ipsecID= {7238523B-70FA-11D1-864C-14A300000000}
ipsecName= Permit
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{594272FD-071D-11D3-AD22-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{594272E2-071D-11D3-AD22-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
ipsecNegotiationPolicyType= {62F49E10-6C37-11D1-864C-14A300000000}
ipsecNegotiationPolicyAction= {8A171DD2-77E3-11D1-8659-A04F00000000}
isCriticalSystemObject=True

[ipsecFilter{7238523A-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecFilter
objectCategory= Ipsec-Filter
description= Matches all IP packets from this computer to any other computer, except broadcast, multicast, Kerberos, RSVP and ISAKMP (IKE).
ipsecDataType= 0x256
ipsecData= \xb520dc80c82ed111a89e00a0248d30214a00000001000000020000000000020000000000020000000000dd9b3159e35ed211ace80060b0ecca170100000000000000ffffffff00000000000000000000000000000000000000000000000000
ipsecID= {7238523A-70FA-11D1-864C-14A300000000}
ipsecName= All IP Traffic
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{7238523E-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{72385232-70FA-11D1-864C-14A300000000},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[ipsecFilter{72385235-70FA-11D1-864C-14A300000000}]
nTSecurityDescriptor=D:
objectClass= ipsecFilter
objectCategory= Ipsec-Filter
description= Matches all ICMP packets between this computer and any other computer.
ipsecDataType= 0x256
ipsecData= \xb520dc80c82ed111a89e00a0248d302152000000010000000200000000000200000000000a000000490043004d005000000063d219511d07d311ad220060b0ecca170100000000000000ffffffff00000000000000000000000001000000000000000000000000
ipsecID= {72385235-70FA-11D1-864C-14A300000000}
ipsecName= All ICMP Traffic
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{594272FD-071D-11D3-AD22-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
ipsecOwnersReference= $EMBEDDED:CN=ipsecNFA{594272E2-071D-11D3-AD22-0060B0ECCA17},CN=IP Security,CN=System,<Root Domain
isCriticalSystemObject=True

[DomainUpdates]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)S:(AU;CISA;CCDCSDDT;;;WD)
objectClass= Container
objectCategory= Container
CHILD=Operations
CHILD=Windows2003Update

[Operations]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container
CHILD=ab402345-d3c3-455d-9ff7-40268a1099b6
CHILD=bab5f54d-06c8-48de-9b87-d78b796564e4
CHILD=f3dd09dd-25e8-4f9c-85df-12d6d2f2f2f5
CHILD=2416c60a-fe15-4d7a-a61e-dffd5df864d3
CHILD=7868d4c8-ac41-4e05-b401-776280e8e9f1
CHILD=860c36ed-5241-4c62-a18b-cf6ff9994173
CHILD=0e660ea3-8a5e-4495-9ad7-ca1bd4638f9e
CHILD=a86fe12a-0f62-4e2a-b271-d27f601f8182
CHILD=d85c0bfd-094f-4cad-a2b5-82ac9268475d
CHILD=6ada9ff7-c9df-45c1-908e-9fef2fab008a
CHILD=10b3ad2a-6883-4fa7-90fc-6377cbdc1b26
CHILD=98de1d3e-6611-443b-8b4e-f4337f1ded0b
CHILD=f607fd87-80cf-45e2-890b-6cf97ec0e284
CHILD=9cac1f66-2167-47ad-a472-2a13251310e4
CHILD=6ff880d6-11e7-4ed1-a20f-aac45da48650
CHILD=446f24ea-cfd5-4c52-8346-96e170bcb912
CHILD=51cba88b-99cf-4e16-bef2-c427b38d0767
CHILD=293f0798-ea5c-4455-9f5d-45f33a30703b
CHILD=5c82b233-75fc-41b3-ac71-c69592e6bf15
CHILD=7ffef925-405b-440a-8d58-35e8cd6e98c3
CHILD=4dfbb973-8a62-4310-a90c-776e00f83222
CHILD=8437C3D8-7689-4200-BF38-79E4AC33DFA0
CHILD=7cfb016c-4f87-4406-8166-bd9df943947f
CHILD=f7ed4553-d82b-49ef-a839-2f38a36bb069
CHILD=8ca38317-13a4-4bd4-806f-ebed6acb5d0c
CHILD=3c784009-1f57-4e2a-9b04-6915c9e71961
CHILD=6bcd5678-8314-11d6-977b-00c04f613221
CHILD=6bcd5679-8314-11d6-977b-00c04f613221
CHILD=6bcd567a-8314-11d6-977b-00c04f613221
CHILD=6bcd567b-8314-11d6-977b-00c04f613221
CHILD=6bcd567c-8314-11d6-977b-00c04f613221
CHILD=6bcd567d-8314-11d6-977b-00c04f613221
CHILD=6bcd567e-8314-11d6-977b-00c04f613221
CHILD=6bcd567f-8314-11d6-977b-00c04f613221
CHILD=6bcd5680-8314-11d6-977b-00c04f613221
CHILD=6bcd5681-8314-11d6-977b-00c04f613221
CHILD=6bcd5682-8314-11d6-977b-00c04f613221
CHILD=6bcd5683-8314-11d6-977b-00c04f613221
CHILD=6bcd5684-8314-11d6-977b-00c04f613221
CHILD=6bcd5685-8314-11d6-977b-00c04f613221
CHILD=6bcd5686-8314-11d6-977b-00c04f613221
CHILD=6bcd5687-8314-11d6-977b-00c04f613221
CHILD=6bcd5688-8314-11d6-977b-00c04f613221
CHILD=6bcd5689-8314-11d6-977b-00c04f613221
CHILD=6bcd568a-8314-11d6-977b-00c04f613221
CHILD=6bcd568b-8314-11d6-977b-00c04f613221
CHILD=6bcd568c-8314-11d6-977b-00c04f613221
CHILD=6bcd568d-8314-11d6-977b-00c04f613221
CHILD=3051c66f-b332-4a73-9a20-2d6a7d6e6a1c
CHILD=3e4f4182-ac5d-4378-b760-0eab2de593e2
CHILD=c4f17608-e611-11d6-9793-00c04f613221
CHILD=13d15cf0-e6c8-11d6-9793-00c04f613221
CHILD=8ddf6913-1c7b-4c59-a5af-b9ca3b3d2c4c


[ab402345-d3c3-455d-9ff7-40268a1099b6]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[bab5f54d-06c8-48de-9b87-d78b796564e4]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[f3dd09dd-25e8-4f9c-85df-12d6d2f2f2f5]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[2416c60a-fe15-4d7a-a61e-dffd5df864d3]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[7868d4c8-ac41-4e05-b401-776280e8e9f1]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[860c36ed-5241-4c62-a18b-cf6ff9994173]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[0e660ea3-8a5e-4495-9ad7-ca1bd4638f9e]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[a86fe12a-0f62-4e2a-b271-d27f601f8182]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[d85c0bfd-094f-4cad-a2b5-82ac9268475d]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6ada9ff7-c9df-45c1-908e-9fef2fab008a]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[10b3ad2a-6883-4fa7-90fc-6377cbdc1b26]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[98de1d3e-6611-443b-8b4e-f4337f1ded0b]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[f607fd87-80cf-45e2-890b-6cf97ec0e284]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[9cac1f66-2167-47ad-a472-2a13251310e4]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6ff880d6-11e7-4ed1-a20f-aac45da48650]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[446f24ea-cfd5-4c52-8346-96e170bcb912]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[51cba88b-99cf-4e16-bef2-c427b38d0767]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[293f0798-ea5c-4455-9f5d-45f33a30703b]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[5c82b233-75fc-41b3-ac71-c69592e6bf15]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[7ffef925-405b-440a-8d58-35e8cd6e98c3]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[4dfbb973-8a62-4310-a90c-776e00f83222]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[8437C3D8-7689-4200-BF38-79E4AC33DFA0]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[7cfb016c-4f87-4406-8166-bd9df943947f]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[f7ed4553-d82b-49ef-a839-2f38a36bb069]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[8ca38317-13a4-4bd4-806f-ebed6acb5d0c]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[3c784009-1f57-4e2a-9b04-6915c9e71961]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5678-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5679-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd567a-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd567b-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd567c-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd567d-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd567e-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd567f-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5680-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5681-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5682-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5683-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5684-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5685-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5686-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5687-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5688-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd5689-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd568a-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd568b-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd568c-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[6bcd568d-8314-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[3051c66f-b332-4a73-9a20-2d6a7d6e6a1c]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[3e4f4182-ac5d-4378-b760-0eab2de593e2]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[c4f17608-e611-11d6-9793-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[13d15cf0-e6c8-11d6-9793-00c04f613221]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[8ddf6913-1c7b-4c59-a5af-b9ca3b3d2c4c]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container

[Windows2003Update]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass= Container
objectCategory= Container
revision=8


[Domain Controllers]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;;LCRPLORC;;;ED)S:(AU;SA;WDWOCCDCSDDT;;;WD)(AU;CISA;WP;;;WD)
objectClass =organizationalUnit
ObjectCategory =Organizational-Unit
description=Default container for domain controllers  
ShowInAdvancedViewOnly=False
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
gPLink=$REGISTRY=GPODCLink
systemFlags=0x8C000000

[Infrastructure]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)S:(AU;SA;CRWP;;;WD)
objectClass =infrastructureUpdate
ObjectCategory =Infrastructure-Update
ShowInAdvancedViewOnly=True
fSMORoleOwner=$REGISTRY=Machine DN Name
isCriticalSystemObject=True
;systemFlags=FLAG_CONFIG_DISALLOW_RENAME        |
;             FLAG_CONFIG_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[ForeignSecurityPrincipals]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)
objectClass =Container
ObjectCategory =Container
description=Default container for security identifiers (SIDs) associated with objects from external, trusted domains  
ShowInAdvancedViewOnly=False
isCriticalSystemObject=True
;systemFlags=FLAG_DOMAIN_DISALLOW_RENAME        |
;             FLAG_DOMAIN_DISALLOW_MOVE         |
;             FLAG_DISALLOW_DELETE
systemFlags=0x8C000000

[Program Data]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)
objectClass =Container
ObjectCategory =Container
description=Default location for storage of application data.
CHILD = Microsoft

[Microsoft]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)
objectClass =Container
ObjectCategory =Container
description=Default location for storage of Microsoft application data.

[NTDS Quotas domain]
RDN-Of-Object=NTDS Quotas
nTSecurityDescriptor=O:DAG:DA D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPLCLORC;;;BA)(OA;;CR;4ecc03fe-ffc0-4947-b630-eb672a8a9dbc;;WD)S:(AU;CISA;WDWOSDDTWPCRCCDCSW;;;WD)
objectClass=msDS-QuotaContainer
objectCategory=ms-DS-Quota-Container
description=Quota specifications container
ShowInAdvancedViewOnly=True
isCriticalSystemObject=True
;systemFlags=FLAG_DISALLOW_DELETE
systemFlags=0x80000000
msDS-TombstoneQuotaFactor=100


;!--------------------------------------------------------
;! The tree under the default configuration container
;!--------------------------------------------------------

[DEFAULTCONFIGNC]
objectClass =Configuration
ObjectCategory =Configuration
;Its a NC ROOT - (NC_MASTER_SUBREF)
instanceType=13
nTSecurityDescriptor=O:EAG:EAD:(OA;;CR;1131f6aa-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6ab-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6ac-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6aa-9c07-11d1-f79f-00c04fc2dcd2;;BA)(OA;;CR;1131f6ab-9c07-11d1-f79f-00c04fc2dcd2;;BA)(OA;;CR;1131f6ac-9c07-11d1-f79f-00c04fc2dcd2;;BA)(A;;RPLCLORC;;;AU)(A;CI;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;CIIO;RPWPCRLCLOCCRCWDWOSDSW;;;DA)(OA;;CR;1131f6ad-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6ad-9c07-11d1-f79f-00c04fc2dcd2;;BA)S:(AU;SA;WDWOWP;;;WD)(AU;SA;CR;;;BA)(AU;SA;CR;;;DU)(OU;SA;CR;45ec5156-db7e-47bb-b53f-dbeb2d03c40f;;WD)
ShowInAdvancedViewOnly=True
wellKnownObjects=$EMBEDDED:32:18e2ea80684f11d2b9aa00c04f79f805:cn=Deleted Objects,cn=Configuration,<Root Domain
wellKnownObjects=$EMBEDDED:32:ab8153b7768811d1aded00c04fd8d5cd:cn=LostAndFoundConfig,cn=Configuration,<Root Domain
wellKnownObjects=$EMBEDDED:32:6227f0af1fc2410d8e3bb10615bb5b0f:CN=NTDS Quotas,CN=Configuration,<Root Domain

CHILD= Deleted Objects
; lost and found objects
CHILD=LostAndFoundConfig
CHILD= Sites
CHILD= Partitions
CHILD= Services
;Container for Control Access Rights
CHILD= Extended-Rights
;Container for Display Specifications
CHILD=DisplaySpecifiers
CHILD= WellKnown Security Principals
; root of physical location tree
CHILD=Physical Locations
; for Adprep
CHILD=ForestUpdates
CHILD=NTDS Quotas config


;--------------------------------------------------------
; LostAndFoundConfig subtree under the default configuration container
;--------------------------------------------------------
[LostAndFoundConfig]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass =lostAndFound
ObjectCategory =Lost-And-Found
ShowInAdvancedViewOnly=True
;             FLAG_DISALLOW_DELETE
systemFlags=0x80000000

;--------------------------------------------------------
; Sites subtree under the default configuration container
;--------------------------------------------------------
[Sites]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)S:(AU;CISA;CCDCSDDT;;;WD)(OU;CIIOSA;CR;;f0f8ffab-1191-11d0-a060-00aa006c33ed;WD)(OU;CIIOSA;WP;f30e3bbe-9ff0-11d1-b603-0000f80367c1;bf967ab3-0de6-11d0-a285-00aa003049e2;WD)(OU;CIIOSA;WP;f30e3bbf-9ff0-11d1-b603-0000f80367c1;bf967ab3-0de6-11d0-a285-00aa003049e2;WD)(OU;CIIOSA;WP;3e10944c-c354-11d0-aff8-0000f80367c1;b7b13124-b82e-11d0-afee-0000f80367c1;WD)
objectClass = sitesContainer
ObjectCategory = Sites-Container
cn = Sites
ShowInAdvancedViewOnly=True
;             FLAG_DISALLOW_DELETE
;             FLAG_DISALLOW_MOVE_ON_DELETE
systemFlags=0x82000000

CHILD=Subnets
CHILD=Inter-Site Transports
CHILD=$REGISTRY=InstallSiteName

[Subnets]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = subnetContainer
ObjectCategory = Subnet-Container
cn = Subnets
ShowInAdvancedViewOnly=True
;             FLAG_DISALLOW_DELETE
systemFlags=0x80000000


[Inter-Site Transports]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = interSiteTransportContainer
ObjectCategory = Inter-Site-Transport-Container
cn = Inter-Site Transports
ShowInAdvancedViewOnly=True
;             FLAG_DISALLOW_DELETE
systemFlags=0x80000000

CHILD=IP
CHILD=SMTP

[IP]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = interSiteTransport
ObjectCategory = Inter-Site-Transport
cn = IP
ShowInAdvancedViewOnly=True
transportAddressAttribute = dNSHostName
transportDllName = ismip.dll
;             FLAG_DISALLOW_DELETE
systemFlags=0x80000000

CHILD=DEFAULTIPSITELINK

[DEFAULTIPSITELINK]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = siteLink
ObjectCategory = Site-Link
cn = DefaultIpSiteLink
ShowInAdvancedViewOnly=True
; The replication period is every (cost) intervals, where an interval is 15
; minutes.  
cost=100
replInterval=180
siteList= $REGISTRY=InstallSiteDn

[SMTP]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = interSiteTransport
ObjectCategory = Inter-Site-Transport
cn = SMTP
ShowInAdvancedViewOnly=True
transportAddressAttribute = mailAddress
transportDllName = ismsmtp.dll
Options = 0x1 ; IGNORE_SCHEDULES

[$REGISTRY=InstallSiteName]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;;LCRPLORC;;;ED)
objectClass = Site
ObjectCategory = Site
cn = $REGISTRY=InstallSiteName
ShowInAdvancedViewOnly=True
;systemFlags=FLAG_CONFIG_ALLOW_RENAME
;            FLAG_DISALLOW_MOVE_ON_DELETE
systemFlags=0x42000000

CHILD=NTDS Site Settings
CHILD=Licensing Site Settings
CHILD=Servers

[NTDS Site Settings]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSDDTSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = nTDSSiteSettings
ObjectCategory = NTDS-Site-Settings
cn = NTDS Site Settings
ShowInAdvancedViewOnly=True
Schedule=$SYSDEFAULT=REPLSCHEDULE

[Licensing Site Settings]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSDDTSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;;RPWPCRLCLOCCRCWDWOSDDTSW;;;NS)(A;;RPWPCRLCLOCCRCWDWOSDDTSW;;;DD)
objectClass = licensingSiteSettings
ObjectCategory = Licensing-Site-Settings
cn = Licensing Site Settings
ShowInAdvancedViewOnly=True

[Servers]
nTSecurityDescriptor=O:EAG:EAD:(A;;CC;;;BA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)
objectClass = serversContainer
ObjectCategory = Servers-Container
cn = Servers
ShowInAdvancedViewOnly=True
;systemFlags=FLAG_DISALLOW_MOVE_ON_DELETE
systemFlags=0x02000000

;--------------------------------------------------------
; Partitions subtree under the default configuration container
;--------------------------------------------------------
[Partitions]
; DACL contains the following aces:
;   AU: list-contents, list-object, read-control
;   AU: read-prop for Public-Information, ms-DS-Behavior-Version, FSMO-Role-Owner, UPN-Suffixes and 
;                     ms-DS-SPN-Suffixes
;   EA: read-prop (all), write-prop (all), control-access, list-contents, list-object, create-child, 
;       read-control, write-dac, write-owner, extended-write
;   SY: full control
nTSecurityDescriptor=O:EAG:EAD:(A;;LCLORC;;;AU)(OA;;RP;e48d0154-bcf8-11d1-8702-00c04fb96050;;AU)(OA;;RP;d31a8757-2447-4545-8081-3bb610cacbf2;;AU)(OA;;RP;66171887-8f3c-11d0-afda-00c04fd930c9;;AU)(OA;;RP;032160bf-9824-11d1-aec0-0000f80367c1;;AU)(OA;;RP;789EE1EB-8C8E-4e4c-8CEC-79B31B7617B5;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;;CC;;;ED)S:(AU;CISA;WDWOCRWPCCDCSDDT;;;WD)
objectClass =crossRefContainer
ObjectCategory =Cross-Ref-Container
ShowInAdvancedViewOnly=True
msDs-Behavior-Version=$REGISTRY=InstallForestBehaviorVersion
fSMORoleOwner=$REGISTRY=Machine DN Name
;             FLAG_DISALLOW_DELETE
systemFlags=0x80000000

CHILD=Enterprise Configuration
CHILD=$REGISTRY=Netbios Name
CHILD=Enterprise Schema

[Enterprise Configuration]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=crossRef
ObjectCategory=Cross-Ref
nCName=$REGISTRY=Configuration NC
dnsRoot=$REGISTRY=DNS Root
systemFlags=1
ShowInAdvancedViewOnly=True

[$REGISTRY=Netbios Name]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=crossRef
ObjectCategory=Cross-Ref
nCName=$REGISTRY=Root Domain
nETBIOSName=$REGISTRY=Netbios Name
dnsRoot=$REGISTRY=DNS Root
systemFlags=3
ShowInAdvancedViewOnly=True

[Enterprise Schema]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=crossRef
ObjectCategory=Cross-Ref
nCName=$REGISTRY=Schema DN Name
dnsRoot=$REGISTRY=DNS Root
systemFlags=1
ShowInAdvancedViewOnly=True

;--------------------------------------------------------
; Services subtree under the default configuration container
;--------------------------------------------------------

[Services]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True
;             FLAG_DISALLOW_DELETE
systemFlags=0x80000000

CHILD=Windows NT
CHILD=NetServices
CHILD=RRAS
CHILD=MsmqServices
CHILD=Public Key Services

;--------------------------------------------------------
;         Windows NT subtree under the Services subtree
;--------------------------------------------------------
[Windows NT]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True

CHILD=Directory Service

[Directory Service]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)S:(OU;SA;WP;f0f8ff86-1191-11d0-a060-00aa006c33ed;;WD)
objectClass=nTDSService
ObjectCategory=NTDS-Service
sPNMappings=host=alerter,appmgmt,cisvc,clipsrv,browser,dhcp,dnscache,replicator,eventlog,eventsystem,policyagent,oakley,dmserver,dns,mcsvc,fax,msiserver,ias,messenger,netlogon,netman,netdde,netddedsm,nmagent,plugplay,protectedstorage,rasman,rpclocator,rpc,rpcss,remoteaccess,rsvp,samss,scardsvr,scesrv,seclogon,scm,dcom,cifs,spooler,snmp,schedule,tapisrv,trksvr,trkwks,ups,time,wins,www,http,w3svc,iisadmin,msdtc
ShowInAdvancedViewOnly=True
msDS-Other-Settings=DynamicObjectDefaultTTL=86400
msDS-Other-Settings=DynamicObjectMinTTL=900
msDS-Other-Settings=DisableVLVSupport=0
; Explict TSL default set in W2K3 SP1 to increase shelf-life of backups and allow longer
; disconnection times.
tombstoneLifetime=180

CHILD=Query-Policies

[Query-Policies]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True

CHILD=Default Query Policy

[Default Query Policy]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)S:(OU;SA;WP;7359a352-90f7-11d1-aebc-0000f80367c1;;WD)
objectClass=queryPolicy
ObjectCategory=Query-Policy

ShowInAdvancedViewOnly=True

lDAPAdminLimits=MaxConnections=5000
lDAPAdminLimits=InitRecvTimeout=120
lDAPAdminLimits=MaxConnIdleTime=900
lDAPAdminLimits=MaxActiveQueries=20
lDAPAdminLimits=MaxNotificationPerConn=5
lDAPAdminLimits=MaxPageSize=1000
lDAPAdminLimits=MaxQueryDuration=120
lDAPAdminLimits=MaxTempTableSize=10000
lDAPAdminLimits=MaxResultSetSize=262144
lDAPAdminLimits=MaxPoolThreads=4
lDAPAdminLimits=MaxDatagramRecv=4096
lDAPAdminLimits=MaxReceiveBuffer=10485760
lDAPAdminLimits=MaxValRange=1500


[NetServices]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True


;--------------------------------------------------------
;         RRAS subtree under the Services subtree
;--------------------------------------------------------
[RRAS]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True

CHILD=IdentityDictionary

[IdentityDictionary]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=rRASAdministrationDictionary
ObjectCategory=RRAS-Administration-Dictionary
ShowInAdvancedViewOnly=True

msRRASVendorAttributeEntry=311:0:8:RIP (version 1 or 2)
msRRASVendorAttributeEntry=311:0:13:OSPF
msRRASVendorAttributeEntry=311:1:10:IGMP Only
msRRASVendorAttributeEntry=311::5:1:IPX RIP
msRRASVendorAttributeEntry=311:5:2:IPX SAP
msRRASVendorAttributeEntry=311:6:501:IP Forwarding Enabled
msRRASVendorAttributeEntry=311:6:502:IPX Forwarding Enabled
msRRASVendorAttributeEntry=311:6:503:AppleTalk Forwarding Enabled
msRRASVendorAttributeEntry=311:6:601:LAN-to- LAN Router
msRRASVendorAttributeEntry=311:6:602:Remote Access Server
msRRASVendorAttributeEntry=311:6:603:Demand Dial Router
msRRASVendorAttributeEntry=311:6:604:Network Address and Port Translation
msRRASVendorAttributeEntry=311:6:701:Point-to-Point Tunneling Protocol
msRRASVendorAttributeEntry=311:6:702:Layer 2 Tunneling Protocol
msRRASVendorAttributeEntry=311:6:703:Frame Relay
msRRASVendorAttributeEntry=311:6:704:ATM
msRRASVendorAttributeEntry=311:6:705:ISDN
msRRASVendorAttributeEntry=311:6:706:Modem
msRRASVendorAttributeEntry=311:6:707:SONET
msRRASVendorAttributeEntry=311:6:708:Switched 56
msRRASVendorAttributeEntry=311:6:709:IrDA
msRRASVendorAttributeEntry=311:6:710:X.25
msRRASVendorAttributeEntry=311:6:711:Generic WAN
msRRASVendorAttributeEntry=311:6:712:Generic LAN
msRRASVendorAttributeEntry=311:6:713:Point to point serial connection
msRRASVendorAttributeEntry=311:6:714:Point to point parallel connection
msRRASVendorAttributeEntry=311:6:801:NT Domain Authentication
msRRASVendorAttributeEntry=311:6:802:RADIUS Authentication
msRRASVendorAttributeEntry=311:6:803:RADIUS Accouting


;-------------------------------------------------
; MsmqServices subtree under the services subtree
;-------------------------------------------------

[MsmqServices]
objectClass=mSMQEnterpriseSettings
objectCategory=MSMQ-Enterprise-Settings
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
mSMQVersion=200
ShowInAdvancedViewOnly=True

;-------------------------------------------------
; Public Key Services subtree under the services subtree
;-------------------------------------------------

[Public Key Services]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True

CHILD=Certificate Templates
CHILD=Enrollment Services
CHILD=Certification Authorities
CHILD=AIA
CHILD=CDP 
CHILD=KRA 
CHILD=OID 

[Certificate Templates]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True

[Enrollment Services]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True

[Certification Authorities]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True

[AIA]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;CA)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True

[CDP]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True

[KRA]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
ShowInAdvancedViewOnly=True

[OID]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=msPKI-Enterprise-Oid
ObjectCategory=ms-PKI-Enterprise-Oid
ShowInAdvancedViewOnly=True


;--------------------------------------------------------
; Extended Rights subtree under the default configuration container
;--------------------------------------------------------

[Extended-Rights]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = Container
ObjectCategory = Container
cn = Extended-Rights
ShowInAdvancedViewOnly=True
;             FLAG_DISALLOW_DELETE
systemFlags=0x80000000

CHILD=Domain-Administer-Server
CHILD=User-Change-Password
CHILD=User-Force-Change-Password
CHILD=Send-As
CHILD=Receive-As
CHILD=Send-To
CHILD=Domain-Password
CHILD=General-Information
CHILD=User-Account-Restrictions
CHILD=User-Logon
CHILD=Membership
CHILD=Open-Address-Book
CHILD=Personal-Information
CHILD=Email-Information
CHILD=Web-Information
CHILD=DS-Replication-Get-Changes
CHILD=DS-Replication-Synchronize
CHILD=DS-Replication-Manage-Topology
CHILD=Change-Schema-Master
CHILD=Change-Rid-Master
CHILD=Do-Garbage-Collection
CHILD=Recalculate-Hierarchy
CHILD=Allocate-Rids
CHILD=Change-PDC
CHILD=Add-GUID
CHILD=Change-Domain-Master
CHILD=Public-Information
CHILD=msmq-Receive-Dead-Letter
CHILD=msmq-Peek-Dead-Letter
CHILD=msmq-Receive-computer-Journal
CHILD=msmq-Peek-computer-Journal
CHILD=msmq-Receive
CHILD=msmq-Peek
CHILD=msmq-Send
CHILD=msmq-Receive-journal
CHILD=msmq-Open-Connector
CHILD=Apply-Group-Policy
CHILD=RAS-Information
CHILD=DS-Install-Replica
CHILD=Change-Infrastructure-Master
CHILD=Update-Schema-Cache
CHILD=Recalculate-Security-Inheritance
CHILD=DS-Check-Stale-Phantoms
CHILD=Certificate-Enrollment
CHILD=Self-Membership
CHILD=Validated-DNS-Host-Name
CHILD=Validated-SPN
CHILD=Generate-RSoP-Planning
CHILD=Refresh-Group-Cache
CHILD=SAM-Enumerate-Entire-Domain
CHILD=Generate-RSoP-Logging
CHILD=Domain-Other-Parameters
CHILD=DNS-Host-Name-Attributes
CHILD=Create-Inbound-Forest-Trust
CHILD=DS-Replication-Get-Changes-All
CHILD=Migrate-SID-History
CHILD=Reanimate-Tombstones
CHILD=Allowed-To-Authenticate
CHILD=DS-Execute-Intentions-Script
CHILD=DS-Replication-Monitor-Topology
CHILD=Update-Password-Not-Required-Bit
CHILD=Unexpire-Password
CHILD=Enable-Per-User-Reversibly-Encrypted-Password
CHILD=DS-Query-Self-Quota

[Domain-Administer-Server]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aad-0de6-11d0-a285-00aa003049e2
displayName=Domain Administer Server
localizationDisplayId=1
rightsGUID=ab721a52-1e2f-11d0-9819-00aa0040529b
validAccesses=0x100

[User-Change-Password]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Change Password
localizationDisplayId=2
rightsGUID=ab721a53-1e2f-11d0-9819-00aa0040529b
validAccesses=0x100

[User-Force-Change-Password]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Reset Password
localizationDisplayId=3
rightsGUID=00299570-246d-11d0-a768-00aa006e0529
validAccesses=0x100


[Send-As]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Send As
localizationDisplayId=4
rightsGUID=ab721a54-1e2f-11d0-9819-00aa0040529b
validAccesses=0x100

[Receive-As]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Receive As
localizationDisplayId=5
rightsGUID=ab721a56-1e2f-11d0-9819-00aa0040529b
validAccesses=0x100

[Send-To]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967a9c-0de6-11d0-a285-00aa003049e2
displayName=Send To
localizationDisplayId=6
rightsGUID=ab721a55-1e2f-11d0-9819-00aa0040529b
validAccesses=0x100

[Domain-Password]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5a-6da0-11d0-afd3-00c04fd930c9
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Domain Password & Lockout Policies
localizationDisplayId=7
rightsGUID=c7407360-20bf-11d0-a768-00aa006e0529
validAccesses=0x30

[General-Information]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=General Information
localizationDisplayId=8
rightsGUID=59ba2f42-79a2-11d0-9020-00c04fc2d3cf
validAccesses=0x30

[User-Account-Restrictions]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Account Restrictions
localizationDisplayId=9
rightsGUID=4c164200-20c0-11d0-a768-00aa006e0529
validAccesses=0x30

[User-Logon]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Logon Information
localizationDisplayId=10
rightsGUID=5f202010-79a5-11d0-9020-00c04fc2d4cf
validAccesses=0x30

[Membership]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Group Membership
localizationDisplayId=11
rightsGUID=bc0ac240-79a9-11d0-9020-00c04fc2d4cf
validAccesses=0x30

[Open-Address-Book]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=3e74f60f-3e73-11d1-a9c0-0000f80367c1
displayName=Open Address List
localizationDisplayId=21
rightsGUID=a1990816-4298-11d1-ade2-00c04fd8d5cd
validAccesses=0x100

[Email-Information]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a9c-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Phone and Mail Options
localizationDisplayId=22
rightsGUID=E45795B2-9455-11d1-AEBD-0000F80367C1
validAccesses=0x30

[Personal-Information]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=5cb41ed0-0e4c-11d0-a286-00aa003049e2
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Personal Information
localizationDisplayId=23
rightsGUID=77B5B886-944A-11d1-AEBD-0000F80367C1
validAccesses=0x30

[Web-Information]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=5cb41ed0-0e4c-11d0-a286-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Web Information
localizationDisplayId=24
rightsGUID=E45795B3-9455-11d1-AEBD-0000F80367C1
validAccesses=0x30

[DS-Replication-Get-Changes]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
appliesTo=bf967a87-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a8f-0de6-11d0-a285-00aa003049e2
displayName=Replicating Directory Changes
localizationDisplayId=25
rightsGUID=1131f6aa-9c07-11d1-f79f-00c04fc2dcd2
validAccesses=0x100

[DS-Replication-Synchronize]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
appliesTo=bf967a87-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a8f-0de6-11d0-a285-00aa003049e2
displayName=Replication Synchronization
localizationDisplayId=26
rightsGUID=1131f6ab-9c07-11d1-f79f-00c04fc2dcd2
validAccesses=0x100

[DS-Replication-Manage-Topology]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
appliesTo=bf967a87-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a8f-0de6-11d0-a285-00aa003049e2
displayName=Manage Replication Topology
localizationDisplayId=27
rightsGUID=1131f6ac-9c07-11d1-f79f-00c04fc2dcd2
validAccesses=0x100

[Change-Schema-Master]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967a8f-0de6-11d0-a285-00aa003049e2
displayName=Change Schema Master
localizationDisplayId=28
rightsGUID=e12b56b6-0a95-11d1-adbb-00c04fd8d5cd
validAccesses=0x100

[Change-Rid-Master]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=6617188d-8f3c-11d0-afda-00c04fd930c9
displayName=Change Rid Master
localizationDisplayId=29
rightsGUID=d58d5f36-0a98-11d1-adbb-00c04fd8d5cd
validAccesses=0x100

[Do-Garbage-Collection]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=f0f8ffab-1191-11d0-a060-00aa006c33ed
displayName=Do Garbage Collection
localizationDisplayId=31
rightsGUID=fec364e0-0a98-11d1-adbb-00c04fd8d5cd
validAccesses=0x100

[Recalculate-Hierarchy]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=f0f8ffab-1191-11d0-a060-00aa006c33ed
displayName=Recalculate Hierarchy
localizationDisplayId=32
rightsGUID=0bc1554e-0a99-11d1-adbb-00c04fd8d5cd
validAccesses=0x100

[Allocate-Rids]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=f0f8ffab-1191-11d0-a060-00aa006c33ed
displayName=Allocate Rids
localizationDisplayId=33
rightsGUID=1abd7cf8-0a99-11d1-adbb-00c04fd8d5cd
validAccesses=0x100

[Change-PDC]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Change PDC
localizationDisplayId=34
rightsGUID=bae50096-4752-11d1-9052-00c04fc2d4cf
validAccesses=0x100

[Add-GUID]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Add GUID
localizationDisplayId=35
rightsGUID=440820ad-65b4-11d1-a3da-0000f875ae0d
validAccesses=0x100

[Change-Domain-Master]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=ef9e60e0-56f7-11d1-a9c6-0000f80367c1
displayName=Change Domain Master
localizationDisplayId=36
rightsGUID=014bf69c-7b3b-11d1-85f6-08002be74fab
validAccesses=0x100

[Public-Information]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
displayName=Public Information
localizationDisplayId=37
rightsGUID=e48d0154-bcf8-11d1-8702-00c04fb96050
validAccesses=0x30

[msmq-Receive-Dead-Letter]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
localizationDisplayId=38
rightsGUID=4b6e08c0-df3c-11d1-9c86-006008764d0e
displayName=Receive Dead Letter
appliesTo=9a0dc344-c100-11d1-bbc5-0080c76670c0
validAccesses=0x100

[msmq-Peek-Dead-Letter]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
rightsGUID=4b6e08c1-df3c-11d1-9c86-006008764d0e
displayName=Peek Dead Letter
localizationDisplayId=39
appliesTo=9a0dc344-c100-11d1-bbc5-0080c76670c0
validAccesses=0x100

[msmq-Receive-computer-Journal]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
rightsGUID=4b6e08c2-df3c-11d1-9c86-006008764d0e
displayName=Receive Computer Journal
localizationDisplayId=40
appliesTo=9a0dc344-c100-11d1-bbc5-0080c76670c0
validAccesses=0x100

[msmq-Peek-computer-Journal]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
rightsGUID=4b6e08c3-df3c-11d1-9c86-006008764d0e
displayName=Peek Computer Journal
localizationDisplayId=41
appliesTo=9a0dc344-c100-11d1-bbc5-0080c76670c0
validAccesses=0x100

[msmq-Receive]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
rightsGUID=06bd3200-df3e-11d1-9c86-006008764d0e
displayName=Receive Message
localizationDisplayId=42
appliesTo=9a0dc343-c100-11d1-bbc5-0080c76670c0
validAccesses=0x100

[msmq-Peek]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
rightsGUID=06bd3201-df3e-11d1-9c86-006008764d0e
displayName=Peek Message
localizationDisplayId=43
appliesTo=9a0dc343-c100-11d1-bbc5-0080c76670c0
validAccesses=0x100

[msmq-Send]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
rightsGUID=06bd3202-df3e-11d1-9c86-006008764d0e
displayName=Send Message
localizationDisplayId=44
appliesTo=9a0dc343-c100-11d1-bbc5-0080c76670c0
appliesTo=46b27aac-aafa-4ffb-b773-e5bf621ee87b
validAccesses=0x100

[msmq-Receive-journal]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
rightsGUID=06bd3203-df3e-11d1-9c86-006008764d0e
displayName=Receive Journal
localizationDisplayId=45
appliesTo=9a0dc343-c100-11d1-bbc5-0080c76670c0
validAccesses=0x100

[msmq-Open-Connector]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
rightsGUID=b4e60130-df3f-11d1-9c86-006008764d0e
displayName=Open Connector Queue
localizationDisplayId=46
appliesTo=bf967ab3-0de6-11d0-a285-00aa003049e2
validAccesses=0x100

[Apply-Group-Policy]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
rightsGUID=edacfd8f-ffb3-11d1-b41d-00a0c968f939
displayName=Apply Group Policy
localizationDisplayId=47
appliesTo=f30e3bc2-9ff0-11d1-b603-0000f80367c1
validAccesses=0x100

[RAS-Information]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
objectCategory = Control-Access-Right
showInAdvancedViewOnly=True
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=4828CC14-1437-45bc-9B07-AD6F015E5F28
localizationDisplayId=48
displayName=Remote Access Information
rightsGUID=037088f8-0ae1-11d2-b422-00a0c968f939
validAccesses=0x30

[DS-Install-Replica]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Add/Remove Replica In Domain
localizationDisplayId=49
rightsGUID=9923a32a-3607-11d2-b9be-0000f87a36b2
validAccesses=0x100

[Change-Infrastructure-Master]                                                     
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight                         
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=2df90d89-009f-11d2-aa4c-00c04fd7d83a
displayName=Change Infrastructure Master
localizationDisplayId=50
rightsGUID=cc17b1fb-33d9-11d2-97d4-00c04fd8d5cd
validAccesses=0x100

[Update-Schema-Cache]                                                     
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight                         
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967a8f-0de6-11d0-a285-00aa003049e2
displayName=Update Schema Cache
localizationDisplayId=51
rightsGUID=be2bb760-7f46-11d2-b9ad-00c04f79f805
validAccesses=0x100

[Recalculate-Security-Inheritance]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ValidAccesses=0x100
ShowInAdvancedViewOnly=True
appliesTo=f0f8ffab-1191-11d0-a060-00aa006c33ed
displayName=Recalculate Security Inheritance
localizationDisplayId=52
rightsGUID=62dd28a8-7f46-11d2-b9ad-00c04f79f805

[DS-Check-Stale-Phantoms]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ValidAccesses=0x100
ShowInAdvancedViewOnly=True
appliesTo=f0f8ffab-1191-11d0-a060-00aa006c33ed
displayName=Check Stale Phantoms
localizationDisplayId=53
rightsGUID=69ae6200-7f46-11d2-b9ad-00c04f79f805

[Certificate-Enrollment]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ValidAccesses=0x100
ShowInAdvancedViewOnly=True
displayname=Enroll
appliesTo=e5209ca2-3bba-11d2-90cc-00c04fd91ab1
localizationDisplayId=54
rightsGuid=0e10c968-78fb-11d2-90d4-00c04f79dc55

[Self-Membership]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967a9c-0de6-11d0-a285-00aa003049e2
displayName=Add/Remove self as member
localizationDisplayId=12
rightsGUID=bf9679c0-0de6-11d0-a285-00aa003049e2
validAccesses=0x8

[Validated-DNS-Host-Name]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
displayName=Validated write to DNS host name
localizationDisplayId=13
rightsGUID=72e39547-7b18-11d1-adef-00c04fd8d5cd
validAccesses=0x8

[Validated-SPN]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
displayName=Validated write to service principal name
localizationDisplayId=14
rightsGUID=f3a64788-5306-11d1-a9c5-0000f80367c1
validAccesses=0x8

[Generate-RSoP-Planning]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aa5-0de6-11d0-a285-00aa003049e2
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Generate Resultant Set of Policy (Planning)
localizationDisplayId=55
rightsGUID=b7b1b3dd-ab09-4242-9e30-9980e5d322f7
validAccesses=0x100

[Refresh-Group-Cache]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=f0f8ffab-1191-11d0-a060-00aa006c33ed
displayName=Refresh Group Cache for Logons
localizationDisplayId=56
rightsGUID=9432c620-033c-4db7-8b58-14ef6d0bf477
validAccesses=0x100

[SAM-Enumerate-Entire-Domain]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967aad-0de6-11d0-a285-00aa003049e2
displayName=Enumerate Entire SAM Domain
localizationDisplayId=57
rightsGUID=91d67418-0135-4acc-8d79-c08e857cfbec
validAccesses=0x100

[Generate-RSoP-Logging]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
rightsGUID=b7b1b3de-ab09-4242-9e30-9980e5d322f7
displayName=Generate Resultant Set of Policy (Logging)
localizationDisplayId=58
appliesTo=bf967aa5-0de6-11d0-a285-00aa003049e2
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
validAccesses=0x100

[Domain-Other-Parameters]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Other Domain Parameters (for use by SAM)
localizationDisplayId=59
rightsGUID=b8119fd0-04f6-4762-ab7a-4986c76b3f9a
validAccesses=0x30

[DNS-Host-Name-Attributes]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
displayName=DNS Host Name Attributes
localizationDisplayId=60
rightsGUID=72e39547-7b18-11d1-adef-00c04fd8d5cd
validAccesses=0x30

[Create-Inbound-Forest-Trust]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Create Inbound Forest Trust
localizationDisplayId=61
rightsGUID=e2a36dc9-ae17-47c3-b58b-be34c55ba633
validAccesses=0x100

[DS-Replication-Get-Changes-All]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
appliesTo=bf967a87-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a8f-0de6-11d0-a285-00aa003049e2
displayName=Replicating Directory Changes All
localizationDisplayId=62
rightsGUID=1131f6ad-9c07-11d1-f79f-00c04fc2dcd2
validAccesses=0x100

[Migrate-SID-History]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Migrate SID History
localizationDisplayId=63
rightsGUID=BA33815A-4F93-4c76-87F3-57574BFF8109
validAccesses=0x100

[Reanimate-Tombstones]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
appliesTo=bf967a87-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a8f-0de6-11d0-a285-00aa003049e2
displayName=Reanimate Tombstones
localizationDisplayId=64
rightsGUID=45EC5156-DB7E-47bb-B53F-DBEB2D03C40F
validAccesses=0x100

[Allowed-To-Authenticate]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=bf967a86-0de6-11d0-a285-00aa003049e2
appliesTo=bf967aba-0de6-11d0-a285-00aa003049e2
appliesTo=4828cc14-1437-45bc-9b07-ad6f015e5f28
displayName=Allowed to Authenticate
localizationDisplayId=65
rightsGUID=68B1D179-0D15-4d4f-AB71-46152E79A7BC
validAccesses=0x100

[DS-Execute-Intentions-Script]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = controlAccessRight
ObjectCategory = Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=ef9e60e0-56f7-11d1-a9c6-0000f80367c1
displayName=Execute Forest Update Script
localizationDisplayId=66
rightsGUID=2f16c4a5-b98e-432c-952a-cb388ba33f2e
validAccesses=0x100

[DS-Replication-Monitor-Topology]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=controlAccessRight
ObjectCategory=Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
appliesTo=bf967a87-0de6-11d0-a285-00aa003049e2
appliesTo=bf967a8f-0de6-11d0-a285-00aa003049e2
displayName=Monitor Active Directory Replication
localizationDisplayId=67
rightsGUID=f98340fb-7c5b-4cdb-a00b-2ebdfa115a96
validAccesses=0x100

[Update-Password-Not-Required-Bit]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=controlAccessRight
ObjectCategory=Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Update Password Not Required Bit
localizationDisplayId=68
rightsGUID=280f369c-67c7-438e-ae98-1d46f3c6f541
validAccesses=0x100

[Unexpire-Password]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=controlAccessRight
ObjectCategory=Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Unexpire Password
localizationDisplayId=69
rightsGUID=ccc2dc7d-a6ad-4a7a-8846-c04e3cc53501
validAccesses=0x100

[Enable-Per-User-Reversibly-Encrypted-Password]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=controlAccessRight
ObjectCategory=Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=19195a5b-6da0-11d0-afd3-00c04fd930c9
displayName=Enable Per User Reversibly Encrypted Password
localizationDisplayId=70
rightsGUID=05c74c5e-4deb-43b4-bd9f-86664c2a7fd5
validAccesses=0x100

[DS-Query-Self-Quota]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=controlAccessRight
ObjectCategory=Control-Access-Right
ShowInAdvancedViewOnly=True
appliesTo=da83fc4f-076f-4aea-b4dc-8f4dab9b5993
displayName=Query Self Quota
localizationDisplayId=71
rightsGUID=4ecc03fe-ffc0-4947-b630-eb672a8a9dbc
validAccesses=0x100


;--------------------------------------------------------
; Display Specifiers subtree under the default configuration container
; Make sure all objects under this container has a "cn=" line
; localization scripts that parses the schema.ini to create display-specs
; for other languages require this
;--------------------------------------------------------
[DisplaySpecifiers]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = Container
ObjectCategory = Container
cn = DisplaySpecifiers
ShowInAdvancedViewOnly=True
objectVersion = 1

;             FLAG_DISALLOW_DELETE
systemFlags=0x80000000

CHILD =409

[409]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = Container
ObjectCategory = Container
cn = 409
ShowInAdvancedViewOnly=True

CHILD=DS-UI-Default-Settings

CHILD=IntellimirrorGroup-Display
CHILD=IntellimirrorSCP-Display
CHILD=user-Display
CHILD=group-Display
CHILD=domainDNS-Display
CHILD=contact-Display
CHILD=domainPolicy-Display
CHILD=localPolicy-Display
CHILD=volume-Display
CHILD=serviceAdministrationPoint-Display
CHILD=computer-Display
CHILD=printQueue-Display
CHILD=site-Display
CHILD=server-Display
CHILD=nTDSSettings-Display
CHILD=nTFRSSettings-Display
CHILD=nTFRSReplicaSet-Display
CHILD=nTDSDSA-Display
CHILD=nTDSConnection-Display
CHILD=subnet-Display
CHILD=organizationalUnit-Display
CHILD=container-Display
CHILD=trustedDomain-Display
CHILD=default-Display
CHILD=siteLink-Display
CHILD=siteLinkBridge-Display
CHILD=interSiteTransport-Display
CHILD=licensingSiteSettings-Display
CHILD=nTDSSiteSettings-Display
CHILD=nTFRSMember-Display
CHILD=nTFRSSubscriber-Display
CHILD=nTFRSSubscriptions-Display
CHILD=rpcContainer-Display
CHILD=mSMQQueue-Display
CHILD=mSMQConfiguration-Display
CHILD=mSMQEnterpriseSettings-Display
CHILD=mSMQMigratedUser-Display
CHILD=mSMQSiteLink-Display
CHILD=mSMQSettings-Display
CHILD=msMQ-Custom-Recipient-Display
CHILD=msMQ-Group-Display
CHILD=remoteStorageServicePoint-Display
CHILD=sitesContainer-Display
CHILD=interSiteTransportContainer-Display
CHILD=subnetContainer-Display
CHILD=serversContainer-Display
CHILD=nTDSService-Display
CHILD=queryPolicy-Display
CHILD=foreignSecurityPrincipal-Display
CHILD=pKICertificateTemplate-Display
CHILD=msCOM-PartitionSet-Display
CHILD=msCOM-Partition-Display
CHILD=lostAndFound-Display
CHILD=inetOrgPerson-Display

[DS-UI-Default-Settings]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = dSUISettings
objectCategory = DS-UI-Settings
cn = DS-UI-Default-Settings
dSUIAdminNotification = 1,{E62F8206-B71C-11D1-808D-00A024C48131}
dSUIAdminNotification = 2,{a00e1768-4a9b-4d97-afc6-99d329f605f2}
ShowInAdvancedViewOnly=True
msDS-FilterContainers = Organizational-Unit
msDS-FilterContainers = Builtin-Domain
msDS-FilterContainers = Lost-And-Found
msDS-FilterContainers = Container
msDS-FilterContainers = dns-Zone
msDS-Non-Security-Group-Extra-Classes = MSMQ-Queue
msDS-Non-Security-Group-Extra-Classes = MSMQ-Custom-Recipient

[IntellimirrorGroup-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
adminPropertyPages = 1,{C641CF88-892F-11d1-BBEB-0060081692B3}
cn = IntellimirrorGroup-Display
classDisplayName = IntelliMirror Group
ShowInAdvancedViewOnly=True
shellPropertyPages = 1,{C641CF88-892F-11d1-BBEB-0060081692B3}

[IntellimirrorSCP-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
adminPropertyPages = 1,{AC409538-741C-11d1-BBE6-0060081692B3}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4e40f770-369c-11d0-8922-00a024ab2dbb}
cn = IntellimirrorSCP-Display
classDisplayName = IntelliMirror Service
ShowInAdvancedViewOnly=True
shellPropertyPages = 1,{AC409538-741C-11d1-BBE6-0060081692B3}

[user-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = user-Display
adminMultiselectPropertyPages = 1,{50d30564-9911-11d1-b9af-00c04fd8d5b0}
adminPropertyPages = 1,{6dfe6485-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{B52C1E50-1DD2-11D1-BC43-00C04FC31FD3}
adminPropertyPages = 4,{FD57D295-4FD9-11D1-854E-00C04FC31FD3}
adminPropertyPages = 5,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 6,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminPropertyPages = 7,{8c5b1b50-d46e-11d1-8091-00a024c48131}
adminPropertyPages = 8,{0910dd01-df8c-11d1-ae27-00c04fa35813}
adminPropertyPages = 9,{FA3E1D55-16DF-446d-872E-BD04D4F39C93}
shellPropertyPages = 1,{f5d121ed-c8ac-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = User
attributeDisplayNames = assistant,Assistant
attributeDisplayNames = cn,Name
attributeDisplayNames = c,Country Abbreviation
attributeDisplayNames = co,Country
attributeDisplayNames = comment,Comment
attributeDisplayNames = company,Company
attributeDisplayNames = department,Department
attributeDisplayNames = description,Description
attributeDisplayNames = directReports,Direct Reports
attributeDisplayNames = distinguishedName,X500 Distinguished Name
attributeDisplayNames = division,Division
attributeDisplayNames = employeeID,Employee ID
attributeDisplayNames = facsimileTelephoneNumber,Fax Number
attributeDisplayNames = generationQualifier,Generational Suffix
attributeDisplayNames = givenName,First Name
attributeDisplayNames = homeDirectory,Home Folder
attributeDisplayNames = homeDrive,Home Drive
attributeDisplayNames = homePhone,Home Phone
attributeDisplayNames = homePostalAddress,Home Address
attributeDisplayNames = initials,Initials
attributeDisplayNames = internationalISDNNumber,International ISDN Number (Others)
attributeDisplayNames = ipPhone,IP Phone Number
attributeDisplayNames = l,City
attributeDisplayNames = mail,E-Mail Address
attributeDisplayNames = manager,Manager
attributeDisplayNames = memberOf,Member Of
attributeDisplayNames = middleName,Middle Name
attributeDisplayNames = mobile,Mobile Number
attributeDisplayNames = info,Notes
attributeDisplayNames = otherFacsimileTelephoneNumber,Fax Number (Others)
attributeDisplayNames = otherHomePhone,Home Phone Number (Others)
attributeDisplayNames = otherIpPhone,IP Phone Number (Others)
attributeDisplayNames = otherMailbox,E-Mail Address (Others)
attributeDisplayNames = otherMobile,Mobile Number (Others)
attributeDisplayNames = otherPager,Pager Number (Others)
attributeDisplayNames = otherTelephone,Phone Number (Others)
attributeDisplayNames = pager,Pager Number
attributeDisplayNames = personalTitle,Title
attributeDisplayNames = physicalDeliveryOfficeName,Office Location
attributeDisplayNames = postalCode,ZIP/Postal Code
attributeDisplayNames = postOfficeBox,Post Office Box
attributeDisplayNames = primaryInternationalISDNNumber,International ISDN Number
attributeDisplayNames = primaryTelexNumber,Telex Number
attributeDisplayNames = samAccountName,Logon Name (pre-Windows 2000)
attributeDisplayNames = sn,Last Name
attributeDisplayNames = st,State/Province
attributeDisplayNames = streetAddress,Street Address
attributeDisplayNames = telephoneNumber,Telephone Number
attributeDisplayNames = telexNumber,Telex Number (Others)
attributeDisplayNames = title,Job Title
attributeDisplayNames = url,Web Page Address (Others)
attributeDisplayNames = displayName,Display Name
attributeDisplayNames = userWorkstations,Logon Workstations
attributeDisplayNames = userPrincipalName,Logon Name
attributeDisplayNames = wWWHomePage,Web Page Address
treatAsLeaf=True
ShowInAdvancedViewOnly=True

[group-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = group-Display
adminPropertyPages = 1,{6dfe6489-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe648b-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 4,{4E40F770-369C-11d0-8922-00A024AB2DBB}
shellPropertyPages = 1,{f5d121ee-c8ac-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Group
attributeDisplayNames = cn,Name
attributeDisplayNames = c,Country Abbreviation
attributeDisplayNames = description,Description
attributeDisplayNames = distinguishedName,X500 Distinguished Name
attributeDisplayNames = l,City
attributeDisplayNames = managedBy,Managed By
attributeDisplayNames = member,Members
attributeDisplayNames = info,Notes
attributeDisplayNames = physicalDeliveryOfficeName,Office Location
attributeDisplayNames = samAccountName,Group name (pre-Windows 2000)
attributeDisplayNames = url,Web Page Address (Others)
attributeDisplayNames = wWWHomePage,Web Page Address
treatAsLeaf=True
ShowInAdvancedViewOnly=True

[domainDNS-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = domainDNS-Display
adminPropertyPages = 1,{6dfe648c-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{6dfe648b-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 4,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 5,{4E40F770-369C-11d0-8922-00A024AB2DBB}
shellPropertyPages = 1,{f5d121ef-c8ac-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
adminContextMenu = 1,{6BA3F852-23C6-11D1-B91F-00A0C9A06D2D}
adminContextMenu = 2,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Domain
attributeDisplayNames = dc,Name
attributeDisplayNames = description,Description
ShowInAdvancedViewOnly=True

[contact-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = contact-Display
adminPropertyPages = 1,{c5f1645c-c8c9-11d0-bcdb-00c04fd8d5b6}
adminPropertyPages = 3,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 4,{4E40F770-369C-11d0-8922-00A024AB2DBB}
shellPropertyPages = 1,{f5d121f0-c8ac-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Contact
attributeDisplayNames = assistant,Assistant
attributeDisplayNames = c,Country Abbreviation
attributeDisplayNames = co,Country
attributeDisplayNames = cn,Name
attributeDisplayNames = comment,Comment
attributeDisplayNames = company,Company
attributeDisplayNames = department,Department
attributeDisplayNames = description,Description
attributeDisplayNames = directReports,Direct Reports
attributeDisplayNames = displayName,Display Name
attributeDisplayNames = distinguishedName,X500 Distinguished Name
attributeDisplayNames = division,Division
attributeDisplayNames = employeeID,Employee ID
attributeDisplayNames = facsimileTelephoneNumber,Fax Number
attributeDisplayNames = generationQualifier,Generational Suffix
attributeDisplayNames = givenName,First Name
attributeDisplayNames = homePhone,Home Phone
attributeDisplayNames = homePostalAddress,Home Address
attributeDisplayNames = initials,Initials
attributeDisplayNames = info,Notes
attributeDisplayNames = internationalISDNNumber,International ISDN Number (Others)
attributeDisplayNames = ipPhone,IP Phone Number
attributeDisplayNames = l,City
attributeDisplayNames = mail,E-Mail Address
attributeDisplayNames = manager,Manager
attributeDisplayNames = memberOf,Member Of
attributeDisplayNames = middleName,Middle Name
attributeDisplayNames = mobile,Mobile Number
attributeDisplayNames = otherFacsimileTelephoneNumber,Fax Number (Others)
attributeDisplayNames = otherHomePhone,Home Phone Number (Others)
attributeDisplayNames = otherIpPhone,IP Phone Number (Others)
attributeDisplayNames = otherMailbox,E-Mail Address (Others)
attributeDisplayNames = otherMobile,Mobile Number (Others)
attributeDisplayNames = otherPager,Pager Number (Others)
attributeDisplayNames = otherTelephone,Phone Number (Others)
attributeDisplayNames = pager,Pager Number
attributeDisplayNames = personalTitle,Title
attributeDisplayNames = physicalDeliveryOfficeName,Office Location
attributeDisplayNames = postalCode,ZIP/Postal Code
attributeDisplayNames = postOfficeBox,Post Office Box
attributeDisplayNames = primaryInternationalISDNNumber,International ISDN Number
attributeDisplayNames = primaryTelexNumber,Telex Number
attributeDisplayNames = sn,Last Name
attributeDisplayNames = st,State/Province
attributeDisplayNames = streetAddress,Street Address
attributeDisplayNames = telephoneNumber,Telephone Number
attributeDisplayNames = telexNumber,Telex Number (Others)
attributeDisplayNames = title,Job Title
attributeDisplayNames = url,Web Page Address (Others)
attributeDisplayNames = wWWHomePage,Web Page Address
ShowInAdvancedViewOnly=True

[domainPolicy-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = domainPolicy-Display
adminPropertyPages = 1,{6dfe648e-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 2,{AAD30A04-E1D0-11d0-B859-00A024CDD4DE}
adminPropertyPages = 3,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 4,{4E40F770-369C-11d0-8922-00A024AB2DBB}
shellPropertyPages = 1,{f5d121f1-c8ac-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Domain Policy
ShowInAdvancedViewOnly=True

[localPolicy-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = localPolicy-Display
adminPropertyPages = 1,{6dfe648f-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminPropertyPages = 4,{AAD30A04-E1D0-11d0-B859-00A024CDD4DE}
shellPropertyPages = 1,{f5d121f2-c8ac-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Local Policy
ShowInAdvancedViewOnly=True

[serviceAdministrationPoint-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = serviceAdministrationPoint-Display
adminPropertyPages = 1,{c5f1645d-c8c9-11d0-bcdb-00c04fd8d5b6}
adminPropertyPages = 3,{6dfe648b-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 4,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 5,{4E40F770-369C-11d0-8922-00A024AB2DBB}
shellPropertyPages = 1,{c5f1645e-c8c9-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Service
ShowInAdvancedViewOnly=True

[computer-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = computer-Display
adminPropertyPages = 1,{6dfe6492-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{77597368-7b15-11d0-a0c2-080036af3f03}
adminPropertyPages = 4,{6dfe648b-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 5,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 6,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminPropertyPages = 7,{B52C1E50-1DD2-11D1-BC43-00C04FC31FD3}
adminPropertyPages = 10,{0F65B1BF-740F-11d1-BBE6-0060081692B3}
shellPropertyPages = 1,{f5d121f4-c8ac-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Computer
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
attributeDisplayNames = managedBy,Managed By
attributeDisplayNames = operatingSystem,Operating System
attributeDisplayNames = operatingSystemVersion,Operating System Version
attributeDisplayNames = samAccountName,Computer name (pre-Windows 2000)
createWizardExt = 1,{D6D8C25A-4E83-11d2-8424-00C04FA372D4}
treatAsLeaf=True
ShowInAdvancedViewOnly=True

[printQueue-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = printQueue-Display
adminPropertyPages = 1,{6dfe6493-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
shellPropertyPages = 1,{f5d121f5-c8ac-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Printer
attributeDisplayNames = cn,Directory Service Name
attributeDisplayNames = uNCName,Network Name
attributeDisplayNames = assetNumber,Asset Number
attributeDisplayNames = contactName,Contact
attributeDisplayNames = description,Comment
attributeDisplayNames = driverName,Model
attributeDisplayNames = location,Location
attributeDisplayNames = portName,Port
attributeDisplayNames = printBinNames,Input Trays
attributeDisplayNames = printCollate,Supports Collation
attributeDisplayNames = printColor,Supports Color Printing
attributeDisplayNames = printDuplexSupported,Supports Double-sided Printing
attributeDisplayNames = printerName,Name
attributeDisplayNames = printLanguage,Printer Language
attributeDisplayNames = printMaxResolutionSupported,Maximum Resolution
attributeDisplayNames = printMediaReady,Paper Available
attributeDisplayNames = printMediaSupported,Paper Types Supported
attributeDisplayNames = printMemory,Installed Memory
attributeDisplayNames = printOwner,Owner Name
attributeDisplayNames = printRate,Speed
attributeDisplayNames = printRateUnit,Speed Units
attributeDisplayNames = printPagesPerMinute,Pages per Minute
attributeDisplayNames = printShareName,Share Name
attributeDisplayNames = printStaplingSupported,Supports Stapling
attributeDisplayNames = serverName,Server Name
attributeDisplayNames = url,Web Page Address
attributeDisplayNames = versionNumber,Object Version
ShowInAdvancedViewOnly=True

[site-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = site-Display
adminPropertyPages = 1,{717EF4FA-AC8D-11D0-B945-00C04FD8D5B0}
adminPropertyPages = 2,{77597368-7b15-11d0-a0c2-080036af3f03}
adminPropertyPages = 3,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 4,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminPropertyPages = 5,{bc019ba0-d46d-11d1-8091-00a024c48131}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
adminContextMenu = 2,{6BA3F852-23C6-11D1-B91F-00A0C9A06D2D}
adminContextMenu = 3,{bc019ba0-d46d-11d1-8091-00a024c48131}
classDisplayName = Site
ShowInAdvancedViewOnly=True

[server-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = server-Display
adminPropertyPages = 1,{6dfe6494-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Server
ShowInAdvancedViewOnly=True

[nTDSSettings-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = nTDSSettings-Display
adminPropertyPages = 1,{717EF4FB-AC8D-11D0-B945-00C04FD8D5B0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Settings
ShowInAdvancedViewOnly=True

[nTDSDSA-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = nTDSDSA-Display
adminPropertyPages = 1,{717EF4FC-AC8D-11D0-B945-00C04FD8D5B0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Domain Controller Settings
ShowInAdvancedViewOnly=True

[nTDSConnection-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = nTDSConnection-Display
adminPropertyPages = 1,{717ef4fd-ac8d-11d0-b945-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Connection
ShowInAdvancedViewOnly=True

[nTFRSSettings-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = nTFRSSettings-Display
adminPropertyPages = 1,{9da6fd68-c63b-11d0-b94d-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = FRS Settings
ShowInAdvancedViewOnly=True

[nTFRSReplicaSet-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = nTFRSReplicaSet-Display
adminPropertyPages = 1,{9da6fd69-c63b-11d0-b94d-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = FRS Replica Set
ShowInAdvancedViewOnly=True

[subnet-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = subnet-Display
adminPropertyPages = 1,{9da6fd62-c63b-11d0-b94d-00c04fd8d5b0}
adminPropertyPages = 2,{77597368-7b15-11d0-a0c2-080036af3f03}
adminPropertyPages = 3,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 4,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Subnet
ShowInAdvancedViewOnly=True

[siteLink-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = siteLink-Display
adminPropertyPages = 1,{50d30561-9911-11d1-b9af-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Site Link
ShowInAdvancedViewOnly=True

[siteLinkBridge-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = siteLinkBridge-Display
adminPropertyPages = 1,{50d30562-9911-11d1-b9af-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Site Link Bridge
ShowInAdvancedViewOnly=True

[interSiteTransport-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = interSiteTransport-Display
adminPropertyPages = 1,{6dfe6491-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Inter-Site Transport
ShowInAdvancedViewOnly=True

[licensingSiteSettings-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = licensingSiteSettings-Display
adminPropertyPages = 1,{717ef500-ac8d-11d0-b945-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Licensing Site Settings
ShowInAdvancedViewOnly=True

[nTDSSiteSettings-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = nTDSSiteSettings-Display
adminPropertyPages = 1,{2f280288-bb6d-11d0-b948-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Site Settings
ShowInAdvancedViewOnly=True

[nTFRSMember-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = nTFRSMember-Display
adminPropertyPages = 1,{9da6fd6a-c63b-11d0-b94d-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = FRS Member
ShowInAdvancedViewOnly=True

[nTFRSSubscriber-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = nTFRSSubscriber-Display
adminPropertyPages = 1,{50d3055f-9911-11d1-b9af-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = FRS Subscriber
ShowInAdvancedViewOnly=True

[nTFRSSubscriptions-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = nTFRSSubscriptions-Display
adminPropertyPages = 1,{50d30560-9911-11d1-b9af-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = FRS Subscriptions
ShowInAdvancedViewOnly=True

[organizationalUnit-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = organizationalUnit-Display
adminPropertyPages = 1,{9da6fd63-c63b-11d0-b94d-00c04fd8d5b0}
adminPropertyPages = 3,{6dfe648b-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 4,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 5,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminPropertyPages = 6,{FA3E1D55-16DF-446d-872E-BD04D4F39C93}
shellPropertyPages = 1,{f2c3faae-c8ac-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{6BA3F852-23C6-11D1-B91F-00A0C9A06D2D}
adminContextMenu = 2,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Organizational Unit
attributeDisplayNames = ou,Name
attributeDisplayNames = description,Description
attributeDisplayNames = managedBy,Managed By
ShowInAdvancedViewOnly=True

[container-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = container-Display
adminPropertyPages = 1,{5a96f2d8-736e-11d1-bd0d-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
shellPropertyPages = 1,{f2c3faae-c8ac-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{6BA3F852-23C6-11D1-B91F-00A0C9A06D2D}
adminContextMenu = 2,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
adminContextMenu = 3,{EEBD2F15-87EE-4F93-856F-6AD7E31787B3}
adminContextMenu = 4,{AB790AA1-CDC1-478a-9351-B2E05CFCAD09}
classDisplayName = Container
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
ShowInAdvancedViewOnly=True

[rpcContainer-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = rpcContainer-Display
adminPropertyPages = 1,{50d30572-9911-11d1-b9af-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = RPC Services
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
ShowInAdvancedViewOnly=True

[trustedDomain-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = trustedDomain-Display
adminPropertyPages = 1,{9da6fd67-c63b-11d0-b94d-00c04fd8d5b0}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Trusted Domain
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
ShowInAdvancedViewOnly=True

[volume-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = volume-Display
adminPropertyPages = 1,{6dfe6490-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{6dfe648b-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 4,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 5,{4E40F770-369C-11d0-8922-00A024AB2DBB}
shellPropertyPages = 1,{f5d121f3-c8ac-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Shared Folder
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
attributeDisplayNames = managedBy,Managed By
attributeDisplayNames = keywords,Keywords
attributeDisplayNames = uNCName,Network Path
ShowInAdvancedViewOnly=True

[mSMQQueue-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = mSMQQueue-Display
classDisplayName = MSMQ Queue
adminPropertyPages = 1,{e62f8206-b71c-11d1-808d-00a024c48131}
adminContextMenu = 1,{e62f8206-b71c-11d1-808d-00a024c48131}
creationWizard = {E62F8206-B71C-11D1-808D-00A024C48131}
iconPath=0,mqsnap.dll,-251
treatAsLeaf=1
ShowInAdvancedViewOnly=True

[mSMQConfiguration-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = mSMQConfiguration-Display
classDisplayName =  MSMQ Configuration
adminPropertyPages = 1,{e62f8208-b71c-11d1-808d-00a024c48131}
adminContextMenu = 1,{e62f8208-b71c-11d1-808d-00a024c48131}
iconPath=0,mqsnap.dll,-252
ShowInAdvancedViewOnly=True

[mSMQEnterpriseSettings-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = mSMQEnterpriseSettings-Display
classDisplayName = MSMQ Enterprise
adminPropertyPages = 1,{2E4B37AB-CC8B-11D1-9C85-006008764D0E}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{2E4B37AB-CC8B-11D1-9C85-006008764D0E}
iconPath=0,mqsnap.dll,-253
ShowInAdvancedViewOnly=True

[mSMQMigratedUser-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = mSMQMigratedUser-Display
classDisplayName = MSMQ Upgraded User
adminPropertyPages = 1,{fc5bf656-0b7f-11d3-883f-006094eb6406}  
adminContextMenu = 1,{fc5bf656-0b7f-11d3-883f-006094eb6406}
ShowInAdvancedViewOnly=True

[mSMQSiteLink-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = mSMQSiteLink-Display
classDisplayName = MSMQ Routing Link
adminPropertyPages = 1,{87b31390-d46d-11d1-8091-00a024c48131}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{87b31390-d46d-11d1-8091-00a024c48131}
creationWizard = {87b31390-d46d-11d1-8091-00a024c48131}
iconPath=0,mqsnap.dll,-254
ShowInAdvancedViewOnly=True

[mSMQSettings-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = mSMQSettings-Display
classDisplayName = MSMQ Settings
adminPropertyPages =  1,{d251b000-d46e-11d1-8091-00a024c48131}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{d251b000-d46e-11d1-8091-00a024c48131}
iconPath=0,mqsnap.dll,-255
ShowInAdvancedViewOnly=True

[msMQ-Custom-Recipient-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
adminPropertyPages = 1,{9e4ab987-3cca-4de0-ae36-3d163df44d36}
adminPropertyPages = 2,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{9e4ab987-3cca-4de0-ae36-3d163df44d36}
classDisplayName = MSMQ Queue Alias
creationWizard = {9e4ab987-3cca-4de0-ae36-3d163df44d36}
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
attributeDisplayNames = msMQ-Recipient-FormatName,Format Name
iconPath = 0,mqsnap.dll,-437
showInAdvancedViewOnly=True

[msMQ-Group-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
adminPropertyPages = 1,{7e93454a-976a-4228-90f1-f7648010b8e6}
adminContextMenu = 1,{7e93454a-976a-4228-90f1-f7648010b8e6}
classDisplayName = MSMQ Group
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
attributeDisplayNames = member,Member Queues
showInAdvancedViewOnly = TRUE

[remoteStorageServicePoint-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = remoteStorageServicePoint-Display
classDisplayName = Remote Storage Service
adminPropertyPages = 1,{6384e23e-736d-11d1-bd0d-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 0,&Manage...,RsAdmin.msc
attributeDisplayNames = cn,Name
ShowInAdvancedViewOnly=True
treatAsLeaf=True

[default-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = default-Display
adminMultiselectPropertyPages = 1,{50d30563-9911-11d1-b9af-00c04fd8d5b0}
adminPropertyPages = 1,{6384e23e-736d-11d1-bd0d-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 0,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
shellPropertyPages = 1,{f2c3faae-c8ac-11d0-bcdb-00c04fd8d5b6}
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
extraColumns = telephoneNumber,Business Phone,0,100,0
extraColumns = l,City,0,150,0
extraColumns = company,Company,0,150,0
extraColumns = c,Country,0,-1,0
extraColumns = department,Department,0,150,0
extraColumns = displayName,Display Name,0,100,0
extraColumns = sAMAccountName,Pre-Windows 2000 Logon Name,0,120,0
extraColumns = mail,E-Mail Address,0,100,0
extraColumns = mailNickname,Exchange Alias,0,175,0
extraColumns = homeMDB,Exchange Mailbox Store,0,100,0
extraColumns = givenName,First Name,0,100,0
extraColumns = msExchIMPhysicalURL,Instant Messaging Home Server,0,170,0
extraColumns = msExchIMMetaPhysicalURL,Instant Messaging URL,0,140,0
extraColumns = sn,Last Name,0,100,0
extraColumns = whenChanged,Modified,0,130,0
extraColumns = physicalDeliveryOfficeName,Office,0,100,0
extraColumns = st,State,0,100,0
extraColumns = targetAddress,Target Address,0,100,0
extraColumns = title,Job Title,0,100,0
extraColumns = userPrincipalName,User Logon Name,0,200,0
extraColumns = textEncodedORAddress,X.400 E-Mail Address,0,130,0
extraColumns = postalCode,Zip Code,0,100,0
ShowInAdvancedViewOnly=True

[sitesContainer-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = sitesContainer-Display
adminPropertyPages = 1,{6384e23e-736d-11d1-bd0d-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
adminContextMenu = 2,{6BA3F852-23C6-11D1-B91F-00A0C9A06D2D}
classDisplayName = Sites Container
ShowInAdvancedViewOnly=True

[interSiteTransportContainer-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = interSiteTransportContainer-Display
adminPropertyPages = 1,{6384e23e-736d-11d1-bd0d-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
adminContextMenu = 2,{6BA3F852-23C6-11D1-B91F-00A0C9A06D2D}
classDisplayName = Inter-Site Transports Container
ShowInAdvancedViewOnly=True

[subnetContainer-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = subnetContainer-Display
adminPropertyPages = 1,{6384e23e-736d-11d1-bd0d-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
adminContextMenu = 2,{6BA3F852-23C6-11D1-B91F-00A0C9A06D2D}
classDisplayName = Subnets Container
ShowInAdvancedViewOnly=True

[serversContainer-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = serversContainer-Display
adminPropertyPages = 1,{6384e23e-736d-11d1-bd0d-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
adminContextMenu = 2,{6BA3F852-23C6-11D1-B91F-00A0C9A06D2D}
classDisplayName = Servers Container
ShowInAdvancedViewOnly=True

[nTDSService-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = nTDSService-Display
adminPropertyPages = 1,{6384e23e-736d-11d1-bd0d-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Active Directory Service
ShowInAdvancedViewOnly=True

[queryPolicy-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = queryPolicy-Display
adminPropertyPages = 1,{6384e23e-736d-11d1-bd0d-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Query Policy
ShowInAdvancedViewOnly=True

[foreignSecurityPrincipal-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = foreignSecurityPrincipal-Display
adminPropertyPages = 1,{6dfe6486-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
classDisplayName = Foreign Security Principal
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
ShowInAdvancedViewOnly=True

[pKICertificateTemplate-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = pKICertificateTemplate-Display
adminPropertyPages = 1,{11BDCE06-D55C-44e9-BC0B-8655F89E8CC5}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
shellPropertyPages = 1,{11BDCE06-D55C-44e9-BC0B-8655F89E8CC5}
contextMenu = 0,{11BDCE06-D55C-44e9-BC0B-8655F89E8CC5}
adminContextMenu = 0,{11BDCE06-D55C-44e9-BC0B-8655F89E8CC5}
classDisplayName = Certificate Template
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
iconPath = 0,certtmpl.dll,-144
ShowInAdvancedViewOnly=True

[msCOM-PartitionSet-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = msCOM-PartitionSet-Display
adminPropertyPages = 1,{9305969B-F45F-47E5-A954-6EA879E874CC}
adminContextMenu = 1,{EEBD2F15-87EE-4F93-856F-6AD7E31787B3}
showInAdvancedViewOnly=True

[msCOM-Partition-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = msCOM-Partition-Display
adminPropertyPages = 1,{2797CF92-415A-43E6-A8F7-A5FAAB783719}
showInAdvancedViewOnly=True

[lostAndFound-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass = displaySpecifier
ObjectCategory = Display-Specifier
cn = lostAndFound-Display
extraColumns = lastKnownParent,Last Known Parent,1,300,0
showInAdvancedViewOnly=True
adminContextMenu = 0,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
adminPropertyPages = 1,{6384e23e-736d-11d1-bd0d-00c04fd8d5b6}
adminPropertyPages = 2,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 3,{4E40F770-369C-11d0-8922-00A024AB2DBB}
shellPropertyPages = 1,{f2c3faae-c8ac-11d0-bcdb-00c04fd8d5b6}
attributeDisplayNames = cn,Name
attributeDisplayNames = description,Description
adminMultiselectPropertyPages = 1,{50d30563-9911-11d1-b9af-00c04fd8d5b0}

[inetOrgPerson-Display]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
adminContextMenu = 1,{08eb4fa6-6ffd-11d1-b0e0-00c04fd8dca6}
adminMultiselectPropertyPages = 1,{50D30564-9911-11D1-B9AF-00C04FD8D5B0}
adminPropertyPages = 9,{FA3E1D55-16DF-446D-872E-BD04D4F39C93}
adminPropertyPages = 8,{0910dd01-df8c-11d1-ae27-00c04fa35813}
adminPropertyPages = 7,{8c5b1b50-d46e-11d1-8091-00a024c48131}
adminPropertyPages = 6,{4E40F770-369C-11d0-8922-00A024AB2DBB}
adminPropertyPages = 5,{6dfe6488-a212-11d0-bcd5-00c04fd8d5b6}
adminPropertyPages = 4,{FD57D295-4FD9-11D1-854E-00C04FC31FD3}
adminPropertyPages = 3,{B52C1E50-1DD2-11D1-BC43-00C04FC31FD3}
adminPropertyPages = 1,{6dfe6485-a212-11d0-bcd5-00c04fd8d5b6}
attributeDisplayNames = wWWHomePage,Web Page Address
attributeDisplayNames = userPrincipalName,Logon Name
attributeDisplayNames = userWorkstations,Logon Workstations
attributeDisplayNames = displayName,Display Name
attributeDisplayNames = url,Web Page Address (Others)
attributeDisplayNames = title,Job Title
attributeDisplayNames = telexNumber,Telex Number (Others)
attributeDisplayNames = telephoneNumber,Telephone Number
attributeDisplayNames = streetAddress,Street Address
attributeDisplayNames = st,State/Province
attributeDisplayNames = sn,Last Name
attributeDisplayNames = samAccountName,Logon Name (pre-Windows 2000)
attributeDisplayNames = primaryTelexNumber,Telex Number
attributeDisplayNames = primaryInternationalISDNNumber,International ISDN Number
attributeDisplayNames = postOfficeBox,Post Office Box
attributeDisplayNames = postalCode,ZIP/Postal Code
attributeDisplayNames = physicalDeliveryOfficeName,Office Location
attributeDisplayNames = personalTitle,Title
attributeDisplayNames = pager,Pager Number
attributeDisplayNames = otherTelephone,Phone Number (Others)
attributeDisplayNames = otherPager,Pager Number (Others)
attributeDisplayNames = otherMobile,Mobile Number (Others)
attributeDisplayNames = otherMailbox,E-Mail Address (Others)
attributeDisplayNames = otherIpPhone,IP Phone Number (Others)
attributeDisplayNames = otherHomePhone,Home Phone (Others)
attributeDisplayNames = otherFacsimileTelephoneNumber,Fax Number (Others)
attributeDisplayNames = info,Notes
attributeDisplayNames = mobile,Mobile Number
attributeDisplayNames = middleName,Middle Name
attributeDisplayNames = memberOf,Member Of
attributeDisplayNames = manager,Manager
attributeDisplayNames = mail,E-Mail Address
attributeDisplayNames = l,City
attributeDisplayNames = ipPhone,IP Phone Number
attributeDisplayNames = internationalISDNNumber,International ISDN Number (Others)
attributeDisplayNames = initials,Initials
attributeDisplayNames = homePostalAddress,Home Address
attributeDisplayNames = homePhone,Home Phone
attributeDisplayNames = homeDrive,Home Drive
attributeDisplayNames = homeDirectory,Home Folder
attributeDisplayNames = givenName,First Name
attributeDisplayNames = generationQualifier,Generational Suffix
attributeDisplayNames = facsimileTelephoneNumber,Fax Number
attributeDisplayNames = employeeID,Employee ID
attributeDisplayNames = division,Division
attributeDisplayNames = distinguishedName,X500 Distinguished Name
attributeDisplayNames = directReports,Direct Reports
attributeDisplayNames = description,Description
attributeDisplayNames = department,Department
attributeDisplayNames = company,Company
attributeDisplayNames = comment,Comment
attributeDisplayNames = co,Country
attributeDisplayNames = c,Country Abbreviation
attributeDisplayNames = cn,Name
attributeDisplayNames = assistant,Assistant
classDisplayName= InetOrgPerson
contextMenu = 0,{62AE1F9A-126A-11D0-A14B-0800361B1103}
instanceType = 4
objectCategory = Display-Specifier
objectClass = displaySpecifier
shellPropertyPages = 2,{dde2c5e9-c8ae-11d0-bcdb-00c04fd8d5b6}
shellPropertyPages = 1,{f5d121ed-c8ac-11d0-bcdb-00c04fd8d5b6}
showInAdvancedViewOnly = TRUE
treatAsLeaf = TRUE


;--------------------------------------------------------
; WellKnown Security Principals subtree under the
;                                              default configuration container
;--------------------------------------------------------

[WellKnown Security Principals]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
;             FLAG_DISALLOW_DELETE
systemFlags=0x80000000


;--------------------------------------------------------
; Physical Locations subtree under the default configuration container
;--------------------------------------------------------
[Physical Locations]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=physicalLocation
ObjectCategory=Physical-Location
l=Physical Locations tree root


;--------------------------------------------------------
; store information for ForestUpdates
;--------------------------------------------------------
[ForestUpdates]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)S:(AU;CISA;CCDCSDDT;;;WD)
objectClass=Container
ObjectCategory=Container
CHILD=ForestUpdates-Operations
CHILD=ForestUpdates-Windows2003Update

[ForestUpdates-Operations]
RDN-Of-Object=Operations
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

CHILD=3467dae5-dedd-4648-9066-f48ac186b20a
CHILD=33b7ee33-1386-47cf-baa1-b03e06473253
CHILD=e9ee8d55-c2fb-4723-a333-c80ff4dfbf45
CHILD=ccfae63a-7fb5-454c-83ab-0e8e1214974e
CHILD=ad3c7909-b154-4c16-8bf7-2c3a7870bb3d
CHILD=26ad2ebf-f8f5-44a4-b97c-a616c8b9d09a
CHILD=4444c516-f43a-4c12-9c4b-b5c064941d61
CHILD=436a1a4b-f41a-46e6-ac86-427720ef29f3
CHILD=b2b7fb45-f50d-41bc-a73b-8f580f3b636a
CHILD=1bdf6366-c3db-4d0b-b8cb-f99ba9bce20f
CHILD=63c0f51a-067c-4640-8a4f-044fb33f1049
CHILD=dae441c0-366e-482e-98d9-60a99a1898cc
CHILD=7dd09ca6-f0d6-43bf-b7f8-ef348f435617
CHILD=6b800a81-affe-4a15-8e41-6ea0c7aa89e4
CHILD=dd07182c-3174-4c95-902a-d64fee285bbf
CHILD=ffa5ee3c-1405-476d-b344-7ad37d69cc25
CHILD=099f1587-af70-49c6-ab6c-7b3e82be0fe2
CHILD=94fdebc6-8eeb-4640-80de-ec52b9ca17fa
CHILD=1a3f6b15-55f2-4752-ba27-3d38a8232c4d
CHILD=dee21a17-4e8e-4f40-a58c-c0c009b685a7
CHILD=9bd98bb4-4047-4de5-bf4c-7bd1d0f6d21d
CHILD=3fe80fbf-bf39-4773-b5bd-3e5767a30d2d
CHILD=f02915e2-9141-4f73-b8e7-2804662782da
CHILD=39902c52-ef24-4b4b-8033-2c9dfdd173a2
CHILD=20bf09b4-6d0b-4cd1-9c09-4231edf1209b
CHILD=94f238bb-831c-11d6-977b-00c04f613221
CHILD=94f238bc-831c-11d6-977b-00c04f613221
CHILD=94f238bd-831c-11d6-977b-00c04f613221
CHILD=94f238be-831c-11d6-977b-00c04f613221
CHILD=94f238bf-831c-11d6-977b-00c04f613221
CHILD=94f238c0-831c-11d6-977b-00c04f613221
CHILD=eda27b47-e610-11d6-9793-00c04f613221
CHILD=eda27b48-e610-11d6-9793-00c04f613221
CHILD=eda27b49-e610-11d6-9793-00c04f613221
CHILD=eda27b4a-e610-11d6-9793-00c04f613221
CHILD=26d9c510-e61a-11d6-9793-00c04f613221
CHILD=26d9c511-e61a-11d6-9793-00c04f613221

[3467dae5-dedd-4648-9066-f48ac186b20a]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[33b7ee33-1386-47cf-baa1-b03e06473253]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[e9ee8d55-c2fb-4723-a333-c80ff4dfbf45]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[ccfae63a-7fb5-454c-83ab-0e8e1214974e]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[ad3c7909-b154-4c16-8bf7-2c3a7870bb3d]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[26ad2ebf-f8f5-44a4-b97c-a616c8b9d09a]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[4444c516-f43a-4c12-9c4b-b5c064941d61]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[436a1a4b-f41a-46e6-ac86-427720ef29f3]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[b2b7fb45-f50d-41bc-a73b-8f580f3b636a]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[1bdf6366-c3db-4d0b-b8cb-f99ba9bce20f]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[63c0f51a-067c-4640-8a4f-044fb33f1049]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[dae441c0-366e-482e-98d9-60a99a1898cc]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[7dd09ca6-f0d6-43bf-b7f8-ef348f435617]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[6b800a81-affe-4a15-8e41-6ea0c7aa89e4]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[dd07182c-3174-4c95-902a-d64fee285bbf]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[ffa5ee3c-1405-476d-b344-7ad37d69cc25]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[099f1587-af70-49c6-ab6c-7b3e82be0fe2]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

;!--------------------------------------------------------
;! Win2003 Created Forest
;! This operations guid 94fdebc6-8eeb-4640-80de-ec52b9ca17fa is set on forests where the
;! first DC in the forest had at least a Windows server 2003
;! code base, schema, etc.
;!--------------------------------------------------------
[94fdebc6-8eeb-4640-80de-ec52b9ca17fa]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[1a3f6b15-55f2-4752-ba27-3d38a8232c4d]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[dee21a17-4e8e-4f40-a58c-c0c009b685a7]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[9bd98bb4-4047-4de5-bf4c-7bd1d0f6d21d]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[3fe80fbf-bf39-4773-b5bd-3e5767a30d2d]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[f02915e2-9141-4f73-b8e7-2804662782da]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[39902c52-ef24-4b4b-8033-2c9dfdd173a2]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[20bf09b4-6d0b-4cd1-9c09-4231edf1209b]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[94f238bb-831c-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[94f238bc-831c-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[94f238bd-831c-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[94f238be-831c-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[94f238bf-831c-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[94f238c0-831c-11d6-977b-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[eda27b47-e610-11d6-9793-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[eda27b48-e610-11d6-9793-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[eda27b49-e610-11d6-9793-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[eda27b4a-e610-11d6-9793-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[26d9c510-e61a-11d6-9793-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[26d9c511-e61a-11d6-9793-00c04f613221]
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container

[ForestUpdates-Windows2003Update]
RDN-Of-Object=Windows2003Update
nTSecurityDescriptor=O:EAG:EAD:(A;;RPLCLORC;;;WD)(A;;RPWPCRLCLOCCRCWDWOSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=Container
ObjectCategory=Container
revision=9

[NTDS Quotas config]
RDN-Of-Object=NTDS Quotas
nTSecurityDescriptor=O:EAG:EA D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPLCLORC;;;BA)(OA;;CR;4ecc03fe-ffc0-4947-b630-eb672a8a9dbc;;WD)S:(AU;CISA;WDWOSDDTWPCRCCDCSW;;;WD)
objectClass=msDS-QuotaContainer
objectCategory=ms-DS-Quota-Container
description=Quota specifications container
ShowInAdvancedViewOnly=True
;systemFlags=FLAG_DISALLOW_DELETE
systemFlags=0x80000000
msDS-TombstoneQuotaFactor=100


;!--------------------------------------------------------
;! Schema naming context object
;!--------------------------------------------------------

[SCHEMA]
objectClass = DMD
objectCategory = DMD
objectVersion = 31
nTSecurityDescriptor=O:SAG:SAD:(OA;;CR;e12b56b6-0a95-11d1-adbb-00c04fd8d5cd;;SA)(OA;;CR;1131f6aa-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6ab-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6ac-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6aa-9c07-11d1-f79f-00c04fc2dcd2;;BA)(OA;;CR;1131f6ab-9c07-11d1-f79f-00c04fc2dcd2;;BA)(OA;;CR;1131f6ac-9c07-11d1-f79f-00c04fc2dcd2;;BA)(A;CI;RPLCLORC;;;AU)(A;CI;RPWPCRLCLOCCRCWOWDSW;;;SA)(A;CI;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(OA;;CR;1131f6ad-9c07-11d1-f79f-00c04fc2dcd2;;ED)(OA;;CR;1131f6ad-9c07-11d1-f79f-00c04fc2dcd2;;BA)S:(AU;SA;WDWOWPCCDCSDDTSW;;;WD)(AU;CISA;WP;;;WD)(AU;SA;CR;;;BA)(AU;SA;CR;;;DU)(OU;SA;CR;e12b56b6-0a95-11d1-adbb-00c04fd8d5cd;;WD)(OU;SA;CR;45ec5156-db7e-47bb-b53f-dbeb2d03c40f;;WD)
;Its a NC ROOT - (NC_MASTER_SUBREF)
instanceType=13
fSMORoleOwner=$REGISTRY=Machine DN Name


;!--------------------------------------------------------
;! Templates used for new server objects.
;!--------------------------------------------------------

;--------------------------------------------------------
; This template works for all new servers, first in  enterprise or replica.
; This section is not used if the server already exists, as might be the case
; if the server was indeed a server (i.e. not a DC) and registered in the DS
; already.
;--------------------------------------------------------
[DEFAULTANYSERVER]
nTSecurityDescriptor=O:DAG:DAD:(A;CI;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)
objectClass=Server
ObjectCategory=Server
;systemFlags=FLAG_CONFIG_ALLOW_RENAME        |
;             FLAG_CONFIG_ALLOW_LIMITED_MOVE |
;             FLAG_DISALLOW_MOVE_ON_DELETE
systemFlags=0x52000000

;--------------------------------------------------------
; Template for NTDS-DSA object for the first DS DC in the enterprise.
; This machine is by default a Global Catalog.
;--------------------------------------------------------
[DEFAULTFIRSTMACHINE]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSDDTSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=NTDSDSA
ObjectCategory=NTDS-DSA
invocationID=\x00000000000000000000000000000000
hasMasterNCs= $REGISTRY=Configuration NC
hasMasterNCs= $REGISTRY=Root Domain
hasMasterNCs= $REGISTRY=Schema DN Name
msDS-hasMasterNCs= $REGISTRY=Configuration NC
msDS-hasMasterNCs= $REGISTRY=Root Domain
msDS-hasMasterNCs= $REGISTRY=Schema DN Name
dMDLocation=   $REGISTRY=Schema DN Name
msDS-HasDomainNCs= $REGISTRY=Root Domain
Options=1 ; // NTDSDSA_OPT_IS_GC
msDs-Behavior-Version=2
;systemFlags=FLAG_DISALLOW_MOVE_ON_DELETE
systemFlags=0x02000000

;--------------------------------------------------------
; Template for NTDS-DSA object for DS DCs joined to a pre-existing enterprise.
; This machine is by default NOT a Global Catalog.
;--------------------------------------------------------
[DEFAULTADDLMACHINE]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSDDTSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=NTDSDSA
objectCategory=NTDS-DSA
invocationID=\x00000000000000000000000000000000
hasMasterNCs= $REGISTRY=Configuration NC
hasMasterNCs= $REGISTRY=Root Domain
hasMasterNCs= $REGISTRY=Schema DN Name
msDS-hasMasterNCs= $REGISTRY=Configuration NC
msDS-hasMasterNCs= $REGISTRY=Root Domain
msDS-hasMasterNCs= $REGISTRY=Schema DN Name
dMDLocation=   $REGISTRY=Schema DN Name
msDS-HasDomainNCs= $REGISTRY=Root Domain
msDs-Behavior-Version=2
;systemFlags=FLAG_DISALLOW_MOVE_ON_DELETE
systemFlags=0x02000000


;--------------------------------------------------------
; Template for NTDS-DSA object for DS DCs joined to an existing domain.
; This machine is by default NOT a Global Catalog.
;--------------------------------------------------------
[DEFAULTADDLMACHINEREPLICA]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSDDTSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=NTDSDSA
objectCategory=NTDS-DSA
invocationID=\x00000000000000000000000000000000
hasMasterNCs= $REGISTRY=Configuration NC
hasMasterNCs= $REGISTRY=Root Domain
hasMasterNCs= $REGISTRY=Schema DN Name
msDS-hasMasterNCs= $REGISTRY=Configuration NC
msDS-hasMasterNCs= $REGISTRY=Root Domain
msDS-hasMasterNCs= $REGISTRY=Schema DN Name
dMDLocation=   $REGISTRY=Schema DN Name
msDS-HasDomainNCs= $REGISTRY=Root Domain
msDs-Behavior-Version=2
;systemFlags=FLAG_DISALLOW_MOVE_ON_DELETE
systemFlags=0x02000000
ServerReference= $REGISTRY=Local Machine Account DN

;--------------------------------------------------------
; The following NTDS-Connection objects are added only in the course of
; replicated installs.
;--------------------------------------------------------
[DEFAULTLOCALCONNECTION]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPWPCRLCLOCCRCWDWOSDDTSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;;RPLCLORC;;;AU)
objectClass=NTDSConnection
objectCategory=NTDS-Connection
enabledConnection=1
fromServer=$REGISTRY=Remote Machine DN Name
Options=1
Schedule=$SYSDEFAULT=REPLSCHEDULE
;systemFlags=FLAG_CONFIG_ALLOW_MOVE
systemFlags=0x20000000

[DEFAULTREMOTECONNECTION]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPWPCRLCLOCCRCWDWOSDDTSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)(A;;RPLCLORC;;;AU)
objectClass=NTDSConnection
ObjectCategory=NTDS-Connection
enabledConnection=1
fromServer=$REGISTRY=Machine DN Name
Options=1
Schedule=$SYSDEFAULT=REPLSCHEDULE
;systemFlags=FLAG_CONFIG_ALLOW_MOVE
systemFlags=0x20000000

;--------------------------------------------------------
; The following Cross-Ref object is added only in the course of adding a new
; domain to an existing DS enterprise (e.g., a child domain install).
;--------------------------------------------------------
[DEFAULTENTERPRISECROSSREF]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=crossRef
ObjectCategory=Cross-Ref
nCName=$REGISTRY=Root Domain
nETBIOSName=$REGISTRY=Netbios Name
dnsRoot=$REGISTRY=DNS Root
systemFlags=3

[DEFAULTNEWCHILDDOMAINCROSSREF]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=crossRef
ObjectCategory=Cross-Ref
nCName=$REGISTRY=Root Domain
nETBIOSName=$REGISTRY=Netbios Name
dnsRoot=$REGISTRY=DNS Root
trustParent=$REGISTRY=TrustedCrossRef
systemFlags=3


[DEFAULTNEWTREEDOMAINCROSSREF]
nTSecurityDescriptor=O:DAG:DAD:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCRCWDWOSW;;;DA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)
objectClass=crossRef
ObjectCategory=Cross-Ref
nCName=$REGISTRY=Root Domain
nETBIOSName=$REGISTRY=Netbios Name
dnsRoot=$REGISTRY=DNS Root
rootTrust=$REGISTRY=TrustedCrossRef
systemFlags=3
