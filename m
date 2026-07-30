Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013069.outbound.protection.outlook.com [52.101.72.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8D3FA5CD
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406382; cv=fail; b=R6vck+xdJSx4MYxwG/xyk5rM+3kO+XL2lCq9mSELf7fq5RUZvWYUBx85Q73p+xiflV4VxNo6uD4enz6A99X8VCHBq7VarFhsi2od6ICuBSBPia8uZKege+fKKGNDZ5aO84OR5RG8SUBWcK+no+69Ytk5UChQo7+H9QTz0n36zpo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406382; c=relaxed/simple;
	bh=ZUrB9IZ+jX2u7qBjdgPGgsCegnOQS71piBviz8bJ0XM=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LJspv5+UkQ1MBwI+l6IF7Ty67WjOgQ2G6ru2GRFdTVK4dwPvaFcarl8/1mup36nRnXHhwHsPOv8QeZ0xr7KatWBGMfnWPzY3nXP65wfHHqVIGhWrULkOzU2lohn1QLxx9pBDIdGlADRXpvboNVACcGoDx8mseL1H4LDne5EO+Bw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GeswaosQ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GeswaosQ; arc=fail smtp.client-ip=52.101.72.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GeswaosQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GeswaosQ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fuQcJ2CjAiESdLvJaXw0WCNJdw1hgqK+rX9LPZstapsjqzyBtcWeZh4F8Ls5Wh6dCwyIQAvxKJowzBhgc7e9gTbRDyOLqp2sKepAHDP/4w8snhgBRlHYHaU7Lfb/TGgfAykYoshDHGlhEyzhXSf/Dnzf0SLClcq8PbvdYytN2SaeeB8vL8megY3uk9FgjRAHz3J26pduCZaAvdC7u62yRh7L4Lra5SC4WvTdGQI3HjEVvN4MS/U99YY80mOpROt0OCaQuJHafKPoGiQ4QpuvMDgPNoS6EB6xfZPBgW00vbX5yI3HosvPlI7hPs6ju2/V+Gw4n1/EKTC2vU4tF4/2dQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GW6TaX/wrJVlgXDX7ALl3n8GGbzcs9T87q/ugCOz5wc=;
 b=aMcKoCqGwivXcJfoYNzoZJ7RBLKyJ635mMcCDTGFaHqUkiAZJPF5hzqQRFNYC0aO/w9Iv2OeWHn4b+u0Z+wwX4iF8T4ZrKvDj7GTYQargMG9ODX00GXLAvLnoCWp2c83zslDKOMDoS9tUgFfzsHW4G+cRX8pmYYxBIFVmKx8qa/LzQB4eNfEeu873MJrOqcYiC0q1Yc04nB3L1cDPZwFMN+SFfNQBSSVwSGdO+vH/QrsUOUiasUt+XF2Op/iCu/emuWCWZAEPJ9s3jfb0Ql2IMADMZrBNKLc1oEL3hCqWBqtuQtzpgHtPo9lX7O7ghK/Y9HVV5br2E+BK9Lxuk7rig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GW6TaX/wrJVlgXDX7ALl3n8GGbzcs9T87q/ugCOz5wc=;
 b=GeswaosQZW0XJG+pOZUpxw2UMeTwpKI4FYP0ko0dIeM4WIxbIYvQH+bglzNEKMbrO0yKKXGBEVn4shqk8etpdsccMENK3ifDFZKHSpzWk9UeWkqZ2kAYwD0nx0jKN9zSjC5NMBpnJ8GUAHuFuIQ5lyqQw1k8sKSM3+5rrH0IUXU=
Received: from AS9PR06CA0556.eurprd06.prod.outlook.com (2603:10a6:20b:485::19)
 by AS4PR08MB7685.eurprd08.prod.outlook.com (2603:10a6:20b:504::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 10:12:52 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:485:cafe::72) by AS9PR06CA0556.outlook.office365.com
 (2603:10a6:20b:485::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 10:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Thu, 30 Jul 2026 10:12:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GS5RCkRYCqQustTpOkpKOo9ShwzYOgu1KcBOh+0+gdQ7GcK/fSzronqjHxjGwjL/xvn5KSgEHpDtZlrxdSITgMoRYf/U4cqHK/HRjYRmnYdwc978uuNSE9KVMT/2DFI7B+M7Eb5Xtad79e9MKVKFCy84NC3CM4NI09/YmnsFXmtiIZziSrLIxTq0atHZr6RzlqhBPqh4utIW9rqC41r1GrALdYvLOhXcc7mp1TW4cusck+GFxbB5uXPnHDaVFbNlSj2JTrGDRc58lvrldvGizlOxiJitFAMLpntI9QtT7Nk8yLX2Uc7nyN73V/J5yTF3Z4utYgdOsz1aALsHjMjwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GW6TaX/wrJVlgXDX7ALl3n8GGbzcs9T87q/ugCOz5wc=;
 b=fz0K7HaKJIztN06ofWYIYBBvaZPV2CIHdhinaGSzda+cmKkXpgu64xYGyHWtvlCTd52xf14/WqguAKFoRG1d62XFW/dwlv0pcVUrzltiip4XkGDf2e5DA1fY+3zJEMQPuBvElKivoSOZeOkPT0CvRhkxV2j7N8vWT1Blx2OKemO1QP0gvD/+UftV9BcQMAOojiuvz69bkP/WO6edjJjH3WT+IfYil4KgozKdjieQjZyhPhjMVtlv+zBrfPjHDARBUlvUWVr0aQqSH4SiXTe/YFBPplDAQus0/ugPjfcUW1ucqlqDsvnRADc8rVLRH+jB0gPFNh6XugWpW6ahgqc+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GW6TaX/wrJVlgXDX7ALl3n8GGbzcs9T87q/ugCOz5wc=;
 b=GeswaosQZW0XJG+pOZUpxw2UMeTwpKI4FYP0ko0dIeM4WIxbIYvQH+bglzNEKMbrO0yKKXGBEVn4shqk8etpdsccMENK3ifDFZKHSpzWk9UeWkqZ2kAYwD0nx0jKN9zSjC5NMBpnJ8GUAHuFuIQ5lyqQw1k8sKSM3+5rrH0IUXU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by AS2PR08MB9414.eurprd08.prod.outlook.com (2603:10a6:20b:596::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 10:11:40 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 10:11:39 +0000
Message-ID: <fec9e0c7-07c3-442c-819b-f9f5316cb6a2@arm.com>
Date: Thu, 30 Jul 2026 11:11:35 +0100
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
Subject: Re: [PATCH RFC 05/11] mm: convert PTE table entries in ptep_get()
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-6-usama.anjum@arm.com>
 <34eed5fd-c569-49d8-bc4d-a3d4b1207fbd-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <34eed5fd-c569-49d8-bc4d-a3d4b1207fbd-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0569.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::9) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|AS2PR08MB9414:EE_|AMS0EPF00000197:EE_|AS4PR08MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 3845b33e-df58-458b-663c-08deee231d7f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 uInQKg8jf9Nb/UF1IivgM/22qCbP0TvqUsgYHdS7porxb5tSHO00dGTijkLOLlk9/j/VpGHmaTlpjAfcrdcNJhbjqGV6wvlv5xuBeOctx6yLoczl/TcDAs6ZQWgiJmENQ5XpevQTCbABC9qqSnMz6KpF2B0ZF3+9XbvadJQABkNVXvu32u1hF8+GBilDAt1ouT4D70y2A1FAy8c47O2lWbyuKu6F6ucTXC0WPZRGqZiQVcIsQcJ4AdcBVwwbreMbB79e8aisN21FlJPPBRejbbhoNfXZC6PkQaIOIvnwZt1gxjvH/iEO0ZZXY11XFY5tIDVPZ96+GpdbXyyCaRgQmjgQ8ywikJooE1i+pSQpITDrpUacjhUS5i8KEKh4+a5rM0BEBsLXLak1sGT8DhPs0kcl3yTxz7olLqyYkcnokgMFTvMYgEadP8H7JJLwzgq1UihvbZjEoIM69JP/HuEYrkpbeuOt6KGiO8go9IwBEOkKVdqLyk29UzTVAmj1dfBwX5Q09MsC1f2FaAoELQck4NMFewUgY6JJH5rwvR/YCvFLzm0JdA4yAkxKKTrW1MgvvtWjkuR10RvprlzfFPfDw8XvJCoR3I8SESUj2xwrne6RTaADibTXz85KPIe2itNRB3kKzgGuQEu281GNHpSVcA==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 mxXycThQPOwCEKiJ4fpi4gay7U452fMtMC308xNh6nW7ar/t+Hqd8lgGY/Q3Eq9XUsaCDsOUntdt15OQ+wP7f8KKOQRloVvYD7VZhZJEaUp3qxctrhUfVFPMkrc61K5jDn8BuNFCj3O4UFhYfZDMIYHXvNVFLVNIMGorVnt+RzJl4dpvtM3jzfnFYWW2sPHTy17I/JghjtEphRZs89opntIZ01w+03ahpl8ja/ezVcis/D6Dn2Zf0i0OAxv7ayl8ma0C0FT8d1EM0q5Zp0gqazNKFCPxh9fD+0NnqIUPE3sspQELgdi5pMydyv8fg6g4LZTnXyBFbv2JTyHAJRKUmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9414
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c7c79767-1c36-444a-b20b-08deee22f16a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|82310400026|36860700016|23010399003|376014|7416014|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IO9HJ9acWekKyDrvqdgT74jIZME9HwZ/JjGa5sbU+cpuO73cCHAxEE4f23asYbnjC12JnPaC2XbI6AuwrBvkPBginhZW21HD1/gFWkjf5Ft51ZA3jGseF/rEzjItQ7dgcpm1BUSsMr5wsvHPyfdaaaL4jqy3UteX0hewlXfo3DFRdPJ+XY4Ev7jYv6yeCeBF30J6cRX7mA60/64Gqbez6UF6PC6NxVYodBs3YASACbK5vdyb2IhpfehN6h7p5X6/kFRgttZvZs36W8HfAke1+gD3RTLEjdq1gV6+zLCyE2rZJPSZw8i/izgpF1SUWORha7tvJlQGYgz33fvNMu4uvlPY3IsgRE86DyJh9h8YfbX9mEI79/RD2YCiEcF/3F8lIz0UhAwHnTsQNZg7oOEarXE2VQTTQ8G/LciftzzR3uJRdEOMxNLFMggXb8V/y34ET+D3VNULdUoEPedW4z/DN9AABB7vDImXzknfXrJlXiyNevfotvHeqaFZHjP/0DH3f0FBpUrZc9C2CQFfF5f/ptgyM9+EppOC/OEt/uuJA12QOI02IeGOyw0d4QpQXahvxbxE46c2U4W/czqSHoguUu2V09rCmITihtKM6pR0OzrvEek3uaMs/rGyflQpB1IhXs1+oYz0WiwUx/cAcATc/UTvVlKR2Wap2Nk96gV3SsXTHcmZFBTtqIgTZfrzbPZr
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(82310400026)(36860700016)(23010399003)(376014)(7416014)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1//oFefJiNUWVxX3qduv8Pq+Y2T8zGwCBZCNR6aSkpRobUo/Uzd/J+/5clgJ50UGQlu2vHtdFhKt4nKfwk/ykE4w2tWoKcq3GPRaWn9pU8LtknN2MbQpmx60jmreXkxAkKnslWyiZuHHkn+p1nHLk9LkfEA8fFSEWHJouMtL5DLnVdxG1JYCI0F5ftDLnjNrpGYhOyF5hPrXJUoycXFvc/jqwQOJek8e3ppxx1yax/eMY8d8JsBnhdG/J0zsUKcVGiNzT7eXyeqzYSGp0yu1f3iie65X6uOMhGBi05/RvffaG10ADlp+kI4uMxU8EtwuqmnsLDw/TM+xTChYSq7LHF9bq6TCv8xTOcG5P9PSQ5ySp/Y0ArRmTrHsNld+wvwHJIko54XnB6LpNy9kdYt3Ia0LtBhwZImwCOP4kqJXLIMhuBrJoWiLIUSbXKknVAkf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 10:12:51.8407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3845b33e-df58-458b-663c-08deee231d7f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7685

On 30/07/2026 11:08 am, Alexander Gordeev wrote:
> On Mon, Jul 27, 2026 at 05:46:56PM +0100, Muhammad Usama Anjum wrote:
>> ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
>> return a logical pte_t value. Add __pte_from_hw() as the conversion hook
>> and apply it in the generic ptep_get() implementation.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>>  include/linux/pgtable.h       | 2 +-
>>  include/linux/pgtable_types.h | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index dad80d264aac2..3003ac9cd81fe 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>>  #ifndef ptep_get
>>  static inline pte_t ptep_get(hw_pte_t *ptep)
>>  {
>> -	return READ_ONCE(*ptep);
>> +	return READ_ONCE(__pte_from_hw(*ptep));
> 
> Should it be something like?
> 
> 	return __pte_from_hw(READ_ONCE(*ptep));
I'd thought about it. My thinking is that we should get the pte_t first before
before calling READ_ONCE(). Please correct me what makes more sense?

> 
>>  }
>>  #endif
>>  
>> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
>> index ed5dba42a4f8c..61afe27307ec2 100644
>> --- a/include/linux/pgtable_types.h
>> +++ b/include/linux/pgtable_types.h
>> @@ -6,6 +6,7 @@
>>  
>>  #ifndef __HAVE_ARCH_HW_PTE_T
>>  #define hw_pte_t pte_t
>> +#define __pte_from_hw(pte)	(pte)
>>  #endif
>>  
>>  #endif /* _LINUX_PGTABLE_TYPES_H */
>> -- 
>> 2.47.3
>>

-- 
Thanks,
Usama

