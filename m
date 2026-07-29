Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8242A16D
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327765; cv=fail; b=lfFwaIvLGjsrIV30itpB3vURWm1phOOiapo7wP9VXOgX/zFk4xVG6JxWyMFdVanpwulCMRenL6ZJReSKVvOasrOCzzmgNw4Twsz1G4tF0PTCf36+8yhsAOVmSV4Cbg5oRPW/JwIzlFSPmNvD6XQXbEQCx6ARcjTNDhrTnuJT7/Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327765; c=relaxed/simple;
	bh=qzAkLXouebTeZaS1WPWKSgNGC8Q220i0dabvqrMjm40=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O/ur2z/pwA4fiV0s5jBtQgnqk6w8yQ93gLwiRdFyItMbePZqo1/Hr+6ulEo6DKkCnNoPyehAquoEAYY/XXnluhAwjJlehRgJiOwyCkZZau4nGKifQxQKWXXaLwxnDG8ePFqe2Zv+gApRroxiDCAKLJ3B9Jsre3SVjsi4DL6n89s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r8WBeMkl; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r8WBeMkl; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r8WBeMkl";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r8WBeMkl"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gMYN6Q0m531rBxKpiephe/F/MmC2atAfaMp4hmdSFNFvGFq/rQZGSWayH9kge7t55zIeTUE8cJwyYAF7i0U7T/MBIeOdqIupRCa2/jhWKOuxvFaAbAaXOTURU+gUuVaRNoWlttFpd3KCzfaDhGcW9lUJ8OPFicAjTZc4o/Dfg4tOW8NhLB4GmvVgHJKoZ0+exwzDx2DMBmZFTVxexIwHkYgzIacPHTdW0cSyJyB+f6tOSx2i/Jm+XLIaK3qX0zdnCP9PWUatLGpxwlyqh+Y7ur7CDjMHSKZzN2Mf/GBmb1MOsUKviPXSnx7WCtLIbeuiScptmtvj6sYOLLenu7+Ueg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UgLZ8i/inTOBt7S51j8e9s65/Rn6K9L71YfNghMwJk=;
 b=zD9Qp/8Pfaq8PLPo3PHKWSlZgihDOKVMbROcHjPUCeMJF7XAgzTwxzBDvQh/IAiUWXT8zIySsmokF/PBW7a0ttkahbQkmsAVZtC1RS+eTmeaGNycTkMIMz8zLZ7SeO+YpxKLIQYWwQXlxTT9w8aY7Mu8dz4GwyU/ke9wKR6R8ML+ecsBPKl61x9k2F24MPt78q6w1mRNuJcSRjBmXLVwqiYXUrGvjFGppqG8WPyrrKSyA7lypvtOXL6qCKRrMq+tU7GUnZckkmcPrWepAevVB7aXQm7wMw4DIs/JxURPm3wXXA3/fxIEHP3rU77ayC7qALz3n4AaQeMZbGLDVAMxXQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UgLZ8i/inTOBt7S51j8e9s65/Rn6K9L71YfNghMwJk=;
 b=r8WBeMklmddGAm0lSTHYsLA4ZTQE1ZLuJSt/QUO0R3jXztqcZ52QnHl57B5GLKXAegA0tQaC7GvjVpfhAy0fK5EFF6auEUHIr125aMqiOmwDd64Jlo1Urdgbssr9CPVp7owoAL5Awk88acUmrPoH+9c50lz7JksulRlvoAy3iqE=
