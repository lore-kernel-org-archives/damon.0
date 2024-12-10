Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D323D426;
	Tue, 10 Dec 2024 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867442; cv=none; b=sx0D8E9v5csnKoZ6Ax/cPWbSSuFoYFrG2q3ktTV+Op0xEKcNJICoPjd3tst1KA4Gqq4M5lsO5SCJNKvb6gfcuWnQohDMDD9VZdZXuCbRRWYMNFyoCwIft5Co5+ySH57lUZ1jgPqrbiU0ONZbhHJSSca7ieje1i2lGEwQwKNyXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867442; c=relaxed/simple;
	bh=RRBl+ZZMmihwq3svB0M1vQmUUPQ7A6rMW0M3h5PQx34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJhezVM6h4H508KOcsSvS2jizNXVq6hXvxrXRgzAlSDLWSxcuXLodsqRZ4xeRe9aQKA7dayfO2rrmmA0eEcUIen8XrleiFqb4Osjq/ArArYrXgdjWnDUT05RJwjos/Ow24UL+fMzBG9IWqc/Z0QqH2j1QAVUQEpGvHb2IXN0GEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3prnbLf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3prnbLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94CDC4CEE4;
	Tue, 10 Dec 2024 21:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733867441;
	bh=RRBl+ZZMmihwq3svB0M1vQmUUPQ7A6rMW0M3h5PQx34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3prnbLfsY6KQzK//CrrzVTSX2P1eXC45Vr/x+G6mRozoJeC3hWO6Wn96Lt/kSN3R
	 kuBCaznCZi/tcBYunW1jZhdpQIhdru1DGjJOeg7RKBqcAIPt4eNnkl33vmahTl6qDn
	 gLLXKiYxnJx+hNAtADXtJUpwO2z92wVn9Joeoh1M5Nk3eRPSPDd3sTZHDv8WS2b8BA
	 NlG8jmbhwla0yQoLpZ+dEsFJKrPfR1fJlWRQFFilwze64VEHfAsBFxICiAqZDKd6O1
	 df5yX0VKr8vDPUoY+PucGaICMPCBKi5EN5GkHVYlSRrQ9xN7v4CgpJpMHBAXyjvGDv
	 +D0X/+nWEBc6A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 5/5] samples/damon/prcl: implement schemes setup
Date: Tue, 10 Dec 2024 13:50:30 -0800
Message-Id: <20241210215030.85675-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210215030.85675-1-sj@kernel.org>
References: <20241210215030.85675-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a proactive cold memory regions reclaiming logic of prcl
sample module using DAMOS.  The logic treats memory regions that not
accessed at all for five or more seconds as cold, and reclaim those as
soon as found.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index b34b9bfed532..c3acbdab7a62 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -49,6 +49,7 @@ static int damon_sample_prcl_after_aggregate(struct damon_ctx *c)
 static int damon_sample_prcl_start(void)
 {
 	struct damon_target *target;
+	struct damos *scheme;
 
 	pr_info("start\n");
 
@@ -75,6 +76,25 @@ static int damon_sample_prcl_start(void)
 
 	ctx->callback.after_aggregation = damon_sample_prcl_after_aggregate;
 
+	scheme = damon_new_scheme(
+			&(struct damos_access_pattern) {
+			.min_sz_region = PAGE_SIZE,
+			.max_sz_region = ULONG_MAX,
+			.min_nr_accesses = 0,
+			.max_nr_accesses = 0,
+			.min_age_region = 50,
+			.max_age_region = UINT_MAX},
+			DAMOS_PAGEOUT,
+			0,
+			&(struct damos_quota){},
+			&(struct damos_watermarks){},
+			NUMA_NO_NODE);
+	if (!scheme) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_set_schemes(ctx, &scheme, 1);
+
 	return damon_start(&ctx, 1, true);
 }
 
-- 
2.39.5

