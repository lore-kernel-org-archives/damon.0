Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8B1D0DEE;
	Fri, 10 Jul 2026 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643041; cv=none; b=od/u+jCGKKml65gQtvLyz73Y0xlcNiNia8L6s6jSxd2cPrrWSeH5wq6MYLtacu0ABnGLJ9o43w1XIVhVmtMGY/2eflpbMmcOONTjFYtoYhNsBrWklIFPRragQEqjzMtRZcOh2oaBL6C7d35haX2i1NjUYfoNEOQ9dPdLuRk2Uw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643041; c=relaxed/simple;
	bh=9EyMomfNpgIKrmRqleQi79yOzZUamG2ZlpJjdR/jboU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JD5E2WFhqc4zfOz+O1XHBskI90FmhHyshBtKYkVNKg0wP2hOY1RQ8fldb+f752yewe+xlayFjcw2szZOPj9HeP4CJgrX/oH4UbHL1m3Lvh0I9Irw+BX9hsC6v4ZkfIAsv+JCMXqp+8JyCnTd+9t0xqC5qc46VMcO1VUZjsQbEk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSUTkoOH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSUTkoOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4081F000E9;
	Fri, 10 Jul 2026 00:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643040;
	bh=IV0EL5uoIkcnMjmKSre6/DXBTN2a0ADkNneX2xN/Zgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HSUTkoOH9HSk9Svfer6M1HuF05EItvDkO1cPTc/KGhCoJlkDDlXgx5Kf6Rj6xO0FT
	 WkXLc3JkLt1bIL7i2KL29tc5DRxQ2tALQsqIlwfuzymvzeL2al4Kfs7fyaQhTouiO5
	 BpQAGujo5qq/MDnsJvvSvga2grou7oKWIMRXz2oy8tE9MBa7MI7mCjnsytXGPX0xS4
	 3K8gl6LSXiy0IUFsFWiFkNJU4zVe676PpJlYsUvcwr78hepYD++YdG9bmh6w8zjThW
	 +QmevC/BQqskyc1RyT2zrEYPE/tmkc70HeJMCD7AHi9G+Yr5iTbNhxyDnn2jotGFTZ
	 MjcC5p9TnSHOw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 05/19] mm/damon/core: implement damon_probe_hits_wsum()
Date: Thu,  9 Jul 2026 17:23:31 -0700
Message-ID: <20260710002349.111414-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When damon_probe->weight is set, the weighted sum of probe hits will be
useful.  It will be useful for not only the users but also DAMON
internal logics like regions merging.  Implement a function for
calculating it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e7acd8e610a64..f69442a9d4312 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1012,6 +1012,8 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
 		struct damon_ctx *ctx);
 unsigned char damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
 		struct damon_ctx *ctx);
+unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
+		struct damon_ctx *ctx);
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9f6cdd810bd8a..fea97399b5754 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -393,6 +393,30 @@ static bool damon_is_last_region(struct damon_region *r,
 	return list_is_last(&r->list, &t->regions_list);
 }
 
+/**
+ * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
+ * @r:		region to get the weighted sum of.
+ * @last:	if the request is for last-window aggregated probe hits.
+ * @ctx:	context of &r.
+ *
+ * Return: the weighted sum of probe hits of the region.
+ */
+unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
+		struct damon_ctx *ctx)
+{
+	struct damon_probe *probe;
+	unsigned int sum = 0;
+	int i = 0;
+
+	damon_for_each_probe(probe, ctx) {
+		if (last)
+			sum += r->last_probe_hits[i++] * probe->weight;
+		else
+			sum += r->probe_hits[i++] * probe->weight;
+	}
+	return sum;
+}
+
 /*
  * Check whether a region is intersecting an address range
  *
-- 
2.47.3
