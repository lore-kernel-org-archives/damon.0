Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867D53C988E;
	Tue, 12 May 2026 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596626; cv=none; b=kJ+u9e6K5ssmly6tWr0HAgW6sJU72c7n3Hj3ogsEKbXFj0HJ8nlkFGrIJfAo/238+k4s0DrMiMJS4n6iOFAwAXUYXie1ilswx+qdEW7rdT7x9yFtpyxV+kmMvx+KGau7UmhGSrFp+JIS8TWY4v661OGe35Sm+8U6sJG6wC3wg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596626; c=relaxed/simple;
	bh=RDSWBAh50cMai+6acyW+AfVUUR9Eit/eslVnRAs5PH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGFRoIluhdtyTK65JvloY/4XE//sQB0nUHZf4Q56f2g1v+fTSccCl78dS3hACMD5tPeyN8Ohm7IMeEIf81jg3Pgt+W+oymHc6v6h/rwTmiC7Lw0kTFVsg7p9o/hez8pAVK4wncjE7TedmMzyjbx8hSpyAKvpmPYV1BOAtGA0XkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjcADgMe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjcADgMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CB1C2BCFA;
	Tue, 12 May 2026 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596626;
	bh=RDSWBAh50cMai+6acyW+AfVUUR9Eit/eslVnRAs5PH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjcADgMeYILQU0boHYv10V+Dio3tUD7L4BXZyaH8N6Fy/Wv3ei35ogEPMmPWNfptz
	 Weu6cImX9OnbWjBATQX7iIB5HZeDsnyweNk7Zr1cvSkOZAwEVsEbTgrfSNOvHZkDvd
	 QMBvrKs3t6z4m0oe0TRm0vJ+U/FlEjY6bye62VJ7yqFojiLJdu5RLt0xAVDJpKzGeT
	 +U8JAKl4SxCdRTNzjScVksA4/wTM5QjaAW+kUmoq99O2wxjb8dwClvHI7H20NlKRiN
	 ziy01Dl+EkbKyvsEOqOJ0Zrn9If8acBZxg0cmvqvtJ8JcsdeptGQpcbpwekL5VU5Jm
	 seyMFVg1NdQSQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 22/28] mm/damon/core: introduce DAMON_FILTER_TYPE_MEMCG
Date: Tue, 12 May 2026 07:36:37 -0700
Message-ID: <20260512143645.113201-23-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
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
 include/linux/damon.h | 6 ++++++
 mm/damon/core.c       | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e9ca40cdd9102..3dec0947b93f0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -740,9 +740,11 @@ struct damon_intervals_goal {
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
@@ -751,12 +753,16 @@ enum damon_filter_type {
  * @type:	Type of the region.
  * @matcing:	Whether this filter is for the type-matching ones.
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
index 14b15c9876516..ef751898a3c06 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1430,6 +1430,13 @@ static void damon_commit_filter(struct damon_filter *dst,
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
-- 
2.47.3
