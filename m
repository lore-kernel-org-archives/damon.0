Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00BC253B64;
	Thu, 29 May 2025 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748498014; cv=fail; b=Bi5Hdy+y8MFjUxeQVJqVYNe9SF5mLpZid7ka07IGG4JOAPhTtyQiCbvVteWaX9PzfPgeIktQZ70aNaFpgCsmin/PrW9tTjbU0kWcNXzQn7Sts8chL/Mb7an+h2Y1I4yMuM9+lplVw4+nWEZwWAvFL7ujWDwt7HbeTZ0KeBbL6oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748498014; c=relaxed/simple;
	bh=HWXTXQgaV27yEw249hKp9IiqWEzczoGxyAdFvUkbM+4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aK8ap7IssSEFKV/VMy02KcKV6p6wbC/VNGoD3q8N7PxpU5PJA+pZK84CYYdMQ6cHcu/47pzjVBS1Lc6TgkIB4mlC1eyckqYqDKr/bib+CjaZllMuJP7kp3aEQlUEouNy3iMHNqvhf1z6X8xQIXhVAZhpSInYvfnK4k1mrYJ3F5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7xTxLZR; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7xTxLZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748498013; x=1780034013;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=HWXTXQgaV27yEw249hKp9IiqWEzczoGxyAdFvUkbM+4=;
  b=e7xTxLZRaaJJNtDq494K6Lso13Lwd24OE2W4LBtj/GZ5DFeDHh1E/Dtp
   16HNyP+7t35eahAaDOdjZk6TdkPJ/SZ3YsPmXVPwh8J+GMBa2eGOTGwzT
   ReyV0JQ0NEY1efLqQ8GHUTVyzcaM23E/qdJpQhcGlINEC1iTTmTEue/L2
   z0l7K1klPwAjruMz4mlG4QyOSJMoYaa1kH2+tI7Qo2ouxwoXju5We7nCt
   Jd3DThPVkqefpqs5FoaW7/2LSevckF1ypF09T6zxnRupPIGFr/l57YGIB
   VkvCaWk39znGXBer6UkaJdqXDkZRL/xzYDfCAQR4ZkcdNzBOtxrUptJOP
   A==;
X-CSE-ConnectionGUID: 5HMDmiO4Q8qbiIA+i4OG9A==
X-CSE-MsgGUID: JPu/w1AYSbWVyPf/TG95Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61206187"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="61206187"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:53:32 -0700
X-CSE-ConnectionGUID: XNbLRYi6S8SCFs1mvX5/+w==
X-CSE-MsgGUID: +v9Lr1+VSviIMoZ6pF3hOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143929804"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:53:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 22:53:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 22:53:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.67)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 22:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aq/cydxtym6vh6f8+Mv8m0ePVhmi77F3jOvJOIuIvpbwQtyBDczL3kS/PZCghPLQH6RU0ayYpP6l1sB8DQ+OMODK9c7C9IN/3IqUmVtp3y5x1hd046yS9ftlJicm0lcorcpa6LTLnSc1+5qnNIgUsRaDrh93ObhI1k/vpde69E1IEuzyB7AAGt62/nc8QSnDi3GXTYkS/V+8slP06SFJED9B549wDg7n5OXiH06XRIMlzhMMSLYDPwTkX3OS7rXPTy5KLOkV8zHZmzHp4YogbigaqMbzuQONHUQysTiEkwETT7veH6dO5HKhCp2U8XeiB2XTPLeR1YpnIqOlo8jagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD7/QXHUHVRu4P2QIgteSAm/oWdwF3PmogO5l8+xca8=;
 b=Wy0GIZGKNe33ik/g1Lt2jlwqVd6F07RKhkjYtB2qWXdFdARi4cfodTE5Uzzr1dbXbDnrmS9tJ+2Yzy6vfOI/ARZy7YNtrBxPfT0MVUASKlzgDAbmMbuzmfbmfFkV+Ylk6QNzhkwIoK9z4oCmVxWyqv7KfjhxSRLN3AEdT6j1nqzH7zTbMIAgVHWL1eB/fgJbZ/DoKrjJDu+FKULmV6e8/EHKdMLxUJPmzToVWxQ2UvjcR+sXDLCXjdMqtPbDto2dXxs2FoWnHCKoBjrPJhmVa+9gok1rJm4pcNuSY+mAh2y/fn/KnarMz8DsRE6N8uawknJivcjxjyBZBA5Gu3l39A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 05:53:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 05:53:24 +0000
