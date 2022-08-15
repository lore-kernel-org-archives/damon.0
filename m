Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B115539B
	for <damon@lists.linux.dev>; Mon, 15 Aug 2022 23:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660607658; x=1692143658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ONyyz6/SEC1gtLFPLZtqYbO4Zu4izwCwUjyWs28fVUA=;
  b=WvGDYx0fycXu7NAKPd3USiFiEsL4/EjlTY2afnDLtbmPsNWkPjSCZDa7
   ixjpJy6iti9Sw3uokIpW3GT+kER4WJWoms6clwYuqDUrrVfvB1XKrv/Oc
   mBE4eohs0JgEVY1y59mLinMWHetSTPX9E9y3tOdgiacIQ3l6fwU43axuI
   YPZ5PQa6WuhJJLYvsxin/fwE9ZAr5/X44RGrEffLJyqT+605Y/HS8aToK
   jXeWCG0ha82SXL0NygyNJpbzciuwAteWPXKd8ZD32PGP5P906nXpkrWyu
   wTpzYG/a/J10elcnIGFFvHsVswkMZ1MN3Y66+v1bZbi8DvQ5XPC719U3a
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="272475323"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="272475323"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 16:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="639819219"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2022 16:54:07 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 16:54:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 16:54:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 16:54:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 16:54:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/s6SQ1MHqCCv9MiKZOWb9z6gOdf1IYvcfhK5p4SImL6shkYqawcpLqrnKn2qKT7Cfb67b1ZNYds/Nq1Xw2ilSZPJg/26mVc3rDnuaS4/WDkbFAmEZ0+qrDSjDY6+ADEazqViQLpQlSlDGQbEJ/NYkcd0AtfUyzwbLmXhv1cw9Qns/zu8pjec0J6RbHaFlJvQujP18p180gSY67ZqtMvYAVepsAb9Jpq0bjPszuCCIW22zoX85XX/F7XYqbXUqwtV1lmXMKVZzVYn1meQ/YHMSjMkYmy6zmxb2blol+6/gUSO/KFRdXUTfitArvTZyqIeN9VRiON21BR+x70yAWRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CiJgeNs/EYhtKAax6MDt9BnHIRKQLE9Zv2zU5qYbwY=;
 b=gyAVkdTQXoa2/doKq1GPIc1RIHAJyqcPXxIj9EFV0lp2idun7KhF4FXDsRhpFT5A8epNW0i0njUj14+T7Fraz/weFezWF5tfd6/r8pNP3jSuRUa8SqNNWpoQ4PA2Xcfx8QK7zZlv15uNpvMggGz1+kQ9ZuHeEcYTuCkJ2POKRhiL6IBNA/UivatWwMfhCy1X0fTpV0EPaKvKjF7x85xMpydUtViLn/nyiGWCj+q4JFD1pDkexUHLoQYwEnUI45dUN7D12vVLxKsMO28jsWSbae1dfrs9VutMSVqggW2krRoUddxw47d3vjJr0TiYDy8ZlC5ynSb+L98EEekjMAVGUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3978.namprd11.prod.outlook.com (2603:10b6:5:19a::14)
 by DM4PR11MB5485.namprd11.prod.outlook.com (2603:10b6:5:388::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 23:54:04 +0000
Received: from DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::a186:a69e:dd1a:73ac]) by DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::a186:a69e:dd1a:73ac%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 23:54:04 +0000
From: "Pulavarty, Badari" <badari.pulavarty@intel.com>
To: SeongJae Park <sj@kernel.org>
CC: "damon@lists.linux.dev" <damon@lists.linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
Subject: RE: [PATCH] DAMON dbgfs_mk_context() error handling
Thread-Topic: [PATCH] DAMON dbgfs_mk_context() error handling
Thread-Index: AdiudYBAiI6eUiB2RbyOapwBra/TXwBhfSgAAD0/Y8AABAwkAAAAYAqw
Date: Mon, 15 Aug 2022 23:54:04 +0000
Message-ID: <DM6PR11MB39786C1A18410F2692DCFC319C689@DM6PR11MB3978.namprd11.prod.outlook.com>
References: <DM6PR11MB39788257B26A38FCD9DA4F449C689@DM6PR11MB3978.namprd11.prod.outlook.com>
 <20220815234210.95016-1-sj@kernel.org>
