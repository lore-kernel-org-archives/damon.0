Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C384264A86;
	Fri, 10 Jul 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691225; cv=none; b=IaHMcH+t0pwL8+kQxNrZyCJq+ZQMOxpLV+wC9Yh9D2v0f5kLeoNZ5muPfWtkTwsA+DLOnfUwLBMIB4m6F0GD4UHLWY0Wv1PD4RSLnABMOlBVrpvWWC4+vSLYPpnvqCPyapp8mNCL5Q/Ba6RalyhiRqoUNB8v8qP8BEpMXt5YWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691225; c=relaxed/simple;
	bh=/0FX8Oiy6TbkxvjGT4Gt4XFED2gDvmSI8ym944SSPac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRdk+3g9H0A0bJj0fN6aw9FyCvfM5vUf8zI5o+EPw2S5a4+Ab1awaW4ngwi2mgbDUOf1ZVCWddxdQnf+4lGi+2C3BUR1W64SRyXHbEqpzo9m4X6PAm1/FR1uTqnFuam+n9vg+r0pETPYlq1VRmnihyOFzFV2SzI1YrLbobu3LvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+UxNb0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+UxNb0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33001F00A3F;
	Fri, 10 Jul 2026 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691223;
	bh=XGD2YWf7x+bc2xuKYd61BqqesZUpM+m83fMjtL5Ub3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+UxNb0YCGeNfa+n6P1nu3YMCqGAXuvj1D1MEMX/tCmR97lOSfrytuUmBhWen9hk5
	 XQZIsVWXa1V0V9rH2WvqLgEAM8AqH3oRBSxlfC+446bBKX/ruVKKs5VBL5wuBUyYgg
	 jItKxirBf3+vOW/BoTuaHgAZ6EZiJLJovv6Ni0MVGPSN+UUeUVE6o2GqjUWTGvInqW
	 e7clg5PcoDR2lCcLWVqFTJmBuZcWdNwOADLATTmX8XKPetpDN/A/0XBXykKTjiSFcw
	 Tg3wER+d/zJXNxMUxJoautQdM3nbQli/VYBrr9Om1R/FuCrto9RTyo/LLh+p4Fn0DB
	 BUVyqDzmZIG3A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/19] mm/damon/core: disable access monitoring when probe weights are set
Date: Fri, 10 Jul 2026 06:46:40 -0700
Message-ID: <20260710134651.18084-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
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
index a0e6a5129fbf3..65f91e3b58d2e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3763,17 +3763,18 @@ static int kdamond_fn(void *data)
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
