Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E84531632
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171149; cv=fail; b=WTTri1zTL6F/tD9oSWbeURcA7gmSI/i34lMAnpyDOE6jMn7vQXkPvcVlCdGhyWUx7sm4/kNSGFgeDXMRD3j4Ylu8+0xB0bMUc9PNpmAHQ5PCXv1CILJlzFzM51n60I9bmWzNocE3cY0iTXhptcDcLVgvHkzham+rjdUmXEVY6hw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171149; c=relaxed/simple;
	bh=3t0QxU66plPfO6d3K7ERDjf5o7q4vJroPmQNdWp4rTk=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SAi4UlChJFwo3STVllHfwnWHAi1Rb0z6Ru0uAQOQa5cOJ3WhQSrVlH/YcDm+pPWUBw54p88qFsbsEskZl3mkipjcRNS/zwNnOYtthR1KiwYny4s8XcLCtTgSCm4ECkU9vlzgDrNd4S5giMHVK+tzfcEjKHx9C5HJUNzn2vwPIB8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NImLnI7m; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NImLnI7m; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NImLnI7m";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NImLnI7m"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XgIhPo/5bmyNuDmCPcXUN+tMG2uhHZDzPHndfNnax95s1dkeQx6SV1tr+VtsBAGomn5tQWzLTpeOX9gR0LXIrTCcZiLBO2wUNiLN9Y40RtA2q9Vmf6+y9CZ8TFKbXgyUtGQSJAR7M03ZhAA27snBJnKLqz3elZASkdie5FjnqIALZrtb4YV4i3EilJsLKD3AgZ1eLiHZqXPkSZGxkKlmr+1BorkY292dYf3e4ZoXB4Pc/JqA2Q1Kt7GG+vgn+g1Z0x4+O8sjhueSbyfS+QoboLJ6d4DwdHX5m4YAfbKvLCDiTx0qDRnq6yvT7UAa35qFJyHS+N0RAW9ZPBsG20pDWg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNv2PlrEALCBnLQsldXodP/zMuSTmALFTUFz//S+1bg=;
 b=pBQBSc9Rip2Car/2/hkebRZP7fA0Fwoe0xOee8EpyEfjd9dn85ThhVYx7p3zD0iSBOR43NrCDGp6vJ7zm5zLoeZiyD7SULlSm3bp0/BkW9+H2UCDhAXnL4N8zDwz2KWEY79qEmJuSOEMcLZyPReFRneEdPlmHHvrI32L6reFNCoDjstJRvnyn6eF5mxIFh9cQrD4hJpNpEfKpgdqmkm+72eMzEOv6YBBH6IY8mX9PLePWdcm9dhcmHokjc41LFdDyXRaja97Nc8WCWDyjPk6MmeEBkT9POYL2d4K/iJCxZ0kJ7tRR2wVIcpS+5nZyyklsigi/klXVS0quHXgINFJIg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNv2PlrEALCBnLQsldXodP/zMuSTmALFTUFz//S+1bg=;
 b=NImLnI7mPzOCS5h75myRD6dJrhYj/Y8pb61WWlfOk08FUtxHCscx3oDJn5egO5woT658xGiB2tOEbTMVbcbi6ph3mDDYiA2qjvSuNRYRzRqdfIE9qlC+/cqGsnimcLLVDcNeCm5QDg8C8Ok0X4+2H9Cqc6asgus/twsBLTaTJfY=
