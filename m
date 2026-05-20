Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772BE37475B;
	Wed, 20 May 2026 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258549; cv=none; b=DTkgCAWLcsYFBXR1rdKJOYMrc2DSr5YwsOJFfS6fSsETQryZuHOY+lO4G64UaPYQl+L5ZHWc+JtXXbXddXUTEoE3mwLH0XSVCUaS7V60l1DboloSO2m2WX5+jLgGKar+jFw8AAelIOo0kWtei/bNgeMPq32CCyiPVELtvWv4xVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258549; c=relaxed/simple;
	bh=SeQSeIT9kw4GiQ+HZa+CgcRvg0CvL1bbL4gPUN4MWDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCPEJWLRXBDNoXqFqooZT+d/6dE9xQRbNfmYQ3op0hIWiPbWDk1e0smyMVB4im7WTziBVzuCuOK31m0hc4iDNy3G+7tZNzQ/WFzeENtM1edYWI8ZjV8LOv4ThIh9dbQXQE5l1kPid5LQrT1qaEMhkuYR8KzkSJJus0TYKivrnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jeb/k8EC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jeb/k8EC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366C81F00896;
	Wed, 20 May 2026 06:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258548;
	bh=iMM8ZRfSsARmGo6eD+hRIbIxGHEMj2jHM5nMAylgAOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jeb/k8ECSQYxRI6pMowOh6vnr6v2+UOutb5+7NMmpN8FF1IXZJpsjUuTQ9yd2SvSq
	 5Ag7I03DN6djHqW2oGpkQZXli+vphAS5DiYacQptubs5ef09jxEkGFgiymJqWZBncz
	 9tPZte19BmEfU7f9nnGBfD+35oHbSe2O+HSDpgHH6J0AocP9YcvoFXKlwLRL+WrM2k
	 WARX6EZRiFghYcrWO+oIaogBGaOEhXqF6VY/PUnMhboG3444EjP/YT1YyUcE4DA1OJ
	 owN7iJszrl0AaSTlrb/LoFVzShHxxKa060kCKlomnzzS7kVMvcPjUvwjwHhZzzzkg1
	 HY9i5KvXSAbJA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/14] mm/damon/core: do not use region out of a loop in damon_set_regions()
Date: Tue, 19 May 2026 23:28:34 -0700
Message-ID: <20260520062858.167011-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_regions() assumes the DAMON region iterator is referencing the
last region after the region iteration loop is completed.  The code is
indeed implemented in the way, but that is not a documented safe
behavior.  Hence it is unreliable and difficult to read.  Cleanup the
code to avoid the case.

No behavioral change is intended.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 40946a7f6f549..e8cf3632115e5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -374,6 +374,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	for (i = 0; i < nr_ranges; i++) {
 		struct damon_region *first = NULL, *last, *newr;
 		struct damon_addr_range *range;
+		bool insert_before_r = false;
 
 		range = &ranges[i];
 		/* Get the first/last regions intersecting with the range */
@@ -383,8 +384,10 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 					first = r;
 				last = r;
 			}
-			if (r->ar.start >= range->end)
+			if (r->ar.start >= range->end) {
+				insert_before_r = true;
 				break;
+			}
 		}
 		if (!first) {
 			/* no region intersects with this range */
@@ -394,7 +397,11 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 					ALIGN(range->end, min_region_sz));
 			if (!newr)
 				return -ENOMEM;
-			damon_insert_region(newr, damon_prev_region(r), r, t);
+			if (insert_before_r)
+				damon_insert_region(newr, damon_prev_region(r),
+						r, t);
+			else
+				damon_add_region(newr, t);
 		} else {
 			/* resize intersecting regions to fit in this range */
 			first->ar.start = ALIGN_DOWN(range->start,
-- 
2.47.3