Date: Thu, 29 May 2025 13:53:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Enze Li <lienze@kylinos.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <sj@kernel.org>, <lienze@kylinos.cn>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] mm/damon: make region calculations more precise
Message-ID: <202505291314.d61b1bcb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250521070747.1458270-1-lienze@kylinos.cn>
X-ClientProxiedBy: ROAP284CA0036.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:f::23)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 82bc1b00-eaa3-4a47-8a15-08dd9e751faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t27+CNemd+lELORsi7nxTHCkPUnXNcab3j8t1ohZ4Z8xO67ztPvDaHwB4WDo?=
 =?us-ascii?Q?Iya8bktPDY59UQtqJst0CWP08gzGLCUH3eEHyMkuYyR9rUh/fvafPPKTLzlM?=
 =?us-ascii?Q?tDjuPvUMljGUqR/mNJkJpzDHdPhgzjI2ZTWjsOAgf9vDoiAU44+CMzFy/BGs?=
 =?us-ascii?Q?LpSInazFeNgsfGOsh6GJRuMaMlGF/ymPmbDxgTU+Ww16IvW1e5Nhk52awAdl?=
 =?us-ascii?Q?T+s3UieRSn/gyw137zJGIogpnCnwy7c5+EB5bw/lpOstjEw/+1xUMnFlr2Ln?=
 =?us-ascii?Q?PzJy5dEoxecEB59J/9lRBj0tzBSzXQDCZx3l5bbO5DxVxH32grEbpTrT2Ljh?=
 =?us-ascii?Q?WNA7S+YvCe6CF3WDMZTY5SsBTI8kaHR60bvHMd3TJLE9vep1lXJto+iLY18Z?=
 =?us-ascii?Q?LCPOo1JhJPvHKrjRvm/6z4jsqAv4MInUrr/Z4bhAynyFJfBqCViL+NoljOf3?=
 =?us-ascii?Q?VskZdJa2HwKpBfCxGL6rpbLZxqE0yxWsh+/36WxCf4IIWc+Td9vKjGsnpreg?=
 =?us-ascii?Q?TZwNgxd720g4D2gTADk0qL+Gu8O98Rb4+FihmAvLRh7/lgqfymYb6o/NVqKL?=
 =?us-ascii?Q?4nL9nK+yDCXGCejUlPboxKlZLcuTgmIVWMJH5EKi2jWCs3rQbdK9GFnImgLI?=
 =?us-ascii?Q?qg1Ktg77tTjrBVr//n0cWeIE43500cFJiKh1CL91ieLN4QvgOvR/QK/Sem3+?=
 =?us-ascii?Q?37RYLaCCeKbkjZJarAmAQW6mlD55+N8uQdJs1MVskeisqtEQyc+2IppUM8h8?=
 =?us-ascii?Q?JvL5IHEu8S+xqYLxXjb4ZE5MhUvRHk2P1cAlbSdZeAm4N3sW1OYPjerd0IG9?=
 =?us-ascii?Q?FkcK+wvxaMiYvnz8TYVYuwE0Ye2JHvEKwWjbMSYXu9XDgPITXKmoZ+9GTBo9?=
 =?us-ascii?Q?a0DWEzA7E4MdOyib1kjvpEuCku7ZEi0rBpt+TlnXDwB8df6cj3JgK0mNES/B?=
 =?us-ascii?Q?XlrI2q1d6UCigKYI6F8yrQt/cqXags6rzPOHJUioKWxqwHduxq5WtgkvaDNk?=
 =?us-ascii?Q?uh8Qga2jUzpGY7pebhEZYi0gPF2xCTcySX66QzBU4NEaMxKX8CgQc0cWru34?=
 =?us-ascii?Q?BQouPgvx5YWO9FpHKgbxoUaFUqwkuOYYTY/v1LaJT35OfCwMWMIXg3vwYw3a?=
 =?us-ascii?Q?VXgZ0vtF8IW0b0uf+aF5P9CRnHhrLv+DV81Kge7ZEC/TK2Amntzk19fQOq85?=
 =?us-ascii?Q?VhS/ZNC/SYJlMlx3wOA22t2/N1oKmq5OrYsxDoltZ2ulqA52Wb82YvcUT1Pi?=
 =?us-ascii?Q?qrHFTWhlc1dQq/FkFDzvVTbOP4NOoblpr/qY/XP5sJ9KqhF92CP/aDKJvcDl?=
 =?us-ascii?Q?eMfo8Nn7KVhKVTvyMl+svgXAxQYYN5It7+sLu6UdT1I2s8hSjcpQgjjpgqbY?=
 =?us-ascii?Q?uVS5zz+Ae3hEgiaUeVDmGU62pfGN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z4I17nfnoJT9kz/QMtqdlbkc0VjVXglsXRaHoIAmgQbYdP1HkSGxgUsOSiSn?=
 =?us-ascii?Q?mpg7KaVNz6oeW3SEFcLIRn0oZMB913RyzxbkZOiVOZB4HVav06xXQEfdIre9?=
 =?us-ascii?Q?M8BaSlxT7gUwkNaKu97WQq7Xfr/Ml+63q3hVEmvFluGhIMv4rKRaHtpxsKbV?=
 =?us-ascii?Q?D8paR6fU837OmXmHX5titQDio2iSrhZVaT6EEvCq+koS8M+kw/MA+TG+R9Ak?=
 =?us-ascii?Q?Khm1Cj0uHBiqcN6IOzZ4Yk3a9AOLJ6wYOiZmteoyIzb8PJZt+cnD9iFiY+NW?=
 =?us-ascii?Q?Hf37o+VQ36TWf6YUnIu+JFOFNcLjtq5XwQFmUJ7UqPfq9ZK1g1Q9NS08Eh7L?=
 =?us-ascii?Q?PSBTP8yVyDGDNuyjYHL9xhhUF67tmzY/1MnSsbS83TKgsWfbgC+N9o/70cTX?=
 =?us-ascii?Q?1hlODUqUfwu4yO2056bB0ZOMSLRB72/TOiy0amLFJkDajneB50EJTAETr3sp?=
 =?us-ascii?Q?GjUtZhtfvEvO7aoa5NIHaya1Oe4SIOCz/eGa0whqhYPVlhhBYp40n5MpL9/4?=
 =?us-ascii?Q?mVQBB5yw2WR/y0+hV/LJifbxm4GEjYCEy969CzEZvcFejV4UjNdBZ4P+0k8p?=
 =?us-ascii?Q?EuHliyGRolvR6NoaaGwRl9MfroW42/P8Re6qv2H0HhP1+EJKuD9jBl5WkjLY?=
 =?us-ascii?Q?2ZV/3Z8y4xU1v3tgIKjGNPei2T99h4IuGhxZskTka0zqpTwhEri2xm0xzFv0?=
 =?us-ascii?Q?i1c6mJh+UZl79duV0UBEanqRL2RxKFzROFTL+sYN+NHNPVAHippifF+9f6nC?=
 =?us-ascii?Q?V1YD3WCiQ8uqa6Xu4vX9baNc1ojsTvcseOmmvFHb2jcLcDQKfta0J1rJGCpF?=
 =?us-ascii?Q?mSwxyYm8F5IOsqBnXmfhCRM0XWl1QlC81zzN9UQWfKP0WLnDui+Gw6adB/fD?=
 =?us-ascii?Q?wMd8CHBndPQdDLz43UKLmSRcPKJZnWuwH9BNW8hadAN5l5AwUra8Unbbb3Tu?=
 =?us-ascii?Q?7dN6oG7futOjuYGHY6+AMC7HnrOoEsVW05PuFJ6SJANN6a5USnxY2iQkvI5f?=
 =?us-ascii?Q?mp9TS52l52YjBbRPrj1MSPNeMUU2wJ5JxrtS9Bv3q5lsUJOQzzzLjWZdptcT?=
 =?us-ascii?Q?eflFQjpre/ziUuodebr20RVIs2xYdlg5o9qw2GSCLsOOOQJk9Trg4KdFLL+G?=
 =?us-ascii?Q?39az9BVk2nc+uttj5jMPUHUjqACy73kCIY2hoXaMhemtkkIs1keOd3znTOO1?=
 =?us-ascii?Q?hhYWxn6xaGTZSYRvy0ah2tQ8VEJcFIHZQ1gRPBMSxhPzKp+ao8viKj982RlA?=
 =?us-ascii?Q?w3Bvjws20BhYbxKBbKVRwGD8Vk2p5BsadZEPAN0sCelPQr7hS4v27lzBBXRi?=
 =?us-ascii?Q?VnoD+qIj29ifbx7hlSM566Ru9wyRwoW0lZJ39/qHV2ybBHQC9fNRDTaGuqRE?=
 =?us-ascii?Q?B12ZpekISTCVcyGi98WYjRhZl/itnhirIQeSfYtueeYXDn16vz0dyM0bHIlo?=
 =?us-ascii?Q?pSvuOM/X6nvsqP57pAzZjV7L0qINaVhFSWbVnZWDvsFyVhlv/xZ5DAy+Tz31?=
 =?us-ascii?Q?JdlkTJVFss7ZP7uVHyCT8EHQ+8I/zae134MeEVSgjg3h35ebplB0gOSHZrZH?=
 =?us-ascii?Q?P528omgB7E4L6CdIVUJcU2IOF3wr7rPWUcsNNcylNee215nq3Z/qO1VegdgP?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bc1b00-eaa3-4a47-8a15-08dd9e751faf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:53:24.2191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmCeHRRLo9+maEjJxoAeufjlzQmp/I3j2BMy8oeSGhn45ZEAI6rFeAHc101wjy8LU8411OunkY5nT10+ss7fpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "kunit.damon-operations.damon_test_split_evenly.fail" on:

