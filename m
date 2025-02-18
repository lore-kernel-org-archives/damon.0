Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D013BC35;
	Tue, 18 Feb 2025 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847221; cv=fail; b=eZxLoaIPwXbRb4Go773MElbhrQJUIhP64cSWWoKuLMPQtB/tIC5/nw47hNO9+Ua+DpaGmrjrziGAMl0qiO57lbb8AdEgb1vNFGHGH87L4Ev3aW4MybmYR6mX/TQHs8jSDXPGJ0S3D2l7L6D/aWt9ipCmvk70ORUiRi41Mp/OiVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847221; c=relaxed/simple;
	bh=JmB3zNUhRTHYc92TtGEFY1GqJd2NdZc80oNdcs3NXE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RLJHBcfy/9x5VLUObcBPBdRalIY0a7/t5zmZos3bAxa5HOqrQ1Hhl84XovGOICFdQAcloyO5aMtAI7yWVS1badqVuk2Zw8gVhkEYYLjdjB/J65R/KU1E3rvdlkwDRjwauqjdyfFESjaL204bWbJ5AityzuVS1vM9JOIZGKcORJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZP69cClU; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZP69cClU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739847219; x=1771383219;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JmB3zNUhRTHYc92TtGEFY1GqJd2NdZc80oNdcs3NXE4=;
  b=ZP69cClUJn/phcxNkrK6FDsgwaoYwiBOH7G9owdQLZlztXvaIj6DizHy
   l918oL8kqDB2xBMJoJiqCUc+0lStC0irNpPcO39L7RbI+ye+yl21oQSFD
   q7k2Lqcg9DL2VB7jOw0eBdn6Y+g3VOx4GnPZI9upCE9tdMd4JdiG1wMeW
   F10qm+qDLBSBB1VGrL1vOAj6EL5Ky6WSlaUhzvoWFRP526WawE5dSc4io
   +skKF1YYnUyfZJDWM0Q2NAs+ifJxWzwVbxerEDdtJ8uoHQ4FKJvJ6jLlq
   bfdmk3J/WNE2dWvK2b2FBJrofkDKGe/MvYZ2q1/pT8V6l1dvPJDzG0uI9
   w==;
