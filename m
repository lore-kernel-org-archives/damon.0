Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7759410D37;
	Thu,  9 Jul 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605967; cv=none; b=ajninAsVwEZZr42uAKxsgFzt1QLKrzbrfkleXyGghV/jqT2kEbXzE1zppK+p+9unqCN7LO77gyvBIAXUf3MG0HYFP+8iohRSJIv7iuQuNDvzzTHuMMfUN31oPiCDcEhHP0mqI1t1ye7u27kElx4XPb5o0l2b+ANEqdj3YiGb+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605967; c=relaxed/simple;
	bh=YHxSOvVrKoUjiUXnJMH4ZrW2oF5xtuOy/pLAzsk5SiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCA4eCz92PvKivtLbDEXc+x/j7idYgNc7NWhfG93NccDmq0s2XkR3J32iVlbAf4xgscy+L4g5tvK2ajzssI1eqX5rk0DWueIgm9IpnJq2y7CpIJGWUveUer/7YQMoAVwi4sDl0VuscByBXRjN9e+CSKgf1YpVFXLyNZlWEy79sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUz3sC9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUz3sC9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711D71F00A3D;
	Thu,  9 Jul 2026 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605965;
	bh=Jsk2BdFiGUHsrTa06Z4d2++A0lkUUpW19Iv6q2KjyUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nUz3sC9VogqnlEvDBz6j8GRzhpUezqHRCGtum/c7bvZGwCk6XNOD6+2h5Qm9YgPlr
	 TVsnDPKThnYjQ1HrJgw4weB53Z7F44YWf4LYJmXef/N96Z7udtgMl4BA0ucxyRwHtU
	 SbcjrDuBpwkCyCNbLPZU6OdmxUfItPEfhI/9F8IHkeZHYNFwfsitIpfY/X6ZM8TP0c
	 Ttx6HjHtPKFpEI58LQLgjdW7FQxItyAwLFcvYEDiAJh82d2YM2wXlu4nCuDl3epuDf
	 R78rwDqNSiw8q+JSbtFk/qHcv7F6avCsUUae8cRm5tm+jW/Tf/orTqETit8rj24y+B
	 qopUIlxBhdyFQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 05/19] mm/damon/core: implement damon_probe_hits_wsum()
Date: Thu,  9 Jul 2026 07:05:43 -0700
Message-ID: <20260709140600.90950-6-sj@kernel.org>
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
index 4e1845ce83870..516fefaf54dcc 100644
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
