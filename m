Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B7331EC4;
	Thu,  9 Jul 2026 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605965; cv=none; b=J7lyIO0ORW4mmsZxB5FitpAf9woiKivAmdwLCyJ8dVMiRWmW3UC6aWXTMg8qFHe9zISrhT8sKkilixGPfyuZtf+0pgcbaurN7V4Bxnu6jOqyJS4ErCfLtNxKm6h45tJOxp+YmSpt5d6LxnVGiwesIDP2KPfv4kuJ7YNGYqTAHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605965; c=relaxed/simple;
	bh=tviKD854KaVkPYcfxMm1HzZmaZZ3K9VMpjeBsPs7jf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHoFqEmSHPgv+lUCIMyp3ra2Na6OGxCr9wJOB2NNabKkUNjPD9sbAxx9/tJ3A21Kgq/Ya3LGwlfvdcWgw8VybMAOPsLvhEN/SRgLU3oI6NCTZjlOsVYUkWgMuG0I1/H0l2lfgo8r33oAh8/k+Yg4kEr1ZsOPS+jHomgQCHkdPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2sUUfq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2sUUfq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6241F00ACA;
	Thu,  9 Jul 2026 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605964;
	bh=YmfZTk/ZQOqnVMZqrheWjYkpxjXzlgMLoos2A38U/W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2sUUfq0G7lu48A89v/C5h4pW3ee3Phxf40ZnZ2L4mSF1bR9j5witgW4MHnbMTlME
	 8XwGfeZHD88nz6OFMtrnTLbFC/BMfpOziO11doGr+FLSt0+Il9v5newdhiiSpR+jfH
	 DOzRqW2OVt8hNQK+ZbyvbccaPMMjIqBnvvgJSiroNWORk58GG57sVb54Agu88kXamb
	 LlC/qUuTiBuvvFXpdcpfuABBx1loprpGY1hDiqiNRiIXOUx1/iRXw4IrQ26htunVD3
	 1k6uYjkOljbUzBWYfK/icxxebvbNr1wlLrQ1NSJwV47P0WeyFqQ1rJsyLmZwffyvsl
	 eaqwwSNXsG5bg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 01/19] mm/damon/core: introduce damon_probe->weight
Date: Thu,  9 Jul 2026 07:05:39 -0700
Message-ID: <20260709140600.90950-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new field, weight to damon_probe struct.  The field is used to
specify the degree of the API caller's interest to the data attribute
of the probe.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 63f596957c1f1..d8251c83e6e55 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -760,10 +760,12 @@ struct damon_filter {
 /**
  * struct damon_probe - Data region attribute probe.
  *
+ * @weight:	Relative priority of the attribute for this probe.
  * @filters:	Filters for assessing if a given region is for this probe.
  * @list:	Siblings list.
  */
 struct damon_probe {
+	unsigned int weight;
 	struct list_head filters;
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 11473aa1f70f4..327398fa4ee56 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -166,6 +166,7 @@ struct damon_probe *damon_new_probe(void)
 	p = kmalloc_obj(*p);
 	if (!p)
 		return NULL;
+	p->weight = 0;
 	INIT_LIST_HEAD(&p->filters);
 	INIT_LIST_HEAD(&p->list);
 	return p;
@@ -1658,6 +1659,7 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
 	damon_for_each_probe_safe(dst_probe, next, dst) {
 		src_probe = damon_nth_probe(i++, src);
 		if (src_probe) {
+			dst_probe->weight = src_probe->weight;
 			err = damon_commit_filters(dst_probe, src_probe);
 			if (err)
 				return err;
@@ -1674,6 +1676,7 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
 		if (!new_probe)
 			return -ENOMEM;
 		damon_add_probe(dst, new_probe);
+		new_probe->weight = src_probe->weight;
 		err = damon_commit_filters(new_probe, src_probe);
 		if (err)
 			return err;
-- 
2.47.3
