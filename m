Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F14D3B71CF
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447694; cv=fail; b=CCZZaxJ2soFS0E5/DTi9n7W5ORfHSOGv4GDdv+cv4uYZliIEx2lODzJBGx1MpPeTPYtPosyOf+g7JlKLT20llMNEufDkoHP6bBvMDpNqf+1M2QTvXCAGDE48wYp/6E9Fzwi1Nlfi42SmapbP9/mR3MkLjAKMaP4+nleeWXhiRlc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447694; c=relaxed/simple;
	bh=QHesBVyFEEVvzGlxlYJ9IHg/wUB4RGCz0EN7ohT0vWc=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MI9k4fQSYbBidKy1gOpyPxyUKvfg2NGy0X+U+4Nii3fOwV3sqCYIcS8qoliitcyp1vHTawHnG73fz3TaEAGSEhFVCFh21B5DDD3qFd/vEEED4xMyMkEEItKnBfWTTSc9MJibFX6/BrIfYumvOVmKe49+KE0YJhstdvaVSPme1W8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZUpGE89U; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZUpGE89U; arc=fail smtp.client-ip=52.101.69.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZUpGE89U";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZUpGE89U"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WgmH99uHZu7Yod43tM3nBqEfLOX5vdc9fYbaP+kOJ3qHMD9B9Sr3YYnD9+IseX9YxIqu4TN6IH2LfJT9amSqvbB/uODx0CFJ7cNC+4uDpBjCnl4ofl16cf8WyDUCMkRyz23M+Zs9pv22kc6B4fCZYKNWiOBI/Q7B/i0tUEtynJ/+pyGdpBde4qExZeFuuhx5t6NvQjBG0ziLHAEPMELlJBr/GIdD+mBnccClKYTWpNvCHZgwXrLgQlawyiXB6k+VBjkepLC6m8zgLyBQ/LKTDGwt2ViGn4t3JhGbV/8qgPWKB557ZQCUnTx+s6YN/ZuRIVEvH8xW4GlWIzH+wgLbHg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJvqjQtYhPn+5rlwiCulIyzL4lgkY2x9AtSglnQ/lYY=;
 b=cKB5gw5uhyyZv0o0xoc2/tNJMg91sHWHUdi2ESuOWbnC4D0jIqnKN7b7OqwruTsht9CZhS7bu1veM2CHRBGvZ/SgkjS71Oska80xeZTdb4Yb7/9+v0i1OPhyvk8ZNGwGkywD5FpvzS6Bvw9RPEsQILzFBfANXC970DEZPztUKCAtx83QkGZHbTEYm4yjVks89KAO7tj66UEhkkvPyNt1xPLbahXGOns2+6mQ/6IXoNTcwMKJPbCR9Zl+3GMGKWHGVG/4GnLtTn3sdebGcF/WYR4hlQS0jVsicydKkfGOAI0tXgj12KKye5eGP/zDsGSVHFwxjiE9/IQcmssC4EQ3zA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJvqjQtYhPn+5rlwiCulIyzL4lgkY2x9AtSglnQ/lYY=;
 b=ZUpGE89U93omH662/JXtCNc15E3velUKg/MY+8EtCB58awMrAJ55DvQpiyUbXmRWgGbeUbeaF1kB4Mf/vJIUzh9u5D1IYs0UbuSUkN9eR4mUz6yAUzJl+btZ4QsOeyW8mPHysbYosEhYL1r7OxUUxylALgW+wLqgDL+K2823ehs=
