Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE22D3ECF;
	Mon, 29 Jun 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744945; cv=none; b=L6p2EsjPijo0c7yhLAq27xdHfL9S/VM17TIyxpCTVn6ZhS6bR/OvcBQPk3pPXQN8IgOdx2/NSstdILX6BRoeyMp5iTtBcsWkr/r1JF1HRiIwLyQXupzzNJrWrBxuNfuDMuIS2YPmzB7LHdoCcr+XT9ZYliO/yc/pfbv7GlmXGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744945; c=relaxed/simple;
	bh=Mql/l83FECvFqg0Gh57RZqJvWvCvaXofOvjdJf4tikE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJHO2+bH3XOMRJiovgycseuS6nSZjyPmG4R4uyC7gEbn3+Z8jQEfftsjtghMXFv3r2v00srtD+7TPB3Ddmhvzlb5krr1NSZL5wkHaeadm0G+FtrnL+yrxNGiAXXcs7vAQV9GTXuv149R1H+LYqOHnS1Dga76lN5bQLasVxen2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+GrKNZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+GrKNZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC58C1F000E9;
	Mon, 29 Jun 2026 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744944;
	bh=pL/OIFxAfmJMENrJselHOaTQtQ71A4Uv2SXDoGfSIdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f+GrKNZl7rNDdeHLjnA2IB+t3bNGbNvt5GRbLNylwd+JKc+cKoP7w8Fz4BYL4Rqqr
	 gFT6c0KH0T1AalBrpEGas5knLBzNAM3qvYqjZgmVuUOlBw+q9989VvK6+yPzWb2UyW
	 e0QOaZ+MVQJzwy1ggUIhkmRczkXuvnc7fh8IPD9if0B3NKooMt8jss/76jTUfviBmy
	 /aoSOQH24JiPeacnNEtiIjHbY0GUe4qWT/w7Q318mehq/RvzxycjrT4l+0+hXqwr8i
	 6Z611YYQ+KzizEl3blr1WDy8CDzWgtqALDZj2RvKi44PiqoDTMlN4NBVQwzv99uzb2
	 pfz8FLfsvZcNg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	SJ Park <sj@kkernel.org>
Subject: [PATCH 1/5] mm/damon/core: use kvmalloc for target regions array
Date: Mon, 29 Jun 2026 07:55:32 -0700
Message-ID: <20260629145538.134832-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629145538.134832-1-sj@kernel.org>
References: <20260629145538.134832-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akinobu Mita <akinobu.mita@gmail.com>

damon_commit_target_regions() temporarily allocates a single contiguous
memory region using kmalloc to store copies of all damon_regions of the
damon_target.
However, if the damon_target has a large number of damon_regions, the
total size may exceed KMALLOC_MAX_SIZE.

This problem can be avoided by using kvmalloc instead of kmalloc.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: SJ Park <sj@kkernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260603112306.58490-1-akinobu.mita@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3dd2750c2ef20..ded76719e8a14 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1362,14 +1362,14 @@ static int damon_commit_target_regions(struct damon_target *dst,
 	if (!i)
 		return 0;
 
-	ranges = kmalloc_objs(*ranges, i, GFP_KERNEL | __GFP_NOWARN);
+	ranges = kvmalloc_objs(*ranges, i, GFP_KERNEL | __GFP_NOWARN);
 	if (!ranges)
 		return -ENOMEM;
 	i = 0;
 	damon_for_each_region(src_region, src)
 		ranges[i++] = src_region->ar;
 	err = damon_set_regions(dst, ranges, i, src_min_region_sz);
-	kfree(ranges);
+	kvfree(ranges);
 	return err;
 }
 
-- 
2.47.3
