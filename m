Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C47477982;
	Fri, 22 May 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464436; cv=none; b=kpabkDSKHh2z4DqlbfMYAKX0mwI9b6pgT2mH9bUQybAgrDFugds5Ct2LR93bELWqDNFU1aOgIIZt4PMpDxaJVoP1Xob1ATRQYrUBwH1eJMxmdSVnd3XE28p+rXhCELUeFdENvq5u78GncHMMYjlLGSLuhCOBdjDTxfWj51gSJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464436; c=relaxed/simple;
	bh=SeQSeIT9kw4GiQ+HZa+CgcRvg0CvL1bbL4gPUN4MWDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dulvehIG5id7jP8eS+aWomBYOFox8RddUkzgzEsFseYCUOtIjTQ35gke3HDl5arkp4u0FLIktehxRC3TTW1x1zgAgmG+QtgYPIY+t2eZERb27A9WHNJh9HBEv8KkNEoI5E9gP3y4H9FsBqMQyYk0RUwumpApNK7rPFRtF2Kud9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMPU0gcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMPU0gcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3103C1F00A3D;
	Fri, 22 May 2026 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464435;
	bh=iMM8ZRfSsARmGo6eD+hRIbIxGHEMj2jHM5nMAylgAOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FMPU0gcc510b8hEOWl8XNJ7KTOiGytz9l+pUedihaHWFRn6uhRrB/gBOKhTWft8Nb
	 KNUV0QEEPs9xlYvEMDvorRwl7OXRGWmjadBvyhj2HyjAYg+m34AYb/u91F9y6diVBO
	 Fzjrqt4+xp+Byx+X+4H+8H2BBPcQaoV93V4PycUJHwCLiS11ZdUDF9L+zFPqhIYFEE
	 n+CsIDT4AAafAisaotM9bYGCa636a5HiGodSMGZUBFfXxfjPoTWrbndQ4rOwuIK3Uh
	 QZE3ET4nfj7taaOxuJr5/xUXacJmh0Tmsp4ODD97FuQsWcv8IzcwsVuvsS1WLDaTKu
	 xbM1VAq6dRolQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/14] mm/damon/core: do not use region out of a loop in damon_set_regions()
Date: Fri, 22 May 2026 08:40:13 -0700
Message-ID: <20260522154026.80546-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
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
