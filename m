Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71273478E57
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576111; cv=none; b=Pj7tLox4hCgaIYC5RsFpo8KvSoU+xF9rQkRks+nl6ttrJiEwRJW+fFAd7eY2/tEL7VfRjNem3Fg0eoETQIpa6IzrLQ82RKKI+QLmYx8wsqboY9o385cxGZyKjJ2XCvAUfgC+itn+OrSGQair+GL8m5trU0ajaM6MekYdm/0gUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576111; c=relaxed/simple;
	bh=w0eKiY4I5uQufyW64Owv7K7jj+Cw2kBSZ0H/fUn8aTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIYj93elbueAJrM0fZb+qJzMh6yirFqgHFEsJ5xIP3D7vluvZhnvk4nsoctZnVqHSbYwxuVO1SV2BvYJL152YZs6NNx/Ge2LFwMN1j/iK7M2HbytB9vnefhnAPzi0YL8ddqYb4FU8LomdI08oQS/GMCTk/8mgSvxjNduxTUlR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=l7htEs2D; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="l7htEs2D"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92f0b5ed131so662379385a.3
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576107; x=1785180907; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AbvY/gXh+2/u61eyWpGKI13cVvWaG4WQkB8wV0sMVYg=;
        b=l7htEs2DpB3UFo9n/br8LcKGCQKGhNJaonS4N5sM5ITKINNXT/WTckkYxGCiBkYKsL
         PVAiKjFebES+B0AKO7Cj18KcN8KL5tLiFD4KsO4Fe+sUr8+oPJmnaUoNHFlPmOocymRk
         m7qSZOTtJgHRpGykMP7hBYH2ElR9k2O7ftLj5k6rTpP1S5cAFO+d/AAm46e5Gtsys2BT
         Z4PpNWu/AStTnKnnSjKX9Gr4jbBY4eCesofHnALH+d+3tI4u7ht5IkGegzM40cEp9o5E
         nO0vILKJIFMePfTLSU+CRqQs2/QKxYM2RVlmvfveMFYdSH9Dg2LOSR+n6Lm+++fXLiPe
         FjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576107; x=1785180907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbvY/gXh+2/u61eyWpGKI13cVvWaG4WQkB8wV0sMVYg=;
        b=lmMl+D5ZSbAJNn0Wiry9RKYVdDhyHz53sGeniobmw/NGZP+MCQQUQXutvzxlxRUs5y
         e1N2trUmCwT/434FS47eCGlr5mx2r+Rc52QhibE/JGOYLhnr7LfHiNMe+Cb0gNtDGHzx
         JD7OWjV6E7Qv+E4csEclY5Y4VyO2RZM1rdcOCv0Ad0a4bIaD5PFfDJwJidYvQ5y8RFk0
         VFG/dZAtJpNhFyzvBYxtgjcvrCnr2sRq9N6GnrEngaNO30DzbsVeExZlBLfvf90c+MbD
         /Esa76sfUpcQx/Dlj3WoL+oC+Z5kdenjJun+B6a3sRh2g+nyKJBvdbP2T9DpcLsPphbW
         hz/w==
X-Forwarded-Encrypted: i=1; AHgh+Rrc8xSadsoYZfjavyxKrr5qXIKKwL3M8Wr1QRK9KsbL+jkxNeM5RbkpJAHF98NcPZ/FIi5GRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUqogHMPgfo1IM9ORfA/s5XFVZAObUZFhSP89cdZsqJa8x4OCg
	XOum/qRigXbkgyBSh7Hmloa/3RbcEScvn3ynPn4zjfXilvbGBCnTjujhjZQMFtmIbeU=
X-Gm-Gg: AfdE7ckGxEHufvd7TQOurRIVou/cL0YyABo9raaiyjCTWf44zp97/FGDRXB+3cUtysd
	JzZKU63bIUj8HjbMIPEI3HzsTd7nObULau6kMmdQUmCvMV1z2PX96l2RR4cU4EyXe75NF7M7Q8q
	pxfzp8+zYaV8Hp3bTz9aSHyQK7MUjyh33QO6511nTOJCZ3xz17dhqxY9oU+5q8b+LCNBH1qvn/6
	H1MWSXfek3hcihDRaZ/XeP3nAsUOtCEX+fNw0bZHR+6He0RaTAnm3BhlywnUxO/euRQL9nUlocP
	wbHPcbFBdkDvz8KS0UWF7+WRqLpPp0ZyOSMSoa7d9ylBWAYhQ2cFX1tP3mNbE7seollmMDySO+N
	62XJ8Gpzg77hUBmyfKrPeDnHoOhAe3Cws6KiXPprg3jzjMxVaMDy7fcx/sWiaDATX7gDgnq3wZK
	siWMzUh6GFeQ0iRH72o0v51mpTHaC4kT41yPJz6IFj772d2JKkD7vAa7hRurDd4eI=
X-Received: by 2002:a05:620a:44c2:b0:92e:6b95:237a with SMTP id af79cd13be357-930b3f45487mr1592960485a.32.1784576106925;
        Mon, 20 Jul 2026 12:35:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:06 -0700 (PDT)
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
Subject: [PATCH v5 11/36] mm/compaction: disallow compaction on private nodes
Date: Mon, 20 Jul 2026 15:34:05 -0400
Message-ID: <20260720193431.3841992-12-gourry@gourry.net>
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

Skip compaction on private nodes. Compaction requires the ability to
migrate pages, which is not yet supported on private nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/compaction.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 9f81055a358ed..8c1351cce7bcc 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2462,6 +2462,9 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		    !__cpuset_zone_allowed(zone, gfp_mask))
 			continue;
 
+		if (node_is_private(zone_to_nid(zone)))
+			continue;
+
 		/*
 		 * Do not consider all the reclaimable memory because we do not
 		 * want to trash just for a single high order allocation which
@@ -2853,6 +2856,9 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 			!__cpuset_zone_allowed(zone, gfp_mask))
 				continue;
 
+		if (node_is_private(zone_to_nid(zone)))
+			continue;
+
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
@@ -2922,6 +2928,9 @@ static int compact_node(pg_data_t *pgdat, bool proactive)
 		.proactive_compaction = proactive,
 	};
 
+	if (node_is_private(pgdat->node_id))
+		return 0;
+
 	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
 		zone = &pgdat->node_zones[zoneid];
 		if (!populated_zone(zone))
@@ -3017,6 +3026,9 @@ static ssize_t compact_store(struct device *dev,
 {
 	int nid = dev->id;
 
+	if (node_is_private(nid))
+		return -EINVAL;
+
 	if (nid >= 0 && nid < nr_node_ids && node_online(nid)) {
 		/* Flush pending updates to the LRU lists */
 		lru_add_drain_all();
-- 
2.53.0-Meta