Received: from AS4P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::16)
 by AS8PR08MB8088.eurprd08.prod.outlook.com (2603:10a6:20b:54d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 11:28:08 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::51) by AS4P191CA0009.outlook.office365.com
 (2603:10a6:20b:5d5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 11:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Tue, 11 Aug 2026 11:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtAUGRcJ6AWlPqIQMLOFqdpWYxlTC4E2nUnOT3chDTEIsmQcnbc7C4Y2sSB+uTDKwOvo2ZRT6Em8+BPrJnX7eXUTotZQn8/QVz2bJayIE79ffJW5RQRmoE9taCWO1CRXKXSMtue7nY/k7SBTekqwHh499iyRUbYpsQOFjkQrA0ckSpbIO9s0kAJ7nZE0iUrOiqvUKvT1dA3BtLcz5cjBQsNYUdJq+D9dJ9nsXo7du0pJvj30fC46fGjK2Fb0oDCav9SQ6O8F+n4Ny5fHFBYw4zeGzzIlme6w72w8fxAFJJS2I8DsZiwUGAxrBHih8QF8wD9eb0Gf3vg1RbgJMx1eYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJvqjQtYhPn+5rlwiCulIyzL4lgkY2x9AtSglnQ/lYY=;
 b=BUubzy05M5a0o/rrnDSXc2KdVNLdPVbJYF1vXwuI3/COJyE/qtHU44Dl3N54SOa/fu/35NVq+uVAGrPBVNXLVeUge3lOZz6SgrGkjDkjsf0CCohtaUm397MMHWHoKlzfgWUPT0NDVZ/OILkn8pomnIoZgwZ7XLrU1HMBt+mc3XClJEnNlKc2NFjlgVA2oaBTo1lN3Mup6A5NInGri1ekKwe78rvvGzamNFBrREnJ2nEKadoQ5NFB3sW9jYunsvp1SIMclM93siICuij+o1E10npQlj8GB80SeLV7W2OsvQivrs79f+K5bjWjAMnQrVdUTAr1zajM6lpYD7FbYq4NXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJvqjQtYhPn+5rlwiCulIyzL4lgkY2x9AtSglnQ/lYY=;
 b=ZUpGE89U93omH662/JXtCNc15E3velUKg/MY+8EtCB58awMrAJ55DvQpiyUbXmRWgGbeUbeaF1kB4Mf/vJIUzh9u5D1IYs0UbuSUkN9eR4mUz6yAUzJl+btZ4QsOeyW8mPHysbYosEhYL1r7OxUUxylALgW+wLqgDL+K2823ehs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by AS8PR08MB7790.eurprd08.prod.outlook.com (2603:10a6:20b:527::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 11:27:27 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 11:27:27 +0000
Message-ID: <00e4f324-18b1-4120-bdd0-2715cb8c8481@arm.com>
Date: Tue, 11 Aug 2026 12:27:24 +0100
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
 ziy@nvidia.com, pfalcato@suse.de, agordeev@linux.ibm.com,
 ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 2/9] mm: make hw_pte_t visible to generic PTE interfaces
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-3-usama.anjum@arm.com>
 <7xbai2nyu6nuyr6otqv556dnphpgwaqsmvwkqwoqwbh5nvj3ns@ddy5ezgvb7w3>
 <85286df7-363a-4671-bce8-8157ae5c8f02@arm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <85286df7-363a-4671-bce8-8157ae5c8f02@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0528.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::10) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|AS8PR08MB7790:EE_|AM2PEPF0001C713:EE_|AS8PR08MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: d61a279c-a036-426a-4b7f-08def79b9d7d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 MTpsf3IvsMf7LVKWeyhvKaEhr96cF7yvH7aAkJB0bN7Dz2cNvpHXLH1fyHZGxfSN239QNIaI0+Jcok45W8o6dR4xsKN68cgbWwRp1dzQPww8VsZXlkd40hV+KhrcssadBi6n0BtjeK57do7GEQf9oFzJbDCKBGKEr/aV+5jAIFyIZeHeh5kMOB9Qrjk9lo8ssRQA+eChm6iIsXGtD+CSOW4NioxM8SGHVL3AteUAnM8e4g774whpKM+LAnfDDjcLSX4MFF9hSkCzLPofT/OqYQzv+EwMtqda4QQ3+eunavGYKJYsOeegTMveEFkeBGvj6JTMm/hOKqolApr0MUGBdr41GqT/ssdVZNPKYsYEt9xqPyShcC5PyLIgKCnX0v/tTebELHCxdk51b5+2EAOWhVI77v4UDPfelMHZNmq21/aREZCxR9W6n0o5k4YLX5a3uijZLV6UVlfpJNgZ3QuTO2Bc6BphO3IM+ARnj71zys1h3r+Kd1pb9EbS1Jq989xaLY051Ts6i4KRA6aMFZo9LueNV/CeTUhnbiREzQtnXolfLW9GvmLGkm7fnud0MoPESxMefIj4l0ubl/7OWFxpNp2b3IZPQBAFKTvfGCVWSb5hVvqbhexADPkBEFLs81yOY+RJW4pds8/DrhzuSgfKHQo42UznNPz83AM+zvWSmgA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 hdQ7nn26YN7Vq0hE6oTx+kKoU45kJvqrMn0abldXFwKud0iJoW85VnYLUJpGpJvIJxgBFh5raADG36uRwV2AaPoefUNSSsVWUW5Y0zg8xQjIC+gS+uPl8TNSAFyKERlMdMsUi0xE67L6J47pXwlISmSbpRVwkLFrYG++90jViVROoUAQ0CjGmPthS/NBEXTu9BnqGOFLyjUMftDMlwsgCQzUj+8ciRZetLxOt7/pjNpvjEIqP4rEUksxKtNuI3nmtRimaXmtBqx+3z5zVXMWLYpAPEr4PTzqyXYAU22s9MqBWyN4hojABhxaeNE2vm0Mc7y2GYdrTtg6FpMnYERIRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7790
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	18d48398-875e-496f-3753-08def79b8605
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700016|14060799003|82310400026|1800799024|7416014|376014|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LBId93zfzYsdkhItQ8m3Sbw8+q2yJVetd30wAGzYPu4wfktulA8SJqNZDgSY8lRgmot0oRJzJqpIjH2QEZ3LsfO30xtYY+j/u0P4xzW+z6q908K+LCWxgfy5xkhraN3IZs2cffvvUM6DhmPLnc93B8PDQziQjZHXcY6hMRFYsN5RBYLMNVcNNAKA9IW9BF6RVDSEajZj6ilZHHgrK3VJo5ZNCchhr0OevMf2oB0qpk1DHxbQv7bcPk4a63pO5EWp6/IEofHhvhM2ogl815zmCKHyuMUK5alMgyRDGxAGMu+KktDDDJuApTyqueK+RcyqDbWoXiHv1ps4YlCWRl52KXUPHtc2VEAFhcjpo+o2xOab2odl1WdqK3wTAuZYqG7fqGzDJkEpbn+P4eQIokIZJ26e0QZ0DYdMxrvGE6LS/3Ol4Gyb62jd2BGSsOIQo4ey+nSBSM7ijHdNoRxbUSdtKTk6rVNwczxg44JeCgZa+J1p2nzp3otsCREcsn+2kdxYxxtzXsev/eDR26zA+I6ui3WMzUMRdUTJoRfZE3cclubw1vUqPvXmFtaW3N26JUVDcP8dnqiTapq4gLg7w5Fm4/gohXldeWHbr+B1l4jHsrqM8S3Ar3jN2FixBb3o8Y3GnLOkOYiOPRfe44vMPIulijzoYtMknOL47tbQqrdTJYmHZQxLzAZPONjwNc7OTnjbt/a6gVf7HQWnzz9nimIfsQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(14060799003)(82310400026)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X+2y5zNjIk2ZMEly/NmhYatLXT7RUjwaXpB/EPJDgLNtuIK+IxTY9N2TNHjyynBgG323H9CdchuekccQRuhVEvDj8V8uZ1h53s0HP6AhK3CZfJM3l1Us/YHLom+lX5544NA/bET9jE6QL4iyADO4tZAwLtBi9oWr0f2OCTqIbVT6XdmkwtMNoIq/H47UJalvZadsXbsa2qnFgnx6uTMu/IL4G80h9+pD/Gm3n0kSoekophUhaxnZ9RwUsiXGD+/RamB02QWqXBvswcUxn3wZydo+l2J/ieAIuOuqLGbZ4Ciu5/wFnbpAohCMtg2UzAdQ1Hs2SpB2cL/oPoWq3jHgAfYyCRfEWT+D8mucQ7B+SO8iu2kg6BktbUW0zAkM1YNXre2M4F0cQzPPhXVltIQbHnS1rRptOfmC1WBH/l1US/USRYq0ORtPg5792sE9xQ0G
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:28:06.6465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61a279c-a036-426a-4b7f-08def79b9d7d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8088

On 11/08/2026 12:25 pm, Muhammad Usama Anjum wrote:
> On 11/08/2026 11:15 am, Anshuman Khandual wrote:
>> On Thu, Aug 06, 2026 at 09:38:40AM +0100, Muhammad Usama Anjum wrote:
>>> Later conversions use hw_pte_t in page-table checking, generic page-table
>>> helpers, and vmalloc interfaces. Include linux/pgtable_types.h from the
>>> headers that declare those interfaces before changing their types.
>>>
>>> For vmalloc.h, replace the direct asm/page.h include with
>>> linux/pgtable_types.h. The latter includes asm/page.h, so pgprot_t remains
>>> available. It also provides either the default alias or the opted-in
>>> hw_pte_t wrapper.
>>
>> Stand-alone header file updates are not ideal. Why cannot these changes be
>> folded in, where hw_pte_t gets used first time ever in the above mentioned
>> places.
> That's correct. This patch should be merged with the 3/9 patch. But that patch
> is already too much big as it was generated with the help of Coccinelle. So I
> kept it separate.
> 
> Do you still think we should merge it as its a special case?

Sorry, I wanted to mention merging this patch and 4/9 patch (instead of 3/9 patch) in
my previous email.

 
Thanks,
Usama

