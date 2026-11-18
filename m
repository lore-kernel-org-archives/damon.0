Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794990590;
	b=LunwkjiCs9m72onH7Ss8TDCwDwKWAAn9iV0MSZ7Mq95g/0stvMjs3keHvox0NoPdJB2I
	 IKTjiMzwZ4kp37hZAp/cLKRLMp9G0pUyx9pH8w/wxx338fbbJyVJPhelhi+jL21e1z3kf
	 v5tKhgUQE7WZjit5tLF9hCv+qlt9AmNLGU+Zrda6xtns4nVkvexSNUQCjz6EpB1f/pZP2
	 ZRjDaTzwi5p/8mvpceXWveGNyApQZAXZHBD6GpkyY4+nzbXBG8f5DZmmdQa6LkisfbVwH
	 HFNWnduv8vpSIkiG99WKVnd+Cn9qKJ6fCzVuvqfK1dQWRrW3HOi7obCapPVITQg/Z3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990590;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=R6RnNqiWkogIz9PQ0eqwbL2QMul5hVFgEpmy8wdN4k4=;
	b=gkq9VObhDXDMFbTkB1wxlCOrljasWe9VBHeei26VDYky5trzG9EtrLAsewBNULPznzg/
	 3HKn1HLFIFKlN28S2cd+5Wi8/fTpTFv525A5S3cNjzt8U9n5iayQP3goSHpk7X/8Cx6IL
	 bKVDKFveb3aXv+ftqNKOXoEAMBkDGcgwlzp5iqz4k0S6NzqwBfwRKSV7BwwHqGx8FZmYk
	 cmb0A87jK5T6UZeGSTMrwmLEg9DGz6AQL8Fp87xShRFKJVwrEDv0zSrpNhHwp4StRz/D1
	 G0L8u7C73ZIYfbkHDbB6iDQ3HR+ju7uXoTOZXx/HXjSG9KO5dACiHxIdO44fuKwBKgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EXiLonfE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.70
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E929A606A331;
	Wed, 18 Nov 2026 08:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E929A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EXiLonfE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCR9NP91Q3uRPIDPQWD+tAlwUmx27KJR6WEOqLCTJAorrU4ziFY6bCucCV5XDcXi12ShJ2UtLRnjfd9ncm08+edMEJX+tibErt+9c478sQccGE95q0tRtRBrCeBeLJepTTgyrLDQYigBTI5X5JOpgL59Wn0hjxincCmZO321kUCOA6IruLItZapV1z2Hhx+i3p611f7LpMbm5pKsp2GURCE5R2at/wsVb9mMWmmI4eYsIOobxpsOggeKbM/oUjCqNWYUtJX6h77pY7Oid/pLExknZOAfO7BuldoyAcQq60plrrQCppKROrzrdjpVXyD8m8cxRpCjZIsZE1g9W0MDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6RnNqiWkogIz9PQ0eqwbL2QMul5hVFgEpmy8wdN4k4=;
 b=b+mIRNDGG06v3CkcWn30RqxcDxmKWXo7V8bcy1bpa8umuoFUH3Q++vg3Vq88WSq5GViyvS8Dbc3+ew+8+v5ncr3Zsy+jCw2/6l+aD+Ow9cFT32LeGrIpxetpZRQlcxuLiA2dPHSCUx8DJFn0JgrbTGKzDQ4FZMLDgULINof8Vd81K/cyrvwtXOoPxhtYT5QCaKSWbjlRzB22n7DbuGUvEKbkEjtNupMD5+KvtSn09i8osv9/9pyG4cjsBRSmCFIBrn4R8TdrKaPxP3tlMCXBf0xCXfnZuiwvnig+gmNItqbOAzYolHJz7y7RLtTACLLWOp3iHjUi45XN5k5QsxJ8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6RnNqiWkogIz9PQ0eqwbL2QMul5hVFgEpmy8wdN4k4=;
 b=EXiLonfEyuhBDvbCx01li1UaP18t93J8jxbwqqJvmZK3DnkMU+MwmM41M4DEFxKqsqtN1Eg/F2GWLQX9To2BYxvVerpy0/MjcRGcLM2Vr1D7knRtkWowJKJydJb23XrIs5sbzAlP+lGfqSWl3NtAkMnrQAwXQulyz4XNzr2CWuZcmmpKdVTRUJTIkI8JaCGtq79wpp/OnHSKWJ/sz4Xlk+R5pb53QPeJSYzBtV6g0D0bti/aeOxCblLrCFdeCddgb8jEgNiKh5k8z9Qg4t25TwcJ6LLN3Mnr4z99+yJlZKoSbCpI/K+uq6x5QhWPfLwCJ65Q4rhBFwtQRnzJeb/uvg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:29:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0615.009; Wed, 18 Nov 2026
 08:29:44 +0000
