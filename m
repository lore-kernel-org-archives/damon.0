Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449327817B;
	Tue,  4 Mar 2025 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123162; cv=none; b=csnOelId8PbO4b7yvhgYaIQ7SoCtHS68Tg2YWcckilRxGjNKsrt4V9qfjAcplavLqH7BTOIgZjL0zh3tO0J+XpmDCFxNV9psGfoyD8yYQOJC49LT2gIVCJCFVx0IDZ4ls6GMTHAzQyOkVoA5IhXJfUAzZmBHaFFzymXUZfNzH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123162; c=relaxed/simple;
	bh=Fde/lmLSQSXQ1liXQlydq/8+gonOje/B4rUucWXnWA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rxZHWp06tAd3vVBZg9EBtea8AOBTIEggButhlAylvQvV6OmJI8V2rvKdAVtOIFMsSeg+iOJ+pDbhRx2BYvDdqnBNC+3Y2rn3ABWTuEng8zW8dPMJBs0IJI4qgdnUxHjKP+wcwo8U2lWufYn37IH05NGDBOCqsLGvBjdsYXZwRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw3kdZOg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw3kdZOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43718C4CEEA;
	Tue,  4 Mar 2025 21:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123161;
	bh=Fde/lmLSQSXQ1liXQlydq/8+gonOje/B4rUucWXnWA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iw3kdZOgSW/u/FLm6g6CMFJyQVZNC4ZhzRohI9+qPAEsY0NxlJyrAiZ7HGK1eEUgr
	 x4Vk8tfB4zycpMiZPQ0Ww5OvmRiIRsop5SDN2uGnU4JSxklmMLOcyGHAIta55u3jtj
	 9u7ujb6HXYACqm7TwsTaJKYEnF+WxtwF6BOUXTGNls4j4iEZo3W+LnHtxSoYcYXjMy
	 Wz34ShUXRd5QwdamGuRjIMf76gTHMtl58V5ITdvjNatxX26xonqU86up91zLT92NM9
	 27romVx/3IxV+kwLagVS6fpOD+eEtPP8gKwrhszRd7XvB7I7A0yu0WTMV7bLdRnbaf
	 g4tjCZJQWp89g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/9] mm/damon/core: put ops-handled filters to damos->ops_filters
Date: Tue,  4 Mar 2025 13:19:08 -0800
Message-Id: <20250304211913.53574-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304211913.53574-1-sj@kernel.org>
References: <20250304211913.53574-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos->ops_filters has introduced to be used for all operations layer
handled filters.  But DAMON kernel API callers can put any type of DAMOS
filters to any of damos->filters and damos->ops_filters.  DAMON
user-space ABI users have no way to use ->ops_filters at all.  Update
damos_add_filter(), which should be used by API callers to install DAMOS
filters, to add filters to ->filters and ->ops_filters depending on
their handling layer.  The change forces both API callers and ABI users
to use proper lists since ABI users use the API internally.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1daccccb5d67..3fbc31d17239 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -281,9 +281,24 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 	return filter;
 }
 
+static bool damos_filter_for_ops(enum damos_filter_type type)
+{
+	switch (type) {
+	case DAMOS_FILTER_TYPE_ADDR:
+	case DAMOS_FILTER_TYPE_TARGET:
+		return false;
+	default:
+		break;
+	}
+	return true;
+}
+
 void damos_add_filter(struct damos *s, struct damos_filter *f)
 {
-	list_add_tail(&f->list, &s->filters);
+	if (damos_filter_for_ops(f->type))
+		list_add_tail(&f->list, &s->ops_filters);
+	else
+		list_add_tail(&f->list, &s->filters);
 }
 
 static void damos_del_filter(struct damos_filter *f)
-- 
2.39.5
