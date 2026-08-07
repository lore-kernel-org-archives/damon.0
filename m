Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD538F65C
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120017; cv=fail; b=cG6tGP2QdznjdmsWG3YjKgCIJZNVAzL9A2RuGO/1g0eIBhfnDStRJTKPnTWjNdwaYyM/JeO+5fwqcBQ/BUJdxBNl0seWxYvseiuVCM4mh9H4XJ0sUjk5cU53FPErqbwGK/pEK34zHYHl4WlUWMSpWsYAJuhqEhlKxqKiHLs8uwA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120017; c=relaxed/simple;
	bh=ivi6SkSu4KC5kFkH+SMpwmoPjZrWBdMtf3OmP4UnPnU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KzjHBgdKW7auyeO/HUZ3BdsrWSU5KtqdDgp09FfKVJ15tVgFAdAWx5psgnCSFYKckxJHU32cDLaOxpwjdN2CTkqPN842GS0AIAz9C728SW14ecWnGmRLzuFdfk1nV27Ze5N/b/KG1PlbkwGyAuUHI4qaliMkjeW25Rbnx6Gtows=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LbE4HoBx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LbE4HoBx; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LbE4HoBx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LbE4HoBx"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OH7W/PLeSe4jSP//L7PTxWuyT7sVUq0VWjBb2X92SD6IOTeSUVbLKNYinlGg6gUumdzJZHW8eS39YpEEZPayp3dmxicTVpc/7Sun4jZRwSqg5tLlxJQeaRiHKytth821YUrqKcZF52BHiRAZF/gxK5fTjIWOiNIlaOFcdf3p/JEi2qlteIQPS7M+KDXZuAUJyv3cPNz+yc68D3xzUAdOmt9lrC9xl9fP6USkWWgb4Gw180edUM8hMz7W8rC2MIDHNcLaDq4DI6c0KFfYHkOC4rQp9iOgegULHj6BY++nKbabmDnhsPCxIjLkDalD6UOnNRBqGSjCZEZRZhCFbLWm+A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS1lmnXLC+3vPC4LjFRguif+C4PkJMlmWukiMTyIh2c=;
 b=XmCYGuW3poOsu5wcPWQonMkOU2sSZqMKl0IYaTOL9LgBR4sCJI7KAirAqFXBe2zGFCvlXLcAKZJ2ALQc2p9NbnrN4+fNET0chK92CoShMDktfnj9yYPo+6pMOK2RNVqY7cchH4/yuU/JC/t2Vyaa2yuSRQwxUIfFgI7PaWJyWUjfHmacyWj8x0+a7V67wL9QqWwvpILF3kHV2Nf8g2IAfPmIfIIxcWHJvuAsWiQtINicqlWtT7xZRHoNI/b9snAR7/ozqTzdYwpnA+Cz0OYYovd1kXGCwqWmwbWqGKVvkIdtgXW4Zn32rLttseMJVtmvnPI2urh2+cuFAYUr0bVd2w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS1lmnXLC+3vPC4LjFRguif+C4PkJMlmWukiMTyIh2c=;
 b=LbE4HoBxjfRtlY7c6ZHDXc95qdWRroP7GkPtXzaFqe+eQxYuiOQOAwMBr7zadR4TuTA5v2UTuXmiECUnpZtueKfuejTnnfUkBfLrYjyJgXAvWpK0ohfjKh71EC1IompC0jkrflMssKe0/wRqt9RdzegAqcf5Dc1XBW/fb9/q1tA=
