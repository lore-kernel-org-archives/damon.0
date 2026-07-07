Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE93AA4F1
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406432; cv=none; b=kCQTyn3wxATRut6iOgY1wfd5TAi9gBWKihRmyL/qP63ckdvu+4Kd6wRztLOryJ8wt1XFtDw8SYLwycxl4gi/t4FFUaoE4cWdCp0oryf4F985Tq6bwbb/yFDzKu/AMatQqpi0CCBWpkatBOd63+ppTNrmbFDe0ImauydiVk3luos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406432; c=relaxed/simple;
	bh=BW1NU17C36MAkZHbkk1dInXX5sbj7TNAaMHUH8qAdeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7X6X81w9TDTj9XVzIkfQsJXbbqD1ypjHvAk9HrnugE2PXfrR/G0HFwyvmf+cTnhBQXXya8WTGD9ioCwqQb4wC1eJ1Js1r8fWfkYclqV6I3HtZf85SvUbHKoPo5Q44/BKnS7ciSvoXlkZneFFazeXjvMIZ5zYl0gOfH7KhUOZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=ZKqK2tjQ; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="ZKqK2tjQ"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=bRJcdc6HHIkHeY/WGZrtx/DJe85hcbtj03n74JS9UWs=;
	b=ZKqK2tjQmEwe/29Z8hEet9dB8iGhvES1aUoWiDViQEkvEClWjwpSOPeMPVHgIFhuu8i4TcdJC
	9IuZHuVC0UJ+ptPS3D+6rHgC2io8ZWaf5GxRsoHYUMfiE8FMdPm3ZTHa9raxOOwWs4Rx6tWwrYN
	2bbevAeaofj8lR127dnMjC8=
Received: from TW004-1.hihonor.com (unknown [10.77.232.85])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gvWnK2YFMzYly8W;
	Tue,  7 Jul 2026 14:40:21 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW004-1.hihonor.com
 (10.77.232.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 14:40:21 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 14:40:20 +0800
From: tao <tao.wangtao@honor.com>
To: <akpm@linux-foundation.org>, <david@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <willy@infradead.org>, <sj@kernel.org>, <kees@kernel.org>,
	<luizcap@redhat.com>, <zhangjiao2@cmss.chinamobile.com>, <kas@kernel.org>,
	<ljs@kernel.org>
CC: <hpa@zytor.com>, <liam@infradead.org>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <jack@suse.cz>,
	<riel@surriel.com>, <harry@kernel.org>, <jannh@google.com>, <jgg@ziepe.ca>,
	<jhubbard@nvidia.com>, <peterx@redhat.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>,
	<xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>, <muchun.song@linux.dev>,
	<baoquan.he@linux.dev>, <nao.horiguchi@gmail.com>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<pfalcato@suse.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <damon@lists.linux.dev>, <shakeel.butt@linux.dev>,
	<ryncsn@gmail.com>, <jparsana@google.com>, <dvander@google.com>,
	<zhangji1@honor.com>, <wangzicheng@honor.com>, tao <tao.wangtao@honor.com>
Subject: [RFC PATCH v2 13/13] mm: Enable CONFIG_ANON_VMA_FRACTAL by default
Date: Tue, 7 Jul 2026 14:33:08 +0800
Message-ID: <20260707063308.29176-14-tao.wangtao@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260707063308.29176-1-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: TW002-1.hihonor.com (10.72.0.137) To TA003.hihonor.com
 (10.72.0.43)

Everything is now in place to enable CONFIG_ANON_VMA_FRACTAL and
CONFIG_ANON_VMA_SHARED_SEMS for further testing.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 1b909819035d..9d4b81bbd4e1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1453,7 +1453,7 @@ config LOCK_MM_AND_FIND_VMA
 
 config ANON_VMA_FRACTAL
 	bool "anon_vma fractal list"
-	def_bool n
+	def_bool y
 	depends on MMU
 	help
 	  This option uses vma_rmap_base(vma) during rmap to compute the page
@@ -1481,7 +1481,7 @@ config ANON_VMA_FRACTAL
 
 config ANON_VMA_SHARED_SEMS
 	bool "anon_vma shared semaphores"
-	def_bool n
+	def_bool y
 	depends on ANON_VMA_FRACTAL
 	help
 	  As rmap operations rarely run concurrently, and fork/delete updates
-- 
2.17.1

