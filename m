Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9D33BC69D
	for <damon@lists.linux.dev>; Mon, 10 Aug 2026 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360060; cv=fail; b=I8wolci2yVlwDQC4fBrIfbeu+AXFZiG08LfC91RPgKOyzJ8iwdK2kHs53jKA9Fdn4DrAjdefK/w9HiiufIOhtdJXh+lOIHZ/iibdQvfLws05GpovY8GGXYmYsnxHzEO9dltw5c+0sGVpRXoPTV62R4DRxDrjsYHPgEUe5T8Ws8A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360060; c=relaxed/simple;
	bh=hBYwPOj3y8kO75TmfgPtxjTsSU1L4cqos7hTA68DQZQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oOZKZFXjnBI6Off58C/x5jUkAgCrdayuw+5mWvndhIFjXNibZ1bdVYtWiFjCMZ7hwPc5G/7Vr4GrX4tgSQQvc4WX/0C+wF9BvE4QrjltwRkx2DzJNKgf1K/RR8Zfq6OMSbuvt6Rz9ZmXAAw4ZThFaU8MNgoMN2R2zuDT4z+3Chk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kPqHrKjb; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kPqHrKjb; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kPqHrKjb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kPqHrKjb"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tlgPrx0F409iYmD/5pPM4DYdxHE70zqhBEOoh7nTQZxi+h2bjl/M8UonIK+qd/WEzRNYxEuwBltEo1+cs4jNdm3scgDFnWjGzYbDwZPkbq9CCcDhI7RALtlRmVrWoWogt/IE7snpss2oZ69kYT2C8DT+WpAdGvERyXnGE42XGhze1LlHa532RbAH1+ZxP7YGb5iegHOTA47LMyIhWGZKN/j3hknjPGAod9hT9W3BbdGdvk7q2V+hF+A4zkDnucJ7soMUgHjYnfXAhl+FRsoKmKcsov+QKLL52qDUErUsjrNAPicY24vqP0/GHiDbQbcgWeRvqrAplHf4CYB8qi6nYA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnQqdXX1ZyOUKKU4li9Bc+RBJzrUk6RyawcfqsSj/Eo=;
 b=KzD4CiwpIS+g+/ORHRzvOHGgqaF4BRax8xP+4cbOddcaN7jUtKC2Ho1xAmeGSuHMomZ9Pf432cVbeHH6QPruaOPe0ObEAs85sfVN+KZB77wTnZuW4xcRAqbqVmM37ZYIhvz6q5colLhpvxG+GiHEFJiVdQzGh0TdpwdcqMa2Y/IbPrn1GpONA1SOgoAuOIP+WnL4Mb0v/GZt9TukpDH2OWkIkTWyezFFp4xQZVrT8e1NScxc9/pGZqk7Q6gZFYHNxFNE5oXmuKmPWXCXXKhOtq97xmpYjjk1lTEmEnFNfG37W2AouWTREm0w8zFHus+/43FQzUpiRL+/RkUJE72zFg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnQqdXX1ZyOUKKU4li9Bc+RBJzrUk6RyawcfqsSj/Eo=;
 b=kPqHrKjbFDa0OLbzp0kgLoxHv44vUa1iZaGhbeDApeXGB9si5HckD9jCUzXFUvjwQ6ya/WFbbblYxXJlQHpxAODd9pB0y6zyz/xt54rLMTBPk10MHoPyHEicMGmUNuP6ZNCcHkdYwPp2GXqM5wrurn9J2iWj+66UzgYkF/HfI7U=
