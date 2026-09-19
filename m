Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C70376A16;
	Sat, 19 Sep 2026 01:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780462; cv=none; b=XLFtCr11UQGOrjOE/ABwI4FDmLwrhLR3Ew1mx9FrVwwTWZI2H596/QcWVPJORWYd5THN9ZOzF6m44tEqAlLwd8daVmsS3xosCSOuSxNTpEQX9rz/YfOwote6gJTJGGdgkFrzwYjswDtVfAoV1aYT2bnWSFiACc7FBh2MsT6z3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780462; c=relaxed/simple;
	bh=I0Ap04Z92whhNkXUtcSqXftws+zfURa9umHb8evL7kA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUW2R+P9wAUMRQF9IwKjZV9dxva9t5XloKGFv2QX+zHNmxYqiNS+qDJbN108HZIDNc0iL2F8nGqFg6dM028rmZAmJx0tWHR1bTVNj62rGLzoK44dk79LQC5g7nDpjj6MZyPXz2WoCJhXG1hAzvbuArCOZZtsDbDucMgReJtQf08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj/NwpFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj/NwpFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C431F000FF;
	Sat, 19 Sep 2026 01:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780448;
	bh=Zb5CytK3hYGdz5zNBs0yHNibNYLTEYY9210AEwdD6LE=;
	h=From:To:Cc:Subject:Date;
	b=Yj/NwpFoDHOxMfDN3lLRnXCT5GzM3QUuYF7ZVmAiNqK29M8boQiCTEe8yKrCVj63s
	 fLAk8XbIM1Me0N/FDK0an4iweUCUZS31ludZnpSKf4zY53M9nQtp4wBZzgZMUCnKOl
	 Qj7YDHSocgO3EfuOiZokUsHuBAsOTVZ89swhot8FH+FI1zZeDyrNxWe+ufesq3Pp9+
	 Ute+vkKNPD3DzDg9BLKVfRIPCHj7+bHoTOqYrXa11GonE91i2WVxefTuR7gLS3gpoK
	 lv8ogbNjBUbJaaQ1vGKERY84aEpCPl2g7uppasxSIWtefwVU1PY6QXhbKlu8SN7vyk
	 B+zIMBZhyWPRg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/7] mm/damon: introduce damos quota goal target metric complement flag
Date: Fri, 18 Sep 2026 18:13:49 -0700
Message-ID: <20260919011359.88921-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aim-oriented DAMOS quota auto-tuning assumes the aggressiveness of the
scheme (quota) and the quota goal metric are directly proportional.
Depending on the scheme setup and usage, keeping the relationship can be
challenging.

For example, let's suppose a memory tiering approach for higher upper
tier utilization.  One common idea for that (TPP) is utilizing two
schemes, one for promotion and the other one for demotion.  The
promotion scheme migrates hot pages from lower tier to upper tier,
aiming for high utilization of the upper tier.  The demotion scheme
migrates cold pages from upper tier to lower tier, aiming for head room
free memory of the upper tier.  Both schemes and their goals are in
direct proportion.  However, for this kind of use case, we need to
implement two different goal metrics (per-node memory utilization and
free memory ratio) while essentially the free memory ratio is just a
complemented value of the utilization.

To avoid adding too many new metrics, we are adding metrics that turn
out to be really needed for each found use case.  For example,
some_mem_psi_us, node_eligible_mem_bp and hugepage_mem_bp don't have
their complemented value version.  But it is not really difficult to
expect use cases that their complemented version can be useful.  For
example, hugepage_mem_bp use case may need a way to reduce the hugepage
ratio.  That would require a complemented version of hugepage_mem_bp.
Adding a new metric for each of such use cases could make the number of
metrics unnecessarily high, and discourage flexible usages of DAMOS.

Add a new flag, quota goal complement, to allow flexible tuning goal
setup without unnecessarily increasing the number of metrics.  The flag
specifies whether to use the complemented value of the given goal metric
for the tuning.  For example, if the complement flag is set, the upper
tier memory utilization ratio metric works the same as the free memory
ratio metric for the tier.

Changes from RFC
- RFC: https://lore.kernel.org/20260918142827.85303-1-sj@kernel.org
- Avoid quota goal value underflow.
- Fix usage doc for number of files in each goal directory.
- Rebase to the latest mm-new.

SJ Park (7):
  mm/damon/core: introduce damos_quota_goal->complement
  mm/damon: add complement argument to damos_new_quota_goal()
  mm/damon/sysfs-schemes: support quota goal complement flag
  mm/damon/tests/core-kunit: test quota_goal->complement commit
  Docs/mm/damon/design: document damos quota goal complement flag
  Docs/admin-guide/mm/damon/usage: update for quota goal complement file
  Docs/ABI/damon: update for quota goal metric complement sysfs file

 .../ABI/testing/sysfs-kernel-mm-damon         |  6 ++++
 Documentation/admin-guide/mm/damon/usage.rst  | 15 +++++-----
 Documentation/mm/damon/design.rst             | 13 +++++---
 include/linux/damon.h                         |  4 ++-
 mm/damon/core.c                               | 25 ++++++++++++++--
 mm/damon/lru_sort.c                           |  5 ++--
 mm/damon/reclaim.c                            |  5 ++--
 mm/damon/sysfs-schemes.c                      | 30 +++++++++++++++++++
 mm/damon/tests/core-kunit.h                   |  4 ++-
 samples/damon/mtier.c                         |  2 +-
 10 files changed, 88 insertions(+), 21 deletions(-)


base-commit: 026f1215e57024b54116f6388ca96c64ff84f44d
-- 
2.47.3
