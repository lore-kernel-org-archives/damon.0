Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5343E48B
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447572; cv=fail; b=ans+4NTbveSaw/QIGsbKiG8Zhb/2gChX5JCrZ2F0barkE+7Bq905u48fwqw41VSSm3hYCsPL/O1D3jkVt1kabjNCX9OLN1B/2EjGVAlVS8AWTKX8Uey2RAJ9Qu5rldzw++8ltcH0tOTrKDftCMGV2PFqhoaHdYgbJlO0hPix0Xs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447572; c=relaxed/simple;
	bh=Rb6FDDcLLcUSL5xgsdgWtnCQY2VoZoavAvmLYFfEH1E=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cIVXe8jQEtRxIpatLVKbKO3kH8wdHthP87G+Fa2P63YR3O6M7JoKV3OCYjYhf9Ddld0ZgGPZVwPtTBJhbfLBUTgx4sCgZL5aspeIJMqVW5NnMyQVdUWPvqUl/Hb5OTuEqawNY552CpSv+pXZFSw0OD11mOE2zdyMsr+p5yn1z0M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZDqaLm7g; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZDqaLm7g; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZDqaLm7g";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZDqaLm7g"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AaRNHVnDQUAZjnNScQ5bdaXTJtyuhgNRdYpiqF4aluPBSu7CzBkQrJWEfgJz0e6OfQmznF9zXTaVLRAyUzZ/x1jKMqcDCmuitzbenhDwbXqV5IufESDlI3N4vJNcDN3plotOTfytA1orcOHFjIB0oqB8/RXDd2MRb+vns+ux3gOWLOMrZnlwHBuy/XWumKSLz+2e+xQrKHjYdL3z8gCC8lc1F91OePlpqgdkQT61cp6IUBnFYMZdg5sfiExpcHXXlZHE/ObPgLDmpOTSHXE3Z6c5NEsK3wFmbvT3HWsHtxN2wNicXlDof5RJG7fCHkwvARJMFafE86+wthwXWvM2Gg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Upa8H8lYci2AEeo5pg4WAAxc+FTB6t5I5dTvHmgOG8=;
 b=Mdv8kO3XJDe/453Lh5rjES1aI73YvdJBDW5+LbfJgBMza52A90ziZAZaKmMT9tGxJv9Rc9mD8oSb0/69tGxYFDxuLVW4KW/mNL/lR/gkObBZtleeT993WHp8b3nOTU/E5329mz8kTCL6RYvjGQHPPWOOWgxQ3HeoeW1oa9eE9R81/4cKtXs+rhqe4cH1eOXlMRbBLeSlg2TTi4vM90jGPx+z0XTw/m5pYOZPimOEKg/XKWDNotD7eD5ixdQOSPHduHuyECHE98klfO3hBMMtPlr8gral+XXnIPe6PuHif+7nIS4BTRhqhOQ1VAT/U0I/JfT+UEyDr0S0pfkPfrw56w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Upa8H8lYci2AEeo5pg4WAAxc+FTB6t5I5dTvHmgOG8=;
 b=ZDqaLm7gWhUITSg3PvlCRuHDeaF0jtytI9AB0HVCOFjQL41efiVP1AEJKscTP+JFRYc3f4vwBxX6ZAv4Y4PTsCJUFq4gLgyuAFM1k5WCHt84HzI07ZD2DqdbEand2v5A73ThSJ6I32hkVU7sgGurUuuZJ0gjrk4FBCJjr8mRbic=
