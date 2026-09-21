Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C71FC0
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789950654; cv=none; b=iH/YJqv1j4e5R4MhgNaboMBlJGIBKuHsrOOES0odsucYSVbY4diriVDl9ns5Q+PnDhauPFXrAg+Z3njvCKvTT8WMb6TeV2C8cFZI7CWD+387HH+GVOCFyOAYf1MTplNGc4LsBvo9Aar8MbqtCuOysL5ofz3SsxEKYQgvHDtUIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789950654; c=relaxed/simple;
	bh=QQSAd2CYAnQxdw/DgFc6joStjKQYfZmSz3ZExj0RHZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFtz8gW16FlCdSYzF2AwTEq4aQBJXE7QSi+9ty5N3Vcl3S8mVKpUfLFlORvMmH95vFCfj2aqXH/ieZdw2DS/kq1FP03xxE0dQ58yo2ylh9waj220iX0SHHcS31mqgimrjza0ucS5oyoKNOD2CoDGfnvHNeqxLoe6yhJudxtrvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suEDZ1rN; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suEDZ1rN"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485ac898fa4so2069737f8f.0
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 17:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789950651; x=1790555451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8p2uHDJTRX2GGhCC6kgbhWuhGhbxvLj9khVv1KzE7G0=;
        b=suEDZ1rNf7BcXeaNOiPEFVUxDAQUO00wtE/6D4fHd0dcZ+EyIrJYG9P4awVBP9Z6vF
         r0tafIkj+x5M0vVLKj+FuM278Bs+Av4cXQ68Rv5XxxYWYZ6GCCgKDL0EeXryGsv16Sgw
         xqN8xUdR4I3LRFHQxIcvgK9kRf6w93ZGxh5vVN739VTu8iLHpyjgYR1YZ4IaMaQJKq4x
         /Hs/E9/YvCtrdi0Vz6Xby4IgWJsWVsBYBiVB6uMEM0EbYbH+D7FQvTUVzOF55uFc2QlN
         ZRTeYEziLdPmtj+Mzwd1DN7qyqyEzYZyi3+W5ZEEEL5jUTCAvRkwO3Rs92CGa4H2gcFx
         NRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789950651; x=1790555451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8p2uHDJTRX2GGhCC6kgbhWuhGhbxvLj9khVv1KzE7G0=;
        b=wtmpMDZ2g7yM/18RL5EwzojK5qVW1qyIYlXTKyflQq2R0UxpAycDzJDqzCBdA+v5BY
         CfEoVY9JOSg6xn+HNZtNVBpQzSI1LqgiFyqFqFiuwDhaIlzTQswsmtDBF0wt7IGS2rqh
         A6jgrGrP9INFOyAbgEk6kCaxBft4nGGMcz5cNMMBlaAoCHMP0hq/PHBkVB/eHxzD/Nku
         /4o31UexvgrPbQAB1xRsNUTbyGtPibnVpJimX36FALaszBF5m7H00kLuBG4W4V+/kMCO
         xLwcBET7vwtIO2XdtFOz0S056UZUhCC4LojknoPXRB0l28m8GrS/SrsW8uNV6yj94fIX
         2tBA==
X-Forwarded-Encrypted: i=1; AKwUvBy0fCNv3FHNMuJCPbohzqeB2n5l+SHKKhQIV4EGlYf2yWusKWBxkjxCWi+xYRGGBFU2uVrIPA==@lists.linux.dev
X-Gm-Message-State: AFuF++lsbiVexuqgsaHQXNgtVaatP0e1VC2DxlDnFw5RWDfy6UuOl6td
	o7ZkPKL9Ji4vJ5HwboTLLDOGpc6w3KwIan28jB7+cZBpAAwRkzDLjMsn
