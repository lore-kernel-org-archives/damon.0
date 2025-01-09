Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A391A2C0B;
	Thu,  9 Jan 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445102; cv=none; b=RCA/90+wc+1AzPvNBeGfdFCNQLgOAWKr+fKRy3G6zNwSTA8lYkyHfcKR4tBBtmqdILVEdqns4GRh9mJAdt2m/41JIF3sknmfMNdPKMe/FP9f1btZPNcomVWFAr5X6A/QJniQBjJYz5CvlgVR8B+0OYYJ3GDm1yLPqBlFz7KcC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445102; c=relaxed/simple;
	bh=xBH0b3NhxWYTGElmoBJalgG8ZkJmFacZfKWdD6zTD8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sf1K7Xq0onfOwIDrt5BUutnfMfA4zrU6lrAFUbiHEswpp/NiIyNUsXFFPELyZuOH57ra2/w8XvStyR05kRFkB+2JvsIrg3n3D36J62QxCQwFXdjp6z+cL2M4SpgDQ7cX0XLXcxuvgVcvcfIa08CB3TgS9S55G3XGF3/Gx8aDB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2nx70CS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2nx70CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474E2C4CEE8;
	Thu,  9 Jan 2025 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445101;
	bh=xBH0b3NhxWYTGElmoBJalgG8ZkJmFacZfKWdD6zTD8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2nx70CSAa1D7NJ1Q+cniSmR/Cs12oa2tSDvv2hG1MrjskAGMUls70M8xr21kMENF
	 4q4oBrSWzKZkaACyQRBmq70GxYNaZdA47qMw1vGxo9rt4Ku8cfzxiOPHsEeIv59ZDc
	 qXLs7xqDVw10ku1W8NLXWOJFEuLyF8FurvEfdJQ2kqTKgcoAmTBMQu22kmd3nO+zGe
	 YbRgznO0p4Z79IkRv+Kyf8TKpyp1Sk4G9VItMY+3WB36l/+AelHeX8q2MaiNKkSGZj
	 WjQfKQVn8KHfHrpm2FrFCHte+if9KtE0kky8UjLhkiXN9kqr13ZOl5S4S4XU9jvfFa
	 p889H/fWOEIlQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 04/10] mm/damon/paddr: support damos_filter->allow
Date: Thu,  9 Jan 2025 09:51:20 -0800
Message-Id: <20250109175126.57878-5-sj@kernel.org>
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

Respect damos_filter->allow from 'paddr', which is a DAMON operations
set implementation for the physical address space and supports a few
types of region-internal DAMOS filters (anon, memcg and young).  The
change is similar to that of the previous commit for core layer update.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b0c283808ba6..817acfd4f8a2 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -198,7 +198,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-static bool __damos_pa_filter_out(struct damos_filter *filter,
+static bool damos_pa_filter_match(struct damos_filter *filter,
 		struct folio *folio)
 {
 	bool matched = false;
@@ -237,8 +237,8 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	struct damos_filter *filter;
 
 	damos_for_each_filter(filter, scheme) {
-		if (__damos_pa_filter_out(filter, folio))
-			return true;
+		if (damos_pa_filter_match(filter, folio))
+			return !filter->allow;
 	}
 	return false;
 }
-- 
2.39.5
