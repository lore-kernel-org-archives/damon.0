Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E6426434;
	Mon,  6 Jul 2026 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347563; cv=none; b=sr+4Jiok45yiy2VT1ETlyQHBWQvktscwq/LKyGJFhNZ6ApwQAtygxJEIGZUQ8mr8GOkQlzgKtqcb/esCfiaFXKSyAYWxl0FzSRJr5LvxNtMZn0umSI4RiomZZ09H0zXAQ7D1UIqMAeGXt3SwED3T9+RX5yQ3S3e91T49msT0et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347563; c=relaxed/simple;
	bh=/+5t0o9xu+bsRb2GO/oa3/OiKrMAIPLZPSw/fBZU+rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXnSUz+ycyUDKZiljmVQE3xc3FnqFBoDGTt5SyAnh2g+sC/q4r2a1wGymx/AmSMtcwLUoyheo3ArdCDoZhdctqaSnufU2u3r4cmQ7XCKyIIRRvANNapFymB8tzYVunxRCuamXopXBRBD/R0CP5PC3bvUgi2ckj9Xdvs9DVmddL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB+zU6z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB+zU6z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19E71F00ACA;
	Mon,  6 Jul 2026 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347562;
	bh=VN5S5Hccw7DXsJXWejcoQSP8t0XO6MZCK5dhIY4HPb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CB+zU6z9na5QxzyFeOVEHjm4j4++wzKU5Oklr0+5bXlWtfixPIpE3D9rUdi5jqCRe
	 FNPC8diLEl95GGpbTC7MCKVT85nM4UyO9Jy7BHuera8KbmN6z7OYS6NSAYYOpJWZGl
	 drphJyr/JQZQmsOzGaSi+XAU08o+bUBXyJ07dmxKrVl3Rl3rjSDguJ1bERpglsnHef
	 ysDSMA8uMWT5+NYEN3Vjv/yPc3Y6r5ed9OzhKhENhBqPXqrCgo7O/j69Rvw0K23jkS
	 4nMAdsG0nYkj5Nok4CqXsQt2+lF7PGsXwyacsUvjayeVEQsMSmisLYxrF71IoLi0+m
	 1RH/u3ZsRXcqA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 05/16] mm/damon/core: implement damon_probe_hits_wsum()
Date: Mon,  6 Jul 2026 07:18:59 -0700
Message-ID: <20260706141912.88445-6-sj@kernel.org>
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
index e1244a06ac7e4..7ecfd72cb21a2 100644
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
index e42f512d87a11..d7d1e27d767eb 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -390,6 +390,30 @@ static bool damon_is_last_region(struct damon_region *r,
 	return list_is_last(&r->list, &t->regions_list);
 }
 
+/**
+ * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
+ * @r:		region to get the weigted sum of.
+ * @last:	if the request is for last-window agggregated probe hits.
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
