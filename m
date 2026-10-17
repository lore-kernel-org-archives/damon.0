Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF931F936
	for <damon@lists.linux.dev>; Sat, 17 Oct 2026 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792218722; cv=none; b=FoT9CpIOI778fslpK8ImW+kroMLvd2YMnSvWkW7VTHWm0Qnk1yf4/647WoNdgDong4cUDeZUBaNGGYA81az6vMNupyB+flYN4A9lTec+bDVH56ggGnPCzI0yjg1fY1s0OgKUibakWi0Jagc2kqjtH57jX7Ls6V352QWhQDM5nTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792218722; c=relaxed/simple;
	bh=PuRmOLLiOl0vNbuSoX1aqr5Q3nJPu3xcfW6e+17K9WA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+ik9D0LupRFJpZTGOj31TrGbbXb2wjrFTriHnG62t78jAK9B9x+C3h6XkpaM3XQ7T9mvawYCbFGR7q8w1F/so4CLRGfegH4lYQ9k+e653cyNTE8hbtKFSk4L7y4kjaA9PYKX7kNZxfrqzvk1LJr9LXN7gcfLpEtIOohmnmaqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiPbYIGT; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiPbYIGT"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35f1f76ea84so987781eec.1
        for <damon@lists.linux.dev>; Fri, 16 Oct 2026 23:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792218721; x=1792823521; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gFJIItUD6Bm1Jl/9pga1RYfX1oYrLogK7vi+7ExnOlI=;
        b=PiPbYIGTDaqjCrV+AByRXeDtd9hPy3nAQCtDTMm1wLoeJaTyRnJpBvoM62ja+fSkAt
         YImDay1QiU37j1/+lZCPuWga2dAqsaCDTkRLpUthvUMJbOmTgzQdWF5ajV/DZGSqvxjM
         3NM77vxK4O9+Q8YsEJFOEonpFbufIJ8Uuicfou8jcj5YE/JKTiTk2i7U9JoN3q9TwR0j
         wkRcjAWiWv3izQw1CUb3ncd+EM5B7ZvarJu4vxK/ffbHN4A0ukt6DZy/umN2z07xF5WR
         2EiRF3o0yPU496rlglztt4kfeC1FRcHRzeQUr/l0JQwfdHND2uj5b6j/Jga1YB9G+kJJ
         IetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792218721; x=1792823521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFJIItUD6Bm1Jl/9pga1RYfX1oYrLogK7vi+7ExnOlI=;
        b=lcqTcNlMFy+ifV7c6SepEFBvJx7gjr2j+U/9zlC+++gWZFbzZyYrUHdhfMkIf4T+GH
         YVpr1QlgzaZEPiYALOGOzD2PAlRuHrkQiAQ6BA+/0O/jVizc2uMf2oxNWWymPvEq8eti
         quxziZLis3bKDnSe8uFCyYDrZ3WShlpf85wtaan3NIl8X6xV9hCn4Z5f/XwyIl/DBHNW
         qp9VHQXJBjzZ415P9Z7dnjbFRs7MCRRZ03JckPFL5Ue4v0P/fAJwBAYwLgK8O44vi7l4
         qizKcvnE+iA/mhUBy3Ljdq9geWKOi+ImWPv3KMFazI4hewEzceTMwhHjvUwbvDCiAlQN
         1P8w==
X-Forwarded-Encrypted: i=1; AKwUvBz+pm8YhrPoKDMcNW+tqVNaxsz2frTuwihyCntLSFTyT/gRctOLWeW4pFX2o7pFaZn1TmqTqQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIx14lZmUo3bpK4Su/J8tXgMEpMQBDnZb1aBORMb4Dez/He/j2i
	ofZrpoHKoun/vA1L2rrusvagzy/Z6q2hBdZ2dwzPKECI1uhUEIq3Shq+
