Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640220;
	b=eGQyZQ7LXkFKbbZgeG1Z+OiiQRuC1FFkm74g7FtoJSPkBnXAAB7sb0wKCoOTz7iiN2K9
	 OkSgA0wRAug6EbwZ9QrrFljWYGiKiupZXs79jJkAD/t2KnXYT2obWrobGNTPmhLNK31m0
	 PUVN2x7yRpaEULDlfHI/9lkIk4INkE9zVap0d6o0nvjxHHBtqN+mLr/mERtuKYYBS0wSh
	 a5jxnaU43SQDm4I7wKUZbRsV5h4I/dyr+cd+yds8f3Zo5P6zO0/avMYwfuKI41k8mS9sX
	 dhjJ6xHERQNHSc0zmlhO9SYoJYdHYuwp3lqSnw3896EXqZlpfjZNMWXlHorrBUdRJCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KKsqfMs+Khz2jHdLUAmVstaMz+t2qjUPbSjoMCe8lqE=;
	b=XEF938tnb3SSfqW/Qm+N7ux0RkspQoxryqBrxuJGPC1B9mWHBDZ0yLHbKqWiNDwnxV/Q
	 8YNVWG9gEYPe6331Q6SwGmoYt39dvkacTjATGPCQdaW1zyTUN5VlsZLswqxxXt1Rw3cQI
	 PiRyZqhsuVHlTn1nAAQXzR1fzq3DQfyAcFTrICYcFzDSnA1sJy2Bz/EcBAzjkuFa2A3IR
	 ZdH/01jVYADeRRb17T7T8iokDqq833JcxDjQWNsWzJeV0LKbMdHri3vCPzi4HUkRq5k4r
	 egc4dlwCUfhXw8qPN/u2BzSWZgWIMA49auQFLHEQxEYBMhuANt9+q0KOGqYGg4Kpk0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=W1OylGpA;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603F60A381F
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D603F60A381F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=W1OylGpA
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91eb46044c4so40932726d6.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640219; x=1795245019; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKsqfMs+Khz2jHdLUAmVstaMz+t2qjUPbSjoMCe8lqE=;
        b=W1OylGpA4BfP9zCMyW7rwFKo9B6IX6QMlAhEdmLMJiFYXBHuXaSu6l+ObB5oQg3hxo
         DfqPWD2r2oYfEERgCAzzewmnX4x/JsFalsaiDlQPpqdD6GaYL8O1vJIBb1d+vNKRTd7c
         K8Nk8e6NqNIanbNz61LnlOUHeZslMDBdlLaezHpwr4Ab09ZO+K0E8JB37y5676xIIaSG
         HSV5ZjMhtgEv/liGIv50W0+bEu+H1bDuyX2QZ0Kzk9CX1lRE0XmsU3Qe3h4Y+JAQ5POv
         7m/CSI5v7QwjmPNPdXKlk5k5aN4buJo6hc8/jk36GAjNjGyE+pAd/YD81q8yEw/hmyXI
         p4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640219; x=1795245019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKsqfMs+Khz2jHdLUAmVstaMz+t2qjUPbSjoMCe8lqE=;
        b=oI18EG5smSDF0x3CsOcYTeNAfXuP4qJEBTwW7cGxUQgIr3qR1j8fMAlhFrrh5fxRR7
         kOLlU6e3tQ0vQwV6VFmUROPG1GlrTePqniCkNoyivHYKO5hRjZS7Eo+IWBVZVtYwYdKv
         +DC7su0NlpzoJ1ObfRnkhe+NaPo7KWYx/toeAkm4gZuhUNVBzOH951JbS0LtxBoBum7G
         BoPEkf4/CVvr2Ti8UV3NLVab9IIPR9Mno/CMCV/D0DiCKiYqn9gKIdfPA7XLNyV4+yM1
         NBT+X/m1IK9w0GCQOVPspJp51IXr/pF7IHJNGtIbNfpqYUSLg2oBYThpWhZHFohtdhMq
         xH9Q==
