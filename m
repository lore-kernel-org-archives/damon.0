Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE1333445
	for <damon@lists.linux.dev>; Fri, 10 Apr 2026 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796202; cv=none; b=Vwh5hEjKWTIVlZyO0HOstqlS3PH1+chzRhtND67OokOOeovFTOGbXQs7Mj1eza2ybXW3HZ6J5BBlc9X/EO49cq2ZsgSobsS1VXmpzWPJY1fFD0zXcojw/wDPXEzqlK2itTz6H0syGQxzFJZ6XATHaYnTGArcv6aaOfSHglJh0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796202; c=relaxed/simple;
	bh=kJqUbQL6/TR+xDiCCdSMw1cpOUwZW7TEhS4gAM+clUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYl8Zbb6CN0emSSZJQGaid73qV5XHrVfT8x+WMIuuCr6QR726igqleURYkiZUEWOE+6T8dEmuBWfA3X/vr34VXV5uwZAxK+031+Gb9XtZkr6mhGSrdzidlMnO1EfSIEYCrvkTxbqTUZMSgi8PKWLJqZos4xlU8qJijPJJkrRxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6ZkE0Gr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6ZkE0Gr"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f0fc82c76so74692b3a.0
        for <damon@lists.linux.dev>; Thu, 09 Apr 2026 21:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775796200; x=1776401000; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shK6Y8ANhI6+xigEaYbBRBX53EjdBBu/dLtteAqBvF4=;
        b=W6ZkE0GrxuH0CLs/OSkBRPe7KdmfJkfy3Ceq5VHMIXCbqvxOAcCHCHWQnpkdyM4VSj
         l7IkZjF3qGE7RGSoFa17khraeKtfUYaxrJRBUHUFu3v6D10stuOvf8XnFoNsGtbpITr7
         X5Une5jV4sPVUsTGq4i+g0RnWitjJGfj114xu9e8b2joo3scc6TnU/BfpsGrb6zw/ARq
         Bkrs7yZWhgz8/SC3HNFmD+vF+Lx6JDrgo9Tj6GwHQcP5KEnprOCj6J7zVKHDXJHGBAAZ
         y70oZzSzVDSVNXKUt+NGBfBNQmOP4h0Zu9LPzjduC0sVmv7QB7ZQF/sgZK7C+7L4EtRD
         aoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775796200; x=1776401000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=shK6Y8ANhI6+xigEaYbBRBX53EjdBBu/dLtteAqBvF4=;
        b=LtXxr8GpN8FxNQuxAq/QQ6Z0fzLrcYxDwbHmBdgT9yWVYhSg/35CDmdgwga38k8iB9
         Qwe8X/37NKk14srctixHAS/FMO7WXYyEQjKiMWWaoxqrYulymp/mJ8AXvWjwiGtIXqKC
         18RrfNWm/Aa+2DXw/I+YDJb0PIhlqyGTtLK7uZ5pu1zTiYTvpGF17Mk6MUOfj4BS3h5G
         PaHVCOeRqNJ4IHOxkrPFVdRyugKSx0rVoiYs3tUlSD5LY3Tgjx5h/sH7Ts+2ktoo+3M2
         Q3ypGb4r6zgYKQUK6JqNA3OHI6JSmdtMCoPBga1KHVwbAM5v1rmesuKwan2kqQpV6JS0
         OqfA==
X-Forwarded-Encrypted: i=1; AJvYcCVmwn4csutFIlQroiEU4iwvMafXhvTepOtYBLxj04Wf+XJ1kWkYWr/4DPQOzb6NG+IMyxxyUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKXDJx3PdVngcBkceb8ATAIHVPKNAdbqpOnqWp3pBdfHtTU8ht
	nlHLMHd3MW51D2VoUbeYQMLjB3N5BqQOiY2afNL0PWj4dcjN63yE6ygg
X-Gm-Gg: AeBDievzA7PmSAEnNqNENTq9FbB4tdIitUvuql8RcmeFxNJqEidE9fc42HdLpqi7fd1
	nbcy5Ty748RR9nVI2QxVcbzoMfLeBjnxVQ/oaobpIOOmCv+jHw4sieu3W6GVyXzbIOXPohCBwa1
	ZGfzqUf3yr4/ousTkSP1CKXcEZKBIcQO5UJberfSgeH+F/Ug5L3DjPTXE5uLAMGx4PIBGbl/nb5
	IJkcNtjcEqtHLhjuQqNoVaHkO9FYCxm6UrEdBfhpmkYqPT7Nq7QYbdd6MyiNp7WJY8h6wHKqOa1
	FtJ+UErjZhnd12W3o1VfQM613SjTiy9m1ZKin3ECn9sFfbZOKUsKd/xptE3On7sVkFe2argTTXf
	zbqODsi5PEEWK7EO+nB02JXz2wJo1LxhSUvZDd6vdMBQ8lcRG99Cc0iaKM1AfOguV8+P9TV8r7H
	aJesSHy0t6nXkJjZuBcOiE2dETRFA=
X-Received: by 2002:a05:6a00:170c:b0:82c:ddbb:7db3 with SMTP id d2e1a72fcca58-82f0c21d396mr1954892b3a.25.1775796200399;
        Thu, 09 Apr 2026 21:43:20 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30e7besm1200109b3a.5.2026.04.09.21.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 21:43:20 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 12:42:59 +0800
Message-ID: <20260410044259.95877-3-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410044259.95877-1-aethernet65535@gmail.com>
References: <20260410044259.95877-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
When a user sets an invalid 'addr_unit' (e.g., 3) via
DAMON_RECLAIM, 'min_region_sz' becomes a non-power-of-2
value. This value eventually reaches damon_commit_ctx(), which does:

    dst->maybe_corrupted = true;
    if (!is_power_of_2(src->min_region_sz))
        return -EINVAL;

Although -EINVAL is returned, 'maybe_corrupted' is already set. The
running kdamond observers this flag and terminates unexpectedly.

"Unexpected termination" here means the kdamond exits without any user
request (e.g., not by writing 'N' to 'enabled').

User Impact
===========
Once kdamond terminates this way, it cannot be restarted via sysfs
because:

1. DAMON_RECLAIM is built into the kernel, so it cannot be unloaded and
   reloaded at runtime.
2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
   Writing 'Y' does nothing, as 'enabled' is already Y.

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

Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
Cc: <stable@vger.kernel.org> # 6.18.x
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

