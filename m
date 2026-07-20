Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542A442FBF
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576109; cv=none; b=TbvfZ4UcMyVm3JNhgBitd84ds/SvC+68LtcWA/DSi4TU4olu5DgKkKwKM5VYEeyJBCpeOTthwKZFUIOG37sNaljGD6TuLbZUZmY0lIAm8HL5NpjQqb4RekJq4SnQBX37D8cAOqtWNx/8CuAJJZwmrwA9owm348AFyRKBvi7zJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576109; c=relaxed/simple;
	bh=oEaRFOVCjSclinhDXeejGJ2Wds4vhFfHEOBs8ywWypA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px2zW6spQxo5dyAn/s4Cs65sjxr4lKdh10rPOU4OGL6kjh8ZXFbtq2b0+1LtFE7c8EDHOo3LStuJmHzj8bev+KR7CXisb9dR460R8pqyel8+9GtRY/GAdWve4ceQizmCo1EW4LQNKIXx51dSrOW0XeRC47L+popKRDrA2s8Rgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tY2u+0DG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tY2u+0DG"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92ea24a2dbfso893479485a.0
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576104; x=1785180904; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ln8pgF9dZ6WMfDl05evHGvg0v2GxuZj6EnExRSfvexU=;
        b=tY2u+0DGhRoTXyvSiX+9IcUMidyobE5+ginNLxFcrueHuksd8gJZ8JtYF2hd0ptFWV
         35ziYuHuGyt7y8Iu5QIXx4keup8PyI62etPc57j6H3+OQRaj5CZ+jtC2DImnVU0vCUKT
         nh+gsaP+HZq99YUvd0U63vR5SlZHTouFInmAAvydZZkAtnnLP/pF5nuTYBA3NG8oMyCl
         QJDp7N61RDeyDSrEjMCdwIf0aSN7njqCWMkf51BV+v6UfoqsJBfqYJMMFIxEQpbBFMJc
         Age/TDrr3OsMQw3mpT/JQeq8R9BCbBjNTeDaxu2PkTScB+nI9HCDGegjhL+4yx6eAz1j
         459w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576104; x=1785180904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ln8pgF9dZ6WMfDl05evHGvg0v2GxuZj6EnExRSfvexU=;
        b=XrmxoHpZx8x9l37RWaBsVqr7ER5M7cdTkTiyeeV05Jlh062H0TOrhQulRYtdSP+6az
         vw/ny1SVI5NRp4UxeWNiIwHRbm6JdPg7sK6Lz0VmssNsSO2Jbf6AxMTxfIBfO9phdVE8
         r4RQRjYXbPUTnzFugnmvZToWXBmfZDq0ekOXPk2mLFrFJ+9JHWkCmDeHqkfQIEarUhBd
         B8WjO/bA6w9DMhb8CVGtAg18N9hG6aL95bF9hWneWfoLlZ29obYgxL6iM2SU3+F9Tozx
         BlwhkzyvrLbJRuNKqM/Ngx3OlE8DzHEFHyTipwSHhMgARb0K/9FhMY/BPcUUMqxYIKhb
         SD4g==
X-Forwarded-Encrypted: i=1; AHgh+RoZFQFws2px90xV2wlp50pHZe8XN+ij0dX1zVMTWsgaKAzhePtClxqlbAN3DnOc6RKXmxMu5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywva9hLxoSYXMnfgWFTKrP7HTRFdLxevc2bZOPQRb/h3zXPSx7H
	TzPSF1CHWPTu+IXgWFzyEb1pzOS0GmsERizPnOJOEsXMgjK0Gxis9JgocwLzdeuX52s=
X-Gm-Gg: AfdE7cm7KOlRVOE561H6r3jPENVJwrilv2yUVdYOWTAwUr1WZMYh8y9N1+MLKAX2KEv
	TZ+kd0QiNsGcNX693p6dGyM/D91vouKxQiJKDKKEE3jIUoGPLXQFX6GVJ51Zh1d77jQzFwBNyVa
	7U5zm5mvfHAvDYKZYnV2u1KuDxYjJtozf4HTbZGfcXX53S07HCdQTDuPg+tzSM5xi94Ql2MQECv
	AQZ34D+dAtqkBlBDTSpru4oOln7zDZYnzrKA/cIm3BG0xd1Os3yBX71bmcgsp9wihCT7O1Xfp0t
	E8STDNnnqV63xyu3x6sxt2GclATqN6k+m97laodtNdozGt8KMC6bgLI5qhnB+nuSsWfCkBshGcU
	V0mvOJAj8p5zjcbvYc3k38FVpOFx0Kupd+vcbM6Ow+mimyBmrowJVVnXrZhFjJu1/ROu5NSwWSF
	ai0Z6Aaz5cYydqmLzpQ4Ac5sjqq93b1fPzggWrJnydiWwT5eMgQrlu3y+OJZeT4aI=
X-Received: by 2002:a05:620a:45ac:b0:92e:c117:9eac with SMTP id af79cd13be357-930b43971a0mr1537518085a.90.1784576104470;
        Mon, 20 Jul 2026 12:35:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:04 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 10/36] mm/madvise: disallow madvise operations on private node folios
Date: Mon, 20 Jul 2026 15:34:04 -0400
Message-ID: <20260720193431.3841992-11-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the same filter locations as zone_device, plus additional filters
for huge pages to avoid madvise operations on private node memory.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/huge_memory.c | 5 +++++
 mm/madvise.c     | 8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5bd8d4f59a7b8..1df91b4e5c2bc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -37,6 +37,7 @@
 #include <linux/page_owner.h>
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
+#include <linux/node_private.h>
 #include <linux/compat.h>
 #include <linux/pgalloc.h>
 #include <linux/pgalloc_tag.h>
@@ -2338,6 +2339,10 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 
 	folio = pmd_folio(orig_pmd);
+
+	if (folio_is_private_node(folio))
+		goto out;
+
 	/*
 	 * If other processes are mapping this folio, we couldn't discard
 	 * the folio unless they all do MADV_FREE so let's skip the folio.
diff --git a/mm/madvise.c b/mm/madvise.c
index 07a21ca31bad4..29f35a23919a0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -32,6 +32,7 @@
 #include <linux/leafops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
+#include <linux/node_private.h>
 
 #include <asm/tlb.h>
 
@@ -395,6 +396,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		folio = pmd_folio(orig_pmd);
 
+		if (folio_is_private_node(folio))
+			goto huge_unlock;
+
 		/* Do not interfere with other mappings of this folio */
 		if (folio_maybe_mapped_shared(folio))
 			goto huge_unlock;
@@ -474,7 +478,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			continue;
 
 		folio = vm_normal_folio(vma, addr, ptent);
-		if (!folio || folio_is_zone_device(folio))
+		if (!folio || folio_is_private_managed(folio))
 			continue;
 
 		/*
@@ -703,7 +707,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		}
 
 		folio = vm_normal_folio(vma, addr, ptent);
-		if (!folio || folio_is_zone_device(folio))
+		if (!folio || folio_is_private_managed(folio))
 			continue;
 
 		/*
-- 
2.53.0-Meta

