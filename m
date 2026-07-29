Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63D381E95
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324919; cv=fail; b=hHv3ri18Trd2m6nWdOlB0FBuJ4T9kL63tGiMm5nyOne40zDpHYwA2DzsGaMWWh5DMtpKVrgDvJ51HUB7ICy9gOTMm71ovI5B9M/2YT+UzUvxmLi5f5kr2kfDqUd1qYldPxT8CCzG2eh47qAF6Mmu8YgEIq2HWc+sG3kF9ERDasM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324919; c=relaxed/simple;
	bh=e/KHxTNE/IOnz/Q9F+dOFrMUpLWlnUaxFnRr/5IMFiw=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YWJJ2muNPG3o9EcoF0IhJe4rLDtiBeqOrjzz4PkYxG3eKHOcsdG7GrR+jd/zlBuMrP+GBaNhOlE3pXQ8NSIKpw/QQtp8BdXQzYCy+aoTsfRtbAEialFBBpMNTOum+1KFVubcHxwvSrKmrc53IILgAvj33zojrW2h/NQI9VS9K7I=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ksKtZWY2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ksKtZWY2; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ksKtZWY2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ksKtZWY2"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aceSp3ad/S6bs77hj5vixPV1ElCNjy2SDE7tt63uodJQfdvcvOUn8XgrO4Xu92cb+rNqksZG3kVaTFSw5x0j/KExEXMr1qREyA/QFlWEm6uUh5tffH54geMwd7UMpIMxDcGVcfTLJBTC4clNpmq+PsMG49PZ2cr1MaVrrlb4amkDbgMy8vI1IQVVqGwji6vS07U4mv2VFcz8QyC3cXmGOYauKsJisbf5JcBDXRytl/XKrkekuB1PavO+YIsqtyD6VCl7aCzXy9ouBTSCfBNJCfeCYz9BcyYBlwgxrji6hZSOR081YAjFQqdZPMq47lvvL83it+yFPhWglVF7w5aSbw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgo9GG3IRVIRLC+akaXKtPN8CAdRusLZrRKYCwTPvzE=;
 b=VFKyprCDPF8p+r4aOEPHvShmdxr6MGdswOjKpadBGiLezrkuLgR3RGcu0UkHzTS9o+5OikeBnVbpFCFrzETNChe/NJc5kNfz/vl7hzNVXOpmDinjhxYBRPm3QNiF41vR9f22xnSivHDv6UeZtbFOh84v3tuLy5cvWB9zEhuS6NLJkMsl8pOcJJUHOv1XzgLV5uXgpkPEEszGaw6rRbcqPIuR7Y76L4CtLOltPKPYqOwT/vGYMNauCH+SKfnUBTISBZ9SDl8O25HeWW2Yuwja3FlW8pjSiqrG0Mp0EXpYh62Rzt/XXoKwEuA5KQzbKo3BD7q+PeqnEI03soCWD8G/yw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgo9GG3IRVIRLC+akaXKtPN8CAdRusLZrRKYCwTPvzE=;
 b=ksKtZWY285/taAao6Zu94jYQ9CxkEq+fxreWsLvoSuuGlXnU8kVZuGWinZRmgHUqlXh2H8ehJfihGsewMVLpcP0p4NTP5TSWEBd1rlhEOE/htrE5Y72OIC3h18agAcY8Z7LmW4ODIa3lVlkSosdTORWVuiQa5ownc1NjI4R50Dw=
