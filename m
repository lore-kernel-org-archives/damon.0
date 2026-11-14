Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640248;
	b=Pqoodg9/XV1yb+bPdaXRsXvO+pdhEUrx9sYYd1niq0Jj8/NLrAAWdj5rhcvU236l4G4o
	 ok7PC9SpPj5o6ZXjCkSt/CJEj5qdjCTCTSAEBMd3xzn/LHdaCV7g+CBa9tcYhEAA6oIRF
	 JYRk6Nm7BZbZ0ZTcM05x7cy+WpAEfpqV2mq7ujZsQd5EJfQzyxLYgtzIw0hCthAOJ09P+
	 Mtchh4SZGmwMnNtavPrLi6U3ow5Vs43UhMfm0U1NF+mdDBdRgYMR7QN9dFzYPjUe2BS1R
	 dP3dWtiF4u5xzNbM0afmF2xot7RdXcxOklCYMBz/JFOBPi4c1gz8ywFTGCwNC1IA6xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
	b=VfgxUZbd7aeqGH0Uic+jg2WvIbDCRe60p3ilyh90xL6a1+wEEdVfEEu8FJPkLvrXRkdj
	 HkguLHhKrRG+GdTBlzuizc0DoKen9D5aDPYV/jCYyez8V6H8SByi+JpwzG+f1v4NvV9mG
	 eozxUTMxo64pNMx1svcSmeWRpgLdB9ZgwU3Pir5ZSHBnMz89i2KxyQUW1mvIYQLvR3TbA
	 pMi9iCOH4rMCnpFAYaFEcBUoxjyamltktV9NbWq90PUOcjzStZUXmHoGj/RBtB41qm4dW
	 1x8CohQ1bR5FKMLdNhCTgwnbGTE6X3A+5i6ekaGoxL8z5quO5qDEQCwEIshuayF9ERA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=kQQuxD22;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE3260A3814
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE3260A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=kQQuxD22
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f269e335eso356471385a.3
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640247; x=1795245047; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
        b=kQQuxD22XLSAL4Jj4h37tYEuykH7dkp1yqAQmUIw4+PGnoRWvQ9DS19XzIe13rLmA1
         iyQf5AqAl0bL+T1AS/yaGRHl9ZA8VNdsvIU7jXFBkaD/jtGNaN6rT12tUSlwn/7PKl4W
         Fa4hrnCB98Wh9qLGwCig9cfW/qOTKFjotj/WZX3MS6In0HLZE72VF7yGARvEx0zHI/GQ
         43e615kn5NY2+CC36PJ2BVn6ZFNOS4nsNuEdL0XTZ2eTsdVMZLLHVu8QfJrwLMBawPxX
         ujAJMm4C1IYbcxjuFGIdj+WnjNE7QA1gWV0n6uyo53QzjSwst3PhyS6aImEA9Xets7pc
         JNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640247; x=1795245047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
        b=22hv+tslKvwYbQN85tiZ9fVpjGMKiT1FDYmo7jtjUCXZJ3j4annbBbq7qwZ0pBRXrm
         yulrRuE6qUiDwn79Os6NGZLvv82ThSY6q80j2+DH4g6kb7LRNiFxb5tRq12Gv1LK0wpJ
         TrAfBUM738cc26jeMwHa4rE/mFE+dJfc/jZaRtL1pSJDWO8TgrAvH780uZNmE7m77gNk
         7M8J1BJdf5ArmeUVT73E1i3huAPAWndvqEn7fUZ1tDB2vo5psIc/F2Oppnw6Pz45kfLs
         CqbNC8OW5HcvZOCFj9e1SrBp3drnsTxW/J7QQK7O4U/GFkc4Q2iDItKf7dR0/98DE2Hd
         j+Uw==
