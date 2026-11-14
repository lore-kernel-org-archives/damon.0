Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640237;
	b=nBKurPvDfTS1VHdiCXKzQ0USpi/qnupcJVjuDMNrPYYHz1g4n5EIKUUugwde8LKNnEJD
	 lc5xyYVjcAgcBhcn1HWCEWZMDj+pr4ZFMvkv1lQ/y0EukxiJzzgbc7aZ1vSCT+shtEnNu
	 Vt6QocaN+w2mBUOxiX2QBbAgxt5ziXsm53RF5WAIJlrVVUyymJA0DkDhnl/HjQ54DR5ej
	 4SXy/ATLmjughRWWRpjTe7wYlm6eWyTQSbpIEH3dqakomQzS0nDsBmvzlSAbkXQFnmE24
	 EXbda1tzWBubN7/CRNmb6TjxPJ4LeFjDGBHgvHkmFdsSu/PfKlPos3B/Mb+WnZna4kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
	b=cXmqM/E6PU8gvsrYBvyfLTbQn2gyAhQPiVxI/EpXmINv22Rj/9OzED9vh2E+UlVcG7Yn
	 ODzrHVaotovX8EGlWObmKk567firc2DR9ATNGPw4IBSlu/edHkgBpP0aqSUvwQwI2diOd
	 O6byHQvjBQYjD+hTdN8QJ3ygvXEL4mEF7AJXF03BuQO6mskAoZkx5I3Zm3lcSv7Sard8Q
	 6GLGX/22YeqLEzvQiDiamHp/4ggqPJJi3aCUmX30emdL0XU/s2tjDXK6f2/ddBzywICvr
	 4PvinVK9QvXP2OjZY+7df8JeyKI1GDtfEalsFQFqMQQGqh87KlZTo70N82TA0CAsabA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="b+D91/h7";
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2C606B42A
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FC2C606B42A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=b+D91/h7
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91f332a4b2eso5815346d6.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640237; x=1795245037; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
        b=b+D91/h7LQ8J5mgY9LDECAPVr3JuNIRCPNade4NZGZlQeSSbHsbdyVwlHZ26g35jeO
         xtrdo0g71kElvFWZ/twef4EhQqcN5+zWQ414Jlw7Z/O7Nm7TKdrZlcV8GGQZ7Nntq36w
         LNBMPCyP2l5V3BewhHt1JR6woFxL8n4oGmqZ+4hUb2ROaSAk7Erbc6CZwcHD46xiOd6G
         h4G7QfSOrHY8lxGBto/fX6V/KueVnEk4iyezqXqcHy5qH7Az1CY4jC9TDWMmeuc+Y1yS
         lh0uIjrKVrjIfKNKscJ0CE6l26ec+THzO0oqAlHByO1VIUXtNRoahWktul8QMFwmKHmg
         seRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640237; x=1795245037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
        b=1O7SGDvS/ldj9eBQ8qaIHK5eXclMzrbWhKJ11gqatIx4EjaT6AjaJBXQF9gIwsV+Xn
         gdUcmCDlgCvduM5V85WyDnE4wSkKO9FIdGqX0x3dg+eD4JMDxr+q6GOlWrIijSffGSRl
         OmOf3BBzUxfg8tznlsFhRwtAdWRrC8r3WUkGCXHevi8f0omrsuMYYokcQKPd5bKaeR2s
         s3QSgtNkgB267DW+Wt5bbSbu62I2fKjMQ3UtOAXBaVYNXYtzGOZ1lklXcsLOgL+jWgHh
         Svb968cd770sr9yACDR9crkfmE0Issy/T34a+hZV8VCaVGJCoVV/rJH7FjQN5sjeHmq8
         EIfA==
X-Forwarded-Encrypted: i=1; AL+hErEIsio3K0E6Yk37DgLUURX+FWGQzCuNs7GMwZDcG9aOIqumxJ2Q93R9PUKnvQfAMy3/rvYVvA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ufYaLf0VvjCCtd5UuUFXvhqzU/5f8Gbn9yf3FaY7IMuGTpEXu
	UH3eIPjzvsGGa+EYR5SI4tQIefFiwDKjNxygj7Spz8jaA8bLBAhjvHTFG2AMxPzwYo4=
X-Gm-Gg: AYBFou3V7IiqTKVv3ACKZbqT9Z7s82GQ09luYuCvaLKUzBTEbGZ0UX8xLA223x5BKRy
	isoXOde/uM1QOoOqrOh/rr+sDKfXFpFmLd0l7IpTSYhcgWaD5AeqBijgZtJyBHf8X8tCnkH17Wh
	Vb5pwhY2vKswJsmcAkTb0FhbKGVnN8AM/SZcFztUGeaexWqhQFoBTmnOeH/0ghygqGT7d19sHhS
	8EOOVzFyerwf6yzeEDhPNoyBxev2eXkG2JfxHBEu3A/i1IrwWA/hcUrkX8+zEQpGAdGy7DDbSuG
	B4vBoIxmy14/NMuo5THlPGp+2WuxafBWeDecJa20Gw1R3EZHGslRY0Yv9ljmkU9+D0k8H4LB/uU
	Zs9YSypzYIj5j9wFM4SZQQ5UR4cgwBHPg4NqdWdEtfpA2j/WYYCdpvPlUJ1MXYd0rzTwLLi/TQB
	IjO8zp3GUFKuSppMiGdP32VH1NCAcVQ1OOkeGIAkq6MI3U/nirH4huFjoOPgdESrcbZgSIAKRtt
	nbkRo+5zCEm1XvZ08qQFfuToF2ounUWyREp4o3x9u4xw+PaZyPljxxXzTM0Rk9VqnwCekIBiCUW
	dvuKZBu+Mt8stSlf6r+LOb2EaytGwlia2S6QVFKXXiHMguoHSKkI6sn6jm2TCdTutvCmopBhk/H
	xObkDI4Y4pGtaplQ=
X-Received: by 2002:a05:6214:3b85:b0:91c:15ce:66ce with SMTP id 6a1803df08f44-91f24194ac5mr80511276d6.11.1794640236685;
        Fri, 13 Nov 2026 23:10:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:36 -0800 (PST)
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
Subject: [PATCH 15/22] mm/oom_kill: compare OOM constraints against common memory
Date: Sat, 14 Nov 2026 02:09:52 -0500
Message-ID: <20261114070959.3490008-16-gourry@gourry.net>
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

Ordinary allocations reach only common-memory zonelists. Compare policy
and cpuset constraints against N_MEMORY_COMMON, so nodes outside it
neither make an otherwise global policy appear constrained nor inflate
the constrained capacity.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/oom_kill.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5d48bd862c27b..1ec22bdad1fd4 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -274,9 +274,9 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	 * get_page_from_freelist().
 	 */
 	if (oc->nodemask &&
-	    !nodes_subset(node_states[N_MEMORY], *oc->nodemask)) {
+	    !nodes_subset(node_states[N_MEMORY_COMMON], *oc->nodemask)) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, *oc->nodemask)
+		for_each_node_mask_state(nid, *oc->nodemask, N_MEMORY_COMMON)
 			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_MEMORY_POLICY;
 	}
@@ -289,7 +289,8 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 
 	if (cpuset_limited) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, cpuset_current_mems_allowed)
+		for_each_node_mask_state(nid, cpuset_current_mems_allowed,
+					 N_MEMORY_COMMON)
 			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_CPUSET;
 	}
-- 
2.53.1-Meta