Received: from DU6P191CA0048.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::7) by
 PAVPR08MB9770.eurprd08.prod.outlook.com (2603:10a6:102:31e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 13:45:28 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::5f) by DU6P191CA0048.outlook.office365.com
 (2603:10a6:10:53f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 13:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 23 Sep 2026 13:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFc6tbN+DqR9bAcOpUhd5U6M7Q7RUV9BGGK3m1uDUl3G88awk3wbZkIUMEtEVoD5b+mpJyuYo4ThkzM/O18vTTB2yH05diNCUoxnCR6PzAd6zAe6sjujqVwqzbLfZSpBRmlaX7XN01mX1sFF/PCDrFtVgNxTVhkksyzKFJAoKXVc2dLQz68cI5czXADet2kHxLdB0RwAG8A4JIKNQ22vh7cJvtgaTzMm9J2BDX0LuHqFJpDmHmOlRw4vxjbTQQ8HW+FeNjRs/2kTIFFnnNEkCK8JjpAY43grjKB/1vVBkqsJP82tRXL+D3n54rr3SLW5UcaLzAtBE6p5ZI1m7B8buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNv2PlrEALCBnLQsldXodP/zMuSTmALFTUFz//S+1bg=;
 b=jNWSZAnXa1NBr9IVjgjsys9yhz7wZLeNTqADBkYdUvhNe6TsU0eG2px/iArkOYQ21o00f5SprqHsrUhgh/eG476Y9d73VAjX9Arqk7Sn1xVij1xQIbJ9Gc/isTRqDMBmtJxYT/h52ecJqhaIJw5lUqsBdyVWKgz0zfTPa7ceo+tOcwIduGe+GNYblhw83oko/QCqSMDHxhyH78pUhd4+GtCloSsUbMkr1b030fIdCDunGTloje1Oy+t7fof+sPsDg8ytEukVESEYbEFtLBJlJuy3TZ0ZNZ6xZmtA0RvwzY4tiXzWwf7DQElW80W7heL7Qh7OVrmv7FY8lQQa5CFUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNv2PlrEALCBnLQsldXodP/zMuSTmALFTUFz//S+1bg=;
 b=NImLnI7mPzOCS5h75myRD6dJrhYj/Y8pb61WWlfOk08FUtxHCscx3oDJn5egO5woT658xGiB2tOEbTMVbcbi6ph3mDDYiA2qjvSuNRYRzRqdfIE9qlC+/cqGsnimcLLVDcNeCm5QDg8C8Ok0X4+2H9Cqc6asgus/twsBLTaTJfY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by DBBPR08MB5993.eurprd08.prod.outlook.com (2603:10a6:10:1f4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 13:44:47 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 13:44:45 +0000
Message-ID: <b9054539-2f3c-4fee-aad5-c6e725c6ea1c@arm.com>
Date: Wed, 23 Sep 2026 14:44:40 +0100
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
Subject: Re: [PATCH v2 1/8] mm: introduce hw_pte_t for PTE table storage
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-2-usama.anjum@arm.com>
 <4fb9f42e-73c3-46db-ac10-351a90901b7c-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <4fb9f42e-73c3-46db-ac10-351a90901b7c-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0270.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::23) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|DBBPR08MB5993:EE_|DB1PEPF000509FA:EE_|PAVPR08MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1ee7be-13b7-46d7-664c-08df1978ed86
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|10067099003|11063799006|6133799003|10063799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 4g1AO8kRUEFNWgcQXjh2wHWdD79yQHdGiF1pC7allufgdnec5hNaE7+LNiSCIW8Cf/LtPMWAWu+HPPgzv/h/86VenR7OgyMEAnQxSLhc6S1YXd3KbGcVG8FY+/uRwl2ul7KHXmCO3LuzTQ0SFj2AvY+ekUeNm5xr/L4a17cqmOqLpE0hAIi44FxnIq9dA3Nm+SVA/TEFMUynwqzMMF1o0R5llCURQxKQkTE1GpeGyi36kiNV9ODPLh1EN0sfuFhInnhFcKJqY+xYUmLPvsySIeInXeNZ1Z93zJhvtB2mq6Y8l5seuDc2vh5RF/SHYMEdPWXSnE5OZxSiaYpuFsg+dDvBTPyMsN0r+h+n2YCPn1GFt6ITTvfq46WkRfqb3MSjQnVdYP/zv/x0HEy6K4khd2PMP8H+vDJwOYKRmIG3Mi519jEvwQz40tAckyFi0mO4vK+baOniNWbTxmwhe8ESybU9GLHKpvs/R6GFtfYcJZB3Kt6GXZUOf1Qb2V5lvYAJGrzFdVA2+GGsUXSScGpCDpUR+Y30VQ+1KOjQc8IDrXUQVwlCBTIaYDWiZ95e9D8+FO8tuwdnNTTTyOYXynEdIkSbx1nbyf2tebLLP7inAORYQY8UD1Uaw/iqwaxO1xbT
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(10067099003)(11063799006)(6133799003)(10063799003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 TXHaA0zYu16+wIC41/vqvbEGWbtUM6A/QEi4hfjhAZPwB7e/jDm13rcDMw/aO8Z2W08mfc3hKtaOOacLo68A26n5EL4dlA6LeleYhiC9nkQ6kXhDTJjvxh6CcSAyRIuUgCt1DIK2sXz505JdtvnA2ICEk4rkuGPM4P8kWlgrKMZpUO0UV9+9Uo3fIActyOJ5+5cyFkF9VXAiNALcv8XPHc2fVWH9PI099oOHbtbpKWEwWIu1KS07lEVj6r5JRJFjGKZlCzAiG9RixrQvT6D0eOwJ1RBKOXbzd2ZDFxeC0Qw/pt63RPvGVNaks9ZgZxO5NDYB/k+xBxN6WVE1V46ZaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5993
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	40b0c1cc-e4c7-4cb9-e70f-08df1978d2e2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|35042699022|14060799003|23010399003|7416014|376014|13003099007|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|10063799003;
X-Microsoft-Antispam-Message-Info:
	KtYR2qQIEXxsKlDwmyY6/zKXj7Q64Pz87SfP6Ve6klZmXMtlisXySsLXsJk2o7hVB640EhykkjxOmMgNP0thdrtIuxJ+r6q+a3C6U8Xpb5HvYq9LASJImUnNnJBrEwcFe8Dv1KA4++TAIPcCag4sxtf3p34YEiCUEyqdCwl/p7NIP25myFWg+Qu6wqoRrnmmgOkbak1w/QDVNIGyPnAG7NUoxL9s2RCRnxJxEvqC1O7u8sob+jtNXWhrb2/jX/fDU7hBGeAfwX5Xn4xcBwR+GdByvHf631rqdLu2ryIjAEFAAFQyA23BxjkV1JUF9ejy7uaP6lKtVpyLX6e/n8aX5FLxOoNe05ldcX4o2Pt6iByeFv2vJCKMb/2S5wN/KxmjCbQWRu0bY7yenjFqZ5JDlRNrVGINrPI/rOxXEj1jhs58GpE+dh6PscxuENII4yqpoL8IkuxHQDVxfyk5Sf+8GuMtYbCsp1iKmcQLjpwS5oXU0Wdg0M/TVo4AsJ2v+VFVb0G897+ckjaFMVYON0akO9P+CX38W+6FPWfAyW6Xl92erdTj3Y3W+SMzQJyKDgAm0AFRB6c7Sm93b5s0Cn+CE8l3k5dJneVI4g+Z5ELOKfsebtB8NJxxGcTWTwQpK1EdSXi1Ded2v2/xkYbSWy+UllVWCuuWdDrfm0pHW8qqELM=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(35042699022)(14060799003)(23010399003)(7416014)(376014)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LG+e6vFDVZHnPjLcz7Q7EULZItRBDrsWR9J1I48Cl+71kBZRMWTGB9PPIo2tK1goaHxFDV41hikoTGBAYxqA3ZBDq8K7uEJ8xu7KDJqAsrxCh68+t83ZpSNPhTVkUAR6PfrCmvkkR+wb7c+z/LEVlRgPKy++vLv7nF1jer8jepoOCgkVGhhKvL1cb5KAjg1uoW8YKqPf7UlL7h/+cnHvrgnqDLHhN8VYIersGpVMjUm8R1WVhQxLsYLxHAjP7+agJByOujXPIx07z9vFJSr4okkBxlY0q24Xu1nNkt8CW9zMzqtUSHlZD1ulgjfW+kddWh+rBG+OoIkmikci624XlEMf2vR+PZNsiGOJBA3H1/GzUeIKfiPiUfO388nxff+Af72HbJfmVQ2BdsfORZ3jpZq/mYXyYe+tfrypprsrxWT2viDskbHPdxJPipo1x8Oc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 13:45:28.0626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1ee7be-13b7-46d7-664c-08df1978ed86
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9770

On 23/09/2026 12:52 pm, Alexander Gordeev wrote:
> On Thu, Sep 03, 2026 at 11:29:53AM +0100, Muhammad Usama Anjum wrote:
>> pte_t is used both for software PTE values and for entries stored in a PTE
>> table, so pte_t * does not distinguish a pointer to a software PTE
>> value from a pointer to table storage.
>>
>> Introduce hw_pte_t as the generic name for a PTE table element. Define it
>> as a macro alias of pte_t by default. When an architecture selects
>> ARCH_HAS_HW_PTE_T, define it as a structure containing a pte_t instead.
>> This preserves the representation while allowing converted architectures
>> to enforce the distinction at compile time.
>>
>> Name the generic wrapper structure __hw_pte_t so architectures can
>> forward-declare it when pgtable_t must be defined before the generic
>> hw_pte_t typedef is visible. This avoids header-order dependencies.
>>
>> Keep the C type definitions behind an __ASSEMBLY__ check because
>> architecture assembly sources can include this header indirectly. Include
>> asm/page.h so consumers such as linux/vmalloc.h retain the page definitions
>> they previously obtained from that header.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>> Changes since v1:
>> - Name the generic wrapper structure __hw_pte_t so architectures can
>>   forward-declare it, and explain why this is required.
>> - Use software PTE value terminology.
>>
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
>> index 2133aec4a2004..da60a8bdcddb5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17140,6 +17140,7 @@ F:	include/linux/mmu_notifier.h
>>  F:	include/linux/pagewalk.h
>>  F:	include/linux/pgalloc.h
>>  F:	include/linux/pgtable.h
>> +F:	include/linux/pgtable_types.h
>>  F:	include/linux/ptdump.h
>>  F:	include/linux/vmpressure.h
>>  F:	include/linux/vmstat.h
>> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
>> new file mode 100644
>> index 0000000000000..07da05d375c2c
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
>> +typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
>> +#else
>> +#define hw_pte_t pte_t
>> +#endif
> 
> I would suggest to provide __hw_pte() in this series - it is needed
> by architectures along with __pte_from_hw() right away (as opposed
> to when lands in arm64).

* __pte_from_hw() is added by 4th patch in this series.
* __hw_pte() was added in arm64 specific series. But it has been dropped
  because of [1] in v2 of arm64 series [2]. There is no user of it in my both series.
  Please feel free to add it if s390 needs it.
* hw_pte_val() was in arm64 specific series. It has since been moved to generic
series in v3 [3].

[1] https://lore.kernel.org/all/86d4aea6-4272-427e-9229-295489e068d7@arm.com
[2] arm64 v2: https://lore.kernel.org/all/20260922-pte0_arm-v2-0-a3f1ddff0a8a@arm.com 
[3] genric v3: https://lore.kernel.org/all/20260922-pte0-v3-0-5670b8cb9059@arm.com 

> 
>> +#endif /* !__ASSEMBLY__ */
>> +
>> +#endif /* _LINUX_PGTABLE_TYPES_H */
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index c1ddf59c0d71a..5f462ec6fa5e5 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1312,6 +1312,9 @@ comment "GUP_TEST needs to have DEBUG_FS enabled"
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
