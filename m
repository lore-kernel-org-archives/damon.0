Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A843148D
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417174; cv=fail; b=NwKK6OKc4a/uXnyVf1TsdLo2UE6qIIuB62AifuxAyz0k01k5U4jXazZA19QKocKI1PeCdij0oqFZuN0+U85b1HguARunIHZF+jWKYsEN+khSdMrduy92xLLGeEXNw1+yllTA+QSOHrqS9V1jKhcr9W3Mj2uBWqmmLSEpXmg+CyA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417174; c=relaxed/simple;
	bh=bpn/LFLN3msSY6Ht+LB4nxVHc3r1RmBrv4r+CAfSmdk=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cfqShsoxkfdlWyZ/u5O1aGU6P9mdDC6gje6iUqotLH8xUctQZ4WzziqgxLVD0ZqxYGyTELlJkPg/tAabYUsP9srTcMZRPUcTYFkU1fvOLRj+q76fb8I/m8e74VLdsu4z+rzETXmygs96uRNqxjt3mgOfdLRjiHmGU8bcZcXwYmI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lJAVj20T; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lJAVj20T; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lJAVj20T";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lJAVj20T"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xj+2RbAPC4yihMJjEr9BeWKMt05zPgxTA0BBNdrg6m+xbS6r8ZgKdJPtaWfahuei7TACvWLUWljwsHn7CJ6vviAeB5yVZoggAHOBWio2PRcu2HkbKjHjtc9LRB6hVyckTfB06KPZmdoKfEO7duP3gRDH7YEkS6zHc0Kg7viEwZdQvBzHAc4NPifGxSsnhbORweF50GGgHZrmcQ+GN4PM7PvW22/4vDRC4BVpjJO7s/OSbln7g3P1dRMvd5cELGA06kDJq3LNW8mrobVLAvumSgAkE17Qea2OzaZe9cK2em0NtOkCZSbJgV707/K6QwyZNb7zc+Fp0iTizCWbCukT5g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQZW+B7zgckTDD0haxJi9xCCLpf7V5m2hM0k7yoDU4M=;
 b=uWNKYiiDCY/FpsK27glNSY9Ujtzd7jswbLCeDyOU1Y1+euvgC74XGefJcA5kWJjBOBt+e2aSjd5CL1Xvuv8Oe9TuGXVXyMqMaP8e+FVz+ZRfpfyAv+LmK/XDfk34qj6JXQQ16AZp7DT2dd/eDGe3EUQSsMmuyduPF3XvUXb3WuHgFUhFyFhZ7WLiwglSXmmVDjouqO2UJohSGtGsV+R/9FUQ+OKTfOaC8Fbw/F+OdKrN6+8GIOYiaAlNUZQ8w6MyrlT+79YCzwJXswv0dZDTm+BtYOGoG51hzXhsJJebibZxqAeeb0LBiHUuj0gnKrmGoqML3gDxVRpDhLeYDZCO9Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQZW+B7zgckTDD0haxJi9xCCLpf7V5m2hM0k7yoDU4M=;
 b=lJAVj20TaOQoNE2FeZbkilvS81u7tHGQZ3LZZMIShp1rOXFQDO28HhereLybauXTgTLFkKhUqGQp/vI3TCRyw1s2aeDxESh77xfSSMQxJkVB6e6nJ7PgVVvV/QsyTjX8EEHGerKuQE7S6/DeeMbekH16okby3YYu78cKGgsSA+Y=
