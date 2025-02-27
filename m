Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6645156F4A;
	Thu, 27 Feb 2025 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621485; cv=none; b=PZnMenTymPJHSsUFZCOUZrL/5MB3uT0Com/Rc94825jzRZcAsjVco7PhNWpOKVAo1Y13Zi75dGyLVgnX42aL6JVva/GlVZsJMYB296exEFeDPfaiOclzaGjOJi1IJPu/SR7mDIoTcKB7XT+RAwQhGQMyipJKjm4ndQFrUKoIzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621485; c=relaxed/simple;
	bh=OY2pEDCzd2TBvXbxWW+MmytpNlwQ/v7G6etRGptJ9HI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5yv41J2eXIYTR/82wW6/uU6um4vQSJcy1h0QJDalZBS2iBMrZj1f3+L3vq7OTk+o1UUo96D+4wSdpb1InQxgPFW4bKJu8/0sMAr7iQU71faKxR6Z8BWkWgL69tatRc2+YZKrXMMScrixUajSFBKPhHoY44zDrMqJisqidQiNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qdx3MU9a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qdx3MU9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D125C4CEED;
	Thu, 27 Feb 2025 01:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621485;
	bh=OY2pEDCzd2TBvXbxWW+MmytpNlwQ/v7G6etRGptJ9HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qdx3MU9aQ+jtJ3yV54gUkfbBPGrqz/FdGkQ5upGuZlS2dfhhuVbV3LJb5lPg2TI9d
	 tlpr0IlquKAzhEa3FPyi5IUCsODvs40GI9mOzW3gQjQWU8TwYRKSxSx7LPfiz6VHIz
	 a5ok4PeVaVKD+SpVl4aBWh9CaXqHoeozY9FyxbDusP6KnDB5p+UMwQX436msGyG5Io
	 4DLw+kZ7PUwkiRftIC/cFoE46dhnLc997RWk6XfyMUHZTGfhW+sLMKyxrAuF0vx1IE
	 feM8bPwk59P5sSwIXepLSJ7cKH2is5XnwK45Wav8Ig79KwPj2LzANJNq3nJEExvYwV
	 mC8/gsT/34R8g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 4/9] mm/damon/core: put ops-handled filters to damos->ops_filters
Date: Wed, 26 Feb 2025 17:57:49 -0800
Message-Id: <20250227015754.38789-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227015754.38789-1-sj@kernel.org>
References: <20250227015754.38789-1-sj@kernel.org>
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
filters, to given filters to ->filters and ->ops_filters depending on
their handling layer.  The change forces both API callers and ABI users
to use proper lists since ABI users use the API internally.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ffdd84ff6fa5..78126a5145fd 100644
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
