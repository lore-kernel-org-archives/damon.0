Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEA33CD
	for <damon@lists.linux.dev>; Fri, 12 Aug 2022 18:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660327660; x=1691863660;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=sXjXRSkFQNFAoPEbIgEtuHokdlrnWP1lKcfczQ/iCmY=;
  b=Ff6e1aVaqcQhRsWn/QXcIzZtEMj9xJrlFBNq0/5+OLBcgDhujoNIn+0X
   Z8U5ipeFtV+7i5s4ghOZC16+Pt6zkZNwvaC3+9CjInyG0wzF4McpCyRZd
   Rldyajx3ILmBFR2E4cD+a3tIc4z/N1k4whD22V9ZSU10caT5UehjwlYnM
   iO+0JFzgMZisZHnUGr8wN5x0vU/eTP42Dij+AtrBdbYyVyWTHZTnunrIS
   hYJQgbnX2YfazRYLO6s8to3vfllc5Sbk4oCZ9yezGaSGqAy4VLqqGN/Rn
   xssSKAjCYiUWylSjwWsinymJQDEnYScqOVZpzXl9N4JXGwCeka+ltjiI9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353397599"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="353397599"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 11:07:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="851646218"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2022 11:07:37 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 11:07:36 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 11:07:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 11:07:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 12 Aug 2022 11:07:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpJuuGRKHOUXweVf1g6n3e018M70yIdGFrMBhG9Eulrjqt14XCb7LnUQf7qvv0p0UY/JW0ICQKWClm0YDrHTKS2nrjp3hw0IAQeS8uKZa8VianBDoPIK1v9w1EZObcSk+XrVqCONdujdcYddjUzlH1EdChPETn6lkK1UvAFyucXMG29o/mL3A8pZFSE47ZtjQMTszfDKMIdBlDUxhTY/BF0zYWYxYVRligowUBPtc+Uiohxsy9sULzSiGzo49sWppvAVNT0L35EixEaJctlJ7Re0Kx/F75g7UeXI62HjcHWrRthY1kTEG+snDpW0j0wq/Z+TBQ0y+Y5K9enKggxBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djngyt8wnv+/21o2kAgu2Sw4Dcfgs+W/28TcnjpOoNg=;
 b=DqE9i/i0HnwXS6AzSfXjuhN4R3xY7ViIaqatLrtC2IhG6f1PJjerKplpTdxXvNqV2yataOTzreqSmsgmm6zkQaHo/QmlhWEK1ygzKLW2IizloOABw0d/TOIFRrb+cSd5LqiKh/Hey0ID/zHdFPA6H3pLzwPbpEbAUkB8bH5UzTtAUseLGgvs46UPhLK2MeopBdFGqLNns0Oo1PRGsZ912ZOUgEwfLksNjFptdwpRBTai0mJrfj458SUkqdBFCZ8wfuolLGFPqOlS648Wum86jQoGQ64Hq5oHa98GaEJUov0jdsq9o52A1Zulza2WSBe2tqB7vUqCFXFXdBARaf+aBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3978.namprd11.prod.outlook.com (2603:10b6:5:19a::14)
 by SN6PR11MB2686.namprd11.prod.outlook.com (2603:10b6:805:59::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 12 Aug
 2022 18:07:34 +0000
Received: from DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::a186:a69e:dd1a:73ac]) by DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::a186:a69e:dd1a:73ac%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 18:07:34 +0000
From: "Pulavarty, Badari" <badari.pulavarty@intel.com>
To: "Pulavarty, Badari" <badari.pulavarty@intel.com>, "damon@lists.linux.dev"
	<damon@lists.linux.dev>
