Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5D31A045;
	Sat, 21 Feb 2026 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702596; cv=none; b=APYwH0VXdUo4kWa1gMt2c5cU03HWA3Zj94+khGRyAHU9Il6tNGYhqLIWAjai4DLYf/ZpY++llHjTPwqIgsl43zu8wq2ZgU7EFJG7Ov0joPWK/sMDZXcVzL4XlETHjYpOVZkRkVg3IqOUA+umuthJFwcoQCkporQLU4maTX/qgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702596; c=relaxed/simple;
	bh=eOXf1CiFbFTK2Hv2twtoei0dTOZocW8a2ac1D/Nl1gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfyabqOomnVKwc0u7rQ2QUeK8MFi2E/LlVr0zE+oB1tHy4kkRwN1k1oDU3picWHapYAlrgFM3lDkbToA9+6jL7wco/vl1R7KO+4q8g7wsCRpISN35DLQKWUd4ZWu7z6ssLwzlmfzXuarw/YrZGIl1fC7Qee0tlDiKWxvVd9McEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPXqH15g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPXqH15g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5034EC19422;
	Sat, 21 Feb 2026 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702596;
	bh=eOXf1CiFbFTK2Hv2twtoei0dTOZocW8a2ac1D/Nl1gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPXqH15gc0vWx1tPY2KW4rtGZ3xtY9TJnGEj5MuuopIAYrIOE3Gp/u3xC7iyoW5s7
	 rizkeOvY3ymuZr33ZOXgI9Vbpj4B06UP+pawVuVfELd/rJ6Cb/F2xcvbZVoZrwj9h+
	 xb2hgK+T/98uptk7AL482fkl10Z71jQCFeVsTlclwNamegApuoDKwNjzKOCIxJ9N4Q
	 P2CdS5fRyK3ijCp08GwtNlMdQ+Hj1ZwY46hycYwvF0IGVlWgQSaGuah1vbkLSkkhFC
	 zmn5Bk20/RjYZZI/hBv3bm3X+lCy/AvlmNmvpZ/SMDo/GxmybDfaWYKNAqIr/TUr5V
	 hz/2JUdRgX52Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/10] mm/damon/core: add damon_merge_regions_of() debug_sanity check
Date: Sat, 21 Feb 2026 11:36:23 -0800
Message-ID: <20260221193629.19332-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-1-sj@kernel.org>
References: <20260221193629.19332-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_merge_regions_of() should be called only after aggregation is
finished and therefore each region's nr_accesses and nr_accesses_bp
match.  There were bugs that broke the assumption, during development of
online DAMON parameter updates and monitoring results handling changes.
Add a sanity check for that under CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 291a847a8c9bb..94be598cafef1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2545,6 +2545,22 @@ static void damon_merge_two_regions(struct damon_target *t,
 	damon_destroy_region(r, t);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_merge_regions_of(struct damon_region *r)
+{
+	if (r->nr_accesses == r->nr_accesses_bp / 10000)
+		return;
+	pr_err("nr_accesses (%u) != nr_accesses_bp (%u)\n",
+			r->nr_accesses, r->nr_accesses_bp);
+	WARN_ONCE();
+}
+#else
+static void damon_verify_merge_regions_of(struct damon_region *r)
+{
+}
+#endif
+
+
 /*
  * Merge adjacent regions having similar access frequencies
  *
@@ -2565,6 +2581,8 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 		else
 			r->age++;
 
+		damon_verify_merge_regions_of(r);
+
 		if (prev && prev->ar.end == r->ar.start &&
 		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
 		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
-- 
2.47.3
