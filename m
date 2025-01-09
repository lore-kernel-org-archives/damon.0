Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE7199949;
	Thu,  9 Jan 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445099; cv=none; b=a0ag43TRJnyfjGk3FwNSM6Z2zTa6FlvS1i7st1bBfqgmbpHq49By0X2Sp5li7nO9nMig+aWGHSpZuHCJ3QdvYrnSE20jZlrBd1GvdhsHkhwhdPtBD0v7Cfl8n0We4/it/XRWE7HXFfcKBPMb4gJ9D3O9Jn6W0n1Bjcr/KtAl7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445099; c=relaxed/simple;
	bh=b5/TGNrGU2BJ6e8ROpk/K/qKcaZatsIxBg3oBg+1uiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ALutS0jCOocToA3z6Qcm9g57YXt4CN0nWE0T9Dv5jKolQpY7Mfv7ycxBH6KGnpbqCpBgHnmubUXDhy9IclZb2+yOfsJXi+CVwx76tcZJfWkEevt/RckGb/tdGOxZcKjuYT+V9JM/09If9Pk5A3kL/xrKMvNDXa3/kH87mgcjRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgDCg4aO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgDCg4aO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CACFC4CEDF;
	Thu,  9 Jan 2025 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445099;
	bh=b5/TGNrGU2BJ6e8ROpk/K/qKcaZatsIxBg3oBg+1uiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgDCg4aOnSyKMLbHEiFCUeQulqorcmktJn7pvdk+KyGJPAAKYP3hw5WnF080ziHBY
	 Cux41jLyFii6G1U+3tgU+voGlXx4KWqRYLpSEYExW+CVkQ5SSj6y4Gtr1m7oetsPxb
	 AVNfrzOLWnPEEr9//e9rt1WVoUECGgS1L8P+J/xt47QJXSWgPcrvFeJI8DfJfH2hmR
	 6OlI1rFGwVWfYml11NanvbR6xZPOyAN/n2KEUDZ2YDkVbokqLZ/Fq/jNdbxNXtbfja
	 dawTjerZ+LQVrDupRPjQRich0DOoWSQpmaea/jAlBS+ZKRUfGvgAX1JVimbYIXerqU
	 I1Ol6vWUob6Fw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 02/10] mm/damon/core: add damos_filter->allow field
Date: Thu,  9 Jan 2025 09:51:18 -0800
Message-Id: <20250109175126.57878-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109175126.57878-1-sj@kernel.org>
References: <20250109175126.57878-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters work as only exclusive (reject) filters.  This makes it
easy to be confused, and restrictive at combining multiple filters for
covering various types of memory.

Add a field named 'allow' to damos_filter.  The field will be used to
indicate whether the filter should work for inclusion or exclusion.  To
keep the old behavior, set it as 'false' (work as exclusive filter) by
default, from damos_new_filter().

Following two commits will make the core and operations set layers,
which handles damos_filter objects, respect the field, respectively.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 +++-
 mm/damon/core.c       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 72afba74ac6d..8a2d104df5a3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -348,7 +348,8 @@ enum damos_filter_type {
 /**
  * struct damos_filter - DAMOS action target memory filter.
  * @type:	Type of the target memory.
- * @matching:	If the @type-matching memory should be filtered out.
+ * @matching:	Whether this is for @type-matching memory.
+ * @allow:	Whether to include or exclude the @matching memory.
  * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
  * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
  * @target_idx:	Index of the &struct damon_target of
@@ -365,6 +366,7 @@ enum damos_filter_type {
 struct damos_filter {
 	enum damos_filter_type type;
 	bool matching;
+	bool allow;
 	union {
 		unsigned short memcg_id;
 		struct damon_addr_range addr_range;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 52e50f183ffe..bdde532ebbc8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -275,6 +275,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
+	filter->allow = false;
 	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
-- 
2.39.5
