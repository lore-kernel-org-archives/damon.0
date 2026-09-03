Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B025F98A;
	Thu,  3 Sep 2026 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397423; cv=none; b=J6uRsb0CqVQxq5TKBvOPNcG8NYTaGRvS9hvATBeEzRnTdSXU4Le5aLDGFVrCrafBlT9nEQcLGZbPSxpyB6ycopZdbMRoxnsHAeeXsRtnl+K9KdqGhFHMr8csbspd9olGGm88Yi6KYyMmTixSNlkdKq6F503wH0o7uDa8JXeEmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397423; c=relaxed/simple;
	bh=r4iZrzj5qL7LAWTz63717Wz1x4MBKJBWzcg3SftZdDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LakKKwCYrTkjyAPOQVOSvxYEjczEF0Or9rSRXQMz3Lz1KrLXhuWgmKtlLnQmtu61d+798nZ3iWMvPwCE1NGSD+dcyhL9yIGP6NXKZEwWb11FssRGxlkTKb2xxx8APMZ44EYhbIxkC3Z09s7y4JkEpCijbmQ1hjpgP0KDCqN85JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+egqciW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+egqciW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA4E1F000E9;
	Thu,  3 Sep 2026 01:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397422;
	bh=0ONhJWY5DgYVDUUnZ1xlMrMEr8Cx+Nb9XbB8pDmxhHk=;
	h=From:To:Cc:Subject:Date;
	b=h+egqciWGoWX9TsIcJAj9E+10Dduu+fOKklXNcGnDE5p+hMmzylMqGVmO/W0UphWf
	 s1E32GSyGpmBAB7BLCrKZV78GOKerAxxT/3WeOs+3ZtrVuZ56fDECMNnlOKZpYz+E7
	 uLxleOlms2+ZVfDvUibwFZjCTKxocsA6cjKW7P4kjfZFL0bJAf0ZWQnmROD49Yxjio
	 iLWVAFWUsxxeuku2PW03E8jr6oMq4uGjfOpHre4540vpwLV0M9PO3yziFEW3oG1Dqo
	 TUO1Z4KhV1cdMi6wP6oIrDVIiWsfE2WJtE/6Xd6pXtkWYO4ZSfnqduMTHi4UrL4Iza
	 gEYyAQ5DXzwTg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/damon: allow NULL or unstarted damon_ctx parameter for damon_call()
Date: Wed,  2 Sep 2026 18:03:29 -0700
Message-ID: <20260903010334.93622-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of damon_call() should validate the damon_ctx object parameter.
If it is NULL or never damon_start()-ed object, damon_call() could
dereference the NULL pointer or indefinitely hang.  Ensuring all callers
doing the validation correctly has turned out to be difficult.  Handle
the corner cases inside the core layer and remove callers' validations.

Patches 1 and 2 respectively allow passing NULL and not yet
damon_start()-ed ctx parameter to damon_call().  Patches 3 and 4 remove
the callers side validations in DMON_RECLAIM and DASMON_LRU_SORT,
respectively.

Changes from RFC
- RFC: https://lore.kernel.org/20260813035001.97364-1-sj@kernel.org
- Drop RFC tag.
- Rebase to lates mm-new.

SJ Park (4):
  mm/damon/core: handle NULL ctx parameter in damon_call()
  mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()
  mm/damon/reclaim: remove unnecessary damon_call() param validation
  mm/damon/lru_sort: remove unnecessary damon_call() param validation

 mm/damon/core.c     | 7 +++----
 mm/damon/lru_sort.c | 8 --------
 mm/damon/reclaim.c  | 8 --------
 3 files changed, 3 insertions(+), 20 deletions(-)


base-commit: 7fe9a8a366a72a631bcb23c2b108669ab182f2f2
-- 
2.47.3
