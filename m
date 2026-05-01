Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72F319D065
	for <damon@lists.linux.dev>; Fri,  1 May 2026 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777599462; cv=none; b=qpnw2fH6cFmzRKVQTAz/KaA2JzVCJ8XQDob7xDsWT66fyqkMSNR4d4v/h9bDOZeB4AQYLsz9ewNNVPOPbd2u5KoBgTyS0f6X+06CkzHUgnlJ1sPsXBV1Gdw71i1V3RbeaaKM0DrXeFAhMDh8y1ag/bhe7XtaFZd1P+IurxrHGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777599462; c=relaxed/simple;
	bh=YyP/4ve7I9QbwZRwmdPBhg7URPumXg9n30YO3F2nBbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mS8P7gAs3XgJHfNbo459ExFc/GfFuu46CQIHrwgYlb6D/Z+lLQABNhnuZR8tHFCie0Ryro7lKCgylJcmwcURSppIwFvZCzPbG2LIRgWWowzkWpYwT6F5Tk0uPAYwBk3henGgoMoOFabeRqzApUSuyaKFO0mPQ3/t+0YTfXwJRFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkiz0UEw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkiz0UEw"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c795a47186bso629351a12.0
        for <damon@lists.linux.dev>; Thu, 30 Apr 2026 18:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777599461; x=1778204261; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXTXvru2GO3NZn+5sTz42Mp4kDJWE6wNo4KhGjLHTqU=;
        b=nkiz0UEwGWt/m3GzXwDqzK7oHwL4qbOtnD3lzJ69MD5gv9jKIAvwzLo1RF/a2rgMN9
         /IJ+puyHmRVPKUwXv2AmILJXLbiDor9X8C714w918gvajVlbuyetjD9sgoZc879Da/6b
         IwTFRWcyVDyakpwdQlLL77aFYhRc8BLBV8CwB3fWaHe4aFbgqGGJEcX1KJ9RWan45X9A
         7AuuRcuAM8x1KrrVUAJT8ed8V7eMGrwim/LAzoW2Feje5R3ZTRjyOgJcyBHapu1jIj4j
         bpZkwhaeBmrcofJeNcXAAXqtZKWnucv4B/tcMTPmEs8w9omzf/0Mp78aVxaXlJxnAJUg
         mxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777599461; x=1778204261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXTXvru2GO3NZn+5sTz42Mp4kDJWE6wNo4KhGjLHTqU=;
        b=HnO0sT7hgFDc9pVXfmSIU1jXYLI/mDNFhDc38xSK9eR9IE6Korkcws53O0vkmCEuqk
         kH2L5EDPDONlJMcL8dh0tMkp7jnWRDYLYCkIEadoc2SmdLIenaYw29VKpKYFKUyoFvdZ
         Phvfn+O+SCns+Znaf6hw0ElHxzwXqJB8sBk0OOiKUD9OfHgV2DS3NuzThAyz8CN7/aS7
         O4e/HebpEaHo7rKcMiOK5jZcek/E8+h+cYGd/zgq178BnTmfw4t+7v10DiTx7K3RC+om
         cZoLtCp74f+VhTTZa5oHoJQAKysQyIfCIvdpxwRFxMfVZAifxkZuDN58mZo8f09uFwYm
         /iYA==
X-Gm-Message-State: AOJu0YyZBhW5JNb1M/prBKUA+ZDN4G5L7O27gnXqqURYJmneU5/Zm18j
	1bHjKYQN+5V/+iFCGbYjC9jx8tDsO7DslRsRckEM7ufku/SK3i4RR71h
X-Gm-Gg: AeBDieuQJPaa2skjLOx3Usb72LC+Wv0tuTqFa6GI4mA0n66xknDrMfYHTE4sj2ErN/l
	WvdcGL4qjYQ3NUOmFGVTumFyONX74GpPBf4KaUykgfR/uTb2fEL0WmwfdgxNPx/LcPr3xcFOZQU
	Yc5cCiwfut08lc6XjLyGTSDrDnrRRxSqygflKWDboseppUfJW2EsZBWg511dzt9/iYDmqnK4sNr
	4OJkasbiPBeVT6PoVjUIgXPNuWGvzFoWsJEXpNPUDG1yMCCGqJrljUTqBC+wGLgyGHeyu/W+hYe
	HhzCYebD/RfbR/P0+4wPPKB963vIC3Ms7ElR9wrhGW+iHQZEr/1hkXEoGKiH16FXmdX7FeY0mTs
	KqT4YyrzyjIdvn4wysM1YXbaPqYmRpbpKpM/oswCiKil8V71xJqrHhs9hqkpfQqBDT7GzkWa1Iq
	L1mNojdl25hSf8074HxenaWEMcwZQoZmGLUgzhMP1F9QobCQ1QaOSnZZyK5Nx1XF2HS7N8jPc=
X-Received: by 2002:a05:6a20:6a1b:b0:3a2:c7e1:ff93 with SMTP id adf61e73a8af0-3a3d1d0b668mr4732006637.8.1777599460987;
        Thu, 30 Apr 2026 18:37:40 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8f3:e8d0:1478:fdf:dfb3:daec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b02935sm956318b3a.41.2026.04.30.18.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:37:40 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v5 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  1 May 2026 09:37:49 +0800
Message-ID: <20260501013750.71704-2-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501013750.71704-1-aethernet65535@gmail.com>
References: <20260501013750.71704-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
When a user sets an invalid 'addr_unit' (e.g., 3) via DAMON_LRU_SORT,
'min_region_sz' becomes a non-power-of-2 value. While damon_commit_ctx()
correctly detects this and returns -EINVAL, it sets the
'maybe_corrupted' flag during this process.

This flag causes the running kdamond to terminate. While the termination
is a safety measure, it is suboptimal in this case because the error is
just a simple invalid input from the user, which shouldn't neccessitate
stopping the kdamond.

Reproduction
============
1. Enable DAMON_LRU_SORT
2. Set addr_unit=3
3. Commit inputs via 'commit_inputs'
4. Observe kdamond termination

Solution
========
Add an early validation in damon_lru_sort_apply_parameters() to check
'min_region_sz' before any state change occurs. If it is non-power-of-2,
return -EINVAL immediately, preventing 'maybe_corrupted' from being set.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/lru_sort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..3fd176ef9d9c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0

