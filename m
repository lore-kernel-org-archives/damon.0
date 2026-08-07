Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2E3B14B1
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116293; cv=fail; b=k3XkNi87oZ9lnzxU/9fwukgzgD2B7zp5QOA+BnM2cgqoia0VExAGjgDDBldRdw1WrnJnN4CvTY+VIpnU2lY4C9KTSa3DO4lfJ/zrmR9vk3MvJ8k81cMajn6i11AehqjjRpjdKxwSD1PPqcYBJerqLDQ7WOzMx+Rt03P8JEHpPS4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116293; c=relaxed/simple;
	bh=XKrRklP/dWKdI/wyDtKdqGb7bhciH7J88gGmFLB3n9I=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BoQxJObn1ENPBP01fKoz5XnXa4pPE2VR7ppJveTiSid2vwQx8PE4lWiC3Hr/V+Vqew150btcO5EHjBAw/mX/9Xt6Y6UgHgUbUNmUbzoZuE1EdU4SQAi3KsKAPr/R+2CfSGKwSz1lvo+DME7rqtGPEH5iI3hhxQSwAwd4gv+pKu4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=enPJXwJa; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=enPJXwJa; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="enPJXwJa";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="enPJXwJa"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WsJgFKx7Spg7TahqCt+hKQjR3kPyPU6ndUJzkm95CbIp7T0Kwldn0KqlzLRvJAOIdrQmgNj7Gjbb9k99LxkRo8lThW6dsz699JBvjDpYy2REPGnY9DY/DSjjxKFOQdyUomjDJAyRDcYA+dkn3QLukQTu3rv6TZwZ7N4LICYHdyW1tADDetODNrhMuBvSPCgaJCcxrpyLrh8o1QlheAWAd5RvUbd6cUebLRSy8Mb3u1ikyoTkLL6AmGH9A+9WE+rjCb+r78MNYi8o3dZde1a2qqnXjqUhXfAioApBQVmmkVh/YCPhbgye7zANQezFrf4ZE2EgL/CUyP8ZZUrkc0+OYw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=214jEOHDvbqO65kJp7R9WvTe7aHGn+ywbFPey8CpPng=;
 b=aHoJqAaij+YGoGlKy+CblLSYrNRFqzTR+468lgWHPEJIlaBcDNEKx5b4/OCfjxNwRdPCejDHPnPhanJdSXaqN8b01DmDNgm5AWbNogFBqjObFWg7PBtPTim6dYQ8a2ikZP2rUW3DRQFsRRi5m+jqAAiJm3BkWQaheFgGlctSIkNQvkADAaaxeuwcZOYB0Dw6/P6F6u8gX1gBHMfROqQNl9OXWPj4h+jrjVtlSa0F3m77LRERcsHIqZPx61ZtXAP2LSvuH6kmspfNNHas40CTZyvmRzQAgcAZjVaQiRZ7/0O6i3+YI6C13FpJNjgZaxGA+CezrvWQBJVjf+jZSNK1Yw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=214jEOHDvbqO65kJp7R9WvTe7aHGn+ywbFPey8CpPng=;
 b=enPJXwJauFv1oQ+Zsu+QSANwW3vkwSHO6idG1f9lavXYCMDiQj7zALU9r7ZrSNwB83ddazzAia7berLLBPNVREmY+i8jUOiFiAzFgVdPhUoiSCQgYnEuLgSz9qoiTNaXORSa7/hhnbz2uAkAxi6hltZwGxaaMH2YsrtnaxNGBH4=
