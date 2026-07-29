Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE04772AE;
	Wed, 29 Jul 2026 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333784; cv=none; b=rMu/spM9Q+JMTUCVJMZL9tiz79zJI7N//FcvrSoH+E4txtbORI93LyKCakCiNEZuYTUf5hZWP1hr8F1aPTXDbAyJt7WsPEUcgCNUNAd8SNfnVtwuPus3T/hDzBCM3wm21JHtD0KhKP72r7lNW87p3tmOeVxElL99RSyUp6w5X+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333784; c=relaxed/simple;
	bh=QvrrtTuipE6vH5VaWbRqnsyzw1mOG22KKMfL8Qk2C24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnsP6x4XAnn4rKEF6tnfJmoZw/jODcNT5dLsiqCURcbauHge5W7Zwmbg5Q1MKv7amMBUd2uFqzzb12BbyO4C5ijXaAbxtZ7QvMZgXq4Nl/GpI/ZNGoPold+45oN9yWKpRChG4gUSaqym37JSQmprhVndCXaTYRop4nqSzQ/HNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN3ktU5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN3ktU5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695221F00A3E;
	Wed, 29 Jul 2026 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333783;
	bh=RY+XUIrZiXuiiU/vLhDSc4ARUS4lqpakXQtTFBEewHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dN3ktU5lDjytpxloJrC/aEGv6gmCuCBuPEWJTFSQg/CwHZ5ppoglbsRHGyArQv0t/
	 EDyE+RO+eTv9Ky5DluaWf14vgsb6WF0Y7cTosv8GWxxb+v+Zxo9p+Ye0N9E4MOCW5Y
	 XFCyaO083qWJg3ks1Nw7216x7AxKOq6f2QWDIQcgUBqSNd4Jb1LYW26q6alYcgQAhx
	 2aWW7q0w2N+6qVFxJCKFigi07qg8sGtj1ZPsVNxg0dwiRChppiQlDkde7q3CyNkIut
	 0nXo2Cs2QiWb20Au8NrUlYqQmWRjBUyd8jgA4AgCHxBcT+LmqwR7vwMYshRlCwfvkA
	 EG0sRdx+CwPvg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 01/12] mm/damon/core: use damon_nr_samples_per_aggr() for max merge threshold
Date: Wed, 29 Jul 2026 07:02:41 -0700
Message-ID: <20260729140253.87753-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729140253.87753-1-sj@kernel.org>
References: <20260729140253.87753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_merge_regions() open-codes max region merge threshold
calculation.  What it does is fundamentally the same as
damon_nr_samples_per_aggr() but missing a few corner cases.  The
unhandled corner cases should be rare and make only a negligible level
of monitoring results degradation.  But having the inconsistency could
increase future maintenance burden.  Use the dedicated function.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f7c9b94b6436b..4169268d94416 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3470,8 +3470,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	unsigned int max_thres;
 	bool count_age = true;
 
-	max_thres = c->attrs.aggr_interval /
-		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
+	max_thres = damon_nr_samples_per_aggr(&c->attrs);
 	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-- 
2.47.3