Received: from AS9PR06CA0711.eurprd06.prod.outlook.com (2603:10a6:20b:49f::19)
 by AM8PR08MB5860.eurprd08.prod.outlook.com (2603:10a6:20b:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 13:12:38 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:49f:cafe::3d) by AS9PR06CA0711.outlook.office365.com
 (2603:10a6:20b:49f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 13:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Thu, 30 Jul 2026 13:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRaIZg0OtleIlPYF9fRGjQgEDulFFA4oqKbKEgDZmJsS1026axwXb3wSL8u76K9bcnOfOdJDW0J8O9Stt4YwDTwjWhsz0Pf/JveP07mUskfbm01vTppSS6Mx7xE7HgtA59dH3bFmKGPAzdtFDW/SgGa/WtIYKL8Xe+eepsiEELlhSQKbGBR4w5nwPWO6+Gq4CjBtrjfupWwR0xOlTcc/J2UiSSdmDhWQH33OAFaeImWgvP1Pxq+7zr3FcHdBF9/Hw9uZprvjXApXb4ThZuunrxgPnSYkKQAcWF39sJXBJTGTrLh9OlRMF6WT6KKrBc3fxmJrbO1Jf4nBp45ZukFwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQZW+B7zgckTDD0haxJi9xCCLpf7V5m2hM0k7yoDU4M=;
 b=YOToT8jlJfifOb3Pqsmabq1zSS0Ji07lJFrUlvNbWkaZkCzsyYLnfH8r/PL9SjNAgs7OoAFXoL6Z0ZXDuSioc2dvGAfYJXxKb8v0IzDHDti3DiInLnuUQdlYEGlYTHLob8rV7Ptz4vpOdZ8ZoemoWOIWWqv6gY6cYPDF6HP2oBe9qnoXSbi+SiaERsuHN2AR0glncLLkIyCO2gn16MLgU7ZmprOPwox536LYo0/j6ZZILqA0lNNdgs9I4zoQqLvTeg/o2gJ4oDtbdfutyQuylCowSyIU2E2mtOjmOSPQ0YMGfrZm+y+nphPvk8wcf7YmOFPyBklUOGKgASMxnNKJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQZW+B7zgckTDD0haxJi9xCCLpf7V5m2hM0k7yoDU4M=;
 b=lJAVj20TaOQoNE2FeZbkilvS81u7tHGQZ3LZZMIShp1rOXFQDO28HhereLybauXTgTLFkKhUqGQp/vI3TCRyw1s2aeDxESh77xfSSMQxJkVB6e6nJ7PgVVvV/QsyTjX8EEHGerKuQE7S6/DeeMbekH16okby3YYu78cKGgsSA+Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by DU0PR08MB8953.eurprd08.prod.outlook.com (2603:10a6:10:464::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 13:11:27 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 13:11:25 +0000
Message-ID: <2203157b-0a88-4f42-9c15-b1696614d74d@arm.com>
Date: Thu, 30 Jul 2026 14:11:22 +0100
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
Subject: Re: [PATCH RFC 06/11] mm/kasan: use hw_pte_t for the early shadow PTE
 table
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-7-usama.anjum@arm.com>
 <e3bca247-0644-48ac-96c0-ea69b23cb11f-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <e3bca247-0644-48ac-96c0-ea69b23cb11f-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0481.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::6) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|DU0PR08MB8953:EE_|AMS0EPF000001A9:EE_|AM8PR08MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3c6d33-7e14-458d-834b-08deee3c3ae4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 A3geUA+4p5re27ojxPsMilqcXfe8IJ7nI4+D10DCbVZaXhB1UI0fkgENFQvlp++zbEYirHCtgaZUBpLkHWwrCyQJohIneLa3tuj/61DV+DCJVtR57C9dq5LrHAO3sVqaGvZsj5agrY63c5wMB1FR94P3Gt7QhDVLu5cACXNz534fif7gHSgBHK4wBj3h+q9jXvZbde2gflnmlDEwIMHWS0CAGcVQmoH4PhIQio5UvYBKtwdbHGZpi1MSxg80hZ+ZEX+SVgRJKVWbPjuamkmFEcQ4ls+kIr1ODilp9YvLSEyrgexN56udDGyGcIqxKfY4e5NZ4fUEDH10iSh2RjToHcMrSHqXqBfgg2LLdBwIOaK3xYxpTPLWMN2bd27YZBI8aiP3Be4TFTH2Wkp2J4FooGl3lhPffk09pQIv8KIheJRm3zqKzuaWwyPSrO3CzGNlhacqPW5xAZLvsMRhZYvX/5yVF6AKxLj2uPOlobCeKhy6Dl5yEcSJw/ukaMhmKrfDHu1chfllhaf33QukxyMjKGqi0GsNliwTww1ocVnCmbokO9+67cjdNU5uHB5NoaUXF2rYmNL8wSXTUmVIllDikFU7cWnCwkL5caa4nfmRpKVxHpX/joTt0HGkJecPkfvS+3pAikU9LsvgbZbONBulpswO3cMkybt56JsNdI6vaC4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 pGNMqoFxLradfRwtZU0HeZlDsmECcdkuaLVRTDL6qPOVnXuuGO7JtOkW/QGzUUum40KYRW9JE20k4bMoR/JVQObFFCh8SMBrJ1LKWlC5KnzCtIAjzTMrA0H3bIvy8aY4tM/+cKxg92fwbS/30ixXRzG7gDQiNkih2WzNy/tDl0qoZIhyA42NNxZ3qW21lYesTDKEDV1tEelcwrj1oVNVNsvC2OT+2Lzl/cP1yigX71cV1ujvMIAZXBkyN7kxbJ614cB/v/WKUu+t0qcy9ChYHwAbVmAlaBlARTkZ3Q+TX+IE7vnN8i0wbCnaSZactLK9TEIfnJmqitXZEm7sIcZOIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8953
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d350bb23-b4b7-48a2-6f00-08deee3c0f46
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|35042699022|14060799003|376014|7416014|82310400026|36860700016|10067099003|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ho8qkkQ0r0/YE8VnIHEpBqqKoAfw/UMgR/4vgLYyKI275IEF49gXg7zsrQZq/35di0rSN5S1cXGEn2CKZS6cYp64tVgFRBydP6Go8cBP99rq/ASXWI6psXeSG1uYdNEzjL3r52V4ePE6DfaNvySg2079qmpJDwHqVTZhSIxk8UL5OQ4S6jrEeNUxqzHslZ0P8v8ADkGDmu+bFBMW5KfTf95O8tQR7eOjgOkkJkdb4lZY1mR66U5IkONmrONmboKuNTQLRuw8Cpis5uP4zaUd1V/82g6SUpSCSnWFDbUgsFFEg/x3d5Ufpol0VXOmW18FTFMTbLRkD8Uf4xCN8Tozab20mDi+wFikzrDNwgT7yl/iluIipGCOYe55JpM7LxzzW5O2WPryRIPu8wwSF5jkk54YsRNiYh9i0IcUxTOtl5z/09oegZPQ0EwOSrbuL0zgLnLYZSM3Z7LV2Ks+HA9HT1Kgn9G2jz363wjdn3lkRonMxECHBh8DUoCJTpjYXVfmp2tkZsq+KasfcUf8rSB4HiAlCLEhhqryp+ihM5Pd3GVpwKe93oVlvrZHWs/P71CSPzigBNiFdh8Hxw41wV/MmbBnj5iqgmAso4VEg6msfOoH/c396SOSgpxjLxbSx50Ug3x+J4eAUgl+sWjHRE61lE7uRj6m+6XEqpCaSnODBvuGCW0QGlovWAlbwRnxJXFUa5KQtkA/VFUNZiTRt6HuGQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(35042699022)(14060799003)(376014)(7416014)(82310400026)(36860700016)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	34V6q2mmnPgc+/KzDCBwRLTGPSLaexMb1J5vcFC+cLNBidXL2QCXNfHnln8R0gxy+87fGXtQhQIhW8rnGWHAGkRZ+ycjVdjaDLKL9NRnPp6f1+fJCZYSimrXoif+JMm8bn9S3ZDUL0gfrhKy1CafHaqB5ZCXVN/vY1uGOt2xs7mMGEuSW82YAN3cNE+Wk3RE4oaKak3nwgSSTBRBSm5qTEHBLOEkjnr5ioXZBVtBrzY097XFLXEAYSoG9ASH+mwjSdMKU3frHtAF1w8hH+AYm/IGS6xJa4R/OhHPb1rVJh8imPmi7+Skzfu3tr64SNI0KVt1G6KEFSVZvpyjAbzR+T/7/QZBSvyw9TgOgJrDDvRuZfpN2g8sObmQ6SgPcR7e2Hb7jGXIzz2yB2x3wkiQ2chDWn4hUnFJAzjWpJ+qxLiUMSUBrjccIiUB91ywqUp5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:12:38.5746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3c6d33-7e14-458d-834b-08deee3c3ae4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5860

On 30/07/2026 12:26 pm, Alexander Gordeev wrote:
> On Mon, Jul 27, 2026 at 05:46:57PM +0100, Muhammad Usama Anjum wrote:
>> diff --git a/mm/ptdump.c b/mm/ptdump.c
>> index 376880071ca2a..8f19f20be3c44 100644
>> --- a/mm/ptdump.c
>> +++ b/mm/ptdump.c
>> @@ -19,7 +19,7 @@ static inline int note_kasan_page_table(struct mm_walk *walk,
>>  {
>>  	struct ptdump_state *st = walk->private;
>>  
>> -	st->note_page_pte(st, addr, kasan_early_shadow_pte[0]);
>> +	st->note_page_pte(st, addr, ptep_get(kasan_early_shadow_pte));
>>  
>>  	walk->action = ACTION_CONTINUE;
> 
> I suppose this chunk could be posted as a follow-up to commit c33c794828f2
> ("mm: ptep_get() conversion") independent of this series.
This hunk has to be changed when the type of kasan_early_shadow_pte is changed
to hw_pte_t as note_page_pte() expects a pte.

-- 
Thanks,
Usama

