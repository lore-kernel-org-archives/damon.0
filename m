Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F5A43B6CE
	for <damon@lists.linux.dev>; Fri, 14 Aug 2026 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702053; cv=fail; b=bP6L+119QfvAOA6kuHcDD+iRPuCT1MUdjPiiTxTHbO0/tq0QtSXa5FtCyy+anhpFIXVlDtZFsIM31hncJPRmIfxAp30iNbunXhUiHfKvudhFm0J36fMRW1mfzQY5m7PDLkrDt1aGSMLAj8HywHC8hqUAsjFZRwJH15xsBExYDP0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702053; c=relaxed/simple;
	bh=nfStK3Pe70ZRRblEKj4btcPP/SQp5rNphn0OaMy4bbg=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kP1OP9rfaARQK925TQK/wtex5PSHmYVgnlToxzGzGLeBBlG5buLAQCKT9JUK16Fbl5h+k1OiZGyi2m3am08xHeNhOmChYJCapdea3hx3SHmnAOblXSc+HHsLVNqqPqrxjVJe/cj/ZaDZAawh7xPrbFU9KI1clp+y1RMVyOE4Uzo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xa73x8VO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xa73x8VO; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xa73x8VO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xa73x8VO"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=P/Nyd0SROwhVLBCUSEdETtGip/mshhnuA0gYRpop2NHd63NQgKGrjHXB1JBbBy7yAIcXwa2oFJZ+LBRqizxirYBUHQ6jZPywdWIeZeLc/vbiGmzsGtVQ5wYWFnxQ8PE7VyMzbKvQsyG+TtVm1bydsjwG1LV5ag4WVlRJEoF0FUn6sUsYEKOm/j438a/AFSxcj1zwuD6FAVdO5R4LUVQLdKkp4hVatX4uVsSb2e61vtObyTc/L1uwIZ4ktnVdYSOYVxxibzPWBkDnw8NdlrywsuLzmW0MGv0Etl7CwgNdjKcniCyFTRoRlZeDWgKVAZv8WMH/dQN16sylfksHGnhGMg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3KhvsxEoEP9z6JNj1aBx70Nx6X3XBZOUekklW3rbtQ=;
 b=LWYbMCmOE0unxHM1qAA+MNisvONMuvvvqWOl3/Jk0aHnJQku25RbVyl62HJeYNdC/uV61fq+q6p31Z1AS7AWCOTTbTmVai9M0M6qXWydqZeks5JUN3pKSvo8dpDzXLQKkCFsjSYuMaH7IGp6RHovred8Aidoo1dHLlzxafra7ahppfepC3OAaeDwYeIeBsNU8U81EsHf7OMLcne6q1tWqcsmBT9DCrm+bzHzEyPTvfNx4Ng27O5oakZzLCeoFJ4kafpvTnU0lvr1EgXQxbIO6bI2RvHOWCxpyZx37WHsRbdhb6T9qmN7eDQZ0/Uq2r6mN/lgrlqCM3ZfEDm7K1s3iw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3KhvsxEoEP9z6JNj1aBx70Nx6X3XBZOUekklW3rbtQ=;
 b=Xa73x8VOqP9SORkdx0HmJjWkb3uz57kANXUAB9hdYEYAtYJmLeE2YabwJREVIDuEv1ACZhPpSmNzQNZDThV0g18zfFCpkViSg2f9AxMSAyzqyY06lO8Q2enl3N0PSPGUuhiDSwh7mZg8yBwj6DT6IUdeWHq5TOnreBTaN+Uj0Dg=
