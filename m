Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06872AD3F;
	Fri, 10 Jul 2026 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643039; cv=none; b=r4CldGUe+Mu2cg5sZYxuFcVtO8IfBoqeg5CZ7Su7s2ClO0tWMaXIadW8DRFPQDJPOP0A/lM7IQhwRNgE8hZP6BYIFuxAsMY4w1eNYDok0/eoepuMPaY5kN/1wJaz4A5Afl1SC+wztBjXDVamtDlodbfvO7NcAH5/0gGxSs3zL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643039; c=relaxed/simple;
	bh=tviKD854KaVkPYcfxMm1HzZmaZZ3K9VMpjeBsPs7jf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt4nFbhu62Bifw0nvzrCVtUjveBrR2hgiqKhpL+100ff52HYomPptnd2Ody4BOvx4uE07V2ExI+aTdDogjVRLOdJaeMsBSoab8+CFWcv82XIql9Wlg7zQcN4Y53Y7LyHuKj+jOeVlz66zba/6nsSEVq5yaqxILc7tpaH+XY7bO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDSeZlvP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDSeZlvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E1A1F00A3D;
	Fri, 10 Jul 2026 00:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643038;
	bh=YmfZTk/ZQOqnVMZqrheWjYkpxjXzlgMLoos2A38U/W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XDSeZlvP5bHHzrY9RsxTybFnEaDxTHC2K1IKsQ/7vcQQpkoUc6BnaJQHNbkgzY78/
	 0AbJMjuSIaECN3qkL/eaCvjuNboRYhwkwXi6AVQkANWnyL4ugoRDSPo6INRETzYrU/
	 BE0SLuuRm/320dBmKR96epkQzR8KIbGI7ng8kZabv+3JXkdcz1BPZS06ONfCQ2dsHi
	 A2/TdtftgL0Bk1+q2bue37otzDiQjoxhquRlkbxa13/RHyQWvGZ4BUNtf0Lzoc7js1
	 U08rdf+6nbZ92uvPnv6L2r0Tu3qYXJUkptYzBHibZaU8NXpvKCm7h2h7gMSukEX1QA
	 OiHtoKz1khxVw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 01/19] mm/damon/core: introduce damon_probe->weight
Date: Thu,  9 Jul 2026 17:23:27 -0700
Message-ID: <20260710002349.111414-2-sj@kernel.org>
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
