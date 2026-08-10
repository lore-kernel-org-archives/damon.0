Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C735C695
	for <damon@lists.linux.dev>; Mon, 10 Aug 2026 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356611; cv=fail; b=qAHcVOf2tKs5+WYMtwlol3nPkNIJhu/mLqmEBH27iZ7WD5S6RFGZ+zepT7xkqCGoMymj5oFznR9eGKl0Ipx3y59M4Io2FJXnhY4hHwUUe8K+Pro+U3ITI4jtr9W+gQEjeW8asvTd3JggTxeZjeeW9RzQoRhJlk76w3OUwatjdOc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356611; c=relaxed/simple;
	bh=DYXokWt9MgiQ3NLZbjDm+GnJeMZXEt0HOdso3th6Jh8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AF/pj8dcIe/l6CDRddxU1QdwvXErZB4NEam4FXS2jPjnf8TbhLt34hsQUN0z+KrQdesxMabBh048d0ydVnz1iMiFbyj4TXLsFIGYclmmPaBKthCaGKaMCldI8ELkb9gTYVv3na3jx5q654cbOi9W0HbGNQLdax/MVt+B/4wy0Hg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X/TDbJ7e; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X/TDbJ7e; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X/TDbJ7e";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X/TDbJ7e"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cLVopsAFZrtJverEZ6bcEmNTV9IeuqdIwQXW+dxOyOgR6bWvYXlj+3q0LycraGi1xlJE9jQeuHYIHL6eMbdFruQJEfKmrnxZdPk96XAMYpooxxo+KWFGG+twU1NA1EEVRBKh/WvPs1mnELgDwb2L+DpsDjhZ1Tvjm4potTlv3BBkEW8dxx6teN4ShwAQmMuqAhikju4z7VPh7EbdUMTdpbhARXronmMLi7iIvxrfmug/G4T+3T7rjUSQt/C5eovo69AxuOEvAw6lLlD4MOHNYeO08zzIcrIMBesmH/hluTorwanc40IfHfO+TNrimReIo+/kzRuXjke+qXYUaEsHlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGHMm995GRpz8U1PURPcj9ORNaGW0JAp4jH7dTCsP5Q=;
 b=laQ7twZjOe5IuWLpGeGOcCN8WQiCDGWALQBhTFpvkE8EAuJWZNcXtxE5v3ygphnX7p65Tx6TEhf3ZFttL/2ubEZhJuEOkyJaw58b/ZDDSiiOdN3eS4qMsORMPFoeeLR/1eZGPV3NZZiIBKjFpWMR9gWUju6jKE+zKhiNWq9Rwsl+8itaPw+wcc6k0Pw6i/2z2yCCZvJD/96dP6sewcciw9SJZzUOs8daiYF1AJwADEKJ1mS52Psjhvim6l50OAIIkO6+rrg/dU9zHvLkS52r7p2Im6GKs0LKc6XXvbeUXVP9cqLunJ+Z/gLC/mI7f+p/rZ20AzfF3pS1iX22yhJz1A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGHMm995GRpz8U1PURPcj9ORNaGW0JAp4jH7dTCsP5Q=;
 b=X/TDbJ7ebcrgT+EhFqFMXkZrLW/4YZDc8WqKTw7e75/PXAK8hVBv6C+G4sRbqAlFtYUqJEtd2tPQmUS9T18h/wXtC2aoCPud+bRck2pQq9CYkNqoCovk3ytIAzcRbI1Snb/v7MuNLuEi4ToSBvjeB4IQeWdFklu/yB6MC0uCDmQ=