Date: Wed, 18 Nov 2026 16:29:37 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	linux-doc@vger.kernel.org, driver-core@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-pm@vger.kernel.org, damon@lists.linux.dev, linux-cxl@vger.kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, johan@kernel.org, jirislaby@kernel.org, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, 
	baolin.wang@linux.alibaba.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, pavel@kernel.org, 
	lenb@kernel.org, hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
	sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, 
	kas@kernel.org, xu.xin@linux.dev, chengming.zhou@linux.dev, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com, 
	matthew.brost@intel.com, byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
Subject: Re: [PATCH 01/22] mm: add node-state-filtered zone and node iterators
Message-ID: <av1hKrtcATVjCnCM@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-2-gourry@gourry.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114070959.3490008-2-gourry@gourry.net>
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dab5d6c-854d-4d2d-1c43-08df454e18ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|261009223027099003|4143699003|5023799004|11063799006|56012099006|261026140227099003|261028144727099003|261102123227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	l13Y5nDdpijjsnMcAiqIwAVjwA38McW8+xWmF2ei6gjrWeyXV9hMWMTMu6vhzs2/Kj/DeDwxNU96b1vjQsPlNfZlE8JJOX7mwH153+Of2AQZBg6wGgKevRR/Wm9f1lS5dekeQ7p/5LLfED1L5d3GKBAChPQPD1CVX2AiB0a76gQZVte5S39gMJl+n+IqayRxCzpKVLJFiKOKC8VOHlgEjGcjaX9vfFwIBVdqarrjLPzr4ksqthM3yOY7T2g1lRpyIvt87H+7hhe+o0brnC9BWGQzNxfE5bqH7PRk/Fb5+T6q+C2qlmyJnqzg0Msxc1Itxl1byduRi8mJnhfpkH0OyhlstqxUwas5oFiMQFsuGnEICFZ+ruY0dQ3BvG7N2mqVsD/IvBYcDHUCHzgF/6rM7RtJ+TxotVajl5uRchNsS8//dw9om4E7nuV4Kt8EM1bzCn18RyfFk1NTOpTyu42lNTaL0EUdfrhC2IyQaDR2nMjPgpiot7AXZu5Xj7KqZwRD2r8QYR9rwwHtnWrdLGFI+s+dcb5f/6TUOZt60MVrIVjKMtlqECLR3Qt9vI5af0kINfL5gw09YoaUB++XJZbO81wgJtx2KJ01a4T0e7czH42fLf8vu6JGM4z43S9AlQ77bsuSrJT1HftInn68Pozj/PWTuEUK32Ca2byCb+9BVVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(5023799004)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gNe2P4ymbBaSsoAk6mxzw8bBStEIMKQqhyffCRJ3S58gbnWlW/7WcBHR24tO?=
 =?us-ascii?Q?0i/NLHcaAwTN06uh3aI3j69Hd9eGjO5zcJ/rP2CsI1uq4lEcTu8u3W6FuWfr?=
 =?us-ascii?Q?6+lk9/hjFAmQ+Xq6NVQ+1JFWATP8PcST4jOJxyCPF3+QCYH+qQFdMgVGD0eF?=
 =?us-ascii?Q?LFyNjMtQJxxkRsQe3CxQLgyvOB30YrgMIkWt7kJn9oVCoBRjvAtSEMtUWNvy?=
 =?us-ascii?Q?bQ5uu0xucXZTwXa0fVlWhek31GKanVb16v55a1qJnejqqPreNrRNea0WrNU3?=
 =?us-ascii?Q?p9d35iWbG/KB7KP6AAI8UrOIoN4RYKyssyTOLrLB1Bl/HgtOQ03KkjyT9Zhw?=
 =?us-ascii?Q?sTKjKSskRz+jlm68h2JmvyhfAT4EQpXmZ/gMm9Tz9+laLo9e2NnDrk26oKZr?=
 =?us-ascii?Q?FCLQ/mAQswtjK9uHw38Rvg7JgLKPyrKnl3e71On7ZbWWqBBJtE7/WIhQ9c8O?=
 =?us-ascii?Q?QPI3cWSEdDSGLoDh7wO/T9O+cNDZV7bhEjHIw8vmKmel8SE8hQN87xnH+MO5?=
 =?us-ascii?Q?TbrPBDqOHI9U4BCsXsc9PWfF5AVYzjwP2QvHCxYAbuK6ZXYS8AfYHkQ5Ga5e?=
 =?us-ascii?Q?UhHjBOV01vH1L+JfGVLlGsVrcF5l2+Fmz9u4ry8KY41lft3PY+dW9IVwiVDq?=
 =?us-ascii?Q?tEgwTZ4IAHzCKPxdrRgFCzAn40DQHF0xGLcg4rRV3LfdVkm2AXct/+x40CFX?=
 =?us-ascii?Q?5Zeedr5r3+x9Ek341MJTJv81RGNO0OQyEPLIrS5AFnjJtiMDsw5nD9qQxw+h?=
 =?us-ascii?Q?hbjwHhETBhmj/KPcwJRPeEhL5ObIWC68tV6IfsIWvjGZ1GoS9wrz7uJUoG+n?=
 =?us-ascii?Q?G4GJnZQmMGGaXSV+UQ/btDzm55llXtT7m771Tvinj1U29lCX63u4LoCZl1ic?=
 =?us-ascii?Q?sQyA164KfeN+BOn9JqAYLZFExzHtpC775T8HJeFZHDJ8K4n77pFHnElIpeQ7?=
 =?us-ascii?Q?ClwUJ1K8NBkMOLzzuIxa4o8FB7EyYmayfa9P/nKNOs81oraWVU9FqGHLWGBT?=
 =?us-ascii?Q?C/IsUfh9XM0yeV/OBPNMSP/aKeAD1kApgGCT4UopuX87T3xpvyirpxmUsaMq?=
 =?us-ascii?Q?uOp1ER/jqzDJzzyzFKQUl8dHoeBK9sXICSK/1dhsNWDx9yIexHSGkeAN6Boj?=
 =?us-ascii?Q?xOSo5GRoF5I2KogDq+sDcRrObuZiQ8j1lG9H+6vjY7Rj5DGk4uonNEOqphHO?=
 =?us-ascii?Q?9ISs+Uem+o/V/rGIQ9LxplQLAhfs9rXRUyYstCQle63BNOl6uJ5YTy++E0ze?=
 =?us-ascii?Q?50x8ZPGRE35KDG6WmJOUGx4vN9hUxs8nO4MxzFfE4+cMjnxAWAmFphLk7bus?=
 =?us-ascii?Q?FemZ5iAd0GrWgMKYbEVQ1S2w6X1IuzTelMbK85PPugNEdEgn9be5WPESv1nQ?=
 =?us-ascii?Q?obl0FFDuY1fG09ZDjvznnDI57+IpZvY4J4gq0soMjg30ue0l63vtZjfVYZ80?=
 =?us-ascii?Q?KOp5lbhsi1Ulza2zbz96oMU6CP79Qc5RLqfepRP4DdbzGY42V1llAH+o+wmm?=
 =?us-ascii?Q?ucqx+n+CCUNZdqJFPsVBXF4xBQDfK6HWD7MxBTs3R943VLyvBl6c6A7mdel4?=
 =?us-ascii?Q?f/fil63BhS0IGBtyB8YX1y874pGTdgQ2AlqsNLsRd2FMumIwvHNGTGu2j+4x?=
 =?us-ascii?Q?vs3fkRJpWC/LeJ3st4XrgDlvXc3wupV8CvW/pnRXeQmE3utll4WdNngQKElo?=
 =?us-ascii?Q?cn7nIE781pSL1KBygdFereEwSN0RMB4qWyuBwgGVYQIYIYHN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dab5d6c-854d-4d2d-1c43-08df454e18ce
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:29:44.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2w2lHtYFtHFvaERj4raXRWyqStqGCLwIhNCVAkU9cwzgkYQopVu6D0TE3l9xCeyHcSJ6av+w+GQa9Hbv9UeBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242

