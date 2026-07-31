Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26163C9892
	for <damon@lists.linux.dev>; Fri, 31 Jul 2026 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493272; cv=fail; b=nc45ZWPnjTVa9+95vy2bm0tbFie1LUZNUbtYc+3DDpeRIZm/FfePpPT38Hh/TmR5Npk23QcvXN3cCEEYYERhR1qCVK1hoGm7SAnNJc8Ei3+gyFgjqkAJ19DYcser45vrRAx2ge8f8vNLfDz0scm6liuZ7FO2bVWSArjOha4tZyA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493272; c=relaxed/simple;
	bh=G3Eh3IC8JdoxA1wfLL1nnEp0F/oOArq7XJw0erj29AE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J54ypFfDawgXJovSlJFRowko154xJXKqODwwKhw9c9Szzli5wQ4sItFIzI4xo/YT4v+KCv2LS20Str9K3PtxaRUpIvrT1MACXCi1jW2mOo41MyETBiOg4zfesCFcM+1mjgz1+3gVK17cyrUjpmlawcsr27IlH2uTNTbmlaGG9yo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cB5r1Whn; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cB5r1Whn; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cB5r1Whn";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cB5r1Whn"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AVS7sk3Kytg85s6ixW2pvS9sBG1paM1x9TBWmklzX4Dsqb6mKXDTd9ppy1TU3l9PaievVvtjQ+D/fWDCJV1VCL8l6MECSNyf3rm20aJp5nTASeC5O7/xOTfNBSrYFtlM99sn3SOsTqknFQ70lrawa3Rgt5MqdU31CKM63vHfU/PyMQuZPnZpBpqpf15Pw+x0E2KyP6JqJAX8zHd7x8xiTYRozKMZMG3s+ToKay1RBLTkmtI6kxRD9uC5PdoIBMD0VIdWifm7fIY/ovc23uFui0oiJeCK9MeSH1xclAxftglrJb+iY62wZyxQwhi5C5I3R9EpHKx9Aw/3goIbGBks/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9bGte8eqdxuMMzc6Sl3gDguhLqQI6GBUeVCbvVeu8A=;
 b=FBLkNyfrDco3hvScUzHb0OlnW5F1aOyRHtiQ7a7evyB8uveVAl+uJC1cIy2HXegPCYzB9QSY/FLNAe6hf3nFI8ePdCxjUD+9jUOf8c8AXWL8ePo3bKzSyHWaxMypwwfMD99p5TZDqCpS8RuVWlVLP+JNvJas9VS6HN0MTusI1B4jEz1pdezMh95Mgs0Td44vrK+Ez1oHMshyUDVszMJ4c7Z5Jpvxezd2tnV3gU4fRjiD+HDbKVFARW5KSSOJ2igsNWpPC9YKH2W6oDGt5Lp4RaOhItvgZup+6B4OKnxRZWxphgPKjVfDzwHKky3wpDFGvR0sbOgsNaWzDLi5JXD1jA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9bGte8eqdxuMMzc6Sl3gDguhLqQI6GBUeVCbvVeu8A=;
 b=cB5r1Whn7zm4IjrU8ljCV0Q7/8waXW+Snz5qDVSFDT6iJQDf0Zs6ZV0KTsHR/rkcn4OBTHXCurcfBr79XtPVWA0L5Wdq7yzDThpWX+1uv0kvDXKB+/ZRMO+e2OcLAUCpFyIKwzCRYSTg/RxY/sHXEpuGqUrl+r5LTCe6RAf2ans=
