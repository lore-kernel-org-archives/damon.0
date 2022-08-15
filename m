Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91C5386
	for <damon@lists.linux.dev>; Mon, 15 Aug 2022 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660600269; x=1692136269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=K5VNMH++b+iAmOhFuH9Ls1+LfMhV78XBN7ywylkIEjM=;
  b=BhvksvI/GfJuHPPVMPRsNwwx+oZhpsEWBhxVmeDvDuYLbkN/9NmsNcRx
   fTb2OkDzwK+2qAkKd6zc+bsH2Ra5fubCgtTTzVXAYf0T6ltvVVJ/Auf2r
   4EOun8NcuYihPPN16vrwXpRn//XT2kioEbP3SjGotjvf4yYkivYXd6vB0
   84vGi95gLrD8YGLUNdTEmeGfhO7xc+K2CJhuQ1Pi69ulG63aTkBhuX6Qn
   gcfuWafhVAaTnixPdg2uGglqO5rN6pfxpGZW2MQ+3ojteH5sovh/WSD8F
   KGZXxhyr8urNG914smGJG0z80keOzAJcQ4zANvEyWSL1hzNYgCHOdsvlQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292062232"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="292062232"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 14:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="557451870"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2022 14:51:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 14:51:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 14:51:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 14:51:06 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 14:51:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1zQRNxkJb13RBUMo8K+8FrQUknLNUzRkwHgmOTfrBYuvNXtZaIhUWa4R/g6pQYVlRn/9PtKSqqF3bp3igZOYNGrJYczSGbZwIUiNXYraFqR+brR4SQy2WFVgz6bQGdGIcUtl5NufnLomViMQyHG8ju+/AZflRSQoytqOZ7zJazYghWWp/duDOU2HQVq33TnzyJjzC9xsJOrfOCu6dmvsPKrw0WxGlWmL3zEimhyE3HxFjGYi6eTXRv52vIC5Kcxda728U71OHlk/jbsxPHLpD56zxqQftvwIzVwyxV1TPQj9LUUOay2sEJCf0uATB2TSwYkyViNgEJoHcblfTnL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKTVFMb8cF3ixLctUXD1bfyVtc5hQdkbxtnZhiNDvT8=;
 b=O8aGSlV8kQTekSMB2Sua4dWrFvAvVo9t0CVmck/Ev+9DgRkjWLD69NE0PGoZRn+My9OliS/9sDiiXqMuQZcX/r1PDc5To8zzWs6JpXU7tLBI5ubx2wzt6kGPDKzwp1ekigLGj/eh3CmHb7uGcuZ2/eLB+UwrLCW3884oVVyTLkGv9+mMtI0ba9xo58YQZgeYkkGPnBR/UQZQC5MaAuLNi9CV8OWgoRE9qwEyU7oL042gbqUDR2NzXnEyj03Ry3rjFVdnHK/gId2kgmEBeCnEGkvo9dUYntVWjUdKFcgsMWAN11T4dcPI21N8qPGKZxpTaqS2qkyE4mtypU8mi9SmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3978.namprd11.prod.outlook.com (2603:10b6:5:19a::14)
 by DM5PR11MB0043.namprd11.prod.outlook.com (2603:10b6:4:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 21:51:04 +0000
Received: from DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::a186:a69e:dd1a:73ac]) by DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::a186:a69e:dd1a:73ac%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 21:51:04 +0000
From: "Pulavarty, Badari" <badari.pulavarty@intel.com>
To: SeongJae Park <sj@kernel.org>
CC: "damon@lists.linux.dev" <damon@lists.linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
Subject: RE: [PATCH] DAMON dbgfs_mk_context() error handling
Thread-Topic: [PATCH] DAMON dbgfs_mk_context() error handling
Thread-Index: AdiudYBAiI6eUiB2RbyOapwBra/TXwBhfSgAAD0/Y8A=
Date: Mon, 15 Aug 2022 21:51:04 +0000
Message-ID: <DM6PR11MB39788257B26A38FCD9DA4F449C689@DM6PR11MB3978.namprd11.prod.outlook.com>
References: <DM6PR11MB3978994F75A4104D714437379C679@DM6PR11MB3978.namprd11.prod.outlook.com>
 <20220814163234.52190-1-sj@kernel.org>
