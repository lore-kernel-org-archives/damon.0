Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794985298;
	b=nHdCyHYKy+O/VDoO4Bcdy3d9aig70XGBxdBPjhRdu0ZWleJfQGlwKHvibjv6SxjmP8k2
	 uFLjgP0SLrHutnuKXGDEONeJJfEZ8oy89lXwvuWyb4/yQvPzuc6N6RvBn64fiaiWU+vDM
	 RGHo2V46HWQgNHOLa0xaowF8+vkd90SLctMlRdiOvl/A2iGyvS9pXqve7awMrvnFlhA0Z
	 4FGW/j9825sEOKkf7t5FVlDjUquOOKvKtePMlHD1PJQ2mqJyhHoAQgue5ybcdEowRgT4V
	 q8EGCwE0E5ueaa3nJCKoiY7p8T1JFMf+q9C9Ds7g1mQ2sP/pUBZVRgavtIgvG0XnUSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985298;
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
	bh=XrGJuOLL59oewczUcCDpvxBHZHzjD87L6DxE9Kf6thA=;
	b=D0D23DpW9X8pvJkhHqUk7IS+EQtezAA2IvK2yr2KGlpJRqbrlA37UYxTDzvv+bX66/bA
	 Cqte39e4uU46dY7f5OsqmWyWNqsi7l/75Ft0BP32cvHe7eytYGEhAsYohNQ6/wqsJ0VT5
	 psDlimOwaPYvlE7lKBX3r8gbpCTTQLc3eHRM3GjUX/Ffj/KJXOZh93N7kCh+qDCP9TvaL
	 I6P5d4R8Q/2e5njBEiyoTBDOxiGyQPz4W720rURf72RuTVD6wsZZU4W4yZDk+KjokEAfl
	 em6cDx8BUjL3U/jlhJIo6Tqac9ZFlmgpcgu8tmtXZcTCimzHcmntRuAOgmGhJ1pSM8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pGB+1JK8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.7
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727C606A31C;
	Wed, 18 Nov 2026 07:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0727C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pGB+1JK8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYwANXddT0sNsKX0CWKO7Ij2VttuEqrF8gmeLKiXoSbM8VM2INcAoDenKT8MIpBeBYY23BCQvl4mv3jtXFA3HNNdOVCiM8Eco8vcdIJEgGBK8VySD0Bu5pP7n77sIXNRQHfNjSG7xITNNDUPclhBBALLGD63gb8g0QAdt6ZajkrRFyxX5U0CByNY/Y7uzTAZSfPS8PdZf0W94sY5uSA+OaKMCVhhhMe1wIL9aGjJ+6ZMKFV/VsWhfV0LQrVAkB06Kk6iUDj0krrFoq6WujYlUYWQ9oHeXWadgiw3l5DNNG99E1v2WgSxzZaU6bZ+20VpcwU3pfnjfneNE5OITcPZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrGJuOLL59oewczUcCDpvxBHZHzjD87L6DxE9Kf6thA=;
 b=HqWy+TNqkFdS1LjEbf/mbXEDALIP6R7s50+hEdux5fNCguYtVhOv6hAx3elMaZl0MtZQGtEi/6fkTNSkimjf8RcA8utjL6VrhZMkMbkq7xPiSpvCFFm2LACm5Zp1cQN/d8StQZVXMuhkRjpkHR01A1Ub4dQpBIaK4HeRq4cgLPoRWuTioO1aElQjjlMxfN88XGGGdByrP4UjvIuEFBLZo0j+M4qTxMu4FbmXJLByrx61Za+1JvHPejnZuHJPtyxORrE3H9q50cAU1MrOLr4HMZ9iZqSgEWoHqcRhmq8nJhvueoDUqOYzZFJCMXpw8xBnMQFu2tUyuJ5uTHuKG+pzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrGJuOLL59oewczUcCDpvxBHZHzjD87L6DxE9Kf6thA=;
 b=pGB+1JK8+prlN7L/R9OxazA6VI+53aJVNll5JnVJCDpLWIlqpRI48oS1pGEQBXwJxrins3sHUSSJ/x/MSCxEos9BcVkWM6H/aXHPKIsUZYA8lIf578cTu7WC7aFXN7Ug/L1eS9yi+c+eXY9CR+czffPKpJLltohrbkCYODWMreV/J0wGDVThwIr+I7jCelaWMOcY7dmgIhKv9hyBMWukOP4+ykgppGt/3/5ZTmHSJLpOVFVorTRS80nDlAW5kFIrFZfeId0OTAWfj7LEGAKNKhHp3t88raPhFdv1o6BWedwsyNiOky6NB6AdbEpgI/Kj6OAZKBiITR8Wc/1lWWJcPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:01:27 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0615.009; Wed, 18 Nov 2026
 07:01:27 +0000
