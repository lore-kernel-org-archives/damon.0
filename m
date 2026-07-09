Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A47423A72;
	Thu,  9 Jul 2026 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605969; cv=none; b=EODUDSW08Ueq1VRGE1lsC7DUS2mRBrZhlqqHkDQBqPWMbBBa66T3VPucNQhQcJ9nU36+0p0jAuIYk5uGYRO6/X+eH7v9nZd3mUlTmXoTAHt14vWPvg2Hgirn1z3MWvcvJvXO/p7beTealOpsWUR2LB7it6hqKu+kKtgixjARM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605969; c=relaxed/simple;
	bh=Iln9bY/XA3a6mW/Elrn3MCcKN2nyTuaiR5WxDRlyVWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/xuiOsroUSnDyGaFZ2lLPZYDX156JHUxruNnrFn7mEetZZVaFGQ7ohRYO7qPV2p609MFnFhoNiCQ91iRO+9tkaPWBaFQjZ5y1MqU07leBtbUNJUbePbc2lHtNvzJ32EZr7hz0wd3J8g/Lne5fTjt15XWMZ7tuIejOWHVC/IKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksvBOlhX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksvBOlhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43061F00A3D;
	Thu,  9 Jul 2026 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605967;
	bh=cwl2cglmpuAFjTMSYGCoVfFN6ks32ggZ1ukBCbftSNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksvBOlhXZuYe6PcvDfA7Nh2i2MrRnI9YRQHYZScgbU9jprbbnerU3CogTOghKADMA
	 AqWVuMMkmttEV3P5neGz/VeCsLEvQJoYI34mCiMB4Q8Kb1o/zmTFExXyc+iGBRK6Eq
	 /7BUvKPgH1VNDMs88H3wSwyzUGYYiUG0itGUopGTpfAAiFVPhSr3BGAI7UbNGsOEXj
	 xpD4ApvNI2vHxW1DRwYIlMd5aUXhXsO1WxaflUDULuPmMVGtFlepDC1tigck6LiehO
	 Ro6T1BH2JL1DXbqNfsnV/5p1DWSJzn9f6RyFeH5GeqTHScw9EgdwN2kFQtBjfhYuNE
	 AUDnv7+9IeTbg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 12/19] mm/damon/core: set samples in apply_probes() if probe weights are set
Date: Thu,  9 Jul 2026 07:05:50 -0700
Message-ID: <20260709140600.90950-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When probe weights are set, the prepare_access_checks() ops callback is
not invoked, so sampling addresses of regions are unset.  Ask
apply_probes() to set those together in the case.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e250b7080708d..f1be748e9a674 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3777,7 +3777,8 @@ static int kdamond_fn(void *data)
 		if (!access_check_disabled && ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
-			ctx->ops.apply_probes(ctx, false, false);
+			ctx->ops.apply_probes(ctx, access_check_disabled,
+					false);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3
