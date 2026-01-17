Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF72BE647;
	Sat, 17 Jan 2026 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672388; cv=none; b=awzpZaQ/vxsVTpuGxHS9RkWUKqPhqZzBH7fNofzd+ttyT2D1oYVtRA5P/a09ozi24AHd8EoU8TZm3GPUCd91C8orejyc9P2BU9mBuhUZHz1AcdVmn0Y3buKsFzGsPdQIyJ9KjBbyzg005ZFkw+kvTTKcSgqtmjlsdOi0zS13b1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672388; c=relaxed/simple;
	bh=Xy1TOQuzIdfvAfcqzCUwqYv5IDB5V3zJCVUE3twZeQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7kA/RXnJ5FCwPEt3Rtf7k+ZnCvEJ3Z988QGyD6fyT6YfgfMzbLzmTZ+iCMG1B5FIABogVzQpELhSxwVoHJmZ6WT0EiQBmAz74NTQ8QV7NFsV3cXfDr0+wei03MT2uZuvt3ha1IGdE4RddPUX3yj+giYsQ8pMuOnC9B4mxqcyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXkEbTix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXkEbTix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CCFC19424;
	Sat, 17 Jan 2026 17:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768672386;
	bh=Xy1TOQuzIdfvAfcqzCUwqYv5IDB5V3zJCVUE3twZeQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXkEbTixnHyVk3yJ9OgZjXGoQK/cD+60CYlgn4UQIR1mT4RWUQ1VZZtgKDtOaYWEe
	 PgkdBDHBhhevYJxLxqBcMTAd838PemlUmYF8UKzpKQN5QST+zvbt7T47T45BYOTn/9
	 H8EguF1uJ1LCzMMnEC6aP3qqPi29keM2Uks89J72aYmyEJQ1jBI4CFD2cniIhNsI/7
	 hPy6murXrIEMhpIHETC4ca7PtuCoxcmkyVYDZIjr3jfYlRMMLnHBl3Gg26tdg8wllO
	 sGFI7862/JoifkJKccnKRTNhv4E3JKTKWETqq9EbDWXFvzTVfvIqsSGSCljrgrDUe8
	 daGnWPZk1fztA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] mm/damon/core: rename damos_filter_out() to damos_core_filter_out()
Date: Sat, 17 Jan 2026 09:52:53 -0800
Message-ID: <20260117175256.82826-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117175256.82826-1-sj@kernel.org>
References: <20260117175256.82826-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters are processed on the core layer and operations layer,
depending on their types.  damos_filter_out() in core.c, which is for
only core layer handled filters, can confuse the fact.  Rename it to
damos_core_filter_out(), to be more explicit about the fact.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 54a7ea98340a..ae5b772ceffb 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1813,7 +1813,7 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 	return matched == filter->matching;
 }
 
-static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
+static bool damos_core_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
 	struct damos_filter *filter;
@@ -1960,7 +1960,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 				goto update_stat;
 			damon_split_region_at(t, r, sz);
 		}
-		if (damos_filter_out(c, t, r, s))
+		if (damos_core_filter_out(c, t, r, s))
 			return;
 		ktime_get_coarse_ts64(&begin);
 		trace_damos_before_apply(cidx, sidx, tidx, r,
-- 
2.47.3