X-Gm-Gg: AYBFou3EzPVhV4FWzEUYsCuOHSnklB+Z8lx9W/K1XKDe55JjXLEDbOajybWpxzmtHE0
	8DMqSkZSwOCoXFitPezJw8PbAPBV1PCoBwjGH5GFos25tBY0sHPoSVt4+bazYwn37rOqkfz1wqp
	7xf5jRkeAkWcsY7/NfmDLVkr8Gov9bSI1uZelCIogp/7EQeoSiiUFZsRiMppqKwUGssMtJx2r5N
	+wnZQqSVrtyGegzKi5GlUxfkjBNAUKt22oMRxLcsJHnXoia/+C9BhmQJi40wwCeVDXHID0OU2fc
	y9ZZjn/qAT5unI2X+g+3crykMA4uamd5HaAgVjM+MgaE9eMl1TDbvdpAk0S7QS8YppFhjGf7EhG
	7UlzltPUgdIPhENSXE3PF7AC8EOrcbR20awpJsTYpqPwrv4BJH26c4iDUQgve96EhtKEp5U0URx
	TUmDb1ynORz9nWXcwko88rfDrfisK8iv4YvxjibvkFXtwuPest9/DLJA/bn/6UmDjhKDh0chIK7
	O5fcDNTBM7JBoR/uHwqs+KBkbkb6mhkgNE2EPcScNRhdWDXFEIIP17+Wo9MIQsMbzdP6uISvH4x
	Mc1W2pSr9zX2ix0GfiAur3r5E6TUvsWCRBaYLbdXGcOhnKlFtg==
X-Received: by 2002:a05:7301:428c:b0:359:525f:74cb with SMTP id 5a478bee46e88-361a195b342mr2373779eec.24.1792218720406;
        Fri, 16 Oct 2026 23:32:00 -0700 (PDT)
Received: from LAPTOP-97G9G880.bbrouter ([106.51.148.253])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm22374749eec.24.2026.10.16.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 23:31:59 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>
Subject: [PATCH] mm/damon/sysfs: make next_update_jiffies per-kdamond
Date: Sat, 17 Oct 2026 06:31:52 +0000
Message-ID: <20261017063152.994182-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_next_update_jiffies was a single static variable shared by
all kdamonds, so with two or more kdamonds using refresh_ms their
threads race on it in damon_sysfs_repeat_call_fn().

Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
Testing notes for review:

- Found and confirmed with KCSAN.
- Repro setup: QEMU (x86_64, 2GB RAM, multiple vCPUs), two paddr
  kdamonds, both refresh_ms non-zero. kdamond.0 watching [0, 1GB),
  kdamond.1 watching [1GB, 2GB).
- On the unpatched kernel, KCSAN kept reporting the race on
  damon_sysfs_next_update_jiffies, again and again.
- Ran the same setup after the fix, KCSAN still on, nothing reported.
- Tried the same with vaddr kdamonds too, could not repro there.

 mm/damon/sysfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 160292f077dd..872b89f58bd1 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1789,6 +1789,7 @@ struct damon_sysfs_kdamond {
 	struct damon_sysfs_contexts *contexts;
 	struct damon_ctx *damon_ctx;
 	unsigned int refresh_ms;
+	unsigned long damon_sysfs_next_update_jiffies;
 };
 
 static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
@@ -2215,18 +2216,16 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	return ctx;
 }
 
-/* Tracks when the next periodic re-commit via repeat_call_fn() is due. */
-static unsigned long damon_sysfs_next_update_jiffies;
-
 static int damon_sysfs_repeat_call_fn(void *data)
 {
 	struct damon_sysfs_kdamond *sysfs_kdamond = data;
 
 	if (!sysfs_kdamond->refresh_ms)
 		return 0;
-	if (time_before(jiffies, damon_sysfs_next_update_jiffies))
+	if (time_before(jiffies,
+			sysfs_kdamond->damon_sysfs_next_update_jiffies))
 		return 0;
-	damon_sysfs_next_update_jiffies = jiffies +
+	sysfs_kdamond->damon_sysfs_next_update_jiffies = jiffies +
 		msecs_to_jiffies(sysfs_kdamond->refresh_ms);
 
 	if (!mutex_trylock(&damon_sysfs_lock))
@@ -2274,7 +2273,7 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	}
 	kdamond->damon_ctx = ctx;
 
-	damon_sysfs_next_update_jiffies =
+	kdamond->damon_sysfs_next_update_jiffies =
 		jiffies + msecs_to_jiffies(kdamond->refresh_ms);
 
 	repeat_call_control->fn = damon_sysfs_repeat_call_fn;
-- 
2.43.0

