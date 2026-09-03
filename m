Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A6282F20;
	Thu,  3 Sep 2026 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397650; cv=none; b=g06ELPde5udSu5ocNI0fuB/glHIuyI1KLT66JFLhz93bvWXIfuVN8lnVTcmyNXLmAdR75TaYFE6p3rXVsTn6OVAvtqrZKa4CPvuloRX53G04S/7yHS7IKemThQ1oTo/e9PoeAjfIMD64xBjfE1hBOhl1+/cwQgEEcxrfKS1pdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397650; c=relaxed/simple;
	bh=2yz8Wh+9iL52rMrmr/Wox1uPaC67NPxNvV1yRJ65GMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxtG+kvF8fDciiSq6pQGCuzMkL2ZvMRJUJNj+OVmqXDQ2b9apfej/Rhd7Ww4IqCjLsmW53WxN1HrzNRUYoPoHxf/vGVHA1c0GfNJRRZ0PWs98lG4hS881hrYLNU7vO0nOc5dsfRzFCJO4dXKsVUfaOCflegn18s59iwBvcgOCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULtb46dv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULtb46dv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132311F000E9;
	Thu,  3 Sep 2026 01:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397649;
	bh=Vzm/scJF4B/qwUzRWO3RKybiqI2rNfNYcnSpn8QAXGY=;
	h=From:To:Cc:Subject:Date;
	b=ULtb46dv95AH46NihZ+pCkNhjRhJKn9bWs4Ph7oKX/WbclWjZrVOyYrs7rOITU3UA
	 yEzI4GnKGx/5m32PrvFZ+Di5jEVJNQxlNGXOlg1aqQBkiz6Z7QvEFqVQN34Tn+Z3nJ
	 5rMDuKtEnnIIC6mSUDDwg/Rd0dnS6EQBP4HnZ4pfOsJI1glcQsr4w/T4ZA3+O6BEDK
	 SKJyVEbqGdjvMsABDhAu3mFKPx7JKx8y7KwUjG+E6uYozMZ0eULUnTzwAchM72+2uH
	 WmR6fCndZF0lobx+by8nHpMAfP4MFgCvuN0L861cqah5BC+VHBmY13NXENgRxrDQoL
	 7ZPzP0VHOWj6w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] mm/damon: move zero damos quota target_value handling to the core layer
Date: Wed,  2 Sep 2026 18:07:18 -0700
Message-ID: <20260903010722.94244-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having zero DAMOS quota target value can cause division by zero.  DAMON
API callers are checking the target value parameters to avoid that.  It
is easy to make mistakes in some of the multiple API callers.  Move that
to the core layer.

Patch 1 adds the corner case handling into the core layer DAMON
parameters validation logic.  Patches 2 and 3 remove no more needed
DAMON API callers side handling of the corner case in DAMON_LRU_SORT and
DMON_SAMPLIE_MTIER, respectively.

Changes from RFC
- RFC: https://lore.kernel.org/20260813054432.101197-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.

SJ Park (3):
  mm/damon/core: error damos_commit_quota_goal() for zero target_value
  Revert "mm/damon/lru_sort: error out for >10000 active_mem_bp"
  Revert "samples/damon/mtier: error out for zero quota goal target
    values"

 mm/damon/core.c       | 22 ++++++++++++++++------
 mm/damon/lru_sort.c   |  2 --
 samples/damon/mtier.c |  3 ---
 3 files changed, 16 insertions(+), 11 deletions(-)


base-commit: e5bdf22abf33923f4571fae61ef1e184afc7ddf6
-- 
2.47.3
