Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720450EBFF;
	Thu, 17 Sep 2026 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654941; cv=none; b=Ps8xPSdsfuyLAxnq0MIfikzEZQZb+wjFbzbwFv2zPDWJ+N4yWumucVGwj52UR3W9RRBHcoPOwabinSfugMEu9nZlaKT8ZyySvRRnWyVdQ8V2loL5Y8uMQ2TKGdnryMip5+2KUyo50a6NKonJL53c/dES8C7dqKhxc51f2Pye6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654941; c=relaxed/simple;
	bh=KOp46QavelWc9MpAB/7pUoY+w8+SCJr5MpMBLdzDA6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Se/SD4rdqjYmHXUApCDjyj71gaCPSdObweQ2suL+ClBS0aHYu/gRPJuPd0gMQ13Waf+F99AQ8q1rE3gbPi/SQB/SThB7uEPQRqrGC5CVTD7pPK5EbyPW4Zen4QEURCetyL/8WrRdEkV27G0YATshxAzyRL2euLH4i9FKzjchFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb8759cU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb8759cU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5FF1F000FF;
	Thu, 17 Sep 2026 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654938;
	bh=tjofGGPSHVfcqzboPWJ6IAtm4wQQNel3C2UWwfDef+A=;
	h=From:To:Cc:Subject:Date;
	b=Gb8759cUP4F7z65rAz0mmY+nlIY5k81T3VIPeUin1rbrmVvM+ZXx62gTB7IFUlPVt
	 Znub8YBvftvVjKpiRv/Na/rttLudHP4zP3b5qv5/6Cb08R3CMx/ieJA/PHNqJiyb0e
	 q+xwyomlbMEpEbPz44JLrIlBc60dY49oaQajc+RJhHynUja3RL78LslqWtO+fZ8s9a
	 UQNA3D/GkIuYY41/1Hi/x6veTaZm1zuE3Ef6iQiV0P++pYoKj83T+oU+3AhJp6FMJf
	 dk6acrZuagzDiLn58yIB62qgsy4eAbprozdbTgJIylfUestjXzCTphymOIHUroWuJN
	 5jqJ3swApSXPQ==
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
Subject: [PATCH 00/10] mm/damon: improve readability, clarity and test coverage
Date: Thu, 17 Sep 2026 07:21:58 -0700
Message-ID: <20260917142210.90829-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yet another batch of miscellaneous DAMON minor improvements.  Mostly
focused on readability and clarity of code and document, and unit/self
test coverage.  No user-visible behavioral change is intended.

Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260917040537.107341-1-sj@kernel.org
- Drop RFC tag.
- Rebase to the latest mm-new.
Changes from RFC
- RFC: https://lore.kernel.org/20260912200814.145612-1-sj@kernel.org
- Fix a typo in the selftest warning message.
- Collect A-b: from Randy.
- Split out damos_adjust_quota() fix to an individual hotfix patch.
- Add a patch for initializing walk_control_obsolete in damon_new_ctx().
- Add a patch for probe_hits_wsum damos filter commit kunit test.
- Trivial patch sequence update.
- Rebase to the latest mm-new.

SJ Park (10):
  mm/damon/api: remove NR_DAMOS_FILTER_TYPES
  mm/damon/core: use abs_diff() in damon_feed_loop_next_input()
  mm/damon/core: use mult_frac() in damon_feed_loop_next_input()
  mm/damon/core: set damon_ctx->walk_control_obsolete in damon_new_ctx()
  mm/damon/core: document damon_call()/damon_start() race hang issue
  mm/damon/paddr: remove pa parameter from damon_pa_filter_pass()
  mm/damon/tests/core-kunit: test eligible_mem_bp commitment
  mm/damon/tests/core-kunit: add probe_hits_wsum damos filter commit
    test
  selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak
  Docs/mm/damon/design: clarify bp is basis point

 Documentation/mm/damon/design.rst             |  5 ++--
 include/linux/damon.h                         |  2 --
 mm/damon/core.c                               | 19 ++++--------
 mm/damon/paddr.c                              |  5 ++--
 mm/damon/tests/core-kunit.h                   | 30 +++++++++++++++++++
 .../selftests/damon/sysfs_memcg_path_leak.sh  |  7 +++++
 6 files changed, 48 insertions(+), 20 deletions(-)


base-commit: 942682790e570c9422a389bf34097e74c4777fe9
-- 
2.47.3