commit: fe301d6b4b4aec003ff84aa4d2860e772b147225 ("[PATCH] mm/damon: make region calculations more precise")
url: https://github.com/intel-lab-lkp/linux/commits/Enze-Li/mm-damon-make-region-calculations-more-precise/20250521-151059
patch link: https://lore.kernel.org/all/20250521070747.1458270-1-lienze@kylinos.cn/
patch subject: [PATCH] mm/damon: make region calculations more precise

in testcase: kunit
version: 
with following parameters:

	group: group-03



config: x86_64-rhel-9.4-kunit
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505291314.d61b1bcb-lkp@intel.com


[  109.399987]     KTAP version 1
[  109.403771]     # Subtest: damon-operations
[  109.408675]     # module: vaddr
[  109.408682]     1..6
[  109.416216]     ok 1 damon_test_three_regions_in_vmas
[  109.416463]     ok 2 damon_test_apply_three_regions1
[  109.422542]     ok 3 damon_test_apply_three_regions2
[  109.428508]     ok 4 damon_test_apply_three_regions3
[  109.434509]     ok 5 damon_test_apply_three_regions4
[  109.440399]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:290
                   Expected r->ar.end == start + i * expected_width, but
                       r->ar.end == 16 (0x10)
                       start + i * expected_width == 15 (0xf)
