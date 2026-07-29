Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741042C4EF
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344680; cv=fail; b=X8wAYQ9oji/6yjcEKm9ih2vexBPt4aNgv5ewnfLorgx/ufGNZf3fvr7KGfpy1VO/KdY3iaGqZqcS08jgBtKdU+26G5gUEiytzcvIgS6rPpPAnr1PEi+/djoZpXvcILtAVsBF6fsefCJGDhOUZer23zo09KB1DuuUR07Oqc5DV+o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344680; c=relaxed/simple;
	bh=PK8yOMUXakZ2cfqZghzpzJKHldPrTnlcNVBxo9DqwIs=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uDzfyHGB2CYM0Wu9yGqBrrfr6m611G7EyxVNYYcuq4kAHjXzzY8GC8B0FnxGCg5JHTCG7t5Coo99zLJQmz7EAQa/WAYpneFV2mfa+IaHG6+5F0+RnfjUL4XGWjDi0H0FLOLqlpnpQ9/JSvUhh7xMjcD7NgzGUYwkvDbqvNw4Kic=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BncRAtb1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BncRAtb1; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BncRAtb1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BncRAtb1"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RVbgkqFb40HwmHd+a4OzHFyinpP2GCUSAWQmxa4M02J707P1jroUYFfMr4569eW9A+WT/AMd65oljCcyIBwFw62yvMaizGIEpaqJNgit2bbTi/WtJQEvx6bAbIaXW3DS6dChsHXBSn7pCUOjqJMUlEv8UuLNaS8WUppemSxmcK7sNXFg5Pl7ys79ecOvNhotTvEfzOePLc7KdSKuAvRjHTZhCDGgsjH/qO+q8cmz0j4B/5AlBm/KoPyHfkxlwZi5z9h2lf7JeCsYYC9OJMWLOXBSUZjxF+5JdBP9MM31NZFl38juK4xRoBYAnJ5QK5knRe1nf6XZ1g9BAAnnjp30nQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbbUS/qk5aVVW1vC8+CkjZ6Px4apThCtOkwiM7lkMQk=;
 b=fLEJASVQJ79h7IE9Nml2UPxugvzdEhdhPawTugKmzeEsObIYbsBOq5NqlB9F3kLy+tf/v3kDlhT9XxODpJzMDzhb4J200AHY4RR7162rBhcdbRwqox3KWWGPcI2NeBHNWNtzYRB0HX2OIujUy45lNbyLN0yR/sHQLN7xVPqNeMY5tmOKL6WvQvXMEOY8J6o65zJExnXpM1KfErbJHpnwS6xKYEEn3SGP9d/7Uts2GNgyPr/hCa8uet/ae/ustRWV0Lt/dpydzMKUC1bONAmew0nU85mOEwN+jDZgV2CXrz1B6bOk+Aez5cBmFAH9ULgTIBriL4BviszJwDbYEvqBVQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbbUS/qk5aVVW1vC8+CkjZ6Px4apThCtOkwiM7lkMQk=;
 b=BncRAtb1wxWuxlYq3hw2v/M+04GjdKg+y4JuhjiTTj6i7XFl/6Jgw2fj+4b0moZKpngDIgLO6TQajpcJFf7aQKeCWM0Dyr1FxXKWsS/BxLIciiQgFsBGYHYVGXc59i+87QMOgh3eg+DLAUo73vT/abtt5OLSRIIXj/lENHQ9qeY=
