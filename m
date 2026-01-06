Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1889306B11;
	Tue,  6 Jan 2026 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767681704; cv=fail; b=BlR7UGLQVlRhgcaq5XPiLUjn9edsUyvtv+g5KuWc0J5UO2nCKIcrPhHmCwZUQlvEA5Tnr8TtSBFUa4+hmQvpN5pXrYBtVCAULf0Drc8JnePMIwSrLAVulGYJrcs2ULFQXd/vIVkq+qKj0AMiqoWoWXRzM/2j7m4TtcP8tcsBLpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767681704; c=relaxed/simple;
	bh=gdr2Q5y3Z7pjsUlwKtFmDbEudQXQ+HDI9jEt56iRCGc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=czNyE7kapb5MRypL49RWb6gbdv3+4WEnHF5yFFNFD/pqo8duRByE1E6WnMn6RRBMYBdWiNSQEAqlFh7lv9iZ9RxsO2IXphZB6AwpEb76Va76Xw3yhFSpPm8YKkfFToxQlWiw7kAvZ4SpFyw/dzXF/vYp4W+xC3vBynZ8yn5QoyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDgQr6Ox; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDgQr6Ox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767681703; x=1799217703;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=gdr2Q5y3Z7pjsUlwKtFmDbEudQXQ+HDI9jEt56iRCGc=;
  b=CDgQr6Ox0/RqW+tdHQIKN2/Xk0sl8kZt2vaVQ6h8af6EXEWDSgsfD1gO
   9Z6GUP7yxRT3pkFSrgdPT+ETZwVTTZNmEpVaBROC4jC0UGAY9tfI7dEXE
   EyQwu9fAcCHDrc/oRxDwDZj1K9xAwaaed/jSmv5pFAnmlPqCYKVGR/mtp
   8FzOndCaPiFsPk57/BHfV9ke7lzEL1E/3aCYJhdnanx2qikO47ti28zh7
   0KpqECPmCOlgX46V5rKzagqPVbafFrXk2ctMtfe6go8cDE8Oi86ImanMv
   BaRLSPQyuVmSE2lGac6RlMCDxQVrIFdVbA9O5zaaXMs/z/G+Hw99r6RA5
   A==;