X-CSE-ConnectionGUID: zRVcCYlZRk6DQRCqPvjDjg==
X-CSE-MsgGUID: iuKuVTgLQyyerlQBdSxODQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51173650"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="51173650"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 18:53:38 -0800
X-CSE-ConnectionGUID: 5NnB/T4XQGOy8v3wGNpxvg==
X-CSE-MsgGUID: 7xg3WkZ5RKC1TAK6VVH3VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119473923"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 18:53:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 18:53:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 18:53:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 18:53:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqabvCKrL2KbH9YvEE9GlRjibbn4geqDiUiZoselzF5r02vUA0xORp1UObh1Wxp85VqG2j/+0fdbV4ofDxJJsWajW3Ql3F/atsTz/oAeTantYosWn44SggggNdop5PPpUN8VSpwYzZvEF8w37NrDPxrZKk3pQc3+GOLVDzC/g+uAbAudR7lc4RdBncTHVV/9NcN83jGFokp5YLc0Sb51LPM0A0y2BtjEs2pO7pi/quEYXREUJlN9CGV6qdbtnF+K2vmUAP+CfQNjkSqwumGmYyD03NanMh+sRuWHV4Gx7uhb3iUyBhP4aqoHdIwkuMRaX4RvbYmVRe3ZIeGJyeSk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0Ch+d/MFLsELw4dbzoluOIvz4zFzxAnTVosEsIyO/Q=;
 b=y9sVusAFPzLvyG8yu7O0lI+BUUPKYGG3wu93ICE9ag7t7YfzBWzM+CcoXUW5O9XIr1aFCJEj083Q7VntOeQwLO3OHYJd/mYXrbtvbiHIko3eFZ2qwe0puNOhXGDBiXfg/A1Qb/qBBIAnPp1MaNpopXPFaDLe3ShlMKBYC5kllYaQSWJ7Dw616XtgASljMxQW30GYNb0XdyaU10MWT/6mMCx51V9C/8a7vJB2yX0tYeGRmMvJ71p/C/J/Q41C1ujivHO1OkQXfqEmb5a36arF5MA6RMxQRALafeVH196i9FMkpDz41903fEoYj3YM8dPBQA2hfOtn19DZLgtl0d6Sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by SJ2PR11MB7475.namprd11.prod.outlook.com (2603:10b6:a03:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 02:53:20 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 02:53:20 +0000
Date: Tue, 18 Feb 2025 10:53:12 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: SeongJae Park <sj@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>
Subject: Re: [linus:master] [mm/damon/sysfs]  9a5aa3349b:
 kernel-selftests.damon.damos_quota_goal.py.fail
Message-ID: <Z7P2GBp9JWLfn2zH@xsang-OptiPlex-9020>
References: <202502171423.b28a918d-lkp@intel.com>
 <20250217182435.45244-1-sj@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250217182435.45244-1-sj@kernel.org>
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|SJ2PR11MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b4cb3d-4735-44c3-9057-08dd4fc7671a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UUXfjmjaL8S7E7Osh6XHmUwoGgHaQBZy4yZeV1l5KmpahCLaV2HcEp+/xDd8?=
 =?us-ascii?Q?jR2kFdz6Y96/5TIpxsRmuQ1vjWttAESkZtr+l3CesVQhcYfIwV9bN//a/cmr?=
 =?us-ascii?Q?ui+zzhogZBSeW4MGfQ98jHehTMmcl6Scu+tATkaneHvh2INiY5+QkWREmLv4?=
 =?us-ascii?Q?fXgb+o4z3Rtl1/VpSyxJ4UXwQvLmN+LuUMLFOAIeAXq9qOy/3DRvLtLAYdNC?=
 =?us-ascii?Q?B+olyd9b2PNfqnZZXjGU8Clzh5HWicTiIfY3irJsfMBo0jBIoQlyuYOGA9Ep?=
 =?us-ascii?Q?Bnuu2E2xc2XRPe4magAHQCpNVgQeF823cAI6O9MuoRLxrid1RNGmKAO8DqRJ?=
 =?us-ascii?Q?gYUEr+bMOSFgYeuA6OJV+6GCR4hHKf5+VacDzyqmrsVbxiGcWMYwIsBM3kCb?=
 =?us-ascii?Q?P8LQVwRBhCqB6eQyBljL7e/m7QC5ZDd2uOMzAsXQ/Nw9j9uXoXa9ZJSnO0/+?=
 =?us-ascii?Q?8qqj4WqdedH6yDwl1rdnrZE64Kj8zeLlC99AhM9FnZU5hJE24EoP/J7SW9ED?=
 =?us-ascii?Q?WCqLPJoPCYXp5mXE04Dripk93+la004iW7RH8qIiPkwN1ZPeABsuO1E/Z0kT?=
 =?us-ascii?Q?OSpCPqkZH0NFuoO1S/185L+J2kOh5b1N+Dd9yspXr5gbJitmGgLLMhuO/ndu?=
 =?us-ascii?Q?6DfhoGkVy1JIgtEatGio3ouPQpUKehZYvmvWU7kXERrLSVgNLxkPhuA/jOP0?=
 =?us-ascii?Q?MQ3zwkAuWEcj+RE/1j+9qsvBEYUVMCl8Yt2vP74aLgjcJhnGqKxhDbltnds8?=
 =?us-ascii?Q?YBAfAdl1jb3vKebzltOcHOwoHXxgYyB5Xw+Er+FIXi5CJUT3sxFTQhEZvhho?=
 =?us-ascii?Q?hwLkAu3nwry7inYe9widwa3Vb8MguEe1mA1TgKIrDe2v0RU2LFQp1cdOiRnF?=
 =?us-ascii?Q?meTKZTnE2zqeCCaMCSCimrmN/hO5TnGZRkEo6HnPXSqOlqXLW16RYrgwGci3?=
 =?us-ascii?Q?e/01aHvJIORDeOIqKSpFPHgfn608nlOcEDPCelcvgXf4sMs118iFDBGXMzQB?=
 =?us-ascii?Q?Mqoeeg6raJ6VM+R/TL2kGSo1UbkgV3ZiPw1ge2D0Eo+OckJ8b+1iC5o1ylAX?=
 =?us-ascii?Q?r1NTcq8MHfUShANqyJChPAhdJ3LWgwWiofaDMp43lUeUaXGkQepAVjBfBSTf?=
 =?us-ascii?Q?tsduBYg/nv2SkLMHhf8XKlqYFc25U+xo0cz1FqxrR5Ado9mS6fk7kNAyf47K?=
 =?us-ascii?Q?IP2xwjmJq8v5fgKO0PUnqs2qeBB+rU+ZEMFwuethGNG16p0VbWcNYva0qbsj?=
 =?us-ascii?Q?WnMgEjmnEJjd6lXculGP/OYq/hBoui7jo/6fdXg1EW89VtI4AJo5iTDjqiC6?=
 =?us-ascii?Q?iOCGDmsVIuC7PmgRP4ltwJukZun3bXniBJCBzNpXg8ELFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pTvvbw7kJ+jVxSYBDsuA0sPdNIeSJmGkn4FTY33N2p8vfBA1d/Rwnk2+SBxY?=
 =?us-ascii?Q?ndTuYjsxh4XUsn+qH/oCkNe0txSOCEdZYIrYZW3Cx65Lr5zgH1j/JkcroQl4?=
 =?us-ascii?Q?Z92By3qtGCMCLCB1vp/HY6X1QelMYc4HrZ7dnDhpcsZWcKeIOcZJvVrQv49B?=
 =?us-ascii?Q?7hYc0b+IktxhTMgEuFiNFKHYB5rLPvAE9LfrVJTY8eUwfinzjMaxoc7fInLW?=
 =?us-ascii?Q?W27QPd1xEKnGl5VdH/byf9SdmRRtLHgrp7zBb+YqEumiTzUWQ7pwotgiHU6+?=
 =?us-ascii?Q?mYONWnXKJrJoZsnm0EYdnJG66P7lenNdNlaRW06C+63EwoONGQxZUhCeb+yC?=
 =?us-ascii?Q?itxCIhWPdWUNoiN0vGzaY3epuaa59Cj5nh6U1ZU0/4tuYrFoTwu0OQuEQ8Gl?=
 =?us-ascii?Q?sGwJlHCtCzr3CMcPRKmG9BywIRUUnMjI0MqeZHfC/8irIKEXlkNkvo7BfkMH?=
 =?us-ascii?Q?iOee3rBlbqFzWpO9MEccHBF6ze2Z38bwMQEoQ0HKzlD9IJIYHJv8I/MSpcq8?=
 =?us-ascii?Q?hKo6OGDj/7iMRuuCXACg/4rZmKEUPS3myaOloSZAjlxcJew/Az+RYAGy+7at?=
 =?us-ascii?Q?tctza2M20Hzlmu+M0tfoqi0YzQcXomnGkvaxnlvxXnkRAzGJkpna3xkZtfNx?=
 =?us-ascii?Q?U8KclgQXsALfU7hNAtKpfTphB3cxPQdZdXAC8xY8/Gl1uCya1TmlRGak8g5t?=
 =?us-ascii?Q?4p0/LxdP+mAl7wGbE+SQ7VKq+zQT6/3yfhkmWGoyma0nypy+8E4KRq+rf8z3?=
 =?us-ascii?Q?Ph3zO80qOjj1KHKKdyPHFsHNynYOjSi+9Vy76sEmV5GIzhXRNVkHpXr6NkyI?=
 =?us-ascii?Q?J2vRZ9wT8eNWFnTu0oql+LgtZ1TL+A/iK155emOb2RzpForHVgTU4q4eRRGD?=
 =?us-ascii?Q?ae/LY/RdlSPw8lAfrjXf8fjuQ7bw2hLVoXWr4UM3NLi+5DP1fgBv1GgpkWSG?=
 =?us-ascii?Q?xJ1LVsrcEyrx0GjYLHxQy5InDhr7U6OHTQEcxgfU+0B+IQHIHS5hv/LLJ/nL?=
 =?us-ascii?Q?n9U4CnL7UOrWYa/KyLz/H6HhAenvwj90wf0fdfuULkyRjz/l+K1edBLnzUXX?=
 =?us-ascii?Q?g1oMqTlFA2EdXX7B+sC8IUp8X4Sltng1aKAB6gD4VomQkLmFMLM1qjmWnL9R?=
 =?us-ascii?Q?5dllks+afUz3V0WVU+ntpwl3XqLvtsw1xb4+2sHvX9BBJh5th3X/nc4WewSA?=
 =?us-ascii?Q?NZqoSYBsnxULCZ7SEh1r7nFzwsv7fPXfIDVc6LoaxJva/Q+16uTawsvIn3YW?=
 =?us-ascii?Q?ut4rWuxPbyp6pe4SJ4MEhjDBqHQOaUkiQuadEVHvemLzMhF+7E0EB1L6ehyQ?=
 =?us-ascii?Q?4ui/F/nXA9byTwNPASrRG+7JNEkyba4k6Ojs/ONud7b9FAC+6OgjvGqqX1ho?=
 =?us-ascii?Q?Z1iAIJG13Bx93vksZQXt4hRLoHJt1ShpQLVmOBe4SQOQ79woqmPLmk3/k0Ht?=
 =?us-ascii?Q?rQZ/0x5t4WiIKdwpeWsftFojIuatveD+TIF5cIGgSEIQ+Bi5MoaGLwii/gfU?=
 =?us-ascii?Q?VDa53XphYNWVrRWlsTqhXo8wdofSSD3UYTFUG+l/DMzMW3Pa9Uh7QvOy6c1S?=
 =?us-ascii?Q?CGAvSM1ABDzc8QY14hqzX2eu0QLjP115ynGqO61btqWQKZ4Xj5tl5sLSg729?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b4cb3d-4735-44c3-9057-08dd4fc7671a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 02:53:20.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfbh12p2jmqyTXYjGkJaoyqe/nRIPIZPn1q/nkSuDkDLBuB4pzeMjZ+5Riu7gIoe7aakLenko6hPgjkwHrUcUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7475
X-OriginatorOrg: intel.com

hi, SJ,

On Mon, Feb 17, 2025 at 10:24:35AM -0800, SeongJae Park wrote:
> Hello,
> 
> On Mon, 17 Feb 2025 15:01:23 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> 
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "kernel-selftests.damon.damos_quota_goal.py.fail" on:
> > 
> > commit: 9a5aa3349b9428ae451b22c331d0d9a9cfc7ac90 ("mm/damon/sysfs: use damon_call() for update_schemes_effective_quotas")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linus/master      0ad2507d5d93f39619fc42372c347d6006b64319]
> > [test failed on linux-next/master 0ae0fa3bf0b44c8611d114a9f69985bf451010c3]
> > 
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
> > with following parameters:
> > 
> > 	group: damon
> > 
> > 
> > 
> > config: x86_64-dcg_x86_64_defconfig-kselftests
> > compiler: gcc-12
> > test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202502171423.b28a918d-lkp@intel.com
> > 
> > 
> > 
> > # timeout set to 300
> > # selftests: damon: damos_quota_goal.py
> > # score: 0, effective quota: 0 -> 16 (-1.000x)
> > # score: 15000, effective quota: 16 -> 1 (0.062x)
> > # score: 5000, effective quota: 1 -> 5 (5.000x)
> > # score: 18000, effective quota: 1 -> 1 (1.000x)
> > # efective bytes not changed: 1
> > not ok 7 selftests: damon: damos_quota_goal.py # exit=1
> 
> Thank you for this report!  I just posted a fix[1] for this case.  Please refer
> to the patch for details including the root cause.

thanks a lot for information!

> 
> [1] https://lore.kernel.org/20250217182304.45215-1-sj@kernel.org
> 
> 
> Thanks,
> SJ
> 
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250217/202502171423.b28a918d-lkp@intel.com
> > 
> > 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
