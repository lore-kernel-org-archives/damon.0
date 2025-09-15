Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72CE21FF48;
	Mon, 15 Sep 2025 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901494; cv=none; b=jcQGQ8h8a1AQakdZiSOpBp6iBkTwrHhIR8493TZiD9Jr965jnHkljNdNGZQNXAAc1f40BR9vrsxIwjMjTtqQIGsaJwWO9Ozz7RZyHL23ZAqHn0NH9WMlv2D+q63o2uf8DvZ1m7X9NMyy11L5jmWexQ8xVsCE2uHls8jiXQx9vDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901494; c=relaxed/simple;
	bh=LPyFMKB43zMlbHRsGJfXl3nVz2GmOh2C7PouLJ938HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U+hB0sXjCdETIhPr8GVtJQDEpLgeCl1N9Mfof910xRLwRYRxQbJTZFvQJlfdtozdBJi4sIl6c15AZcKNeMtxDwkRGlSUZVYfwCQ1nhu1fKry1eRJ6ZbIChkpTSSJUli47da/j516GgiBOL4IxUSOqIBqBLwSIgZXywgmhZd6DrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvG8ia4q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvG8ia4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C31CC4CEF0;
	Mon, 15 Sep 2025 01:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757901493;
	bh=LPyFMKB43zMlbHRsGJfXl3nVz2GmOh2C7PouLJ938HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvG8ia4qP38O3NEYaj64HpSn7dn2Ni8E73J+n/o/qiKCt9lL2wdZ+8AeAegbzg4gW
	 aR7iX7LuMoaliorim7TJQ42HGMNIJ6cPJp3hfa5IBm5HBYXqRxR7DKqmbwOALUnrJt
	 A6JP1Fgen11hlDQhrUlLmbVcKU1QP2azOug0XQUf5NmMeegrjy+5DXCIqFuc2AfbuV
	 zWxau/gxB1FW9xmbOU+xmQkkf6HWLv59i4K0Iky1VVflnkJm58lkyCUMQpBNFNkLKQ
	 qXIkN17/to6ZB2MUz8VXNlwIgQQPb+K2Cno1KtZx5r1RmPWggl9i7GmiHUzmymcTN8
	 Jz70PbzrgdzTg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/6] mm/damon/core: reset age if nr_accesses changes between non-zero and zero
Date: Sun, 14 Sep 2025 18:58:02 -0700
Message-Id: <20250915015807.101505-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915015807.101505-1-sj@kernel.org>
References: <20250915015807.101505-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON resets the age of a region if its nr_accesses value has
significantly changed. Specifically, the threshold is calculated as 20%
of largest nr_accesses of the current snapshot.  This means that regions
changing the nr_accesses from zero to small non-zero value or from a
small non-zero value to zero will keep the age.  Since many users treat
zero nr_accesses regions special, this can be confusing.  Kernel code
including DAMOS' regions priority calculation and DAMON_STAT's idle time
calculation also treat zero nr_accesses regions special.  Make it
unconfusing by resetting the age when the nr_accesses changes between
zero and a non-zero value.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index be5942435d78..996647caca02 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2261,6 +2261,9 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	damon_for_each_region_safe(r, next, t) {
 		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
 			r->age = 0;
+		else if ((!r->nr_accesses && r->last_nr_accesses) ||
+				(r->nr_accesses && !r->last_nr_accesses))
+			r->age = 0;
 		else
 			r->age++;
 
-- 
2.39.5
