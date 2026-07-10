Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E0229B18;
	Fri, 10 Jul 2026 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643043; cv=none; b=dQQSyBIl1dqOv0CYEu5AfZTzRx/momtBNt5dmZ+HNieT9IQOBT2D09iaLCgmlmJHzGXAYuMe1MAD5L14UpFzak9vkG2CPuGhy4iDjDAaG3dgEqaN8IYBOvu+XJ29rv1ZrOA8S7Qt6d3eQXD0UiwWg36v5/0T8RYOirUarERhIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643043; c=relaxed/simple;
	bh=/0FX8Oiy6TbkxvjGT4Gt4XFED2gDvmSI8ym944SSPac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muizt9Qz2YfArj6OFa3GH5NLy74ksX2IZx3Nrcgm2LoF0xLDKFjnLvY5Jgsq1Gg2MuytRzQwgTCqMsUvjQZqEU3jc9WnskXRdpcnbxvaRdUT6QLAYob2nBAQRcKhSQwy83bJkEq7B8nFg2bpqEbUXEaTP6T1VvjDKzqgtCi6oyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDxEzSXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDxEzSXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287AA1F00A3D;
	Fri, 10 Jul 2026 00:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643042;
	bh=XGD2YWf7x+bc2xuKYd61BqqesZUpM+m83fMjtL5Ub3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JDxEzSXbY1Gp15IUSZTSzgJB4wKiWpCO8s2NG5+ut+qNiXQwqwaUa6JJI3hIHAaty
	 HHNDBGvOpJJzEv5TTOy8vu5Dz2HyU1nx86ht/78bi7HFWSfVQeDgCqDLx9Ubgk8mNx
	 BgWJhkzz4/wP+arQMf4CvMqaHQYzHLzW+frMWWOuf9ZNsJ4AOwyicq3Ph7fmx6/B48
	 YHGkrhxWAejDsyM1PA7s6cqXE/SB9hFEXa1MVtdFVLvorEPgupqpuUrvh9Hqks47FV
	 YV71znycF/Wz1/whWVLSw/Gc9RIIplZjcvnMArB8AKEf3I5+ErdM6xopHVMklJQ3Yz
	 U/MRiMQG4fmeg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 11/19] mm/damon/core: disable access monitoring when probe weights are set
Date: Thu,  9 Jul 2026 17:23:37 -0700
Message-ID: <20260710002349.111414-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
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