X-CSE-ConnectionGUID: NoTfYvxyTdm/LEWqLiaetw==
X-CSE-MsgGUID: Lv5nT0yYRMal/LAqc1sgpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="72677302"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="72677302"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 22:41:42 -0800
X-CSE-ConnectionGUID: /O/GG21iRH2OgcelFoYz9g==
X-CSE-MsgGUID: E3rxn3uQSEqTBB/hgclxhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="202205447"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 22:41:42 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 22:41:41 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 22:41:41 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 22:41:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6I7sgamBJYXr9Wa3bEnVQpgs5xYvEO6sGiuXJscsv8+vYvZvgNfVLM0qlczo8Ay+HklxmzErUFpRm3rvWFUPBp0kyOmzQOeszlOsFH08Tsk4aWZm2S8czWy2q65FKhMLKEGj2p1mqXiyeb3P6sptoFuwLQ+M3j/OgE17xinayq3RdfvTEvRTChDb8a28hr63bakIt09y1KdjZ4a/JpUNi7nJAS+iDUXj8NpHVjtkuGamHLYyyvunC/fdSj+X5yBauc6rWSuWK536dh2V4H8hUYvIp23yJrMTAmzIU0pGXUKzy1sI4VoFEcLKf3FRzqaSh+DCzTLfRa+PslliuxHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lTd2dWBuJXrLeXKkUZrQKACrwlEv213S2CmxjwDenU=;
 b=JpJllOMMiyZevRSklU0v4dINmkpAl6QaY+0Pkxwgly2hslNtNw2H6f/p6RKFlqWR01YxvMqyPJ9YRDwP+CEr+x6suQsiGoXfL+2quDIuaB8vu4yIMe3wqbhg32LJs+LerpGgfxvTQ7f6Cma5mA3gJ0BbiMWyNu0FwTZ/8dZUOoSt77Tk/1vO2GzCHyw8sXT1mHDEaK5tFpna2iFaWxmxE7EtNLwdHliNldSSf1c88laXAdD44s27AtYhj0m5bpYPucMua+ezW56a5Y2DxkngHL1HsFPYayii2ehf9mQ9MhKpkROBNMqWjgDqbvdUHM11f5MjppBOgEHVAgWDZkkuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8549.namprd11.prod.outlook.com (2603:10b6:510:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 06:41:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 06:41:34 +0000
Date: Tue, 6 Jan 2026 14:41:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <gutierrez.asier@huawei-partners.com>, <sj@kernel.org>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
Message-ID: <202601061219.9effe621-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251229145533.2437293-1-gutierrez.asier@huawei-partners.com>
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a84a68a-6b59-4f27-02df-08de4ceea26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9amVqqHVGeS4Ih4zl9Y+YVwBK0XyOo3SFpB67AhsdNds3I8xbjTcjQOSuTeM?=
 =?us-ascii?Q?rLdfRqVSXtlsKdZdtFrkBcVkfaxUS8RLYIxMEiI2ctVp9dmXGxuUCbVdRVoG?=
 =?us-ascii?Q?nQpjnF5J/fulkcuIxKjNnhzFicMbRyAEaPG9quzHPj11E6QAlbk+nFK3MmLz?=
 =?us-ascii?Q?fBGT3RpTnPzNUgoOk8fMv5zTiCpY7fO5PMbQ+X+CRZx/7lcp2/vN2A3XvnSR?=
 =?us-ascii?Q?mKRvD6KYWw/SfuNt70d/TVrq5VUK+O0Z88OdFv2G3OA26oHwCYzStGHQYchn?=
 =?us-ascii?Q?PIfbaD8F8CHpAahjk6wjXTVoNxeloeRCvrAGwG/IODQ5Rh6IXu9dEJ7XQfG3?=
 =?us-ascii?Q?t0a5QO2VqXdX5sLnG2FBFUQA7itnC+4iPjVhygckVHSAw5fjk4G/ScHHqV9F?=
 =?us-ascii?Q?RsixJadfF7K4GSlqa/Mx20ErBR9UmU5Ssd4fam0xWINdl7P8nYi1V0RJHN3h?=
 =?us-ascii?Q?PQIFlVdv7gkp65x4BcsWvojx/VhzQZUTM+tSy54IHgUFqEie1/8VF0YjHw/6?=
 =?us-ascii?Q?o4YIykaJjYmqQUdcqkwbi4Fa82XdmpJBCNmBxAY5AMwM/IeZGOdpraI0T8Ur?=
 =?us-ascii?Q?i2D9YyCH6nbdIFQQgEmAmzVXZRSlVpwiBTkb7UsMxLH1WZqfytJ2NcAZB2MC?=
 =?us-ascii?Q?yUQD1fB2rDaff50chBaUvEYOFWpBQ+B1hM3rn8qPl0P0hbcjP5xulGDAhyDl?=
 =?us-ascii?Q?HoW+nDJnG28x9y1iRUkZKtesrcMa64aNx9E3cwSpV8VUn1e+wU5x10UzHWEO?=
 =?us-ascii?Q?sxvgGRahsfs/OTXWkgoeaf7L4nWfQ92r0i6fOeeE9ewAMVIuWDsSx2VG1PEy?=
 =?us-ascii?Q?GNiqc9FL/FgaxywxO4qgkooKjMK0IOw2omSlfUTbGNYW9dudsIyXUIzsFqkg?=
 =?us-ascii?Q?cTTjf5T3r7f9pIJ2Mg+cKq3ChbmSCYv69YsSw2gb9Nm6WOuuzmgZCVthg7WS?=
 =?us-ascii?Q?xNzfag3H3O25ZI2i0fkWwnTb9Pf1YwvQ8x6xgtUuchQECJNFDFJWlDC5DJHQ?=
 =?us-ascii?Q?umP3HUyd7D1v2t348+gOr84gzX2eS2zqr4lRBT0ni6n5HcmGH6mXnIuTMjPv?=
 =?us-ascii?Q?IkygAp0g9B08F3SJ7RaIF300pqGYICRv6EZyDyNkePLGzQHPBhHcN7XeXhAE?=
 =?us-ascii?Q?OjpBxGOloBRoyDK/psCBgOtcKAhCX4B5KKNi/WFd8bwTAbJmty9XdV8T8X0w?=
 =?us-ascii?Q?/w4UfsYi4W1aT7LWxHQtxozskKxrF+kmASv+w014ZmIMEvw7p7of4pjjOz1m?=
 =?us-ascii?Q?8iMU7Ralwiq8udQa5lnzpOIJLfo2Jj7YgC0TU3hQ3TQyL+UivaGlAfoAu8M3?=
 =?us-ascii?Q?gVCt6YoLT+7I48k0LjfTsmALMKS7X5+R/H9aVFHcZT3OnO1GpmHz+jMRM996?=
 =?us-ascii?Q?3N1drjeNGSm5nUAaC5Nzh8eGagup+/gGEL1EbE7GRLPUF5UnmElUrcTcJ+ia?=
 =?us-ascii?Q?uMwi83p62SACHYkrYBkyJrQAPzFJ/eoDpG4lPZ2sVA/TFsiAitozcg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lgPzNqlTPOSJ0nRrjd5EY9xJhMbDATofJEIpQ7fXAm+uSBimv5QVVQB8Lmnn?=
 =?us-ascii?Q?fEVRDQENxrKl/18KOaxgYhWIdJ/b8/4szDezLjWsCFVkXn0CFkFKKGdWtIIU?=
 =?us-ascii?Q?7Xcbu8dfWS2X3LFviVptrX/7DKvdLXuJzo28844V/v8vF627sicMFO64aL/K?=
 =?us-ascii?Q?G9UbbEN/JHXfcKQhdcFj8LeefFVdwLiOqScCREEQcTnEZuaMykvnwq/vjy5d?=
 =?us-ascii?Q?UE8qIrCcpK5k+iYWUGB5O0Ifnt63v/Tf4nT09z7rfx+kA///JHNigpbHFyxb?=
 =?us-ascii?Q?f88/DXUZwJv7QUnPxAaDLwshRL832MWpM0/ZLCGiRPR5sBU/vVJNzJ7wQ/Da?=
 =?us-ascii?Q?Z8XmHKgB1YMyiV5bwAcWM4atLAjxri16JmIbCVPnkELqM1S0hqSJ+JoJshFP?=
 =?us-ascii?Q?qR4YGoiU1O2wQHNAEwEkeqfh+B2khoBCV8Jld1PPNfbO+Z8gesl9X/Qz/LVB?=
 =?us-ascii?Q?Zvy5psKGGe65yGswfv9aHwjemdYWjoXROee8gLmSiUBvrbcBahNbaCqmiYLD?=
 =?us-ascii?Q?8wEpA2lGBJiwLC7xD1PB6GbW9CRFG7M+l2C0DaeU76SwJkFvn2kUtvW50yhv?=
 =?us-ascii?Q?ThrBuknkvoYS4jCbS5RPeVpRdqkkzLHHmqtkayB0DImBL+wXs+rv2R3HMn/B?=
 =?us-ascii?Q?mJKYkO8AOPryJ/4sJ9edfaHqFSQAsqfKBF6hyIYWeLxd6mzWzUqk6yGgFx6M?=
 =?us-ascii?Q?ZEGp/QOR74AtzSkKIHTyQ1ArHYQMsGqArj4kwlfmXOOIvdcSiFI+d+Ikk2rt?=
 =?us-ascii?Q?2rbSMTu2DrsWqKACBkY4wFGjB7bt27PFM7gWjbG1/TCvcr3qSpU/y7COIwvz?=
 =?us-ascii?Q?hWnhqn3G4Fe28EDyQvBFmBNLbaCplfoZBOiFVUDVB8KR8zRcB5GoN89+Cdw0?=
 =?us-ascii?Q?kilsfs7zHKSg+gtFL4IeDKE91vsWRj/vepnnZ5+qUbvrApixa4YkGIUY5YBC?=
 =?us-ascii?Q?ZYc94gea5oAKHAxrBtvOjbbCbbaNbbyICh29po7tj9Ih2obsWqjYhA4Cylec?=
 =?us-ascii?Q?3/U2HLeGtKzH1+07TkN7XKC985fvobFMVloe6a8+70XThIi5dXxRUW6xQZyK?=
 =?us-ascii?Q?jR4SLsz6yeu7qIcyNKzeikN/oF+64UizZuIm3KzgS64epOjnGbe38SInBYP4?=
 =?us-ascii?Q?x9kNb5QTDCMDYtWK955Nn3wZ64C4JXUoL//R6aZJUlEu+VDOc7yXZ9gmB9S7?=
 =?us-ascii?Q?FFsbVDloe2DWHtv0DCtt/Wd6DW+4z7l5ciY+udu0JE5pXvPVNNNRBZw745gk?=
 =?us-ascii?Q?F+ZCPWI2J3BjHSLfmxfkKgy7GF9HIfBsOLCsnl0jsqyyw1OUzCphksP/j55V?=
 =?us-ascii?Q?554ulYBtQIKesikSFTTmQucFKoTaM5ynYeIVwNzsuJiwUGeN3IfF9PWjyKLh?=
 =?us-ascii?Q?drbwM9gqcRPr8Y0boPXdpcHK8HvAb2vf+qQwoqe9y7EgQPLql8tpRn30OmFH?=
 =?us-ascii?Q?JRYGMOCcJz8gKeDVeWN05ipMGQuY/Khih/FP9pLSY9UWabXqKl2Cd7fTyKjT?=
 =?us-ascii?Q?zanLfoYjISkPncgM5+csQAXpfukcDHRxRb89oiuId0T4v/s9kBOE/02Yi43t?=
 =?us-ascii?Q?DP3ieqQFemlCUsKTnhjWsnKP0PZb2/8xbCEM2thhW7XRhy4odn50eLXqBDML?=
 =?us-ascii?Q?NB6OtzZkqUObx54SGW57MOyztPhh3k0XJd5uGRBQUEewPhj5B/ZKb5elelVS?=
 =?us-ascii?Q?d48y+cSX/za25p4phx8RVSyPW0PeWLfTg0pbZAMWv6qVyb1hr5dlFK/Pn+MC?=
 =?us-ascii?Q?hYkIpUiqzg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a84a68a-6b59-4f27-02df-08de4ceea26f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 06:41:34.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saaxwrJKGEfy1cKxi/iEgIuyvypb59Q3EVuWzMvC2U2vSZzNi5xqnHKFra3PyxPsElY+lV+Z++xfdHRPgyB7Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8549
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "INFO:trying_to_register_non-static_key" on:

commit: d87e70902c77a5dc3a4fd4fe78c1172b4b644495 ("[RFC PATCH v1] mm: improve call_controls_lock")
url: https://github.com/intel-lab-lkp/linux/commits/Asier-Gutierrez/mm-improve-call_controls_lock/20251229-225805
base: v6.19-rc3
patch link: https://lore.kernel.org/all/20251229145533.2437293-1-gutierrez.asier@huawei-partners.com/
patch subject: [RFC PATCH v1] mm: improve call_controls_lock

in testcase: boot

config: i386-randconfig-005-20260101
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202601061219.9effe621-lkp@intel.com


[    1.225255][    T1] INFO: trying to register non-static key.
[    1.226642][    T1] The code is fine but needs lockdep annotation, or maybe
[    1.227181][    T1] you didn't initialize this object before use?
[    1.227181][    T1] turning off the locking correctness validator.
[    1.227181][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.19.0-rc3-00001-gd87e70902c77 #1 VOLUNTARY  7c12528289a79a90bef93a94128a85da378fc562
[    1.227181][    T1] Tainted: [T]=RANDSTRUCT
[    1.227181][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    1.227181][    T1] Call Trace:
[    1.227181][    T1]  ? dump_stack_lvl (lib/dump_stack.c:122)
[    1.227181][    T1]  ? dump_stack (lib/dump_stack.c:130)
[    1.227181][    T1]  ? register_lock_class (kernel/locking/lockdep.c:985 kernel/locking/lockdep.c:1299)
[    1.227181][    T1]  ? sched_clock_noinstr (arch/x86/kernel/tsc.c:273)
[    1.227181][    T1]  ? damon_start (mm/damon/core.c:1372)
[    1.227181][    T1]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91 (discriminator 2))
[    1.227181][    T1]  ? __lock_acquire (kernel/locking/lockdep.c:5113)
[    1.227181][    T1]  ? lock_acquire (kernel/locking/lockdep.c:470 (discriminator 4) kernel/locking/lockdep.c:5870 (discriminator 4))
[    1.227181][    T1]  ? damon_call (mm/damon/core.c:1460)
[    1.227181][    T1]  ? damon_start (mm/damon/core.c:1372)
[    1.227181][    T1]  ? __mutex_unlock_slowpath (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-long.h:40 include/linux/atomic/atomic-instrumented.h:3189 kernel/locking/mutex.c:947)
[    1.227181][    T1]  ? hrtimer_nanosleep_restart (kernel/time/sleep_timeout.c:62)
[    1.227181][    T1]  ? _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
[    1.227181][    T1]  ? damon_call (mm/damon/core.c:1460)
[    1.227181][    T1]  ? damon_stat_start (mm/damon/stat.c:219)
[    1.227181][    T1]  ? damon_reclaim_init (mm/damon/stat.c:258)
[    1.227181][    T1]  ? damon_stat_init (mm/damon/stat.c:271)
[    1.227181][    T1]  ? do_one_initcall (init/main.c:1378)
[    1.227181][    T1]  ? do_initcalls (init/main.c:1439 (discriminator 3) init/main.c:1456 (discriminator 3))
[    1.227181][    T1]  ? kernel_init_freeable (init/main.c:1692)
[    1.227181][    T1]  ? rest_init (init/main.c:1570)
[    1.227181][    T1]  ? kernel_init (init/main.c:1580)
[    1.227181][    T1]  ? ret_from_fork (arch/x86/kernel/process.c:164)
[    1.227181][    T1]  ? rest_init (init/main.c:1570)
[    1.227181][    T1]  ? ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[    1.227181][    T1]  ? entry_INT80_32 (arch/x86/entry/entry_32.S:945)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260106/202601061219.9effe621-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

