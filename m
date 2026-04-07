Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE823DBA0;
	Tue,  7 Apr 2026 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775521922; cv=none; b=qlgFl57fniRxrUUjMKQl9B5yKDcUUOLL786zCCY9RBaG8m6ZtrpPNEnFm3kHTRfUWRUlDVzUATWinmayr0F5eWqPQH85QKGzPk7pMn+xK6vJDe06qg4iXU6mFK/Vj8p1mHJpZTL1c6pWUyKECr3n9FNhj+BdjMzHG+2in73HTl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775521922; c=relaxed/simple;
	bh=e6PdU+sFU0K01P//31v0gwLstVAfukUiXGSZ4qXfxgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGqQ9F4qEE5jB1FMM0dI+2yOhWU5DC4hxO26iQJ6ueOY3dNRDU5fdLU9TPOo5mRnKATcp3QrOSK6S9brNcfzXY+dVrRWrf0zvyB1LNeLMuSgBNnZnPe9ndY/45Cr42UW7bJsGkPJ9iQ70vBSPEptwGP/BELAbUApIuOtbl/thPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8OxJqNe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8OxJqNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B655AC4CEF7;
	Tue,  7 Apr 2026 00:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775521922;
	bh=e6PdU+sFU0K01P//31v0gwLstVAfukUiXGSZ4qXfxgs=;
	h=From:To:Cc:Subject:Date:From;
	b=K8OxJqNeSgov7VyfXY9BqhmgY42pYdzKPlHslDeqPUxlwNM/TjVJaGqePKlGmJ4Av
	 UfaTpT9bxMeoRe5e3nlVBkK3ijzjw0sDqaBXQPyKqB23y45VAnuLvBmMMOVWxjjjQS
	 5ds7sx1dXy+TfLi4gIw/WcZVqT8g0OPcrbLsl2VggE7gQUH5OxTXJas/Mp+AFBGCEV
	 okZ+PnW7XR/SMhrz2nqp0QQEHTSP0QJ90bqEvC/qpax2mwegf7KFBK7+svdNfl/7eQ
	 yVO8q27a6iXz27ioCEzC5Op0xLKJ0n0QSEqWRc5UxhIgqUrJyf3CrO0q/Yw5rp8Bas
	 8g1a+bPRuytIw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: disallow time-quota setting zero esz
Date: Mon,  6 Apr 2026 17:31:52 -0700
Message-ID: <20260407003153.79589-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the throughput of a DAMOS scheme is very slow, DAMOS time quota can
make the effective size quota smaller than damon_ctx->min_region_sz.  In
the case, damos_apply_scheme() will skip applying the action, because
the action is tried at region level, which requires >=min_region_sz
size.  That is, the quota is effectively exceeded for the quota charge
window.

Because no action will be applied, the total_charged_sz and
total_charged_ns are also not updated.  damos_set_effective_quota() will
try to update the effective size quota before starting the next charge
window.  However, because the total_charged_sz and total_charged_ns have
not updated, the throughput and effective size quota are also not
changed.  Since effective size quota can only be decreased, other
effective size quota update factors including DAMOS quota goals and size
quota cannot make any change, either.

As a result, the scheme is unexpectedly deactivated until the user
notices and mitigates the situation.  The users can mitigate this
situation by changing the time quota online or re-install the scheme.
While the mitigation is somewhat straightforward, finding the situation
would be challenging, because DAMON is not providing good
observabilities for that.  Even if such observability is provided, doing
the additional monitoring and the mitigation is somewhat cumbersome and
not aligned to the intention of the time quota.  The time quota was
intended to help reduce the user's administration overhead.

Fix the problem by setting time quota-modified effective size quota be
at least min_region_sz always.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org

Fixes: 1cd243030059 ("mm/damon/schemes: implement time quota")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC
(https://lore.kernel.org/20260405225440.76827-1-sj@kernel.org)
- Drop RFC tag.
- Rebase to latest mm-hotfixes-unstable.
- Slight wordsmithing of the subject.

 mm/damon/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3e1890d64d067..3703f62a876b3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2228,7 +2228,8 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota)
+static void damos_set_effective_quota(struct damos_quota *quota,
+		struct damon_ctx *ctx)
 {
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
@@ -2254,6 +2255,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
+		esz = max(ctx->min_region_sz, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
@@ -2290,7 +2292,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* First charge window */
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(quota, c);
 	}
 
 	/* New charge window starts */
@@ -2303,7 +2305,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		quota->charged_sz = 0;
 		if (trace_damos_esz_enabled())
 			cached_esz = quota->esz;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(quota, c);
 		if (trace_damos_esz_enabled() && quota->esz != cached_esz)
 			damos_trace_esz(c, s, quota);
 	}

base-commit: 7c554c59e5a8142c2aea9fd11afbb0fae8876244
-- 
2.47.3
