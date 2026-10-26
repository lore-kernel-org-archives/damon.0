Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793010717;
	b=AG+AEbzLZn/kvz1/9guc7/drlwKtIpZS4fBKAunrTFYd4tqgX7r1y1b/+dzxxONH+BqO
	 7o2jHJ0i6FxWIIzObqeLXZxyKjMU38fkYzIn7mCpt6zhX0Yexj3sYh1hmzKuqJqT/JZC2
	 xZAFBKBiHjmzAfO6Gc4DMqouUsPfCnESmKFHM8CGTvbZtB1YKFLtdBwTK/PGYwdTa9zOZ
	 9hJb+3vEyI2iQtseL2xdK+PcwKdVrGnV2TUQ9HP/efMW0ZTVtVcmzWGPfGL/bigJ0rRrI
	 egOMn9zBWWPT5gtsGUfBljFQ+tA6FXi60SoDr0tG21jVaZj47Hf9Z3+aESDG2ozU0wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010717;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MDZGFnq1guYAW8pw467X5VXLvibb4aCvLrPKmuhnonE=;
	b=iTEaEm4eDOsFC2Wr2hNRKL1kWeDY1n5aDo93iuk9quX2Br2FIW2rBWErI3CEDIuONV1W
	 EPxhqq3Yc95nMoPbm0Sn30Rgs16OVps6WYmvOivbvLZdGFcK9br+JWXP2zyxg6z/wMLvb
	 VZ7yILIut5jXnIB+R5DgLI8CZOeYpP7qmub3rX5pwchiIEk/Y6b58xjvjeR5JpbsG+fPG
	 vbsaZP596yIz4g5SC+RuIrfzipri83+rRBmtHqKGzEKXjReVuOGusn3Mh4lQ4sK040D9N
	 g5C53sJ9qgGT5Ae4p0vLHop62/amZax0wZ0oH+nRP9aBj4O9zlCfv7n7Cd995/s15xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NnlnGHIJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.29
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DC3606A328
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 10:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5DC3606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NnlnGHIJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjdiaVU84QhsjuIiQLApsCrtJteL2GtakDUx6FeVKbI2ubLEoNZUPGutPJIL5gD5WwUGRfrkCc6PJg6wDTi7MZnCTDPhbt5+E+GsFxNfeonqvAr66dPTHOp8xW9EDEzeT/tCsyoEXS8VWbHewYN6oRhmSauBzPSAg0d7k4hytRMFKAUQAdi6G3Ud0w0p/3eb5zoPfnOv8G0wYzXPuwT2XL5yjSYGvPdEg07MEP5zwU7v0hvcPUekpXsSb1ak0pfzshVIHoma1f8PA50yXpzvle2Fk5OcSWvK6FQLrTLSDHayzYrLL7ux2ltr+DCGIBmydeUpKN8XCbdI86oQu13gwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDZGFnq1guYAW8pw467X5VXLvibb4aCvLrPKmuhnonE=;
 b=FY0VUeRM2CzRCM+VFp7etnHuiCG+ErrJ6W8rP40tq4vOS3+lbI4gbYCuEbP8+2w3XfJryFDIk77lhwVm6E0q43fk49Zaaf2AtX2yH+BUqAyI6OhSAPoGygDGKkQBZlSTZTdNX5sNx+0KhQyxbiKM9zEIcjw6B3iNEF0jwp0jvnapFcdyyqDFGQtaRdHo/ncSVr6/W/MVLTVG96hKOVKlZdlTcYUgn8eR0NN1H2Sm0YSP4425Y+/FVI0cYWH0b4JlsSgJ+LQ0JRFJvypLBIYLnNxcLiKeXDGgKBADX8LAEanSquo6j5rDg7IrYXtfx25v4xeqrnDN5+Ne/sd3FRTwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDZGFnq1guYAW8pw467X5VXLvibb4aCvLrPKmuhnonE=;
 b=NnlnGHIJLSx2RExyYlmnAzKRwLOIQoSMfZTOamerXlE6t8+CKh5CmQXuwN1ZsMa3m1TI1XWnX78obTDWtM/j/UH5Cgr61+2rWSXNw3Jp1DKJCWD/zNgD+zXMsdSRp71pS3ZNLesCU1jhisSfAAhmTl2YIYxXTXx/Db8/tQD/jbY=
