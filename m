Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478A264F81;
	Thu, 20 Feb 2025 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080815; cv=none; b=hsseiouH/4YMOVIWRTckiZ7DeiAfZ3v6gjAVT8S5YerSTFjJN1poN0m3vbGOJV9Dmgmm+tmZRHJgdd/8vGG68qGcOZi9DlnxluLe2acTYFkHfovX9Yw8jJ38Uw1PKGaIn376UVJMFR2E1YaqBmpUjyqvOSXHIt3d1v0PpTs2Hxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080815; c=relaxed/simple;
	bh=unBPrgpwY4dqZxI9ZkGpabB3hwhCwXKpoAI9O5yqzHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EY3scEjr5Ttk5jxiEcZZrDx8tXqo/jCukMQ0iR/iagBbptnHsiyK4KwmhFTOoFy3RGHxR4cVck79erP1cttyAci0/IuWYZvAJwgmNuFbEaVBrOiOBDstQnY94nht2ER27id6c4rSquM1DNEu1/0DRBP0eofrzq5DT/Ag/lyYE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WewL63sw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WewL63sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D234C4CED6;
	Thu, 20 Feb 2025 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080815;
	bh=unBPrgpwY4dqZxI9ZkGpabB3hwhCwXKpoAI9O5yqzHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WewL63sw7nGHhNQcUnh0tz/dMaSYlbcPYe2RWUmVq+aytbTyEYmpJ6J5w3nOlu4tT
	 GQ0ICGSmH408g7E32RUlQYub0hg/zDhjc44kR5LL+Sihris56f7X8MBijvaafdP99d
	 TMsc1p8NcfjBl03dknhjDjkCUwNad8S1Zfg8OvSILPUwhYP6FJALgfdL1TYM4dAEzZ
	 LuHi9slL+2/w7NKWzx0yIab130ftf+AcoJbYKdA89jVOGAfSlhjXCnjZHfBMgqaCiw
	 b3Yw/gjvY+BOK2TxjFUCLDpJiUBvseEL/1Fc2ygXSCfhw4OXJQmjFSM04kbBTn3Il+
	 EPzMBOXW9UHAw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/8] mm/damon/core: expose damos_filter_for_ops() to DAMON kernel API callers
Date: Thu, 20 Feb 2025 11:46:42 -0800
Message-Id: <20250220194646.37726-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220194646.37726-1-sj@kernel.org>
References: <20250220194646.37726-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_filter_for_ops() can be useful to avoid putting wrong type of
filters in wrong place.  Make it be exposed to DAMON kernel API callers.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 +
 mm/damon/core.c       | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1d8479f57f85..085f26a2e702 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -846,6 +846,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		bool matching, bool allow);
 void damos_add_filter(struct damos *s, struct damos_filter *f);
+bool damos_filter_for_ops(enum damos_filter_type type);
 void damos_destroy_filter(struct damos_filter *f);
 
 struct damos_quota_goal *damos_new_quota_goal(
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9744ab9ca5c5..273c91e6df86 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -281,7 +281,14 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 	return filter;
 }
 
-static bool damos_filter_for_ops(enum damos_filter_type type)
+/**
+ * damos_filter_for_ops() - Return if the filter is ops-hndled one.
+ * @type:	type of the filter.
+ *
+ * Return: true if the filter of @type needs to be handled by ops layer, false
+ * otherwise.
+ */
+bool damos_filter_for_ops(enum damos_filter_type type)
 {
 	switch (type) {
 	case DAMOS_FILTER_TYPE_ADDR:
-- 
2.39.5
