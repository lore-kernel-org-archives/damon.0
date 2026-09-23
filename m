Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED91535FA9
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171278; cv=fail; b=GWP9uXLLEt/I7Cn7BjfgsjE6At+NmrkZes9GHIAyPGXQ/HZZeB/43QiDsAJys6oDM6Tt9625O5lHnEyzNFsIDKa7tJDQzghjbV3LWIzpkmzYPCIHViCcJ7Pf7bXqBBck93+eCp05GdyEAieHdUgXHQW7eRWG0HG8zPvyKgS8pAg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171278; c=relaxed/simple;
	bh=e0ChUrTH85n5xj1cgn5qFFxGpX7mriXQi2UUBmrXLsI=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rwFa9AhAe+VX/reS8nySO8qffaMr6YP6QOl22zWy/PfbPCNkAjMtZqnhess8qy314q0CinhBqUSZPCIVTveu3TB2jgwTrat6kq0bFWCBOkX/zbzTpEIkbasCktRgIlQM6WqpvITFd0zjB0DJyf4KfLMkuPPBn+vZuDoD6ZYHCoQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CEAnJKHd; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CEAnJKHd; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CEAnJKHd";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CEAnJKHd"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Nsz2ByUKq41InmoRZYGnYAcdpwRijRMePYQLBFspsQqgpQ7seDaoIV4Wn2rUwgocVTRxhLbfGNpO0hHM4I99UJTUjx9jR8MLn1MU8x/VWItNWkadirihNwXlIHxCyPfdDFCdw2ucV4GBqd3DB7Cb8/Tv24lG/6QnznEyLwV3pN0Aog+QLbJTNz3dQ7NHnp6aO8+b1gZ/58hSBxzUP8cW+z+8K3XADbn3Z7kQHiK7qFqBm6CLW/tG8nMlfPrOqzw/Dk0zS2sf3PLBwKeF/Zwwt+aMwsPQBcrFnyc5v/g8nptvfu0uE+fA/kSSvn4D9yG7qhxeoiMuvnqSD/DSCBO47Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhJoI7Wuj8ebK8ZsC9lfG+NOdXn1WH2SV3Bha+yEvZU=;
 b=KFPTMupYvvEDU18VZragSHrclf/EXYKMAUcJLSxNi2GJPxtxW9d5vQLM/QvR+X+46BwxrNMBJZtNnQjQBMD9sFInDT5ck30XcixBrzo4Wr9QS4ZbOzQqGzLSaWwP8MAaW+jWWUQAkkUwyFdBobp2BS59wKLZUKqO9iM3LBG4owQuD4YL3aLNGqeh64+wNwnvQjPGO51e0TVMS2FsA9DoOCQVcwkpJJjzhbEbRXuFjIcbMxJSZBD0C9ttRomVGfo/ZbBjYIGnXHmVuk7+o4NZ4JmqfJ5B7qJ2CMG4ctqv25PWZ0nWfMimHae+GJ02mX1soWLx3pofL3WdV+QeSt6H8A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhJoI7Wuj8ebK8ZsC9lfG+NOdXn1WH2SV3Bha+yEvZU=;
 b=CEAnJKHdb8pQYooTKptKnU5SRdLbDsAEXe4zpgonArlQ6IOgiZ/8YIcavCracvPOjQpwUG6IDxmkMRotOFU70VAs2tvEkbWl2CDlFoaYztnWgG1xGsH4yIaMIWIcku6xHq/1Jugkyrr5fMSl5MLqGbPsNAIWqIzXCdK5hRAzHtM=