In-Reply-To: <20220815234210.95016-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1251197-3a20-422d-1f3d-08da7f196f53
x-ms-traffictypediagnostic: DM4PR11MB5485:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5uSQyvKeRcSKeTcWwVIWwc1S1c2vWddh7bVfG1VsA1m5jCnR1NuJ/th22vjYUN0V3VS3RiEP7OdpCZVzKyMBotDru70DTCAUB6EmSvnpQw/jDnF6Y/CdgJm30BwwU0Tsxc2/K3g3zLJAXg3A+45qScK6E6+I7mrF3cl40bXetW3/2YjhVjvNGuIOpIINCQJjouAlFgQK23GkPv2FugHJFAgD63OW3xmIE8hQx2v1KYBheNNfta6wElh1bsusX5z+LmbDjv1WLBcGp12Ugjd3dX3Ft6KJAlGU858PWlz/MDHgMhbKJclHbPBrVZO5xxAnr6XDO7jpGPGLMXbY1bLgnIxgABMe/FFqfoit+DhWQUXzUMQmiQS7N/j5qiM1XMAK9vgY952sVl/zkvaA81R8KzbEAk1TuLeMUrrByxJELjM2obLGMK8jkvbTnulwOCt+HBWwyOLnXpTl5JaDfF+m3l+NYnr5oEqItWWJJCvxsCTtU4yWwRboj6ks+bK4qpPZX7jk/HeFOed6eZW4cG1lk9HbZQI+cXGzU/uipvd3UqprrpuyV5kLCW+kJX2u+p4as9KmGyRuE6qkDTqbkemnWXsTvGxl/mCKVbW+k0rb6d+gLqrxlu2QabrlIae9LxgLte9riVsbwqlAnujt2JxxwmuveNhUfCmTR2rTfEbN7o1RyCSmfba0fhrb/icOVV3/lpRay6uSIHPDKryBR6D5cNRUHMMLk0gfE/kgOZP0vbWQB1FpM7wgWf2eMH79VQBDIHBrlOd68hZ6kjCGCZk5xRrMna8061VFuvz8MjVuL1hY/QdAg57ahPeIfRZigXf8UMKjWQ0LxDqVj4C8MvRXgrv6R+nkauL2Xst4feFBLddRvmXVc6BsRya2moudxx0d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(366004)(39860400002)(396003)(71200400001)(966005)(41300700001)(54906003)(316002)(478600001)(26005)(38100700002)(4326008)(64756008)(8676002)(66946007)(8936002)(66446008)(66556008)(66476007)(5660300002)(76116006)(52536014)(6916009)(2906002)(53546011)(38070700005)(122000001)(186003)(86362001)(6506007)(33656002)(82960400001)(83380400001)(9686003)(7696005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qdz1qq0i98WnJfclMisy2mL5gSX3Z07FDctknY20sqz5hcchcVsVj9ytAdEm?=
 =?us-ascii?Q?XyuVBhXXN1726mdrPC4pHkWdBsjg9Ovm7jc372Qu73WZvHxdfFpFXdTrYlBb?=
 =?us-ascii?Q?LGAAkEiF0R1nIrHvpNviXUSenmycOQWXsdL0wVs0mIBTNybJlPRHKvuQI6fA?=
 =?us-ascii?Q?Ixj8KWsxtjQF68ZVPQDs2b+/R5GrE7cOyPkKuuIlYs356B3bhC8m4nH0GL9T?=
 =?us-ascii?Q?C5QvPKRjCeEXfwi1LwQlXr4KYksE+tNSRYFT0omvg+R09YCjx0TsB/vs6aOe?=
 =?us-ascii?Q?BtLsuB+B04uzzvVbDLDokfGbDso7juPEexxBBKzXeoF1AIhaIVxxCCFdZ8NZ?=
 =?us-ascii?Q?IKBmgfoV/+ukLiotc11prO/hWd+1ysmXqBX5A5sHDT/R1BOJU26TXH0nIF0y?=
 =?us-ascii?Q?0/TSmzvRXf1OO21/qVKUNzu962O7+9VyXGRRxlG5KqS0dhQ9F3+a39Fm2neV?=
 =?us-ascii?Q?VWC65ZOk1Vs13RhxNcOaSQc18f055SXRBjIKAe1r4KTTsRm6kw5SzL9Wtaiy?=
 =?us-ascii?Q?93iSYnowG3kFSkfKoGf5OlcYyGTFDmzbhe2ZGkUX0ICuW9ErOqIi1+nz6VOA?=
 =?us-ascii?Q?qOwpBJj47Lw+AfG2ktA0FzgPlGMCfYr3JJYL9tGbErIPEoEoXeCYe7nMs/pF?=
 =?us-ascii?Q?DJzmC45pdn/xLBiuCuZKIdxDhoMPu/g/irF73Rs+8LGTRI7glKXLLDki8rR9?=
 =?us-ascii?Q?4SZOgMEWBabQocm0RY0dTJX9HcYG1Lhbsi7v4/oe9pg4MdHeeOUhMGK/QeOX?=
 =?us-ascii?Q?M23C70XN3J1CqDtUSncJi62ek8Yt6z2uH8Bi9KvH2MkANNXWfu8cC/LmdW/k?=
 =?us-ascii?Q?1vNDQzkAapJYPgDOiS3AipWs5tjdyrE/3oPhLrz4d3bGYAGTuOPgCtglKIwP?=
 =?us-ascii?Q?4sg6U/5nG5RhJPMSuZRv+qBuuX9FTk3by9C5al1+0tNIYzzRyGvbWbASxhf9?=
 =?us-ascii?Q?oY49vrqTRMSiD6lX+RoJdMeIiBk6trwtTZ2Hy/qU01iiK/8BWUi6T5i8GV7E?=
 =?us-ascii?Q?AumSh6IEKCI+HwlNq9MCQWsEwqHyyInAxrIUYkTvCdHgAZS6wGyv+OkwKZYW?=
 =?us-ascii?Q?FZTuhzPVwBVv6mcSBDfLqm+nSXWSm6zOMPhvezmBgbHlKKrZ734PDR9sw1QR?=
 =?us-ascii?Q?/4HbKk97+CXjP2XR+oyArrJGaVq2jZgHSjhgL0U7s82Y4xa8DclFt8XAGJN8?=
 =?us-ascii?Q?+lK9fX1jdeK6Bh0Ei7Ahy4pV0f74f5MHurs7LRrb02dS57I/1BMULe8Qllbi?=
 =?us-ascii?Q?4IsdJ7gzKcVS9Jkgs91kqWLIRRvfsn/AfA9MV0sCEzdOlweqMYppIrr1vjyX?=
 =?us-ascii?Q?ZU4V6Q8NDOjQeRTJ/BmUsvgMEgyX3TWq2cjmBdq0XCGBvz0v8nAiU8VmQB5Y?=
 =?us-ascii?Q?aTswyJ7GiKIu3SB71ksnu2B2pZmpVETIoGeqdRjVX1yvuTT/ktGwgJMZ+xhS?=
 =?us-ascii?Q?hGdnaqofAHTs4KRNyy6EjH1gutzwb8/Jd9qllfFRFwuWQ+EzTf8qLGef77Kl?=
 =?us-ascii?Q?Zy9H3rVk9OxJs53Vp6IwqTjHhs1qq8fLLfN+c68SCk9f7mro2GbMHp05VdoA?=
 =?us-ascii?Q?TGsUvYuiUA/wLYW4RSZO585hPc6W/HcTwMS1uq/9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1251197-3a20-422d-1f3d-08da7f196f53
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 23:54:04.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2FRB2dnyiJB5CqTn8Wi0AVjqLDvSOyeFsiQuDvwGYSLKPBw9Y8SrcTrS4L/5k+mr+B2rm4HPtzy/i3iTarqZL8eNb5ebKRHOnemspOfSuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5485
X-OriginatorOrg: intel.com

Sorry. I am having e-mail client issues, its messing up patches..=20
Once I fix them, I will resend the patch.

Thanks,
Badari

-----Original Message-----
From: SeongJae Park <sj@kernel.org>=20
Sent: Monday, August 15, 2022 4:42 PM
To: Pulavarty, Badari <badari.pulavarty@intel.com>
Cc: SeongJae Park <sj@kernel.org>; damon@lists.linux.dev; linux-mm@kvack.or=
g
Subject: RE: [PATCH] DAMON dbgfs_mk_context() error handling

Hi Badari,


On Mon, 15 Aug 2022 21:51:04 +0000 "Pulavarty, Badari" <badari.pulavarty@in=
tel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 350 bytes --]
>=20
> Hi SI,
>=20
> > Nice finding, thank you!  But, the return value of the debugfs call=20
> > is intentionally ignored[2].  How about doing the duplicated name=20
> > check in
> > dbgfs_mk_context() itself before the debugfs_create_dir() call?

