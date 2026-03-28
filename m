Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C523EAAB;
	Sat, 28 Mar 2026 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774715974; cv=none; b=bjq5S1FLAYRfdPEw+dpAhHLN9DQdv5idNo9EdPgAbu7lu+PjidaFMcBM+5f3Ml84zujpztsltglSyaoCJA1S35dBgFGqcH+jPTJeKfshgPeOuhQfBcQzT2J+fDRdV3H4bAkud5nuV148j/kr1HI+W3DBenysHjw1E31Qzu3ZllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774715974; c=relaxed/simple;
	bh=0PwI1SI+BDoBCXPBrRWqvfcXP+Y8eEc47YaiUYRUruI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZUk2Qo2Ny6NL9AWPPzchOkz4fRbHA3mDk2yPCfSk6Spjky3koOodrBj/PvwtRJXTVmNzavr2mYP0nh/Kw2prFq0kdesnGYKMMLOHIkY/IHnNOvGLgXJRY9vrKpaNQL7wDs+oQq/NusbeE1pGKul0cKHTiJGnbHbpiL5A6ZHVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIYNftcv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIYNftcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B971C4CEF7;
	Sat, 28 Mar 2026 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774715974;
	bh=0PwI1SI+BDoBCXPBrRWqvfcXP+Y8eEc47YaiUYRUruI=;
	h=From:To:Cc:Subject:Date:From;
	b=eIYNftcvj4/Ctr6vTYsINJDWwdgeG9ARYoqiCYAqw8w/O9OPck+HDa45FAtD4/anz
	 lyebe3WhNSw2Ujhm7UXdF9RzgPWL0a5kmTnEcSazr3lVtFXjAinHX5EpQEe8GlIZO6
	 5vC9eGR8AD2KUgPOeRMHjWTi1Dn9mXos4Z2nEPdRoTMx8cF8RcNclfHjjHpPvySU+x
	 NNCruFzN7VoBcW5MUelbNo6jvAsSq8swN5wqXGpN1GobwyRF53R7GFkXeqKeib4h87
	 uoK3DTxzcigI7DUq4Dm2VINyxUJ0boLq2ujjhSG84sPLidKL+NmYjaluOPjdWNlTnm
	 dsVBAcrgemEHw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: use time_in_range() for damos quota window start
Date: Sat, 28 Mar 2026 09:39:29 -0700
Message-ID: <20260328163930.47096-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_adjust_quota() uses time_after_eq() to show if it is time to start
a new quota charge window, comparing the current jiffies and the
scheduled next charge window start time.  If it is, the next charge
window start time is updated and the new charge window starts.

The time check and next window start time update is skipped while the
scheme is deactivated by the watermarks.  Let's suppose the deactivation
is kept more than LONG_MAX jiffies (assuming CONFIG_HZ of 250, more than
99 days in 32 bit systems and more than one billion years in 64 bit
systems), resulting in having the jiffies larger than the next charge
window start time + LONG_MAX.  Then, the time_after_eq() call can return
false until another LONG_MAX jiffies are passed.

This means the scheme can continue working after being reactivated by
the watermarks.  But, soon, the quota will be exceeded and the scheme
will again effectively stop working until the next charge window starts.
Because the current charge window is extended to up to LONG_MAX jiffies,
however, it will look like it stopped unexpectedly and indefinitely,
from the user's perspective.

Fix this by using !time_in_range() instead.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260324040722.57944-1-sj@kernel.org

Fixes: ee801b7dd782 ("mm/damon/schemes: activate schemes based on a watermarks mechanism")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3298ee8d8f64..19ae388ff1e0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2449,7 +2449,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	}
 
 	/* New charge window starts */
-	if (time_after_eq(jiffies, quota->charged_from +
+	if (!time_in_range(jiffies, quota->charged_from, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
 		if (damos_quota_is_set(quota) &&
 				quota->charged_sz >= quota->esz)

base-commit: f16846f15feb80ea9553b860bd0f70d9072101aa
-- 
2.47.3
