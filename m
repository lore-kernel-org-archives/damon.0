Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA943B2D38;
	Tue, 28 Jul 2026 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216497; cv=none; b=LuF4CulZw3W+HbcEy5Zbx4Zdi2R4eaGCIodFw/lg5kTYia7/pih4+l2Fa6d6xuVPFT5d9CGePmnHh/mii2iRU2VMGYLHR6hWYE7sd1bORs7Ex3GRPZdy8r8gDpF3Bdwp4W4iwPTQ9eOCAJQRITqK7FiKUBXP+3pL699VnCG+q+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216497; c=relaxed/simple;
	bh=Kv6U7sdJmVVWW/zecZwXQFLCcuf+poejWjew/rCGs4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X69Q1XfIkTNhT7SqN+KWFUTWXc2RJaHyzWqz8Yuxcqasw+zM3CEmO94sWFFHSZafD581MYyu5zBq1F+qq4+lbiYIguj26njjymmUFfJGi8Ln0UOdRQM5IJvT9PUd9GpGLrvHFPVg49mqOxRieoziKFpNZxRArfHhkA9nFNADmOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrkU89uR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrkU89uR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4457C1F00A3D;
	Tue, 28 Jul 2026 05:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216495;
	bh=N3HvH4/tSu736bqeiUxT4Fvoqu4R4sLivhdZFnOzSNM=;
	h=From:To:Cc:Subject:Date;
	b=NrkU89uRiJg3I+y+kH60PO7jvuidI/3gCjUZDFGE3+Uv2Ki1KNbXs5YM9EMXofmFN
	 Yhizx54cvr8L8eUls+wzrxdY+tq3AI3ATMNu9lOofr7VRPYHnf3uEyuTmRzWJJbnJM
	 tDLxe+hk7iR7S2J2ws+Xg6iw10UHoYM5JFmMlkzQAp+cn95dr9S+GQtFqObxSj05O9
	 sG1dO0aSZIBDmtpxNK1xffq9c7wWDrxcVdnKaoHumviUwNvedIfq2gezf0u/2hJwUC
	 KJ19TmoyYkaqf89udGc1pd72zWxv5P7wxx0zH8/T0Gpke+L997ub4LbrVwBC0nc7Mc
	 tXODw8A4FskBg==
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
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/10] mm/damon: cleanup code, add test cases, and update guidances in docs
Date: Mon, 27 Jul 2026 22:27:59 -0700
Message-ID: <20260728052811.192712-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Misc cleanup, improvements and updates of code, test, and documents.

Patches 1-3 cleanup DAMON code.  Patches 4-8 adds kunit and selftest
test cases for recently fixed bugs and a new feature.  Patches 9 and 10
update guidelines for AI review and what document to read, on DAMON
documents.

SJ Park (10):
  mm/damon/core: use damon_nr_samples_per_aggr() for max merge threshold
  mm/damon/core: remove debug messages
  mm/damon/vaddr: remove a debug message
  mm/damon/tests/core-kunit: extend set_regions() test for error case
  mm/damon/tests/core-kunit: test <=0 size damon_set_regions() inputs
  mm/damon/tests/core-kunit: test overlapping ranges for set_regions()
  mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
  selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
  Docs/mm/damon/maintainer-profile: update AI review for Sashiko replies
  Docs/ABI/damon: recommend subsystem doc instead of admin-guide

 .../ABI/testing/sysfs-kernel-mm-damon         |  2 +-
 Documentation/mm/damon/maintainer-profile.rst | 19 ++----
 mm/damon/core.c                               | 12 +---
 mm/damon/tests/core-kunit.h                   | 60 ++++++++++++++++---
 mm/damon/vaddr.c                              | 11 +---
 tools/testing/selftests/damon/sysfs.sh        |  1 +
 6 files changed, 61 insertions(+), 44 deletions(-)


base-commit: f5d0a1c210a9bec33ee6cc888f4cc6dd1f56eda7
-- 
2.47.3
