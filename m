Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3037C0FA
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778965446; cv=none; b=saC5dKwNNAd9fIefC2U87W284rENuRXHO4uj2SLUAJKBBjMHZXjLLV2Xgcr7VQyiDgMT8PwooKq5WknGJyLLF4R7gBE5v2Jq7MxLaIllmF34tgcaz6wST/FJ01LNx15Y947/CrnwESc8VtPN9bNJUH2Dia39Zx7nKAtDtjpK/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778965446; c=relaxed/simple;
	bh=9ehoVGHCch2YDXFpAgGWGiRbcBZMIbDp0HeIrubwg+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuwW2/De281P1ElNwk3yQuUdXL5NIvqdouN9CwD9MaRmkZt0px97HqnL5/WoFEHZ+O9JNjB3LMKZf6CqmgDztns81AYic8FHd7oTq409479M3zCKLqE0rlkFCAfBslDU15qRxXoAxlo87ex7CyclU+PP2OFLSqXPTKkhMhOVjJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ76nsq+; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ76nsq+"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7c5d8f45465so4687267b3.1
        for <damon@lists.linux.dev>; Sat, 16 May 2026 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778965444; x=1779570244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHb6DjRXqj9xDQrypI0jK8ctMTDK6O2uioTTtx6jNrM=;
        b=RQ76nsq+wdDjjXqVUXo6QzAA3XKH0jNK9YT2KEshXed9sfvjq3alZL1igh9tZ7Wqax
         mgSaVg6Ky/9+NHIrWdliH/L3MCFC+meRiSJ7QNi6IkvkNRDRQ2HO3/oLZz9plsjEF9FO
         CzoKCzzaAj7GLL7yhwYNsxRZOtL/vfs9QRoivzCb9AjcNSBs66ncglSJ/CKnXia9WFMG
         mW1P94BURR9kAjOyJpNKLepVl9U3UD3RwDI0HIKkykgdjojMNOgLJPI9dA279lBwrA2n
         TqdfGSWP8JVc3KW2L3wZ8asVW+mcE+yimdp3USuDnfuxk+ewRMdrGXKW6IIRWMbK7DeU
         gKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778965444; x=1779570244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHb6DjRXqj9xDQrypI0jK8ctMTDK6O2uioTTtx6jNrM=;
        b=hRxj868wHt7eHgWEtMe6TEOei6nmuZiwH2d292uksQeWDYo7L/9pvajXtfiOm98Q2s
         68uo/vU8kFe2l1t+HMYDpfSBI5EF70+VVfP63jGME/yND8K0s4VMTwh2nVMG9ddWSSS3
         yQigH6QAaYOedHa6QcaLTTGK3EX6Ol2Mde1UyXLNJ3LDnFj2dK9eDI5s2pr/FbiYCNhQ
         MbrfKuuW9Cr+pyS/23+UGLlEQKghlvQrHfNmo3ZS8aJ3X5bWFBYDuH2R8UcMFD1NWsJZ
         keOD8/ROVWd04DVZzK8H5nrvgE2aR1tougl9iadCQOlvBf6t8Iuxwpx2irgI1uNUiT1t
         uRJw==
X-Forwarded-Encrypted: i=1; AFNElJ8zWI2Q6gWxa8Nfpg6SNDgYOgNN/jWHRVGBBzqJktdJGOBSkap6RbA6P4QS1GNf+VVx1g1yTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOw79SL0hEFtuSSn0Lvqe4QDB6Pbr1NwQ1aIu9/dq8I/gMF56f
	uM5lSyqlkHhM3cqYBpLb98s5aHHYaICwsZuXqg/khCqnx1eGc7WH+sw=
X-Gm-Gg: Acq92OFT5AFYvuIaj32g0en1c65TK7fAiBvAEIRjfiPKwZc4PWCpwigdzgAABILGeYD
	wRImdMLk3a+orEmUyGXW5+uZ4vm3g/UEIudawrMvx69k73ITtN1G7VBf9JSmR5l8p9+qRz61sUE
	FhFaeZqriFsAzx2TXIVJXwkyMbwkYelsv/R4I19W0nzM9xesP1aM+T8YDOJj1MlGizkJokqKQnP
	gn8ppDJ2aESJpa8R+OF8SlJf1nyT2LEbNWvfUs1fN9fPBhCOTS78vo1IOgW4isonWufPqtTulGt
	IdJrxZDLINSiOJ6Aft0RNCD6srSbSsbu8N0NpfxqgcmCAGawBZTrfsVLuWpi+jxURn2Q8RrNUnO
	92AcbGB612OJ+xsiP5b+ZnqyPfWxh43H93gYafkAwMGn7xiz4bCYadwaeIJD2xafynzxr2rIiBN
	LtzKRiGxiMhRl/VnvNeJsqvvNK/GfGLA6DOKi4cYxL/qMN/zoVi0FLz80Mn6wPSCYQxhRjTUwSl
	g==
X-Received: by 2002:a05:690c:c4fa:b0:7b8:1b67:2571 with SMTP id 00721157ae682-7c95d1da54fmr102587527b3.42.1778965444167;
        Sat, 16 May 2026 14:04:04 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f54c29ddsm48585327b3.34.2026.05.16.14.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:04:03 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com
Subject: [RFC PATCH 1/5] mm/damon/core: fix nr_accesses_bp underflow in damon_moving_sum
Date: Sat, 16 May 2026 14:03:53 -0700
Message-ID: <20260516210357.2247-2-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516210357.2247-1-ravis.opensrc@gmail.com>
References: <20260516210357.2247-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guard against unsigned integer underflow when nomvsum/len_window
exceeds mvsum.  When that subtraction wraps, the moving sum returns a
near-ULONG_MAX value and corrupts nr_accesses_bp.

If subtrahend > mvsum, return new_value: this clamps the moving-sum
estimate to the current observation rather than wrapping.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3a8725e400c6b..9975f3d9ebfe9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3449,7 +3449,11 @@ int damon_set_region_system_rams_default(struct damon_target *t,
 static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
 		unsigned int len_window, unsigned int new_value)
 {
-	return mvsum - nomvsum / len_window + new_value;
+	unsigned int subtrahend = nomvsum / len_window;
+
+	if (subtrahend > mvsum)
+		return new_value;
+	return mvsum - subtrahend + new_value;
 }
 
 /**
-- 
2.43.0