Subject: RE: [PATCH] DAMON dbgfs_mk_context() error handling
Thread-Topic: [PATCH] DAMON dbgfs_mk_context() error handling
Thread-Index: AdiudYBAiI6eUiB2RbyOapwBra/TXwAAMC5A
Date: Fri, 12 Aug 2022 18:07:34 +0000
Message-ID: <DM6PR11MB3978836A9F06579D15A5198A9C679@DM6PR11MB3978.namprd11.prod.outlook.com>
References: <DM6PR11MB3978994F75A4104D714437379C679@DM6PR11MB3978.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3978994F75A4104D714437379C679@DM6PR11MB3978.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a1ddf52-6810-4f60-6514-08da7c8d880e
x-ms-traffictypediagnostic: SN6PR11MB2686:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rCFwxBF+4V+mYQru6nw20DAuVqLGqc3WQXxg/8sAupPFqZHQpdo2yQ0+9m+2T/WyAEYzp2unEcjywqrNBqeKmt9ubISSCOWBvSPwrtn4mq+ekrixQbrgH0Do1oF0n/y8chLVGNbhDMZOfMfv1Xu9VICg710SaYEtsSm1DCWvBnEXEt9Ko/VjrVg4/ggKplOImQzLgUWSDaRmoh91Q2cNTT19dNuN8boyU8J8xkZy7L3+tuBNwKjj/of+sp3qV5MZsN6FGda3NB0QDwa+c6ycV+Vm2jf8YSg+VusHCZ4tCbNTvBUMfUguExaRXdAEN13m8FYcrUOI+VdQq+CvxQHrwEODa9AvTjK0s6/c1XdNCwfus/UKpV82Cf935MFxAqZHIMkeg66IqSkEFvhgvvG1o2wmJ6dDPC1Z3w92X7DYWvraoqOtfYLNATwOemNkjL3oCS+qsRc2/hz+4rUAK6+35CZb8xCi8nYsmeEvjDWE3XQXO0tiYvTdmCXPKFzse2seKiwbUZrgK9yAzm8dPjkTwmMpwRs474JJWF2uxLU4CjjS2XqBLDaEh+OJcBXkgdFwRSnqx5xXNPklZsAbP7de1LCtOXIXXM3QscxOBUePHgZNul/p09i7hYE0Wua68Bre4UliMwiEfSKlBiLuUTR4pygEaYnao2a6OOIC9975m9fEgZD4RFoYjLv9T5O4iksAH3XVsVzDvg70qyBj72OvaDjvxzQH0PhniPmTqxNwsHF3F0fT1HT7cbkArkO0c+JEbXLjgx/9jq0kcXQOsQENpwN0Xxo/Yk5mzoFU04g0+KZtL1KBLCAN6F4VJE+Yawoz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(136003)(346002)(376002)(478600001)(83380400001)(122000001)(64756008)(41300700001)(55016003)(76116006)(66556008)(66446008)(38070700005)(8676002)(66946007)(66476007)(2906002)(186003)(33656002)(82960400001)(26005)(53546011)(7696005)(86362001)(6506007)(110136005)(5660300002)(9686003)(8936002)(38100700002)(2940100002)(52536014)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yAWEEYsins21WEe7ENW/4Bon0JtjxuLxZCqyU02pML5LHThsiUKM7Y2yr8YZ?=
 =?us-ascii?Q?YhA7/tRWdyh8ADsKC/cSLOcX6ubId5lt8cq3Lnvex0fwin3RIbdBY3fJrlZw?=
 =?us-ascii?Q?7J+v6/5W4PUen6yds0cU7Xg9LGSMaSi8KQxE3WT4X+oXjUurbZgrGAAqFKiF?=
 =?us-ascii?Q?6vXWMHeHaKO1avRptK7wRlek8U5e0L48iAgHfqLR5djlA7fDtsQvY0ypl5qS?=
 =?us-ascii?Q?/7JS0xG1f5HFp9aO2e1H9mGC+UJ6sFCXU96xHsKQGNbMg0L6S6TWfvBbeXje?=
 =?us-ascii?Q?ZRZgtwwe2SC4FxfDsbjacyonAoyQyPhperG7A1wjuf0s3rH55Nm73zCTqGgY?=
 =?us-ascii?Q?bchYoMJVy0VQkMZL4A/S8ssIFMcGLa1pwfU5fC1hY2fLMopDVoyoq6EZDQC5?=
 =?us-ascii?Q?cr4bGq9EU7ZlTV8Am0iba9CUpyWtwtYPaXmsTL3jDhLXi+Zz1+ALMzeBssLn?=
 =?us-ascii?Q?kik0rsJfgYAfLi56SIpQ2D+iViyq3RADB6okR+QOhIr1GTZq4Cy3StCsa3BP?=
 =?us-ascii?Q?OMwVM0G8n17DLX9M2dURiiCk7wdKnv02s2CV/ZJFVaDaRdi81X5OifEGxe1H?=
 =?us-ascii?Q?kKueONVsixHKKSdQaBaIbKoN5H9Qub9efjeoQLxMCjjFLFQyv941neNabR8a?=
 =?us-ascii?Q?ow50fyE880QO9YJufK9lnrQgqsJxcMcYoIF3bHBxO+ay3REs61v1Swy0TbJY?=
 =?us-ascii?Q?n5Dn92t7knFkPBIP/SuSFeuA5uF+oPbDNFJjbwj/zcdozXxYyZAeeFfHqL/P?=
 =?us-ascii?Q?O6vodZih9SOU4tBqT9jKe8j+L9n5wuFT26CSldwDsxGzXRTE4M66Ds7U7Nod?=
 =?us-ascii?Q?VuaUw+wf//8pHVzY7UrcZZCfipqZwV9jLbVhxSoQjmvw0xFoPwU+zqOzefBw?=
 =?us-ascii?Q?7c/KWj0stwJOoDiYhqfMA9J0INIxmoAguKnjJ3MgLJcfnS1R/1iDvzUxRZoA?=
 =?us-ascii?Q?WMRRpitS4ZTunE+goZvV0N/dY8k/vi/l6TnsCv+TsK2cF4rT+zXxUFDLhJDJ?=
 =?us-ascii?Q?mU714khIMJD99XrEFQqI+3Y6NxY7Q3u1bUBnRgkVNBzfHRSB3BvUvqhlZWYa?=
 =?us-ascii?Q?l03pyyA/gThqxuNhG5sZGjqcmqYGnklkihjijQElx8HlY1pNjCJGbuktuZ3c?=
 =?us-ascii?Q?5Ui9paWGHjHVxPY0KmHBPgM2AXueUMdcptihnpyXG9Vls2QYETz478SCbrn2?=
 =?us-ascii?Q?tNxwIhLfCWp7aclKufu+uriTf8YldTJexvlsniS6tuOgKU0yAiOvG0npg18J?=
 =?us-ascii?Q?fq0tZPD6FUp7P/Vu1yVJMOiGsRtdhAiAWdAj7lXsJJ0pu3vp+dbn/scB3fy5?=
 =?us-ascii?Q?nfp8vkiinYTYQTEeGMmyfR0Jg/Gv0bN8taj1xsnp5QVn4Lg9QiDOSfj354lP?=
 =?us-ascii?Q?WexsCk20IrlgVvRcEhF/TBPjnIlTFysuLHTMMK15VokPWrDO3fgO7gXoD+Cj?=
 =?us-ascii?Q?OEneHeXwejVsJOszo6a3ISBEW7Iojz1zcB5C/1HXlgIid32QJ3aHuyFrPsRZ?=
 =?us-ascii?Q?tMdRuxOMHx76tP9TyJeRMjrSWbc9M0e3H2R8sxDwnZ5IbTiYFSDDlW173sw9?=
 =?us-ascii?Q?lvYampaqFAMdQM+M8IeVVuYdlbitORUyWHysfrJk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1ddf52-6810-4f60-6514-08da7c8d880e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 18:07:34.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9mcLWeCCpJHiIv6EF69h4MzqUAQiZTLQhxzJ926RVABnyEitPgCcFkZrM66dCcH+kDdGqhDRA4RBV1V9JHIml4X40xY8JeLCxcmgu2Tb6ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2686
