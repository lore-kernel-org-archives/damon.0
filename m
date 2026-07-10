Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0572459FE;
	Fri, 10 Jul 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691223; cv=none; b=oEiCbrGI6/7laqH42VoOvHTuIQjdXYmX38lZw9/rSi2143Ip9N/LFX1hhTBI2HV0v38SsBHZArhz+Q29fniQjvMdq+TrtOsfVzqT0rtvNoKh4qcHY8W2bRPg4i/4DMVO6VFKOkklHa76dWs+tSMoweQcfvyX/UsgQw3xpxcEAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691223; c=relaxed/simple;
	bh=9EyMomfNpgIKrmRqleQi79yOzZUamG2ZlpJjdR/jboU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAMyszP4/Ccinm/hbwMN8Czj8LTtASO4BL2lsrlLoz7rijRBiTwb620VdvwXOmUxhdQ7mZDvbdlsvkRX+Sf8eV/YLpoGcfEV6bfquJHh5PzM8ONbl7P2V+EC3SPaZYrFc6LLrHt4Mq2g+KjlvN9EP08BmB/lt2eV9A+T6e/oqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+GZnBQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+GZnBQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB1E1F00AC4;
	Fri, 10 Jul 2026 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691222;
	bh=IV0EL5uoIkcnMjmKSre6/DXBTN2a0ADkNneX2xN/Zgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h+GZnBQFWF3S+QHnUQcBAWTNuuqGOYf13WlRZGm34i8t9SEhEAlcnPFh1+SO1dd/g
	 34w1MqXFm3ZOB0BvK6M+AQexvrGwgH7K/1bnWJUtfuxUoT6m3ZU9uTFmkigA2s1ZJ+
	 wRIYf511g+Cq3zCFPVc+fljCJG7Imr4vezVGdfp9ii40+o1bwBAr9+Ff9cdrBFakxr
	 iN9GV/3u/nRz3PQ3QKbxjU6abzvuYrEF23Gp+VFglg1kGtzGpnpYO6A6n/PG/s8xV6
	 CWUBL5ll6VjDcjgTkxZZdLKmN3h3xazG4JublqWzTTvmL571Rb52SLvUideSgvEG+T
	 62g+eDOQGwONQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/19] mm/damon/core: implement damon_probe_hits_wsum()
Date: Fri, 10 Jul 2026 06:46:34 -0700
Message-ID: <20260710134651.18084-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
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
