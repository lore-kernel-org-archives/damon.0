Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EF426F47C;
	Tue, 30 Jun 2026 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829057; cv=none; b=CqTZJjiMEh9SYdCXfLfqPNXKzhGb21Pni+DH4f2WKvas6LrwNHxCDrH2ysWQJOF2Yfz53ggRVYlWRzOwj3FQ8IYsjvPURMJRW/9FkpC3h8b87Zraq+1javSEEScHqvyYPCPmgDBibzYL6S7o07bKreLtbMGgorbSuy9ooHcgpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829057; c=relaxed/simple;
	bh=UZymSPBa0XWWbwns/JOidAA5gjvPwF8fgglUWlRV/6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cd3BJRdMaHuMqGmrZ5aAA9ioFnBhHlXK8jyl7cFSuUC7HIjz35m1jKv1/8vSVvxw8gXMqlQnN7VJUwL0RT/rzq3fbtnOKusDa7YdEKCqZk32+szd71IWvRFIR5TSV8OE8My9SvR54/guuCD4Joh0sR3DPcg7q4ugIEDhPkwt604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpvryAXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpvryAXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A4E1F000E9;
	Tue, 30 Jun 2026 14:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829056;
	bh=8vfRiINSDbirl30Dmm17gH3r0ZINd4Brr0niqjDS/TE=;
	h=From:To:Cc:Subject:Date;
	b=MpvryAXchpyZO7mGub1FHBvvvj9h2FyGUTCQqdpcpHzs6b4BwS62GwPEfLkxV9+Ic
	 xznRbtcnDWntPb8Y0MzcvWGbukxiERNdlZi10+dJLsJGpW36Y2V/TIOO85+M7hDA4z
	 6OUbwEta+oYPz9ehSP+A66TAbJJ+ftvyuYIgpMkcTbn1z6q+qHMuUwUL0Gg/+2fn7R
	 5Fm0gaZ4xlsVjXBHsWgU7WIco4Qn2nhDOaWy7B/Ch7lJKXSewS2mz7umL2CjkHzns2
	 sNSSc3AJUmpXpyijIKBL7OOaUyjKE49ZLQiZbrkPLPScBzT+SjxHYa0lSCjVz9mWIX
	 O2sh0WBEvnsHw==
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
Subject: [PATCH 00/11] mm/damon: update, optimize, and clean up doc, tests, and code
Date: Tue, 30 Jun 2026 07:17:14 -0700
Message-ID: <20260630141726.92246-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 2 update the design and ABI documents for recently added
DAMON features.  Patches 3-7 add or update more unit and self tests for
DAMON to cover recently changed or added functions and sysfs files.
Patch 8 optimizes damon_commit_target_regions() to skip unnecessary
adjacent ranges setup.  Patches 9-11 clean and fix up recently added
DAMON sysfs interface code for readability.

Changes from RFC v1.3
- RFC v1.3: https://lore.kernel.org/20260626001644.85825-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.
Changes from RFC v1.2
- RFC v1.2: https://lore.kernel.org/20260625142357.103500-1-sj@kernel.org
- Fix broken sphinx syntax in patch 1.
- Drop unused counts[] for damon_rand() test in patch 3.
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260625050756.91115-1-sj@kernel.org
- Document nid requirement for node_eligible_mem_bp.
- Fix typos: s/memmcg/memcg/, s/geets/gets/.
- Drop damon_rnd() randomness test case; test boundness only.
- Fixup dests dir selftest to do real test with correct file permission
  checks.
Changes from RFC
- RFC: https://lore.kernel.org/20260624142008.87180-1-sj@kernel.org
- Rebase directly to latest mm-new.

SJ Park (11):
  Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
  Docs/ABI/damon: document probe files
  mm/damon/tests/core-kunit: test damon_rand()
  selftests/damon/sysfs.sh: test multiple probe dirs creation
  selftests/damon/sysfs.sh: test {core,ops}_filters/ directories
  selftests/damon/sysfs.sh: test dests dir
  selftests/damon/sysfs.sh: test all files in quota goal dir
  mm/damon/core: reduce range setup in damon_commit_target_regions()
  mm/damon/sysfs: split probe setup function out
  mm/damon/sysfs: split out filters setup function
  mm/damon/sysfs: fix typos in probe_{add,rm}_dirs: s/attr/probe/

 .../ABI/testing/sysfs-kernel-mm-damon         |  40 +++++++
 Documentation/mm/damon/design.rst             |   6 +-
 mm/damon/core.c                               |  22 +++-
 mm/damon/sysfs.c                              | 102 ++++++++++--------
 mm/damon/tests/core-kunit.h                   |  15 +++
 tools/testing/selftests/damon/sysfs.sh        |  71 +++++++++++-
 6 files changed, 203 insertions(+), 53 deletions(-)


base-commit: bb5dde77be397d614ef968578e3bf6cf9674df3c
-- 
2.47.3
