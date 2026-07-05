Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB53A7595;
	Sun,  5 Jul 2026 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285077; cv=none; b=FqzA/tWgsA4nCNO20H8XvgPqHHc/YA5HUqWwDBCPkQ7mwNT6jl/XEKwKKh0ERjJ50+4x8tK0ErKjiKpunFG9SfHJDkm4d0zeahEn9xsEYOqWCVCF5iyql/EQxu6+ZmXhQ7ZjgYsulfOG0EI6cIsaSghMmgrSh7Kf0XcvFfFoL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285077; c=relaxed/simple;
	bh=iK3Pjh373PkSXQHz0O2cPtCazCpbKE/JtPcdthDxNyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRNG1G/s2Z91TfwRm9oYOWQtl6/8ErxVgYOjf4a6QGXLZe4j3m/+oi6S0uRHuzTbuhtyfA0N1PZJi1/gPOwFzvbNveXIYYyHX+/zRK4k8nNeDEQdya3sLk1MT1SbILf3sOX9qfWRlPiopJbX+eA8QUK4pvwBfQFc22/pV9KWQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwVyRiW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwVyRiW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143901F00A3E;
	Sun,  5 Jul 2026 20:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285076;
	bh=CerPQCpLVt90M0nUjHgPSrY+HHMTa8twt+lmeeO7V1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WwVyRiW5rsxPwlJh+5kk4V454aIQaLqpXiurpK0plRnh7GJjP/XZhNTwbEGWOOF7p
	 /whtAWXYP81oJriugLVSbpDNK5IkxKJ1Ejg5rP9f0M5y997hRuFcRXDcViyiMmbNwq
	 /06vsutBypmFJl2M9qnhwkeaRIJ4HaB9gsygso1AHWyBWv2so+irzL9xuiUrvgrg/q
	 3/u5efHoT/MFfuflgTHEIIKR0OOsq1GC2x51NFPCQ9KwpNUzI1vh9tNkopNR6j8nCZ
	 wDygJEbkgAaR8w5hG8/bGK6fuyCFNiEsxJkHgQGbICCRqLIeTjiCwz8/k3B9jKrXR4
	 vCwt6LGRMvLYg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/16] mm/damon/core: disable access monitoring when probe weights are set
Date: Sun,  5 Jul 2026 13:57:30 -0700
Message-ID: <20260705205743.98656-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705205743.98656-1-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When users set probe weights, they are interested in the data
attributes.  Not necessarily they are interested in data access
patterns.  Disable the data access monitoring in the case.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9bb884ab135ec..ad0f28469e633 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3714,17 +3714,18 @@ static int kdamond_fn(void *data)
 		unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
+		bool access_check_disabled = damon_has_probe_weights(ctx);
 
 		if (kdamond_wait_activation(ctx))
 			break;
 
-		if (ctx->ops.prepare_access_checks)
+		if (!access_check_disabled && ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
 
-		if (ctx->ops.check_accesses)
+		if (!access_check_disabled && ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
 			ctx->ops.apply_probes(ctx, false, false);
-- 
2.47.3
