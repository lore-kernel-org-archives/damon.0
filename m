Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5872623;
	Wed, 29 Jul 2026 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296281; cv=none; b=HDnkN3ul3GCG1G4xIQ5a8LmYcCkB4Q5Z9wtAHeFKkmJDy0pE+VBZ+Qw6EcqqCPuRTUNdp6LuEyq47l9mdDW+5PZyoa7m8Pb4Rhb3TvowiDqJrzUop69GJaefcZExuEoNLKSKpqdXaa8Kc/85DtrOk+2mN0lrRPQpbcgBJlsEMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296281; c=relaxed/simple;
	bh=QvrrtTuipE6vH5VaWbRqnsyzw1mOG22KKMfL8Qk2C24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOpap3GAq2+U9akPSLWboegUSPqQLofp2BlU2FU8oBqRAWlzfuZZ/l9Y9rjORPMK4W4bwMXdqz9PdrKnz4x5MgyoDVYlpACiKqO2cCX8SVTTP1C52WXL7QbP4CyyGcwWTv3i/qvZLd/5MTxULizX/vb5HvD+bhoiHiCcsBv0kCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQNiXv0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQNiXv0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CCB1F00A3E;
	Wed, 29 Jul 2026 03:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296280;
	bh=RY+XUIrZiXuiiU/vLhDSc4ARUS4lqpakXQtTFBEewHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQNiXv0ycuYjmgNZqlyFpDkk3lQmMhdqw9P2NN4wGYy4xL5dlGWUZaLD0HdiEktfY
	 4HkbI6d4qxH1z/maHFy7d0I2x5AQAL2Ehc7t3qkTriqWjUf8coZgMLaAvcpceoZ325
	 va5qtQFhqJ8KLxDnWViuB5V5UjcBnIofg8CMe/7ayGeZBLvkdwV62S077ddlZW7qYI
	 fAy1JtsRc5kydWpZP+lfGPrcEt/1b3q0sXXwx+1DJ7ZxnlYjs2uitISaz9IzgH/lvH
	 crubnLcv2aEaIFGhPN+rnppvAY7lQu/uYyKuSdcIJddPhY1TLEYEmw98MoL235Nmfv
	 DTYJkzRodQWeA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 01/10] mm/damon/core: use damon_nr_samples_per_aggr() for max merge threshold
Date: Tue, 28 Jul 2026 20:37:41 -0700
Message-ID: <20260729033751.131213-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729033751.131213-1-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_merge_regions() open-codes max region merge threshold
calculation.  What it does is fundamentally the same as
damon_nr_samples_per_aggr() but missing a few corner cases.  The
unhandled corner cases should be rare and make only a negligible level
of monitoring results degradation.  But having the inconsistency could
increase future maintenance burden.  Use the dedicated function.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f7c9b94b6436b..4169268d94416 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3470,8 +3470,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	unsigned int max_thres;
 	bool count_age = true;
 
-	max_thres = c->attrs.aggr_interval /
-		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
+	max_thres = damon_nr_samples_per_aggr(&c->attrs);
 	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-- 
2.47.3