On Sat, Nov 14, 2026 at 02:09:38AM +0800, Gregory Price (Meta) wrote:
> Add node-state-filter helper functions/macros so MM walkers can select
> their node eligibility explicitly.
> 
> Add nodemask intersection and nodemask/state iterators using the bitmap
> intersection helpers, without allocating a temporary nodemask.
> 
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  include/linux/mmzone.h   | 46 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/nodemask.h | 28 ++++++++++++++++++++----
>  2 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index c161d563ce8fd..5ff190d870830 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1845,6 +1845,13 @@ extern struct zone *next_zone(struct zone *zone);
>  			; /* do nothing */		\
>  		else
>  
> +/* Populated zones on nodes in @state. */
> +#define for_each_populated_zone_state(zone, state)	\
> +	for_each_populated_zone(zone)			\
> +		if (!node_state(zone_to_nid(zone), state))	\
> +			; /* do nothing */		\
> +		else
> +
>  static inline struct zone *zonelist_zone(struct zoneref *zoneref)
>  {
>  	return zoneref->zone;
> @@ -1937,6 +1944,45 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
>  			zone = zonelist_zone(z))
>  
>  
> +static inline struct zoneref *
> +next_zones_zonelist_state(struct zoneref *z, enum zone_type highest_zoneidx,
> +			  const nodemask_t *nodes, enum node_states state)
> +{
> +	z = next_zones_zonelist(z, highest_zoneidx, nodes);
> +	while (zonelist_zone(z) && !node_state(zonelist_node_idx(z), state))
> +		z = next_zones_zonelist(++z, highest_zoneidx, nodes);
> +	return z;
> +}
> +
> +static inline struct zoneref *
> +first_zones_zonelist_state(struct zonelist *zonelist,
> +			   enum zone_type highest_zoneidx,
> +			   const nodemask_t *nodes, enum node_states state)
> +{
> +	return next_zones_zonelist_state(zonelist->_zonerefs, highest_zoneidx,
> +					 nodes, state);
> +}
> +
> +/**
> + * for_each_zone_node_state - iterate zones in intersect(nodemask, node_state(state))
> + * @zone: The current zone in the iterator
> + * @z: The current pointer within zonelist->_zonerefs being iterated
> + * @zlist: The zonelist being iterated
> + * @highidx: The zone index of the highest zone to return
> + * @nodemask: Nodemask allowed by the allocator
> + * @state: The node state the zone's node must be in
> + *
> + * The state filter is part of the iteration rather than a trailing if, so that
> + * this expands to a single for statement: a macro ending in an unbraced if
> + * silently steals a following else from the caller.
> + */
> +#define for_each_zone_node_state(zone, z, zlist, highidx, nodemask, state)	\
> +	for (z = first_zones_zonelist_state(zlist, highidx, nodemask, state),	\
> +		zone = zonelist_zone(z);					\
> +		zone;								\
> +		z = next_zones_zonelist_state(++z, highidx, nodemask, state),	\
> +		zone = zonelist_zone(z))
> +

