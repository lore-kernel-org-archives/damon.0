Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522E212550
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750161; cv=none; b=eo3Cv15+tsdOIatNPPJyXh1Kk07SBSdjm35gtPQn9K7BY57gbBkuYewgPn5fPvENimF1wDbw3YVBhCbVrkgQcBdTGs9w7JhVFO2RAdqtnYDIpBP0SFnWDAnFIAmr3KmV+BfKRH+yLiQfoBseGc1/ZJyASD75GwrMN5v3tZBI1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750161; c=relaxed/simple;
	bh=H6CTxJojW3RaznwU7e2tIws+8uIQCpQLDZJs/4YMrlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFkU0VLsoBaszu/s2PQ5OtAzo/zl44s/SealSrjrGhccbS7MxWz2Z1v7wF06mV2a6fHPSSxeLnlDvhZLySom1zZKvKgc7Y61oYF6+8Gxs0E8XqdAU9L79h5pCxTwHvhcLhnKPYX0n4J3UJ8virPU+sj9PtE9BYuPuoEW7oe5FAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=avrBpzgn; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="avrBpzgn"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5033387c80aso58956741cf.0
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750158; x=1772354958; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN2sy4KwpOgCvYV+YZxAOK9yTs+OHW6J8ZgmY0xzRNk=;
        b=avrBpzgn5ThmlrsfR6J40V48J7NYzoy0FE80H/QolGql1OkCDEY9pBEgF4YSK/W8cr
         YHhoy/fXG3cqvjaQ3YIQeD6/EK5GAWS/NfpQmhwDmTjuQCx5g5onw20zeHJOGb2paUNf
         oWg22VhFW+fdpN9FEgUXLRhzcegxgxBp9Vtkn5+xQH3PWhnUFheu9dxuZ3OiuHU3DIbP
         Ed9NzsZUWUW3iHvUjfynfavuUY0PS5Kxc9UkIKMwraNNPlXo3S1jCbQiaz4p/uSYVTZv
         BOlIi4vBmta4GX3BASr8zvzP3FCK7iWWDUoOW4f9RrS+0sOn0kdIJTgxYWVNtGI41O1+
         MQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750158; x=1772354958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PN2sy4KwpOgCvYV+YZxAOK9yTs+OHW6J8ZgmY0xzRNk=;
        b=VHCZO7fq+YWqWdR+aJUH5j29goT3IBgbzN2njJFw8bBW5TPYW4bOhyIQLYMjK3Z4cL
         BiByyIC6i+nFNzX3gO3JxfAUjJRU0IESnOL8uM/litXVtarPUA/LS6uq6sYmbMMEd683
         5qi7q/mEWfMjeiDA67YJd584lB0dCEpYakDGaM3z5sdJdSZCBZTz+bVqIpaaz2uJ0sAP
         03EBsilQ0PEzRI9a1RiSU4yjVFjqxPrhEX66nWmmz7pqudixtzfR6HESFgrzCMxk++q9
         egII9NbW+TXwRnQxrlEwJE+MUgkn9qw60i+gpBxV5e7JEImXaarzL9VdVGw+Kp09M/C/
         uQVg==
X-Forwarded-Encrypted: i=1; AJvYcCWVGCd7MIbK6vdgxkH1WF3Mc7ewLuezEmpR7qMRJApns/QDW2jne1iEsz4fesMBSU8dEUJA8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUkO5og6eWwbgX7fUB19pSKM53O9PGNfLbF3trAwlC771THesh
	3AjOzenC3RbalTIhw6OPnaMCOBBu+QRO6dzZlN5AUPzIuGQD2BBszIlcta2Fp1oWxNI=
X-Gm-Gg: AZuq6aJplZ5sTm9gFHsU7BWLkfM3db9miPXQmjuFWY5ZTTx1fV4+/IWYkGfhH0tIcz8
	BXyb40Vy8EG7MileV4jElajD/6FnKrbEqGRCCJmUEPmcA3EujvjmiGPW48XafQs1ym+10fPLZ/C
	oJ/pZFrUstG/1NtQYwzR2M18Xa5FpwZBkIpw9fxEdbalBD31uDvpK89aJPLPUnYxBg3yJfKWfqU
	0l+qcVPPE1R+51A8NU4FH6TVt5c26aLc1MAmnrHD9tXWadihvspcQenfgsLnJWRbFbfGncTj8Wr
	LplDcR0XZAAsBlaQIZf3YIwkpmcwToeLj39nTqgclk3MxDgmblYJP1wA0p4Epp/S8cLqjiS5J0s
	0LOYC5dfg0+61/j/uoY80qXoj3mnuYybUrUuWemFqnJ/zKbu+/GJltyfvnThLwq7Pu7E/E8/l64
	2THoEnDTDhmVpk1afzWihNEWsNZx61+Abfs5rDKyi6/gzfxc7bYzAj7Zzh/9SpeaPj1tIb9zvuS
	7aYNaOFILbMraU=
X-Received: by 2002:a05:622a:201:b0:4ee:232e:4950 with SMTP id d75a77b69052e-5070bf3bb60mr62117601cf.8.1771750157802;
        Sun, 22 Feb 2026 00:49:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:16 -0800 (PST)
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
Subject: [RFC PATCH v4 06/27] mm/mlock: skip mlock for managed-memory folios
Date: Sun, 22 Feb 2026 03:48:21 -0500
Message-ID: <20260222084842.1824063-7-gourry@gourry.net>
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

Private node folios are managed by device drivers and should not be
mlocked.  The existing folio_is_zone_device check is already correctly
placed to handle this - simply extend it for private nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/mlock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 2f699c3497a5..c56159253e45 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -25,6 +25,7 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/secretmem.h>
+#include <linux/node_private.h>
 
 #include "internal.h"
 
@@ -366,7 +367,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
 		folio = pmd_folio(*pmd);
-		if (folio_is_zone_device(folio))
+		if (unlikely(folio_is_private_managed(folio)))
 			goto out;
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
@@ -386,7 +387,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pte_present(ptent))
 			continue;
 		folio = vm_normal_folio(vma, addr, ptent);
-		if (!folio || folio_is_zone_device(folio))
+		if (!folio || unlikely(folio_is_private_managed(folio)))
 			continue;
 
 		step = folio_mlock_step(folio, pte, addr, end);
-- 
2.53.0

