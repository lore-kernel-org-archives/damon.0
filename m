Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96632F764;
	Wed,  2 Sep 2026 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328075; cv=none; b=aIKaLXcQHxT3m4inV5RWFVL3o/YWBTIO5mlJoGT4UPJQV9ORS+9F+9l3tYi68/7BHqpDYhzbqDi/vvfng0+/yNEOteuQS43sFS+lVR8klbUcKvj3u7PZlwwq+Qd321iTloxPFDKQmRLb1euVmTdpfhu6rzqlRL4E9jyfhwLm478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328075; c=relaxed/simple;
	bh=bgHiJ3hrICbXSwbvFkN24uoEdLa9MwhS+qn9Ov4apko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDNhOOo4fyBoJXh7+hd8Md3xdBylvfx0HRBrba/nCZC/uXD+9+K8v1m2r9e37BvD37I107KD95WidyvA+J4VU/BQocn3eULNV9d3Z9wUq4nxIgVRtI7weLiZstak6jhqIkJfYXS9sGA57LS0m2Ureu4nQdkNYFQXJDUb8ojrDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nmr8Tapk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmr8Tapk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B9D1F000E9;
	Wed,  2 Sep 2026 05:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328074;
	bh=xyVBn1leruni8Keulp+lVKAKdJp5Y+Dj/l28v3PKPmU=;
	h=From:To:Cc:Subject:Date;
	b=Nmr8TapkJLpq3LiZ50wQjliwtU5ueiy7PCUbVtFZup6daOCWOMBPEi2992dEg3DIN
	 b3hmVw5bw4+9tXpzdcuBFO76dTtOML0lTwjBOLp1SBNvIi0XGcaXG7RRgnWEqbtqQs
	 bBX1MOcKsiIZuEC1NPcI8QC3GNooaBLRiyFAwC3ehnIAF3dkj7qxRAY2agHzJLnjMn
	 Q1t3GqJ6Kl91TVUU+6J6DoHZv8IyjMXEa9Zv80QnjuDRbmeDjzsiJd8xmz+DKuhmI9
	 xkp86K0xkYf50MX4IjSCzNH/ZPYog8twgwaA1aoVfscEr/SH4j0qlr6ZLi+nH4BBic
	 k3h+OGLsfotlA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH 00/12] mm/damon: cleanup code, add test cases, and update guidances in docs
Date: Tue,  1 Sep 2026 22:47:33 -0700
Message-ID: <20260902054747.99370-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Misc cleanup, improvements and updates of code, test, and documents.

Patches 1-5 cleanup DAMON code.  Patches 6-10 adds kunit and selftest
test cases for recently fixed bugs and a new feature.  Patches 11 and 12
update guidelines for AI review and what document to read, on DAMON
documents.

Changes from RFC v1.2
- RFC v1.2: https://lore.kernel.org/20260729140253.87753-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260729033751.131213-1-sj@kernel.org
- Fix a typo: s/alingment/alignment/.
- Add damon probes parameter validation cleanup (patches 4 and 5).
Changes from RFC
- RFC: https://lore.kernel.org/20260728052811.192712-1-sj@kernel.org
- Remove ctx parameter of __damon_va_init_regions().
- Fix damon_nr_samples_per_aggr() overflow kunit test.
- Rebase to the latest mm-new.

SJ Park (12):
  mm/damon/core: use damon_nr_samples_per_aggr() for max merge threshold
  mm/damon/core: remove debug messages
  mm/damon/vaddr: remove a debug message
  mm/damon/core: validate number of probes in valid_probe_params()
  mm/damon/sysfs: remove probes number validation
  mm/damon/tests/core-kunit: extend set_regions() test for error case
  mm/damon/tests/core-kunit: test <=0 size damon_set_regions() inputs
  mm/damon/tests/core-kunit: test overlapping ranges for set_regions()
  mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
  selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
  Docs/mm/damon/maintainer-profile: update AI review for Sashiko replies
  Docs/ABI/damon: recommend subsystem doc instead of admin-guide

 .../ABI/testing/sysfs-kernel-mm-damon         |  2 +-
 Documentation/mm/damon/maintainer-profile.rst | 19 ++----
 mm/damon/core.c                               | 19 +++---
 mm/damon/sysfs.c                              |  2 +-
 mm/damon/tests/core-kunit.h                   | 65 ++++++++++++++++---
 mm/damon/vaddr.c                              | 16 +----
 tools/testing/selftests/damon/sysfs.sh        |  1 +
 7 files changed, 76 insertions(+), 48 deletions(-)


base-commit: 52315e1a031f7370a286d6f6c805e2c8eab5abbc
-- 
2.47.3