Date: Wed, 18 Nov 2026 15:01:19 +0800
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
Subject: Re: [PATCH 00/22] mm: introduce N_MEMORY_COMMON
Message-ID: <av1DvCQd_OvkGgLU@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 514d9fe3-4040-4515-2287-08df4541c348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|56012099006|261026140227099003|11063799006|261028144727099003|261021121427099003|261022105027099003|261022115727099003|261022075727099003|261026121527099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/waEutd8lFNcOEAot8LrtlotdLQswvCxCLsWZI/acAHmuGfQvttoAlGTBrE5+ED60YlIv4TTyEZRblXELgkpFLE+iniSMO2COx8v3tmRRKwzPQDoTc/+YR20ou8N0+lcyZ+J4Wsn73GkbgVdNuCdZH9vrkOFQgzfKhaejDjthQ9E2Zbk0Jzyg3GLDwaaR7kvyHT1YA5En+Gq/A/CluGCdRsxkz1c1Vq2r3UFP9hU3YNRdtOJxYqOQaIzQUKWedTQyf61hUmz1jTo/KnLnbdNcXTHbMF/M3R6Qo45h9UzqTVwHc3iP3m/8r0Y3eewbRxrxAurbczSBLIQfpXkszHwZCISzkSYH6rxntiJnJzGYN6tFgn8KnIkaJdv9LhQSmPzJAbPvnJ146F0LwDaAt4RU/UZU1GhbJCnJGAN3q4vrvqtAvf8+uApzvRSxpkdlZ0E22VYrCD5xECaZlXNEmVVKZR4WMyZ++uAP7q3PsySibg6kMnwoHLyiCPxTCuWw8b67GgG92gnzgmbwQjEJemriwm0aJ8y7T3Rs5qATHA3wdGReACOfV2Y6AjbTclbGay8ONTtX5AAvh/eikhI8V/0dk9z740/YtcX9pKmKDTeahkgI677qqh8vvtfQDii9D1f5JSOJ/8LFtLoBf2Dsyk2V114L9tdSj1a6/lufXDKINI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(56012099006)(261026140227099003)(11063799006)(261028144727099003)(261021121427099003)(261022105027099003)(261022115727099003)(261022075727099003)(261026121527099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aosA1/g+XuU++UnQ9BM1jBmDf9jIBhN7Qkbl5js2WzBhK2OnSED+L1T9tBfO?=
 =?us-ascii?Q?ux/LjhFJZ+l2QQb1zZ55U1tMGoBiEVnXer5jKoTzDfxQrqx71JMyhVuZaiyc?=
 =?us-ascii?Q?Zb9rVoYcDNepZlvV5JvAc5R8iy0UrG7gF/3QeA9cFph6EzgWZ/vq/C9uiLki?=
 =?us-ascii?Q?ZaToUE3PnQ2qe0MFC97FcvwLWgjxFW+Nb3WOxtaUZcVqRw2VUa9JWlvSGgbX?=
 =?us-ascii?Q?+dGVsIwl6+yrzVPu1PFyS3QVSktUZ85tLFkpwaJAEA3Vgy8cyCgbxkQvoD14?=
 =?us-ascii?Q?H8s2ibDQaSTP+T0ruQ+27Qds4FulISY7e96zgz9JcYc2bsuKVU2OcGHl2IvE?=
 =?us-ascii?Q?PjkJ78TmmVX6zxd0pLiBNsM8bhIfn+uEnql7qG71h+nBrXRUMGUFr/56JzNa?=
 =?us-ascii?Q?+BN+G9QHFr9NTyjqyiYCIASyh9pYOZyjsiG2taV6rC+m9ZrGkM6kGdVQkpQz?=
 =?us-ascii?Q?slX4lc59t+VshG/q7BbY3ioO/LUmH7+r8lsKH1/+hhBG4/4UVqUNx1sIQIdd?=
 =?us-ascii?Q?zpC8ys+BAtueZuY5/NJ4IFEiRTc/mqNcgbp0f+tIzfS3VQrQnr11HonFKdcz?=
 =?us-ascii?Q?T/11uKVFNWmp5EMEH5jS8taDpSXZ+16zsI6E+AIeHGcIuAa3Uwbcmv7cstDo?=
 =?us-ascii?Q?mUL7OO3bASjzjAdnhWb7Q20pMQGGDNSIjXIZa98LT6nLcxstUFEiTAWYZVfs?=
 =?us-ascii?Q?bgDSIkGeqWF4C853kRIXT40l/K8XI5V/o4ObTn53/dR/PZbP3/UBN2IU9YuF?=
 =?us-ascii?Q?IXxCR74GqvN+U7K8nhhijnUKsSvrtBOmLFbM6hV3RnyUKTgycpKVNw+tuU6O?=
 =?us-ascii?Q?KUUe8DewlvelsiBQo5SkFJ5sJyvXwmTwaIl45hKBInTjp4Lj9rZZk16BkLs/?=
 =?us-ascii?Q?tqHRFNH+vyGbPQ+qp0Dm5maDHyPjlAr+N/tFkl85Bb4T9OHo+c4Ux0b8SthH?=
 =?us-ascii?Q?TXCpUaexBKua7DdyejYRmBi+lVJ3PieOu0wchAnGCXReqzejr8P67U86ldR4?=
 =?us-ascii?Q?XNVFSRUbxvCNEZQqP4LcndPdO6Mp1Nq1lYxdzEpOtgCUR1Brn1pRkVAXs1Vy?=
 =?us-ascii?Q?h/d8kAF0vsvr66ytF1s1nJSbkVtGayJ9wW4OMVbSn3X/Uo6xuctOn3T5rSwA?=
 =?us-ascii?Q?VAk8zXnPKKOJAvK4eVmFRMshjfk6mG4p2ou83jFFbYNL9tDsfRtIwuQOc9hg?=
 =?us-ascii?Q?x2swxDEIhKl/2ybfQBQfnMQbcRTa35LipqCQbhf5iwIN9FLwmgWtdrOtfDKI?=
 =?us-ascii?Q?w6mrS0XBTis0jgVjllCD9hoPh4Pka4r2Cla6osLDxNf83GiW3Q6hJfuD4gGK?=
 =?us-ascii?Q?f5s6azE2ZIaqhrlCr2qaNW5qBl3daHFajshsVT02IkcRiBfjURGnozmZg6om?=
 =?us-ascii?Q?p3IAQmMU6nSrQlXQvGLb5mka6T7CD0lOBX9wGMUtob1uDZ2N7xEQyAW0W7vQ?=
 =?us-ascii?Q?WQmx0CBTnS34TohStsypvAWKLYhn6LbtwBP63RDtfDJIXfWbX1NQj3MD+qpX?=
 =?us-ascii?Q?PMbAjmpXBzE7KIAOpOHnM0MHMqrURhFmYH6vON7RPrXP3jZ05zYDNXnly1sj?=
 =?us-ascii?Q?zGwrXfn9zedFx7zyq9Qo0MpxWcZHf78cQcqgBZvCf7bccxXSCxBIhkajhwNg?=
 =?us-ascii?Q?j1my5XRCeDJUJI+JLSSCT4h9lJhCyQtwiRfV1cOQ7jMeJDdd3iYTFyKRY4I0?=
 =?us-ascii?Q?T4sd97NhNGOOsHf0pc6qbHVyqw+8/bwEJb9lWTj0IC4skUDe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514d9fe3-4040-4515-2287-08df4541c348
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:01:27.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yauRTyZWkkKOev4MHsHqbyZE3mR/9uzzN6wz8NAj5N+VBsczMQwoMmKkxT81fuaGkpvtZ5td1NAfQPwaN53Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429

On Sat, Nov 14, 2026 at 02:09:37AM +0800, Gregory Price (Meta) wrote:
> This is phase 1 of the Private NUMA node series.
> 
> I will send v6 "Private Memory NUMA nodes" (phases 2 and 3) separately
> next week for further discussion - but I pulled this out ahead to make
> the core filtering mechanism easier to review.
> 
> The series is now broken up like so:
> 
> Phase 1: Introduce N_MEMORY_COMMON to define "general purpose" (common)
>          memory as a concept separate from a node having memory as a
>          topological feature (N_MEMORY).
> 
>          This phase is a no-op for existing systems, but creates the
>          baseline for ensuring private node memory is default opted-out
>          of being touched by MM (much like ZONE_DEVICE).
> 
> 
> Phase 2: Introduce N_MEMORY_PRIVATE to define memory not part of the
>          general purpose pool. With this we can introduce a minimum set
>          of KUnit tests for the page allocator to demonstrate the
>          isolation mechanism.
> 
>          At this point it will be possible for a driver to re-use the
>          buddy allocator to make uniform order-N allocations.
> 
> 
> Phase 3: Introduce feature bits (COMPACTION, RECLAIM, MEMPOLICY) which
>          is the minimum viable set to allow userland to manage a private
>          memory node via mbind() and migrate_pages().  
> 
>          This enables management of HBM and Coherent GPU memory via
>          userland tools (numactl, cpuset) while protecting them from
>          incidental allocation (no fallbacks, only explicit placement).
> 
>          The memory could even be hotplugged in ZONE_NORMAL and pinned.
> 
> Actual cover letter for this portion
> ====================================
> 
> N_MEMORY has two meanings today:
>   1) this node has memory
>   2) ordinary allocations and MM services can use this node's memory
> 
> The two are the same today. They stop being the same once a NUMA node
> with memory isn't part of the general allocation pool.
> 
> This series adds N_MEMORY_COMMON for the second meaning and converts
> the relevant N_MEMORY users accordingly. N_MEMORY continues reporting
> memory topology - and some users (cpusets) still utilize it.
> 
> At the end of this series, N_MEMORY == N_MEMORY_COMMON, so the series
> changes no behavior for existing systems. A later series will add memory
> outside N_MEMORY_COMMON without having to audit every N_MEMORY user again.
> 
> Rather than add new hooks for page-table and pfn walkers, we consolidate
> existing ZONE_DEVICE checks (page/folio_is_zone_device()) into a general
> `page/folio_is_common_memory()` check.
> 
> The series is laid out as:
> 
>   1-3   helper functions to check node states and a folio's
>         membership to a common memory node.  N_MEMORY_COMMON itself, and
>         the `has_common_memory` sysfs ABI.
>   4     zonelists: the fallback lists hold common nodes, and a node's
>         __GFP_THISNODE list is built only for a common node
>   5-21  N_MEMORY->N_MEMORY_COMMON and zone_device -> common_memory
>         conversions. One component per patch.
>   22    removal of first_memory_node/next_memory_node, which no longer
>         have users after this series.
> 
> Each conversion restricts or adjusts:
>   - an MM service (reclaim, compaction, KSM, collapse, etc)
>   - an allocation target to common memory
>   - accounting meant for ordinary allocations from common memory only
> 
> has_common_memory lists the same nodes as has_memory until memory
> outside N_MEMORY_COMMON exists. It is added now so that userspace, such
> as libnuma, can start choosing allocation targets from it, and so that
> the meaning is fixed before anything makes the two lists differ.
> 
> first/next_memory_node() is replaced by first/next_node_state().
>