Received: from AS9PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::10) by GV2PR08MB8752.eurprd08.prod.outlook.com
 (2603:10a6:150:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 10:20:42 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:20b:542:cafe::75) by AS9PR01CA0029.outlook.office365.com
 (2603:10a6:20b:542::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 10:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Fri, 31 Jul 2026 10:20:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RA36WTR3u3SMRbdo4Q+GY9qftlofBtyl26SpHhVA1QL3wPiNHvi7neI8BbiGFjcNhz1+h1QDKcE0ZH29no90uYmqtrLrQnwRJD280YKRU7/gqA0+0tIUTJFKURvMSdpBS7eVPTouH84B16YiKeL88sietYvZ7XOa71dlK+ScH4hQhGonkDNwW4F/HaN4Nyh4duISMR/oBfVW6+GEH+aluV/FbgSsThnzenNYe2xxWAHtZIGyfkN7TPij1BBo+UJtNXsts1wyxh1TmDRLjnx5oc+i/7JjfOgPTZwDIaMTQt6vUTHSC5NoadpfnbkxWOFTla/gP6QR0jbh50pkYvcHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9bGte8eqdxuMMzc6Sl3gDguhLqQI6GBUeVCbvVeu8A=;
 b=g05P1/GLRVOKiLbD7Hb/VMYlyYCDfmaEF5OIYvGINkGPWcIpqHcFwbqMc0/AWM6+ODDDSdiJpDyVHnpd0FgL5QoOLa4CXqhA66pWz1YIkKejm8m0xccvKH5Uf2JK2DOaHrqRyEuyXM/tSe6/2ajwLwYxrWeEAzDI60Z1jX6CtU0kSJzN1NDxpWBMqJfRS4KJG6uG36/NayfVcXgpDfQZ0uiyJynnKgLdvaqB8OMJbDhMLUfxgeKSCY1pf/MDs5FtIpO0SH5u3N668OxAR5xp4xyyRMpEpZ+kXYeUJ1kqePf0+jMbrTuI7OlNQsxC6CaqVaoszEtJ6wUT2nO3X0+cmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9bGte8eqdxuMMzc6Sl3gDguhLqQI6GBUeVCbvVeu8A=;
 b=cB5r1Whn7zm4IjrU8ljCV0Q7/8waXW+Snz5qDVSFDT6iJQDf0Zs6ZV0KTsHR/rkcn4OBTHXCurcfBr79XtPVWA0L5Wdq7yzDThpWX+1uv0kvDXKB+/ZRMO+e2OcLAUCpFyIKwzCRYSTg/RxY/sHXEpuGqUrl+r5LTCe6RAf2ans=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3410.eurprd08.prod.outlook.com (2603:10a6:208:df::33)
 by GV2PR08MB11278.eurprd08.prod.outlook.com (2603:10a6:150:2f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 10:19:34 +0000
Received: from AM0PR08MB3410.eurprd08.prod.outlook.com
 ([fe80::b6cc:973e:a807:c3d3]) by AM0PR08MB3410.eurprd08.prod.outlook.com
 ([fe80::b6cc:973e:a807:c3d3%6]) with mapi id 15.21.0270.009; Fri, 31 Jul 2026
 10:19:33 +0000
Message-ID: <9ac33752-b587-4901-b5f2-473e573d7ede@arm.com>
Date: Fri, 31 Jul 2026 11:19:32 +0100
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
Subject: Re: [PATCH RFC 01/11] mm: introduce hw_pte_t for PTE table storage
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-2-usama.anjum@arm.com>
 <6xah74eadjmo2bozyr62wcxo4hhpsiufx2mshh7tztyy2dzzps@63m327m7pl5u>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <6xah74eadjmo2bozyr62wcxo4hhpsiufx2mshh7tztyy2dzzps@63m327m7pl5u>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0321.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::12) To AM0PR08MB3410.eurprd08.prod.outlook.com
 (2603:10a6:208:df::33)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM0PR08MB3410:EE_|GV2PR08MB11278:EE_|AMS0EPF0000019C:EE_|GV2PR08MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 063978fc-0a0c-4a96-497c-08deeeed607a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 N2wlK7+ZRozJGmK0N2Kg0R4yJ5wOgZ0BD8bcmN9ckzK3UKJ2F4czXbrv7jZaWgvVUj2tZLGIy6TXZHVj8n7cCBGjmutqs1o22knL3OyEpVQm205U7W840n0BzB93Ls3ya0MZ3n6q0MiN1ZCHJEdhHH4FmcCqbn8amDqXdOS2JFy534KAR6w8Hode3mZKdiNOi4XHA4EMm4R4NmgNqv8BTHU1o1mrdwRGbDcLLTL/Uhcr5Zj2H23tyNGUWdzcb9/6Z+9bMpCyFaPdcHduC8sbRRNlTmKgEgaDWxAsRtFcZniZDxYHOO0wMLuvu/FIbZEpfc9mggB79qJPf78hwUaK6sCBMcFbFO1lIgj/xFLfWAMPLe5iSzSFLg+eGHiNLL7zlhllC5XRJ7sba3tAP1A5lpnMKQQ5InaimxmgfYr2EcWK5+6aNVUYhSXkZdPq7CHlTQ18QsDrrhmDdOi8MKesiDc4vc9VxGb/uuv4aw5rgyKAM7jO0sO/zN+AdxTpB9Vtc10PElC4ddyBnsaMt+zoJSiIhtu0ZzbyjOzgxOvSTZh9hr8fCJVH9BN7z4kFR0HmSW0uqGKEUsWoW1c6OA7FbV3EauzK0vM4jQZyqMS9znmYSKnSFtSl9lnT1Aih3rkG/pMOiNT7X9Xk05Vfb8Gxfo07Avde+ZzbUlyDqgQmWys=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3410.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 jppYn+MrAjPlJcJEzGfQ1jvETR90CuL564Cvd3s5pQpSXb3FjdEezsTcu1l7Aw7vpXIhIhpPA4Fvjw06egzld5SxxNDODfBO3WGFQpssEDJnL8PWJRIWECUYo7TnCKu253Ngg+5ToeXKLgfCk4brktdsgrj7zk4W1crtnbpBsYC4BT30W2CElHRbMGQdk/8tVzUPeMqdRQtqQ59xKrgLxPMc3xsyjg/9StkRA3HpzyMoGJG+NEI4gVuZt6ij1C/0H9fj2NUUWGDqXiOrjsESkwvO2Ls29lOKFjcW8bSAMO3Y/NNJVoKjg8ty9x9AJ/wLhzWBu8NL0DMS7x6LKw8FeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11278
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8eb83e79-85e5-447e-8f2c-08deeeed372f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700016|14060799003|23010399003|1800799024|82310400026|376014|7416014|56012099006|10067099003|18002099003|22082099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	dFh9utBZm9coYe7lszFVqG+lkK8KKJHKFUcLLL2UMwqK/yy/8cBat4HppZOkWZAfERpq9Nqdr9wJ/LHJAOFQEFNwVQ4MhRIjYht+fxl3iAF2VNl/bzaq7LSg9Nz7d1TDUt1vLiWmv5aQ/eOT3kNL4ydgoH8GLXhFJB6bpxqaxB34Hb15BD8CXfIHaOGLZzl3a1qTu5qT5Dw8o4hA/A/FTkZgr64vErpIvQxC0npknPzCtFRMbBNqZfNyuCmRgbAa7eDbERFn6Zsh6b13v/uGFHtaVClVxAvm7iiATJTQVNC6CQyn6Df0C6YgyevRFTAQdfsnUsjEsy15+KcF/ohHJOESgA1YzuZ6DA+XwPSIgD8YbyyF36cAD5jtDbDJNxQ3POqrxE38H9HSncxL1lKpDks1J17i7Ack6OL6zQmOGfJ9Rkr9/CCMao++ykT52cd8XK1z3RPKZsnzR+GE/GFjWVYUPSjHWvMK8pkb2oeDxzQBMDMiS7v4lWWXFgVA4+kf0AtwTiQ25mMLWTs9Jvgn3mXMF74BJT6RQmw2+i9osZGZhzbhCc7hxEE+Sur3/WYn/FdcZvV0dKmOHnZF01tHV48qhIYTgAROTgZfctc8ANWWXskXoCHmbofaVUtbAONFEC0SLYarDcsWXq5Z78E4/cYnPPku4A+XXDGfI01YbTNqrDbv00JTbyE7H7KYtkK6mSAbTiW+kW3Ab8f3TIsfBw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(14060799003)(23010399003)(1800799024)(82310400026)(376014)(7416014)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J5D3Bd7peVRNDXPA0hNBwP0oGui9YRu+nbas8AqrFIzDS/BoqoNRvxt7stx/O7swEfXC5E7bbvF1tMhNzfaD5bdaZFQi4LWxrTNN5l8SXqXAxHRrMoMx1Tm30oLnObarSIliiQOBB7e7Bxi5j3QJDv6ZepNuZoKLJ9LJHr8WLuRuG/F1nQph3mshKgLjfXz91Jk6scG1zimGIpOnTg0r7oZ8I0aaSfNLevScIQU9VA+BIlsWI2EgEnYytYEc+F9VMWh77czPcsvLTHzI0GFoIrZ5auPHWbHZYDnJcBaGaRw5twwz2EqT/c/gFh0awK41MZzE9A3cllsyLeA5s52jUvoRfc+5Hq7IQr1M3/Af5/e2WBRZu3jWlTzCH3fNtmsPPyJbRhPMx0LX9PwJ7JSFkwIOC92aPhJhKrzmlfNx8MjgXXfhkvKuKRIri4IBkZA0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 10:20:42.5455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063978fc-0a0c-4a96-497c-08deeeed607a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8752

On 31/07/2026 6:49 am, Anshuman Khandual wrote:
> On Mon, Jul 27, 2026 at 05:46:52PM +0100, Muhammad Usama Anjum wrote:
>> pte_t is used both for logical PTE values and for entries stored in a PTE
>> table, so pte_t * does not distinguish a pointer to a copied value from a
>> pointer to table storage.
> 
> Should we rather call them as "Linux PTE" and "HW PTE" instead ?
> 
> Some like "Logical PTE" does not really sound very clear on what it represents.
Yeah, I should make distinction more visible in the cover letter.

> 
>>
>> Introduce hw_pte_t as the generic name for a PTE table element. Define it
>> as an alias of pte_t by default so architectures retain their existing
>> representation and behavior until they opt in to a distinct storage type.
> 
> Makes sense.
> 
>>
>> Include asm/page.h so pte_t is defined before the generic alias.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>>  MAINTAINERS                   |  1 +
>>  include/linux/pgtable_types.h | 11 +++++++++++
>>  2 files changed, 12 insertions(+)
>>  create mode 100644 include/linux/pgtable_types.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 15dd00c7ffec5..78aac05949829 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16981,6 +16981,7 @@ F:	include/linux/mmu_notifier.h
>>  F:	include/linux/pagewalk.h
>>  F:	include/linux/pgalloc.h
>>  F:	include/linux/pgtable.h
>> +F:	include/linux/pgtable_types.h
> 
> s/pgtable_types.h/pgtable_hw_types.h ?
I prefer shorter file names.

> 
>>  F:	include/linux/ptdump.h
>>  F:	include/linux/vmpressure.h
>>  F:	include/linux/vmstat.h
>> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
>> new file mode 100644
>> index 0000000000000..ed5dba42a4f8c
>> --- /dev/null
>> +++ b/include/linux/pgtable_types.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_PGTABLE_TYPES_H
>> +#define _LINUX_PGTABLE_TYPES_H
>> +
>> +#include <asm/page.h>
>> +
>> +#ifndef __HAVE_ARCH_HW_PTE_T
> 
> __HAVE_ARCH_HW_PTE_T macro is a better approach here or a config ARCH_HAS_HW_PTE_T
> based selective platform subscription should be introduced instead ?
Moving to CONFIG_ARCH_HAS_PTE_T from the next version as suggested here [1].

[1] https://lore.kernel.org/all/78a0402d-5436-4aab-a704-90fab56eec50@kernel.org 

-- 
Thanks,
Usama

