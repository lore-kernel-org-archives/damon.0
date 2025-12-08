Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2A320CBF;
	Mon,  8 Dec 2025 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175433; cv=none; b=gcJorvOBvj681L5dogvDF0cV5kdU4wqI05UwQn8bvHJUa3UrXkcescgX1ZrP+lB/RtT+Z2M8civAMdqCPekcOaHpFVJYsPqBdGV8PfTbdGmKJAk4L8VK0zoDvgViGrp5+DE1ClFUQZG7CCPrie2IHVcYP7J7gpAyCETD/NyRhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175433; c=relaxed/simple;
	bh=gwTxa0+Xw/5ku9fEShf6P61CX21upFsU6eEBzrxcpzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T79zt6GorIUIGPUZgFvy4R3zouM+v29Aec0Y40epqiDyx6/lh6UxlWgwFjBErQdJfNvJmdPjkZtAEXH60jX+bBWo7zh1Fg4m/AqNYUCzJlpF6Pnr+fOzP3wkPWYVPykVFfy/qX5LxLfddLwko5OjTFqeA9jycd6AKWN9Fe2Bcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euXt4Rbs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euXt4Rbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66783C113D0;
	Mon,  8 Dec 2025 06:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175433;
	bh=gwTxa0+Xw/5ku9fEShf6P61CX21upFsU6eEBzrxcpzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=euXt4RbsZvz/JVIq9rAtil0vOmQVNcrpPL1Nccoc9a4iX1XyV4b0MLoBdiEspWc+z
	 UiF6XeIRapawls7mzSEnKfrTs+8j2R48XDy9BL07iOO35DWwo0HCY/ttxi/sHwUqxj
	 gb3vJ+tisW6bhNcejx9VhjNpz0iDE+Bc79FP8xMm4LY7KHmPZtWEWb0QZkz0vmkT+5
	 Lrp6xQgaTcjaZSXbLKlCf2GegD8FvCsKyanGqvD7rw+ToXL9z6k6q5y+XYCrcCNFx5
	 uwCmOjS3uUc6QzBnBuEmvPqMxJKaASKq73+b2jQ9Zh1KFr6jZk+7YSM+C0+t+B04Ro
	 3na0LG6r+aL4g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 29/37] mm/damon/core: support threads type sample filter
Date: Sun,  7 Dec 2025 22:29:33 -0800
Message-ID: <20251208062943.68824-30-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Access-generated threads based access sample filter type is not really
being respected on the core layer.  Implement the support for doing the
filtering, and committing the information when doing the online
parameters update.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4971647d4b5e..782af39ef0c0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -546,6 +546,10 @@ struct damon_sample_filter *damon_new_sample_filter(
 	filter->matching = matching;
 	filter->allow = allow;
 	INIT_LIST_HEAD(&filter->list);
+	if (filter_type == DAMON_FILTER_TYPE_THREADS) {
+		filter->tid_arr = NULL;
+		filter->nr_tids = 0;
+	}
 	return filter;
 }
 
@@ -570,6 +574,10 @@ void damon_destroy_sample_filter(struct damon_sample_filter *f,
 		struct damon_sample_control *ctrl)
 {
 	damon_del_sample_filter(f, ctrl);
+	if (f->type == DAMON_FILTER_TYPE_THREADS) {
+		kfree(f->tid_arr);
+		f->nr_tids = 0;
+	}
 	damon_free_sample_filter(f);
 }
 
@@ -1317,6 +1325,17 @@ static int damon_commit_sample_filter_arg(struct damon_sample_filter *dst,
 	case DAMON_FILTER_TYPE_CPUMASK:
 		dst->cpumask = src->cpumask;
 		break;
+	case DAMON_FILTER_TYPE_THREADS:
+		if (dst->type == DAMON_FILTER_TYPE_THREADS)
+			kfree(dst->tid_arr);
+		dst->tid_arr = kmalloc_array(src->nr_tids,
+				sizeof(*dst->tid_arr), GFP_KERNEL);
+		if (!dst->tid_arr)
+			return -ENOMEM;
+		memcpy(dst->tid_arr, src->tid_arr, sizeof(*dst->tid_arr) *
+				src->nr_tids);
+		dst->nr_tids = src->nr_tids;
+		break;
 	default:
 		break;
 	}
@@ -2878,11 +2897,20 @@ static bool damon_sample_filter_matching(struct damon_access_report *report,
 		struct damon_sample_filter *filter)
 {
 	bool matched = false;
+	int i;
 
 	switch (filter->type) {
 	case DAMON_FILTER_TYPE_CPUMASK:
 		matched = cpumask_test_cpu(report->cpu, &filter->cpumask);
 		break;
+	case DAMON_FILTER_TYPE_THREADS:
+		for (i = 0; i < filter->nr_tids; i++) {
+			if (report->tid != filter->tid_arr[i])
+				continue;
+			matched = true;
+			break;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
