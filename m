Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8932222B2
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750172; cv=none; b=iBc9tMz/VdFwZTK44jDD5hqOI9HORSFZF8UGD70aBksFdzYud1eiHFb9UnHIv/9K4CmwTcfqerqlX/uYGGtj9PjRmd51+G/kwXqn/Pkq3G0umIuCQaHhrZxosE8TLRNOVZ044K/OzuGdTwT7dWdc6/AIjqvwYiN0DFOrmOamXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750172; c=relaxed/simple;
	bh=fY2O2ukegsBDPZTxA7RgjpegM4UC0FoSjHYp6ZA4CME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2I+U07Z4gQUyGM9s4/JIc9rBuPa7c5/4BuFcQzn62WibAvGmWUDBCOrPSjTUFfCZGcCMG/tz36Yqm+QU5m5FRtEw3hoWXQkwEnOa1sZw216Skio1aPXt9aLOJGmT5BrQR+0FPoPhm9Zn+SuOUZz13Wrf/sfsP0v7kpo4GYR4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=goVE+jhW; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="goVE+jhW"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-503347e8715so43170961cf.2
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750170; x=1772354970; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0SIufGPxfCWQh/+gXEhZXOnJbmqG7niTtTuU93HVZQ=;
        b=goVE+jhWcMm3jtUlxOQNlIX9RWwg1hSa2JK7wSzWKOiKAy1b5NDFLA019oC1ZnT31o
         eIPin32PWuMUUtW7E/M8BseN7UP4XfpmcEcmDd/VI3jh7HAs7eT1qqFEk+octPIRd7ke
         2baruPx4386pZ2JUlOBsWHFNpzR74Y/O3yXNxxiKFCvWaD9g20MYTxSO1ayIPt6BdyIa
         xibJ4+lOAF6u6JSIK3O0elk3a9AYu/YvpeDc2OQCllIrZTs+DfyPFe1gKoZsum3VgAQH
         rwjQvmNF5bUtt4KngyH9uiByD9L7wtkEWliATb2uzrGbdRGGCSrUIw4uYQwDFgb56+Ar
         RmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750170; x=1772354970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0SIufGPxfCWQh/+gXEhZXOnJbmqG7niTtTuU93HVZQ=;
        b=hFvt7LN+wNgdHqXQPNQzKQeb6unj0m5Ot+eMRQRvkaLZk0PBbP/hzEl4gLeOEEz3zk
         WO9AFlU+J7Oz97wpFx8fr6tMdUkHcd0Wk5EhtBUAyErVlUTtWdeAyi4512uhekpxKpFq
         zPhIy9WGxj6N5E5VkK652WbFAeme88+VS+kfes2wjrvyi71kgBrz9PVeOk0+C1FMnEgG
         Cfm3Jh6AUYqYIJT8V6v7b6bA6m79iqtFzIfhEdmSmvUWcC0Khc8CAanj8I6u8IDHPAuZ
         I0eS4LGAxfaarWzbWorOU4Zj8+6YYb9ypqMw2GZQvDSrOcpxQUTZsEwyTiWtKdLLouBB
         nDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+W2opwogiG33hy8jhuSRowdzYIRK2wIWvGQAXxJKkspqgAymKAXsKrBhF1exdOrxTqMfPhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/oKP6UC7Z178+RRyDfNXLY7J5YOxrCOYMZ+LpioGem3CW8eTb
	5B/k1vbvAq0KjbC8FumdzRYGT6whOAmSA4kg4CoRjq22EfC+FLH2g7nq1zvFKFJu/j4=
X-Gm-Gg: AZuq6aIXixr290Ea9cX1oO8uZhdDpeDshFnZT5D+pRXk1pGm9KygG8Q2O1FO3V8EQIq
	1IMlZU6upjegG9FkBEaANq2H9eqMY6FZkAcd9LLW7sPsjtFTtIDeBOypGijqFXuI6FKPsrYggk5
	Hm6FS7pEy6R3dJpF1k1ihkgbt1qdYxzsnYtOWCODZXNJCRzR5Zq0xhiPy7iOwBknQxYbpG6M/N1
	apBrLyOTVJnEVcmGWlVrgE1NKiDrexz9tyjznjT2CFdY6XuppN2WAZhAVLjuV25+F8Ga/J7VLTZ
	QjBtfGdFsszsKK7E5b4bTY9ulcsiY/KKhYMmln5BkahCjNfhWGsEbl/kPx/RXTfhfd/+kCCVOIG
	DeuOABKNNThEp8kEsfBP2ucTqtAqsh75oId0VdNE2wEWxVK32IhVjdoqABsbbAxx7h/7x9LHcDZ
	zFJyRQ+f+Byu/+2cB9f3gyQVrK9pQkHclUyvTG9Z7DCXoM2K08nDqQUOpN6EQrJTY+bApkkINjT
	2+2SuiczjK0DmY=
X-Received: by 2002:ac8:7d84:0:b0:506:8a2:b1ca with SMTP id d75a77b69052e-5070bcedb32mr65601961cf.73.1771750170035;
        Sun, 22 Feb 2026 00:49:30 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:29 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 09/27] mm/khugepaged: skip private node folios when trying to collapse.
Date: Sun, 22 Feb 2026 03:48:24 -0500
Message-ID: <20260222084842.1824063-10-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A collapse operation allocates a new large folio and migrates the
smaller folios into it.  This is an issue for private nodes:

  1. The private node service may not support migration
  2. Collapse may promotes pages from the private node to a local node,
     which may result in an LRU inversion that defeats memory tiering.

Handle this just like zone_device for now.

It may be possible to support this later for some private node services
that report explicit support for collapse (and migration).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/khugepaged.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 97d1b2824386..36f6bc5da53c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -21,6 +21,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/dax.h>
 #include <linux/ksm.h>
+#include <linux/node_private.h>
 #include <linux/pgalloc.h>
 
 #include <asm/tlb.h>
@@ -571,7 +572,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
@@ -1323,7 +1324,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		}
 
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
@@ -1575,7 +1576,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		}
 
 		page = vm_normal_page(vma, addr, ptent);
-		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
+		if (WARN_ON_ONCE(page && page_is_private_managed(page)))
 			page = NULL;
 		/*
 		 * Note that uprobe, debugger, or MAP_PRIVATE may change the
-- 
2.53.0