X-Forwarded-Encrypted: i=1; AL+hErHeIbDRjxVH2SBmsrIf/bOPs0rlhBqs1fLcffb7aBjKxnKF4sAFtLiwBibRq9NCOAXf1m6fNA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8rKVrVtpTgbl9q0xxtJtxEd90nIKwcFYx+3cMpBkMt9NIUgIYy
	cE5yyV0tbl0M7/BmAA04/jEqS4tOXjdwXSfgUbctAe+MjDxA4479dAKPdBMbVKv6ELE=
X-Gm-Gg: AYBFou0deG3w4TJuqoIArX7lL5GNraLJ/Xb0unCjVbLIQlAiBCeAguaP5yU0QH+rvY7
	c+xhirmuru4H/hYxfjLe9nPuydAuo/WHLIgwss8TjPXBnaDE0NU6NLKWr3JACrZQOAhsFKmWU+l
	kbJNZ8G0VuMR3y7q1CI59Hk/WdsOISoyvKPD0XDKGM2Gi1n9IGZNW5uloa0bY/FOH8gpaTu0PM5
	PGSf1pjyNocqPL0EAU8SOL+3B6vFcMZaLMqy12X8Fr1DmtCDMDUsOJtwf7iLj+bTn7XoCPlQ1xY
	S/naz+TOLf5JAH9VU8om2bcIXCRviYM6w3C3KMWy4/1FWlMW84Un9Q4esLCGSYhvJw5NxrQzUdh
	DudhjCsv81OfxAMrFaXnqUdmZmt0B7TaVdc5j49wnrmtCO7LCsKTUevzfmo8prVtQWS61vUANqq
	ox3ACdCnDD301QAn7GYwY3lDQp555yzVqaITXAPHAdvxU0KrIuIZhGY4Bkcc/i34SKffOrVXvqf
	uqps7yTO/aJGmcKkm9EpmhL4nXkCiHqYrtPm8eVF7/QpG1m+e0KWCvz/p9fBOQWVggJ1VFoXDin
	WIqFL4Z6zU9T2npaQkN5hA7YWnSxlfGIYXuZcrg2yVprobpecZ2gMRX4fV2Ma4tRTIyQzPUDEXE
	nBQKcQfmyrDRkcNc=
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:fbb7 with SMTP id af79cd13be357-9494bc76c5amr813866785a.68.1794640246800;
        Fri, 13 Nov 2026 23:10:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:46 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 20/22] PM: hibernate: size the image from common memory
Date: Sat, 14 Nov 2026 02:09:57 -0500
Message-ID: <20261114070959.3490008-21-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hibernate_preallocate_memory() and enough_free_mem() count the free
pages of every populated zone as room for the hibernation image, but
the pages used to store the image can only come from common memory.

Count free pages only in zones on N_MEMORY_COMMON nodes.

The image metadata estimate is a separate sum.  The bitmaps track the
page frames, and every zone's frames are tracked (regardless of node),
so that sum still needs to be calculated for all populated zones.

Every node with memory is common, so hibernation is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 kernel/power/snapshot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d5dba0e50b2eb..8aeb086a3fd3d 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1866,8 +1866,10 @@ int hibernate_preallocate_memory(void)
 	saveable += save_highmem;
 	highmem = save_highmem;
 	size = 0;
-	for_each_populated_zone(zone) {
+	for_each_populated_zone(zone)
 		size += snapshot_additional_pages(zone);
+	/* Image pages come from ordinary allocations. */
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		if (is_highmem(zone))
 			highmem += zone_page_state(zone, NR_FREE_PAGES);
 		else
@@ -2011,9 +2013,10 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 	struct zone *zone;
 	unsigned int free = alloc_normal;
 
-	for_each_populated_zone(zone)
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		if (!is_highmem(zone))
 			free += zone_page_state(zone, NR_FREE_PAGES);
+	}
 
 	nr_pages += count_pages_for_highmem(nr_highmem);
 	pr_debug("Normal pages needed: %u + %u, available pages: %u\n",
-- 
2.53.1-Meta

