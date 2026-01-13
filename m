Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1B72EC09B;
	Tue, 13 Jan 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318050; cv=none; b=KbdOJNqpfxDK0botxBNjePRPhS/0LOKSdsyCWJHVMvdX9Oq3YojQrrsVI/Nd1GPHDgVmsCrNMgAfgJj+NhjHm7WQwb2gQdOO9OgWCz5oI7bj4uGKjcELpvMzzxPNb4u218DZNuwxuIwyyCTYbNRHs0t1EJB9PCcly+pKYhadu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318050; c=relaxed/simple;
	bh=9B4uMGFwloAk5ZAEn3IBwWCzYGd064BJjvrO/dS6ItQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbrnaHAZF94sNGiGkzcG8BHOgGpz569gMJff32nGdfrUdZ4HEKljFzpB+vf/Gk3mnNY5aHNTshPanEMB7SnZOGsxFvI/kl2xpbZ6TmFM8MsYQYFPPxGqjwUGAaZbq51JFBDILLTAVaqXKpKdzjjF/j/PAV2G9Bxhe93UWpg2nuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNkBCAAu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNkBCAAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A412C116C6;
	Tue, 13 Jan 2026 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318050;
	bh=9B4uMGFwloAk5ZAEn3IBwWCzYGd064BJjvrO/dS6ItQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CNkBCAAudUv4/3USgBu/lTnxxryOMiV6WwUq/uGyfscdpNEgyE3cCYRMIpRisUv+x
	 nqC/IishGpRJ2VNhWc1T2ba1KSoHxv2RjWc7JTaVNYMRg3bi+fyENeylR3WlKTeKwH
	 PV/g11CNxfMyh3qLtbroljLGm7xMlru9UGMoFJkefj4Cekr21WgPUUUzd9dd1PRK72
	 Lw/ChIay2KTD/fciRkKC+jjSqrTYwR4mDuxYUQvM5tuZNgugf/SA2KBf/Ml7u8PYta
	 bdTnCk5MrBWh6LwHNfWzRq8+JhCqNog3Tbown+vhGy8Su5/3/q2Al+KVijWVQ5LcKg
	 uNcMvRe07LzbQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/11] mm/damon: advance DAMOS-based LRU sorting
Date: Tue, 13 Jan 2026 07:27:05 -0800
Message-ID: <20260113152717.70459-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_LRU_[DE]PRIO actions were added to DAMOS for more access-aware LRU
lists sorting.  For simple usage, a specialized kernel module, namely
DAMON_LRU_SORT, has also been introduced.  After the introduction of the
module, DAMON got a few important new features, including the aim-based
quota auto-tuning, age tracking, young page filter, and monitoring
intervals auto-tuning.  Meanwhile, DAMOS-based LRU sorting had no direct
updates.  Now we show some rooms to advance for DAMOS-based LRU sorting.

Firstly, the aim-oriented quota auto-tuning can simplify the LRU
sorting parameters tuning.  But there is no good auto-tuning target
metric for LRU sorting use case.  Secondly, the behavior of
DAMOS_LRU_[DE]PRIO are not very symmetric.  DAMOS_LRU_DEPRIO directly
moves the pages to inactive LRU list, while DAMOS_LRU_PRIO only marks
the page as accessed, so that the page can not directly but only
eventually moved to the active LRU list.  Finally, DAMON_LRU_SORT users
cannot utilize the modern features that can be useful for them, too.

Improve the situation with the following changes.  First, introduce a
new DAMOS quota auto-tuning target metric for active:inactive memory
size ratio.  Since LRU sorting is a kind of balancing of active and
inactive pages, the active:inactive memory size ratio can be intuitively
set.  Second, update DAMOS_LRU_[DE]PRIO behaviors to be more intuitive
and symmetric, by letting them directly move the pages to [in]active LRU
list.  Third, update the DAMON_LRU_SORT module user interface to be able
to fully utilize the modern features including the [in]active memory
size ratio-based quota auto-tuning, young page filter, and monitoring
intervals auto-tuning.

With these changes, for example, users can now ask DAMON to "find
hot/cold memory regions with auto-tuned monitoring intervals, do one
more page level access check for found hot/cold memory, and move pages
of those to active or inactive LRU lists accordingly, aiming X:Y active
to inactive memory ratio."  For example, if they know 30% of the memory
is better to be protected from reclamation, 30:70 can be set as the
target ratio.

Test Results
------------

I ran DAMON_LRU_SORT with the features introduced by this series, on a
real world server workload.  For the active:inactive ratio goal, I set
50:50.  I confirmed it achieves the target active:inactive ratio,
without manual tuning of the monitoring intervals and the hot/coldness
thresholds.  The baseline system that was not running the DAMON_LRU_SORT
was keeping active:inactive ratio of about 1:10.

Note that the test didn't show a clear performance difference, though.  I
believe that was mainly because the workload was not very memory
intensive.  Also, whether the 50:50 target ratio was optimum is unclear.
Nonetheless, the positive performance impact of the basic LRU sorting
idea is already confirmed with the initial DAMON_LRU_SORT introduction
patch series.  The goal of this patch series is simplifying the
parameters tuning of DAMOS-based LRU sorting, and the test confirmed the
aimed goals are achieved.

Patches Sequence
----------------

First three patches extend DAMOS quota auto-tuning to support [in]active
memory ratio target metric type.  Those (patches 1-3) introduce new
metrics, implement DAMON sysfs support, and update the documentation,
respectively.

Following patch (patch 4) makes DAMOS_LRU_PRIO action to directly move
target pages to active LRU list, instead of only marking them accessed.

Following seven patches (patches 5-11) updates DAMON_LRU_SORT to support
modern DAMON features.  Patch 5 makes it uses not only access
frequency but also age at under-quota regions prioritization.  Patches
6-11 add the support for young page filtering, active:inactive memory
ratio based quota auto-tuning, and monitoring intervals auto-tuning,
with appropriate document updates.

Changes from RFC
(https://lore.kernel.org/20250628165144.55528-1-sj@kernel.org)
- rebase to latest mm-new
- add test results on the cover letter
- minor wordsmithing and typo fixes

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


base-commit: 7a1491b1b0a461872951e8fdf885fc243f67f5e4
-- 
2.47.3