Received: from AS4P192CA0028.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::13)
 by MRWPR08MB11707.eurprd08.prod.outlook.com (2603:10a6:501:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 10:07:00 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::90) by AS4P192CA0028.outlook.office365.com
 (2603:10a6:20b:5e1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 10:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Fri, 14 Aug 2026 10:07:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHmEnvHlnGBw4IwdJs7esLlclPRGZD2862Rk8b9wsf+poJ2rYvaUBfHOPunvQWGY5sYkl8wYrAn/QYbHHAtQyGPCTEJkGD2TJ4WhFQsPsx33YtXlw1LwXYRwVz3fOWwJiquTf1z6MxUiF5BgTZHG98PEkygMOeAHsS1rt199eD6O+gDgJTLzIHiZPgDkLFGccCmeryNn/dgQ7ZvlIPEKY9Hak1474QAC75YTnYzI50qA4wALw96kqICvycaCYHRE7Z/nP5nk8K3GeAC9f+/2oCuJaTM0OlcH7BBFyvc9cJ9DlaqACd/QE3coMzFmhKVnDfFiUHlD5oT+MsOS2gJLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3KhvsxEoEP9z6JNj1aBx70Nx6X3XBZOUekklW3rbtQ=;
 b=HTDEjnorGVlYrFORYmJdgvFchCM37g7vDTzt/byP84USaAURmmENe49RTl34SlC1zzHl6D2b+A7QmIrit+m8GN3JvghoHHjvQor0ke8o0TdXvyBSlm9HFG2tZkamq4qtJb1+n5TSDY0Pl0Ufjg7M/usWMZGI68M2+vhuGQD+KDPyWTY4vuDbimg4VR9OHJH8h5o7vpz2F5ilzIcp3fP0qqbBtmqN81mvB9WWkMPMg0McxLex/XZ4Xx9Lw3JTJ9aehR62XBuqz0omqE/zj00Fvtc5jtGUquybb5+N2V/NwDpoZwFWI3zGsjUH34t+FLowH8NNpN8wIoaj+G0ZCKR0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3KhvsxEoEP9z6JNj1aBx70Nx6X3XBZOUekklW3rbtQ=;
 b=Xa73x8VOqP9SORkdx0HmJjWkb3uz57kANXUAB9hdYEYAtYJmLeE2YabwJREVIDuEv1ACZhPpSmNzQNZDThV0g18zfFCpkViSg2f9AxMSAyzqyY06lO8Q2enl3N0PSPGUuhiDSwh7mZg8yBwj6DT6IUdeWHq5TOnreBTaN+Uj0Dg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3414.eurprd08.prod.outlook.com (2603:10a6:20b:49::10)
 by AS2PR08MB10111.eurprd08.prod.outlook.com (2603:10a6:20b:62d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 10:06:22 +0000
Received: from AM6PR08MB3414.eurprd08.prod.outlook.com
 ([fe80::dde8:bf0b:1dc:2a2]) by AM6PR08MB3414.eurprd08.prod.outlook.com
 ([fe80::dde8:bf0b:1dc:2a2%2]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 10:06:22 +0000
Message-ID: <99eac5ca-d5c6-4777-b16c-5a20fae95f5d@arm.com>
Date: Fri, 14 Aug 2026 11:06:20 +0100
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
Subject: Re: [PATCH 6/9] mm: convert PTE table entry to pte
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-7-usama.anjum@arm.com>
 <fab9fc78-1e1d-4d5b-a9ca-92f3ebd04108-agordeev@linux.ibm.com>
 <5c329236-7761-4e42-a549-b822e43b4358@arm.com>
 <2599c5b3-e8ac-4865-993b-d41e6f060d52-agordeev@linux.ibm.com>
 <f0b0dacb-fb83-4402-b0ea-30072727dfd7@arm.com>
 <e9de4158-b829-471b-980c-1999959bbc48@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <e9de4158-b829-471b-980c-1999959bbc48@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::19) To AM6PR08MB3414.eurprd08.prod.outlook.com
 (2603:10a6:20b:49::10)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3414:EE_|AS2PR08MB10111:EE_|AM1PEPF000252DD:EE_|MRWPR08MB11707:EE_
X-MS-Office365-Filtering-Correlation-Id: f70267f3-6bfb-4aeb-5941-08def9ebc81b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|22082099003|56012099006|3023799007|6133799003|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 FdM+vYM//Rs5TUwEEHIcmgNLmFMgPcbIWudfucKOtLwbQHuQH4LsRsLWhZbhUHVwlsUZ2MW/QlqZEBRFZOotGFq9ElB1fBk0T2wDM9eJxSONOc0eBnNbJCrYXcdL413Ax+OyfkfEoxy+7p6xfO/Gp0ULezU0rryPMHDxdW+WSS5rUULaD/qtxpsaexe4gAKKlRwpoKiMYC0kk6mOSF6nV//6DKRqnn8jaUxss4Jb7rpTjNrDntvBromiOXkyH+u738mcKX2mQvUwgMLXPwSoUcHl2FYCYlRXOtzbXYvxFs4S2yuivsokOQ+SAGvWRCMRzXK/QnoVKcb0xUY8+gZ88apENk0piPBxngMRBECCAR61rRcrJLUNQtlEB8HBbq/YpCmGNjePl8g7rSF97nWWZn5uqDznbnx9lhon+2zPAyx5mE7R4B8g1+I/ayLySqAwyOQtrDcO7Utgw3QJ5V1LabHy5H4Zq+RZu+yoYeVUyWvQxqZvBXrOzp8rjCTsZcVr6KY7JAdQq4tl5Ps/qB9tRiPALRaFbOG7P370QXOXENe/wCCzLSQ1wcD8BOuVSU5Yk2Obd7lxvCHq2207TdfFyw6gpkOv+e49mmqVZhxXI356CRSby/7mB6IuGiTs4sLL6Lcof90Lpfy9gfrzTaZ12kmtz9OQ0y9Jt1KAXQnZMIU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3414.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 hg0VAWoj1GcWWsk+NJy5Vc8BjrpZSBqh8S30aINiN6NxTNaP4iTTkJ91o6iF1/+Zwjb+/AU1X6UV8XTM3bUxU3Q8BCdzlOCy7kOyF2/QY5swJ6ur7BBbFXmGFS6NpT/ac5AA3biozKgSIVWQ+BMglFcO2/q00U6bDY7FjrezA7vmmaMQsVLMPQbt67FGkKdB2XVwe9vKRY6AHj6SJA5C8LJnCN/kIC4nQUKWP63TP6aMafYf/b5odoc4YiM9oEHhWuIHKuJJWkzrwup6r5XiD7ifQ667mLFzrHqBBcKWLla6YAbKP70dp40wmHUcEMJMSgsfMU8tyCfetML6h6+siw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10111
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	330ecdb8-6c41-4eca-4e97-08def9ebb11e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|35042699022|82310400026|1800799024|14060799003|6133799003|3023799007|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KHeTtP3Ez3wwyNNbieBSMway/4gRe8iRWUFJCAGvNs0bLohj5msdEE88dguIhGx9AwlATy4Bh8QpJK999Qe7Ygs8FNhdcaXVzuuFdm2alvD17z42SuoWXf83nDEr5w35H75y9jb4S0KXZIRjDOeVDxaaBjE5sis3HN5Kykdt5zVuJw5AQZ5xubmT35xPEnCu0y3GYKZ5eLLcTw37bcFLiklZb1X77eIYm2ke0GbM//0f0ub4zTdovAIpmmBc+58WOHPNS+CD77qJhIEYC/akCXymBadci6367yEKSMU4e5NcGJnj8JqgmyO9nvwAPKa6WMt6S05b73ukn/1tPQ2bmUFuuWXNj8MTk2nELSa3DTtpPj3RHOxtSsP6XKWeM3kEpU03PI7zEbZzaZwSV4DEkJCzvwZZ2RaI5bHlqZ+b9sh5dQliW/NU9KvmX27DT5Jlrye9vy5/NwWVIW0Y/skVjxklWLlJXJqmKalxmaLjg1LoWDzkvnJIxMhMSM3EkH8QSYfg996gv059xmrfEdejEi1dc93olCE3+uqiHKJLlbZ9SlTsKmQAu3siBSC0Yud9daUs/pYNW5wm8hTXlZUjKmgCPHDYPGOZHbms2bO01rmaoIAUNN8sbxXgSV9kKhiTH0R2Ci7G2X5gZn1sjfxZ6Y+l5THudegx/HUNYcu7TsRedeLETot5CTIf4uY0wlRE/AFvExZTiXSSdgx70TtVUw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(35042699022)(82310400026)(1800799024)(14060799003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	voy/rIUGFK9Y83RFi+GNLo0bd+hgd3RSfQNYGCPPneCOmqVfHeoDSEz9pSDOAzep+sUx61TMpDPKCB9IDpD6Co7/y3O44IW0kdB04Z0I725aUU/9zjJ44UogCeyicQh5K1UO11J3b3jV5g+yGae4vu1hPw0HiMzMb4gmAehNq6jCyH+ffXyj2UH4aUYGGPpydjjhWcY5v/yqPwR1QQl4km3JMup0lo6raH49nabPQkkRfGdZXR3xBZWGnrNG45qILSxSVqEwMREJNe65+wD4BFEz4R9sUg7F7fpQzLRHgZkzENoozxHEi9FMNIf+tXUaYleVDHbkOU+UnCf64OvsGsOR+eFjgLxVAEsxG+0hwA4Q5pTe4Qv5Kf0kvd97r+u0veUJJzmGIozXywLWUVsphZvmxzf28lsw8z50u6OT/s2NsnXIqB5cclwn12qbnSS5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 10:07:00.2055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70267f3-6bfb-4aeb-5941-08def9ebc81b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11707

On 11/08/2026 1:11 pm, David Hildenbrand (Arm) wrote:
> On 8/10/26 13:06, Muhammad Usama Anjum wrote:
>> On 10/08/2026 7:44 am, Alexander Gordeev wrote:
>>> On Fri, Aug 07, 2026 at 05:26:04PM +0100, Muhammad Usama Anjum wrote:
>>>> Yes, this is particular line is for non MMU. In this case, CONIFG_ARCH_HAS_HW_PTE
>>>> would never be defined. Hence hw_pte_t is just pte_t and direct dereference is
>>>> allowed. I'd thought a lot about it; is better to leave direct dereference here
>>>> or use some helper. Then used __pte_from_hw() was already being used in generic
>>>> ptep_get().
>>>
>>> But in case CONIFG_ARCH_HAS_HW_PTE=n __pte_from_hw() is still gets called.
>>> That looks inconsistent to me. Why not just call ptep_deref() (see below)?
>>
>> Agreed. Calling __pte_from_hw() directly exposes the representation
>> conversion at the call site. I will introduce ptep_deref() and use it
>> here.
>>
>>>
>>>> There are only two users of __pte_from_hw() at this time. 
>>>>
>>>> ptep_get_sw() or ptep_get_deref() is better name here?
>>>
>>> ptep_deref() would be it.
>>>
>>> Do you agree to the suggested API requirements?
>>
>> Yes. hw_pte_t * identifies storage containing hardware-formatted PTEs,
>> regardless of whether it is attached. ptep_get() is used for attached
>> entries and may provide additional architecture-specific handling.
>> ptep_deref() is used for unattached entries and performs only the raw
>> storage-to-value conversion.
>>
>> For review, this patch would become:
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index bc0b9c65aa1d0..ce900d2652d91 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -1283,7 +1283,7 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>  #ifdef CONFIG_MMU
>>  	return ptep_get(ptep);
>>  #else
>> -	return *ptep;
>> +	return ptep_deref(ptep);
>>  #endif
>>  }
>>  
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 1768421755a9c..08613593f3320 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -490,6 +490,13 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>  #endif
>>  
>> +#ifndef ptep_deref
>> +static inline pte_t ptep_deref(hw_pte_t *ptep)
>> +{
>> +	return __pte_from_hw(*ptep);
>> +}
>> +#endif
>> +
>>  #ifndef ptep_get
>>  static inline pte_t ptep_get(hw_pte_t *ptep)
>>  {
>>
> 
> I mean, how many such users do we expect? 1? :)
> 
> Why have a helper for that then, that seems to encourage it's use, when really
> people should be using ptep_get() ?

There is only 1 direct dereference case and even that is for non-MMU case.
That's really good point. I'll keep using __pte_from_hw() and put a comment
in huge_ptep_clear_flush() that use of this must be avoided at all cost. An
API can be introduced in case more users arrive.

-- 
Thanks,
Usama