Received: from AS4P250CA0029.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::19)
 by GV2PR08MB8148.eurprd08.prod.outlook.com (2603:10a6:150:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 17:04:32 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::34) by AS4P250CA0029.outlook.office365.com
 (2603:10a6:20b:5e3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 17:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 17:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xahEWMRLnwid9CUeH2xMEOsP0mG5mVIig03K9CrPeXgnE2GOpBr+kyZG+F2d35nN7dR9xvnXrP7djuCDDm0yGzzPCPLmwN9HVJRprqNsY1afrMOM76IATPc6Bx7cxzusYrxGi0huWmRQGSfB0QfwawPJIKbKFggt3SIihvOynDbEk3eLLBRhW2rqGskNlTyPWDq8w218z4dshXjQG7JrtiCZb8UUmiCp9IeCf02pp5vMYisEfl/Fqb9WAWkRqg1ftPnNj9ppDIsf9Q6yGfC8fiNJoUKPfwXfvqkzxfOvFUxsmrsXu6aIvBBVboUs/a/ltqbKrpSiLr2Tbuo+ui5Ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbbUS/qk5aVVW1vC8+CkjZ6Px4apThCtOkwiM7lkMQk=;
 b=O/164cDNkIYfZ57+OU0eVLSYvhlM5ZSK1fDakvR237cxTdJV425e5h40oM0+vWNWTYYZbjS2OvWO1AwvWygrxMBzG+ve9IVN63Qhel7K8uGgreqLZI/laB970xYq/Xnv3k6qIohwLrGyn85FCaC0O5tBWx1IcDyuQtd4HwwoU0YnPOX9oqrN4gFotW/HHWygtNEzbgx7cniww0Dz6kHuixHYY1RiZxaM3z4S5QTYNUjH6fy5mvJNpJuQ6fgPcNbXpY5xk2fXVvexrXE7I9tC2S7p7aDARcljsa4nhrjA8kxpcNWfdxBXYzmwgly8WQqD4llBzx2j+05RCCurppSevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbbUS/qk5aVVW1vC8+CkjZ6Px4apThCtOkwiM7lkMQk=;
 b=BncRAtb1wxWuxlYq3hw2v/M+04GjdKg+y4JuhjiTTj6i7XFl/6Jgw2fj+4b0moZKpngDIgLO6TQajpcJFf7aQKeCWM0Dyr1FxXKWsS/BxLIciiQgFsBGYHYVGXc59i+87QMOgh3eg+DLAUo73vT/abtt5OLSRIIXj/lENHQ9qeY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by FRRPR08MB11966.eurprd08.prod.outlook.com (2603:10a6:d10:1d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 17:03:24 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 17:03:23 +0000
Message-ID: <e0f68f91-629a-4aa7-bad9-11ef7dafce4d@arm.com>
Date: Wed, 29 Jul 2026 18:03:19 +0100
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
 ziy@nvidia.com, agordeev@linux.ibm.com, ryan.roberts@arm.com,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 09/11] misc/sgi-gru: use ptep_get() for page-table
 reads
To: Pedro Falcato <pfalcato@suse.de>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-10-usama.anjum@arm.com>
 <amnxCmFU40QQaxTx@pedro-suse.lan>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <amnxCmFU40QQaxTx@pedro-suse.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0023.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::15) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|FRRPR08MB11966:EE_|AMS0EPF00000193:EE_|GV2PR08MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d18064b-3544-4c78-7fea-08deed9375a0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 DaJWhsTZTSxcIZbwinfD8XxtPw/2f++czvjbD1W4bd4XreSaU6D3188u9w9GWQdT1JXBI8k6WeoGO6ebdA1+x5ERQkgaS+IvsRPUFarLXoyLSoHZCSpfHIwd8F8MDWoNeQ1ES6E/mzkjlk9uqRqSUEnOeLxSkLZi6rsNJwpm6ua931PyYrgJVmT6wev4vTkMgr6syRqwCjlvl016KdBkPiyWoyKxZXNeor7nen405U+6SC5mEjJpEHoT80H3kzt3gxPjjZbNpd4hPE5DyqouQQ/VsqiaVT4B5FfF36BO841Sp/Xl1P8QhSFShghy3xRKonzeQ6A/ywt8H9Xc7keLkphSLfy4PtFSq3IQ9cNDuKln6Hvy3wazEyx/gr/sfCYkTZxE2WgTQ2sOWSeZfWA0h0Bs//n0R4D2bofUttfS5x1z/oSEZO66wztXTfYvOjSF4x+5WgQMtt44LAKW9yT0uqPjlfJb31GONqzqwi6bX+GqpqX9cYgrlXmoVI+N1K5HndLAeojNGxA1aOc+48bNI+LQ644ttsRtlgno3Kz2zTeOy2B2aSZkC+ecrjfht61nUE2Ky3+IWsStwYWvifvhWPtHsv2iZXgW/f3/PHUR8FXVam5L1/5xsQl5FIGgf0hMGGNYQ2A4WaTk1Pb40YB1BVCnjNZIvY4oAW6YwLT8GW4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ZiugpGqFJussUsX96Dr0qNIxsdKxjJBS2tE8DuDcDfFRexZmwdjfLQBMcHCaqX8OW1QUx7kPU5UoDm0xLd+5To+L1Lwby9UJzIjM7tj6tA5Gw+zuycwLiOY/6k46sQqIznBHfE1A0FGGTlp4WsiYDINkUezqpj2bXuRimKRIR8fvUQKmBSt1LLeBmJQ2za0zrmj0rciHYG5LhQEQzEyqn2YhvwKI5abL5D/+qqH+vCRW9DPPMD/dKpxd8el7hfi9uzaC51A5QUOe3GYui2sBAzf/m04Y5tcPJZU+DTlZbZmqZ/j2M/F5BLeLb4tlW6TNh/xL4+oFjqd9nq4+N9gbjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR08MB11966
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e588c869-dbac-40f5-682d-08deed934bdf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|23010399003|35042699022|36860700016|14060799003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LqNi0pxk/WQJEqBwV36BbnxYavF9w6y1oG2hziXvd/QsBnpT5PgyoUYYXiylJg+EwhrcuUJhIIzf9eLcLuR4Ym+5AtEKuNUJPssMvV6gwpm6Sh/463ffGfV+NwlXvU800sn0toNI/tyYz90fe5NSk7PkMcDCUqbvp1Lde4i8I3Zg2XIC9MxGnkOvcRjSBe6QWBU469qhdNnFJsFCPhyN3JG3K+NkcnWTz0grf0EqwFwAq3X1/P3EvxaUp6FoeN3P+qNaFuk1unAqrEO1EadbiFEMuQyyc6uy3uOVK2Bk4HacxI6Sg3dDJ4FZn7L4TSjUmL89x6tE17fCk/RuCZXc/Y9h1VjcA5eNK56pRfXafKZRwhqUNe041Zlnzskxi81kyxN+e/hk8oEQP+Zxw3HHYsZVBFqA+m1CYqqLm1WbbnDope9Ak7RTs6dpn93szsGacOAiqaK0Pqlq9OpbsIzMvycm9l1isTSagTitLZVUKg4sUjldQlOmppm4sHaKIS1aaP/aB10+zOkjN04sxvhCaNyCxjwc5x1CdRwcs3T8NU2I9MtAaFe8GW+YJQZNm38sYpaIhCDqJOR+83Gb2Hz/3V7Y37sLNqvdA+QIQiUwygT8i3Y2Rj/PvwXptazoty5iuYlgcXfeyS6B6Nih1UlIg2LWM+EotGt4JU9CvZIJmqr75DwYJcMMVYtPJOhs8tD7Lgvxd4uuZKaJcz4K1AYMCw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(23010399003)(35042699022)(36860700016)(14060799003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QRqYAROp8xA3sf+JWew6LKUjBrMYao1utpWvJ/6Y//VIFQ/1qjoj3M9ZVWgQrl9UfPm6T8/5RpudZjJK0ivA2rUkzYPliLNeZZWK37HQEFTQ7HR5WG8SvNcUyTNZTsBTR8H4XXmFG90EBhsVhghqjj2WKYBJJ2x4wt6ANe8XDOkEFL+UbGOQMkLEDDwGIJby4v/WjXGX8BGZzisKMh/+1kwIniANLZhe9EmU/zZa/RBvGyRNpvaPLOXqTbTsPztjhS6oQU7BT1ZqsSXNQFtuYXfRfsVAJLdFqFoHaiKMH2p7sac9ES8jh6dt+DUdkq2bTug+eAuTq71XIxDIwdfHP0ATNy4giEmAYoQD8aX5luvZIGvEFMi1Ozd7//wXrBqv7me5ul40k7DVvTq/YV/FlxbSUSEQviN9fT4CEx8+2py8hsHDEwcMbPyX/YvMHISB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 17:04:32.1124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d18064b-3544-4c78-7fea-08deed9375a0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8148

On 29/07/2026 1:36 pm, Pedro Falcato wrote:
> On Mon, Jul 27, 2026 at 05:47:00PM +0100, Muhammad Usama Anjum wrote:
>> A leaf PMD is being read through ptep_get() by treating the PMD address
>> as PTE-sized table storage. ptep_get() now accepts hw_pte_t *, so update
>> the cast accordingly.
>>
>> pte_offset_kernel() also returns hw_pte_t *. Get pte_t value by calling
>> ptep_get().
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>>  drivers/misc/sgi-gru/grufault.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
>> index 3557d78ee47a2..ff89d34ad2aa4 100644
>> --- a/drivers/misc/sgi-gru/grufault.c
>> +++ b/drivers/misc/sgi-gru/grufault.c
>> @@ -228,10 +228,10 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
>>  		goto err;
>>  #ifdef CONFIG_X86_64
>>  	if (unlikely(pmd_leaf(*pmdp)))
>> -		pte = ptep_get((pte_t *)pmdp);
>> +		pte = ptep_get((hw_pte_t *)pmdp);
>>  	else
>>  #endif
>> -		pte = *pte_offset_kernel(pmdp, vaddr);
>> +		pte = ptep_get(pte_offset_kernel(pmdp, vaddr));
>>  
>>  	if (unlikely(!pte_present(pte) ||
>>  		     (write && (!pte_write(pte) || !pte_dirty(pte)))))
> 
> This code is super, super broken. Can we remove this ASAP? For starters,
> we're using is_vm_hugetlb_page() to detect page shift, the code does not
> grab refs on the pages, uses pte_offset_kernel() on user page tables,
> does not handle PUD-level hugepages, does not handle PMD-level hugepages on !x86_64,
> does not hold page table locks nor check for pte table retraction, etc
> 
> I don't think I need to go on.
This and parisc both have dead code. I'll send separate patches to remove
dead code.

-- 
Thanks,
Usama

