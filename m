Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD923E342;
	Sun, 21 Jun 2026 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078165; cv=none; b=UGYjD/LkqZHeFTUVkaoBLR2Jm53BBnm3qhoMVGTnHHxZ/VZrqjuH2ARw7cWBs/c759dRPFTHiENm2ey0XcUQSOGuAaGmpvijA4P5yZxrDTBqWtKlbZMAchwb2G6v3bxGetIngHu7+hPtyIKyV7Yuk7FxfEyPnykcX3sz748CoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078165; c=relaxed/simple;
	bh=0JM1jzoF+1wsff6kJRSnHxo/QYw0zeqH0YhMirNLiJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9EKDcVsWi5BDXkfGJzvc+c08sARXA/mR9KCepkNl2lSKiQPO9DV/eTmey1ZFYVgJutH7QZnxgF1J1OGxBQnX7J3HNpW9YsnkdL7LLHcjIKxFYgZe3TZwT0HjIDvSu1g2E4/Ee04bJazhYM3Lx+tycW9aYXcDvmdIxU+xiddYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZGpNdrg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZGpNdrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FD11F00A3D;
	Sun, 21 Jun 2026 21:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078163;
	bh=fjSOxWy3PSIxUzStq8QVNZF0VBLkNihghY1tHfnbiPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MZGpNdrgIMU2RMIZP+UzifZQc3BwsiTl0OCfN0IEQQppQ6OVYcRa5t/yIf3h7Vq86
	 DpKFiSjPxcvnhwbKNevow0an6AY44T1YKu/ObY/Tr+iK6rNWPRJuW986Mnq6OGCL9h
	 5lBUHzMWbH3kPtLLVIY0ZDBFO4zf16fTmNIKStpzuOT/bIhedWgjifuRA+/ux9Tgeg
	 DFSyYa1fZjjFcdxbP6DIufbc7+uHPOcjpeJtaswNoiGZbP9jBz3E+flvpOJfhCzI04
	 Oyaeg+zU6jQscrr3JSbdsqNa3dQb5blC5nULYm7jMi45gBhctNUBWQzqWc1KJ30vTV
	 f1SkXWI+1OUJA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/3] mm/damon: add damon_region->last_probe_hits
Date: Sun, 21 Jun 2026 14:42:28 -0700
Message-ID: <20260621214231.13449-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621214231.13449-1-sj@kernel.org>
References: <20260621214231.13449-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new damon_region filed, last_probe_hits.  Maintain fully accumulated
probe_hits values from the last aggregation interval in the field.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 +-
 mm/damon/core.c       | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index fc3d467dc2e34..f0dd45ca788f5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -70,10 +70,10 @@ struct damon_region {
 	unsigned int nr_accesses;
 	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
-
 	unsigned int age;
 /* private: Internal value for age calculation. */
 	unsigned int last_nr_accesses;
+	unsigned char last_probe_hits[DAMON_MAX_PROBES];
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4f7954b383d18..e84f2f1b07cc6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -304,8 +304,10 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.start = start;
 	region->ar.end = end;
 	region->nr_accesses = 0;
-	for (i = 0; i < DAMON_MAX_PROBES; i++)
+	for (i = 0; i < DAMON_MAX_PROBES; i++) {
 		region->probe_hits[i] = 0;
+		region->last_probe_hits[i] = 0;
+	}
 	INIT_LIST_HEAD(&region->list);
 
 	region->age = 0;
@@ -2024,8 +2026,10 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 					damon_nr_regions(t), nr_probes);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
-			for (i = 0; i < DAMON_MAX_PROBES; i++)
+			for (i = 0; i < DAMON_MAX_PROBES; i++) {
+				r->last_probe_hits[i] = r->probe_hits[i];
 				r->probe_hits[i] = 0;
+			}
 		}
 		ti++;
 	}
@@ -3216,6 +3220,8 @@ static void damon_split_region_at(struct damon_target *t,
 	new->nr_accesses = r->nr_accesses;
 	/* todo: do this for only installed probes */
 	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
+	memcpy(new->last_probe_hits, r->last_probe_hits,
+			sizeof(r->last_probe_hits));
 
 	damon_insert_region(new, r, damon_next_region(r), t);
 }
-- 
2.47.3
