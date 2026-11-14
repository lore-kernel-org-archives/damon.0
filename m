Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640236;
	b=ThMNpjmJElWpHA4e7a+6/Fgu9BUKCafR4ZVgZUPhAHfdx8pX7/9sbqkjzez0/RtKQmMg
	 DpHTkRsFqg8rlxip0oG7ypL9JZzZmaE8bF7sMKMO8hF7HztNzXCRUIAKdYruV+MmgtFjf
	 zxilYQoQAV02lzHZTUqa1CKEDo2E4DueTrmLNdADw5fYKAIdCYXkI//42t3IZX6vwWD/C
	 wLXegHE02agGzQN82+QUm52AJG0sBxGFDvucguSn+zwIRF/kERwNp3MnuH9cYXP4u6Kla
	 WlNtBKCAoRv4MtD21t8BgUAunzAcyIPYvsa6rKbxEptAeMmOvUZ0C5y1/rZJDYnR++g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
	b=Y2ZyWoRM7am5OPTVWWaKpHpFmKE1fwvlH27ziylqohXPPZzQjTL0Thhs5Yhuzs7WbCB0
	 cHPpiHUqxsmibspGLcrG5GO7VDicmnctz04EQtI1hwffSZBiclhPk3WonLKj2/x7rBE5O
	 9oLdb14YJemvUbcNIbHDg+7IuBBgKzBOq5FPnqqMrfW8NGl9iM4S2uQ1EwqTkfkiJsaxh
	 K0AFLhnSXn0KXEz9f8JNC13J7lzZaJQE5znHdwE0XdHpddfsIgQUf0QNTynOlA1UL38DB
	 J2NT8Q+eN1XjluFwpWhpIr0UmZS2ZFMlVPkOJzqwbGQmeQrPhCBB6HV8PpvGcDUc9Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=CH4YjEA5;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9243606B41A
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9243606B41A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=CH4YjEA5
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91ea0c05c92so32026926d6.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640235; x=1795245035; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
        b=CH4YjEA5/pPUBd3brO40Ys0VFmTUV3nhKoRHUhyuyj02EN0kmlgS5D2P2nYpN+dfaU
         Yca4qMpyP84ibJto4/MT8P5wmtILf3YFg9vKMVVntkByv7rcb6nc6MaQReNFm7KUdd9H
         PaMVRpYzoqCiaWoJNplVQx6a1C1sCQqyBbkUhqaowhRtQ8INIwE0R1bluZabK4aAaxOQ
         ezxRYTGSaMfJS/bg2Sl60CU3dgh8xZoa7LVy/QAgvF0xMBADXvh2vAp/AuShfDBdZXY6
         AIAQO3vKsJKZdSGOo7wEwM+ZS62EVXwTtKJOuFP/3m1SBL9u/5wsnhVAPT6LtYEzktpO
         lA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640235; x=1795245035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
        b=P3viZT97MV6FCqZV6jxlskiLKi1/XfKGtySOEvA6wS7Q3/KgawvNAMo5xOSrpDiC4m
         mLQiNIGGEaF2+ucA96EfJMyF4AoEzJcPbbHdKv1bjWM8V4SQ7oduCFQo8TKaCjnH3YLw
         eueAZJdVfLq7YEzH8W2r3zgQWBaY5EfwniwSd7M2Iky1rhNNyJ0MB/BHwM8MlhZYOJ11
         Bh+lCUAjDpSb9gssQME/LcdM7crxw90YcPp2ssOS/MYQOn60MJ5NmeOTr0TT4fai7j39
         p4mHZZzEDpdu6XJAyQ3DIRp9rg5PnWiMu3X5viKkinKUBwx5bcS6GWc8TsV4sqBBLR2T
         5oYw==
X-Forwarded-Encrypted: i=1; AL+hErHz+E2iUwbVqMesceQ+PqLMdldynrsoQ6+dxVgSzExa03uOxpRrW8/PB5KS4H0/9fFLp9PE2g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+x/Qn4aTIlPjxm+/6uvgFPM9nplRKTOJykrPQsc5Sd3fvpfhH8
	3h0hQi2oBEuRq9x/6YI+3mIPQ881RZib023zP0B3c0zw/WwwpcdAByfN87sCtIK4dus=
X-Gm-Gg: AYBFou1ncoYON2EtY+nuZBHJpC5IuM8WrCZVtWPQSP/JIfAvAKtXmLQf58uCylhiT3U
	SkvvcGzh6MThBwSAVD0wk13b90ypivFJQejhtHbSovv+pu3vMZdXHuNHIfXv4S6CkY7FkeJPt5p
	9BWNKcm0dPNz9k5AoXMWnlaxpeDbCywcHAO9d/4HhlRGGfsU6igcbMwDHspKQJlza0kdAYPLUpi
	Cjv7p/10NIFoF4qQux6w7xSbHnlnuj6AdBq60ZTjTvQmNyj5AW9bML4v46sm0byonZOD007fYK1
	x7XBgJwf8r/cP7p+TFxq+RelR+mpjyishbjiXG8MJVpKVKb/1PyL41uJo/ScTRC40JSJ9WyWzJW
	MRZ3ZUI/ZDPSrkBq5hI64ajGKVBcoEkeVQsib/Itc8n2eQ4QME+P8Jw+18a0Sc/pIZEi4uMexvZ
	Ou8I15nrdwL3t1Gdi8MMssMKaud9WUdDnWSctdE+J2QdK3irnkVf8qG5gUIIymWMccslqGrKgxw
	5IHh031qFSqpOXR+kWtOYAZn4qA+N029KU2DQrXmMPaxSMOTOM6TOmOl1ZR7JUZGXtbjOqFhFGW
	LbI2TTIPGlxl8jQV1p438p+XFY2FX3GBlSUnvxU6jF6JsIoOgdi5/PdKCLfJt1gI6C3KM3Fnsht
	tk5EFaAq0dfWiPMU=
X-Received: by 2002:a05:6214:1d2a:b0:91f:17be:7c90 with SMTP id 6a1803df08f44-91f2424c199mr78511936d6.55.1794640234508;
        Fri, 13 Nov 2026 23:10:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:34 -0800 (PST)
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
Subject: [PATCH 14/22] mm/page_alloc: count common memory nodes for kswapd recovery
Date: Sat, 14 Nov 2026 02:09:51 -0500
Message-ID: <20261114070959.3490008-15-gourry@gourry.net>
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

When a zone recovers above its high watermark, free_frozen_page_commit()
clears a hopeless kswapd state if more than one memory node exists,
since allocations could then have fallen back to another node without
triggering direct reclaim here.

Only common memory provide fallbacks, so count N_MEMORY_COMMON nodes.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 580feeb608b7a..6d98e213460a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2949,7 +2949,7 @@ static bool free_frozen_page_commit(struct zone *zone,
 		 * kswapd work again by resetting kswapd_failures.
 		 */
 		if (kswapd_test_hopeless(pgdat) &&
-		    num_node_state(N_MEMORY) > 1)
+		    num_node_state(N_MEMORY_COMMON) > 1)
 			kswapd_clear_hopeless(pgdat, KSWAPD_CLEAR_HOPELESS_PCP);
 	}
 	return ret;
-- 
2.53.1-Meta

