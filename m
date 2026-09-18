Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACF347500;
	Fri, 18 Sep 2026 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741717; cv=none; b=NWiMxT8I9h5/Zx+SqlSCpBY7HGTPTz13feLHB7ULjx6R3ipIMGiIWXA5AGrB/18mspEcF6alKv0Q0aCsTQBfvDPwl8VTjN0zhfHnyN9JCM6L+ZOHaFvngW9VJ8mw9VDAnnBxNWiyZY18t5MLHZsYiEopD3/Dr+SVtTVZqteKOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741717; c=relaxed/simple;
	bh=X1Xp22Ntm/Mh4KQR7omMAAPu3pnKu5HEufZKpxULxEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o007zqo5DpbxO3adnJ++lbfAs0HGIiaPrnGKvgxjna3UJHwqQH2pR8CICdUU9Oicf2XWeZmqADt4hoc5efS/xU8MwsSvIl07lUncLcOwejk4k8DVA08Zj3eyw0zVc2QwNph4nak2AKYa99NaU11gBkmBDffsxcKmP1MmhIoxtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmtGpu+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmtGpu+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4E41F000FF;
	Fri, 18 Sep 2026 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741715;
	bh=T4fRJKzlEvMyOgw/sRPLjVTFvQlAdW9RAG1NCaNsEPU=;
	h=From:To:Cc:Subject:Date;
	b=AmtGpu+M9Zs9zqLx3ByetdhiTO7KivZkq6OFoQzyDg8VjdNX8/f1aiMvg8urPJiYD
	 pjfUXW5Njt5aHPjQetTenUOQFzf8cSYMm7d30fgs8fKVH3K+z7uHGP7+P7Z2qw6NEz
	 PhmU+zmKMMYCZ3o1HXFCq67rrBUiPy2KJI1ct/czdyhEiZz/EBWrlWul1unuaKaAg0
	 IT6a8WP2JWQGsrzyLXvjGl+i/DjW2CjPwtabq1i9ymLN+vYtzUD27z3SwF6K3rKp04
	 Qk+8RZA0Vg3QyKrP4NZ45e4083OqJCaiI7shMTK8dajjlpydIsh1Ruii3H1+5Tnfsj
	 bHvzbgwqSWGgg==
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
Subject: [RFC PATCH 0/7] mm/damon: introduce damos quota goal target metric complement flag
Date: Fri, 18 Sep 2026 07:28:19 -0700
Message-ID: <20260918142827.85303-1-sj@kernel.org>
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

SJ Park (7):
  mm/damon/core: introduce damos_quota_goal->complement
  mm/damon: add complement argument to damos_new_quota_goal()
  mm/damon/sysfs-schemes: support quota goal complement flag
  mm/damon/tests/core-kunit: test quota_goal->complement commit
  Docs/mm/damon/design: document damos quota goal complement flag
  Docs/admin-guide/mm/damon/usage: update for quota goal complement file
  Docs/ABI/damon: update for quota goal metric complement sysfs file

 .../ABI/testing/sysfs-kernel-mm-damon         |  6 ++++
 Documentation/admin-guide/mm/damon/usage.rst  | 13 ++++----
 Documentation/mm/damon/design.rst             | 13 +++++---
 include/linux/damon.h                         |  4 ++-
 mm/damon/core.c                               | 21 +++++++++++--
 mm/damon/lru_sort.c                           |  5 ++--
 mm/damon/reclaim.c                            |  5 ++--
 mm/damon/sysfs-schemes.c                      | 30 +++++++++++++++++++
 mm/damon/tests/core-kunit.h                   |  4 ++-
 samples/damon/mtier.c                         |  2 +-
 10 files changed, 83 insertions(+), 20 deletions(-)


base-commit: 93d2baf86ca2a321306c5ea2f07e3d936cc4e6fa
-- 
2.47.3