Hi Gregory,

I've browsed through the serie, I'll go into detail in each patch
in the following days, for now I have one general question.

I wonder how the "common memory only" rule is enforced ?

As far as I read it, there're 2 ways:
1. The zonelist, you build them from N_MEMORY_COMMON, so non-common
   node isn't in any zonelist.
2. A check at the call site, e.g. node_state(nid, N_MEMORY_COMMON) or
   folio_is_common_memory()


Code reaches a node's memory in 3 ways: zonelist, node id, or by folio.
I couldn't find a statement of which mechanism is responsible for which
kind of path.

I see some consistent issues,
1. zonelist paths are covered by way number 1. Some of them also carry
   way number 2, some don't
2. node id and folio paths can only be covered by way number 2. Some entry
   points have the check, and some do not.

I can't tell when a call site has no check is deliberate or missed.
This matters once non-common node gets its own zonelist, as patch 4 metioned I think?

Could you clarify the rule ? e.g. which zonelist users must filter on N_MEMORY_COMMON
themselves? and why the zonelist alone is not enough for them ?
Whether every path that takes a node id or a folio must check N_MEMORY_COMMON, and
which ones are left for the feature bits in phase 3 ?

Let's get the rule settled down and make it as the foundation as well as phase 2 and
phase 3 ?

