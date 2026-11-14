Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640227;
	b=iUgS9QlUg5EYdoEE8jwcht7ZM8YNcml6o/mXmbbElnBUwhUoCOe+8+EXCAtrFbgM+stL
	 f8LM0JZIA1CZ1qV73fBpKCrILYfJWq4pV7SAEu5btMia7B8qg1TpbMpiLtoBXvWmO189K
	 5TV9jdgBz/+Jdwyn1lpnNoPtCwTPUJmGLRPSF9LqVFAR4VpYmG4ycAztmVw7IKiabntUp
	 VySbHxYMDwKSzkO3butE+PwUR1+L/GzlaWVc+8eu+l5QeVpnXfeTsfxkZpNRlDj1YwjK/
	 wgVuJRJH6j3xY0cymG2TyzliaT8vd/GBml9XDqoQSiCU4IRjrvHT2t1ORJh0wBxqgiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
	b=d9PkCjdi2o7lhlFg1TWm58iTneQxKmUzdK/Pb7zoDZ8BQPb5kk2Kn0FWhdMcVFGMqf9x
	 IEd152U+hLferEZXTGkx/mCBql/65Foj1AVy8+FAb49OMIUHfs0Tsq/eJtQbuE2IyvvqO
	 PkYWSDPWGWJRDibNsumITZ5dQtkC+Xt6v6x8caluYyydbXcQpRMISyAOP3zEmoJ6nr00+
	 VMNuh3X6Cc9oPgDJclMSDziucFthk2kiZzKs+4w/RmQSZxiYJ6QWKe1ZvDWg7R/go5pdf
	 f7ZYRQBU6YS/G4UHBqnmbPqPNZgRKb+R/sHIUp5yGEEKmXHjzCWCisWyQzFbuVvuv8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=IryoeXqz;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513E360A5BFC
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 513E360A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=IryoeXqz
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91f23ddf32fso12082336d6.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640226; x=1795245026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
        b=IryoeXqzUQdrT9HfL/4HDH8dX5eeLdESAfiIMUKCvdoCYm+JrcweHiNoc2tJKLaf2c
         21DS1GzmO8wjIWfikAGVwIV0k1B+gzrGBG9KPst1S2WigUpOiiMyHBEvuNwYHkwZJ3ig
         oW4U4wDgQCrkfz2822guyBYV5LWHO4Gg+RkB4u1xmCDI12gvuEyFB8nV4zVQ9mK0xC/E
         xC0IL8kOGtl+tg5so+/nDyTmOf61X+8chVAmA+1ESjcTfa87Q5Nz/kAmFpDXIoVa02ml
         zy+fOGJJN5Zhk+F21EbnSp2bCR54IhcfgSYPWWByilLAQY5sO4QkcDWmOgbnIHx3lJaM
         hEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640226; x=1795245026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
        b=wu+HXaG0uYdfH6v6rxeuQfuJ3yKRsjvzy5T8DdJKLe0ODMUSKCfYHlitqCLzx3Pbnf
         Lqf7UOiOvzDFSqMknUlWWK0BuMmpfYz+EKOUffY0FEXedm5y7minE0STd4H8ZWhJrZus
         AeHdT6x21FXjBIykzsfVA8ww1WQGOBbAMQAz6aEapYbJxK5sfqHVq/QrvXsG9rGmPh+y
         Ntod7KwumjZAWm1OXSYClb+YjHovKChK79PcMqYMQJ2ExtApYJNh171Qg0w6t9Pggajn
         zv5CvattdTeaq7Eth/CqrbLZdAWMDNnW86XEi1s56G53lDcSKSG9DCvRjHOUv6NlISEx
         /6QQ==
X-Forwarded-Encrypted: i=1; AL+hErFFlLh+Jb0efTbiQLVREMM576HZIWnIckuWLS/JE6ep2DR0erOKzFxZNSN+QKXsg+etb+wcig==@lists.linux.dev
X-Gm-Message-State: APuU4Z9uBAITU19zD2cVBC4fkGuDZ26BnyVyWdfSe7A7Tnjz/ACIavHr
	mXaxYwuEcWV5TDXvk7G3KETIq1E2kRfOORxbKI27+PGmpXpEqZi/0mnsX6TPcDwBQfY=
X-Gm-Gg: AYBFou1uHXXdL5qlLUwpsHap8sHXjxCulj64xU0iU6pAI9kV/tW+wDJkg4QKxoNyTkt
	hfW7y+b5AKGX0Ki4z4IgVQn7bbcxg5oFgQWPGpSp3p0pupfdmXKncxDWSkF2RTTu2fsS85Y3/yi
	FCMlbk/fyPeze4/w7ag+QPxozPDx6b7ROc1dSKFBc7l6fEk9Oe1OXpg6XlG2RfvetWYFqFGKDV6
	RiPHENkbAVXi1fch5HqF4zr2+pZC6QvMzsR69g+2ZP2BTNgmaz0izqR2VySlA8gBLJMmPamhUk6
	TizmL6R38IoOqhlLyNdfqbVg0SqkRrjYFfhjCTBs/dFn2G21v0jHroUyDcta7RtACzlNx9rgajN
	zWj6kA33VKKunet4+/9QZp3AgbcTXbqkFu4O6TRIB+EQ6bef8rm6nuLG3AYN8i0pvCg3dXwt+ho
	o1gZNTVGYZRt0plCq9csu5cvMOnLPriRHMGguNpFyTDr4vFJ59TlpNvgT1rYxYHBTYnrFQ1Fqnu
	B0jgRBM/r6thrgpKC1dfIlZpVKwDxX6SHWT3hcYYoUFI5rLAtFn7vDg0WNV3MQlEHUfhtVECG9h
	IlRgqRrspakMLvE+GYdJQInmeiwT8BWSn9/nPBg9olRHz+0y1uCJ+Vg7Hd4MfvZydhHolExufKK
	7SNbiqWp8GV8rTp4=
X-Received: by 2002:a05:6214:e8a:b0:91e:7bb7:fd65 with SMTP id 6a1803df08f44-91f24292699mr81332616d6.56.1794640225203;
        Fri, 13 Nov 2026 23:10:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:24 -0800 (PST)
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
Subject: [PATCH 10/22] mm/khugepaged: restrict collapse to common memory
Date: Sat, 14 Nov 2026 02:09:47 -0500
Message-ID: <20261114070959.3490008-11-gourry@gourry.net>
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

Collapse is an opportunistic MM service and should operate only on
common memory. The anonymous scan and isolation paths already filter
zone device for the same reason.

Replace the zone_device check with page_is_common_memory().

collapse_scan_file() gains a folio_is_common_memory() check. Page-cache
folios are never ZONE_DEVICE, so there it only filters memory outside
N_MEMORY_COMMON.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/khugepaged.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4bbe319ef86fa..b4bd29f25c145 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -628,7 +628,7 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(!page_is_common_memory(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
@@ -1673,7 +1673,7 @@ static enum scan_result collapse_scan_anon(struct vm_area_struct *vma,
 		}
 
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(!page_is_common_memory(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
@@ -2741,6 +2741,12 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 			break;
 		}
 
+		if (unlikely(!folio_is_common_memory(folio))) {
+			result = SCAN_PAGE_NULL;
+			failed_pfn = folio_pfn(folio);
+			folio_put(folio);
+			break;
+		}
 		node = folio_nid(folio);
 		if (collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
-- 
2.53.1-Meta

