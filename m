Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BDE42F6FB;
	Mon,  6 Jul 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347564; cv=none; b=o0VBwexwBellUceEYXAso/c2aE/17MW/dRixRRXm6ZFs4iDLow2PrwnpDAoDgUAmW08PTPNx8sYuSq492Vz2PGNnVM2XvVZJPkQParQSmyZlhI2FtTlXQOIpqsX3q6Q7C+exbpmI48TQSyKDIS2RIjppb3cBo7wQ3R8BgN0AEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347564; c=relaxed/simple;
	bh=lPQsOqnXp6VWBBfDL4uYMLI1sb/Fedw10zLuq4lDRLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K16ihHX86Favv1HskxbbuUopH/VT4822Nvwkfr+/duP+PR0VuGmaBTNpk9xfJmJhcO0WpZfWiMJxfUQzkV6WC2VJoRzXlcAPkQsSRil2swyqSZGa5XfJUrqNvHz0R7WWFqtFzPjNJ6b/kXCOn8r2eiC7OZvZ2Q2ew2T4ekEURYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U54HSCwV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U54HSCwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265FA1F00A3E;
	Mon,  6 Jul 2026 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347563;
	bh=QEatb2PqGWEsTMpIGK5NyiCA2DZolTzT+XVQuw4N5Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U54HSCwV1AMqJmZfzHAzGot2ucL3pXqXJ+pqpC7+P0zdsDh9oRt9iQI9Y4jc2lUtg
	 wRqXtsuXMO7xZ3gSTqnfDJUHmGzpW/RwJ1MH54EcnMThzmWajXmf86MkAgHUSOT1fw
	 2TKd7ejKz2wwd7iZQsySVHTEyoBh0qK8nGjhgUxyFh6FopVzyyDCTGbQNR4Eqpd/zu
	 bmtsJhPh9C1ayQ14vHWxYyRh5SxqH7KPUtQo1IRmx4tRVL2jrDkxUsIXwMG/5Rg2mx
	 Iah5dQjVA2YShZu2PNUnV1FxlmFPyhsdmcJ9/nr2NVlA7wNXK7FJLNwn0n5RpVYv2d
	 BhNhqoT2WMbJQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 09/16] mm/damon/core: set samples in apply_probes() if probe weights are set
Date: Mon,  6 Jul 2026 07:19:03 -0700
Message-ID: <20260706141912.88445-10-sj@kernel.org>
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

When probe weights are set, the prepare_access_checks() ops callback is
not invoked, so sampling addresses of regions are unset.  Ask
apply_probes() to set those together in the case.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ad0f28469e633..71008ee6ca243 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3728,7 +3728,8 @@ static int kdamond_fn(void *data)
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
