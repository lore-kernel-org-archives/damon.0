Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640230;
	b=IQfRyM3ZBMMzJ+Y9pYt2S0hSvymuco8w5aldIlpdn9ePLdweoOLN1XfKRvGJjds+2VY0
	 hgl+QmJKVVwwIRDExsoHw56fFB27mqO2g7o3YKM7qzUd6rYlPuh1L0ZgxGimJCs3r5sLm
	 eBz68nbFdMeqpOGP5T/jKNoUQyV/h2wCI73BHqUAf9ZOuxsGvOaOkVdujVXVkswW26VLK
	 dcUlEvgDKcrky/SitsBbAvE4rcKdbnUk5zjE0LFsy3FQLV+DG9r0NwAtdmo1iMaelJo+w
	 u9zS+m4/esx7kV6jGZ9YxA/984KDAwBh4/OYRVUm3s3d0PW6wifEPnPQmQa86qCNSDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WCui+DSNeboB03hP2f7maV0wOWIxjAUtx4hYmP2Ak68=;
	b=EWUhDtF2FgW9WWq8S/uBsjPWFcHkQuGRnA/R6lIUh2J/T1JrcDB+w5uVxrU7NQr+hXGG
	 nNnPo+rIvTu7jD21+eulK4S5wjwAqUxOZmTMd78hUAWvvpONhGWbOj3wHNNQb9g9YCHLt
	 eLLbD35kB+QM+8a+twFrKyoWdYQVcZXzVLe4kij4YE/ALNuXLb389chJxZfkGSnQlS3T6
	 6pP0+2nY/cyUwGf/yKBaH+5pfGhAOSOSX2Ndc+Ey3GhJk1rs0RXnfPpgC9s/Ymn1hL3f6
	 Js+fxh7IbCERTEoNGem+ygV5Pa4dYISvENLBF3KfjNFpUdoQ80e3Fsrof2dmF+l35CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=r96HC8+h;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71235606A8BD
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71235606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=r96HC8+h
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91ef011e338so29792666d6.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640229; x=1795245029; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCui+DSNeboB03hP2f7maV0wOWIxjAUtx4hYmP2Ak68=;
        b=r96HC8+hZdJqQGiMTPkKDYH8RsKClX8l3lVrUZvAf/mreC0VVSi5JpQcQ4aWCTj/ok
         x9hNBnDEjyKNzlkZcdlVaGd4WsakPhxeUChGRpbY7PtmMXkyM/BI02G5zEfx5w2cc65P
         QWXDCXVHmGmPPMK9IhV49jB5DX1QKFGD8DpdNCPb2APrtxZFYwlGtkf5PtY2ljeylb16
         Fr6N/Lne8Rt72540KUJ5sk31XlU0S8/czimqashsTwfRFfVgaZJ97HWn77o1hCg5NPE1
         HPz+lCgL4gdjrngQ6xer4AroQswwtrn0Z4jMlQ66sWHpyz+WN7C5s/HKconb4AUnFmJV
         2hBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640229; x=1795245029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCui+DSNeboB03hP2f7maV0wOWIxjAUtx4hYmP2Ak68=;
        b=AD1nEZNLbY8G6WBCuSyzBP/6asYuwtZQlStY2Tz8JGyk95LqIXeGYkSIyKZNPF6AkM
         pMJ/VMCIytOLoXtxQMLBpXWs93al8hySokDS+owJgpBhasJ6UUiXO1BTpgwAN47nEJxb
         eLIST9pt7NRGZs3icU1WDdMFkVLpAG02hZV9jYfMXBZNGwPAVOYwOot4K4JtGtLjMyog
         1DR+cAfA6AG17Ex0s5viIQ8XKjQx3JNnX2bVL9JAMHGv6xzkxOiXQh353dnHzzQp7w8r
         hzsASIVp4Mzav6M+tPXWfm8Dg6mssAab3YO0tJM+UbdVwzUja5VFUZVOODh50a5Yj1e3
         F6kg==
X-Forwarded-Encrypted: i=1; AL+hErF3fujvBU0mJ85hSR37OX+Zsk1WArcpjNTQ3PeNJOppLkHewCjsfeiScwuqCb1s1LhBwC0QPA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+cm0eSdlXCPpXDuep2/iwNcd+4MG0G6YPFQCnLC3EGbInuYOuK
	+jstNK9bqD6kQLBn7swqVDI/0AkZUNZAAHiD/PRFrMim93/FtX3Ds4EMbx3Pz1bIrbY=
