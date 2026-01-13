Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5338F233
	for <damon@lists.linux.dev>; Tue, 13 Jan 2026 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306642; cv=none; b=c826i7sYpYf5ENiSk0mq7CPwaXwnrPaJmgKqaDvaenGLItsrObuJDOzcnIYHkBQvG3piiX8TCn4OEa2zscvYoJevhOOzeiYtsAZSeNp2TROiRKIroX2hgLgfgfy/UUgggOlmBBk9Cz7qkzfJBQtA/imgI/ggNwa9JnhYS3XVx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306642; c=relaxed/simple;
	bh=9OmQe1fMKYYA4SinN8SIb2wYoDcsKDcc/wBBSjRQZQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAJifJQ80TaY8qe0wxNu5N3+hFGJ1plkkEqWGK8wpXY1IUm59pvFoNzf1cVuuszWxkgGWO67Qr6W2c0K4Aqot65M7u/ChmVPJMAvgzRTlwjZkq7Dsgdih1eKJCmV2olNqFQ8AVQ21RoRXLM/1R/Qb2g6jyMPLDJVV7VDjNXU6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9oKexiD; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9oKexiD"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c2dc870e194so3876389a12.2
        for <damon@lists.linux.dev>; Tue, 13 Jan 2026 04:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306640; x=1768911440; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DabuHi3K9u7UKNn7EoClhxIBJInkjBMtz9wL6ThmFfQ=;
        b=Y9oKexiDo1767mR9nnLS1drKr0vPZQlp6jhsi//c91jcFurcofi2bmi9S3+XZAzBiy
         b8ZS7B+PD38tC5/DJljdq2MkR00KHeQOWULKokpEpWyxJwCWS2XCRb8zF7YCZLlLgabu
         /VlcPzb5+V8v09Q9PuJsXGDFozrIsnSHmtB42p9M6t1VgCVB1EQwJQkHNMneo8qnDVBn
         D7dglOv+sGabHpExc5RyyxoNc4+o5I9TtzH6vRdTLZwXxdY1t5L0Gjh+Sq/zjaR5swZk
         qv5pGxFLzhlm3IUEG5Wbo1W1zJ57/qsxke17/feUUEI1+SjlTP4GbqM9E3jKIvhrxHMW
         83rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306640; x=1768911440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DabuHi3K9u7UKNn7EoClhxIBJInkjBMtz9wL6ThmFfQ=;
        b=J+GdQ0v3JKHz22K2qk0J2ves27eMb3BT4N66bZnoOBUUMy3/pc5nXaycEfhkYvP3Ka
         xf6VL3FN9IeK62ywnvfxW4XxTo0rSMAgjq0RemSzq/uvBCUWlekBNwTLYt5FF7xl78+a
         PrIBfzdK/EpIgji201dtByqeoMTf8Oc5HmhGRScIOlNeDMDvUkQRAO+j9HrSstnw2YfG
         5GO2JKaQCytfpeE7liCQjHSozWxF0Pfae2BGck2AuFY8jMioxbJrK60TLVDqmrE5ZG8f
         E17Ks89nTyFeNCJf6r8NJMyHKENl+79a+9PLUHOXF9oU3qMa0p5w6pd8axu/kjT5kmep
         xQBA==
X-Forwarded-Encrypted: i=1; AJvYcCVCVAFhMV327Z+E375y3zFyyD0uO0gjj/kokyjmisuCRtSvowFHilhH5jBgRPZfgLDGY1Fmrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUFjlnT46bnokwqUDQRFK5xf7d0KsaApk+grIF0NrJ+L1lX9ev
	NvuR3yOWkRfJdgcugi9U4hhHhMKgJI6xsRNLUyvFVupIyvArpAjD0lQJ
