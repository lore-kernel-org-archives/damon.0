Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53DD48AE06
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576133; cv=none; b=IQhR7QBlXsf68mj83uPuPtPSIeGqoAWGc3aHiF/bdaZGs5Q0CsZJQL8LC1UCywUm6/b99RoIdtNgbQYWQh7TwKRLOui2iXD9Rt8ZPX3TiQs7ZUpRhsS9DJTPs7dX5WOWIVvvc6aw7ufov6RQ4Eo5CBSrGeWDXbtpsyeg0nFDcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576133; c=relaxed/simple;
	bh=ifqNq225nfRuO77jzr3XXyC27iYCrW1SGYAlShFLthM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2+6kU13uscks9vSfz10RlWOBH39CTftaNBb4pl/mifZy9YW8GkkXYU/4OyQHc1nCXNgUZ7oxZJCW/g3IdWBvitZlAubv3clZe3ijk2CX82Y2BOuF+JfDoWL1D7GR6BXqsRy9NypY5WEVwT9fMgQXQP+0Vxl7/P7Nv7dQ7JVPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BWDoV6+E; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BWDoV6+E"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e85499ffbso577754085a.0
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576128; x=1785180928; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KU1C1BFWfSEqKvrRpWFHlkg4mZCsJC5WSVAsWkbzWmY=;
        b=BWDoV6+ELHMGah32oC2+Ew+dhfCm4hR+7UzfXPX3vanlULvguAjrVkP0ESGNZRq3UB
         zbl0ZbfVGtkS9F9QVLFb28nHSqFSFwRoOPUzEGshZ8G9UhDiM38dY+Gzu+apJmqHW205
         bsu0Vw0eXFqVtq1SORCeoFKkGyB+lumYz2wE8xPnerg/9si4cnqH6WGaqBGQ0QrpzMGs
         MjKS5G3sxqM326SM3wa11kRC+BNXugu/7dbWxqzNmsd9QEWvZFPqdA/BNPfd0MW27rc3
         WY8anK8j0rKHcAIZ+hVUBAvQk27vc82Ak0IwnPW+UPqJWZG5utKcTuMTu9e34SIekDN+
         oiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576128; x=1785180928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KU1C1BFWfSEqKvrRpWFHlkg4mZCsJC5WSVAsWkbzWmY=;
        b=NjPKQQBhdwZnx6r80dHfsm0vZ+NftnfVqXW5I+4SzRUumqhvuwUnFzCoE9coG6rUWr
         t/8dUtwWdKEqxb9rMwu8vDWquO9DcdnkvYbfk5Z5Eh989SHUfXX1rWRqCTmECKiwl9Kf
         y2G9Tc91ItVvdOQZ5xMSoIq8w6odmYdIbZWyCz4/Xe5v4S3EBBLKpkMs1DkP5l/nwYHX
         r2yZRZgIrvS88XLct14+szkWv8xq38Ay8FmkYif6ZE/WaAv7XpoEqNWEDMdFp22Vp1DI
         UNxcyQZug4mv/5/f+AAYGs/irpmCcQF4uZXz9LlTS6hr47fd6/hU64aojlSJTp5SjGgc
         eCYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrjd/n5K4yrUjRYBtLa5NyxyvXUINl0cQAGs6gX6Bn44VDskrLjhQXaYKavzAjkgYDog6nLAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYy37r1i1QdONXQlxfb8BftSKaQpkCScripKsWksyJr3d+FV49
	2b9YWe8heaTU6Tz6R/rUHIq0QzEnctBfJb0jbcMJFIv4ApG0S3qxqR4Wp4Tp+waLx2I=
X-Gm-Gg: AfdE7cmpDrPU8B+NYlisK4OW7SUXf3y4BZlvKZlsqXuYsHGlI+3P0Nv39gb5K8OshbC
	TSGl7llZCxGC+ZyPhliBmqWrT7CyRixuJht7qyH/oR8WFU6hzIXTlt6LkqDpaA7IcCfzzi22UZY
	7pslccda66kTMk2T8u4Ly3j+oDSVsqf0kE7bmZjZRg1RKiZC0swJ/1rop/+PU4eKAsVAMr1F2gp
	k7N7je2rEiBzHdyiB0OPr/+TjeFIRo/3FW+PWov02Judq/OE3nXrmQu2f8+PX90b8BK5AHvo3ec
	1gSuRGG4wP1xAznrqR96VNghxCCW59fo8iCe5xxmgn4HR1mZgFVUAKIqd8zqwAx+Aexye3KHYQW
	M6LXdc2mYu+2ywJbL43192/wT3BwpiL0e2k+bmmkoGkKNcHmoPJWKvsGauGRvQIbfwUeHiZ0eEp
	lYMli+pomo2W3ihn97uV1YRTOgSaWAUTvozyPrT5uaC014Vn7C+mi9dy1NDAgNsXM=
X-Received: by 2002:a05:620a:4588:b0:92e:4e88:f453 with SMTP id af79cd13be357-930b41a0726mr1469051085a.52.1784576127960;
        Mon, 20 Jul 2026 12:35:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:27 -0700 (PDT)
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
Subject: [PATCH v5 19/36] proc: include N_MEMORY_PRIVATE nodes in numa_maps output
Date: Mon, 20 Jul 2026 15:34:13 -0400
Message-ID: <20260720193431.3841992-20-gourry@gourry.net>
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

numa_maps collects per-node page counts in the page-table walkers
and emits them in show_numa_map.  All three filtered by N_MEMORY,
so pages on N_MEMORY_PRIVATE nodes were never gathered/printed.

Accept N_MEMORY_PRIVATE pages in both walkers and emit private nodes
in show_numa_map, so private-node mappings are visible in numa_maps.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 fs/proc/task_mmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 817e3e0f91943..e116cd5f157b9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3389,7 +3389,8 @@ static struct page *can_gather_numa_stats(pte_t pte, struct vm_area_struct *vma,
 		return NULL;
 
 	nid = page_to_nid(page);
-	if (!node_isset(nid, node_states[N_MEMORY]))
+	if (!node_isset(nid, node_states[N_MEMORY]) &&
+	    !node_isset(nid, node_states[N_MEMORY_PRIVATE]))
 		return NULL;
 
 	return page;
@@ -3414,7 +3415,8 @@ static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
 		return NULL;
 
 	nid = page_to_nid(page);
-	if (!node_isset(nid, node_states[N_MEMORY]))
+	if (!node_isset(nid, node_states[N_MEMORY]) &&
+	    !node_isset(nid, node_states[N_MEMORY_PRIVATE]))
 		return NULL;
 
 	return page;
@@ -3602,6 +3604,10 @@ static int show_numa_map(struct seq_file *m, void *v)
 		if (md->node[nid])
 			seq_printf(m, " N%d=%lu", nid, md->node[nid]);
 
+	for_each_node_state(nid, N_MEMORY_PRIVATE)
+		if (md->node[nid])
+			seq_printf(m, " N%d=%lu", nid, md->node[nid]);
+
 	seq_printf(m, " kernelpagesize_kB=%lu", vma_kernel_pagesize(vma) >> 10);
 out:
 	seq_putc(m, '\n');
-- 
2.53.0-Meta

