Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6CC47F2EE
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576125; cv=none; b=jAdIfrSvHTYmrRlnvAxhi9OT/yC/ylsFtcWwwnviegdV96cHaVibxZTn6OY5ETCl9Dwi8s1bo6cl7gRLXP+iCHh4b7ACej0YXdq1LirVlKvqsQb9sYf25K9Sr9Kp6fuq637sUBuG5b1Jqo8KlZ2+HpqS1M7Amq3ZfLqjmgEsS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576125; c=relaxed/simple;
	bh=rTGbsGvKQACnJtisxUC5ZLec44efZiXOSNd4OQNTaLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+isVb6okgcxpKZrDspbiROhiJL922ATilFVlkHv/W4IbFjXu7pvptJuIysAUdJvxXnPZ1Ntkt08PLi6kki59fZjGfnn5mMCseQnlkj8U/tB0XM2dq/8Z3OlCZ6FdJsP+tu3AWfSkivVRBUWYh+9Uf/zfik5MPBOhK3YF4Xk5YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZVZORhe/; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZVZORhe/"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f29ec73064so104746416d6.1
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576120; x=1785180920; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6FOiK4vob/RxKMxAQwNd3dgf0KAGjN7gNG/YIVjxjc=;
        b=ZVZORhe/Ej18A3tgUGVY8r12lG5Ww1x4XOC8OFZdVzhUIkzWHXyLQCSiIvgOxJeCcK
         Jk3KlJECv1hKwWSL04jVXb6w59uf2ZjhZYR10NLM3eLzpoxh+irQTkdEeT5HSdzZL5am
         iWLi0wOBjQH+fQmooUWR5Ol6Ix0Gen8YMehBFOq1bUHu3z/HA/bJSIXW5dSV5qO28vc2
         9gkSW63xQzb8gv4/iNM6BwBtskWHbtJFsLFdwmzdrGKUsbwyhGcojeqjVugP1UIRGf3k
         l1nUmumLv3NsRTbblmzBhBRdeB/2KlShTxCYKG5bTll6DzVjDeeweJZdKUhDpXxAw+U2
         qfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576120; x=1785180920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t6FOiK4vob/RxKMxAQwNd3dgf0KAGjN7gNG/YIVjxjc=;
        b=HyFNCktJlQ4OmiXHPAdp39wRsP3UM7exuyGqou+g42ZE1zawroF9ekFrtO3Gu0dSyi
         Bf4tQWfo/9KC3mTH5CpFQ9bZHnCXDoXyMrN7SLv2tfsq2qgDIkBvMUDZ1d22k7+0hTvk
         0NeTOcli30DIOlmXlsRqTOZyr8bxx1c+oY/4xR3gutLyE6VmhOhVVvl5Ngn8fsoefcel
         jLT/MwLj0QtfxgP0HD1F2QHypr/pnqDqv/4FewU1FJuqgFYrT0CaSpGWGKWCQ9N7aJIa
         02vX6ofJa3FbtG2IjwGSRyPtWnnaRkoI6jPJyGV1Jg2ZsZOifCXxPEGgi5JmVXvyJOMP
         N1VQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXxDDsMSO0yF2dYxcfwDjUMDwPGdcIq0K9t4hfXG6raQ6Usa+b94bUvDibyOCv2BbQKkUHhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPubiXo8lv+RRZUl/By4rOMmb9C4o3QWv5xQ+zwisKTjmX62Wx
	6/rUYNqLkvDdnot1slw1+ExXri7LMDnGM2hLQWka6NMreaYjXYiLFJjFLtRqJ3LBxWU=
X-Gm-Gg: AfdE7cnEGp1dtZLwYPZA8EnQyzmAvYA5IcMa3xModTO9AR9XShhbcftVadfWLMTtYui
	q3f/3beyIDkgBxXXP7uW3CvBSyk0xI0JshSla/qvTQRYvTNpBasG6Dmsq7xeJoGljJd9Q+tm8kJ
	/Rp5+Y4MI0dBy6aTpsfXvmoBqbTefaJX/+trVXw5S52D1PFV7j8ov5Q8/LUrlkFJ10Of0x3L8hW
	6UPklxcX6k28eG9q3S3UVXaVTT8IgGqxSi5kbO+erkzQjnciZr2onpCQHJ63DVGUzhxC2J/pV68
	CqZXol9rL4x7sDeL8AigubzzMnESeYJz4frL8pcam+FXvT9EdQ2/Ocx9logF+L3k8KQZYbOeE59
	wKpNGHpFqFvDtHw75obU0C+xixOzQ4sMyb5idAf3jhSbm+1yxx+CrYPmvjXt7Fkb3rWL5oWQcXk
	R+GtI03qKqECEGKwfmWo2uL0fNHJgYOJb8uVANCW+aMdEcM9UwXBTXcg8G/p/IW/M=
X-Received: by 2002:a05:620a:290a:b0:92e:7745:9a3a with SMTP id af79cd13be357-930b3e4e1f3mr1582641285a.18.1784576120209;
        Mon, 20 Jul 2026 12:35:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:19 -0700 (PDT)
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
Subject: [PATCH v5 16/36] mm/khugepaged: skip private node folios when trying to collapse.
Date: Mon, 20 Jul 2026 15:34:10 -0400
Message-ID: <20260720193431.3841992-17-gourry@gourry.net>
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

A collapse operation causes new THP allocation to occur, and may
migrate memory from one node to another.

Handle this the same as zone_device for now (disallow collapse).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/khugepaged.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 89ce6bcbc376b..fb4378cc17b10 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -700,7 +700,7 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
@@ -1687,7 +1687,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		}
 
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
@@ -1944,7 +1944,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 		}
 
 		page = vm_normal_page(vma, addr, ptent);
-		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
+		if (WARN_ON_ONCE(page && page_is_private_managed(page)))
 			page = NULL;
 		/*
 		 * Note that uprobe, debugger, or MAP_PRIVATE may change the
-- 
2.53.0-Meta

