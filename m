Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A033040F8C4;
	Thu, 14 May 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767766; cv=none; b=WH6LndlK0IgUsX+3QGu9MYXQajMYNlzDg5KJdRUiX5y+s8orkNVW2Tsjhy0fitjHm3AW7T0B/iCVj32tRm6SJZjC3z1Z+Xzo63ixxQH5AE/0oaFy1kN6NDAoFU64xONBfI6wpuOyL7X5cjcyvw0ICBM0W405EKj3+apOWTVTfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767766; c=relaxed/simple;
	bh=qOqEZ4mTyQqrPd9Hvgo3jTPU9OytMKPgxXbnEmzq+80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfdB8PYP3EUFrDKy4iJVLBz9bSLoHUf2CBUrEVCUNsD4knDzQ0+0euL3tNRfl7bbGeaT7uOTHg+vQ42MiEiosYa1KurZI/J8b7trbWtmtt+imTdjWM+9ogMZ49iiSvOoWEvasR1KBd3Vr4mPKLXmFP5SBm0O3J4MGS8x3PpZfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXaOZZ20; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXaOZZ20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582DFC4AF1A;
	Thu, 14 May 2026 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767766;
	bh=qOqEZ4mTyQqrPd9Hvgo3jTPU9OytMKPgxXbnEmzq+80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXaOZZ20m4kL030F4QGEu84jVPcoDQ68yJ0/+Z/IzdoJiB6mlp9V4pz4lteFWXLWp
	 l2PQD/b+lKKRcSKi6zc61bHv8alSdZJlMO3HRWVla1E3GKH62USjlEdkWdlTARCnkE
	 Ry+fM3RoJK6Vgf7obfF1PetBp4De6Mfgmt3GkYL4amOsVPJZAghKlbVA1kLpn6SLd2
	 AAPeVPNrhf5HaOvbA3IyOU1BMfzDbSKk2WDmovg7d+mlOJ9pdJPSY4CRT4iG9h8qls
	 auhga034IPjE5yjUC8vz23FVusN+LLiKo+eqzObch59E6VvBT1yCXFXd+DEbuxCizz
	 3I+mEBiJ3UfDw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 22/28] mm/damon/core: introduce DAMON_FILTER_TYPE_MEMCG
Date: Thu, 14 May 2026 07:08:55 -0700
Message-ID: <20260514140904.119781-23-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
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
index 0ad1a0af06893..32c371c98a884 100644
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