In-Reply-To: <20220814163234.52190-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5617f48c-def7-4720-ad8e-08da7f0840b5
x-ms-traffictypediagnostic: DM5PR11MB0043:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdfZJjUlalPgMCAZk9sSy2U5ZuelaUCaADpGzrP0LUXpkXDeF3h6ZV2HZ7jCUX4MQ6G/Bz4o6cLIHRhK1GY1hXf48uhCZFZBkqGdwu8nT29xXkXsfGno/gv8wtOuKi33pHsvZ1r4hlPK75q+lJ0XtMFNx/b/MQefbSj3oI6a0B/JNklAd3UxG4VoiJIOXq+1jU0WXkf0h9KVSqeOxRJ7ay8x0ONrRodNGUZ22fUnplGbVPgcFzpQhzWh5V2eAfouP1fgmZkz15CbGbDweiZrb5c5O8+JQIWu/iiFo92N53vNZ5RQHz7jnO3k+Z7aeferwXVzVRaVEKo5ElMTJmvtIO6KoKlYFykiv2b+mzOp8e3d7aQrSsjuhZAdhEbUkpZJSbNCgt65HwVIWAqWeO+ielKwWEcKl3T3CCvDtZbFGPyhnlptU9T/567+j19eGz9zM6c96hTRAMG18B8VogQz35i3f9MEvXfUIYOXWjmFZ0jK9IhCe6Z6ELqS5VYkaXdBHlJz/c65jKYcblKFSsRyDe/8i3zXavg10LofEVXjqFLSxaGN6xOzhRNiCkJNuxrYXiUfCOHEQyY10s/b+r9XUTvaY4NRMOd3px5XgwIEUIbv8iWMyWZNtzqJMJdVNqKan3Ux4miN75krkv6X/cKf1ACdvtFRioe3Bep6NNOlUJtyLda2MmybAStUHclOreUCnwbMzJ/jCPR/qjk9HZq+Vz4jlgNaAHDmQCi0Ai6+n297Wf19m9xh06in7nIRaWe34DspmcUfmnsO+5AxDnvy+P/ExtJf4iehfairb2LAA0b9OVHaBy1xZuEfHM9if2ttF5fKRrQW12yCTk4iV7Z2Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(366004)(136003)(39860400002)(7696005)(186003)(71200400001)(9686003)(26005)(6506007)(478600001)(41300700001)(55016003)(966005)(33656002)(86362001)(38070700005)(99936003)(122000001)(76116006)(82960400001)(52536014)(8936002)(5660300002)(64756008)(2906002)(66476007)(66556008)(316002)(4744005)(66446008)(38100700002)(66946007)(6916009)(54906003)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uX97gyMUuG8F0oi2SEuPY1b8U1O7ai7JqPqvMVeEtpNVcNiYdo8x0jRsFp/n?=
 =?us-ascii?Q?rus3lXLGzIYRHni0p7C7kpDlMkcw8nbYOAxKvbElnYg4ye08zE4jrsz1Ig9j?=
 =?us-ascii?Q?hLV1Mkq/e39on+cBnUzQkweTfbslcMl3s7+cc1ZLMXDvO3IWz8AHZO0MDhPY?=
 =?us-ascii?Q?68yGScnzwZsGncAmxlM2EvjFo4+55eJpP9eONI9+3AmqVnsZDGMwVvpNBteV?=
 =?us-ascii?Q?BaLsfnUGQxK7jmJPCFJjkkyIk+7eXVIVV6rF2KFc0yYOwfgeRXKcYtPl9shY?=
 =?us-ascii?Q?ROsuxwQASQAJ3xcMKJZgS15Xfwea83X5hovFZWg0G3WHtzc169blScELU/A/?=
 =?us-ascii?Q?M+4c0/SZwPK/aW2Z/HhPjrpKwscjMbIvcxSneXbu1Wr5ZjvbdzVJ4r4AMHLA?=
 =?us-ascii?Q?Y4NHGnUzEQO9b0A9JwrHzFuJBxkfOVly6+8uDM0ijAcfgItQWCTlxX1t2orJ?=
 =?us-ascii?Q?QpAwcpm/rvrPaIHjvtn3SLA8Phef2KEbLOdLC6qOSpd2HM88MVnPO6e4sWwK?=
 =?us-ascii?Q?WmF/WI7C7Ul3TPvbYNF339Nhk97ul7jQRi/F9duuips8ttZpJm5Lgc1Eudm/?=
 =?us-ascii?Q?VDVthqA5w1uDL1bJP+pYQUPu4188OithFLlsjYYgQEGxmAEp6Rn2zekEUI0W?=
 =?us-ascii?Q?cdGQbXHieVMsfmJ6dsjmhD2hPna0thyD2iUHEESmSM0spECyh0ps8p2Yxchb?=
 =?us-ascii?Q?0XQ1iXvkUccAE9oUijVZZsw2V0JN6f2tlJwKFhWiKIzcu2M7MbmcgAb9/seE?=
 =?us-ascii?Q?tlOvSMmhrUevM7R4HjfPQcsfQSu21VO53DsHaSQsyG5STlOU6PZIe+86a0Hl?=
 =?us-ascii?Q?mfKsNG/7nGJMgPQDX8PmzvHvcsGoiQtQlAbsMr4/3zltY18l8PIw78+ApOK8?=
 =?us-ascii?Q?30S5snQvdFEHFaP/Vy0eYpf6cNydnTqtcRaGddnyTF2OYf9O9GQrKPVSHakK?=
 =?us-ascii?Q?hO4MuByfccw/nCyZXN4BYk9x/bAzRxx+MK+LozynFgc4lQ8Gc+z7LyS+2lv3?=
 =?us-ascii?Q?0Kih/7VyRLGetPkyDt6f5rQSaBvsA7rlaTspGo6AVtxytswlyrfk4ttDQajb?=
 =?us-ascii?Q?x7GADKSdRNC8rvXOHWjkp3QKnjjkmaafLAQLoSozC8dSMLqahnVaEQHyleHS?=
 =?us-ascii?Q?1UvVKxP16iFprDmwGNEfVBTKC4ilJkiiwzK1BsndBx41G3/ONGlp8qjtgHfh?=
 =?us-ascii?Q?jNDAcAIWnQbGzv/k/NyW/1xA3AtQKpzr9rWtjHPvj703YpwBl+mSkJaz945P?=
 =?us-ascii?Q?I2p9whV1JWhaltnYcn3XhRDprMWyOCs/7fBg89EcEk2Pyl4p47jrAcxM1iL6?=
 =?us-ascii?Q?yMzA/Q3oXbmgRGGDnpRKzmDuCpYiNDJPTPY3/lhJsXkA/UfO9yuRw2SBp9Rk?=
 =?us-ascii?Q?HSP6o59utjklHKsihyN89P1RoCEXCXoOWddl+mi1FLbm3PhvKIC11/u+y5Ae?=
 =?us-ascii?Q?+8+bn3Pf9J9GIzKkGSR804+3vqPlmobAyZxFqgmmr6rrhX/RlEbQV8FvmMIC?=
 =?us-ascii?Q?6JhBFG+gLZY/d9oQ/YQlMyIyatlYXoDCMiGSgRyf7ws1iK7gyJVrwzz5JBaG?=
 =?us-ascii?Q?irYBDcdgk/s4darb8lTAx70VEzQG8NLTzbRZ1xof?=