X-Gm-Gg: AY/fxX7q8T1821Ag2y00mEwpX/ceY+SiYI9rmHqbw3uMhZq2l9b9UCKAfk8fO7S7iJt
	mN+cF0Q7Ovgoi/yBC9imFBc20ijYEv+UlRJ8pGCAvgq2AQ+5LN6l8B8WEogBRX/JwZNcjkc3q2H
	8W5wnov5Q6zo2qOMQet2xFAoA+Toq4adjqcnzaP2T6Ci/FNqeZ9ZCG+cGQ2KzSxEl8KPoM243uO
	f89tMF19AbC+VRHJMR6j434J2GtKqKq+k1wG3GfyxK7ty7LALIEQWs401ng1p0EJp2Ed40rlnRX
	+Sm/2C2pNRNzaLMjT7tbZ6py/9PKihaPy9EpCud7AywGI+F6l/UlDkA0yo+Tz2FyUFpuuTn6ZjX
	GVTFwhe9aGwJktPDHuaRcSkE8nSzVG/kdZTgK8KW+j0n+IohQhLediokuo+8ML5KBUC+tn447pB
	Zi0fXPeKYwOH5r
X-Google-Smtp-Source: AGHT+IHcMGs8PoLCswC0jcVFT7uA/GxGBxuYPiLqvqoQfhZ141q5O7/FTfDa2atu+Qn3ppbT66iemg==
X-Received: by 2002:a05:6a21:3286:b0:34e:865e:8a65 with SMTP id adf61e73a8af0-3898f9cd677mr23369587637.52.1768306640111;
        Tue, 13 Jan 2026 04:17:20 -0800 (PST)
Received: from HP-Note-Host.. ([222.234.91.137])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faf8sm20775186a12.7.2026.01.13.04.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:17:19 -0800 (PST)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: sj@kernel.org
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rgbi3307@nate.com
Subject: [PATCH 1/2] mm/damon/core: modified and tunning damon_split_regions_of()
Date: Tue, 13 Jan 2026 21:16:42 +0900
Message-ID: <20260113121646.31441-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before modification:
                                                             sz_region
    |--------|--------|--------||--------|--------|--------|--------|
nr_subs:     1        2        3        4        5                  9
split random:    <----------- (*] randmon        LOST -------------->

When dividing sz_region at rand, the random value may be small, such as
1 or 2.  At this time, there is a problem that only the front areas
corresponding to 1 and 2 are divided, and the remaining back area
becomes too wide.  If the area is too wide, there will be many missed
address access judgments.

After modification:
                                                             sz_region
    |--------|--------|--------|--------|--------|--------|--------||
nr_subs:     1        2        3        4        5                  9
split from   <------------ (sz_region / nr_subs) ------------------>

It is recommended to divide sz_region evenly in the ratio (sz_region /
nr_subs) rather than using rand.  In this way, if you decide nr_subs well,
you can logically match the number of divisions and their sizes.

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 mm/damon/core.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f9fc0375890a..ff9af9d6a788 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2394,27 +2394,18 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs,
 				  unsigned long min_sz_region)
 {
 	struct damon_region *r, *next;
-	unsigned long sz_region, sz_sub = 0;
+	unsigned long sz_region, sz_sub;
 	int i;

 	damon_for_each_region_safe(r, next, t) {
 		sz_region = damon_sz_region(r);
+		sz_sub = ALIGN_DOWN(sz_region / nr_subs, min_sz_region);

-		for (i = 0; i < nr_subs - 1 &&
-				sz_region > 2 * min_sz_region; i++) {
-			/*
-			 * Randomly select size of left sub-region to be at
-			 * least 10 percent and at most 90% of original region
-			 */
-			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
-					sz_region / 10, min_sz_region);
-			/* Do not allow blank region */
-			if (sz_sub == 0 || sz_sub >= sz_region)
-				continue;
+		if (sz_sub < min_sz_region)
+			continue;

-			damon_split_region_at(t, r, sz_sub);
-			sz_region = sz_sub;
-		}
+		for (i = 1; i < nr_subs; i++)
+			damon_split_region_at(t, r, sz_region - sz_sub * i);
 	}
 }

--
2.43.0

