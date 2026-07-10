Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839B1EA7DB;
	Fri, 10 Jul 2026 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643042; cv=none; b=db0ko0ql1A5uE2H31bJD/aAZS7ZHOHpL75abcQJQro6I7xEFU5wZ4oJ0V9HUs+O1RMyWbDfP2DaVQ/XPoErba6jy4CuUB558T8PwcRGW71zDeLz8GNjjxLx/niXlLQKIwRnpgAjt05nH2TTRYZSHXEbTmIfSEHE7oEIqqPHad2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643042; c=relaxed/simple;
	bh=nEsmjY06Hyev02Kgci90eG1ifza3IYtKh9jBRs/isCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVOv1/0XIOj8I9+RNfSgXVl7MXgZ4z/KSQ14TjrC/pmW0iuTnxeJoSjf2UDZQNi9tZq1I5Y8TH4r2cLVoegeb9W3QG+t+cueK16TBIL3Pl3DH1EeBJfxqlim+KeeqLw1dFHLouzc0LsWziZ4qdAXOdKaQV1AO0DgyMqenwU8vfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD6ITAf2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD6ITAf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57DC1F00A3A;
	Fri, 10 Jul 2026 00:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643041;
	bh=Afvkxg7JDGHDzuDLSPibRSpczK7Yb0J9zCK+iiS9Hlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hD6ITAf2Zsiq8wZRypCUXKFrsfJY4IQ6OnuTGPbEYiz14+mnkxjghaK5xr9tRT7lC
	 ChZ8K96sA+5MyIkWz/g1+K5i5m+3W+z3tImfbalH4vLvwKILa2afVqPw4XCjrzYYdO
	 nAuPUR+H8/whyTesGqLo3EJkHQzqxFGAN0+yObygU8CWpKM5Kj7yhjm904b2USZmFw
	 /A7we/IgtIzXX+fCy+vEmdNPuil2LDRqyOVrvgvhf2At5JVaBq/nkzBASFRtZ69w7r
	 BujozuOoXMLiAZM4xWduozWYsRqoxQp/vdBbuLdF5FCdCDk3bgeUIZIX0IriNk/B5c
	 53VJuvUbqNlHQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 07/19] mm/damon/core: use abs_diff() instead of abs()
Date: Thu,  9 Jul 2026 17:23:33 -0700
Message-ID: <20260710002349.111414-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of abs() in damon_merge_regions_of() could cause a silent integer
overflow since the macro casts unsigned int to signed int.  It is
unlikely to have such a large value for nr_accesses.  Even though it
happens, the user impact is just degraded monitoring results.  Users
showing bad monitoring results for weird setup is quite trivial.  But
the code is obviously wrong.  Use abs_diff() instead.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260705213817.100841-1-sj@kernel.org/

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index fea97399b5754..4c7e8a12a9b67 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3261,7 +3261,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
-		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
+		if (abs_diff(r->nr_accesses, r->last_nr_accesses) > thres)
 			r->age = 0;
 		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
 			r->age = 0;
@@ -3269,7 +3269,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 			r->age++;
 
 		if (prev && prev->ar.end == r->ar.start &&
-		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
+		    abs_diff(prev->nr_accesses, r->nr_accesses) <= thres &&
 		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
 			damon_merge_two_regions(t, prev, r);
 		else
-- 
2.47.3
