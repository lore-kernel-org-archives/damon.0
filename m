Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1522CBE6
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750167; cv=none; b=WpdoJ1fJDuMW4CsH2Vr2UWu1f9kjG3elHYv58fLd6t0fUw3qNx36/it/iXrGm3VaQfW5lqqJafrD1ESg/rOuhiUnh7lSfqDoJelBNvmk+nkSBq7xZVdxjapApsYPsaFQI1A6ROLlg4ZH+nsvKXKWdAcRvmMc65+RQhoLUDMtqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750167; c=relaxed/simple;
	bh=RBdmtloBdxUpHWxlqKJWGoVvcuaOTpX5GdBn/hyqYaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXHKeC6rOrZlZvKNwdsvNl7pyaTJuZLpXvH6k72/gAFJwcmP9zYCnW0Ztyx2u5iAwC8UcKMfiNBRxIwp4L+jAPWnYRWyBqRCEwZprX/In1O5IfG1ol9JrPbBPJ1l9/Pp8fqrWMud2DptZSVOs+sLtrW738tTwp6NeiChCVP01MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Tpgw7Mx4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Tpgw7Mx4"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506e287dd53so27493951cf.1
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750165; x=1772354965; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbh2YPrN1iAkzOE6jhFX+vkJxP+0+A7nSYJL8bBT1Dg=;
        b=Tpgw7Mx4lhr66YkSeiPj9Pqg1+jE1yi+8r6mUbdzRJrsv540yqEgJ6jfF4Sn4fBuN2
         0M93gkak/LgNdx7iASie7NYWE2esHVpaRgPZxx8M3rX7wAEQBtMhA9wHZ5SCFAc+I7Iz
         S95etFWHAE+lB+6h6XNPtVviXb5XD0vo0XPQlMN+WsO4Xb2jkdOdsJWzSX2MetL3R+Bq
         GMuifFMAxeq6hP0aWX0o4kRFPoP2Iu/iekP/oA6WkYNUb71AjdUZeVGFkSc4t+8AdMvQ
         gzp2YdoVToVvsqFBI9nEXn9Oo5AeHQPlGAGn93Ao9coLSHJabymLMR3ZeCmJsiEK+lDC
         8Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750165; x=1772354965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qbh2YPrN1iAkzOE6jhFX+vkJxP+0+A7nSYJL8bBT1Dg=;
        b=Bq9gosPHEC+offMB2VM74phsZFCKOmu/HNCh1Eq0ZCxuemMUFe9pGfW+LYcj25fAW8
         qtARhosB1uqzMX3VcTMT1gSiGfRKFXkj3PXaCoyLA/x5Q0/eQHsb3nH0CzT/6pgjnl97
         ENbpE56DI+uFAiQ6v6ie63EUE7N58CqDBKYNbSwFV283xhpHAqFTNx910lt76aMpH/kG
         FVauhqFVkjJUZzkvVdVoS1wmtGJheaQiSIFXVjwoTXW9BW4OM7D8p6LpJvLbfNh5LKPj
         bpyNzjVn+xnyEp4Vb2rayc41Na997cXXW3mIefMj3k8JSU3iX685cD/Q2iXKIVIF9Il9
         lLmA==
X-Forwarded-Encrypted: i=1; AJvYcCVZKWdfRsOFK/z41twbiSLs2NkFciRDr6czzkxmbng+hT2s1YOIsUqK5QdxiC9yiK7KTDxyqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YybsMbbWX+AeN6+XsVj2ocO4RFTbJcw1TdebAUKIYmfTn3dMGdB
	GS+/TD1dQdKLgDJAHIH8TpLMHZMqiHTUIDeQ8KgRcvu68KPSMxdffYhtHUnpP0Vt2C8=
X-Gm-Gg: AZuq6aLNpFG1eO6NomF56KLlE6FSzRRGsIMo0cSv2tysfmTuCW/4vo8aMpOxSmYDd35
	CGxNoPOeCSb/X/gU6gXFMa34tNB7L1Tn0n4HDmA/Pt+28bHV1I0+HeRhAcFUs219yNyi1gs8ssM
	ty3kczG2m7lGrC5qs0mOExzi+wcgvP5D+/lO/eazpaZ341/g7ijqDarqjvxw4nzc6s7e7RgE8qd
	Wf2O9FWgetTvUZYY/GQKQpB2DAd2q+huw/qGy/iW7mhawUglpcYEmEi8EYTaLE50mKJzH2CjABg
	mOiqC6o2xu2y/CqBUx8hzR8DWV935li0BJ/4q+SIJeeey6mHizcWhXi0OkSPsIi+hluU57YJiwl
	9KLMUAfhGDiLdcvkuhGmKbY+wBzSnQuxYWhfAwwU2HS+uSxH0ui1gVjOTIJ163UGJd8VQs2Ll7i
	M9+r2lDxmfEGVQ2JWg83vZpePYKKs0h+HrgzE9T0s91kKDGrXvJBJo3k4XLkrAFuzvPf6eKWcO2
	H5IvQhDOJs041E=
X-Received: by 2002:ac8:5816:0:b0:506:9b96:6280 with SMTP id d75a77b69052e-5070bbe5967mr70651841cf.21.1771750165415;
        Sun, 22 Feb 2026 00:49:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:25 -0800 (PST)
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
Subject: [RFC PATCH v4 08/27] mm/ksm: skip KSM for managed-memory folios
Date: Sun, 22 Feb 2026 03:48:23 -0500
Message-ID: <20260222084842.1824063-9-gourry@gourry.net>
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

Private node folios should not participate in KSM merging by default.
The driver manages the memory lifecycle and KSM's page sharing can
interfere with driver operations.

Extend the existing zone_device checks in get_mergeable_page and
ksm_next_page_pmd_entry to cover private node folios as well.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/ksm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2d89a7c8b4eb..c48e95a6fff9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -40,6 +40,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/pagewalk.h>
+#include <linux/node_private.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -808,7 +809,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
-		if (!folio_is_zone_device(folio) &&
+		if (!folio_is_private_managed(folio) &&
 		    folio_test_anon(folio)) {
 			folio_get(folio);
 			page = fw.page;
@@ -2521,7 +2522,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 				goto not_found_unlock;
 			folio = page_folio(page);
 
-			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			if (unlikely(folio_is_private_managed(folio)) ||
+			    !folio_test_anon(folio))
 				goto not_found_unlock;
 
 			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
@@ -2545,7 +2547,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 			continue;
 		folio = page_folio(page);
 
-		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		if (unlikely(folio_is_private_managed(folio)) ||
+		    !folio_test_anon(folio))
 			continue;
 		goto found_unlock;
 	}
-- 
2.53.0

