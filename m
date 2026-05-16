Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756A36655B;
	Sat, 16 May 2026 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956654; cv=none; b=cs9E2pR4wyZdNQnTPYEcTBcRsMDqlFFGsQlCdfQjmuoMYPQARF2hSCkcVxk9pTmsBE4+egrhIpae2Q6uvV1amg5n51sUcEiMRwHXs3bhtLOpdgkYy/E4ugNmVlp4G7TIAm5ZbcAvniJ7IL0uF8rtH32UYn9YhpeLK2JY5kB5UJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956654; c=relaxed/simple;
	bh=2Ec0kIvSNNzHsY2IUhwcp+UI3Lx0nH8m4xnL8yQciI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogg9I9HZsGpJsKAhOzg30F+snh9hhv53eJQKt3USCDRwOGtPqbP/lMQ+2ISSU/YUVAn9iribWM+ciKXdvJo5yeYqrErfLuIMgleCzansYEIOjN8qSUCFhfTCWA/34X/zAmOR4Try6y0Qn+wH+T4RhgF+TLf5ZHvD8ZY2cYJ+HFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH2ctPE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH2ctPE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C360C4AF11;
	Sat, 16 May 2026 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956653;
	bh=2Ec0kIvSNNzHsY2IUhwcp+UI3Lx0nH8m4xnL8yQciI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KH2ctPE3z+F28KIea6irxq3fcBYKl/QSEhQUsM/8PCcQDij7ql6+QWVLIT7XNCHSq
	 HoCsNFgqLv1hiHcDQWck4HKOdDUBfG9Ss6xuNJNwKXgKB8aQgX2GTvJ00dWD6HFBhM
	 WZPqFaMcDauSCO3Ms1U2z+FymCK1cZwua/EBFh9Ek79VkpjsV/i5OM4rZiaLGGmMPD
	 yP1qsEvC64VWmvN4jRothMj+Y7bRgw5KTLLp9a2mCsrbaz3gDWWOvQXl4qk9bo3mt4
	 YusN/dCrmE49HH6Wym/QDLdLSx6Tu/nW8R1hNNrbKEQjwHJdAaVKXh97qRuJmi0i6N
	 DZyoPHUCVjm+Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 22/28] mm/damon/core: introduce DAMON_FILTER_TYPE_MEMCG
Date: Sat, 16 May 2026 11:37:03 -0700
Message-ID: <20260516183712.81393-23-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
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
index d3b6296700a08..56a76781fde22 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -733,9 +733,11 @@ struct damon_intervals_goal {
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
@@ -744,12 +746,16 @@ enum damon_filter_type {
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
index 11b513eb077fe..332d13d9f8603 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1422,6 +1422,13 @@ static void damon_commit_filter(struct damon_filter *dst,
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
@@ -1446,6 +1453,13 @@ static int damon_commit_filters(struct damon_probe *dst,
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
