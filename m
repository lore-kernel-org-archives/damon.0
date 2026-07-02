Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C57344D8C;
	Thu,  2 Jul 2026 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012649; cv=none; b=XJV1fTVJlIzaGTfdjBCYy2qRRY8a4YE3XFMRkALpi5uKPSocBYP+08I+5gFgWp/HeRkVy22B525ZFxUf/zD0v0NdSmXTZfOszNqbOso7ix1dJ5b77yOX/CPXMKNZ4vFHpqAR660m5HAWaMJbGtD106xJaSsc1UoGGT/2vO0sVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012649; c=relaxed/simple;
	bh=eunayg+T4vCH2a//b3uL8j23puIHdfmVQdkw5mBFvFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0RivuaUpjhxz9gSdsNhRHvNBJAeJ9Nvwd4rppxbWkZLvA23QJaXSWQQp7JYCWSBGbG5keJEinzZHBynhD9I3L4BKHtWPDR8lxWPHA0k2klZV2J/lf19sREJ8L3TEPDxs/uiDOag1YtVr7MZBRTCOf7MhOvQOVbNIigwB1Xlv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV0GRM8X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV0GRM8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292B41F00A3A;
	Thu,  2 Jul 2026 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783012647;
	bh=r7SpLxZbspL6XS8P9x+tydUy80YkcthGS0kwmq/oA40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OV0GRM8Xw14V/XJHNFLeOXS6ZRg96+zCIwS8jw1vF/leCd+5ijvesos21lWjHFLZk
	 Yo14tOzcMD5W+ODOYUVYUR23gopp7e+w1uHnJNWq5qWfu3lUhImTvZc5Mj5ORQA23z
	 mQo9dHsu6YHd1wn5xWK5j5FVjjAIJWwwyuaQZaJ7whcdAvvruae7/5uNXEEmxyF9UI
	 or9m0787yhtBQO5QHScsJqoM2EL29hCO4eWfrrxAsj6UIjbBW+rpRLu7EtQIBBnKcJ
	 6Io8LbgYFYSIL0OSEA/qnD3/zLDAkWc9V00Iz5tIk/4Pk18y0eKMNLW1x7NBfri+AR
	 cuRqo1C/WJQSA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 1/3] mm/damon: add damon_region->last_probe_hits
Date: Thu,  2 Jul 2026 10:17:09 -0700
Message-ID: <20260702171714.88278-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702171714.88278-1-sj@kernel.org>
References: <20260702171714.88278-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new damon_region filed, last_probe_hits.  Maintain fully accumulated
probe_hits values from the last aggregation interval in the field.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  2 +-
 mm/damon/core.c       | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 805e089ff4f2f..4f7e305b261c3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -68,10 +68,10 @@ struct damon_region {
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
index b2fc15a3804ff..d45dc87fbbd9c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -302,8 +302,10 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
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
@@ -2047,8 +2049,10 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
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
@@ -3239,6 +3243,8 @@ static void damon_split_region_at(struct damon_target *t,
 	new->nr_accesses = r->nr_accesses;
 	/* todo: do this for only installed probes */
 	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
+	memcpy(new->last_probe_hits, r->last_probe_hits,
+			sizeof(r->last_probe_hits));
 
 	damon_insert_region(new, r, damon_next_region(r), t);
 }
-- 
2.47.3
