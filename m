Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795045819;
	b=ZVuZuW988hGTaZ0h+yoU/+Ty8JOwoAUTCvwapXNpZUgswg49bBaEpZIQ08kpqNtZnwhS
	 nUX7F78T3ufI9gAFZeKOWGA4z3mj9VNGnWbTkaZgHQ4J9j5kQSm2HcUB0yS5qsySIoeic
	 Ud5c+FrqEDfzelPqTjtw7O4573NyUHQXII9YHrgUNtyt3EfxHBrvbFUw3Sii/3EZpv7Cy
	 pCrE/g/7WdQ0gGPDWBqJbVzAYyaQpVXBvjpMKEJZUSH4wP2NxZ9vkAAXIaDn8692c4pGz
	 5T6vXTyKM6hUbnUaIYbvZEbDcU7RZDm9wzH7cfTRLnEdZytCFob3QX2RgSoKmjh4PYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fduH1+3PZ/9MoDFOHCe3dYefomwFptmBxA3+ByWc1yc=;
	b=dsNOL6NUXJRWoADEfCfSgkSNCBrnai15vMoy1Xh1c0tPBBrf7ywAO67YZrUxXeHeSw5i
	 y+wL5N6wsq9EXyQPq9uqDKxNdhvzrIw4Zn1uaQnX2gx6hGGWS0xjFhR4zBS++UB9N/03c
	 +vfpDJi8T/M9YZcLW3jcEfT4unS47wgksVMEUDaz3nDPPsPCFOOxFc0IzK+UlDEtucdg7
	 QLqNScpCwQV4cFaxg8yONhyVLrhczfxBUiyahkgjsq3dOu+rJfLMPJJE1EIyfTGn+tuX2
	 bPO+e3YaaVTigGKbfKJWqOZAJ6tvYMIg9No6BgHDJwYdtiPYmodL0rsNaU495eGaGJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bBgmbPhD;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9E606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 23:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C9E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bBgmbPhD
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-844a8bf7e25so1046571a34.1
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 15:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795045817; x=1795650617; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fduH1+3PZ/9MoDFOHCe3dYefomwFptmBxA3+ByWc1yc=;
        b=bBgmbPhDjBs60oHPCYZouMiGRYGtpvdQOrxOmcmynY1kbua1gXeb/dO/WbpYA5C/G/
         EZk3DLumH4FCfC44TceDroP4SkeK+3mCqOGhtGDlPxwKagwQbNfpeGIFXntfuD9aPFyf
         cAt1awn53adXEofCcMFEvUTffzO4r5tP9MLllfZWTnCrNTesNtsRBO27VYtcV3rb3Vcw
         TJfe8j4oZkQGqNvscK6pR1FL7Cs2g9SoqtgE36qoUDcX2PgC3j7pcIuaLi4SiCcbeyG1
         HosjaLLevPhoROBonX2oONy5Tm+2AdPI+88PAs2ycgIBgZG35SfI4EefYRfnhC0OlJ4u
         EaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795045817; x=1795650617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fduH1+3PZ/9MoDFOHCe3dYefomwFptmBxA3+ByWc1yc=;
        b=BV36/vtYIjUPVCQTXrLr8aDyCQoSo6paeeZLNCQkQzZsCn+kAJuv1Vq8F/IlP2sD4j
         cw+XtqZMCtxX8eO0UCU3YytqJumJjPPkeD5TXTOGRgx5HwIhEgVyFR8YIdKjGpDTSRDT
         wpxR6IFi0URRs3Ywa3n4tELxIoSYjzrsQEoCRtcCP4hRVhKgZgMuv57HpNFF++mk/jTb
         pVciv3MGa6whfrxiq/z6AUIsvGFOUJKzHMDzs0pFt2daE9rvDYqMBcvmfbn/+MzIdlXz
         iRHFWGBHuzVo2kMTfv9NPBibwk//Q3i+Xlej0Zxet9AOIN8EjoVs+FI8m1NtRmpqru6Z
         n5RA==
