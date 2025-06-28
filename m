Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320925771;
	Sat, 28 Jun 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129508; cv=none; b=DKjUV03/gO8gYb77vKjB7ioUVeb2SOXXofzg5kpFD+VmLWGYdKSIYhFvuVXuqxfbToakc++CvoVC0QsxOMO/ZB+DVo31vgxaYD1lf0t9zc/oUfzggWogApDj8F5Zc7D1B6gsCUi5Gl3mMQvktAg0oKyW1GQVwqmU9NzbxJHenKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129508; c=relaxed/simple;
	bh=olJKO0kLyWz1TOYHSyUA5GZthC3GQPte6dBjhm22SWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S1aZkpZpFXiwzrfXSPVbMtLKL1IBz8JeDcJNXLm4tDQaRhqS8EY5jq20oHMMwkxZ6ijjcA203pUilfwdqM02alclrV2uN5sWcnMsrv4A73/ItEWc79WzMwAMBhib1a1nmzVlfsJl2a8n8bqerhyDD3doB1uhyQCzbcbxQIysS/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb6oWWRp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb6oWWRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD19DC4CEED;
	Sat, 28 Jun 2025 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129508;
	bh=olJKO0kLyWz1TOYHSyUA5GZthC3GQPte6dBjhm22SWU=;
	h=From:To:Cc:Subject:Date:From;
	b=Xb6oWWRpKsdA7r+GNbKMOHLJp2HY7ouxnBxplbcOiuX93qrNvKSeugvkZLq61Ehbq
	 OaaVhwPmtjyEMhFCwrnw31k2htx2hnzSoCXjsMsK4fcY9kXqIHV2XdjDaBarxbvXYb
	 et4ueSlxlPzLxoOEyjTyhMf1XG2efmlcFkSrPOqwhIkYXPH7RVdOnsaSXw7jxP9jWX
	 gculrRZJipGsAqvZHTvj0iR7mEWnDVnwCa2uvGDqafMimsU21vYHDN2g51r9zC/V5a
	 EqgWwXY4yKn+qiICiFQNV02990I0KMCBvjDw+PCoVgXACZUHUJaYC7mFCKcdcAjUdA
	 ELusYkCHqrgtA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/11] mm/damon: advance DAMOS-based LRU sorting
Date: Sat, 28 Jun 2025 09:51:33 -0700
Message-Id: <20250628165144.55528-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_LRU_[DE]PRIO actions were added to DAMOS for more access-aware LRU
lists sorting.  For simple usage, a specialized kernel module, namely
DAMON_LRU_SORT, has also introduced.  After the introduction of
DAMON_LRU_SORT, DAMON got a few important new features, including the
aim-based quota auto-tuning, young page filter, and monitoring intervals
auto-tuning.  But DAMOS-based LRU sorting had no many updates.  Now we
show some rooms to advance for DAMOS-based LRU sorting.

DAMON sysfs interface users can utilize all the features, but
DAMON_LRU_SORT is not updated for such modern features.  Also, even in
case of DAMON sysfs interface usage, there is no good quota auto-tuning
goal metric for LRU sorting.  Since it is a sort of balancing of active
and inactive pages, a metric that represents the size ratio between the
active and the inactive pages could be useful.  Also, internal behaviors
of DAMOS_LRU_[DE]PRIO are not very symmetric.

Advance DAMOS-based LRU sorting by introducing a new DAMOS quota
auto-tuning target metric for [in]active memory size ratio, making
DAMOS_LRU_[DE]PRIO behavior more intuitive and symmetric.  Also update
DAMON_LRU_SORT module to be able to fully utilize the modern features
including the [in]active memory size ratio, young page filter, and
monitoring intervals auto-tuning.

With these changes, for example, users can now ask DAMON to "find
hot/cold memory regions with auto-tuned monitoring intervals, do one
more page level access check for found hot/cold memory, and move pages
of those to active or inactive LRU lists accordingly, aiming 50:50
active to inactive memory ratio."

Plan for none-RFC Version
-------------------------

I'm planning to do more tests and add the results by the final version.

Patches Sequence
----------------

First four patches extend DAMOS quota auto-tuning to support [in]active
memory ratio target metric type.  The patches introduce new metrics
(patch 1), DAMON sysfs support
(patch 2), and add the document (patch 3).

Following patch (patch 4) makes DAMOS_LRU_PRIO action to directly move
target pages to active LRU list, instead of marking accessed and
incrementally be moved to active lists.

Following seven patches (patches 5-11) updates DAMON_LRU_SORT to support
modern DAMON features.  Patch 5 makes it to use not only access
frequency but also age at under-quota regions prioritization.  Patch
6-11 add the support and document it for young page filtering,
active:inactive memory ratio based quota auto-tuning, and monitoring
intervals auto-tuning, respectively.

SeongJae Park (11):
  mm/damon/core: introduce [in]active memory ratio damos quota goal
    metric
  mm/damon/sysfs-schemes: support DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
  Docs/mm/damon/design: document DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
  mm/damon/paddr: activate DAMOS_LRU_PRIO targets instead of marking
    accessed
  mm/damon/lru_sort: consider age for quota prioritization
  mm/damon/lru_sort: support young page filters
  Docs/admin-guide/mm/damon/lru_sort: document filter_young_pages
  mm/damon/lru_sort: support active:inactive memory ratio based
    auto-tuning
  Docs/admin-guide/mm/damon/lru_sort: document active_mem_bp parameter
  mm/damon/lru_sort: add monitoring intervals auto-tuning parameter
  Docs/admin-guide/mm/damon/lru_sort: document intervals autotuning

 .../admin-guide/mm/damon/lru_sort.rst         |  37 ++++++
 Documentation/mm/damon/design.rst             |   4 +
 include/linux/damon.h                         |   4 +
 mm/damon/core.c                               |  22 ++++
 mm/damon/lru_sort.c                           | 110 +++++++++++++++++-
 mm/damon/paddr.c                              |  18 ++-
 mm/damon/sysfs-schemes.c                      |   8 ++
 7 files changed, 189 insertions(+), 14 deletions(-)


base-commit: cd5e995caa32062e89e340acb4acbcbe09ad709e
-- 
2.39.5
