Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694642A80;
	Wed, 29 Jul 2026 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296281; cv=none; b=BpcRfztUFeQQK/2bjXVxsDY+knIJijPJzdfpAUpsYRiKqOUlWfq5NfW4cxkaTjsVX6LcK0dTgNduplJFqPv253gkdelG4MLHX2pQKxXBt+Te8tugpypfZSvCwR2/Jp6sDqJnkGxadBjZiF1SQKcWpNp4jJjZFlYFQfvxDaSz6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296281; c=relaxed/simple;
	bh=ZKQkp9JI/TGOpnjSJDTVSY0XSOfwq0Xkuj8jUA3dFi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onPd9MRCVHbsrJGVa6eQ1C5t45TCW6PfYG8WxMGkN+h88in9lnVjfPowkPccEqKeQ3Ynfglby4iLuynkTuJg8oIyYmHz0gFEgYm2eKVyUvlP75ie99WJsNdziS88kZ7kp9PYG55FRQeTFwjctyfa5uM+TYYiyuZ9RnDz7JjwDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO6J+KXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO6J+KXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3471B1F000E9;
	Wed, 29 Jul 2026 03:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296279;
	bh=PHXHv/8aRUsKBfW2c2nIcEHw5jx7iOabXJGxsw9CVD4=;
	h=From:To:Cc:Subject:Date;
	b=SO6J+KXGJ+KUH/INHpG2J3XmOghTN32xj2I3aUF8jHBFcCQJan0Ay60/+mVNh53ly
	 rsSr61U/6oVD8O58hiJfnh1WaihBVkSZFmaPg11HpYc0Jy5zUsUxjbFFTiXjlMYI4C
	 Wx+H3XRV2eZv4dybzFbdRGiT2PZDQmCm/zF8CRBTzlGNc2G9yv41YcvOFT6iiRcpxz
	 EOsyF1O2GzQe9qOqYYQN9biolkpM1et/UFUpXIxtA0n8SE5/zg9L/iJ2CQqtJyGB7K
	 mmSOoPnHRmX0bBNzkwmVZwodSHQ6hixPZeYjHBoPv3RtfnrqrouCGXsHG6um/LZtcg
	 LoXhDcN2Hf3aw==
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
Subject: [RFC PATCH v1.1 00/10] mm/damon: cleanup code, add test cases, and update guidances in docs
Date: Tue, 28 Jul 2026 20:37:40 -0700
Message-ID: <20260729033751.131213-1-sj@kernel.org>
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

Changes from RFC
- RFC: https://lore.kernel.org/20260728052811.192712-1-sj@kernel.org
- Remove ctx parameter of __damon_va_init_regions().
- Fix damon_nr_samples_per_aggr() overflow kunit test.
- Rebase to the latest mm-new.

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
 mm/damon/tests/core-kunit.h                   | 65 ++++++++++++++++---
 mm/damon/vaddr.c                              | 16 +----
 tools/testing/selftests/damon/sysfs.sh        |  1 +
 6 files changed, 68 insertions(+), 47 deletions(-)


base-commit: bc87db7fa4d8d45745620150a9487efcb6ebbd51
-- 
2.47.3
