Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81542EEAC;
	Mon,  6 Jul 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347564; cv=none; b=u8INvNxmMp3QgsCtDlvWMG9pgRqx/n8LnNfm7Pcx4EfCHZ0K3dxhUagVJzx0Ud+txPEUk6UEXpyo/5pTTH20qfFN1uKI/2Hgwcy9jIYucQkxw7WwZPHJW8+JYS4IJAuh/02XPVXY9S3NrH0LYqQhDtAGdzbdcefao5d3nHmz2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347564; c=relaxed/simple;
	bh=iK3Pjh373PkSXQHz0O2cPtCazCpbKE/JtPcdthDxNyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTS5NF3GCfhHMeBJdwqBvpvHmyGR0OxYYSamxmtVJSXQ5q0+ez9FHKObr9f3C8vNBRda0WuIcYV0Hma7G2GJOX9S8ub42Sc4NksDUpT/Y8duWAIwXFrQ8nB59Y/hMXtEXkj9Q5R1YnM8KUOgCHbwYlJv47EyrrsOLYreZ8oHDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIgAZYuo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIgAZYuo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7061F00A3D;
	Mon,  6 Jul 2026 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347563;
	bh=CerPQCpLVt90M0nUjHgPSrY+HHMTa8twt+lmeeO7V1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EIgAZYuofMDWd81/+UVkaNqqj3ZRSNPaKKACGMwYBeYRlMAAMvbM1f0BIQ3k5C4cg
	 IJkwrmB9mApp2l2uhMwmV6p9yslrT1zn8/o09WwFBR499UwI1/ZK2T8F9Q6iCJRPKP
	 FVMg/r4poJjC0So3O9QJxi3GDzcDAqu+jNn5SrLFoyahiyy4u5H1gCZPHCe+1aPf7Q
	 qhlXct3Rsv7pOZHqIHPFhMOhzQ6lEEmY8IY/PNyf49L2E/+fS0Lz2CYwr1skOmJgxj
	 ZNvJXYEEP6lPHq+rrFAXCDQHuvoYfhUyjbljcU9EvmyXreI+1iGsImGyRgFHbRDmLG
	 npOcp8NEmAT3g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 08/16] mm/damon/core: disable access monitoring when probe weights are set
Date: Mon,  6 Jul 2026 07:19:02 -0700
Message-ID: <20260706141912.88445-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706141912.88445-1-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
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
