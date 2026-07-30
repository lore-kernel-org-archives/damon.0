Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6F642FCB6
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416448; cv=fail; b=et1kEbEihyr/FNQfhiHMun5QYObr4nJBEr0NEsLMT8ZGZRg93qZIxN6HSSTlV0xH3LAQZ2kFN0OI2y39PHMME9TdIVEfVEeWrCjQzrFqPUalqchNWOmpPUAICk9X2pgfA+p5Q8/9y0DSUUr2XCp0Dkmtg8Itg6SNzwhqKkgabpU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416448; c=relaxed/simple;
	bh=pKaANjAeuNqDrUj/BFvU/C6QV4mgQsIYMQTl/5Fiutw=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhSLFGDNXVCrvQb5sORKBuffHK0I3/GOLb4sOyNLnDKK//pp4NhKRatR1o6n5lJJ9k1kp8x02x2oVDAf8oBdox0pItx8PJk6U/AqjD20yRylnykfD44YQajZAMQU5Xr5Z+HXoZ0KiZbZJWgDNYDeZsxiUvUKyaC2LhRYtTu46Ak=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ehFlbI73; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ehFlbI73; arc=fail smtp.client-ip=40.107.130.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ehFlbI73";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ehFlbI73"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Pdx7EWGMTEx234Bdb1lJGX92GeqY5M1tCBCC0sEknSO3OA6lJ9KuyUFlHDhmbFBgKaVGcFNQpdeP0eYIcB6c0GaTJ5oiECwCtqnzjbcuqjOIBtzqxKfEIXLnG8Fz1QbI2oCILhjn5UQ87BfXaySANB/tC2kv6hjDJ/dvRqNjGC+XKw5jvFr0eGmuNtD40geNup5sUJBdP4r13tWW7Mp/IGLzfzwzDVWSEEbfQnCacP1fNT8oirahjsAsswYTY+S3WQwxViVcjdIe/pSpCFGKP3jvk2T8PM0Mr9PLDBBt0Xvf0piJuBjXElTJl2Do+0bAIw/d6P70kuN9BXk/uKNLiA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGN+4FAAC8jIvrpXYh0SLEvL/4I+/62MbZ2lH29z+TY=;
 b=F+2JiZEXHOYMzcm7gIKDhGxUiEBULpYvbutcP50hnqRcnYzAjFyz1k3snvedofe3XijAQcOa9ROkvAVfrirT0yInTHPTXdn7GycLaHyPQ4lcF23fpE84fyW/ZW0tCPBns26YEBSjzIeyVuNTwRhAStF0wZ5LJn5zSmUQECEvQ08NfW7RzDrZkMcjDbUWMMknT+TxLCUWEGPwPe6QUAkq8xfNwHcGTPMm9+HIY3qQ5gBxZnvmyL8luU0ZwKyPxdujaBpIw7TeMJiZwi5SS2oLV6JXnJqXQaIykVGUTcQQioin/969vmalU5vLvvPxnTYnO3ghSy59mCvCPcycvXuPZw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGN+4FAAC8jIvrpXYh0SLEvL/4I+/62MbZ2lH29z+TY=;
 b=ehFlbI73LoxtbByzSNijQF7loKC3ZeZkxXqfibb33CjVmDNBoYQoepnyr1q1+I1wvvtby/Q9VRDpUKgcH09WljEJj8R5a76S1CKxrdWBk6bf1e/WMFtGccv8XgrF/uT+BZ9ZnJ9h1+A9xjW4ASKIJeakwn8760yq3o5hOm8kHDw=
