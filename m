Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C12673A9;
	Wed,  5 Mar 2025 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213663; cv=none; b=Emb7ptuHPFstmK4He2bewejjI35M5P9aJR4kf35KkV5n97MZnsWfImfdTZTsGsguxBD3/2a3OkCMKrshEXdw/iKbAY0ttdKRqZ8RAJOZujcJUmR3NbhCE7aPWCkY4fPAsWDu/Z7n5OGeW8vKrTYrz0tDJ9B03EM+WX6DQ2bUmQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213663; c=relaxed/simple;
	bh=eJ79aIy+KAG+2fVOvrVZnQksHxdlrGRDAyQqbJ9uXyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iDpBiao/ytTSSP3iZRbq4Vm6HmswguJxYfePD7IfxcISRxYfkvd5p1mCQmLAR6B8yQHQHrIli65B3q8RD57xobe162Iylqs2dgmNWpAd5va0h5JqN74YqJs+4L2KylCL+kFTYd9x/5Api3RUZMrxostVIUnuU9H9mPD+kIbwsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaY2kj8A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaY2kj8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029F5C4CED1;
	Wed,  5 Mar 2025 22:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213663;
	bh=eJ79aIy+KAG+2fVOvrVZnQksHxdlrGRDAyQqbJ9uXyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PaY2kj8AmWawguEdmCNUQobuUZHVxSQUPY3b5C4KFMLUv4x4MgClffxV2X2SoEDmo
	 2QqZPI7a1ppdOMf9pS+qOLU1TMtgeEQJsM4WZ6N3HhzfLqqTJ8FdIA0B9CAiN1V/7E
	 KNsqIPUen/oTYyX9liEVgJgtF6VVcFjV9WrWRXw9lxO8Qe5Ke5DPx3kYmPwgeB1R01
	 psCz6Phx6uBOfw8mwIsAo71+l7gOhjw6+Kf/Es1y0xUj8EAVNqWH8dIWWzasDICDBv
	 Cg2QmH7h/JLcjLYCzUNoOwpoO78b3VhFMQlld6X+6sh13kChAf11m85kcfwc+480UU
	 Qa0iKKbwEl5Cg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/8] mm/damon/core: expose damos_filter_for_ops() to DAMON kernel API callers
Date: Wed,  5 Mar 2025 14:27:29 -0800
Message-Id: <20250305222733.59089-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305222733.59089-1-sj@kernel.org>
References: <20250305222733.59089-1-sj@kernel.org>
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
index 52559475dbe7..eed008b64a23 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -894,6 +894,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		bool matching, bool allow);
 void damos_add_filter(struct damos *s, struct damos_filter *f);
+bool damos_filter_for_ops(enum damos_filter_type type);
 void damos_destroy_filter(struct damos_filter *f);
 
 struct damos_quota_goal *damos_new_quota_goal(
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 194550e033b1..d4fc2c907cfc 100644
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