Received: from DUZPR01CA0305.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::26) by PAXPR08MB6606.eurprd08.prod.outlook.com
 (2603:10a6:102:157::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Tue, 11 Aug
 2026 11:25:59 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::18) by DUZPR01CA0305.outlook.office365.com
 (2603:10a6:10:4b7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 11:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Tue, 11 Aug 2026 11:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfpSa1oKx33iClOdPa8JCMayv6kb2mS5cLSdASv8gqPN7G9jRNvNZr0BRV4nAn6sr7qPWueIE9ojHmSandXoWV6JVIpWCGw0mabIwDi3hHXaLXz/d09eY9YS/qmXGiad6Nx7LwvsP3kdsAo4tvgS/k3HhLmg2aGodcwlkU1qKK2+WtV5Z5feAlL1aVtakk4g/bMK/rfm4u6YKvP7XXcz9/i8d0vgwi39NfSQ1znyncgm9lObFdDx6hgSgY61WahCZgSNmpzHZZeo5EpCJhHGjpN3AhYm7QSKGEWktVwtPMb8mZ/r7AU9IqrFuiWeqKZGgdDb0JOBgfrWxcD4VVqDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Upa8H8lYci2AEeo5pg4WAAxc+FTB6t5I5dTvHmgOG8=;
 b=wPp6P2gJ4yNQDU7fWUD1/g6d6JagwvLy15xCBXNctqNPVJNxT71iw0065K7P6c05Yufxg2vVpUuu1t5vH85kR7TRcPvqyfqE4PpXf6TAwLs89iK9hg0BqavgDwN8+AFGzg+osrO2SGItVo/uJYHvmGhmr1GRm5CljI++dqBRw+wB0W+Td9dzJ9gI8qkjy1cSs7hPwJtlQDELDD7lUnOQFut0LFcDCBf3Y/x99uqfZF2ujpT45Smb/nAIPnrxA1r7ex+SOUNkIqhY2cmz+HO2/YWS3qbYInruq9XQi0dBfnhbKn5vsoPQbFeEi7DmozIPRLvwFmokHwABpcYYEaWsiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Upa8H8lYci2AEeo5pg4WAAxc+FTB6t5I5dTvHmgOG8=;
 b=ZDqaLm7gWhUITSg3PvlCRuHDeaF0jtytI9AB0HVCOFjQL41efiVP1AEJKscTP+JFRYc3f4vwBxX6ZAv4Y4PTsCJUFq4gLgyuAFM1k5WCHt84HzI07ZD2DqdbEand2v5A73ThSJ6I32hkVU7sgGurUuuZJ0gjrk4FBCJjr8mRbic=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by GV1PR08MB8033.eurprd08.prod.outlook.com (2603:10a6:150:9a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 11:25:13 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 11:25:11 +0000
Message-ID: <85286df7-363a-4671-bce8-8157ae5c8f02@arm.com>
Date: Tue, 11 Aug 2026 12:25:08 +0100
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
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <7xbai2nyu6nuyr6otqv556dnphpgwaqsmvwkqwoqwbh5nvj3ns@ddy5ezgvb7w3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|GV1PR08MB8033:EE_|DB5PEPF00014B97:EE_|PAXPR08MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea68448-d185-49d1-cf01-08def79b519a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 S6S52yYdxtDtrbu3+R3LqA1hBff1nj/2rLzT9GQ0+Ov8ipkmk0O3mjgrS/DUQ1/AFHfZWm9IZqKqqBU43nupYPXdHctB4A1PEZb9VDmjzZVISz3QfTXgSdr/68htGFhRc/j48gtQ4l6+L4ZW1nZja24rc6nWlSCYCtCWwtrMSs9R7h+dNpcLi2YgHViFI9Py9PcceBHI2y1hbD3tgIm9e45D/TvCqL/DDHF12QMIcti8yIvgdyO09z7AYYF74iZeACzU7uBne+6EXxl5OTZFg6QDzYUP73s7GSAEpT8D0uC32vGvMHjG8m+SK/kgAzP+Nmx82vnMrK3xq8uA+VWijeEIKRH0QxmnSwYsuk1AtsGokPKiK6I6K7ncpwqGz621yibL1B1X/TtMxwipICwYVw/YV+fP2FF6t2BPeh9+LOL+/jJ5P4Q0nEQm8VGkWH7CqIW3RZfdDrfhmWwygRbb4FGuEulKGS0Zb9XSJgqJ/zyiqn5W4UNQbXYIOTge5Vv9t0ogYUJ+UEirnawh/Dtsl7J7crALwP6tP+AkARGX3R1W7ZcuiL99OIu2CO3DNYis4WRH+XIaGeh4GtZWlHcy/Q/iSOzNy8TKPbP6PMGBNW2rO6bfWb0+8p3gurQ1AfDE8vOseTc5WWE/ndAm09GMDOSotmNmMi7644PyBtk9BhE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 HcK3rNnbwnlUGSwsDidSABGG1HQSoO72TkmhaC28ctmrJg8jVmz1OTzbiHJyHscmR1RSZ/MVJf3UF+V1Dje2C1z7jQczHvpZZk9NqnA1pIaWUyQ0NJGWUP8OQZQ7BxNR+CvvvJU4JV3+pgE+pVX/LgqCg/GXYo9PNipkTyJMz9mRgXBJrvoOJFLveHRnnNj6ydDRiY+xZEs2n9JOMvPO5HLQY82ufTlmcOJ3FL9PskIALGq/04QKaGj1BuKnnTOeCwktvBeWr/VO5+ier2emXtvzMh/0Yd8zfkfTpnuAfv7qGuIggIUVnYNjisH2v/7Pxh+mGQifH9TryIJK1GhcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8033
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eedea4c3-0f48-4936-b2b9-08def79b350b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700016|14060799003|82310400026|1800799024|7416014|376014|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XYzog42Z9eMotfhgmS9iqKEi/e5WTKtBPBLzsRFRImxcbX5PniLWX3ninJZ4Af9k8bC4VHb6o1OwwJeoQA/2i730UUL2zNXDrSUWZHSuYACh8QJoW5JgqmeVjwqtwzy0z3gml+sK+Y/qjBl57ElCrJw+q7sYmT2cMhD8/3y42HreioKJ7QwzD4e65wtbrgqx5rliSAYRw47vrJyPwh+27VAzCchS7WFEz4MCXP06P/OdVyLTWzIvphvWiYIv5Dpu3aUaCZVHseGGRdJvUg9dauMONg70dWwbFk7CfqcRLlqzz3qB9fpZJADNmnKRFDw6eZmIAqAtTNfcZZuIQFWtpqx0rwR/rbZmSh2tCSB5DtB+rbuo7WBwFKgql+gOeDk1qPA/oUzC6d/9xDHnAIwRXyL1i2Ef/jMLBnbpouzZfrm7hYbVc5G4ESLHo1CoKc555iEFJIe9dSs1pY5CYnfIH7XIQVWz3VYWDF6y+uiG+1TLIYp9YxW380IRrjDVlPmOEhXuwJdVaB5X+aq2CMjrNxZGbQ5aecucmbuZ3I9tv9qk7LeamoSXOD4HjipuvtYft6RMLA0NwEmufdcOZPV/MQSMghyO8/IS9V4icJeLHiMODF2yA636hTouVF+HiDo+IiBhEv5OsrsxJJ74me68enp1XSR0G/0CNcB7V9Jx3ELApiBuiiA0szf/qCOPCqAwU9Kwrg2WbEiZ33DtCpKRKQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(14060799003)(82310400026)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0ZwgNXYWfRhYYA98LbWiL9Dq4fXTlXNoaKXJQAI4q0ScIWMMzfAi5eNx7/7dyqCLPwMFFJl4mdHzLPZ3yxxBKHkGJ9BToPKN1NXkYyYPLgkHN7n4Ca5Hd+PlknmPCL4C27c/ceF2j+mo5dRRN2Jh9Hnq0DC42pW6grD6e7yvZzc1aqIvmjsx/g3+7JCmzCXryTSxe9pVgw+zMvyhX0cuk+Hv0PFOyuqtmTp36SLoSjAFuzakML5/In5XYRtpnXN7XcWWG9Ou2nnPtYxS6qoD118jx2xGpmXe13nJ+wFzbzvK0NLQV5fAwTpVCR9S+pZ0C3w+Q6lNLvCcsz2sovYLD39CY+u+bNX70sG6ID4lGiEx4xxsCL36VJ9FxCt4JSja1TlOxvzaLeKyL7nre+yugq7ve1MVuzX5vxlIKGXjrZQbu1IM8oFYp2Be2d9AV99p
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:25:59.3167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea68448-d185-49d1-cf01-08def79b519a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6606

On 11/08/2026 11:15 am, Anshuman Khandual wrote:
> On Thu, Aug 06, 2026 at 09:38:40AM +0100, Muhammad Usama Anjum wrote:
>> Later conversions use hw_pte_t in page-table checking, generic page-table
>> helpers, and vmalloc interfaces. Include linux/pgtable_types.h from the
>> headers that declare those interfaces before changing their types.
>>
>> For vmalloc.h, replace the direct asm/page.h include with
>> linux/pgtable_types.h. The latter includes asm/page.h, so pgprot_t remains
>> available. It also provides either the default alias or the opted-in
>> hw_pte_t wrapper.
> 
> Stand-alone header file updates are not ideal. Why cannot these changes be
> folded in, where hw_pte_t gets used first time ever in the above mentioned
> places.
That's correct. This patch should be merged with the 3/9 patch. But that patch
is already too much big as it was generated with the help of Coccinelle. So I
kept it separate.

Do you still think we should merge it as its a special case?

> 
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>> Changes since RFC v1:
>> - Clarify that the header provides both generic hw_pte_t definitions.
>> ---
>>  include/linux/page_table_check.h | 2 ++
>>  include/linux/pgtable.h          | 1 +
>>  include/linux/vmalloc.h          | 2 +-
>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
>> index 12268a32e8be1..12ee6d16ad339 100644
>> --- a/include/linux/page_table_check.h
>> +++ b/include/linux/page_table_check.h
>> @@ -7,6 +7,8 @@
>>  #ifndef __LINUX_PAGE_TABLE_CHECK_H
>>  #define __LINUX_PAGE_TABLE_CHECK_H
>>  
>> +#include <linux/pgtable_types.h>
>> +
>>  #ifdef CONFIG_PAGE_TABLE_CHECK
>>  #include <linux/jump_label.h>
>>  
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 8c093c119e5a8..cf595608cc4c4 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -4,6 +4,7 @@
>>  
>>  #include <linux/pfn.h>
>>  #include <asm/pgtable.h>
>> +#include <linux/pgtable_types.h>
>>  
>>  #define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
>>  #define PUD_ORDER	(PUD_SHIFT - PAGE_SHIFT)
>> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
>> index aed121d729b01..b068e6ade4207 100644
>> --- a/include/linux/vmalloc.h
>> +++ b/include/linux/vmalloc.h
>> @@ -8,7 +8,7 @@
>>  #include <linux/init.h>
>>  #include <linux/list.h>
>>  #include <linux/llist.h>
>> -#include <asm/page.h>		/* pgprot_t */
>> +#include <linux/pgtable_types.h>	/* pgprot_t, hw_pte_t */
>>  #include <linux/rbtree.h>
>>  #include <linux/overflow.h>
>>  
>> -- 
>> 2.47.3
>>

-- 
Thanks,
Usama