Please don't unwrap wrapped message.  My monitor is not so wide :'(

> >
> > [2]=20
> > https://lore.kernel.org/linux-mm/20210205155902.31102-1-sjpark@amazo
> > n.com/
>=20
> How about this?
>=20
> Thanks,
> Badari
>=20
>=20
>=20
> [-- Attachment #2: damon-mkcontext-fix.patch --]
> [-- Type: application/octet-stream, Size: 858 bytes --]

Could you please don't send a patch as an attached file of the mail but put=
 it in the mail body so that we can easily read the patch and comment in li=
ne?

>=20
> damon dbgfs_mk_context() should check to make sure there is no=20
> existing context with the same name. Otherwise, it will cause failure=20
> when we enabling the monitor.
>=20
> Test case:
>=20
> echo "off" >  /sys/kernel/debug/damon/monitor_on
> echo "abc" > /sys/kernel/debug/damon/mk_context
> echo "abc" > /sys/kernel/debug/damon/mk_context
> echo <pid> > /sys/kernel/debug/damon/abc/target_ids
> echo "on" > /sys/kernel/debug/damon/monitor_on  <<< fails
>=20
> Signed-off-by: Badari Pulavarty <badari.pulavarty@intel.com>
> ---

It would be good to put the changelog of this patch here:
https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch=
-format

> --- a/mm/damon/dbgfs.c	2022-08-15 14:27:38.308806431 -0700
> +++ b/mm/damon/dbgfs.c	2022-08-15 14:33:31.661163048 -0700
> @@ -817,6 +817,12 @@
>  	if (!root)
>  		return -ENOENT;
> =20
> +	new_dir =3D debugfs_lookup(name, root);
> +	if (new_dir) {
> +		dput(new_dir);
> +		return -EEXIST;
> +	}
> +

The change looks ok to me at a glance, but the attached file seems not an a=
ppropriate patch.  Could you please repost this as a formal patch as sugges=
ted for a better review?

Thanks,
SJ

>  	new_dir =3D debugfs_create_dir(name, root);
>  	dbgfs_dirs[dbgfs_nr_ctxs] =3D new_dir;
