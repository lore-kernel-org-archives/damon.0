Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3B387363
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457400; cv=fail; b=HmXZfygzhME080R6mBcjqfJR/EbFJgw7coSqvQcDJAvyUJo1cjCTB+BeQAp4+e6pck/j/6RdKVmiX59g4Go115zRqxxztyv6arSyt2XZV0Bwhx7RwN1Q9BFDMoaIUihYw8hwVytLj1kDdseS0vZ+T8tkNRnW78kidCnBUM/IPgs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457400; c=relaxed/simple;
	bh=KCTCRIDA+/2X3cH7JnYpxM6tngQgt6W0YqOS/2HDF/Q=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i5BPw0qPq4MTeSjqPMudf/Mg6x/mtM6pO4e/dxf4GrErc5bvEAhqSr9p73ebvd952RlzhUpD/9pDsuoZxwFwChFS9cuVraWvqgK4CCyWf4HQRVWI9PS4KU+Z6W49mPXa4idtodrUlRaeYjbOKw8uEjZEwYizNuOglJznncPzZag=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Of2zMK4A; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Of2zMK4A; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Of2zMK4A";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Of2zMK4A"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=v98DqEcnij9beeN/vI7p771mQgPxKYU6wFBDPLpc7u6vWlSzG/B2YC/OPxUVEAArnIDTOpV2iXj8q7vuZSQVkWj8sZuNvB1P4ZUSZp7FNdu1gaogn/FKgf5li0T5i+gMMax6kmJaSbLMA51cq//wq0CN37sRr0i69DDNdAriwyzG4UEkZiDkUl516iYAM/6K0aLWYqYkhAMyhgnyvnaFnks0fSpRj3eM+LwbjCI54mjUVkq7Bq8lg3FQFlkUFQRZs9BEknlERYmmNboB8ysJ3M4ZyaTIEK6SuRBs1QU0m9/lIAUAhrZVMznCfYO+9WcZjadDDwGsiQ9I5SYCUXpP0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spajHA6ointRyLw86RivlHQVOLc0loAJEJ1TlU4g/dk=;
 b=u074ugBG1c0wpeoSEpgr7umlkd7oChN/T7sMcosIo+GjoCC4RgD6Qy7ef4dZeC/X8T+LFtSxl6LDpCm4aJsH3d/frLsdYqIblwoQhwAmqe76P1Czw8pBt9gbtY2johIP6Necpqyqsz5/unsL6D215yWYXyuZpbGODU+rM2unw9zUpIi0y/mP5jx8yc6xenvPcNoQFPi/4dl+z+EjezajYn1nyky+4a+vs0527d1b5WAA2hUKMWH/gdG4pNe5w9p95c5odSH6MET1bb0XsID+DGc1e4hQ2BLvHf7os9h6VhDjZXehzFuAzMIfnlTUNSzaAoYtezdiq/HUzngNa+45cg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spajHA6ointRyLw86RivlHQVOLc0loAJEJ1TlU4g/dk=;
 b=Of2zMK4AYCmnRWDmgZxXsjcqJPO31mxBQjUoXGVjTGfhVwp3SdIVVi7agOghu8iMGsMktBYOl3wqspqIPSdjK9UxF2eBDJ6bk6sX1c3OJggt0NuQA/Et5PtcevurQjrhzd+EKtrJjoGYBF7cOXsfD+VKGP1nFjdL2BwS8rzk/ik=
