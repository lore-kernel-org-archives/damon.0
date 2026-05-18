Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2CB399031;
	Mon, 18 May 2026 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147692; cv=none; b=kr3A8jlGRMmX3r5LQ55AIpsuIoERFUeyOu7vTSJsjKCvRKO1iHskWRGgeENB2NCe7hwT2dPYkiI0v45rc5JfZbOqnxgXNWxuZFj5kndNtiO1FmBKOssemkyGsKw9s1V7oShiLs1KLkFKXJjbMa+uSyfrG91eGI2fS52itPgUkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147692; c=relaxed/simple;
	bh=6FCGqtqPK1Y1yCXdyueYRDbO5bOOUBp7eJYagnQ/2uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfFLetoC/ARJ0xW2wDpbhR9OYIMX6EExm/kakxPnYLrQDhjEj+D8oBex1/DU8N9erx1HCb2XzRfSUUGUT2GLnBZUPycoLuhU6nsJdWhuhC3L3JvD/ZW2IwVvgCKl5l26CZf7C0d8hYDIKzw+F8Wxl5xQfxcrYmzk+7CREehLTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv28qGD1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv28qGD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE061C2BCB7;
	Mon, 18 May 2026 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147692;
	bh=6FCGqtqPK1Y1yCXdyueYRDbO5bOOUBp7eJYagnQ/2uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sv28qGD1fBC1oWwlOv+NYk3ZPwvyCCq+0pmn0h12YcRr9a6RTz4X7Fuf7CrZVMx5M
	 1v7Qd/Zxj7SlJxxCeo1l35krA2BFOocZ2pHjLterqnyfw+8OCWwjGxJ0LI+XSAyoT8
	 Y7ynJDO/U8VSNu8e741JTrvfAOo+BDGxP/l1MThFLPl58R4PGgKebYDC+e13eUm5DU
	 89XBTH2i4eTFRKMApT+F/CaDzBd/t0jvvs0TgC4T+M+5Re1CvDCPR5cLiAJNeniBhC
	 FzJup3NIpnrZAphhx7RoloYSOLXCacq904GFuApJ5zZbtIjpuGXGTy8UQ9sU+Ok5D1
	 Ip06a09ta9vWQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 22/28] mm/damon/core: introduce DAMON_FILTER_TYPE_MEMCG
Date: Mon, 18 May 2026 16:41:10 -0700
Message-ID: <20260518234119.97569-23-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Belonging memory cgoup is another data attribute that can be useful to
monitor.  Introduce a new DAMON filter type, namely
DAMON_FILTER_TYPE_MEMCG, for monitoring of this attribute.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  6 ++++++
 mm/damon/core.c       | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1fb271a35e98f..6a54c601889bd 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -742,9 +742,11 @@ struct damon_intervals_goal {
  * enum damon_filter_type - Type of &struct damon_filter
  *
  * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
+ * @DAMON_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
+	DAMON_FILTER_TYPE_MEMCG,
 };
 
 /**
@@ -753,12 +755,16 @@ enum damon_filter_type {
  * @type:	Type of the region.
  * @matching:	Whether this filter is for the type-matching ones.
  * @allow:	Whether the @type-@matching ones should pass this filter.
+ * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
  * @list:	Siblings list.
  */
 struct damon_filter {
 	enum damon_filter_type type;
 	bool matching;
 	bool allow;
+	union {
+		u64 memcg_id;
+	};
 	struct list_head list;
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5ba7ad4df4351..4fc90b0bdac88 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1433,6 +1433,13 @@ static void damon_commit_filter(struct damon_filter *dst,
 	dst->type = src->type;
 	dst->matching = src->matching;
 	dst->allow = src->allow;
+	switch (dst->type) {
+	case DAMON_FILTER_TYPE_MEMCG:
+		dst->memcg_id = src->memcg_id;
+		break;
+	default:
+		break;
+	}
 }
 
 static int damon_commit_filters(struct damon_probe *dst,
@@ -1457,6 +1464,13 @@ static int damon_commit_filters(struct damon_probe *dst,
 				src_filter->matching, src_filter->allow);
 		if (!new_filter)
 			return -ENOMEM;
+		switch (src_filter->type) {
+		case DAMON_FILTER_TYPE_MEMCG:
+			new_filter->memcg_id = src_filter->memcg_id;
+			break;
+		default:
+			break;
+		}
 		damon_add_filter(dst, new_filter);
 	}
 	return 0;
-- 
2.47.3
