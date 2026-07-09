Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EC41A79E;
	Thu,  9 Jul 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605967; cv=none; b=Q/k99LgXcE08z60bHAZya6SefV8Ld/Qx6Xb8/RKamCpD3FY4FL3FnswLyLzswn/8a7gkADYb6YKOCsXy7vWfXAA63aCoYrnBrI8sEnT7+gFnogAB4dKHRKq8E+yXhaGTbvVnjoMPKupEdPCpz6F7/TQq6mLy8fe1BCnd+1bsdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605967; c=relaxed/simple;
	bh=nEsmjY06Hyev02Kgci90eG1ifza3IYtKh9jBRs/isCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rqg7N0KBMt7WDla606b4zu3qG3yb9r136OzKpL5NPy9dIfMr0hLkRgrIl1m5NYkzdjsJo5utjBf8LpogLOee2cvsga6Posz2uCUf37xfQUX+GCLXWwVEuW1a1jZf/IC9k9bUAMUq4PYJ56si1bJMlYAyuMXVlvQyoA7HQQVgd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr/8IaT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr/8IaT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152B91F00A3A;
	Thu,  9 Jul 2026 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605966;
	bh=Afvkxg7JDGHDzuDLSPibRSpczK7Yb0J9zCK+iiS9Hlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wr/8IaT1YIogiEeE+7VXNxpm5ekZswKIm/Y6AkWJ4zeAYVC0AUKr2TxCMlSwHKT1+
	 HbzWenPOjTFMNfIGdIx3Da0MH54BjfNfRxqfrnSwEfJDtd4Qnot5+gAOLSyKd4xpv4
	 H3O2uuJnPGtUt9teMEmtMliN5k0hGm6iLsvh49SwTLrUb/uqRS2+9GZxdf3acq3pO4
	 jMfrfzi7zsh/YNedPD3XJUpEm8imhKoebaMrnRXoYlBRWoMUxO9FrAdCzPPbfbh6qo
	 lQRyZ8z/yePxPhyenAHgmBZ7nQKbSoQpjtQbXy5LjitT3xedRDkGkLMdX6Lnbuy+Gp
	 +knKLaXO+3PjA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 07/19] mm/damon/core: use abs_diff() instead of abs()
Date: Thu,  9 Jul 2026 07:05:45 -0700
Message-ID: <20260709140600.90950-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
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