Received: from DU7P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::18)
 by PAWPR08MB9592.eurprd08.prod.outlook.com (2603:10a6:102:2ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 14:09:47 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::7) by DU7P189CA0013.outlook.office365.com
 (2603:10a6:10:552::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 14:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Tue, 11 Aug 2026 14:09:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAp0D8fED4BIknp3JzrYjuhx/SQCyUUgLhlHQqssIAq2N6Zbn1so7sXZlziVHIj7d6R6PvF8Ffjtzn5GtAwxsJVYpCiC48lY1FRKuvfiZSsIjOzx5m0rzsNPepoiaPYMUz1G50y3QAq/T9sRgB7BwN9w9N/5R6Z/dvPN6jj2BvCi5es97DYocaURGfL86kcHhZ1Slwc/nSlmXR/BKN/XnrkkkH8IwV9gNY0TdJ1pp7/fHWC6RH/vdaAWVJV5U07z0j2Ijxbtr1LpePU5MZb1DHhnujJir1mlbvttFdbM6COV0mAusxSw6xvcW/kyWYKjFzABD7KH14UKtT0642548w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spajHA6ointRyLw86RivlHQVOLc0loAJEJ1TlU4g/dk=;
 b=iaBjCOaVhCrKf98DWl2iS/e0DsC7e2a2L3DMyqusEaofhJIZiVQsRraj6DPlUHWjukjnzf+AoDBXBd5Ox9PjTzzPv3+rGqnof+EKhq///cIsuJpOOu7gm5tcXvQs8wLkXbmtqZ/yG17mPwjxEksDitQGwZ3BuZrdYfyLesQWzPqWPhK7kueTmeaMsz7EK+6sUZMOSPcFkkNDWrBv25fa0YsWNMPqFyhGOArj1uD+rr+3ELIXOhc57Dz1C3xjDevg7ocWAmwbS63Ihia7vPkPc9ak4loMKc52jcciVQPoAiesWVhjMqiBGkrR2ZU76WKZ5dv12pZ7rzg4OvzuMYZSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spajHA6ointRyLw86RivlHQVOLc0loAJEJ1TlU4g/dk=;
 b=Of2zMK4AYCmnRWDmgZxXsjcqJPO31mxBQjUoXGVjTGfhVwp3SdIVVi7agOghu8iMGsMktBYOl3wqspqIPSdjK9UxF2eBDJ6bk6sX1c3OJggt0NuQA/Et5PtcevurQjrhzd+EKtrJjoGYBF7cOXsfD+VKGP1nFjdL2BwS8rzk/ik=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by DB9PR08MB9730.eurprd08.prod.outlook.com (2603:10a6:10:462::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 14:09:11 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 14:09:11 +0000
Message-ID: <b21c4cc9-84a3-429e-8156-0b9967b2f133@arm.com>
Date: Tue, 11 Aug 2026 15:09:07 +0100
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
 ziy@nvidia.com, pfalcato@suse.de, agordeev@linux.ibm.com,
 ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 3/9] mm: name pointers to copied PTE values ptentp
To: Anshuman Khandual <anshuman.khandual@arm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-4-usama.anjum@arm.com>
 <e7osakog3yvdewhdlrk3bsp27pwt2nnhroeb7zihlfxyjotarb@rwxkcb25crh3>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <e7osakog3yvdewhdlrk3bsp27pwt2nnhroeb7zihlfxyjotarb@rwxkcb25crh3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0197.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::22) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|DB9PR08MB9730:EE_|DU2PEPF00028D06:EE_|PAWPR08MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f22337-43bc-4bdf-716d-08def7b23383
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|10067099003|4143699003|56012099006|5023799004|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 X8qvVO1tGgOGc68Tj8e6uYIlEm61fj7Yc+rR2Ay/UJ31hxb3PHm/Vx9ayVx7BXhFCE26lvSj1FVRwdkt9qTwDUf03EfjHj5zTGh3lNmthZUPU0QqKoBPqNCZMmlIdwvntC0ETgEazcLBhiggaaU1oTVhVrF4zZNB+8zbzV+Jd4wX3kEhklK/JQF5PBzEsMQlnX/RA2nh2JKyOqzVqPIP0JRjHOvrNtwouMyn4EApYlEz54M5OIY1sJGVL2DhxYD3bw4zw1/+YIsp0Em0CEamCCEu6TYlPIaaPzdzbep4Q20xFGwIz/vtY0BuDXxxwaquypHlTctA+f8g9C3qAfi604tm9S5lbClK6rgQWc2C7gtm+k/RpQITOlu/8ySU8jRAuLryQLIaU07iwsnyadRcNDbGozKdXF53Sl5vfnr69T1lGLspteufAc2KPwXQegTPnGNpBa3XqVK3I0rj6mCz2fhoS5cgar40oNGDel28oFjLSHmTqLzlgfCXDa/SdbvfGw6kYd7pbX0X6Er0Yoa1pmDs1KkhBG+od3Lm2kLHvxMgPWvVu6+OGVUF/muODby0JcN0Z5kv6Rm9XFuwS+rujtHHfFG+S8WUrGIQGqc1z/gh7bAy38Lj79K19jGGQknUUaoEdzVxQEjI8Btl4hXMy1IFAn4QlZDRT18lnMFWkRU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 PoID+C9pr8SsNiZRZqrmEF20E8+VyYQrbmNS/atK0zw4H6xYhN8JDWaNyZcuAbKvDXx3md+N466b0729ETpNiHwGFoQQWHtr1wStuHk00WaD7R8uPTqjp9Pek556gM35mQe8FX1aL7Sp2zO09cPHEXYxt6UjkF20b/IyX2c8fU9p9FtV22m3Uikksqe9i+Rbf7inmIUq5CxSfVO/lt6nTQ/RZeCwOhVPzS6fqYMTUAmCwPYjztBlT9Knlw8LjChFicyl5+dVAtGMoyOikQxEQPeOpO5qwUVElOLqNbWdabbXkDPmBevoai7DCbgoVW7V/xraDV24EN08DFdilYcMzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9730
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	685e73f2-e898-46f2-3da0-08def7b21dbb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|14060799003|35042699022|7416014|1800799024|23010399003|5023799004|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	mJj9+g9CTwNe6lXjFWoC7/VBwsZrazpmSu60RYbieJDzwOf3IG7pmNN6fKJ5WX1yiROHiJvCdvWcTx4ypukrQf2ImeuUxQHd0DWI7OjMkjb1hbecgaB4lhP6oeY9JTmVnbo0dh8cts+/QAOVXEESeeGBqY1PNg+RRWHrIQqlO/Ti5IH3eX9fsLyWoG2E46IYsvfOOTwwPC/Gwt3rwRRgFw1mSbmSifdzuu5f0IWjnixJvCPB1sF5MsIz72fpCYN53dERvvuHELI2z9ZczTNtBoYdCdsbRt6dA9/SVQ5KjcpgJv5vWzHRC5/C9MPP/6buF5I5RLmkniwj4/Ipp9QYdDCHaEDeuno/7oEMFn/sdl503i0T4GloiVEXft35Clk5pLZxXT26qfEnvq901LHvrCw3F2bndko+9723QLev4q6EbaKnnPHp9VjFQ31bcCi6RDSntUgKHNY2nXSAO5YQ2TzN5MwM/iXLOJwa6AVlZQ0Rpt2Xyhkn2Dq05I+2HVz90DyJDvLFmxkcVbwhDjyTxe+/dLM78O9GGJAZtthKMmSS60+0duZSA+gxiTUQ2a9+0jq77SpHZQAWcPw4C3IjcVRw4pI4bHgqwjXBHpmcqRWqQxY/scxyHruj62R/1IJw66UthjJ7diHMx04ahsKz6vFLGAy5CGJjSlXYtoAl5z5kNbpRInQ+yNS1XpDHW/fwfS8gir6ZdSmj4hYQRiceWg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(14060799003)(35042699022)(7416014)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VgG6ce1egSC62hnvoCC3VleAGl/sGlqCuIxphL6dKahp74GS6+hLvWP0zuyKk+kCYAo8BbwoQtnLG5m67Z2jPdxTVqtZWXDuug+9vz1I4n9FJVH8fy1mzFq5JQV2yXA7Nhh49h53NZe+Cqi+1Loiwxap4UAcmtyKumMldJG9S/06VJaXcYaJjWAgS4KYFhXH6swXHD5MkYPtZjLjFnsOQgTNKJFuM/6qA0ySz/lXwSlMrsCOT8t186fcmBIoQqnvTFzhQ0cL2Ha2tpUz+hNBWm+/HAHju4Ounb4GIKEa8ciHydlmuSzpjvW9qitMHNgLYuBcSwLxnlxZGoI1qAj24wHnPxRFnC+thBQYVpv3bnx+Xek0VHg2FWXbM4TQPv7WbioIC6y4rMeKzFs4yKYuKnWnjXlzuWjhNm0Ji969WI4Yj46iZRrEULIhYxfuz16M
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:09:47.2581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f22337-43bc-4bdf-716d-08def7b23383
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9592