Received: from AS4P250CA0020.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::9)
 by AS1PR08MB7538.eurprd08.prod.outlook.com (2603:10a6:20b:482::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:10:04 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::e) by AS4P250CA0020.outlook.office365.com
 (2603:10a6:20b:5e3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Mon, 10 Aug 2026 10:10:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu7ea3NWDFQpIQidj/jgqt5/KcmZz0+/1a76oNtofgRKQtEybTY1fyBCnkJjwDsyW7/qX3L6SuD9Uh5OOHCJZv4AsAKYRa7pqgYV5bpV89zK0ET5xvFNA69JUYBVaBtP0v7tg2VZAyWAiuyhnRXyRJmyI6iJTXkdrK8qzmLAX72W8xQB1C86P44R4flTtnd2wfkhUaNejYRyNyzz7kDmWdH4jUVPDlAovM32wCDcB9FIoKAtzVEOFXG21H0s8vbW8kpr9DkQcw+l1uc4z2ouPB+PKPpQgUkqAgSo7BymZKjTQDr1YQgtlWllUFntTrZaE/f0vUEuw7WNLHE7NfbLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGHMm995GRpz8U1PURPcj9ORNaGW0JAp4jH7dTCsP5Q=;
 b=INpxTaXgNxtQiT573C05qSNgM1vbGnG8XOl2r9kZCWWdSH5g6G1tsg4YtDB2RnlUfjNClceUU3wo9Klb9vEyafV39ILI5xqT1mB40WqPtm3NOuPUzwS5rBds59divY4qpTl7kf1EzwOf8HLDVNq5OTM7M6etkjs2xop/w+dMmKowx8ZP6A7DWAFSqY0QuOdrj5QS8eOgAYJv13UTwNieAv7yjfEIN10iM0PeUyIVFvRpY3+skcHmBU15LSyj0evBb/FYsMgrn8p9G/rw5d2z6CVDr0Xv7YlNJpp1GNZQl4fgnkZvyFgrCH78oR/UhFhwGdFC2APICbt2IEP03StPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGHMm995GRpz8U1PURPcj9ORNaGW0JAp4jH7dTCsP5Q=;
 b=X/TDbJ7ebcrgT+EhFqFMXkZrLW/4YZDc8WqKTw7e75/PXAK8hVBv6C+G4sRbqAlFtYUqJEtd2tPQmUS9T18h/wXtC2aoCPud+bRck2pQq9CYkNqoCovk3ytIAzcRbI1Snb/v7MuNLuEi4ToSBvjeB4IQeWdFklu/yB6MC0uCDmQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3414.eurprd08.prod.outlook.com (2603:10a6:20b:49::10)
 by GV2PR08MB11418.eurprd08.prod.outlook.com (2603:10a6:150:2c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:09:26 +0000
Received: from AM6PR08MB3414.eurprd08.prod.outlook.com
 ([fe80::dde8:bf0b:1dc:2a2]) by AM6PR08MB3414.eurprd08.prod.outlook.com
 ([fe80::dde8:bf0b:1dc:2a2%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 10:09:25 +0000
Message-ID: <52b5066c-64f6-40bb-9bce-365a18f24265@arm.com>
Date: Mon, 10 Aug 2026 11:09:24 +0100
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
 <eef14e97-20cd-4b08-ae22-7636af049b09@arm.com>
 <4a42c498-58ca-46f4-819f-da14cfba154f-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <4a42c498-58ca-46f4-819f-da14cfba154f-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0541.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::12) To AM6PR08MB3414.eurprd08.prod.outlook.com
 (2603:10a6:20b:49::10)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3414:EE_|GV2PR08MB11418:EE_|AM3PEPF0000A79A:EE_|AS1PR08MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 0add7375-722f-46c6-54e9-08def6c78c07
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|4143699003|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 mSQv7AaybVdP8lh1lVFlcXP3kGG1cksbK7NhWTSFCBI3T0vZN0VuY2xwLDoDTGWs3W5PpK1u3qICDytNzKUqK9SDvSv7mOhBGz8mCm/T4p9TZ37PTi68WrHC7SBnCBiKxzCJ1ggOVHo04CZfBzLVji6+kBvSiujrzeh5gmb35+T9IoDVoY8YoaoS6y3IVsR/GNlvmGtl5h83qJwaCQGveRteXDi/EkCuqvbd5zatwi9ASQA/qgf3VrS4W7mHxiqhY/nlY5S2wjkycoMVtJy07vAqhKdVMsdnlL25x/Iwz4DXtgLyS6aJ6fYrNzxhQ3+eeZbR9SXZ64cp+5Kn89v3W3otEbkLRadT3SUQngLaRqNN8wIsqyOU8D4Yz99lvY6ZDxbtPq7pRcf3CTk8/Al5XLIF1V5sHok4sc9I5uDs30xNOq+ymqN4IBv9JdPHOaSs/1do4M34tKTFM41rHL/hmWIhHTdx8kq07vwMPgvnN5p7o+qmmoZSROUn3GPPhVdKXZ/LpJhu+sxmyl/Sx++vGNwaHa6REVMYmcFmZNeFvyZ/Y3jMrZuslEQMs0LbQZ2M5AtlfuTDIL4Je4PJTXc6RkGhF6yffaGrIBjR+RmxDHg5eXT2WqHRIQ6DcoTZIfTUIKxMWJPNuZkweSPQ7vN4An9Dr/hNzavgZ0covaVZmjI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3414.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 opP+uzSVHSCRZK1SnjoVnNSw+fDPOATCeo/EkQ/9TKyIWl0BioAAzSjZhW8oRWRhh0VP/Q1IhuRQUxZSxCsMBYVxG/vcaCq1wzUNu0nQPwwWo+QE2KhmS9+j4egy16LiRS4nTmRLKN+XuBdurSLoP+kaCOoDnMKd3pxwSOThge4lF9ONak39/a4lKk8vojL/Ah1HFZ0d8Go5NuqSGNowzXBjnKGdIXTD/jk32PsEmyqcNbc2TwzdKXhRdNZujBGi+KEGdynA/VP0mrbFbmrciAva+eyNqKFeXEVWYbI8GKT7kDRSysVn0Mgym+JU9ctCXZkrSk7GbR3mC+NkBpOOug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11418
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b22ca400-de72-440a-7983-08def6c77506
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|35042699022|14060799003|36860700016|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	52ljw7+N2VP30dy44Cnyx9GzXIODrdUB8NIuupreBaekg+HKKRyK4Uyz8+FSZ2wT4HJT1NqxG0OBF2CfIMDsIJFUojSFVqrOP1y5mMQMX0Gn+iw+UOBL7e1oGjVDgs2qMZle0OQvgyeqEpTgM+7zs2AyRKVdVww3rvIOXb+6viTkzLM2eDS9bsALyGE03Dj4uqs7sHCeA9q2Obs9b+v7TbqHv7hviVkKEKHo/7y5pi+gFG6uhWO1e+RTGQPpDJmVXUla383O0GG9sVd1QfaiNOW4ZU1NQl/jBrMwM61fmaYa9ND5U72bAaEdhF2vegC/qJJz0M7F5UXOEvMabP2txG5e1YCL5XzCmxK4i4tOqNcQxAvQX9bRxCiK6NjvhkGG4DcAdhusAVzcdYQkwAKRC4c6akqzOkGMG/KG+9jMh3r74X5uOflr7vX7yihr0Uvb2k6F/uPYVglfSl3xZHbVuzxFSC1UeKO8HJibYK3aw71qk6hoYfobqUY2txc7HaS+e89BDdcBPF01UrqtKArGVF2f5Y8M2uQlL/+qSzdbhdL1+h717JAzo1gd/b2gaN0TVvCyFYqNFKcntYni/GEpdOym5mMyqJoSX6RhWIsv3fq6e8YO/OL3gSgpGEc+NqSkbOHd/x1pFCmMX+krXX0auw3ZynNmfwOy3NWcdT7oeKtKv2KE4uWgAOG9hFsOLTFrk24evXUwm6ztvWevcFDjRg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(35042699022)(14060799003)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VdxhsZ95/ysXP8RdLEbk4sVtvy2edVQtoJ6oqy2f2vUE54Q2Mo9e1tCwYr1WSdLoGGSVNKIFlJyVSKWPQXbElgmtgNyenbdug6KN14JYg/n1wFiCVfUjnkVFmCQDftsy7zeBdBBnFC5apMchrmHRQZW2c4pk7GLTu0UBqctb/bILTt6B+fDXuUyBIpXMP7goDZ5vemuf93YQDFAXgAzq3sHIC/MmP+cXwjQL+mdMBj5uUpP1Tpzb+i5I7It8c5/rJUpJEt/u4e+VT8rJ4jZewcZytBD6B8wAYvh9jGL52VyiptBem5YoT/fKoZXgpzm8ua8C8E2ayqgv67Ld+UAEUGbSEO5TU/TgQuqPotMHI+Yr1drtdridF6rTA0iISMeAQjF/a2rcXho+GZUbep6DokYVrs935fbjMzvhIsItdLEL5z6M19cjFQ/H/YcTSE98
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:10:04.0374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0add7375-722f-46c6-54e9-08def6c78c07
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7538

On 09/08/2026 6:45 pm, Alexander Gordeev wrote:
> On Fri, Aug 07, 2026 at 04:24:00PM +0100, Muhammad Usama Anjum wrote:
>> On 07/08/2026 8:09 am, Alexander Gordeev wrote:
>>> On Thu, Aug 06, 2026 at 09:38:39AM +0100, Muhammad Usama Anjum wrote:
>>>> pte_t is used both for logical PTE values and for entries stored in a PTE
>>>> table, so pte_t * does not distinguish a pointer to a copied value from a
>>>> pointer to table storage.
>>>>
>>>> Introduce hw_pte_t as the generic name for a PTE table element. Define it
>>>> as a macro alias of pte_t by default. When an architecture selects
>>>> ARCH_HAS_HW_PTE_T, define it as a structure containing a pte_t instead.
>>>> This preserves the representation while allowing converted architectures
>>>> to enforce the distinction at compile time.
>>>>
>>>> Keep the C type definitions behind an __ASSEMBLY__ check because
>>>> architecture assembly sources can include this header indirectly. Include
>>>> asm/page.h so consumers such as linux/vmalloc.h retain the page definitions
>>>> they previously obtained from that header.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>>>> ---
>>>> Changes since RFC v1:
>>>> - Add the ARCH_HAS_HW_PTE_T opt-in and generic wrapper definition.
>>>> - Exclude the C type definitions from assembly sources.
>>>> - Update the description for the new opt-in model.
>>>> ---
>>>>  MAINTAINERS                   |  1 +
>>>>  include/linux/pgtable_types.h | 17 +++++++++++++++++
>>>>  mm/Kconfig                    |  3 +++
>>>>  3 files changed, 21 insertions(+)
>>>>  create mode 100644 include/linux/pgtable_types.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index e9c8567308a75..7169bea968cf5 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -16982,6 +16982,7 @@ F:	include/linux/mmu_notifier.h
>>>>  F:	include/linux/pagewalk.h
>>>>  F:	include/linux/pgalloc.h
>>>>  F:	include/linux/pgtable.h
>>>> +F:	include/linux/pgtable_types.h
>>>>  F:	include/linux/ptdump.h
>>>>  F:	include/linux/vmpressure.h
>>>>  F:	include/linux/vmstat.h
>>>> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
>>>> new file mode 100644
>>>> index 0000000000000..70c3edd00a01b
>>>> --- /dev/null
>>>> +++ b/include/linux/pgtable_types.h
>>>> @@ -0,0 +1,17 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +#ifndef _LINUX_PGTABLE_TYPES_H
>>>> +#define _LINUX_PGTABLE_TYPES_H
>>>> +
>>>> +#include <asm/page.h>
>>>> +
>>>> +#ifndef __ASSEMBLY__
>>>> +
>>>> +#ifdef CONFIG_ARCH_HAS_HW_PTE_T
>>>> +typedef struct { pte_t __pte; } hw_pte_t;
>>>
>>> On s390 it fails to compile once we do typedef hw_pte_t *pgtable_t
>>> in asm/page.h. m68k, powerpc and sparc may also have such problem.
>>>
>>> The below declaration helps to resolve it using forward declaration
>>> and without meddling with headers, though I do not like it much:
>>>
>>> typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
>> Thank you for testing it out on s390.
>>
>> As __hw_pte_t isn't being used yet in this series, would s390 enablement
>> patches add __hw_pte_t to this definition?
> 
> I hope there is a better solution. As I noted m68k, powerpc and sparc
> may also be affected, so I would suggest to look into those as well.
> I would prefer s390 to use the generic one rather than circumvent a
> compile error in a custom way.
I've just checked all of these architectures by doing dirty conversion and
reached to same conclusion that __hw_pte_t must be defined like:
 
typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;

I'lll add __hw_pte_t to this series. (Initially on last email I'd thought
that the first user would add __hw_pte_t. But it seems sensible to add it
now)

-- 
Thanks,
Usama