Received: from AS4PR10CA0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::19)
 by PA6PR08MB10624.eurprd08.prod.outlook.com (2603:10a6:102:3d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 13:00:37 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::59) by AS4PR10CA0019.outlook.office365.com
 (2603:10a6:20b:5d8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 13:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Thu, 30 Jul 2026 13:00:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yyx+ToOaEnOvliHo5S5zNq7kYBNmgVSRSL0orMykREc9hqSqjsYxQs6C+lu7IYnDXiqlAhPCkdvWBpA4SH3qEK3mFGCnmqynn1L1wHgf/2D1/REgmU4jA1bZUfu4FJEoB4cUaInXCuzbVMHLc0/hyx9184MDrGAS4+YSQsaH2F8L4/e0zrFC6u2XZRkGkB+IRw+ipGNzOdlsNWrP94fZj8M5j1frcD0vHU01l0imGM/TFij8bUMMESJ4CqovmhZr4gEwzrh75Y7b9jhjgHkFozLm3Ik0uwrs9XixxlPemeJLSTjwELPeh+384IKVCn7ncub1OMEh+EfEplfh0oYX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGN+4FAAC8jIvrpXYh0SLEvL/4I+/62MbZ2lH29z+TY=;
 b=OPOKjo3Rvy1I4POMIdhajtkJh+RtxKtxGV3xKvUK1yETsg6IzZIMYDDo2cAhLp1PGVZjKFQ6h+aM6JDuMdFWgOTq5x44s+3uUK1oEUbjJLJnVvcq8Ey7XHaO5Lp90rsOH65dFFx0AEyuzASd8q1VpHZVGCp1IHM+Njtzh7zFI5BkKadZCXEjFo2WWCmTIzp3QTVC7Wvb0frWM/amTwik2w880RYlT68zBtZ0gsz6n0kvCxcgn6eF0mUG3KquYfe6ExEhGkpWanzhMxR/C3/ueWLSOH7blAEAxexih86vrVpfwxsrr+Zx77zveIZpbP7Ato2fWzoLhPG2gG6HjGGhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGN+4FAAC8jIvrpXYh0SLEvL/4I+/62MbZ2lH29z+TY=;
 b=ehFlbI73LoxtbByzSNijQF7loKC3ZeZkxXqfibb33CjVmDNBoYQoepnyr1q1+I1wvvtby/Q9VRDpUKgcH09WljEJj8R5a76S1CKxrdWBk6bf1e/WMFtGccv8XgrF/uT+BZ9ZnJ9h1+A9xjW4ASKIJeakwn8760yq3o5hOm8kHDw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by AM8PR08MB6499.eurprd08.prod.outlook.com (2603:10a6:20b:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 12:59:27 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 12:59:27 +0000
Message-ID: <fe1b4098-6ab7-4cf1-ad6b-ffadabbd587a@arm.com>
Date: Thu, 30 Jul 2026 13:59:24 +0100
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
 David Hildenbrand <david@kernel.org>,
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
Subject: Re: [PATCH RFC 07/11] mm/mremap: use ptep_get() for the destination
 PTE
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-8-usama.anjum@arm.com>
 <50dd77c0-b6cc-43e2-abd5-6d44a29b5597-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <50dd77c0-b6cc-43e2-abd5-6d44a29b5597-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|AM8PR08MB6499:EE_|AMS1EPF0000004E:EE_|PA6PR08MB10624:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5c3a3c-87fc-448b-d02e-08deee3a8be1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 FC2/f3uqOPNNy96aL5tW8wkHImrCfVxh6gQab1ZKH0Q8V9H1vUmueEs6OtDiI8UtXir4rhhqasBx4ap8cYLSYxigO/kvUNlrkbD2UFdd/IpSC7NMQ5r2AdxEt7Dil8zElmXunvRoE5Tlg5sGnVdcymp/0GRd7uQDnxPOWfgMmzW1CCGhDM3v+DfMPVFosD2QLovucjpI0mdWXiiv3LhVLTTiqh85ygjUz5tiRxrntpo8otSPv4PIgvvvuRnm2hI0to5Mdar/A16FWVJK++gzpBzWDlclVVy9ObW6E9YNTB5AcXTLB2BRmht6C+LJ73SIGkvhND+munjpvjnCNX4GM+dv+iNc2yrnOKf3hduUdhhmqBZMJfBiFIXH6AC6j8q89bevK/2qXILNDQRfolUrwjbzI9gX0tiwMteCnIQTjkYrfh1NWlAMJBqRmVgkez0L1229MzW0FFHciClGqnCrHNlhG9+3JkyI/D1HQnoUBzVW2hMioefk3Nl3IAFu1t0UCQ9ab0zh4eIjPXw+czTd5wh5/3SUeVS2L3txx6cDHO6mWTMfg1iPlJNryIjRZOG4tQgZcfzHN0355IoQ1BJo9CIYMiBMGUUM/pO+t0/1P/UVaidrsdU8W1nwX5nKncAJfTqvDhCcwLQvvX6sZpr1j3KIOss8CU0HxU3z0QangmQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 PJVqIA2lDgDWhewu7hYynL9BtEIPBvddMwyA6Osilo+gjydcsIvk19XXBZt97+CSHOBCcSG1lF5ESd//62FEcnuW0Op041L9mUSopM9qIiRcFzs6jxJ5UjR3ygaJFlN1jkDri8tj2JilMkEJV/f+jXbciV8JLgAAjrVUK1FCu8cKe10e2R3XzHtcJB0d0wf+6uvadBsnplj1Vi9ZrgFvKbcSQ3nWsFAKAwekW3nE4LknTIXxlkyGUKh4agwsjc5N6hK6U9AG4+8fxKtOCwiJW0F14FybdRB0nEtZgFHfgnVXGE59pb5a47YhLFojq6ZdSXR/ked5yu0EJrH2ID3F1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6499
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4668f8d0-8f81-4de8-943a-08deee3a6347
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|14060799003|1800799024|23010399003|376014|7416014|82310400026|35042699022|11063799006|56012099006|10067099003|4143699003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q8InMwLDgllc70N/HufvW07WxCHclalesReSWfnJHun/E4bbEH8xBz3URcM3Go4z2+HPd4r77mPOS/xQ8yCVd/3GAAMtaFs29vtlYZPP3mFKwphPQ0unOaPiGk4aOdpcnNqE43frBgXosjH/lYQzD9l98JfGnZ7mU83ttDTRwDPNy/TJXOqyqD1n9sOP5bitZqmey5T5cGFNCJrvQt1OvHmPWUaQc3t9JSZS5fyfoGK83j+QQBIyafIIOltanML/FMt81rXNk50t49MGD+rbcG6Xmj7BSSESOdMAJcAwZ8dMc8ilMJwsc9mKqIpv6DVnLV5JH/W9q7l+TiEQI1i4KQJ99wHwOOzLy3hmueLcGTbEOvWtYc8kB+mtPDBdWa+CEqQZz63tuPYa7wCj7pPltDi4R2rzeFMYmpB7AhGTC9lDWEAZq3XE4bAQiI3bcVALPS5beGLrIbu+p3gn2C12RZzabWqFxtjW/dSEA5fqMg9gOzZFMKOAp/A727kf418MuE4lKMkwRRhEKsoJu68hoG5xscNiAxuYOc6BQBnZ/Beb9U0tFQGJG+GtYYjGnAT/FD2SwFYL6njWW4XAQvPAovWy2vNg8vVbYdf6l0I70F1rohjtyUt2k9iGLazkY+vMGegDygS1PLkssZT2bi2Xym95t8dwdyWLFWeqOiXenafK6Lv+TC4WpqIzkoqGglUHNPydeZEiMZoNCN5wInwUtg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(1800799024)(23010399003)(376014)(7416014)(82310400026)(35042699022)(11063799006)(56012099006)(10067099003)(4143699003)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QccrdLweX/eOhaWyQCSFkboHXjODW5wjVCh7bGR+jeMUzYQE9PTlra2AeutYkwh3VkpQzwfY+AtfK1TL2UhWxWDNt8OJOlNrktM4RejScQk1kuGd3cyG/Iy/EBZsa0NYT+2r91N8oCGPeavEesJYK3TSjELLjYBU7QNHzBC6NhBQxaXdfcT/PN1Bl20fmVwrJcGXrmvd2qqjptJcWjaBYTI6ZBrFg/ljqUhBTDlJMiVUDOGwV1rxd3RMumJGz8puKtlMi8Y6QSuRVkA3f5QPGsoV8ROQ6dWIZjPLTWpuwcfAVa5hPC4webV04CBUG3NIXOIMCSNjWo7h+rhauz6Wnl8vn8yyjIdHrwY31gddL0L6cclUQqpfSVkz0ENpClmd8Ovx2WZpsGA3b3BEJDLWIbYbqNGAImjiUBayyb97ruw2ojEC/sNHewmFK2rQMG4g
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:00:35.4613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5c3a3c-87fc-448b-d02e-08deee3a8be1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10624

On 30/07/2026 12:29 pm, Alexander Gordeev wrote:
> On Mon, Jul 27, 2026 at 05:46:58PM +0100, Muhammad Usama Anjum wrote:
>> move_ptes() directly dereferences new_ptep when checking that the
>> destination slot is empty. new_ptep now points to hw_pte_t table storage,
>> while pte_none() consumes a logical pte_t value.
>>
>> Read the destination entry through the standard ptep_get() accessor before
>> passing the logical value to pte_none().
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>>  mm/mremap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index d966ee8248b6b..ecb90ccee6fdd 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -264,7 +264,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
>>  
>>  	for (; old_addr < old_end; old_ptep += nr_ptes, old_addr += nr_ptes * PAGE_SIZE,
>>  		new_ptep += nr_ptes, new_addr += nr_ptes * PAGE_SIZE) {
>> -		VM_WARN_ON_ONCE(!pte_none(*new_ptep));
>> +		VM_WARN_ON_ONCE(!pte_none(ptep_get(new_ptep)));
> 
> Same as the previous patch, except that I did it already:
> https://lore.kernel.org/linux-mm/20260720141633.501799-1-agordeev@linux.ibm.com/
I'll drop this patch.

> 
>>  
>>  		nr_ptes = 1;
>>  		max_nr_ptes = (old_end - old_addr) >> PAGE_SHIFT;
>> -- 
>> 2.47.3
>>

-- 
Thanks,
Usama