Received: from AS9PR06CA0039.eurprd06.prod.outlook.com (2603:10a6:20b:463::31)
 by AMVPR08MB11999.eurprd08.prod.outlook.com (2603:10a6:20b:776::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 12:22:38 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:463:cafe::7e) by AS9PR06CA0039.outlook.office365.com
 (2603:10a6:20b:463::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 12:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 12:22:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0uKrjJBmHp7eTVLqZ+bd8ST87iOuHt2PL6pKLdHE2et8YzFCyOf5v6vEMT79ZoPloSxRT6rXnrw0n0AxV9G4RvGSmcMvAnwytTsqVIK1/eFumF/x4ewDceI37uMabTMvNcxD/Wj4cOU7mCo1bnpxMk/NKCy5/GH6hOG3PQ0qNihh3dadPSOgHKqJhXkPN2VAPzD1ql+6jczrAiVl8waWGEvZA9KsP9EGet4JDQipPt4O+Dunk+Rw0F5r/aLaNStPZldAOyCKae9KoT+ZFs1/K0HTqoBS7uUaFJ4X47ayVDEiZh8exmZP+WtIUM1GA2qCJbVQOAaGopIqp5CnToCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UgLZ8i/inTOBt7S51j8e9s65/Rn6K9L71YfNghMwJk=;
 b=PHuDnc5gnHlllAbPl+ssICaFV9QwlyirhxIKMRdOvP6LtpFytiCL1WR+Ed+n09EOtn4L3jDyT/98x4bmTAS1XghGKgZsuXZ8Z+M7n5SRkVSvzTGV2bG4mhqLhWXrM3pMew5fgpZpd2eeDn3oJq7IU3+G+x34AAvaNR8eJmbXpfdAFaAIPtIwa0FEUQ4B0NUGIwLFoQc787mZzf2uC7h7FyI+MYk09g8bKsxSr5ZpOMHhQI9w8pGvWKxyxkBk+Z7D19B1cEKsH0TIoDiIdc4WnlDUzGDp8e1h+oQE/jcZ1MpJMMOx/saBJV9N2Qfsk4R1RcqrhOrITvbtmlXXUS9NVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UgLZ8i/inTOBt7S51j8e9s65/Rn6K9L71YfNghMwJk=;
 b=r8WBeMklmddGAm0lSTHYsLA4ZTQE1ZLuJSt/QUO0R3jXztqcZ52QnHl57B5GLKXAegA0tQaC7GvjVpfhAy0fK5EFF6auEUHIr125aMqiOmwDd64Jlo1Urdgbssr9CPVp7owoAL5Awk88acUmrPoH+9c50lz7JksulRlvoAy3iqE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by PAXPR08MB6432.eurprd08.prod.outlook.com (2603:10a6:102:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 12:21:32 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 12:21:32 +0000
Message-ID: <38e14b3f-52b3-45d8-b151-776be75d44d8@arm.com>
Date: Wed, 29 Jul 2026 13:21:29 +0100
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
 ziy@nvidia.com, pfalcato@suse.de, ryan.roberts@arm.com,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 00/11] mm: distinguish PTE table storage from PTE
 values
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <2c19247e-bee6-45f4-a353-2fcc60db26e6@kernel.org>
 <7813b5fe-e767-442c-a356-afc1a5c567ad-agordeev@linux.ibm.com>
 <6db0a8c0-b500-4364-be3d-d3a537c61258@kernel.org>
 <46319967-0338-4532-b953-dbea77084fe3@arm.com>
 <78a0402d-5436-4aab-a704-90fab56eec50@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <78a0402d-5436-4aab-a704-90fab56eec50@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0018.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::14) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|PAXPR08MB6432:EE_|AMS0EPF0000019A:EE_|AMVPR08MB11999:EE_