Received: from DUZPR01CA0137.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::10) by AS8PR08MB10316.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 11:35:09 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:10:4bc:cafe::8d) by DUZPR01CA0137.outlook.office365.com
 (2603:10a6:10:4bc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 11:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 11:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSnYCeslggQxQSwqDV21tCiTCB6yv8A+BS3ksQcSqchYF8y/ZNsAtgL0N35LiyfAZzzgu6CFfPr+4Z/jtZITRHUsUumNcy5zzVQAnPqM3VRufn9reQPjHWPaK8Pj7EDfD37hxf743LYKws4P1U7yZLiZhTQTebxZdAfvX0pxn8qBK/O59CWXr/vIup/HsaO52swjgJ3vZIVe6gEa8AZJVLfmK3gMj3QRTDNYKxJdKZkQvGnCTqjLIUS7CMlceliqGPUFH8bRlOqeuLnsULe/0Tj0P/2E4g0W9AMwkNBpIFShHrEEk41mfUoVPibG4ot/fWkN1/fW69dPWS3InikcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgo9GG3IRVIRLC+akaXKtPN8CAdRusLZrRKYCwTPvzE=;
 b=t0rDZriZ6OpjaJ3T+spCrkqxr0d5LZEkUqpA31+K0IeeP51GOkFxCAm2lAS5Q8F4u+dt4CDGHN+ySvjZ4FoheyMLxqAS+fzUEP5vxGEUC60TZkjJkpGBrEpiRHexoSmk49tdqfDRLFPFbhEaUy7T533Xf7eXs+VOcyrb3fPt/B9ApU1SwduBz3HHS2tK887X0YwWfuYfMY+/QuzU4kLdOyosqkubs/H7/w7YG+0PvbVto5HiaqcGCYxIHmgnJKvJwFzs/yQdDJzfyfMvIBGONVO9ZuXztwHAERguCkH3mp7H0xn/Vn9Usf3vRW8AcTTCAVVTyezLQTu4dQxTarwKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgo9GG3IRVIRLC+akaXKtPN8CAdRusLZrRKYCwTPvzE=;
 b=ksKtZWY285/taAao6Zu94jYQ9CxkEq+fxreWsLvoSuuGlXnU8kVZuGWinZRmgHUqlXh2H8ehJfihGsewMVLpcP0p4NTP5TSWEBd1rlhEOE/htrE5Y72OIC3h18agAcY8Z7LmW4ODIa3lVlkSosdTORWVuiQa5ownc1NjI4R50Dw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by GV2PR08MB7955.eurprd08.prod.outlook.com (2603:10a6:150:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 11:34:00 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 11:34:00 +0000
Message-ID: <46319967-0338-4532-b953-dbea77084fe3@arm.com>
Date: Wed, 29 Jul 2026 12:33:57 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, SJ Park <sj@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 ziy@nvidia.com, pfalcato@suse.de, ryan.roberts@arm.com,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 00/11] mm: distinguish PTE table storage from PTE
 values
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <2c19247e-bee6-45f4-a353-2fcc60db26e6@kernel.org>
 <7813b5fe-e767-442c-a356-afc1a5c567ad-agordeev@linux.ibm.com>
 <6db0a8c0-b500-4364-be3d-d3a537c61258@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <6db0a8c0-b500-4364-be3d-d3a537c61258@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0161.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::22) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|GV2PR08MB7955:EE_|AMS0EPF000001A6:EE_|AS8PR08MB10316:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f51a9c-3141-48b3-1e4d-08deed6571d1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 xfbEy9xFy2KjtgbtZQwVRo/4rDSmq7tan+BAO+pWdsGQt606AZahYR8QjfxNwepbtpCMtOOt+8wN6/aZUrVxGXdve9SNgmI8m3i49FVH1QvKzgN5iWDAyc/qG37Ap0G5Y97odKPEnoyFqd5WWCZrVDk5WcqlYn1UwCiLpvduHOQ4yKJHDxymZa3ezH7yIgpM65fy1J5UWO78alRqVRYlrkDOFWL2EaCUXoJxhmlAjJf/9UOgfdXHsNXdCO/znX3umbrqmhM0sQPcJ5r2VzRsoQeAv+i6QegXoExunECasQNkLXlSXuF1rfAjl27hyVJfWLP1kh6Wm1wg//SMzutnVr0XBV1zVP+5KkRjixIEliIfiHgPajlHGFEg0DSfY+ITRVfPTuzgauKHtZXF4IJPVHsDbIGz7qKh3qavST24XYL4oY8gg7unjuuFv0XeSHMU+/FxCkxzesBUNQBZN/20qiLgprM6KvcPUSbXs7HPQiJI0p45cXsivdzB+efiv0xLdN4ZMqtdCHKXfaRp/J6a1owLvwowpLkBOkJkar4nFaDFO7GgG4qvbOjtHKBP5iQNtpNOHdII6lgDMrPlunWF1g3wYJI2ezCDEC9O7KZd6Sf89Vm+sXMSJ5YifvkjccdnRSEDGI26zF05DhcTtdnoNfWBagvIF7AW8rx0Rv6l+2k=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 bfpSLQDM89AGYUqYoFAxdTSUxQeWzvqrXWN01Q8nSdOHv09YbMqZwEkh4De+S90bWZhKDnix564/0iluBMAaDBLsP/eTzmgwj8zSC8MqbERlfS0mpGodCyOiNyPtSf7Pe+nzMgJoUgaYugPoxE6pM543p0DW/yTGW6oZ7bODJ5DM1V+j55iRlovzyeqTGf9Sb2QjeloUSNBQhR4N/qRtUg106VYsNxb8LiTmvTM4/T7wuyg3rWvD8R0cLWaftev4/sKlE31/5RJ3yOUwg/+bPmqGyASd1WLyfVazwE4VmC1+AShpm0prYuFDu0FzTmqdeirtBDGb4Y/uPepsm/ldrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7955
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	191f0cd4-83b2-41b7-9c2f-08deed6548c6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|36860700016|23010399003|7416014|376014|1800799024|14060799003|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7yu0ADf3kwsrMfse/Z7t8wn6KwNoRZdirzCh8eRzyT54hhpCcDY2abMXDixASMOdYGTYfS7Hd8Rv55mmGNpzi3J4VQQIToBLeKRD9qVT2ybSdUsXLJvwcKgscd2Qma/yzbexrHgfakG7CmirjQJa7mwRYc9rD9KyVBujTy75c/K7Uob5NMbpNttYQtMsmkIPGSEoiBZXNLf2bpv4UAmE+purHne5UZPOYAsxAdQppnwxT9kvlZyqLAIBXe0HFK1WkDfOf4tqFy1eiZc9584UjyfuB63u6Qot5VLndLdnkTt2KvRPjymv/MX74fAd04lheaDXqqJQ6lG85zUng+e6tCdIeO0Zc091j1sscGZd/CoYeKMGh03Ar6cWcn71k8rcxcz2sjyYWyu8nqi1qm0azNOpCWrPLLtpkDRpuRF9r03bu7AEJ6S7oHR1+VCOBoTooh287UjuHHk026SP39ptAKJg/1Oe9DBPhySUbPkMHiYtLq50bKegUgQcZK16i0DsjJBEJLuiYU1J+EEgVZdzrDQH+ED5kES57RpbchiK+vvnZ+A3CXO+Ehu19VLvIysrYuYPYgswP7FxslqUC9hL7i2jYcOansyaPdHaLyol+7DiVx7Q/TaQ7JdzY4+2ERPNDEJa37YhdQAqkDXTXqqw6F0OoTewL7CmZwz7Kalx2CFleebfLpDn4EssVcq4pOXQinq+Rm8RcBZwOlxOcanPIQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(36860700016)(23010399003)(7416014)(376014)(1800799024)(14060799003)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tItzrgIADRn+gCUNrZWmvfC78+V7MAdmzlyD5zTw+AguveJ9N+W4n3AmyYSLBPQRqJwcedDwWmhiNnrYoSBxgJNxs9X0r3NWpGe8N8Ta7e3+on1+cq4vQR9XOVPyddgRm0auKmAZXGM0K6GNgBtdJTEJ/5RsWez2x3mzcqnMiLD9D3SfoMDsqeFjXdYECBCJpyQqWVmymIwnLx4LAv9mQXEgZdwn3pYdRBHdI/XBjbcjcG0saJzHsf+VHsfIJl3vwjW1RgBV8DGwjIvnCVYc7Q5X+VRHcBH2Nn9iauSi2AV8pEuGBrcHQv0iStozqtAGbRNX5XFHrB/h8FBJvC1zxtF3mVC08DQFL9cywoie06dkgJpZ4EKPVAnRtnNI0h6UN6NxJRNwtw0430do7mF31TXUMtcg5APEESUEMjOeqq8AT950HMCKGIDMOlpoD8Ma
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 11:35:08.9326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f51a9c-3141-48b3-1e4d-08deed6571d1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10316

