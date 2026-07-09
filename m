Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A442314E;
	Thu,  9 Jul 2026 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605968; cv=none; b=OjXOqP77oHIBeNdDcLutUQWRKqv6WDTa2HVuvDS7nC33sFrWZtilZC71RSHoe8skUc7TPgCpBhwua3RfvRM/rq1UU1caT5mpXFLx+L4vTl4pPkWBn1cQq9m5SLlRZs9DYoUAMDEIe+j4bbmkDMG1VIuNdMUiZKJZctNqhOoyVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605968; c=relaxed/simple;
	bh=PhXQQpucptaaEPaLQbdUQsx9YHekTQ5o6U1OizAavYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQNdd1Eyo0TR4qi/0pra6qZKdkjujwhvAEyE0JbB6COQI11FqPhugRVQZ5vl5gNIOOxYFPI4xu1xjfESqZ2e3n2oT9d9x8nWJFHJwrFf/MtSTJulEDg16ActXELBkM+wLnFLINcBo1iEywSRQkdPmAJRRCneeCVU8H3SU8ZQ2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeLgLUh+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeLgLUh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FA61F00ACA;
	Thu,  9 Jul 2026 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605967;
	bh=uDi6I/gjqdQG3FZL7bTPNXi1XeJP146JhSzquekJpSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VeLgLUh+rr1bHaq7sAsIy8KkttF3Wk9ow6qqHLK2hG/4sPALyBUbRDsJmRf8ospen
	 REGrUy2G3/+oGnrx5zKJkOpytHDB9lYZWKRWkGqLivz+ULyXeeoG88ox7gDBY2zdho
	 N1SMT5+vlgdKW9OkLzXIfhLCcq3/vJOJi9vlzvqd2J9yb1RrqAv6gy30FT0y4EerdP
	 WW97+iqsoD2gHlZhW8Gibfod756Rx4npI0mWW/vVkM23GN9UAnW3TFNqP9Ovige50x
	 HDfeD9UV51vbH3MhDxAZqfngfhxJkwUMXqMbNlTJMhzSKMhW2iTNY/+Vpx3PR+SZT/
	 f5WCzepUR5hRA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 11/19] mm/damon/core: disable access monitoring when probe weights are set
Date: Thu,  9 Jul 2026 07:05:49 -0700
Message-ID: <20260709140600.90950-12-sj@kernel.org>
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

When users set probe weights, they are interested in the data
attributes.  Not necessarily they are interested in data access
patterns.  Disable the data access monitoring in the case.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b585e4bf035f1..e250b7080708d 100644
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