Received: from CH2PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:52::20)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:31:51 +0000
Received: from BL6PEPF0006C3DF.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::a4) by CH2PR04CA0010.outlook.office365.com
 (2603:10b6:610:52::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 10:31:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DF.mail.protection.outlook.com (10.167.249.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 10:31:50 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 05:31:39 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Mon, 26 Oct 2026 10:30:31 +0000
Subject: [PATCH 3/8] mm/page_ext: remove unused page_ext_iter_get()
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-unused-sym-v1-3-82ca2dceabe1@amd.com>
References: <20261026-unused-sym-v1-0-82ca2dceabe1@amd.com>
In-Reply-To: <20261026-unused-sym-v1-0-82ca2dceabe1@amd.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
	<liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Kairui Song <kasong@tencent.com>, Qi Zheng
	<qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Barry Song
	<baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
	<yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He
	<baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Hugh Dickins
	<hughd@google.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
	<harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang
	<lance.yang@linux.dev>, Chris Li <chrisl@kernel.org>, Kemeng Shi
	<shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Youngjun Park
	<youngjun.park@lge.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Johannes Weiner <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	"Muchun Song" <muchun.song@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
	SJ Park <sj@kernel.org>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, Alexander Potapenko <glider@google.com>, "Marco
 Elver" <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Pedro Falcato
	<pfalcato@suse.de>, Bharata B Rao <bharata@amd.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<bpf@vger.kernel.org>, <damon@lists.linux.dev>, <kasan-dev@googlegroups.com>,
	Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793010663; l=977;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=35jwmwykYZJtQ1SqvCGsIgxwetZpyo8G2gOL9icVWFA=;
 b=C/Ay+2xhf3NGI2rrHC53Tr4l9l2B7dKxKNbQ5CE+vuH8Z0L22mKvuNhQemV/3MrQUq+9UfcW8
 Vmt8XqNEZmVC/SFZv/F5BLBxbb7glh3nRjV6mung7mZyqh+KK9SN5LO
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DF:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 8641c4b4-b36b-4005-247f-08df334c58b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|7416014|376014|22082099003|18002099003|921020|11063799006|56012099006|261021123027099003|10067099003|261009223027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	5q8u3c58+35LcTFBpFydJQnIv2oaHvSJht38ZQyl2Qf59f/X6JoH/ZHjfW1CP5la71+D7CdyR4IPW3hG5fw2c7fzhMDijJUtDHk70NO/UwNXLiRmgxcm84d4brEhYErkd+4qE0zqkW7tY1X90bEwtZSy4hYs5RRa/L4KotVHe9ExFMmrHbXfBYT8F8Iw0rN/kU7G2YDc/OmxZpqAqHY4q5aCJVdjYl5dj6ECiWBYkRd/aID1KQ2IWGUbDznHBYvrNSpUmd5rRtzT5N89lv6/xehCOy4asCVRXv5mrTWJSRsvIYiJDHdzncvSsayWkY2epL7Htxgc8N94FJEAYMZmi+EOJU0aXmTOQ3Oe/EThgYl4id+O3zPxw7NsKIt5IGcYqUfKDIZuhBwdzsZgLPWyYBwAllT1cMNHWns3zu15mKHP1Jvy2zaSWF0QPV5QxTbhSE28pkFbI1xyYF8IKI4UsocwSdxHFn/G3yJl2zAn3SB2gY9+JBZrzhsQ8xHLirv89hkIUjJTW7GrCKlxOgN1M9MtCzXU8BXCzPMrE1b0SUFl7z2zDVMAPvge9gNWqNAlXvmnOy6HO6ahjkZCQIt2AbMiUrR7r6z364AguXbzHLyXj/QizQHMhwX+3owLK2UsCsAJNHi0RPOG91TuM2vKCnD9MzxvX5Il44Zn+y8xRLidy40hCHI4g0sGZeeUt8kxAPM19uaHSftKWXdcNwhxL1ByuHhJlX+euYkGLG9l7S9LeEBcZwtUgEZ7mQQ01P7A
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(376014)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(261021123027099003)(10067099003)(261009223027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gXQvCbbDbWxNZJsmj2mr1kWontar5G8A2JhvTQzbFxbkR6OIGmXlf8Zb/IiJrg+1f5e1rf6Y6XGhqcX7k1eZRiG1LmmEgGhJuFz0GCVVnwQo+F88WFb1X9nrOnb6TByM6mVVqQFsjwB6D4WmZKmdxhG6vXjJw5g5y7Py0WdUux8f9VODwPA0yD5n9Yn9ahjkeXAhUGlQ2E5caJErxNsSJd00dT9l2j7shbUp1q5bgQMwAjdWw2Uy53n+7c9z1S+/nrJsm+c+6rjWfjqCSYglweM+7978ePRNpEXlBX4MVY0RBMT/koF8vfbV6JNtNYqcufhPPDFcF8EYd6YKoP9MPPgIULQ3YjU1XYz6xSGBOWzRBjmdVot3Ym/upxndc6+H1Hr7Wi1fQEZxbMdCHzYJrzmZP5ZX1tW55QAvIrUiBIjHfSYNdSxNIzfwWSXYhtRt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:31:50.8183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8641c4b4-b36b-4005-247f-08df334c58b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804

It was added in commit 9039b9096ea2 ("mm: page_ext: add an iteration API
for page extensions") but has never had a caller.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/page_ext.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 79c53ec45dfa..52a8b70c525a 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -167,17 +167,6 @@ static inline struct page_ext *page_ext_iter_next(struct page_ext_iter *iter,
 	return iter->page_ext;
 }
 
-/**
- * page_ext_iter_get() - Get current page extension
- * @iter: page extension iterator.
- *
- * Return: NULL if no page_ext exists for this iterator.
- */
-static inline struct page_ext *page_ext_iter_get(const struct page_ext_iter *iter)
-{
-	return iter->page_ext;
-}
-
 /**
  * for_each_page_ext(): iterate through page_ext objects.
  * @__page: the page we're interested in

-- 
2.53.0