Received: from AS4P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::12)
 by AS2PR08MB9893.eurprd08.prod.outlook.com (2603:10a6:20b:5f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 11:07:27 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:20b:5df:cafe::7) by AS4P250CA0004.outlook.office365.com
 (2603:10a6:20b:5df::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 11:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Mon, 10 Aug 2026 11:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ziuome5/djtyBQzLEzz0klmAysoiBI5ZAwdG5vnb3nMr09jdV9VGv97x/PZogNuexDHgr5Xo5nw3XjHMCCjfiOoa3inGpsNMEfFzlW8yKZg8LiwfBlpVURriB1zGsB2mAyZBoQUt4prjIke7q/FWySr+Ygo8QBVmuE6d+O/0OjpAKTIxOIjcOkraqFpDsBHE4rCU647hc4e0D6FVP0Kv4noUVajpvIWXLH9litFTkeZXuLKIJYC12llbrMGJ4d2Dt8a8LFKPaUChAGM6/FefuJTy4GvU/zRGIvq3uWLhj4xlGe29JKudC2FebNsOezbu0guaNOMNCGQI/DuWebZESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnQqdXX1ZyOUKKU4li9Bc+RBJzrUk6RyawcfqsSj/Eo=;
 b=GdzwAUCegwRfCxVii+ZLGkAHtO3xXp4tzYPyF0iDSnfrKkoUNGEAMGhyDAQb39r1zcUcsMnxah9Xs/c0/bOPAN64IsYrxlHANrH0uiSvjthio3zxLLdIAClSLHTCk/a2+wLIy/0MPUkjKdt2o8mrBSwHvXehtjU2VwCbcamMxE5XsWs9w1H5IV6kNrcPdqkbq5Q6QOTzInJZbqCCym37I5EOnc2q7D/bPp1USuGxXPCX3As3bQ2IIjG6tgAGC81jJJmeoYrKOCrspJs2VC20PJ0vlwKKSWXEZu3j4/LNx5lQiLcRbzue4l6uOentjCiBOvApUlYxv4u6XBCNs2j9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnQqdXX1ZyOUKKU4li9Bc+RBJzrUk6RyawcfqsSj/Eo=;
 b=kPqHrKjbFDa0OLbzp0kgLoxHv44vUa1iZaGhbeDApeXGB9si5HckD9jCUzXFUvjwQ6ya/WFbbblYxXJlQHpxAODd9pB0y6zyz/xt54rLMTBPk10MHoPyHEicMGmUNuP6ZNCcHkdYwPp2GXqM5wrurn9J2iWj+66UzgYkF/HfI7U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3414.eurprd08.prod.outlook.com (2603:10a6:20b:49::10)
 by VI0PR08MB10485.eurprd08.prod.outlook.com (2603:10a6:800:1b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 11:06:41 +0000
Received: from AM6PR08MB3414.eurprd08.prod.outlook.com
 ([fe80::dde8:bf0b:1dc:2a2]) by AM6PR08MB3414.eurprd08.prod.outlook.com
 ([fe80::dde8:bf0b:1dc:2a2%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 11:06:41 +0000
Message-ID: <f0b0dacb-fb83-4402-b0ea-30072727dfd7@arm.com>
Date: Mon, 10 Aug 2026 12:06:39 +0100
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
 <5c329236-7761-4e42-a549-b822e43b4358@arm.com>
 <2599c5b3-e8ac-4865-993b-d41e6f060d52-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <2599c5b3-e8ac-4865-993b-d41e6f060d52-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0240.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::11) To AM6PR08MB3414.eurprd08.prod.outlook.com
 (2603:10a6:20b:49::10)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3414:EE_|VI0PR08MB10485:EE_|DB5PEPF00014B8F:EE_|AS2PR08MB9893:EE_
X-MS-Office365-Filtering-Correlation-Id: 375dfe31-4230-43cf-1174-08def6cf901d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 lQ0hyfxi02b4F9VwRxN8Znn5OAewgjlyPjRZcVcEUaWc/2czU2/V4NIVgJiRy5t4QbhGiEJ0KwtaSe7jPvxwE+NAtXM/byDqA7dfUzahbycT7I25PzR5jhkw4frdVt9oxMHTuT5akKF8RzZ33dyxm3YumgOMNPXleL3/6dgR5gVsXlm7rW/4NEmneY9iocIiXc9AJnfTRej+kH5hV/eFNjczN84h/tHRt+GWHZjzpSAoJPL9JYvhN2uJY/S+VrzqF+CWj+0w5yWDWDTqJ2PBgzAAUUUZs2kukSyhTiklg5Og1PLgZuW6iLLN9l3sFHSU2tcSI9gz7kEmj/CGBr9gAEUkaYQ39JJiiB4jvVQCheZ+7eOV/F/NBXKAzFVSt5gbfbkSknaem3qoa0pI/BVUw5qogKsLivyhv9KJhur+AwUg3Hgnw5miP0aiKhBTfaPE0nfqcrLZgmGWMPvil7+FlI8U60XhaDqEly8cC0jIpSQvVcvtGMEalbBtDiQFFCEDkDZUFQgjRdmfVg8KexBPyscLIZeZnbQZrbdecvE8TcK0E/1c/PBQ2CN+jz7B3aX/bKPp9LZqOK57affgO+aFBh9J1aTXDH4Sj/DOUdJRckS46M4BPeWnU89+1GK6l1c08XjUtoEwa9L+S8w73BiSAlNMsrmS1vmLGiUwtdwZAdU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3414.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 cPVi6hN5aavRhhAswfgv28wAXtZ6qeLTlP8q/AgWsrYcs7+vK+svJwSvC9NxV7RCHctlS0aIjO7/jx28wsEyjQwzfPGHOGPv1O1cSupSolWeBAX4rw+U98JrzgQTU06aoDW97oqwj+5onDZpDRYSBHwBov2+hRwPNJzrr2UbtXUdSOHd+PD4+E88nTrZSLjZV/sS2M1LGA2uVyfjDBfSo+DAoVyrKGPcprIh6Cee/RdcDdxZjE1/fY7YTLbnfllaV7GL+zNTiE62tYtPGYGbhMmEk7fG0EHHuqShM2REU2EwVZP0Wify25HFm73akjgX+cx6WziW0ou0CWTB9iKpKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10485
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ca79a833-59da-449f-a5ec-08def6cf7495
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|1800799024|376014|14060799003|35042699022|82310400026|6133799003|3023799007|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DYD0X0iVz0p7nTAJOluvMJLgPqN47VVopPuu1Tgg5k3iL+tjdugH7XD8uxMIATRQyCHE5CEHii4ZfAv6BZjP1mMDyapOVM4W1ilg7X9F0fKYKMVmAP64ka16hpMN+CetP/B7v2E2RwlOqTiHDBdavGagR7Oqvw35wrRZuJ3dNDw9Mkhh+3zY5wQzNlZGpxBaI8NxlVhlq6b1ZQ9aUNP7efMLmEPoLgGM+evYeK0QIRTgJ2Fyo+CW69lWEsvZ2/SkL6sZ60hz2PmFMsjnqsNN5Q1c+P7IRHVkY2NoPUMZa7mBXUxTB8BSAlC/boHdMS7EUC7HXAuE3LpcdLtDKOOUyN3fe9DgCc6hle0dB1cYpMprWXhhEt2kuzkxW7zaTiSIBQSaIDsXcciVawBjNzjRQ1ypGqGGYOEbvGA0BGCy1xO0aW+ZeI5aUrMtDgFGiDagdpDVIJkAJG+9PeAfUpJ2umRMn7zo8OZu4s2i1Qh/xkkcoheE8Z82yY89FctXsnrQom2dWmWTG4rj2I2fHX3NhtZMEVg5J6ZJxq7qptTDXtjk8zAl+rcLvg+nYnKIQVkWCO2STMGjNeOqVuy6ZTVS3YbQdX/hSXT5sI6f2Xw4gZzflEDaNN9TeY0bYD4Gk0nKGg9+7YRxPh4lEV/yrhze9+l7tI5XxvbyqEDd1HBuArxVIQAW4JgSveigAAc2jkO2S/Am5UJTNhZKku2SH4iqsQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(1800799024)(376014)(14060799003)(35042699022)(82310400026)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v9yzKvXersSc6ReFU7qOb8iYY1Krkk3I3TrL+MJcGrO3lI/b2VCRkfIXMpelrZ3Z3v8Nja2ctBoUQegYe+BH59zpJzbeJf9Wmop23UI8RGskbJ9Hp5J0PK4MBK1M4Y5fCG2dYTG5otCew4rBcxJOhS4StHUYgnRxBcczC1fMzZiZY2SFu7KZ9lYFWoR0KkEvfeQz+X0T21UvumKI3/eKIZslTKAmxq5tuASfa3Lte+WSTflopF5jZ+FKhdnf2bYkFeqi728pW7y9nAjh6TakaOLo5ZyUPrzOJ3Twzg0PEN+0agEvYEyrTJbXleBIUvUYRvwmwQ4P3ShnAb4VF7/SJKDssizgp423OQ2Ol0FJS8sKmgl5HwuW0ik/oaqYg3ExRb4anBIlSFduzmBPTTGE2clTYRV5Zf1c70KivNmDoT7Nwm92mHPqS+fUQsx0Z41B
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 11:07:26.8601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 375dfe31-4230-43cf-1174-08def6cf901d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9893

On 10/08/2026 7:44 am, Alexander Gordeev wrote:
> On Fri, Aug 07, 2026 at 05:26:04PM +0100, Muhammad Usama Anjum wrote:
>> On 07/08/2026 7:58 am, Alexander Gordeev wrote:
>>> On Thu, Aug 06, 2026 at 09:38:44AM +0100, Muhammad Usama Anjum wrote:
>>>> The non-MMU stub receives hw_pte_t but returns a logical pte_t
>>>> value. Convert the stored entry through __pte_from_hw() before
>>>> returning.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>>>> ---
>>>>  include/linux/hugetlb.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>> index bc0b9c65aa1d0..9e8b391aa4bc9 100644
>>>> --- a/include/linux/hugetlb.h
>>>> +++ b/include/linux/hugetlb.h
>>>> @@ -1283,7 +1283,7 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>>>  #ifdef CONFIG_MMU
>>>>  	return ptep_get(ptep);
>>>>  #else
>>>> -	return *ptep;
>>>> +	return __pte_from_hw(*ptep);
>>>
>>> But this is a direct dereferencing, which breaks the whole point, isn't it?
>> Yes, this is particular line is for non MMU. In this case, CONIFG_ARCH_HAS_HW_PTE
>> would never be defined. Hence hw_pte_t is just pte_t and direct dereference is
>> allowed. I'd thought a lot about it; is better to leave direct dereference here
>> or use some helper. Then used __pte_from_hw() was already being used in generic
>> ptep_get().
> 
> But in case CONIFG_ARCH_HAS_HW_PTE=n __pte_from_hw() is still gets called.
> That looks inconsistent to me. Why not just call ptep_deref() (see below)?

Agreed. Calling __pte_from_hw() directly exposes the representation
conversion at the call site. I will introduce ptep_deref() and use it
here.

> 
>> There are only two users of __pte_from_hw() at this time. 
>>
>>>
>>> What about introducing something like pte_t ptep_get_sw(hw_pte_t *ptep)
>>> to be used in exactly situations like this? With that the semantics of
>>> hw_pte_t pointers becomes straightforward and closes the still ongoing
>>> "storage vs lifetime" discussion:
>>>
>>> hw_pte_t*     points to HW-formatted page table entries
>>>
>>> ptep_get()    is used to obtain HW-linked/attached entries, and may wire
>>>               extra code like [1] or [2]
>>>
>>> ptep_get_sw() is used to obtain HW-unlinked/unattached entries and in
>>>               most cases is just a direct dereference
>> ptep_get_sw() or ptep_get_deref() is better name here?
> 
> ptep_deref() would be it.
> 
> Do you agree to the suggested API requirements?

Yes. hw_pte_t * identifies storage containing hardware-formatted PTEs,
regardless of whether it is attached. ptep_get() is used for attached
entries and may provide additional architecture-specific handling.
ptep_deref() is used for unattached entries and performs only the raw
storage-to-value conversion.

For review, this patch would become:

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bc0b9c65aa1d0..ce900d2652d91 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1283,7 +1283,7 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 #ifdef CONFIG_MMU
 	return ptep_get(ptep);
 #else
-	return *ptep;
+	return ptep_deref(ptep);
 #endif
 }
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1768421755a9c..08613593f3320 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -490,6 +490,13 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef ptep_deref
+static inline pte_t ptep_deref(hw_pte_t *ptep)
+{
+	return __pte_from_hw(*ptep);
+}
+#endif
+
 #ifndef ptep_get
 static inline pte_t ptep_get(hw_pte_t *ptep)
 {

-- 
Thanks,
Usama