X-MS-Office365-Filtering-Correlation-Id: bb007915-0f4d-4d71-10bc-08deed6c1413
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 4f4WJiVrE4oE00IPJF13mXr5bYm4gJicwuFnW0oBvatB6ToESonz8/pFQy9Nsoh59srkh7AJ7Js2OYOpcAZjgWNoJEqkc0gP81wULmr6D2jyl+sQ4oxvEoWrcZTA0CzQ1Atz5uiA3JPPVbImXlnBvXEGNnh9MFsN9M4fysD56roZQ36+Z+mfvQlsr+06zv9TOIuiNx5CQTVDQfSzDipWZOASj2dFGOrG7Nv5dqqV04LK70KToG0OnumY6SVGimaGR+L4qiUVCZrr6GO9XrPVWAJzlJCYM77mWF7597CV5OMNeRje+Kd2FuHRNXttxrP9npyuNGxf9WOO8WO+dAldb6+8x9YsqcOugQjPQkULwaNtWNEsOoMYGQFd5cn+mpdZKrCwluwtNHX6nO32lbsA8kgE8YdbeZa6Kk5bSk6i3NMEaARh7kAnJkiuEwel69qEKRHkugY8G+JyK2Gr4oyZh7rA0ZMLHofVvYPeJHu5TNUSDLbAhTRBh5LGSSfkS3vkjAMv2ZG9YE03lkRt5NqCps2MOQryWQni+2q21fSj6lrnQq+MLUauz74mQTETrdGvYYg5X+wNLCs67CVW3ft7anoiMo3J3xDexGhnzPKYslqwke0d1m40ni/pPA/SpIyRupazJHBUKUwhPHedv2wvv7Lzk0132SQXBc2eYhmYDWI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Brip8dYa6YHQXD+S29uLLOT7LZIpu5N3EpgcLBC8QHeBs7dhjsgU+a7dW8lNCfj8di1XyQ7cYDQJ0BJ4Hjw+vuizJ78uwgbcMviGi72j/DZTDkcPvf93jvRj/sV9S5monBHQD3KNSVeUP18W2OegB8BQoe0X+ESoFIcM7+FxisD/UpULQrvsaQkb/nR3GXD26Kx/QjPdun8wOddrS8LQdCyFzxlN8rig+EDZuaJE0CFqO0P9NVrr9GvJbDHz/Okby+NyKpsQt0t3AkrHSRXiylYwvlGQb1NR96MdI+G62zSMf/Edt//mv7zM2dbWWp0DO4iqSZYTkjA+WL7ON3otCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6432
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	26ba18ca-dbad-48bc-c3a3-08deed6bec90
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|23010399003|36860700016|376014|35042699022|7416014|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aktEOCXgNgxIl4NKjwsHlcr/pYFkKPSfqFE9CNL9ClI3Zo+XZk09BjffLWxO9jzmrsOjTYhhZB2t5Djn0k3qXjC78NNHHl1qD312K6rzmVjCWKxJV91oKaDkM4tkqD0iJZXTO55o+jArLy9Ms1JUkwyBI8HUhITsypkUHYhzaxCi0l8AwbvcXecQj1cqCxwxSqGh46RAZmZTF4IjmGP6pKdZXdHKbQeSYsK5T1SDkjP8MMUr5M+FbwnZak0GCL79qoCVIy2Z9k+4aHN2VvQYYEHN+ETrxTUusC6LPQ2TSCPJx+BVNkmWQdDNd6jGT+066v3Zrj0vvzqtWUGDtJuQ27+DqQaLkC57t+ySb4nDBSQEgE5w+XmhvbCanza2NO2TmcI4P6yMQEDbkujr0q8ZlZm0JxbdUQDOBXrR1zOvNRt39gfXnOqHYRAv4GiCVGH2JsP3YXTSfO8vAenWe5qZ65yE57RV01xG3uASTjZNu62VkRuNMvN0V+qjR5mm/t3hnblGFlC7rfQiwz5xt+2KfW0j6GDtnzjnFNaH/h9uV3CxKzTRkMao1W1m3drieGYwO3vdsncwNM34WNz0GfwPvntvakDTRWk4hKtgvlpCt6izln3MeALi+DvRQBynu2dAb+wyk72/sKiiFMaz+k0rdARvlw8mY+HVJg1auvZExf3ZwihB8+lhEZW7kWAI6Xh7x1H2RzYNTsQ525NvYj0agA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(23010399003)(36860700016)(376014)(35042699022)(7416014)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RN3Ytg67Vg2Zak6Es1yH/cUa4avmjHG61CzeSPLKnIhC7DL6P2AgXlecNBBFiNpoZi1ifodUz5H3pwkzOUBYN9uNp7ZgetHsM3H6UTLziJWm0dZRQnIM75Ef9ap753FjMCfJ7g5+bTilWrI5DfZMeNVMoWfSWLHTpaJTBYFzeaXhpbeZcCdkTDrkpuu0BWQAY9nHdK1jsVTbMgm9SDKijQo/3ifcv5rXuUwimS8PSrmWvyvcMtugC+vLn6OXO2zdNJi7HMV4PicoVI/OwaSrGhzSa3kH7j6dr04Gxoz2PZri3G2kYupxa34wMhko1yWV+uj6CIQbg1pSM+K9HWQDHHHjV62ihCdOO7gdQF1JuZ7cLE2ClQbx2TckfSb5+XDkm52IWs0ixv/DBQ9Gsogzc74yrTdXxKFC1Au5mmfWQG6F5oosHXd22U9ZYoyFl3p/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:22:38.1356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb007915-0f4d-4d71-10bc-08deed6c1413
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMVPR08MB11999

On 29/07/2026 12:52 pm, David Hildenbrand (Arm) wrote:
> On 7/29/26 13:33, Muhammad Usama Anjum wrote:
>> On 29/07/2026 12:05 pm, David Hildenbrand (Arm) wrote:
>>> On 7/29/26 12:13, Alexander Gordeev wrote:
>>>> ...
>>>>
>>>> May be we need the generic hw_pte_t implementation as { pte_t pte; }
>>>> right away?
>>>
>>> Indeed, that makes sense. We just need a way for the architecture to opt-in that
>>> it did the conversion.
>> Yeah and architecture cannot opt-in until its converted. So we should leave
>> it to architecture to define hw_pte_t.
> 
> In the context of this series, we should have something like an
> CONFIG_ARCH_HAS_XXX and select the definition based on that.
> 
> So we'd have a generic variant.
I'll add CONFIG_ARCH_HAS_XXX config in generic version.

I don't understand why generic code would define hw_pte_t if arch optionally
opts-in.

Are you saying pte_t may have different definition in different arches. But
the hw_pte_t would always be structure of pte_t. Hence definition

typedef struct { pte_t __pte; }; hw_pte_t;

can be moved to the generic code?

Moving definition to generic side is fine at this point in time. But if
a arch wants to hw_pte_t opaque and don't want the generic code to perform
arithmatic (ptep++), it'll not work.

-- 
Thanks,
Usama

