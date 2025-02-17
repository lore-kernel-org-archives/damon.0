Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213C155322;
	Mon, 17 Feb 2025 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775703; cv=fail; b=T0pUQPNxtSOC/q6mol9pB8Es3Qzw82YAusTQvtOFh0p+PTw2P8Qk51hxBOHF68WinZXpAST9F/UxYzGGq/TvEclgOxUvarkeNl4OepepIkSD8x3O4Cx4utmnxnN8uKLP2qLdtgTuolla1OQowznraW6i3698AkbqnElqiJGwlNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775703; c=relaxed/simple;
	bh=1ayfZ1YuX+UQdfuJzl1X72oRdqusFzuWIYQ/2r4+Esg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EWJRbjuzKF8NySedgqqzGaoFvN9HhPqvbfmHdobcu1IXQLhBuucq0oXP43ZDvBnKES/7fzUrxuKOTujnjhwRSwZ1GZj8FdKkZJTbzzA0tGqUw31uKE/lwTiSK5zGvpKj4H1xf3Z9gwaKyDbZPvZDRFHaxciBdiaKbcHVchEn2hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwIu6DRO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwIu6DRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739775702; x=1771311702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1ayfZ1YuX+UQdfuJzl1X72oRdqusFzuWIYQ/2r4+Esg=;
  b=cwIu6DROVZsGJgTEcFbl0nWcWeWG+f1N1HtkVD/IsKO1wPZPGz8lZjZu
   ficH+l9epj9VJ+aFc+xsHh3oMQU6jWDnfP7DtZkbDKFJ/W1lenE40TbTq
   bM3la0lNAbTP5Sb65F9ovswo+VqFMx8MXu5UdGdmkYza0+VlScm9zQxYC
   wT4FaX6X4GwjcCf77ifgZMJgXXBbPZ1+lNvlwd6qsQ1XAtEWJBSIOj+yq
   3GA6M1CmLkO3SA/iXxPOWtxbdOp1mR0f/wS8vAL9C/lbWdRk1y3iIpxJp
   QHKHsTB5qCg+t4RQGC+O9E6Q8RYjvtqWlrXjsw1Muh7npxN48+ir6V8u6
   A==;
X-CSE-ConnectionGUID: 9oXWz6DQRN6VLprcskaZDw==
X-CSE-MsgGUID: /HyBvq2sTg6ZdMdz91peKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="44207590"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="44207590"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 23:01:41 -0800
X-CSE-ConnectionGUID: db1hQdvoRtyskOH4jS4oJg==
X-CSE-MsgGUID: MiJb5tLbS72l/Ve6w0r5Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="113779817"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2025 23:01:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Feb 2025 23:01:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 16 Feb 2025 23:01:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 23:01:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x79BrUMXvx2WbD0iRNDdMk1jnTBbmRaBQ52a4pf6j8s9zOgWuAUOY466pEJmk3JY8efexpOAy8x8c9OizrocCOkXW1X9ZnQTIXLkRe+9SC04mIhzpg9SHBTVNG16xPGU8IfuUg2GpnuCqZSNGAj56y9GAmwhjcvg9T5LpS9h0IZpAycRcNHTAZTDwRAfCuZs2FuE5p29h/ndTsLYlQH6aZkWZclGEF0Ce6Uzj+qC3mVzIGzB0Nd5j8rZNcdlCQH/kxseOHFEgE9i+3wbKdJPa4GsdfIavLQJVdqzYcSRfKx4wXS+CyU1KdJa87gBgzmQgftF3jSzOziQR0RQS0U2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ5eOrDCHhTNHlNKlXono5UirOZBMKZI7uVRBo8syhg=;
 b=sVqxJc8x849wuRXDVJKiVqZPKthAQcajr/fQhcL7zybxd7Of1w7ox8JyEVJtc0nDlH+qDzTXMY8BKs2MlwzcoDKF0Wsun6ooLRgYIClcgMq5UhrCClOkiCa346hlGEWfyQjf5HnN4i/jPIf8Tqi13O9YdUXFQxnn4nK2VXmvN8etmMXuoah5fHzmQJtgY1gAAO/eM/vOLib/Rylq3AVsjL1woQpbaJuAGJPj4jkhAudgcfDTwy6KTEJxy/yO2LUXxHncqt5dRZJvqGIinahB2bXD3N4CCKuAlSrnTGu1xG+PBoSs/bWzTyzs7Juhb5DkP5aOZxX7sBC2VzSkslR5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7473.namprd11.prod.outlook.com (2603:10b6:a03:4d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 07:01:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 07:01:33 +0000
Date: Mon, 17 Feb 2025 15:01:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: SeongJae Park <sj@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm/damon/sysfs]  9a5aa3349b:
 kernel-selftests.damon.damos_quota_goal.py.fail