X-Gm-Gg: AYBFou1ep0uGNNHeczI6mObntya8gMPSpuVEqrthcdOgfQmqHKPPDM6OR+nnNxJat7c
	XKgXLi7bJMcnidl3TsajuRFscXP8TJYwXFSeDTc78aAmghQAoH+ehWRyBFLQ50BRWDJiNTRc34O
	RcE9gs0oWyGxNmwYQsFzes3ReL7L8IwedQiV04WORXFt4i+UFyUcu/0v+b8EY4hzaaDdPPSCfHS
	CVip/fyPDMJypTZXaNNUYh+BC4rqJkVUMTj925Lp/JENAeRmYgR+AT/WBdIeZk+OMkEMp/dS+qP
	Nirc2bXaEAA4RlFnIvZldMcaAb1DPycKFaxMMbSbD91Ln3b33VSBoU58k2QHNtp/WUnA6wSrhn5
	YwC9makAhHTTssCKd9tLtjvhn64rjX4WQBQhFpYYOK1AGsyipsnuvrshgYS4f9esgF0t11ETNcP
	myCV+MQkdDzTjk4fgiAU9d9vTbRANi6KnWxQnEuTiX3xPOKqDVo2m4PQlCQEieDfAk8fsHLsD5m
	xMq5FXKVd5BBz6KZIWacUVdtKftyPdr4PXIjHBdfbvo0RmfD0qeGQ1CDJfd68LHfcLgJpjKU5n6
	sFXkP0q4qd7zW0y2hSGDRrBB/2yLILjNgYS6/nFtWaoLMnzedKcXfnhi0k50oGvweRj3Dfn2fg1
	qyA==
X-Received: by 2002:a05:6000:186a:b0:486:e949:532c with SMTP id ffacd0b85a97d-4871e367f08mr12791266f8f.43.1789950651450;
        Sun, 20 Sep 2026 17:30:51 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a012-6c01-e0c2-ccc1-7acc-3570.310.pool.telefonica.de. [2a02:3100:a012:6c01:e0c2:ccc1:7acc:3570])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm17515695f8f.23.2026.09.20.17.30.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 17:30:51 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: preserve the caller's quota in damon_new_scheme()
Date: Mon, 21 Sep 2026 02:30:46 +0200
Message-Id: <20260921003047.12041-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921003047.12041-1-kmehltretter@gmail.com>
References: <20260921003047.12041-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_new_scheme() calls damos_quota_init() on the caller's quota before
copying it to the new scheme. This clears the caller's effective quota,
feedback input and charging state as a side effect.

damon_commit_ctx() first copies the running context into a temporary
context for validating the proposed parameters. When
damon_commit_schemes() creates the temporary schemes, it passes the quota
of each running scheme to damon_new_scheme(). The quota pointer therefore
refers to the running scheme, and damos_quota_init() clears that scheme's
state before it is copied to the temporary scheme. Even an update
rejected with -EINVAL loses the running quota state.

For a size quota, this discards the bytes already charged and allows the
scheme to use a fresh quota before the reset interval has elapsed. For a
goal-driven quota, the consist tuner loses its accumulated input and
restarts from its minimum input. A time quota loses its throughput
estimate and falls back to the initial estimate.

The constructor side effect was introduced by commit 70e0c1d1bf94
("mm/damon/core: factor out 'damos_quota' private fileds initialization").
Commit 60bd24f272d0 ("mm/damon/sysfs: test commit input against realistic
destination"), merged in v6.19, exposed it when
validating sysfs updates against a copy of the running context. Commit
b90408ef1163 ("mm/damon/core: safely validate src on damon_commit_ctx()")
later moved that validation into the core API.

Sashiko reported the same side effect [1] on the RFC of the core API
change.

Copy the quota to the new scheme first, then initialize that copy. Make
damos_quota_init() return void, since its return value is no longer needed.

Fixes: 70e0c1d1bf94 ("mm/damon/core: factor out 'damos_quota' private fileds initialization")
Cc: <stable@vger.kernel.org> # 6.19.x
Link: https://lore.kernel.org/damon/20260702212143.0CB6D1F00A3D@smtp.kernel.org/ [1]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2258b72da7a78..e655863d33d9c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -734,7 +734,7 @@ static bool damos_quota_goals_empty(struct damos_quota *q)
 }
 
 /* initialize fields of @quota that normally API users wouldn't set */
-static struct damos_quota *damos_quota_init(struct damos_quota *quota)
+static void damos_quota_init(struct damos_quota *quota)
 {
 	quota->esz = 0;
 	quota->total_charged_sz = 0;
@@ -744,7 +744,6 @@ static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 	quota->charge_target_from = NULL;
 	quota->charge_addr_from = 0;
 	quota->esz_bp = 0;
-	return quota;
 }
 
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
@@ -776,7 +775,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->last_applied = NULL;
 	INIT_LIST_HEAD(&scheme->list);
 
-	scheme->quota = *(damos_quota_init(quota));
+	scheme->quota = *quota;
+	damos_quota_init(&scheme->quota);
 	/* quota.goals should be separately set by caller */
 	INIT_LIST_HEAD(&scheme->quota.goals);
 
-- 
2.53.0