X-Gm-Gg: AYBFou2Fg2jFFoprGj6JCPfemcMpxDdoAn6mj2EbWQXlB8f4A0sKkHpCfoPsDMuyzZJ
	Kb9tOaQQ5Bp9/QsmEyWeeh+YyOAOyMvWbq+7jxj2rSyIzaW+64yFQt83c47MRoBtcjlylRv0M3h
	h5yFs88aDUUHYwyMTmy+4is5838r06Dk9JfrpQ5I1NMh1/ihPuykhCejO7MRbj8NDCDdqW/+0tl
	eSaR16dWnFD9YjPS5uv09xaoKTaivPEf7mE3IsJ6V7Zgr6xpwW09VJ+Ckvj2ks3DYf2MvUcoqsj
	lNhLXRuiEcQ/gG2yxViZnG0IAikeLgHqfe0TZHboX862EUElHNdxC+SLOZrNPI8jqun46Gjdc3w
	P4geMZWSeFp4dcFhMBYoBYW5WVL7Q/9aK/7qc+000Jsqh7DnqFbAiJgwHSkUJClmFQcEC4QMDHe
	DiXzOh4lEiZJXZUpUnRMulANm+G+XvBR+1BDZco7rdF8MjGCCt0k6rIeWyTmy4WAKEhqE6KxSDd
	sWc8HKlxBEJoFylRicPARYLZZhW6nl21Hxs2JMI7TVd+5Q0XTt/ot5coUzOPFkRWpMIm7lFTU0y
	/QSbjc6Mkmy1Ble3M/72YVbO9pQeXal6je+ZwvauV5vFwPxXgEuOuGZYxwuXjORvgknyXO012+q
	2BXzGMPB30AaF5P0=
X-Received: by 2002:a05:620a:4005:b0:940:e34a:aead with SMTP id af79cd13be357-9494b9488f8mr838653885a.5.1794640229507;
        Fri, 13 Nov 2026 23:10:29 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:29 -0800 (PST)
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
Subject: [PATCH 12/22] mm/damon: restrict DAMON-native folio operations to common memory
Date: Sat, 14 Nov 2026 02:09:49 -0500
Message-ID: <20261114070959.3490008-13-gourry@gourry.net>
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

DAMON acquires folios to age them, check their accesses, and apply LRU
operations and migration. Treat these as general-purpose MM services
and restrict them to N_MEMORY_COMMON.

Memory outside N_MEMORY_COMMON can still hold ordinary LRU folios, so
it would pass the checks that keep ZONE_DEVICE memory out of these
operations.

Treat these folios like ZONE_DEVICE memory.

DAMON cannot acquire such a folio, so it never ages one and virtual
address monitoring reports it as accessed, and DAMOS cannot isolate
one for migration.

Reject migration destinations outside N_MEMORY_COMMON.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/damon/ops-common.c | 7 ++++---
 mm/damon/vaddr.c      | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index b9571f53e538c..51b4b5d572e77 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -17,8 +17,9 @@
 
 static bool damon_folio_acceptable(struct folio *folio, bool monitor)
 {
-	return folio_test_lru(folio) ||
-		(monitor && folio_test_hugetlb(folio));
+	return folio_is_common_memory(folio) &&
+		(folio_test_lru(folio) ||
+		 (monitor && folio_test_hugetlb(folio)));
 }
 
 /*
@@ -498,7 +499,7 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 		return nr_migrated;
 
 	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
-			!node_state(target_nid, N_MEMORY)) {
+			!node_state(target_nid, N_MEMORY_COMMON)) {
 		damon_putback_folio_list(folio_list);
 		return nr_migrated;
 	}
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1e65e7651cd98..338876559140b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -830,7 +830,7 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 	if (folio_nid(folio) == nid)
 		return;
 
-	if (!folio_isolate_lru(folio))
+	if (!folio_is_common_memory(folio) || !folio_isolate_lru(folio))
 		return;
 	node_stat_add_folio(folio, NR_ISOLATED_ANON +
 			folio_is_file_lru(folio));
-- 
2.53.1-Meta