Message-ID: <202502171423.b28a918d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc7ef27-6774-418d-bf32-08dd4f20e95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vqHix3ANli/SCNo9fufn9tSjRGwIFVqXYg2v/IYL0TUDxEDVU/weRBzqdhA+?=
 =?us-ascii?Q?8JFLxXGDCqVIRuqrcm2IVmKPprUUsD5wE0O+TDIBAqs0ArwPRemWe7mxH8YO?=
 =?us-ascii?Q?EF9u6tKTbHXTHOsKMGC0+4oqvJd8bLwBjW1GqqIunNb1uQCNlfkvB+HP106U?=
 =?us-ascii?Q?5p5brVN9gQd9S9RHy2Zj7RJZlZF0IRSuy/8XaboZ9reiIu8if+p91X4seOPY?=
 =?us-ascii?Q?vX8tTJAHldw7ZWyDEIGl0tTVnz7UrHNbYldLQ93AOPG/imKwab28TTuIogcM?=
 =?us-ascii?Q?hb4B2DUgZfC0zNzQfxTdQ4uxBIGROLmXYHs2CFH6ozmtO6cHuVaY7dfMM572?=
 =?us-ascii?Q?3f0N6h7b2raisVBNJS+IFJ03RXed4H6XqvCKbNRqfxd8AneHckDl0akkxu91?=
 =?us-ascii?Q?FErVGzKUjluvgCeofJbq7AiMch1nFeVn/0ArXEygPeCrgMitS/cG5FtTQsPM?=
 =?us-ascii?Q?YbU1QZQwnyS9w25ekWQpjPAhJf3i9o0OYaoWlDnaZAlFfjf2H8ts9ih+4pLr?=
 =?us-ascii?Q?BcyhlNDGkx+IOWTpbnEHsxaskGt8PtXDIr4aq9z4GLokeHKfuS9yCvgX4KNC?=
 =?us-ascii?Q?QLcaF9C6JypQkOkQripeJzrHYsnELoJVS8jO8a82T49owZjrmfpDFUB7I+rl?=
 =?us-ascii?Q?VgLtZ2vSl8GQtCJqtNUVQyovAOO8WBmkNHBLngmx6ph+P2gCRS3zqiYxqZYE?=
 =?us-ascii?Q?jLcCxnQ6uZcrUd9Fm/gtnC3MV/EkXURjFW4zEh3T0ae94klqkdsp9Nl10vNl?=
 =?us-ascii?Q?rNFvxPaCMND1owxINcrd5/M9oleNy9BYzYTNP8Jv1r7LI0i2ZTzmb6vlT8K5?=
 =?us-ascii?Q?NO7PepbTOcqqcZZYji35BNlAIBpOlsHwnb9KxoFXZD4rH8V4Rz8nO5bl8pHq?=
 =?us-ascii?Q?gj3AFPVoDITWcX1l11RJ1T+ddl6ZGIKcZHVVto3P0UQXXBhmN3MEkN+1R4uB?=
 =?us-ascii?Q?/5gXt6laXCG2SRboesEFNUCxTLiEhIhz8TIVwX29rtcDsmfGW99rnAdzrNz4?=
 =?us-ascii?Q?xGQ8JxVlpzijFzcmHq5JnBNfKENZsBAwlH4SeE/sQtM9fG0fJ+VmWYgev1Eb?=
 =?us-ascii?Q?kbu+qxE3BFdhJIqNw3Yrdzv3QmrituMmTwXcjbLRVGYPKg6Wlm0epa3CF1pK?=
 =?us-ascii?Q?6Y3fYA8XdVBwYPH0ew0NVfZwp95vlmPvMlRf70rT3dded2aI3e9bfD/jAy/I?=
 =?us-ascii?Q?B47t9uV6u/g1QU9f3qiw2q78wnsrFyqs0rlbpK3J9FNsZZk4A7NEaZtxjp3r?=
 =?us-ascii?Q?wrLQXsy32dFCIWiMZcRE2yJc+lPG2x0TFso1NnPh+uy9gtnAh3LMU+vauKDf?=
 =?us-ascii?Q?g9b0Qq5UvBSsI1yaNFbTufRjpsC6E4Dar/9v2zWlBynxuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jF4G7ZsF0ujmkx8pZ5WJPHmWlJNP8zL/F/5V9UuNp6IABhKAtszvboLs6/Vg?=
 =?us-ascii?Q?nBJJL1qav/hJdwDrdvCPdhYNMgHp+1GcpmTTZ48KTpwUI1ZX51AHg25k8tfz?=
 =?us-ascii?Q?OxgM44LKsZE8BAf5PsqoW6klUZH85jYUdbX0GtX0DO2JIWPClwoKHViVNWYi?=
 =?us-ascii?Q?xP+TWNTFbjz/kXlTQ1nZI2zyTb3EQYda3xQVBRhXCeJrXCN1k7sAtxe2Bf5G?=
 =?us-ascii?Q?AeCkgicG6VHaOvA+jI83iItz7S9kgGcC1ZvMVp+cLwDphe1qizOK5SlwD9ND?=
 =?us-ascii?Q?HWXEDij9wQbRVIhnjccuBROJSHswkdtHsYLL8SSRNi9GzLM39RFRBDvfclGh?=
 =?us-ascii?Q?ktIT2F29DftwT7BOLKLqn1O/9kJRlSTSBc+p7Hp8qpRnB3bv1nP5eftW7V6X?=
 =?us-ascii?Q?3d58RCZyIawE/QfNusDcuQGp0oeRvU0XGawmDEQbQ6jv7oD4UkmBJm/wQNRf?=
 =?us-ascii?Q?ss2nkSCaLb44SzzOVWLQ/4UISrs95rg4KJNmi9oFVOlRpfxWgrH8o15lppi1?=
 =?us-ascii?Q?sbgjkMZQuGumnG/MMj6rWWe7lIBGnalj9HIqV164OprsyyUIEjdtJLadJIah?=
 =?us-ascii?Q?PHS0PwDsXW1TUwh7B7ehOx7Scu2qSIEymmQzHAyYZLveBoKbMs5Ftt70M8id?=
 =?us-ascii?Q?dXuGH5RNvUDqpUZw11eG65OTwGOQC+SZk3qJfl3NLNPRDuLAfxbn+IaJ+CpN?=
 =?us-ascii?Q?v7A22GPp50ljS+0EGqctyzCFQhCHrQwQesXso7nCyqbRDp/2mTQtKHipiST7?=
 =?us-ascii?Q?kFIh8vnYxDoRtecLTauvk5X9/uiUlwLs9wQO3en7BANzZTXnC1pQSSsRy9V3?=
 =?us-ascii?Q?ESXl+pwzR6ZxBaB3b87EFjJgrnT/jGiqMU+f04NPfHyUbBjbBdfJWpPwy3OK?=
 =?us-ascii?Q?Cd3HBViWbhFglgU4/dPESLS/2SqgqtkQ46OmhSLA4bAYHAVvrB0RBzBxKSke?=
 =?us-ascii?Q?/p0IrAV/1gaw4DBqGKElw100uHBS/A8wWvXVXL1/I/oFipxvBGmfEGsTHj12?=
 =?us-ascii?Q?SJVVJZ7uvfVne6cyM0/a/b1TT42VrNh6p2l2B8Wz/72gxS6TtotxHa6MjdZT?=
 =?us-ascii?Q?UeZrOv/cnn3PtCBKqEFY7/2heccsOWeNHqSzB8u6MjNy1ykwmAFbbZ6FnyN4?=
 =?us-ascii?Q?Ow4UpYo6h7ximoRrtY+wLZiv0CPL6/uCXUtwpODNM6DDKQtuQ48T5/sbNY1/?=
 =?us-ascii?Q?9eyNFpyWIzQjUFflJAJFoUkHsNbJUx/fvxI/ty78esxfoTm1SgXvUIbuZVTi?=
 =?us-ascii?Q?ArrT8oqFMWHimhJbVtYbRGeyOmFZj2rdGd8a9ICt6+NJr6Nk66ouHL724ZD2?=
 =?us-ascii?Q?cYjLAucVkzjQMxZQP2NV1acV5vfyjZRd0jWhPE+0AQH9Ja9HvdH36CyL7Cjm?=
 =?us-ascii?Q?tb+1t5SunNg29NP+qahCed2ChIN4CWFJCOHyB2YRSLN76wOw3YJN7sVeTzrd?=
 =?us-ascii?Q?lw4aJw9S0SSwN8xH0nJOwRQ3eC3OK9hmrFKlv0lbyMJfKGLwC31VCabR1/3F?=
 =?us-ascii?Q?5426k3L7wYKidtp3FkJJWfFjM1/qYE77SS3TAOB1cVe/uM765Lbmc61AwnKW?=
 =?us-ascii?Q?aDjkQzTWPWPM6ny53cJrhyyIwWXv9QoCAyn8k+LVeJwWYaSfxrDGZBRT2/Fz?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc7ef27-6774-418d-bf32-08dd4f20e95b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 07:01:32.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt5e41ps5fsg4TkN1rCh7ttjVLhens4Zg7nMfooFCdFQNTjRghqpgtyM26JkDdvKKCn0VsQlvlZ4gR2Tz3oYmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.damon.damos_quota_goal.py.fail" on:

commit: 9a5aa3349b9428ae451b22c331d0d9a9cfc7ac90 ("mm/damon/sysfs: use damon_call() for update_schemes_effective_quotas")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      0ad2507d5d93f39619fc42372c347d6006b64319]
[test failed on linux-next/master 0ae0fa3bf0b44c8611d114a9f69985bf451010c3]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
with following parameters:

	group: damon



config: x86_64-dcg_x86_64_defconfig-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502171423.b28a918d-lkp@intel.com



# timeout set to 300
# selftests: damon: damos_quota_goal.py
# score: 0, effective quota: 0 -> 16 (-1.000x)
# score: 15000, effective quota: 16 -> 1 (0.062x)
# score: 5000, effective quota: 1 -> 5 (5.000x)
# score: 18000, effective quota: 1 -> 1 (1.000x)
# efective bytes not changed: 1
not ok 7 selftests: damon: damos_quota_goal.py # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250217/202502171423.b28a918d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