[  109.446223]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:288
                   Expected r->ar.start == start + i++ * expected_width, but
                       r->ar.start == 16 (0x10)
                       start + i++ * expected_width == 15 (0xf)
[  109.473938]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:290
                   Expected r->ar.end == start + i * expected_width, but
                       r->ar.end == 27 (0x1b)
                       start + i * expected_width == 25 (0x19)
[  109.502332]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:288
                   Expected r->ar.start == start + i++ * expected_width, but
                       r->ar.start == 27 (0x1b)
                       start + i++ * expected_width == 25 (0x19)
[  109.530150]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:290
                   Expected r->ar.end == start + i * expected_width, but
                       r->ar.end == 38 (0x26)
                       start + i * expected_width == 35 (0x23)
[  109.558624]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:288
                   Expected r->ar.start == start + i++ * expected_width, but
                       r->ar.start == 38 (0x26)
                       start + i++ * expected_width == 35 (0x23)
[  109.586405]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:290
                   Expected r->ar.end == start + i * expected_width, but
                       r->ar.end == 49 (0x31)
                       start + i * expected_width == 45 (0x2d)
[  109.614882]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:283
                   Expected r->ar.start == start + i * expected_width, but
                       r->ar.start == 49 (0x31)
                       start + i * expected_width == 45 (0x2d)
[  109.642682]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:290
                   Expected r->ar.end == start + i * expected_width, but
                       r->ar.end == 2 (0x2)
                       start + i * expected_width == 1 (0x1)
[  109.670817]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:283
                   Expected r->ar.start == start + i * expected_width, but
                       r->ar.start == 2 (0x2)
                       start + i * expected_width == 1 (0x1)
[  109.698255]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:256
                   Expected damon_va_evenly_split_region(t, r, nr_pieces) == -22, but
                       damon_va_evenly_split_region(t, r, nr_pieces) == 0 (0x0)
[  109.751585]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:258
                   Expected damon_nr_regions(t) == 1u, but
                       damon_nr_regions(t) == 2 (0x2)
                       1u == 1 (0x1)
[  109.751634]     # damon_test_split_evenly: EXPECTATION FAILED at mm/damon/tests/vaddr-kunit.h:261
                   Expected r->ar.start == start, but
                       r->ar.start == 6 (0x6)
                       start == 5 (0x5)
[  109.776758]     not ok 6 damon_test_split_evenly
[  109.800835] # damon-operations: pass:5 fail:1 skip:0 total:6
[  109.806182] # Totals: pass:5 fail:1 skip:0 total:6
[  109.812563] not ok 4 damon-operations


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250529/202505291314.d61b1bcb-lkp@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

