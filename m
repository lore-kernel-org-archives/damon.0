Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9342669E;
	Thu,  9 Jul 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605970; cv=none; b=Cwz+DSST9PEOyj1uxUJSGhdsoUNvnHGZtByf4NlhO1JDvlB7SQ+Q+9V6jNypwIpqZDfsmgQJ0vUylU/jKcbwjThAhINgJMxuqlsv/1aCU+12yQ98ZherCl43f+GsUnKTpWj5iUjQ8a6q9PhyWTuRjjCFhgf/Ss3sFkwS3RVp/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605970; c=relaxed/simple;
	bh=/tfsHGSCG9CFHm6Clx7NAUT7XTIqhJSovFYN0b7AiV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmytyqSDvUdUdGoakuy6Q3v89plIZyvWVjebw2eCXCpWSbpSu8j30WOp1N8Y3Da9IFEmq5+6+QWUA6YmRiUbeP33rgDsHg8VmVlwkVCj9Rt1DSPGHY+7nshtvi3f8yKIE0xlP1ckN0DcIOKqI91hTsJghLhYC4o+Jbil6ojbOC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmg0eQ78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vmg0eQ78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFD71F00A3E;
	Thu,  9 Jul 2026 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605968;
	bh=uIok4qBZQSpg60ailXO0bOCkjI7Xk9a+1vq0pYdirF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vmg0eQ784RNQy4F1LMVusNPLwtOeDD5MkHC4mmvzhsAgcOyLihdCuXxPmt2E0ckLa
	 0ndiwRvYu9X9JlRCsaXND48MjjOPKb+STLe1BEzhGtbHlyUF2H5f5t40J/fH0GHGsy
	 pcgudqt4GPeiweZZtbJaW0HCt5mhOs1aiG8StOdwI4BoMywMlHZrwvcBRDN2MjVGHr
	 nVzej4uJCZa3FOXCb7aHwDhTkXNbf4kQ4EguxX1zXZXpWk/SwqLNS1qbSMpVQCou93
	 OyE0QlyP8ybncx1kQVFep7YDYCiAltT2ZkbI16U1dv1vEaGdgcypwMv9Eo6QxixZhe
	 HJhTgPhKLJLwA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 14/19] mm/damon/core: get merge threshold from probe hits when weights are set
Date: Thu,  9 Jul 2026 07:05:52 -0700
Message-ID: <20260709140600.90950-15-sj@kernel.org>
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

When probe weights are set, DAMON merges regions based on their probe
hits weighted sum.  But the merge threshold is calculated based on the
access frequency.  Update it to retrieve the maximum probe hits weighted
sum in the snapshot from apply_probes() ops callback, and generate the
threshold based on it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8837b2129baa6..12c66edecd783 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3763,7 +3763,8 @@ static int kdamond_fn(void *data)
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
 		bool access_check_disabled = damon_has_probe_weights(ctx);
-		unsigned int max_merge_score = 0;
+		unsigned int max_merge_score = 0, max_wsum;
+		bool get_max_wsum;
 
 		if (kdamond_wait_activation(ctx))
 			break;
@@ -3776,9 +3777,18 @@ static int kdamond_fn(void *data)
 
 		if (!access_check_disabled && ctx->ops.check_accesses)
 			max_merge_score = ctx->ops.check_accesses(ctx);
-		if (ctx->ops.apply_probes)
-			ctx->ops.apply_probes(ctx, access_check_disabled,
-					false);
+		if (ctx->ops.apply_probes) {
+			if (time_after_eq(ctx->passed_sample_intervals,
+						next_aggregation_sis) &&
+					access_check_disabled)
+				get_max_wsum = true;
+			else
+				get_max_wsum = false;
+			max_wsum = ctx->ops.apply_probes(ctx,
+					access_check_disabled, get_max_wsum);
+			if (get_max_wsum)
+				max_merge_score = max_wsum;
+		}
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3
