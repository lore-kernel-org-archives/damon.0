Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640218;
	b=hGREpjNFT+wSsn5KWMzaLvhCJoEP+2rajvb0NUvfadHxHq9skYMtoa58hy+mN1MoC+FF
	 PXdiOI9uEHjWZ0sEzfQ2CC3OBdnbD7i362RL0VESRGZFcn7K4s0CJXgo2QglR/YT1oyRC
	 c9OTgX0AEkNyAwmpkbbvo7oXhKPVQ6DgZ57bsgN57qGIdkYX/VGW+p4cUGQ6ZokPCNfnJ
	 aHK3kbcv/Roj3WW5klBGvz9vtb6sa1XnvJ3++2Mzl9ipm1fv5a/iPyySfqKphLU3joZzE
	 YIm+lMfWEpzHcYH57PdXxpXA4/DsztnRhaqfriaDaXL/CmuVgutfpZEnP8yuF4IBeMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
	b=TkmnXAW4HYuJDvwyWjPSR4ZMzPfJcFES7byi16aCKVWGbC01EDCipp4VKk0jO6UwulZ/
	 XC7l/u2m+Sj5AgAQ9RDmRuL7QouvDQrIvNnfcSqtRs6r1grMUbpVgvzY6djEbUPKUqadq
	 nLsuAIsYmcAkz+3qq6bY8Z9xXxq+DyeiIqfnpVzwnwbT8hnQCdHxs3jLBsNz2/Jh1BHcD
	 nrGXbxkfidtZWG+Mw3lFZQ21q5yFm+WqHoL2mr8994FjPljqrxEk5Yz2k2bOqfX0bXE3U
	 ga+MSsgZxDQ8UNx6L6jPRhj8h0kPWASYN5YFiW5wz+ANHHbg7+qxYB3gHfm6NuiySgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ct+xPY1D;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CCB60A3808
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19CCB60A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ct+xPY1D
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91eb53957cbso45070916d6.3
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640217; x=1795245017; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
        b=ct+xPY1DtrgxmMmbnkPvgL1GWioCTi+9p2OTv/ztfCbmWwkjPS1I+3ksuGvSee835w
         U9re8UM/a+pYtFYHz16ITdxCKQdq+HcNthoG0ZF50l2qVXMLSa8ZGZSzBkuhFM+rsMjQ
         PYBRnxDNSmJoAHHZjI5vCetUDvPcDpNCVXgGYFMwh9WtAYFM1756y6Xb8BpR2r33FRa1
         4MH+awbHQtGGrjfOidNjbxhIHFYhbSj+S8yPBYBcHC7jHOK3ce9MeT9RWSirelgSPQoM
         gSqaE0Qtiv10Ru04GqCbABUq6crFfbN1pF8Ddr1vBPebXeVTOnX2rVu8UF2hwfXFtUSV
         R9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640217; x=1795245017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
        b=jg4TgPoSdJdsSpVx3o0AF4JlpwaWuefMRU40GXEXvzm6GnlZ8lHniFnGRXWAEkCk0J
         CnsEpWELUrM1bqsz38xKWmOmS7jjMRy0KW8grIYwCYazqv48btBokgd165NIQe2AbtTR
         XpeVc/7ul7V/nvxlEgFKQ7xBwgln5yLHF8W+f2r81ugXu7tEHzbMFHPEIHxx311V+JsS
         vy5nLJjBZvljYJy4svEjeeep1alpRx8ciILaIxEN7utjogXm+nzUDTw+eaNu0i6zGru4
         /cuECEyrdEy1CuK/zXFrwdny7QlolNhw3uFxc9FChTat5Li02cAY7qt5HZj8YgsJGyFH
         6UdQ==
X-Forwarded-Encrypted: i=1; AL+hErEYZg2jqZsktHF/oXyNFAgyOIb1/QjZsw4RloI5xkG72tXBb9lvMU1R0V6S/ZGZoEn5jsAYTw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/SycBbTwTXQrhwhrO5T+rvqmx+dtaLVd1vTKH6BGKm7kzyrCxL
	Mx3smONqshTZunlMgUqCvZLVzZP8ikHUxfAFxJaCCRRtusbQTMIhtIOFnej4nQshTlQ=
X-Gm-Gg: AYBFou2To+0VnmrgDzciWeil8qD8C79J0ZwG2ZMm2AC2eh1MXGP1HeFoW6exfUd8zwE
	ke6Lj77hDMOw/6msD1AKOqheFor2CeYc5Ot34NQuJ8Q4Z7Hio3jb40phy4uh98N3UJVGTs4ZSrM
	qym9qH6AyVtVmjJBVeqYEL6BHQAYlQ9yeCY4VmzwD+ZeUhieSOiZcyybhJeM+zvGieyn2WWO5z3
	LnuM8pn7amdBPBqAK99Ni81uGGclDgYIk14i0wrV7wp+yfHP8T8wS1xS3U9eneV4/Qwk0uzv0TK
	QcSTx/2AqtYgDp/yMcHwERD1OZyMI7Me15a0+mBulIvEE0rwUgj330MQ9HrTyQvtT9OMBX5znYd
	v/nzwyu51e1z08QOPqbnA3/N3BmQattYRDWQleXiGRcCl9K6NBG2l33A6oT0FHIjbAYcMSj6R6P
	G0QsSupf1+OgmXV5nWL9ZeEVfDRN/LW+MLdzyrgqBhjsZfAqeSr+2WJ+4jBJhfWmvC+JFi69M7U
	ttVnJ8vepUCUTy7Wn2qO7ydwCGVGHQgu+iPFr84Uej/FwJ9Enysx4wZvHz7Y7oiaRHRBqYePFBB
	TYYZPBOxDR6qTy4V1y7O2lnSMnIz/W/oFSrZhsmA/gv5NyQnaRJY+Av3/D7MMLrzubF9v0Xgpkl
	Qsnp7JFHJImN5zWIilX91xiKEY8rABx6CTdIB
X-Received: by 2002:a05:6214:6347:10b0:91e:cf4d:f868 with SMTP id 6a1803df08f44-91f2420f9c3mr56246926d6.22.1794640216984;
        Fri, 13 Nov 2026 23:10:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:16 -0800 (PST)
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
Subject: [PATCH 06/22] mm: base hash distribution on common memory nodes
Date: Sat, 14 Nov 2026 02:09:43 -0500
Message-ID: <20261114070959.3490008-7-gourry@gourry.net>
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

hashdist is useful when large kernel hash tables can be allocated across
multiple NUMA nodes. The tables come from ordinary allocations, which
only N_MEMORY_COMMON nodes serve.

Count N_MEMORY_COMMON nodes when applying the single-node optimization.

All memory is common as of now, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index b4c4dba93652d..0c076bf5bf380 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -685,7 +685,7 @@ __setup("hashdist=", set_hashdist);
 
 static inline void fixup_hashdist(void)
 {
-	if (num_node_state(N_MEMORY) == 1)
+	if (num_node_state(N_MEMORY_COMMON) == 1)
 		hashdist = false;
 }
 #else
-- 
2.53.1-Meta

