Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C8413A86C;
	Sun, 22 Dec 2024 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734909145; cv=none; b=kYlGzlY5JwKGX/gxzDpNITvKwNSKj+vu0L3c6h7Gc++AAnlO0lpA4Rken938jEIhfnErzyRut8tcaQy4wPPVLLR217y1w/dwjuisnDWNCtdxOOx1uj8RhB/bJldnzlkHEfR4WyXN7xW+96XJc6GbH8zoq0z9aGEXrtVB8PEehzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734909145; c=relaxed/simple;
	bh=SSI7Tn6SikEE6Gd2Q2oJVusNNucHn6YZQJN4/lEumMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbmQND+9jzZOmuC94cuqPO/0/9AYdmktjie43oS5/fFaDpdYnD+dUbwpPQeLXGu8pMJGOhQfes3DMXMNLIpUdnEZLkibF0c5HkBI14qZRLmWq1Q6fZcUyJ9KlN2QUird4k7xqU2Yvz3ZAFwnuZRpoIolTPg3wHySSY1VjTQ007A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsU6PInZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsU6PInZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CB1C4CECD;
	Sun, 22 Dec 2024 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734909144;
	bh=SSI7Tn6SikEE6Gd2Q2oJVusNNucHn6YZQJN4/lEumMw=;
	h=From:To:Cc:Subject:Date:From;
	b=JsU6PInZI4ZU+mTYWAy3mJrw4QpTpSHHTzuM8brMxVYeb6PV1y8aUjtxnEnq+dDiS
	 rSUCWil/pTvVPz8ohac6pjlw9vQ/UC8khy5mRzGC5rfSRMh87RrZ+Pped3grcKQ5TZ
	 drVYXiW1kaypnjOHgoBv1rBiN7uXO9dOgYq3h+nkVQxo1zHPuUaV+11I4o/EKviRUq
	 H7UQNQ3sGzLayu0Z9VzFWd79U8F0fK4JLcRvvgxx8LcIosoMDLJOrdnCXlCEKfecTa
	 LP5ZkqAEZNldmXFHVRICIJcUXuPJONxKjc+4x38OyaqlVgEV8SLKERPitXqSxWi8iR
	 stmAAIxWDM9gg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon/core: fix memory leaks and ignored inputs from damon_commit_ctx()
Date: Sun, 22 Dec 2024 15:12:20 -0800
Message-Id: <20241222231222.85060-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to two bugs in damon_commit_targets() and damon_commit_schemes(),
which are called from damon_commit_ctx(), some user inputs can be
ignored, and some mmeory objects can be leaked.  Fix those.

Note that only DAMON sysfs interface users are affected.  Other DAMON
core API user modules that more focused more on simple and dedicated
production usages, including DAMON_RECLAIM and DAMON_LRU_SORT are not
using the buggy function in the way, so not affected.

SeongJae Park (2):
  mm/damon/core: fix new damon_target objects leaks on
    damon_commit_targets()
  mm/damon/core: fix ignored quota goals and filters of newly committed
    schemes

 mm/damon/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


base-commit: a2b6c37664ce2d7ab39837dae4078fcb01078f13
-- 
2.39.5

