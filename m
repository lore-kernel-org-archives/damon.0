Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37919D065
	for <damon@lists.linux.dev>; Fri,  1 May 2026 01:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777599465; cv=none; b=NUkZur4L8LL8UKbvAX0Qwr8zANgHXQtmLTRBLU5HjrO7z4DRBqBg4QKvOCs4OhtU4lL3iBqGh++rD6LDjQjSHVvulV0T6gVq8bPJoqMjinxDbB9euShf1Z8t6z+tVqzdJbtDAWCY0l+KgCjI4LoIgoAwYOCKG8PC0TXuDNR6NS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777599465; c=relaxed/simple;
	bh=Er05+V/fanvnA6KfIhAgi8Aag4/2PjQt1YEztxTMAEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctpczKBK1/FxKy9/RFSEVbMlwWhTSIl8pv5r5lMqFHi0ce2y8EDzuXClV8pBUZtV/lMGsPE+hWXcliRdmGYtDNvbwH0qHeRjTdz4gAxpaY1PKI13pEphy5+CiJgBACIanF2Jnj/Ayk71XAJ01zflRFFHubmxygFedCk9WmHTrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBuhrgdT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBuhrgdT"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824c9da9928so773193b3a.3
        for <damon@lists.linux.dev>; Thu, 30 Apr 2026 18:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777599463; x=1778204263; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXkZizzlIjDaETBBA0ZOQ5z2LGXYcLfPd8nsRMFv+WU=;
        b=lBuhrgdTDrrPAiuLxT9uUvbsXhsedRYHYbrL1kiqnF00XNNPow+ww+vp1N7P31zhge
         wsbHU/58lSt3CnEZbAQzOZ7np7s5R5RpheYIGoNLgSMVAGhe/26a6Aul0YI2ExZ3ntsZ
         FjiiNeWDMlZipA3f9aABFsmnMiVmVf5ZjFeW2ESjAjxIQLWgIJmtLRXWXp/emaiIxkkR
         iKHljYwvcMyW5H2rSFl91v6mCPFzLrei+PXYK9mKB8qdbPUSmkixPLx6JJollayJ2wV/
         +Vk7ZUG59eLfz3txE92lGm2KKQataM3cmsg75BwO5OoETcVchgmlcUkHsgQqaNULKiGT
         jvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777599463; x=1778204263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tXkZizzlIjDaETBBA0ZOQ5z2LGXYcLfPd8nsRMFv+WU=;
        b=s/vdxDc82q83lIuB34K71zYgKyVAN00jz5Pf6deNLi6nHu3cb0L1R8TMSBTr27uu+4
         yW1el4emcJgtcm7ekR/t2o4y4eTo6nvVxglrZUZHmUJ6WTCc8lRo6+zxEiReboHGOAV9
         sokqBhsBEQsQhYdOX0L+UzY9Kviu+HV++rXqNSgfP3+osKSp10PcoZDYEAp3bHlLRpfu
         VJCMOGsxD6IYAZ6JpHBhIRsQEjeCgdpyeMZdG17j30C1tPk7KkUOUd4gNJ4xzDbQEsYY
         Yn66y8eFHVeOChRiFM1UCI03rCVRYmoddZnHIVWUN3aoAuZoqfXWfFe6M8+7DwUTBczf
         lPGA==
X-Gm-Message-State: AOJu0Yyd/nQUf/ayMr91llSnTlIvVbx3gd8QrQns3Fg4JgtbpfsLD4Vb
	8WWdJPyRDB/NEuG86b93u3xl6C1d6SDylvWDfTdbhoHwdfZP3gBpO0OW
X-Gm-Gg: AeBDietxPU6ul5F63AewsR4+XFTq45C6bgSYffLJVloDwj7AtrQKCKkG4aaojLTbZBA
	UULFCcP82jHBURNwczVRetO4Pgzy3WQijC0CZCXUqRmHGaI+tKLKSgUIbrNeR7c+0NTOsxxuPyf
	Ld2lTLyXfsfgQPJIyvAUI6wxPr1bU99ecgtRybHh7QKZXfqsjCNdFMhZSJE3o0ggOsIx/vXo8ne
	MPJ6IOnuQloDUWvqZR5kM61TmamABICXZjXiY18+kS1yeowazJMzUr9nCGTpmFNH7Cq1B4dS7df
	2pQIZhlIZYYENOD4JhpBexunz4gfNP8BhX61CiWOfSmEGYkMsU8Ae5sxbL7irgMdPulvvfUfA/c
	RRJryXq540O4FXOUiCFh2VMLRGCBrdNcDl+T2Ju1tc8TS5mRGzD3ddRVVQQphHxxqOSIwcMf510
	im5K/g+7YYHH+FfbTbYOrqZxXNdKkW+x8wTxjLqH/gMOxSMW4pPrmviVeDGdzv
X-Received: by 2002:a05:6a00:330b:b0:82f:6a64:deac with SMTP id d2e1a72fcca58-834fe1bf650mr6747969b3a.28.1777599463184;
        Thu, 30 Apr 2026 18:37:43 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8f3:e8d0:1478:fdf:dfb3:daec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b02935sm956318b3a.41.2026.04.30.18.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:37:42 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v5 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri,  1 May 2026 09:37:50 +0800
Message-ID: <20260501013750.71704-3-aethernet65535@gmail.com>
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
When a user sets an invalid 'addr_unit' (e.g., 3) via DAMON_RECLAIM,
'min_region_sz' becomes a non-power-of-2 value. While damon_commit_ctx()
correctly detects this and returns -EINVAL, it sets the
'maybe_corrupted' flag during this process.

This flag causes the running kdamond to terminate. While the termination
is a safety measure, it is suboptimal in this case because the error is
just a simple invalid input from the user, which shouldn't neccessitate
stopping the kdamond.

Reproduction
============
1. Enable DAMON_RECLAIM
2. Set addr_unit=3
3. Commit inputs via 'commit_inputs'
4. Observe kdamond termination

Solution
========
Add an early validation in damon_reclaim_apply_parameters() to check
'min_region_sz' before any state change occurs. If it is non-power-of-2,
return -EINVAL immediately, preventing 'maybe_corrupted' from being set.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/reclaim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..2747eef5919d 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -204,6 +204,11 @@ static int damon_reclaim_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0