On 11/08/2026 11:58 am, Anshuman Khandual wrote:
> Subject line is very confusing. Perhaps something like the following.
> 
> mm: Rename pointers to copied PTE values as ptentp
> 
> But even 'copied PTE values' is not very clear as well.

Something like:

mm: rename pointers to logical PTE values as ptentp

or

mm: rename pointers to software PTE values as ptentp

> 
> On Thu, Aug 06, 2026 at 09:38:41AM +0100, Muhammad Usama Anjum wrote:
>> The hw_pte_t conversion must retain pte_t * for pointers to standalone PTE
> 
> We need to explain what is `standalone PTE values` first.
> 
>> values. Name the value parameters ptentp in the install_pte callback,
>> write_protect_page(), and guard_install_set_pte() so the later mechanical
>> conversion can distinguish them from pointers to PTE table storage.
>>
>> Some functions already use the ptentp name, including:
>> - madvise_folio_pte_batch()
>> - folio_pte_batch_flags()
>> No need to convert them.
>>
>> This is a naming-only change.
> 
> Small nit - s/naming-only/rename

I'll fix it.

> 
> The commit message needs rewrite clearly explaining the following details
> 
> - What are standalone PTE values
Logical/software PTE is correct and better name here.

> - How these are different from HW pgtable pointers
> - Change is just a rename for pointers into such 'standalone PTE'
> - These renamed 'ptentp' here would be used for skip or replaced during
>   upcoming mechanical change via a script
> - No functional changes intended
I'll update message in more elaborate way.

