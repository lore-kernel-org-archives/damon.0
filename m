Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C9166E8
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D271C43470;
	Tue, 13 Sep 2022 17:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091108;
	bh=9ivYQelMNdPJnaUU9EF7chmzaREKfF8OhPMBITLg3Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMkprEXAQC24XJuiTGGjHyvCehrXWfCWngVdHpBZekHiCxDCwHZs0bOCXOeUCGKF8
	 NAWMZpAkMK5j5PUmvn9X13/I1Xx+Q3H3d8j6AH3HocE847FyXcbB6E0u2ImFA1+HiW
	 XcP4TCbJSNnGyPtX5aBTXrfh8r6R56LOXK7Gx2fZgrTD4kVu1uEWKufBq3AF/YeWfU
	 kFigvWxhkISGTBBEeedP/5RwKIBFKlDPHTlQk3gqZByQpGK9poN3cLcmo80BDROsnc
	 Cjen7hGO3HLbS2379iozDv043UszchvmX+3WKTheH4+4Sw7BMZXvVAjUurep7BxVqc
	 JnJE5k/ZtpKhQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 22/22] mm/damon/lru_sort: deduplicate hot/cold schemes generators
Date: Tue, 13 Sep 2022 17:44:49 +0000
Message-Id: <20220913174449.50645-23-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_lru_sort_new_{hot,cold}_scheme() have quite a lot of duplicates.
This commit factors out the duplicate to a separate function and use it
for reducing the duplicate.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 8d9c3d1fd6be..07a0908963fd 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -135,6 +135,25 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
+static struct damos *damon_lru_sort_new_scheme(
+		struct damos_access_pattern *pattern, enum damos_action action)
+{
+	struct damos_quota quota = damon_lru_sort_quota;
+
+	/* Use half of total quota for hot/cold pages sorting */
+	quota.ms = quota.ms / 2;
+
+	return damon_new_scheme(
+			/* find the pattern, and */
+			pattern,
+			/* (de)prioritize on LRU-lists */
+			action,
+			/* under the quota. */
+			&quota,
+			/* (De)activate this according to the watermarks. */
+			&damon_lru_sort_wmarks);
+}
+
 /* Create a DAMON-based operation scheme for hot memory regions */
 static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 {
@@ -149,19 +168,8 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 		.min_age_region = 0,
 		.max_age_region = UINT_MAX,
 	};
-	struct damos_quota quota = damon_lru_sort_quota;
-
-	/* Use half of total quota for hot pages sorting */
-	quota.ms = quota.ms / 2;
 
-	return damon_new_scheme(
-			&pattern,
-			/* prioritize those on LRU lists, as soon as found */
-			DAMOS_LRU_PRIO,
-			/* under the quota. */
-			&quota,
-			/* (De)activate this according to the watermarks. */
-			&damon_lru_sort_wmarks);
+	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
 }
 
 /* Create a DAMON-based operation scheme for cold memory regions */
@@ -178,19 +186,8 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 		.min_age_region = cold_thres,
 		.max_age_region = UINT_MAX,
 	};
-	struct damos_quota quota = damon_lru_sort_quota;
 
-	/* Use half of total quota for cold pages sorting */
-	quota.ms = quota.ms / 2;
-
-	return damon_new_scheme(
-			&pattern,
-			/* mark those as not accessed, as soon as found */
-			DAMOS_LRU_DEPRIO,
-			/* under the quota. */
-			&quota,
-			/* (De)activate this according to the watermarks. */
-			&damon_lru_sort_wmarks);
+	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
 
 static int damon_lru_sort_apply_parameters(void)
-- 
2.25.1