X-Gm-Message-State: APuU4Z8YNI3njNmoieeVcOZ/9dyTDKpxM4UWFMAbNy4fHAPn2YnEX0/X
	vwrNFsKmrAhUDqmqkGYvVoasny1/0bB9fltemE5IbpDs7RGn7it3jp00
X-Gm-Gg: AYBFou1P8+uIp1o6fPXcNvi1V8L3P1mXQxfO9Cq6U/m2rwKDF2j4/Eg73mBNA1/8UxQ
	DToBdtkiJa5NBzzjGAiZCpFgsvOnQ7NT6fOhuFosj0JtAL/Ad04KSWSv43/kx5nxcqMfaBhgRGQ
	hST+pVKH43yv6C3AiH0KM+jDnklyHZ4ZVCD1xnV2xzlee+7UTQ9kF7SdTu4g5x1nsyjLw5lGpdF
	ugTbJMd/W0vP3tcFqzC84FbwpkeQYY87aHAU/k5J38HtwvbiWwZ/kpJ87bfRx+yOJpf3OQP/aFm
	W905wXbgo6YTQyv4wXb3Fk5c2dFvlVvWKetCwSddb6wEboSNxDQ3nke3FPOgLptjZtNawJjLMLM
	sm3/riciZvEevZoWKp8bjkz4pMODNpnJIGT5Vpp5K0QjBtePA/fn/g4VPwA+igJI5TKhGbxuAPd
	PlJJPymW/VRsZZa/IRiHiCgnRhGcHvYehdk1iD14D1U8lQOpxQ9xjVO2gK1DyBkil1hqcaHbuM6
	uvEA/eosmdDmzzr0dmzJuKqAHTIOfZ3aquf2EbL7wWnMgottDHO0apJ3Y77BjNYOXWF7/C5Rtiq
	+NVRoIdf3sBZdMznqHFL1GCrDX8JOXUj4V3XjaPF7T1qNDABJhPhoZio/Flk9OSnSOMb39aiCTb
	6hHQleyLl4+wvwzJevOZZ0KCDugOW5PrFiEcahQ==
X-Received: by 2002:a05:6830:254a:b0:843:cc20:9d07 with SMTP id 46e09a7af769-862f093b805mr5979128a34.16.1795045817527;
        Wed, 18 Nov 2026 15:50:17 -0800 (PST)
Received: from FKXX2DL94F.bytedance.net ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f023a1c7sm3148912a34.23.2026.11.18.15.50.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 15:50:17 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: fix damos_walk() hang with zero watermarks interval
Date: Wed, 18 Nov 2026 15:50:12 -0800
Message-Id: <20261118235012.14859-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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

kdamond_wait_activation() cancels damos_walk() requests while all
schemes are deactivated by their watermarks.  But it returns without
waiting when the watermarks check interval of a deactivated scheme is
zero, which is the default of the DAMON sysfs interface.  The kdamond
main loop then runs with all schemes deactivated.

In that state, kdamond_apply_schemes() finds no scheme to apply and
returns before it calls damos_walk_complete().  The walk request is
neither completed nor cancelled, so damos_walk() waits until the
watermarks activate a scheme again, possibly forever.

For example, with a scheme that has the free_mem_rate metric, zero
interval_us and a high watermark below the current free memory rate,
writing update_schemes_tried_regions to the kdamond state file never
returns and cannot be killed.  The writer holds damon_sysfs_lock, so all
other DAMON sysfs writes including "off" fail with -EBUSY meanwhile.

Do not skip the deactivated schemes when deciding whether
kdamond_apply_schemes() has something to do.  damon_do_apply_schemes()
still skips them, so no action is applied, and the walk is completed
with no region for them, as it already is when another scheme is
activated.

Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
QEMU: the write hangs before, returns after; kunit and 13 selftests pass on both (2 need drgn, not run).
Found and written with the help of an AI coding assistant.

 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b8678a53b0a9..12578fc3280c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3498,11 +3498,11 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
+		has_schemes_to_apply = true;
+
 		if (!s->wmarks.activated)
 			continue;
 
-		has_schemes_to_apply = true;
-
 		damos_adjust_quota(c, s);
 	}
 

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.39.3 (Apple Git-146)

