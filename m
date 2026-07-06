Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD037A486;
	Mon,  6 Jul 2026 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347562; cv=none; b=OeG/QZWYlxCwLAK1ZBthL4eyOyaoUEoDd86PS5CroRSISAGrSOCOLYhTKYAixObmdgu7PwmHKF7HY0leC2EZNpGglUOlcz+7DmRsNQO64sY93vaPYfzyB+k1BdbHYzxfnTJSgoCAgmy5zq6u1PBMSIZFrDfB1tG/nJeOFmkq5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347562; c=relaxed/simple;
	bh=4x18lTNigIGeXxFeH4b/1U84eMvsCUit8VWCZ3A6sO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9tjrYoh5Ut+PDbWjiQ/L4RL2Zk/9DxU7nmoabI42IPyRYQJ6EAAsP3q5CRZJxHGuIsN8MtQwR7V7ycOAadD1ZVgBnb2iyNqkERByD3zBYPRNCyxKLYoY8PNfmoSGABeqPRDoJm1XHP0hx5RV+tkSTooURfysl/xj1G5hBZV15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOzn+ND9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOzn+ND9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80641F00A3A;
	Mon,  6 Jul 2026 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347560;
	bh=VcWww5ifvnRODUdttj+GVq6VBSGXV/EsAHhoPI+HZt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GOzn+ND9YBjb6bLwwltmgdYGJIebzuoGqSANOwAAPWczWJzio769cUd6gzWaLkYRn
	 Tv9pInA4WNSBzAck/t8eNKChZ+5sfPHe10R4yK04537wtBB69PqtAqOZiv3Smpyguw
	 zm+vGIOhhKWf9Djx7mZcQL7loz9Orv4AmNXlWIMdAyzdgaf+OSS8jlwmVuRy1EOP7n
	 nYDGa2kLggB2KkeLRNt6VHj5HfzeJ+QIvfkm7L6kmUoZI5j9/kaGl7ISlA2IRNv35i
	 JNBmjbBxHepBUzk5elZ2YJ2QgVsDhLksoa3Sg4t+KoqauP8vr7blBWchXHPLdVzJrr
	 IkEmE790OaRxw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 01/16] mm/damon/core: introduce damon_probe->weight
Date: Mon,  6 Jul 2026 07:18:55 -0700
Message-ID: <20260706141912.88445-2-sj@kernel.org>
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

Add a new field, weight to damon_probe struct.  The field is used to
specify the degree of the API caller's interest to the data attribute
of the probe.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 19b7e839bde0b..7d0a920fe4b83 100644
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
