Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640224;
	b=pGmHwI5PevxZoGHa+Rb4wxXS1sAnA3ILl3PgXVCXT5KIjZ2oALFuxXfZHhz1nWrV0MBh
	 hIqgxIEcAluT1JuRCNKm7TLmbbf44cGe+jTfdofFYF9OCVydI/twV1NlaSGsQgYHE7x/h
	 45CI0eujZ2x8mYS46f8coF60codgLDbrzFfC2Po76MwKsZOQnmVcTPmaybxPMyEM8nSaL
	 GSIpxZNk19rqhUVTfLZXX/lIzpuOdMmwV/Hln1pjbWW7tijM5HU34aefVFO0cBr+7pvi6
	 2rWH/3n0yaZXJhnB/kzC407bzMONzeWVfMvX/yxWOBSa+kfHZVEd/7y17fpSSsna36Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
	b=Z6WHuZU1l981XAwDRdIFCUn0U2PMqluq5s14wlHgBtgObMmqdE2mckazyAhZ8nn2F0l3
	 /XEjHlJ8O2vivJwVcttCf1lYgoQIiFRIYdS/7TbfZkp3TK3h9PrhupK5AhvsHoYEvTPDq
	 o+t9jHWIXarNHTbNsoHpMsddqx7ctqLsEeD7MT2mrt1e6eIOhBsgBUJMjuuq+rsdk7rqP
	 x6yTnyj9UIvk/ME63Pu3PzHs6EOXkNC37DhN7kfYEq7ghW4jWzZ6f8zV4KOlT3/B7jb9j
	 toHDyJa9A2i88Zw33EOPD4UV16A/6mZmCe3feYYFGIP+Pt5e0C9VdVCfClmOu5jRx4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=IFTtneFL;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DCC60A5BCA
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24DCC60A5BCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=IFTtneFL
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91ecbdf5343so39949116d6.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640223; x=1795245023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
        b=IFTtneFL7+veifXsxC+OpNGyBlgx6LrOQkpA0/qVDJFWbcJ4Qv+0AjJu4ZJMrGjuBE
         ZedLAbozimZyftcMDNw6mwMwp9q1z7UA8+3lTLcKxWWp3ifdP+Jc4GovUlruYWDmJHf6
         5rzt5B3e7gyYCTN6VqQe+2M7CXRye8d6vNTAC1Zh19D+T8hqtCycDjsynZGv8i46xYVE
         HCRV7/FgA/yPKZGMavUKUPMNeB73ZxTzwqLBDxz7vDSm4aLeEV6P/yY0XBxAJ8RyEO+7
         I8AGRTxpo4FBr0uGwVHIxna3ogU5xGlChOkq48ocXA2cj0+Fesi4oS/eHBnVgQyU/7L7
         xTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640223; x=1795245023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
        b=MrUwInw5e9eEw5nKOaeTgMdlBzd1Mk6bkB0f0VxsQPPD9XmT027eLvr59LFsGgZX97
         RIYzRrVDLB4QoKiUmBjQZ00cZO+FPWrs+VI+bVReyHMJtLVM3Z9/N0ADXFE4Sjupiffm
         2u6y+LfzQsqCMim6fFRutST6S2U9hA86ligP9dYBZe4WfYns1crnn7zY6E66wifi1EJQ
         3SHIxrSm1mPFHAm/i0cFLfQhI73N7XtSTeM/mWXp01ZFmRSOeB7TmsW5J4Gy/+QOjW5R
         lF0+D6u9/Dl4bbzLnbJrsXh5i31gXkIN3lYmUYtJLQGJtJqH4dlQRyJ/BUx+yZIv7k7M
         fPBA==
X-Forwarded-Encrypted: i=1; AL+hErHr3r8P/sLg4A9Hh+18fz6+eyFdI0AxfwNxtwzDZKy4hnm19H5fSzRHJoXqmnrvFGRuF7PXEw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+zNw86DG2i1T3fNJijqi92SINMNRpPBV2vEQRX8P5hfvlTrK+V
	2QyX9u0AJkAsiYHFWzqoH0UucdWjDXekLe1lEy6Z2yDLTqFjkT/vTWM0rXD+C1WIv5s=
X-Gm-Gg: AYBFou39X/VPvD8/Qq6wz7gbq8dCMmfHzpJ+hEeriScKThydec93NWeXDgEvWoM7qfZ
	Q0kDIBG7/zJKDEefCIYhaOpDXdsUOIa/zhRUa3y+cFV96xQRGOeL9AI+72yINW8XppvgT67XPfp
	dQThNcES4AmRiGCiaFtSi2e5sAi8B4Krve2/j9EDw9V0dzGfA8DxF0mHRI45WN4raUwjed5E9if
	F5yevCteiiqOudRmHtKvhnDGY7o+RJrkj1KrWQmbIW3fwShM5feDfiI7BJWoJeGuVnTCz9EeL/v
	/f6rkKLZFWEmQJj4eGOCuHIU0pNvr7sXukylhaZfpdvdNdX9XGCVcmifi35Dy1RXND5ARr2jq89
	MqsEWUAqBDyyTxfUitMPT8tpVGwji6uLilxVNQq1h/nN7XREWhsux+V/TyA1RHkTfwRQ645llbR
	ntKwxFUeZfIcT20TB+GfZIXEqOTxHSA31lYEUK+hIEaZWwK0YNMnRUUTykh8jZLPtMDluM7M029
	1daIrZjXitGqbpc1tOXcoAI75TB79V0XuLZPppVAsKSbiH4Dhjx6UckYXmsietFTwGh+evkqHyx
	7QRd/kdxWvqsQn1L7xk6N1idMMD5EA8wW2ehojJwCzjd+qE64Ak8cI3PGGKL2zVFSfw4nAmPVkh
	nOJSnB8zlFu3D+CE=
X-Received: by 2002:a05:6214:2462:b0:91f:3182:e94e with SMTP id 6a1803df08f44-91f3182ea72mr35908656d6.8.1794640223087;
        Fri, 13 Nov 2026 23:10:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:22 -0800 (PST)
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
Subject: [PATCH 09/22] mm/ksm: restrict merging to common memory
Date: Sat, 14 Nov 2026 02:09:46 -0500
Message-ID: <20261114070959.3490008-10-gourry@gourry.net>
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

KSM is an opportunistic MM service and should leave memory outside
the ordinary memory pool alone - as it already does for ZONE_DEVICE
folios at each acquisition point.

Use folio_is_common_memory() at those same sites, which still rejects
ZONE_DEVICE folios.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/ksm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 623a2cdb39242..25b2c2f944862 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -831,7 +831,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
-		if (!folio_is_zone_device(folio) &&
+		if (folio_is_common_memory(folio) &&
 		    folio_test_anon(folio)) {
 			folio_get(folio);
 			page = fw.page;
@@ -2571,7 +2571,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 				goto not_found_unlock;
 			folio = page_folio(page);
 
-			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			if (!folio_is_common_memory(folio) ||
+			    !folio_test_anon(folio))
 				goto not_found_unlock;
 
 			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
@@ -2595,7 +2596,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 			continue;
 		folio = page_folio(page);
 
-		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		if (!folio_is_common_memory(folio) ||
+		    !folio_test_anon(folio))
 			continue;
 		goto found_unlock;
 	}
-- 
2.53.1-Meta

