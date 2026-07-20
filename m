Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180D48165D
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576128; cv=none; b=PI4itPp7i2xKMZFjpNkAH8xsoodgMF8i5DYKL3tlPvvN9QAN517nhvY/OceWq/iXX2yyDXkY+0Oyr9W91JZqOAqzmRobW3/eYlUUgJgdRXkRwkXiEXbMMfaIGWyvvA4B60Hz+OZdiqAUb/1lnDtg5VkbSlLOC07x/5ajs+hFZTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576128; c=relaxed/simple;
	bh=AclVB29m5XEXwT6jfLm+y0Vje/ATQlFgKmkw+sbjY3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOABTSn9hPfEBZemrnsHh7IUezs+QEgyt4M30GV61ufLjEIfMVQcf4KQdMNpwH5q5KFKevDw1xI9RDuKY8RFVynD+99Ja6QpZ2KSAIaQeAngnv2PYAOBS8UlEPKI7++iY+yfnZeXOXYAAHQKCF7G7rwIyIiUddLr8jaInuGvyfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fi+I8HhI; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fi+I8HhI"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so46478926d6.3
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576123; x=1785180923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2LDhxlVOpgNtSXDCdv8imM0ubGsvF9EJ4oiPoX2j2c=;
        b=fi+I8HhIet7HPyizZcEDOVfm416HncKv+PdpftSW2rSr8U0JFj08ZOnsJqAMu6eB/q
         AYlhRQgBGK3YoYrJt067shMITN+nWz4IMUo0KEM0Z7E/5G9AcndkW1OSkT8yMLgynbDc
         aNHQ/YKKfTZLhHaBhU7kBEI892czirtk9A4yEPn+FbUBsy2KIhCrQm5xhO8ETrYITnfV
         sw7ZtRJ1+KQ+6Lim4tR5EXIUB5UEudpnt4mki2bBqhyrYCKnv2R4YeyQY0b3imroxpd7
         DMLUWEqwM0pJniLchGELpP4obXAPVUlshJmOaMkaGenBwMD5NdN4gkMg3K4q39Xs5zF5
         KxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576123; x=1785180923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2LDhxlVOpgNtSXDCdv8imM0ubGsvF9EJ4oiPoX2j2c=;
        b=NGJbBBr/S7fDwx7eGCeCN791T/UkD/ik4BVRXxpg2kkFcmVFm/1e8Tt5iOe/N1u30q
         UZ36u0iLOlFgkZFcfaWe5Ui+D7ORoxwYG20s96TXZmwQrW5lB8KzF5S3yO/C6L7jbzyh
         PIPkTwdFwjl4P0aNLl2RcpjCBbbsdbvQVeVHxB51gO3xM8q38KlRQVKSM3Fdnz+imVSv
         BIamietj4gc71O5GrEBYiRL6bkRg7rKT4477DuYVWp4vaVSyoyMFP+ludTmUTRo9Rt2y
         03xhf1n/UrPJhFTE9xDOl+q0iP/E1ZCkdwh9Xtt3N8+5K01Kr/FHeSS27la8fVmihJZE
         gRPQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCf3Ac9GHzGd7P3aNJay38gAge5rbwGUjl5TAgf6u+CfmYvJTrTwOA13m++soNnP40cZIxLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcV16XCpcegK7NBFDf1sfifDqcdqtQvaSdSM2LtR3BTnA3xMNK
	qi0Ir14xylGra7+DPo6VpIAKPO/gfYCccco+6tkCdkiFxpr5PS8RuvuhjuYLBONWWvc=
X-Gm-Gg: AfdE7cnBqa421uwbV03T08lhJYcdmW5/HEcdRnjYcnBdcL4Q24/Fz2WBBeF4J+dD0rg
	vlrh/sib3UF38moUqETjizATOjD0MqlhwNm5PezM+L4CSExDQnYb9j7tQtxGfYourJDcG8ef9qU
	3vLQftsEnt9MUPupDlG6E/l0WPJ2Ks31oxz/1H6Y3Z9WpptZhBo18sTbywglvqhNmWhfnAfWVv3
	e5gr2hNJ1khZqvHSSss/ckFR33s7XkKMPnAIEWyubaIm+7FyH4mk70FS+tSA/c1KkTl+rZYmiGX
	AIRdt4uwXjqF6V5t2ZPLT6476LSNdT1xpRGYPrt/YyRZup/1uhSacsYEyDcyuAX+pzfItrnXwcV
	HxqasbqWEEhnJE8MnsoBJCsUE2q3PalIscSS7j5DczLooY855IY68dJAuw+hegugc18edOPfygo
	hslYJIfbpktw033NpsD6baKoMElEJUUVQ7k7llKK/94/DabtPYBoQnuTHIahaPemBWUcoGxo641
	g==
X-Received: by 2002:a05:620a:288a:b0:92e:f3ca:2ec8 with SMTP id af79cd13be357-930b3e4b8a0mr1508481385a.19.1784576122786;
        Mon, 20 Jul 2026 12:35:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:22 -0700 (PDT)
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
Subject: [PATCH v5 17/36] mm/vmscan: disallow reclaim of private node memory
Date: Mon, 20 Jul 2026 15:34:11 -0400
Message-ID: <20260720193431.3841992-18-gourry@gourry.net>
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

Private nodes do not support reclaim by default, so prevent all
reclaimers from operating on private nodes.

shrink_node() is the common chokepoint for most reclaimers (direct,
kswapd, proactive, mglru, etc), so it's the best place to filter.

DAMON's proactive pageout bypasses shrink_node() entirely, so we
disable DAMON in a separate commit as its own discrete service.

Other reclaim entry points are already covered - e.g. MGLRU's debugfs
interface rejects nids that are not N_MEMORY (N_MEMORY_PRIVATE is
mutually exclusive), and madvise pageout/cold skips private nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/vmscan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e26c6931f5fde..86b2334c23b98 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6141,6 +6141,13 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
 
+	/*
+	 * Private nodes do not support reclaim by default, filtering here
+	 * captures all normal reclaim paths that may attempt eviction.
+	 */
+	if (node_is_private(pgdat->node_id))
+		return;
+
 	if ((lru_gen_enabled() || lru_gen_switching()) && root_reclaim(sc)) {
 		memset(&sc->nr, 0, sizeof(sc->nr));
 		lru_gen_shrink_node(pgdat, sc);
-- 
2.53.0-Meta

