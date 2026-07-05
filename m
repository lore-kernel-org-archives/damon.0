Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7E36C5BB;
	Sun,  5 Jul 2026 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285076; cv=none; b=OyJDuvILAUZj3zwxWhz6VqqSAfC8M/xYzQmV0WWwaxf+9gYantiAjjk5hzKKLMJeFS2TxWAesPC9c+8UVtRilaL3jsx5qCaTftJ9c9ojkgkSt2SCDiJx+YLT1jGQt2mqB4hiR/xWMzg1f0KjeWwJ1VPUj6EfXDLCiISwuQZKucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285076; c=relaxed/simple;
	bh=xCiz0lIETQI3oa5S1aPXncijfXx3Ynh8SSO3TLHFJIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnvuUzq2gfs5Bl44T5zpV01s2luqfaaJq/kWpNbdtSpLFVQyXRL5WR9IsObp6Zjs5NnpekBTCYJcsc4PQwOj6ffi8orWKF2tey7ZwVX8VojSQeLPvLefftfUkKaZ3ijhORhkzElQ5BE0rtR/JAgSW7+WdZhtsVvPIjhxTTttJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc3t1gDN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc3t1gDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF001F00A3F;
	Sun,  5 Jul 2026 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285075;
	bh=cq/lZgoqO37AZM/wd+VdC9Z5R6uQckVYXcY7Ow/7PI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lc3t1gDNtfXoYZS3W+1hV7V78KeIb0Oo+qj2NIguCzvYm//NsMT0Y42liJ+hLlsnj
	 uW2Etkq33qYqrHkfAp85/Zi1ubHF7Qkdlk6u3shlrtVWBE/stJQdOWZ+az7s79rXz7
	 U5kakfVjN7LTvr2gaRKo+HkGzgHZ4peB3Bf/PoxQPRsVfUtH+gJUo/7SvyatbnBnwr
	 vizacExzYAYxTabWIMKBmgMxq7m99fwM6Q9Lveb3mfyhAXkdTvkpEnt4PtH0BTeZKL
	 zff+52ALIdIroPCCxTYiqh0Iv9I1z0pUnudjCy6SW6STw5so8/g24jnnq5YB220beM
	 j5+Lad2ZjYM2w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/16] mm/damon/core: implement damon_probe_hits_wsum()
Date: Sun,  5 Jul 2026 13:57:27 -0700
Message-ID: <20260705205743.98656-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705205743.98656-1-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
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
index 62caa67a3c40c..c43986a3aa16c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1011,6 +1011,8 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
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