X-OriginatorOrg: intel.com


Sorry. Here is the correct test case:

echo "off" >  /sys/kernel/debug/damon/monitor_on
echo "abc" > /sys/kernel/debug/damon/mk_context
echo "abc" > /sys/kernel/debug/damon/mk_context
echo <pid> > /sys/kernel/debug/damon/abc/target_ids
echo "on" > /sys/kernel/debug/damon/monitor_on  <<< fails to enable monitor

Thanks,
Badari

-----Original Message-----
From: Pulavarty, Badari <badari.pulavarty@intel.com>=20
Sent: Friday, August 12, 2022 11:01 AM
To: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Subject: [PATCH] DAMON dbgfs_mk_context() error handling

damon dbgfs_mk_context() does not handle error from debugfs_create_dir() co=
rrectly.

For example, if one tries to create a context with existing name, debugfs_c=
reate_dir() fails with -EEXIST, but dbgfs_mk_context() assumes the call is =
successful and adds another entry - which will cause failures when try to e=
nable the monitor.

Test case:

echo "off" >  /sys/kernel/debug/damon/monitor_on
echo "abc" > /sys/kernel/debug/damon/mk_context
echo "abc" > /sys/kernel/debug/damon/mk_context
echo <pid> > /sys/kernel/debug/damon/target_ids
echo "on" > /sys/kernel/debug/damon/monitor_on  <<< fails to enable monitor

Signed-off-by: Badari Pulavarty badari.pulavarty@intel.com
---
--- orig/mm/damon/dbgfs.c       2022-08-05 13:35:54.416831666 -0400
+++ new/mm/damon/dbgfs.c        2022-08-05 13:44:25.121849930 -0400
@@ -721,6 +721,9 @@ static int dbgfs_mk_context(char *name)
                return -ENOENT;

        new_dir =3D debugfs_create_dir(name, root);
+       if (IS_ERR(new_dir)) {
+               return PTR_ERR(new_dir);
+       }
        dbgfs_dirs[dbgfs_nr_ctxs] =3D new_dir;

        new_ctx =3D dbgfs_new_ctx();

