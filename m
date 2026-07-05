Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142A3016E1;
	Sun,  5 Jul 2026 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285075; cv=none; b=PCobipNFwEzNdsWSbhDxScGf80cbVT8FJrQDiWGm/MMjydpe3+Fo0i29HDk0cdUKC8vR+7ls84y01Xx6dfeDzYAAmSxdU5Q+4ekz+mtZvXmhtUOUlno9y3H0aQ8hjNvr2aoHip/bfn3ZQDWHBDflBm/omPC2w5SHe7HwBii8clU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285075; c=relaxed/simple;
	bh=LitvS+8oYyjlvXBWQlhruC3Og00mPnUWLVVbv9WG3aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTygoTJwzn9GvTd4Zndeqqj4tik6nCUj/dlFCD34ykPsWxLaZ21TTCbtWBPCsydB/WJsk7ydCLN1DNSZAGKP1M7HAyvsFC9/4h0SeUn114BBnQrR/eaG1usyjlv2JHgsJ6051dUw/sV7Hq9wNUNSp0CsEh7l0k9osk5sbB7V6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpa9Ws+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpa9Ws+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D371F00ACA;
	Sun,  5 Jul 2026 20:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285073;
	bh=0qg/rQtc4ZF10NY3hyCPz6BwwN6rWMQvMaKKDQZFcro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vpa9Ws+vaP6dLQ2Jvg5viEsvUbec//lvGeaiv+tIQgnzGMLfrPyGhn7xK0j0QE5eR
	 3TOBWS5eX0C90ErtWnfNQLMyjAlK97XZa0RyZZgmgfTUKWePDurufC+YF6bClYRtYw
	 2OC2IVxJJVfgjcvs7EMpK7XkJ6kwy3+MaCGPOe2+0wvNZkWBfkg1vse57rc85/nFY/
	 YAOHG1H5TkvUr4oTZUIOZpDzHNXwWx6sVcLEpmHediGhT1S2lMg2j3lbXa3R3KsxMZ
	 A69ftIrNMmzJQZDOIBmnmjyM3nLebhKhjX2sfX1eWXkeNr81xwYwQPd1azFlsa3TOB
	 VSCbC2uiXL+LQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/16] mm/damon/core: introduce damon_probe->weight
Date: Sun,  5 Jul 2026 13:57:23 -0700
Message-ID: <20260705205743.98656-2-sj@kernel.org>
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

Add a new field, weight to damon_probe struct.  The field is used to
specify the degree of the API caller's interest to the data attribute
of the probe.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 1 +
 mm/damon/core.c       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 19b7e839bde0b..c9c1de7ec0e7b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -764,6 +764,7 @@ struct damon_filter {
  * @list:	Siblings list.
  */
 struct damon_probe {
+	unsigned int weight;
 	struct list_head filters;
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 390e00b3685ef..ca5c3f3e45fc6 100644
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
@@ -1641,6 +1642,7 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
 	damon_for_each_probe_safe(dst_probe, next, dst) {
 		src_probe = damon_nth_probe(i++, src);
 		if (src_probe) {
+			dst_probe->weight = src_probe->weight;
 			err = damon_commit_filters(dst_probe, src_probe);
 			if (err)
 				return err;
@@ -1657,6 +1659,7 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
 		if (!new_probe)
 			return -ENOMEM;
 		damon_add_probe(dst, new_probe);
+		new_probe->weight = src_probe->weight;
 		err = damon_commit_filters(new_probe, src_probe);
 		if (err)
 			return err;
-- 
2.47.3