> 
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>> Changes since RFC v1:
>> - Update the description for the architecture opt-in conversion.
>> ---
>>  include/linux/pagewalk.h | 2 +-
>>  mm/ksm.c                 | 4 ++--
>>  mm/madvise.c             | 4 ++--
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
>> index b41d7265c01bc..c34d826c5e4a2 100644
>> --- a/include/linux/pagewalk.h
>> +++ b/include/linux/pagewalk.h
>> @@ -89,7 +89,7 @@ struct mm_walk_ops {
>>  		       struct mm_walk *walk);
>>  	void (*post_vma)(struct mm_walk *walk);
>>  	int (*install_pte)(unsigned long addr, unsigned long next,
>> -			   pte_t *ptep, struct mm_walk *walk);
>> +			   pte_t *ptentp, struct mm_walk *walk);
>>  	enum page_walk_lock walk_lock;
>>  };
>>  
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index ad05d7791307e..11d50518d02e9 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -1292,7 +1292,7 @@ static u32 calc_checksum(struct page *page)
>>  }
>>  
>>  static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
>> -			      pte_t *orig_pte)
>> +			      pte_t *ptentp)
>>  {
>>  	struct mm_struct *mm = vma->vm_mm;
>>  	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, 0, 0);
>> @@ -1371,7 +1371,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
>>  
>>  		set_pte_at(mm, pvmw.address, pvmw.pte, entry);
>>  	}
>> -	*orig_pte = entry;
>> +	*ptentp = entry;
>>  	err = 0;
>>  
>>  out_unlock:
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 07a21ca31bad4..c324cc991f841 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -1101,12 +1101,12 @@ static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
>>  }
>>  
>>  static int guard_install_set_pte(unsigned long addr, unsigned long next,
>> -				 pte_t *ptep, struct mm_walk *walk)
>> +				 pte_t *ptentp, struct mm_walk *walk)
>>  {
>>  	unsigned long *nr_pages = (unsigned long *)walk->private;
>>  
>>  	/* Simply install a PTE marker, this causes segfault on access. */
>> -	*ptep = make_pte_marker(PTE_MARKER_GUARD);
>> +	*ptentp = make_pte_marker(PTE_MARKER_GUARD);
>>  	(*nr_pages)++;
>>  
>>  	return 0;
>> -- 
>> 2.47.3
>>
> 
> How did we ensure that the above changes are comprehensive and nothing
> else got left in here ?

The order of patches and even the code was found out after adding hw_pte_t
structure. Then everything was converted, until some pte_t pointers were left
which didn't require conversion.

If something is left, we'll get build errors when we build a converted architecture.
So the branch mentioned in the cover letter when built, would produce build errors.
(Those patches would be sent separately, after finalization of this series).

Whenever I'm rebasing (on mm-new), I'm rerunning Coccinelle script to see if new code
has arrived which requires conversion or renaming.

-- 
Thanks,
Usama