Received: from AM0PR10CA0059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::39)
 by PR3PR08MB5849.eurprd08.prod.outlook.com (2603:10a6:102:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 16:26:48 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:20b:150:cafe::90) by AM0PR10CA0059.outlook.office365.com
 (2603:10a6:20b:150::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 16:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Fri, 7 Aug 2026 16:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBDF7vggKyg/P39qymfNUnPXNLSQX3uZtATlVOwaLtC8TwntOHJPr284gwOOE6pZfD9pmyFHAa1UmVfQW8bWlKsBhgNU/ouiGX+26VsQpjWXWZ03OJBCOzmApMN/ySTKE8mQDBvgdWMFtoxsru3C01DYlr7vL3iyKVBB5c54bw0QQucf/VJGVkwhwn0z/NmQitzGga1XjI0FH3FYglUvWzdpCvBaLvOiejWwJW7tBPnR8nOSG9qg1A/4DhkmlwKTNOGQjqPvIBUIIUSuFkWtbpulF3P6v2SWp5fzB49KalXQ7i7JhAcvUoHoajLSseZYDQIz+xv6ilzZFCFfYm3ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS1lmnXLC+3vPC4LjFRguif+C4PkJMlmWukiMTyIh2c=;
 b=RvoYgMTkY2CEpoffjFhgvcG6DOqoHwEYbJ3Ie40Y2aRdAowA7ORsQl6ZnFxPWEiRodcf+LQDB5UOCktktQ+uxJAXXkH3XltD1V1wzgI2rtyhQsrVcO8xIqGBAnRZ+pnWcT0zs6U3BkS0mNhhnOV96LiBzjqE7VbRskZWsDvkN+P1KzSRZcbvzKEh42wx0U5sjamKWFkxFTgC6XqVLLTJ//iITABk8mNNNio7hfW87kMwg27jLdrB+/9eJLsIyVTVEgYOvUXJ1zW80G/r81Ak3LDbRkKk/TMVrZf9o1etFK7qrsmJCJNLp2hUG362ZxNhsBXDxRQjMohSfbormJVZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS1lmnXLC+3vPC4LjFRguif+C4PkJMlmWukiMTyIh2c=;
 b=LbE4HoBxjfRtlY7c6ZHDXc95qdWRroP7GkPtXzaFqe+eQxYuiOQOAwMBr7zadR4TuTA5v2UTuXmiECUnpZtueKfuejTnnfUkBfLrYjyJgXAvWpK0ohfjKh71EC1IompC0jkrflMssKe0/wRqt9RdzegAqcf5Dc1XBW/fb9/q1tA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by VI0PR08MB10655.eurprd08.prod.outlook.com (2603:10a6:800:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 16:26:07 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 16:26:07 +0000
Message-ID: <5c329236-7761-4e42-a549-b822e43b4358@arm.com>
Date: Fri, 7 Aug 2026 17:26:04 +0100
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
Subject: Re: [PATCH 6/9] mm: convert PTE table entry to pte
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-7-usama.anjum@arm.com>
 <fab9fc78-1e1d-4d5b-a9ca-92f3ebd04108-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <fab9fc78-1e1d-4d5b-a9ca-92f3ebd04108-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0420.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::11) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|VI0PR08MB10655:EE_|DB5PEPF00014B9D:EE_|PR3PR08MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: c6724411-c0b7-485c-a07d-08def4a0addc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 1mEC+1GW7muqv9YRUa+5/AFrrrerVojSEnd0ecaTJkfa3ovLhwzSUtq/5/iXk3EltNs1VIgCRf8Zh7GTAr6czHLzj1LlHiHnMTDT5Dcb24wAlC09Mw+6D5YHPspvL2sx1EVI20obl2sTrjQoXjDCgA7aBVp0HoJDluRDuV7/B58aAjYrXiLYtdilyVB/c4ILJZct9XSAPErba2JDglH3GKJD4ype/UD4mcHzequXHk1JMOE06O16tguwAUEIG0u+MJ8ggTWNqgYTzNOd6MVIq6sd2hHoWdX2Y2qjuTpQTX+YA2OBeZDzPK349/Ui6sl0RztQtbMC3yY/MuAf8RC0UbnnCeYg8DCCD41dNdhUatK+JRo5T3IK1KmdaqJIqc1SsTX08C88FG2Lg8b1iyt7B2jUsYSIVllojrtRN+9N6ntm73XxGeP7W/EKk2HijMVLt/zJ00cBPF+s6ehrAwUuLcXR3bFWdCxqikr9Hu5qgLqNLiBeQyU9LZ3Rn0uE/AjKJr7KxBolhiCVsfoUtLoROh7bFHlrC6EFaGGtVgi1y6ZHnr30Pd2XXuuZe89Ym83TMhdg1ihZmFB2EXbHj6gKjLziMPVkfqXTj4k6Xt+iMxg68NNxRNU+gVap/tVp0ZnjQsNUaocWwqx1SokpwWWnu8VdsKL2mjWzZqYQVxBsrn0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 dn/YewereVVzC5A5tIWzHJtVSWhBYpgpDSi5ALQzfsiowfVbPFqVXI1S32+w2Gf3hBalkT4ScA+EB4sUwudcOtIJhjhR9aueBLUTgRnHXPmr0dbhEUDZJ+v2rrucvP3u7iERclCslQl2A5NyoZhvKU3h4jrT3J9OorOozCFUP/qcN/HdbFVtvnLxCOyew+JGCZ6WkqiuZJrWgmbPl2r9U72xSp7bx/EmXd8DnNf3SnfIcujY2BMitEtNTLz7u55xSDP2vPsc11Dyxs/oe8ZFQ05c4AHjsCyEnqkcV8VIhBM96NYmH5IBO7uCDB0P5KyPkh6gWTBXXIEFZ97AzZVXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10655
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0a4a3d81-f480-4118-d51a-08def4a09582
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|35042699022|36860700016|7416014|14060799003|1800799024|82310400026|13003099007|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NZ3bIJ884+ZyHM2XBurjUf1NmPKYAswdPxrWwZIrU83idK8YX9Bc4KWVr8SFJk7Hv0pxrsAkbB0MVnPZHjaAwWnV13WDTzvmpPfA9+34rdnGYZEbTK6yyArp0uDV1QfG5YlYkRLjoEBwbMhmDlCukitAZV95ADd6esr+n8NkXGaGuTG2LlrRZHPjAtgTSfMSkDlqohYPpRM1dm7ooqC6Aqf2MAawvS93MSaZTBYk99pY2Lpfuzzt/3Dc0Z0aDt0yB0atmY4QsEbO0aHdZQUx2IgDteNUZWYb4IN2za6kA48uY+xsEfYkjYdNgGbOGwLyo59D9gCQWGegrQqVDVKpxRJj8VZXfjO13h/sNAOx/2p33obd9RV/I/w5BM406ql5YOet0XU50VSBc5spOVjqIpE1UGP4duW1dTquq2ZMdCUNY3iVNwZy9HzJumZhhu2HPWuBh0z6pawizSr4P2iy2D3C8HEUOAjkGpUfUcwOsj6lizsleTNiezl1j6TEHu4/voHUTWL7MFfXyLzS5J7e948Ou15CVYtYYmix1wfqf2eMFjLujfPDWwQxFCkxUqbLMPhL1qF+m2mWPdIt5rP137/UMl1ZADDxKJrsACJlF7AXw8uSzQhGoE7oB9eLwyR4E7LiZ9kGv/gR1YcH9CLsE2Gh+qLB/HFxMPMR1cMKbumw9mKTQ7tY9s+uVwehfcFmw7YUd+UMRYkpqOxExatCJg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(35042699022)(36860700016)(7416014)(14060799003)(1800799024)(82310400026)(13003099007)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cAUcPfD2O0q7AOIL86lAFaq9WhccWESU/HVhh7iY95rtD144TmAxxyVtgp7EQp5o+x4e4WZXhGf5rdpiKB36+fNo1SYDgtPx2tc4aeZ5vjU2NDeGi7+yz3ttPIsVa8NH/3iczKCGd1Md55lZNvDPjRuWqkX/tvtNJs6s6DQNo0gmYruJlsaWscaRgr1y08A1/w+gDdzo+RetSmRvdSvhXyYtpsoZn0jwcuiz7EqzPj5a2cRHt9YyaaC2qetR7kD2CruioylzzecA1ONNeAJ3ms2miRzRrERbS4U6SP3oVsldktHvCQIxhrlggWHPf0z7rnQ1B0M5Rkpmr6BsPvlaontcE/pYocotHOfsgXA1e6Ceyb/CDdImAnsGQRmZSJ40MDR4fLqBLJer5Pj6si9x2lqngdoBSHRbqcRbRe/ZrIk3J8fR7B/eXKrYFsL7l1Ro
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 16:26:48.0969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6724411-c0b7-485c-a07d-08def4a0addc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5849

On 07/08/2026 7:58 am, Alexander Gordeev wrote:
> On Thu, Aug 06, 2026 at 09:38:44AM +0100, Muhammad Usama Anjum wrote:
>> The non-MMU stub receives hw_pte_t but returns a logical pte_t
>> value. Convert the stored entry through __pte_from_hw() before
>> returning.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>>  include/linux/hugetlb.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index bc0b9c65aa1d0..9e8b391aa4bc9 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -1283,7 +1283,7 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>  #ifdef CONFIG_MMU
>>  	return ptep_get(ptep);
>>  #else
>> -	return *ptep;
>> +	return __pte_from_hw(*ptep);
> 
> But this is a direct dereferencing, which breaks the whole point, isn't it?
Yes, this is particular line is for non MMU. In this case, CONIFG_ARCH_HAS_HW_PTE
would never be defined. Hence hw_pte_t is just pte_t and direct dereference is
allowed. I'd thought a lot about it; is better to leave direct dereference here
or use some helper. Then used __pte_from_hw() was already being used in generic
ptep_get().

There are only two users of __pte_from_hw() at this time. 

> 
> What about introducing something like pte_t ptep_get_sw(hw_pte_t *ptep)
> to be used in exactly situations like this? With that the semantics of
> hw_pte_t pointers becomes straightforward and closes the still ongoing
> "storage vs lifetime" discussion:
> 
> hw_pte_t*     points to HW-formatted page table entries
> 
> ptep_get()    is used to obtain HW-linked/attached entries, and may wire
>               extra code like [1] or [2]
> 
> ptep_get_sw() is used to obtain HW-unlinked/unattached entries and in
>               most cases is just a direct dereference
ptep_get_sw() or ptep_get_deref() is better name here?

I thought __pte_from_hw() is ugly enough that if someone tries to use it
wrongly, it'll be noticed pretty easily. I'm fine with any other name.

> 
> The caller should always know whether the entry is attached or not, so
> confusions like [3] are avoided.
> 
> 1. https://lore.kernel.org/linux-mm/20260526-kpkeys-v8-21-eaaacdacc67c@arm.com/
> 2. https://lore.kernel.org/linux-s390/650903a4-0dd9-4e6b-9d4b-3c32c5657236-agordeev@linux.ibm.com/
> 3. https://lore.kernel.org/linux-s390/b44e071d-7c9d-4e7e-a84d-4af3499a5a05@arm.com/
> 
>>  #endif
>>  }
>>  
>> -- 
>> 2.47.3
>>

-- 
Thanks,
Usama