Best regards,
Richard Cheng.



 
> Gregory Price (Meta) (22):
>   mm: add node-state-filtered zone and node iterators
>   mm: publish and clear node memory states via helpers
>   mm: introduce the common-memory node state
>   mm/page_alloc: build zonelists from common memory
>   mm/mempolicy: keep interleave and tmpfs mount policies on common memory
>   mm: base hash distribution on common memory nodes
>   mm/memory_hotplug: migrate offlined pages to common memory
>   mm/memory-tiers: restrict demotion topology to common memory
>   mm/ksm: restrict merging to common memory
>   mm/khugepaged: restrict collapse to common memory
>   mm/mempolicy: don't NUMA-hint folios outside common memory
>   mm/damon: restrict DAMON-native folio operations to common memory
>   mm/hugetlb: restrict pool growth to common memory
>   mm/page_alloc: count common memory nodes for kswapd recovery
>   mm/oom_kill: compare OOM constraints against common memory
>   tty/sysrq: use common memory for the manual OOM zonelist
>   mm/vmscan: restrict reclaim to common memory
>   mm/compaction: restrict compaction to common memory
>   mm/migrate: restrict move_pages() destinations to common memory
>   PM: hibernate: size the image from common memory
>   mm/khugepaged: base the recommended min_free_kbytes on common memory
>   nodemask: remove the now-unused first_memory_node/next_memory_node
> 
>  Documentation/ABI/stable/sysfs-devices-node | 16 +++++++
>  Documentation/mm/physical_memory.rst        |  8 +++-
>  drivers/base/node.c                         |  2 +
>  drivers/tty/sysrq.c                         |  3 +-
>  include/linux/mmzone.h                      | 46 +++++++++++++++++++++
>  include/linux/nodemask.h                    | 38 +++++++++++++----
>  kernel/power/snapshot.c                     |  7 +++-
>  mm/compaction.c                             | 14 +++----
>  mm/damon/ops-common.c                       |  7 ++--
>  mm/damon/vaddr.c                            |  2 +-
>  mm/hugetlb.c                                | 44 +++++++++-----------
>  mm/internal.h                               | 18 ++++++++
>  mm/khugepaged.c                             | 12 ++++--
>  mm/ksm.c                                    |  8 ++--
>  mm/memory-tiers.c                           | 23 ++++++-----
>  mm/memory_hotplug.c                         | 25 ++++++-----
>  mm/mempolicy.c                              | 30 +++++++-------
>  mm/migrate.c                                |  2 +-
>  mm/mm_init.c                                | 16 ++++---
>  mm/oom_kill.c                               |  7 ++--
>  mm/page_alloc.c                             | 43 +++++++++++++------
>  mm/vmscan.c                                 | 26 ++++++------
>  22 files changed, 266 insertions(+), 131 deletions(-)
> 
> -- 
> 2.53.1-Meta
> 
> 