Content-Type: multipart/mixed;
	boundary="_002_DM6PR11MB39788257B26A38FCD9DA4F449C689DM6PR11MB3978namp_"
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5617f48c-def7-4720-ad8e-08da7f0840b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 21:51:04.7991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7bMhPwMcd0yUToulnfeGSIu0ZgVte4OtYs56lObTf4tmmiomcE3DzQwz+ENIeQmt8BrT2CUAFnGnw/5GisS+tJuYhcUVcD5L5q8ogk1hAqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0043
X-OriginatorOrg: intel.com

--_002_DM6PR11MB39788257B26A38FCD9DA4F449C689DM6PR11MB3978namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi SI,

> Nice finding, thank you!  But, the return value of the debugfs call is in=
tentionally ignored[2].  How about doing the duplicated name check in
> dbgfs_mk_context() itself before the debugfs_create_dir() call?
>
> [2] https://lore.kernel.org/linux-mm/20210205155902.31102-1-sjpark@amazon=
.com/

How about this?

Thanks,
Badari



--_002_DM6PR11MB39788257B26A38FCD9DA4F449C689DM6PR11MB3978namp_
Content-Type: application/octet-stream; name="damon-mkcontext-fix.patch"
Content-Description: damon-mkcontext-fix.patch
Content-Disposition: attachment; filename="damon-mkcontext-fix.patch";
	size=858; creation-date="Mon, 15 Aug 2022 21:49:53 GMT";
	modification-date="Mon, 15 Aug 2022 21:51:04 GMT"