Received: from DU6P191CA0053.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::23)
 by AM0PR08MB5364.eurprd08.prod.outlook.com (2603:10a6:208:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.4; Wed, 23 Sep
 2026 13:47:50 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::86) by DU6P191CA0053.outlook.office365.com
 (2603:10a6:10:53e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 13:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 23 Sep 2026 13:47:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ickhjXQUhKmKADyKvpX2SLen/DlJScYm9DJfnqtrT0vB5PCb170fHF3jxmOwNXlRzLUSbUuP1wAziagOgnSFGBjCttrrcFfENX65D8i9dP+ln8RQFfeUzG89n8fu/T/UzZma7+gknAH7MSvM8CLP3W63eC5OYD2IYMiWpiFMa3GM4gK2IX7P+ViaJ76swrL1VFmYumr4i47G28whFE38tD9IZ53B8tYhTEhi/T7VIrp7Esksf+puHqaCYgApPb54POHoYBpshiTFtg8tmqc20JN+oFZbq29vtym7n0NrIl2UoeLrwRJC6oVTX7oFwtYfOFa+a20xFRBPl2pL+xlMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhJoI7Wuj8ebK8ZsC9lfG+NOdXn1WH2SV3Bha+yEvZU=;
 b=vu4VSN3RqZb/Vcgwz/Wf9VmAAobBhpMEKFhHyr95Pjgw5OIiRPvvaQmdoJHZVLoLB52Nl7Jid26+nwpGAnFX3Zu5E6Fv23fp2XSMp4vtChySpfU3S9aMBep1Vb7KV8GRW5VuzCZDi4l/32O8rKO58Z1TH7/oEc1sON60J5QjSGVGbcqfCrvSy6efxkpmT55txFhjgEHEcigFViy3srFQ0r51h5ybwODA0eJ9pF1vAXgV4EQTrIL3zjWfh36yEsgPxGy7P9Ht61jsn37Mmx8JHPQVqoqLpDTx9xQc9sFoH5nzkmZyH3mjkF1kQHQPclrH7u3xww14apmPa9K0oBtPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhJoI7Wuj8ebK8ZsC9lfG+NOdXn1WH2SV3Bha+yEvZU=;
 b=CEAnJKHdb8pQYooTKptKnU5SRdLbDsAEXe4zpgonArlQ6IOgiZ/8YIcavCracvPOjQpwUG6IDxmkMRotOFU70VAs2tvEkbWl2CDlFoaYztnWgG1xGsH4yIaMIWIcku6xHq/1Jugkyrr5fMSl5MLqGbPsNAIWqIzXCdK5hRAzHtM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by AM8PR08MB5729.eurprd08.prod.outlook.com (2603:10a6:20b:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 13:47:13 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 13:47:13 +0000
Message-ID: <e4bf62ca-886e-429b-a268-3c0ef7903bc8@arm.com>
Date: Wed, 23 Sep 2026 14:47:08 +0100
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
Subject: Re: [PATCH v2 0/8] mm: distinguish PTE table storage from PTE values
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <1401e907-04ff-4ee5-ad03-00d88531a091-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <1401e907-04ff-4ee5-ad03-00d88531a091-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::10) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|AM8PR08MB5729:EE_|DU2PEPF00028D04:EE_|AM0PR08MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0d4b4e-2507-4f89-dfc3-08df1979422f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 er1QZE7t/U3keliySsRiVAPvYcTdlk2LDXtXoxCQiX/p/iuft5DFC6Hg211hZb0NWQwvMx9IUr76nD9aJUEw77Mote6K6GncWOChMqvI1mvAdPiuFtY7C8ycOlKNYQ1tlEBYn1u1K/U0k6WYfHH8R9ubi1rj7q/KBa+aCM7tPa+BrOAUYCQuzhK4rHTtfI5dsJmYjVdU5NX+nPgICeyXE/qyix3tFyt8G5IoWrTWWFjVB7+b5rbKPsLN+kuBxibKgO9CMVu62dGdE+/EO40XuvQGsUBKik71rer8bglW18v0Hu2rF7C1JxLla1p73iaseziW1mjUv1m3YExgnIIMl+YIhaUOC64dFjPaeqkNJuKmYJeIDoG3g4wXQrYkck6UDnuAXxx3/JoD2gQR+ruheEguivjEq7VUX5QFYAwVdM6H/5ZHufLQqlO57DMlRyvVDUlvzJogbPkIWPJkJPrUDipq4nDYlgZ80fmDOpQ3NC1GqHaBk4DBDE2YgXlP6ZPPIBZwWetKZuNaLVhqTNtBrf0o+Xt6yHnVRPgEIBuo8lpAhYP1Geok+PounKdZ6Dt/kcTPVM6opmbIjL5lpa7vxzvMWlR9fG1NNwyvvz79w14YiI735TKIMcv5NJf7vgmk
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 iITv+pbcilPPsUiFk1ljo6e+oEJjA5GQCrka1p5aoy5sK5/YpMHzwUzjve+/D+zQXB6T1hlApHgCWb4Fl6E07hSm463PAuBWWM8E8SJ95bMwPp9IZwnx5wy0gk6CrZWd6dSZPpZc/zVzXW7s4wtmsuH2SKf/pikvXU4rLMkejhus34n3qKxApBaHZ0aMPXv9HR1pDnmOc1Mi0f5FM1pN32GHc6thNsrNjHfOBDs4lij2vZbPDUDh94hF1ZWJZHdjQUMerPNjoAX1yhxuh6zhB1ZPQW9M7/qXajnBALmMcnt2uH9RaIili6VIXZCziCKY8yjahJb/qe3bqcLthGwBpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5729
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	43bfbc74-461e-4eb7-b61a-08df19792b6b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|35042699022|376014|7416014|1800799024|36860700016|14060799003|82310400026|13003099007|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DAixqge82KZo5KFOb8H7YDHoeJqXi0dCh+VHlqblZpq8BQKZ47HpwsjXPUKatKtiNK386Slzu014JdEpANGZWk3benVlmI2C96z6DI4rJKlddh6LSfRZbsKEIw9SF+ASyY/4R1FIYZZezBS22kQTtivZAVIZ9eNd/Ir3qyp7saB2GtzBsEUvNPo21FdowOhpBXaqk8dgNECY3v7F6WnCX7uzOObj2juN6FVykVSbCDqSYHDcWtQ2j0Pflwbdp4UpQp+62fGeRmi8iOgXCaMPt3ELWYisHl7YOGV+XTTQYI+cyeIe/t3p+nf2UfLYdCfZLZoMOxoFVatsRcwMxPKVaEJ6TSP3h+XSGG8dPr9urc7UXRYVgHZcFXb+ZxZsQVwL8Uf73BevCImmumO1cigFHcWJdmo4it+AdsUGqaqqHHPq7bIbTqcRpdw9+hnYgzuhAU0SkHrq+4jUR6uC8Vkp/u6OA1UoHsLaC84AWYt64TorlwFSwMvfJnxr/Uy55NsiUZigEF1rPJLuraKOqCYMBGdUrmVCDoQpS8GaFiZKp04KN7dBdW7wFdExTAop0ZesrxEx2xbzCoNM4sRPtmEU2oynE7j2QeP1SBuretuaM9CKBV4LPzQdltyhyUCLChhpbcRlmyB8hBLDLGtOuHtAwF3DD/zXGTzDvV3VN1wnuao=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(35042699022)(376014)(7416014)(1800799024)(36860700016)(14060799003)(82310400026)(13003099007)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	48vbjjntj6dxHIZVbgSZ3YiLn5SOqhQvlSgC8CZYjCh2x1vKovgmzgVKdlnMvfzQhb7wbdnactLTvlQF1YQamuL1OyRqtX5bxCZwOQaC6OBE/RNfLSeOOA3Kr07JntUQ+Xt6bL1h6ETKfh9u41BmfVWF5FwWRe9cr67JFGjKRAQ3nOCX2vsimrPtLNuNf7F/6WAwq1ZggLvIMfWW/GXaCuR6FX4wjKZCViT3h+Qaw3gAUm75BHoVKBrR2sDEKnMofMhHOooHKPryaOdQ3Vdw8cRv6iDu1W6ru4na80vqLs7BoPn6oWqGpZL3Y/aGiYGDlUc5ccAQbiHtcI/WATL2m+1hhRpz5aPJ0sV47VhUpypKzOv8+6ACxOeRbBqF9Nb2Zx3Df5f4atksbIC91TMCyr+g1B99orf6TSJT9YjEMCFEvoN0x8AQJtqGQbNoF7WS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 13:47:50.1070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0d4b4e-2507-4f89-dfc3-08df1979422f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5364

On 23/09/2026 1:25 pm, Alexander Gordeev wrote:
> On Thu, Sep 03, 2026 at 11:29:52AM +0100, Muhammad Usama Anjum wrote:
> 
> Hi Muhammad,
> 
>> I've the patches here [3] for arm64 conversion which I used to find
>> usages in generic code which I missed during development. These would be
>> sent separately.
>>
>> [1] https://lore.kernel.org/all/6110202c-057b-4701-8c04-1a76ee7bb9ab@arm.com/
>> [2] https://lore.kernel.org/all/a063f6c5-2785-4a9f-8079-25edb3e54cef@arm.com
>> [3] https://gitlab.arm.com/linux-arm/linux-us/-/commits/pte0_arm
> 
> I checked [3] with s390 and also against our lazy mmu implementation and it
> looks okay.
> 
> However, is there a particular reason this series is against mm-new?
> Should it be against the master, it would be easier for me to try it in our CI.

I think, mm-new is the branch in which this series would be picked up. This is
why its based on that. Are you referring to mm/master?

-- 
Thanks,
Usama
