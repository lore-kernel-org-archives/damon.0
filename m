Received: from mail-qk2-f5.google.com (mail-qk2-f5.google.com [74.125.230.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E25223336
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075980; cv=none; b=ugxSBs/K27kc/bZxlNnjoEa4YPD5MXSAEJOfdvsIRzMjgOCMRihfoQbbrlIE/HxGUK72kRkafaU6faf1xydDCvqyR9XjrPEq8+gBQhVz6ejJrVuQf/HLW4OjEEZ1EoBoU3XgdPW+b9e1d+5SxncjtCO9BviTtorMqNgnGvR1WqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075980; c=relaxed/simple;
	bh=R+lQIQY3eRefZFRtmkfz2M5VPtTBdh7wpJqwrh185z0=;
	h=From:To:Cc:Subject:Date:Message-ID; b=LRodhfBUzgzXhEs++s6F0u+XamPukzCNf9akR/SOwHxPiyUpgFH4TcxGYFGDUPQrGkndUXw8+ntC1fDMitK7PRw0Z96Uc4FSG/vlXau/ezdYa2lIzSw7qpEiYlditoiN+m2YkQZ3kexAUQJlofU5h/YmQi+sewsS7dlCc2Ur7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeULppYq; arc=none smtp.client-ip=74.125.230.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeULppYq"
Received: by mail-qk2-f5.google.com with SMTP id d75a77b69052e-5337b59ef7fso32484161cf.0
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792075977; x=1792680777; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XdRcwxlD3pWCchI2KWHsVI/091IqM4MFlf7NS18N65o=;
        b=NeULppYq0cJIVYV3BJ6cmgWqHYtM6n8FbKHH1ZJqKPL6ywIYrbOprwGwm7APH3g8Tg
         zuRQfK9i1QLbBSf8KpC9y4BYSQL++yAHGuK+HOyopeRmAbNXeK57z6FMHRW2uPBHy13j
         oGvqvTyLq2RXGl1swmhxsvg5l09FEg5bhOZ8z6hvM3Hj0eDHB097H8Ol3hjVRqSpnZKF
         Z5hS0tpUFSKOnNam/MQRmP7+qp92xqRl81gZDRlYsXNR3xYKffMk13EYtpZES0+lRweT
         HhS8clsNXIpqQEZZvfdhHqM7cqATvk8Dd0HWNK9pm3EFVCDAIGYd1i17Mt1XRPIe/Mok
         KlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075977; x=1792680777;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XdRcwxlD3pWCchI2KWHsVI/091IqM4MFlf7NS18N65o=;
        b=Dj2yZltmdeaKt5VlW83J1oKGg22Z9aWAdRgUtJZ3AM/93TrRBXaM9JfJt9mF0d+6Fz
         Wq4yCRWAVju2KhkRa6XoZcOFDXDzlEm9sVBp9UgkfvyUPwuBZYQSL46iGnUm7cdFVr4a
         xIyDE8dQ0WMuDDz6fsbqp3ShqEou6ZHJHTbr8RBeZOQKiWwhfMp2uwD4+3iRPWHC4TOd
         NAxdsmCe2f7vWdIVECiONzs2nQfyndHDqNreedlAmFxWEJ+yjzzckJEGrUrLqbzjANqR
         0rPo3JrKDpTsMjKtLOI4p71erdxxTuCGtSV/lVH0bwBKOEI9De9Ig4K5jJ9KL+kRm3c/
         8tWg==
X-Forwarded-Encrypted: i=1; AKwUvBxS8kMwNIN8KoFw0iIlOFkfTz7C54WYBwsmTszk+U6mZ3Bwnik12wyM9I7mWN1ZC0j75svemQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIpncxVS/aIYCruoNFeIV5m09NsizsuTQlL+NrsV4m9EIvK+ieg
	ROPt44A4jPeDm08hDmVeqHNpE66MdVfF+zhTv75fVAz1LCnXyihqDcWb
X-Gm-Gg: AYBFou3bdPldwotkkfmDHGVXUL9WLgFYIwLsxjy7+ggDzZB8006VReuseeHAMtX3C8s
	8BeG8V5ESO4E9X4NMSIrFIg8abJVkgnAf58/H2Adwr7m1+FNzKzW3z9SzWbfj7C1ClqA6Bi18dv
	YhSItCeN6oGgQr8RYlBFyEDZZEqPNKfjbcW0q7jKgeDiQA8qy3QJXsKDUZY+nZ1vgpEGyKlWvSi
	JyLeqhTuz1Js+UAeOKvhW4LzkQvW7E9Clgb5y4fD2o8GJVb0KXkCSSuag9yyCZAxAxZX8PWxvxi
	5NXMLT/eG7/En0hVAdFnguTeke140KBKh97oSFuntNBOmkEHvS0o4t6Q7m1EH7BCmA/CzE+iDMx
	MN9b139EdUCK+z3g5yLLqyKXkMTE/ZuRVv3zX7HViVWDW+ixF5ph0GttSzWx2So04wJdu2MCiWR
	T4/4mfOa9uOp4xCqPJ2CbtY1VMgRdmxEcG40VnchpIen0+nDz39U8cEiiqa0gSA+3icHn/FAEiZ
	GDeYXL8WnHLeitx
X-Received: by 2002:a05:622a:e19c:20b0:535:cd9e:bfc8 with SMTP id d75a77b69052e-535cda027f6mr141795071cf.77.1792075977484;
        Thu, 15 Oct 2026 07:52:57 -0700 (PDT)
Received: from [10.131.15.42] ([115.200.102.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127c62d3sm27173261cf.15.2026.10.15.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:52:57 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/stat: avoid 32-bit overflow in idle percentiles
Date: Thu, 15 Oct 2026 22:52:04 +0800
Message-ID: <179207592479.3.11595453180868898703@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

On 32-bit, accounted_bytes * 100 can wrap before division by total_sz.
Some entries in memory_idle_ms_percentiles then keep their old values
instead of being updated.

For example, a 256 MiB i386 QEMU guest reported p0=19200 ms, but p50 and
p100 were both zero.

Cast accounted_bytes to u64 before multiplying and use div64_ul() for
the division. Compute the percentage once per region.

Link: https://lore.kernel.org/r/CANOyQmHad1vamnZT12M5yPrJ69==Pt1U0+MGw6u0MuNtr-DRCw@mail.gmail.com
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
This is against mm-new ad9f2d463666. With the fix, the original test
reports p0=p50=p100=19200 ms. The i386 kernel build, x86_64 W=1 stat.o
build and external arithmetic checks passed.

I also ran 38 before/after VM tests and 20 same-image controls. Throughput
was close overall, but median kdamond CPU rose by 0.0053 and 0.0221
percentage points of one guest CPU for stream and sparse, respectively.
Some pairs had 5.91% lower throughput or 15.49% higher scan P99. So I can't
yet tell whether these differences come from the patch.


 mm/damon/stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index b05b68f73e10..eccd372810d0 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -114,7 +114,7 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 {
 	struct damon_region **sorted_regions, *region;
 	int nr_regions;
-	unsigned long total_sz, accounted_bytes = 0;
+	unsigned long total_sz, accounted_bytes = 0, percentile;
 	int err, i, next_percentile = 0;
 
 	err = damon_stat_sort_regions(c, &sorted_regions, &nr_regions,
@@ -124,7 +124,8 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 	for (i = 0; i < nr_regions; i++) {
 		region = sorted_regions[i];
 		accounted_bytes += region->ar.end - region->ar.start;
-		while (next_percentile <= accounted_bytes * 100 / total_sz)
+		percentile = div64_ul((u64)accounted_bytes * 100, total_sz);
+		while (next_percentile <= percentile)
 			memory_idle_ms_percentiles[next_percentile++] =
 				damon_stat_idletime(region) *
 				(long)c->attrs.aggr_interval / USEC_PER_MSEC;