Received: from DU2PR04CA0321.eurprd04.prod.outlook.com (2603:10a6:10:2b5::26)
 by DU0PR08MB8495.eurprd08.prod.outlook.com (2603:10a6:10:404::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 15:24:45 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::57) by DU2PR04CA0321.outlook.office365.com
 (2603:10a6:10:2b5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 15:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Fri, 7 Aug 2026 15:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyb2Zb/LWU68b4QGwWAhlcQocb72STHW3uhfNyJ/g64lELJLAmSW96qAz/OMx/oWcaZqLK49ey50C0zOyinM7uz2f7t/rswIfJA3on937Xr6rhZb33gq8yhF4bo6zdBOVTLTTmBkHDZqbrhB1LfT98VZ4UuY+vRsvJGn47rpYM2oVFn7z917NcM2U9kmEetzF9c++WTMl6VCBZgLdoLH5eaGhWUVZSpGlwrGUhQRbJUXUyod4ZZbXfyj0kyvcfN7N4KwVdsxEpfT0a5ugq9b0gRmqdJdpiXUKBiRnGKrU20+fpbtbBQlvm3ws17MFXcdqwsLv/8+HoZLqlMT5UlyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=214jEOHDvbqO65kJp7R9WvTe7aHGn+ywbFPey8CpPng=;
 b=Iq5uLCPRY95NgPG05ec3/v2umI3pqGev6OJlMs7JnoSZa/9RU2leY3JSX/bYvrQkD0I7P1+cm78rMIHmjbqvjBW7B9mXVoMfVYbF+opAu4V+XE2BHctMeSKfr2XeJY44FM3zl1dqPfSUlfEMG+B6CiPQfIIlotdibkE9UBosH1EJPtygjT0yjeDg+eI5L/m71FQd9x8g57J2U6XhfKwPEIWMwIrh1riSh2LF+rAZ7E22DOaKucwUf1CTatrBeX0rJ5Q5DU7hX6WqB6NmLRg7PAqNEZZ6AHGC1dUBwtSis4KZ/YYk69flyBa7kLy0fsZiiWBcyjtBZR0lPz6uPGvmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=214jEOHDvbqO65kJp7R9WvTe7aHGn+ywbFPey8CpPng=;
 b=enPJXwJauFv1oQ+Zsu+QSANwW3vkwSHO6idG1f9lavXYCMDiQj7zALU9r7ZrSNwB83ddazzAia7berLLBPNVREmY+i8jUOiFiAzFgVdPhUoiSCQgYnEuLgSz9qoiTNaXORSa7/hhnbz2uAkAxi6hltZwGxaaMH2YsrtnaxNGBH4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by DU0PR08MB10360.eurprd08.prod.outlook.com (2603:10a6:10:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 15:24:04 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 15:24:03 +0000
Message-ID: <eef14e97-20cd-4b08-ae22-7636af049b09@arm.com>
Date: Fri, 7 Aug 2026 16:24:00 +0100
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
Subject: Re: [PATCH 1/9] mm: introduce hw_pte_t for PTE table storage
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-2-usama.anjum@arm.com>
 <3db8233c-3785-444e-b2eb-3e5fc5cb2f17-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <3db8233c-3785-444e-b2eb-3e5fc5cb2f17-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0612.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::6) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|DU0PR08MB10360:EE_|DU2PEPF00028D06:EE_|DU0PR08MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b954349-aac0-49ad-7190-08def49802df
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 2t3nqJ+jv2XLoMl6etGaV134C/dZQIRkfbXAbpMvG3W60rxh9JNS7vnG7JumwZOuXshH8/Khuk3XFmNjAOvraHt1FiMxY6SDqUc2bwJ7gjYZ8RtOPYKcClF0QM+zYRhnM2CHCrpr7hoXmeUcNK1NloD1WpyVejEgA1J4jgFzdItq9u6OyZXdImufdWj+LEBGS6IBmv+6/BB4ye4g2SKWQIknvPuEDBuj1QJcOVK16BBecyhY/ujuWGSnNHP185oWRvXeO9VonLi2CbWPODWWJ6+GNA1EHlmq0Q4ZqO2p+w3c5VO7/ibcU56cA9Zm1BPAr5gV3dSiIY5gBrrO0GhJM/Nz6RG84n0RW8uE6xU5lIhiU0aD67U5Nv3EgUz3WjaosLO/zSgKYoBUWVByOz+9Priy7ZB1ksCjLvXt3lJinMQPrFeYsVK6CNwe9nME7chQkisUZPHEKJn9+l8p6tsQWo4cFJaBq/z/0EYkPFoVR0A8yv0iaX3Wc+ux7aTJ/42G09Rj3Dead4InmbspUi+Ht3U8qdwytMOXQUE/LL9p10Moqf0AmvqZoPncIsUwaQ4XpIbvzZ39tWHKbpiuDcdyBJ5WqoGT7NG2PDYTvLuVLzk29GuoAKjCGC+s6nyChN0n+dYaspSn0T4UGPXwMasE55ULyoI/4NgyGnNil4b9eEY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 dlDyhQkPRofMsLRSwwlNt05buGPmBxT0qhTwS66CFq8RqMH9JnrYeuRl/dIwLMTa3S0/tZc6rtzklCAqGaMnZaEqdUOy9ty+kky5eI4h+1Wf1WKIT0YHlFeHr0vRqQZTfCnso0G6QzigOOedxx6gMxysMT0bK0ziCJd0J1RyfKzdTW8odKVbcKEuWC5tBK5BP8pSTpUvb9bqjJt22KWmnNAWz2ZwHUnOCAJKWRrFwk8vXvlbNdJcHpB5C7uykx7jnsyv/KXKYdJZ+mj0wHCvlqXKkXG1OQs27M0t8YC/n8p+GVaGFyr5QH2Su5t2Nu/Vrv2mfXu8Eux58avYedux6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10360
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	78010af5-117a-4010-9bc3-08def497e9d7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|14060799003|82310400026|35042699022|1800799024|36860700016|376014|7416014|18002099003|22082099003|10067099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	RLn8DrRAn/Cgx3+gdDE1FGA1JCtwZ5Cyldd28Myk1KPdFn3iMtCmTiOX2cIzOqrmJSzBOPjSQROORjMnWMHHh/N3zYrRVX6J+l/HMbXC5ngQjlRSkRNU9nGgUhHBfEldKPT9gzP6EvgxJ6DvPLQ3N/RerNC9WMRM890DWuce7nyl2VXlaT9UodyWIbaBBW7nRoIHYLoCDcD5kj7e9hlnb85NuSRDx1apjcU5iDKPpa7g6tACxQnZJ65gVjH1bBdo0//bJZk59xNPKn4VWGscM98XtJoyt9Vw6G2WHlnpJzSJb577CHvJdkjgHX4akOAj3MtJ0kDJtVxynIF8lz++N8tmcO7zjqspsRrvqeraA4ZDMKSBWBZlSombiyHNKlpai2M5ZqGxWu7PN+sH0DF8ZemglVm3ndcldmJ5KTECrh319mVqx0C8dVD/l/7F/mGrAZhTYmHuGj26S+gdaIDz3nZX4LQmylr6BkOOnAx1V83X2KVftv4R05rE6S5BH6pesNrXKBUvOPdrmqpiQWedIr6yYWJJtEAIOxNd2jvHxO6Sy5O1ccjjtO5hqKAopDi97G0fTBU6IzQVPTYRQJ4jLZIPa5DX50wMug6Xtn4VaeFoZe7z77q3jQUmgrqNyoC6C21uoXdGm5CuMBiZsv1jkKANG/Eaa5qQYpO/FC0ZHv/lYAkPYW/6DM3mE+yBneEWC47UMNNnbF52A5xzYEBv1A==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(14060799003)(82310400026)(35042699022)(1800799024)(36860700016)(376014)(7416014)(18002099003)(22082099003)(10067099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YfXVruQOVMnu9qAzHmVW7WFcdQnL9XI70N1a+T1mYtYWeOrmE1yot1dbZhQeTtjJZCr38eLp9BDXX0vohdNzR4LESCGAlYL8RZJ3td0QwFml5kHmz/N3BhIUzCDIpyBPKkkrySUJWcLgtnuFJPVI4eA5Veuc4TgdxlVUkIBJROom4lx42pOkLGyDm2bXPe9HA5/xkO2w8fZx0YMgbZZCAu0gQTYHUn7RQa2HQGfs0AzwHoZLsWG0VhRTKdEun0PX0DkOMOZLgbqI/YDwdCwV0pQh5pvuOdjRB71ofMlLzGzExNXFwsKCfs6E9p2Oyjrvhlw8xkxA7gcOxnxi832Qo+KoCgBfEJHBW75yFO+q+skRFNh1Dqxzfw8T1HIycZ7ZN/NkW71VgE/AS7iuW7oAJy9++9RHfF8yVFZkpqBzvVyOkVwZXf4IsGScL2K8Soyb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 15:24:45.2449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b954349-aac0-49ad-7190-08def49802df
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8495

On 07/08/2026 8:09 am, Alexander Gordeev wrote:
> On Thu, Aug 06, 2026 at 09:38:39AM +0100, Muhammad Usama Anjum wrote:
>> pte_t is used both for logical PTE values and for entries stored in a PTE
>> table, so pte_t * does not distinguish a pointer to a copied value from a
>> pointer to table storage.
>>
>> Introduce hw_pte_t as the generic name for a PTE table element. Define it
>> as a macro alias of pte_t by default. When an architecture selects
>> ARCH_HAS_HW_PTE_T, define it as a structure containing a pte_t instead.
>> This preserves the representation while allowing converted architectures
>> to enforce the distinction at compile time.
>>
>> Keep the C type definitions behind an __ASSEMBLY__ check because
>> architecture assembly sources can include this header indirectly. Include
>> asm/page.h so consumers such as linux/vmalloc.h retain the page definitions
>> they previously obtained from that header.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>> Changes since RFC v1:
>> - Add the ARCH_HAS_HW_PTE_T opt-in and generic wrapper definition.
>> - Exclude the C type definitions from assembly sources.
>> - Update the description for the new opt-in model.
>> ---
>>  MAINTAINERS                   |  1 +
>>  include/linux/pgtable_types.h | 17 +++++++++++++++++
>>  mm/Kconfig                    |  3 +++
>>  3 files changed, 21 insertions(+)
>>  create mode 100644 include/linux/pgtable_types.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e9c8567308a75..7169bea968cf5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16982,6 +16982,7 @@ F:	include/linux/mmu_notifier.h
>>  F:	include/linux/pagewalk.h
>>  F:	include/linux/pgalloc.h
>>  F:	include/linux/pgtable.h
>> +F:	include/linux/pgtable_types.h
>>  F:	include/linux/ptdump.h
>>  F:	include/linux/vmpressure.h
>>  F:	include/linux/vmstat.h
>> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
>> new file mode 100644
>> index 0000000000000..70c3edd00a01b
>> --- /dev/null
>> +++ b/include/linux/pgtable_types.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_PGTABLE_TYPES_H
>> +#define _LINUX_PGTABLE_TYPES_H
>> +
>> +#include <asm/page.h>
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#ifdef CONFIG_ARCH_HAS_HW_PTE_T
>> +typedef struct { pte_t __pte; } hw_pte_t;
> 
> On s390 it fails to compile once we do typedef hw_pte_t *pgtable_t
> in asm/page.h. m68k, powerpc and sparc may also have such problem.
> 
> The below declaration helps to resolve it using forward declaration
> and without meddling with headers, though I do not like it much:
> 
> typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
Thank you for testing it out on s390.

As __hw_pte_t isn't being used yet in this series, would s390 enablement
patches add __hw_pte_t to this definition?

This could have been avoided if each architecture defined its own hw_pte_t.
But for now we are keeping the generic definition of hw_pte_t.

> 
>> +#else
>> +#define hw_pte_t pte_t
>> +#endif
>> +
>> +#endif /* !__ASSEMBLY__ */
>> +
>> +#endif /* _LINUX_PGTABLE_TYPES_H */
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 331daf7fcfab5..31ba9ebf4aafd 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1316,6 +1316,9 @@ comment "GUP_TEST needs to have DEBUG_FS enabled"
>>  config GUP_GET_PXX_LOW_HIGH
>>  	bool
>>  
>> +config ARCH_HAS_HW_PTE_T
>> +	bool
>> +
>>  config DMAPOOL_TEST
>>  	tristate "Enable a module to run time tests on dma_pool"
>>  	depends on HAS_DMA
>> -- 
>> 2.47.3
>>

-- 
Thanks,
Usama

