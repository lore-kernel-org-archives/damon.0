Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47654178CC8;
	Wed, 13 Nov 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515192; cv=none; b=jXeecypSs7dBXWmdfb+pheug+aNx63Ct0i2DtPbZFydbLtPwHVwUU42W6ZUvJyMgAZhmZjepzN6V+lMKJQvU8VrAlPo929StEZ5dnhujz2PR0xKwbwZLXApTEoHTuZXCTS71vXiF76VQhBHo2KY9iFuX/ezScCxBnV6TdIdtmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515192; c=relaxed/simple;
	bh=WP1gX/xo4x64pFwAnpa4+qlhjEolC1jxzqSRjjY1A0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EDPhEdB5fyuz/d4l8cMCEBSEElmdOfiwwI5iVMe1TLkQNv0Aq9FKdO6BmwRtUjejoWIaqe1BJMwH6aMMTvAITr0CA8CHbo1o1HRLz7xz7Znd6pRwpqJNSQ3jMQaTNnDO+vS/CmK4YL7p/gP93fCADEvPagnUBxx7lSqlB7I0Kiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN9kf5OF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN9kf5OF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA66C4CECD;
	Wed, 13 Nov 2024 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731515192;
	bh=WP1gX/xo4x64pFwAnpa4+qlhjEolC1jxzqSRjjY1A0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nN9kf5OFlgu4dQr8kCgt11CeEmO3VjWDz9PPNEL9PiWAWkorJg3cQDh8o7rskgdSs
	 cn+ZKCIsnVwh+8dDZO4Zbyur1MW45QSGn8txRaDsySqSV7KIMmfUKA5PWQ1Dv3NHmv
	 +N+s+m3m/WrVUHwd5kcgs7cL+OxACk/rGNf0EmWGQOVxp0vp7tt78QGYKr46jUlIvE
	 NOTMsBSNsx0g5Ie9rDombMvKqIbh7Nyju6A3ZegmdGTOr9s5LdvlzbdX0wltREHHny
	 3qbGbMDgb7mTKOD9Et9doc+jpde1E3Wt42dbzEXoOmxjsTZX2KM5B2RTwzhiT1mwTz
	 nVlaC5Lb/NTtg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 3/5] samples/damon/wsse: implement working set size estimation and logging
Date: Wed, 13 Nov 2024 08:26:22 -0800
Message-Id: <20241113162624.48973-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241113162624.48973-1-sj@kernel.org>
References: <20241113162624.48973-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the DAMON-based working set size estimation logic.  The logic
simply iterates memory regions in DAMON-generated access pattern
snapshot for every aggregation, and get the total sum of the size of any
region having one or higher 'nr_accesses' count.  That is, it assumes
any region having one or higher 'nr_accesses' to be a part of the
working set.  The estimated value is printed to the kernel log.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 119ac8a2c901..a2a94c505938 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -30,6 +30,23 @@ MODULE_PARM_DESC(enable, "Enable or disable DAMON_SAMPLE_WSSE");
 static struct damon_ctx *ctx;
 static struct pid *target_pidp;
 
+static int damon_sample_wsse_after_aggregate(struct damon_ctx *c)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+		unsigned long wss = 0;
+
+		damon_for_each_region(r, t) {
+			if (r->nr_accesses > 0)
+				wss += r->ar.end - r->ar.start;
+		}
+		pr_info("wss: %lu\n", wss);
+	}
+	return 0;
+}
+
 static int damon_sample_wsse_start(void)
 {
 	struct damon_target *target;
@@ -57,6 +74,7 @@ static int damon_sample_wsse_start(void)
 	}
 	target->pid = target_pidp;
 
+	ctx->callback.after_aggregation = damon_sample_wsse_after_aggregate;
 	return damon_start(&ctx, 1, true);
 }
 
-- 
2.39.5