On 29/07/2026 12:05 pm, David Hildenbrand (Arm) wrote:
> On 7/29/26 12:13, Alexander Gordeev wrote:
>> On Tue, Jul 28, 2026 at 09:26:06PM +0200, David Hildenbrand (Arm) wrote:
>>>> The generic definition aliases hw_pte_t to pte_t, so this series preserves
>>>> the representation and behaviour of every architecture. ptep_get() keeps
>>>> its existing READ_ONCE() semantics and converts the stored element through
>>>> __pte_from_hw(). An architecture can later define a distinct hw_pte_t and
>>>> convert its PTE interfaces to make the distinction compiler-enforced.
>>>> Architecture PTE implementations and most architecture code are
>>>> deliberately left for those later opt-in conversions.
>> ...
>>> Do you have a pointer at the arm64 part, so people can get a feeling for how an
>>> actual hw_pte_t implementation can look like.
>>
>> May be we need the generic hw_pte_t implementation as { pte_t pte; }
>> right away?
> 
> Indeed, that makes sense. We just need a way for the architecture to opt-in that
> it did the conversion.
Yeah and architecture cannot opt-in until its converted. So we should leave
it to architecture to define hw_pte_t.

> 
>>
>> Also, can you envision a case when sizeof(pte_t) != sizeof(hw_pte_t)?
>> If not, the compile-time check is worth adding.
> 
> That wouldn't work as is. We'd have to intercept ptep++ and instead have a
> helper to advance the ptep pointer.
> 
> One idea for that would be to let the compiler catch that by marking hw_pte_t an
> undefined struct (unknown size), such that the compiler would indicate any usage
> of ptep++ properly.
> 
> That can be done when it would actually required, so as a first step having a
> generic hw_pte_t would just work.
> 

-- 
Thanks,
Usama

