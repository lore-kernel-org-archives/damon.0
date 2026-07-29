Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85984A3406;
	Wed, 29 Jul 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333785; cv=none; b=LY4G9dBFw3dS+N3xSuWo8b3Y4m/hrfNNKehsFMPwrvkP94P59PLXdVIIBkPdkleevVQYpg73c79iLIGBk9/IgmqP62+p05Djs1Sk8g6Md8yX6FXtI6/Uthbrz9yxq7yU3RVHO9yNmw3ocDBJ1828kJEaYLmYhTQS2KiWl1p2Lts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333785; c=relaxed/simple;
	bh=7aj0HHIF0FmLDvA7ZUTRMPVQm2v2FlKqXF7k67yMB/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uu/bY8RZ+NvK5J7NEWJQOKDevk4TTB4Yy+Ldf6xHjoSMEeeO1GxfHo8Oocm9qu+504GlbI6OzDNQRzHshGqewzV6zPFiBD9hwyLksKiMOT5dQX5v08wODitGTLg+BeNEqUmNJ1O+WCtA4UTjcRfHAULrGzWHk7t5jJJt78QLy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3bsZJLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3bsZJLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B601F000E9;
	Wed, 29 Jul 2026 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333784;
	bh=l6Gzj2O2XUAR6lep0wUa1dFLYISIw0l2rjfScnnYsJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z3bsZJLHYCQzwZO54/ElaLeyhDf/2VAfVGWP6UskqGjo6BDeL9kwYAE3utoKcmDQK
	 GHhtYksSfyTl3gjLZWz2dehrtDJp4ROmjUZk2R8KlVYGJwPYVol7nwsFLgYhEZuMTg
	 uekn/PmSjZO6Yj21tF7cR+GCB7vRCkGw55dTjxk3SCd9uvNulE+RuL8V9Lr9yAk5Ia
	 u+CY6ixLAPKnwvYW10VR4dHKaqMtSrxKFUW9xCsE5bauDEMvycJFalKuNLB8eYDizr
	 txwrEJzy9fGaGMhRtEX25lZRDGxQcDOuBgoxkNNZYswROFE8zwxqVSMMwd3E1Ln6b1
	 I7Jx53ncKsmLw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 04/12] mm/damon/core: validate number of probes in valid_probe_params()
Date: Wed, 29 Jul 2026 07:02:44 -0700
Message-ID: <20260729140253.87753-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729140253.87753-1-sj@kernel.org>
References: <20260729140253.87753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each DAMON context is allowed to have only up to DAMON_MAX_PROBES
probes.  The central place for validating DAMON probe parameters,
damon_valid_probe_params(), is not validating the upper limit, though.
Do the validation.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1b0f12d17de3a..07f4e7126397b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1401,6 +1401,13 @@ static bool damon_valid_probe_params(struct damon_ctx *ctx)
 	unsigned char max_probe_hits;
 	struct damon_probe *probe;
 	unsigned int wsum, wsum_to_add;
+	int nr_probes;
+
+	nr_probes = 0;
+	damon_for_each_probe(probe, ctx)
+		nr_probes++;
+	if (nr_probes > DAMON_MAX_PROBES)
+		return false;
 
 	if (!damon_has_probe_weights(ctx))
 		return true;
-- 
2.47.3
