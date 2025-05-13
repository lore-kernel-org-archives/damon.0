Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091B56B81;
	Tue, 13 May 2025 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096042; cv=none; b=rP6olKwNhzJ0+2bPDJShayJX3bCp21U1I+b8jZkkFiZrYYmIP5aCtrS9pZ1cqdhWFxd9oYxSdyW7dvYJh2CexWIY6NRXNM32HIku0SRb3sooSRi0yPboSrldj3EgqtLYxI/XXoCdAZzxat+Molsa2qsNCioDf7JYF7ZSDrV+oUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096042; c=relaxed/simple;
	bh=yewlievy6Qnuy2etyGnbRM4hLG3L14FNoqWuRtiYgHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7lGznPj2Wjnk5sR2FfN4tFmI2wyUJQtPGdCyhxfAzpVwI5SKDROVLqtEzaad1lL6lf85CkAbzpCgkNdI7thwbRM+s+kVoD4U0r0pu5MtOA8WnYQp6eximNI0dADkZNbGxMYOaDg3oP8lKOHEKPFeNQnk4qfv7jYzqYyQrbZx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5S/RKCJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5S/RKCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84A7C4AF09;
	Tue, 13 May 2025 00:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747096041;
	bh=yewlievy6Qnuy2etyGnbRM4hLG3L14FNoqWuRtiYgHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5S/RKCJfJEh62ST1HmV5elMRoGVTSM+ZcG6nF1/Wg734Ij1D2uBaCWmrQQikg5Iq
	 oB2oh21+VqNJHc101yJXOeF1wJ7agjFCsZw/Wy0L7bHs+cb354gt1r78xRdzu8QfIC
	 9wPD6vTFGODaAdefk7qSyMv/0zvVYpqqdHtwy4CLI6EkJnnu9brStX7MHJ71vxyDt6
	 TM2J2GbkRKd0NO26aRYk6eHuD31YFzZnHhFT5vAoWXOedHiivUBB8jwOCTW2TnOmuT
	 DQklln2I+0Sg2PIz7X5g4IvIiJGtCwCymbxOXLxJ1ui2FYsdlFB3VQK7t9WMXfr3xF
	 ZXcR6rpH6Av4w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/6] mm/damon/core: warn and fix nr_accesses[_bp] corruption
Date: Mon, 12 May 2025 17:27:10 -0700
Message-Id: <20250513002715.40126-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250513002715.40126-1-sj@kernel.org>
References: <20250513002715.40126-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a bug such as double aggregation reset[1], ->nr_accesses and/or
->nr_accesses_bp of damon_region could be corrupted.  Such corruption
can make monitoring results pretty inaccurate, so the root causing bug
should be investigated.  Meanwhile, the corruption itself can easily be
fixed but silently fixing it will hide the bug.

Fix the corruption as soon as found, but WARN_ONCE() so that we can be
aware of the existence of the bug while keeping the system running in a
more sane way.

[1] https://lore.kernel.org/20250302214145.356806-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 587fb9a4fef8..0bb71e2ab713 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1391,6 +1391,19 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	return 0;
 }
 
+/*
+ * Warn and fix corrupted ->nr_accesses[_bp] for investigations and preventing
+ * the problem being propagated.
+ */
+static void damon_warn_fix_nr_accesses_corruption(struct damon_region *r)
+{
+	if (r->nr_accesses_bp == r->nr_accesses * 10000)
+		return;
+	WARN_ONCE(true, "invalid nr_accesses_bp at reset: %u %u\n",
+			r->nr_accesses_bp, r->nr_accesses);
+	r->nr_accesses_bp = r->nr_accesses * 10000;
+}
+
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -1404,6 +1417,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 
 		damon_for_each_region(r, t) {
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
+			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
-- 
2.39.5