Content-Transfer-Encoding: base64

ZGFtb24gZGJnZnNfbWtfY29udGV4dCgpIHNob3VsZCBjaGVjayB0byBtYWtlIHN1cmUgdGhlcmUg
aXMgbm8gZXhpc3RpbmcgCmNvbnRleHQgd2l0aCB0aGUgc2FtZSBuYW1lLiBPdGhlcndpc2UsIGl0
IHdpbGwgY2F1c2UgZmFpbHVyZSB3aGVuIHdlIAplbmFibGluZyB0aGUgbW9uaXRvci4KClRlc3Qg
Y2FzZToKCmVjaG8gIm9mZiIgPiAgL3N5cy9rZXJuZWwvZGVidWcvZGFtb24vbW9uaXRvcl9vbgpl
Y2hvICJhYmMiID4gL3N5cy9rZXJuZWwvZGVidWcvZGFtb24vbWtfY29udGV4dAplY2hvICJhYmMi
ID4gL3N5cy9rZXJuZWwvZGVidWcvZGFtb24vbWtfY29udGV4dAplY2hvIDxwaWQ+ID4gL3N5cy9r
ZXJuZWwvZGVidWcvZGFtb24vYWJjL3RhcmdldF9pZHMKZWNobyAib24iID4gL3N5cy9rZXJuZWwv
ZGVidWcvZGFtb24vbW9uaXRvcl9vbiAgPDw8IGZhaWxzIAoKU2lnbmVkLW9mZi1ieTogQmFkYXJp
IFB1bGF2YXJ0eSA8YmFkYXJpLnB1bGF2YXJ0eUBpbnRlbC5jb20+Ci0tLQotLS0gYS9tbS9kYW1v
bi9kYmdmcy5jCTIwMjItMDgtMTUgMTQ6Mjc6MzguMzA4ODA2NDMxIC0wNzAwCisrKyBiL21tL2Rh
bW9uL2RiZ2ZzLmMJMjAyMi0wOC0xNSAxNDozMzozMS42NjExNjMwNDggLTA3MDAKQEAgLTgxNyw2
ICs4MTcsMTIgQEAKIAlpZiAoIXJvb3QpCiAJCXJldHVybiAtRU5PRU5UOwogCisJbmV3X2RpciA9
IGRlYnVnZnNfbG9va3VwKG5hbWUsIHJvb3QpOworCWlmIChuZXdfZGlyKSB7CisJCWRwdXQobmV3
X2Rpcik7CisJCXJldHVybiAtRUVYSVNUOworCX0KKwogCW5ld19kaXIgPSBkZWJ1Z2ZzX2NyZWF0
ZV9kaXIobmFtZSwgcm9vdCk7CiAJZGJnZnNfZGlyc1tkYmdmc19ucl9jdHhzXSA9IG5ld19kaXI7
CiAK

--_002_DM6PR11MB39788257B26A38FCD9DA4F449C689DM6PR11MB3978namp_--
