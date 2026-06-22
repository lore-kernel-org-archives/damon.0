Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362593BC668;
	Mon, 22 Jun 2026 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138119; cv=none; b=b7+0N4kXwdFsyepozp4D4TNrjiDMcMfYV3aJXliRW1eEimY8bP2+NyCTGFMpq5h+3J8QOLwOGDWFdwsWnoc9E6EK8L241aqzIJaTBANe2d+pzpRVP/I+vAWlUlXzKGPxRj/U0d/YTfVoavPf1402EcORUhafIFoNiNCKsSCCKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138119; c=relaxed/simple;
	bh=fDhXbIhIQdROH8xaI0APwYBpmlFKq++Uaz1z8b5foAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUbS+wxh1D+AgjPdqdUzkWrNKS+4CUOjBy4sDngHyZwNMM4+najp13VKSJbdSyedO13T3s+IEc/7auTtjMlvdS2cyi95Hj9u77HnCcQ7vnnUW4N4z3lOoOtuTWN8sFOgiIDQ7cwSP8EtoeWJOJTNoHYalfZGrg3sL1kqHrN9sHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFlGElAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFlGElAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB881F00A3D;
	Mon, 22 Jun 2026 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138118;
	bh=BGWzxU5bZaNSYgN3wX42/Kk6A34qbqSNs910LdacOd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HFlGElAzlA6mNvqYV655G9zaorPSKChkQSdKwYtV2iEoiTmMsfOiVYtCp5xFSKN8F
	 8DjxI2xcLN1XjlPd1b3f/kQ915FH1ouf0Em7Q5hQZLHIha5kI8tYat+2QfWAZsxlPh
	 qXqpS/kT8aHbuM9GSJ1unAz+6viJbb8gAnk0ZvVkr8OvZAewFttEHxQ9pxuPX4gEP+
	 9OW/8WOLOS2CBsfDg1Jx2TC1ZAFLWWuqulnqffVhc+moYNTrAxdiQAcxaWA4MiH7RO
	 d/2rfmC0x/2ofleTEGKroVAor5fgJNutpJ2srL4lMYn0Cd+jETVh6xlLDIXOTyI6Zd
	 29PmXLhBAGTQw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 09/18] mm/damon/core: remove damon_verify_reset_aggregated()
Date: Mon, 22 Jun 2026 07:21:29 -0700
Message-ID: <20260622142139.30269-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142139.30269-1-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_accesses_bp is no longer being used in real use cases.  Remove its
validation function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 89ac5552085a8..84052fa009158 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2002,23 +2002,6 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	return 0;
 }
 
-#ifdef CONFIG_DAMON_DEBUG_SANITY
-static void damon_verify_reset_aggregated(struct damon_region *r,
-		struct damon_ctx *c)
-{
-	WARN_ONCE(r->nr_accesses_bp != r->last_nr_accesses * 10000,
-			"nr_accesses_bp %u last_nr_accesses %u sis %lu %lu\n",
-			r->nr_accesses_bp, r->last_nr_accesses,
-			c->passed_sample_intervals, c->next_aggregation_sis);
-}
-#else
-static void damon_verify_reset_aggregated(struct damon_region *r,
-		struct damon_ctx *c)
-{
-}
-#endif
-
-
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -2047,7 +2030,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			r->nr_accesses = 0;
 			for (i = 0; i < DAMON_MAX_PROBES; i++)
 				r->probe_hits[i] = 0;
-			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
 	}
-- 
2.47.3