X-Forwarded-Encrypted: i=1; AL+hErEr9hzOCpoxGXv/+/BUBIadzVWXBPEaiYucLOhjYvGJ3uOevwnV9vB1IaK/BeGyz5F+KadahA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8cgQ4iHKtTXSCjJ1Mkr8IK4GLUkB0r8TtlT82cT2LDa+4bgBcO
	o3lCsKyT9vTvjEgZ68kZPSeHpoqwinKRwKiv9HgPvo2pdwjQ0Dl/sU3MuCaeSshs7UA=
X-Gm-Gg: AYBFou3tI/5YUvpoE2b8/OFYaqhbVgHaHznTT8C05hxd0qV9xnhcGB52qVsjJVblEt2
	1z7CVMvXtl+OHvaRDns+Vokt+QtQSBDw1pNIakTPkRLjQqTByoe+CVn4SAyZI4xQyy/zQ5PXvH/
	XzZlKMR1t5WnE0HR9NUnaOd0L3fKPRYqhaJDoilh8Z0x4Svw3h2CTXz1tm2wOCMEvwJcWUHoC2m
	VFbA8brzSuhBWWR1IIlfFF/YaeyQJztZ2Qud6qjIXqMM/UqYCI1OZw4fYL6fS7C4htOnJ3FFCZx
	uZAANHr5Arclf/kja9TfC3POqbn2SQME1bZ+fZsFEvgMrIpg7gIFNPFbDbGK6/qvZD8y3VspKHs
	nmeGBMb15Pt5hAqzfWfvUN09mn0TviDTuDMWHVvA7/5LgXkNrmPz+xG97drtAPaQ+C29w6lA9zu
	XuF7byg6+t+VMAdieScWlmGWkBIUN//xT8XrxhE0Xb8nsdL/bpqMvtj04dv8ZbgiO9BHseMnOS6
	7E9r5I/XoLlX/ZHHmjPSnk/s0KNWDzNWTsidA5VejsgYl4Zl7Jc7mUAX7W5GvmBqn2zrBHRKkRL
	fSU4zbqaJ+TKAmyiRzoPxS1+9w6cthPMlj2iPug01NmE1mU6bOU76RNFcjYxPBm4Pzxg/aAOCpo
	q1d+C8cCN7qBVxic=
X-Received: by 2002:ad4:5d68:0:b0:91e:a6e7:b445 with SMTP id 6a1803df08f44-91f241e127bmr84458226d6.9.1794640218986;
        Fri, 13 Nov 2026 23:10:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:18 -0800 (PST)
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
Subject: [PATCH 07/22] mm/memory_hotplug: migrate offlined pages to common memory
Date: Sat, 14 Nov 2026 02:09:44 -0500
Message-ID: <20261114070959.3490008-8-gourry@gourry.net>
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

do_migrate_range() / alloc_migration_target() is only capable of
allocating memory on N_MEMORY_COMMON nodes. The destination nodemask
presently starts with N_MEMORY and removes the source-node.

In the current code, if the destination mask becomes empty, the source
node is restored to allow migration during partial offlining.

Consider this configuration:
  Node0 = N_MEMORY_COMMON
  Node1 = N_MEMORY, not N_MEMORY_COMMON

Node 1 keeps the destination mask non-empty, despite being unreachable.
This leaves migration with no usable destination because the source
node is not an eligible allocation target.

Restrict the hot-unplug migration target-list to N_MEMORY_COMMON so it
reflects the nodes the allocator can reach.

All memory is common at this point - behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/memory_hotplug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 490f400498f14..29ff2c46499b3 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1904,7 +1904,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		folio_put(folio);
 	}
 	if (!list_empty(&source)) {
-		nodemask_t nmask = node_states[N_MEMORY];
+		nodemask_t nmask = node_states[N_MEMORY_COMMON];
 		struct migration_target_control mtc = {
 			.nmask = &nmask,
 			.gfp_mask = GFP_KERNEL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
@@ -1919,9 +1919,9 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		mtc.nid = folio_nid(list_first_entry(&source, struct folio, lru));
 
 		/*
-		 * try to allocate from a different node but reuse this node
-		 * if there are no other online nodes to be used (e.g. we are
-		 * offlining a part of the only existing node)
+		 * try to allocate from a different common node but reuse this
+		 * node if there are no other common nodes to be used (e.g. we
+		 * are offlining a part of the only common node)
 		 */
 		node_clear(mtc.nid, nmask);
 		if (nodes_empty(nmask))
-- 
2.53.1-Meta

