Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4A384232;
	Thu, 13 Aug 2026 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599883; cv=none; b=QcmSRQxawFqQPu5Bf2IOIRDqvvE51kkwbQpLOI1kwHxmIztiDZR3hrWMa/jtv+AShGo62Sut8pmJ1dgI6l0o73ZyN9LK70QbVFf8AQjyD9YHVftJVHUzjAo6uUTdas6+bsJoHvG45fxpUditZxBExQdSssgM0AbXsfcJ2Kqtvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599883; c=relaxed/simple;
	bh=axZTWAdNkaqbfw81b8HYeJVw703O5s5cDzE+KJ6R1x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTbO5501/bE8xhLx32Zjl7cGEAZHjRMmXLXxjn1ZsgUZpGwlbCVBYBCxf0sIsokcsARvo9WDzdJDqIuEoQZEXmxWQhHxJ4fKGd8EiLsxZr7HHJvbmUEp4uKWpLd3LYnu6Q4ps5iBzLvJmu86c1VCn/c2ECDyLvPZU9qnPN1FST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTHampD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTHampD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669A81F00A3E;
	Thu, 13 Aug 2026 05:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786599882;
	bh=3ydKZfv20XDA9Yk9OoF1itUqqkZNlBOcLwEjFDoPApk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oTHampD9EL+aNZtVjjB2h74cZMpvrG2Rg7tpIUrpaPKwsd7n901RWDPN777SrZlpp
	 oI8yHNzUjhoibL+KXIY8OoCtw7fLy1q4xkmOzn61cs7XR8LIvtnRw9exlUXdWzu28P
	 0I0iYq0GaEG+7ykgJpjH5p8KgwSKh/Vq6cNjo8gF7e1fHjF8dz56x0b8QG0AlRVwol
	 pJPVD0F9w23zE4wtoIPRzrqBnPDSDPEH5HtePBdwBYbp35i/Hc30kDk/SJy7R6O2dO
	 TFjxV2HyNK9iaD46h9R5UVcTIyDbCkTccqQai9Xm6K9C6ovhC2WyFX6b7qhWDXos1Q
	 CisuQqENrQ94w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/3] Revert "mm/damon/lru_sort: error out for >10000 active_mem_bp"
Date: Wed, 12 Aug 2026 22:44:29 -0700
Message-ID: <20260813054432.101197-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813054432.101197-1-sj@kernel.org>
References: <20260813054432.101197-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 06befa61c427e74319781e6f35a364cfc32dbae8.

The commit was made to avoid zero damos quota goal target value, because
it can trigger division-by-zero.  Now the core layer handles the corner
case.  It returns an error for any attempt setting the aero
target_value.  The corner case handling in DAMON_LRU_SORT is hence no
more needed.  Remove it.

Note that this slightly changes the user behavior.  It still disallows
active_mem_bp of 10,002.  But now it allows other >10,000 active_mem_bp
values. Setting >10,000 active_mem_bp makes not much sense.  But it
doesn't cause critical problems such as memory leak or crash, either.
Arguably that doesn't deserve additional code complexity.  Just allow
it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index f25ee7326e87c..ad8e86dd3a93e 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -233,8 +233,6 @@ static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
 
 	if (!active_mem_bp)
 		return 0;
-	if (10000 < active_mem_bp)
-		return -EINVAL;
 	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
 	if (!goal)
 		return -ENOMEM;
-- 
2.47.3