A question on consistency. This one is a single for statement, with 2 new helper functions.
for_each_populated_zone_state() in the same patch uses "if (!cond) ; else" form instead.

Both forms keep a caller's else correct. The only difference I can find is that the if/else
form give a -Wdangling-else warning when the loop is the unbraced body of an if.

Is that the reason for the 2 helper function here? If the warning doesn't matter, this could
use the same short form and drop the 2 functions. If it does matter, should
for_each_populated_zone_state() be a single statement too ?

Best regards,
Richard Cheng.


>  /**
>   * for_each_zone_zonelist - helper macro to iterate over valid zones in a zonelist at or below a given zone index
>   * @zone: The current zone in the iterator
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 607373bd83ee6..28a456c3f5964 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -386,6 +386,10 @@ static __always_inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *ori
>  	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
>  #endif /* MAX_NUMNODES */
>  
> +/* Iterate the nodes present in both masks without a temporary nodemask. */
> +#define for_each_node_mask_and(node, mask1, mask2) \
> +	for_each_and_bit(node, nodes_addr(mask1), nodes_addr(mask2), MAX_NUMNODES)
> +
>  /*
>   * Bitmasks that are kept for all the nodes.
>   */
> @@ -411,6 +415,10 @@ enum node_states {
>  
>  extern nodemask_t node_states[NR_NODE_STATES];
>  
> +/* Iterate the nodes in a mask that also belong to the specified state. */
> +#define for_each_node_mask_state(node, mask, state) \
> +	for_each_node_mask_and(node, mask, node_states[state])
> +
>  #if MAX_NUMNODES > 1
>  static __always_inline int node_state(int node, enum node_states state)
>  {
> @@ -435,15 +443,21 @@ static __always_inline int num_node_state(enum node_states state)
>  #define for_each_node_state(__node, __state) \
>  	for_each_node_mask((__node), node_states[__state])
>  
> -#define first_online_node	first_node(node_states[N_ONLINE])
> -#define first_memory_node	first_node(node_states[N_MEMORY])
> +#define first_node_state(state)	first_node(node_states[state])
> +static __always_inline unsigned int next_node_state(int nid, enum node_states state)
> +{
> +	return next_node(nid, node_states[state]);
> +}
> +
> +#define first_online_node	first_node_state(N_ONLINE)
> +#define first_memory_node	first_node_state(N_MEMORY)
>  static __always_inline unsigned int next_online_node(int nid)
>  {
> -	return next_node(nid, node_states[N_ONLINE]);
> +	return next_node_state(nid, N_ONLINE);
>  }
>  static __always_inline unsigned int next_memory_node(int nid)
>  {
> -	return next_node(nid, node_states[N_MEMORY]);
> +	return next_node_state(nid, N_MEMORY);
>  }
>  
>  static __always_inline void node_set_online(int nid)
> @@ -481,6 +495,12 @@ static __always_inline int num_node_state(enum node_states state)
>  #define for_each_node_state(node, __state) \
>  	for ( (node) = 0; (node) == 0; (node) = 1)
>  
> +#define first_node_state(state)	0
> +static __always_inline unsigned int next_node_state(int nid, enum node_states state)
> +{
> +	return MAX_NUMNODES;
> +}
> +
>  #define first_online_node	0
>  #define first_memory_node	0
>  #define next_online_node(nid)	(MAX_NUMNODES)
> -- 
> 2.53.1-Meta
> 
> 
