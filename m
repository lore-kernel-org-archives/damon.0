Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B748003D;
	Fri, 26 Jun 2026 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433018; cv=none; b=mzeP2iOCk5wNPlYq5FIQC8w8zaRjyHXPt8xQn4xeYNGlDKytbl5Laqj7wgcohGyKrgaMJtbWJmjbScDOH503MFfnxyH1TRugsBrSybqw4fLNr3mBgLBZwRpHCWeBGiuTPL6De12aYVdHozQ+554cnbwnnhXx+n5+YQyAVcZGdzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433018; c=relaxed/simple;
	bh=o0Akgte5GjB1iVc5BSsHCNajPkuOLGSZ1ia5+Sf6OkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCDYe58wb/Cv8Y0SFTbCkA1G+sOfXxMkxqRLThKiYL1QxgQYPVzKbEgmI/QzEbUCEt3HqA95B9HHjYqGBQfViZHMyQdpTXQHPBn9ZeD1DxUBzKATMk84lqtv2a14UPDvDWzR6RDFcSC6Adm6fJit/d9tyMgsheKTcSFZ7bZ9A74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+z1VXpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+z1VXpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA501F000E9;
	Fri, 26 Jun 2026 00:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433017;
	bh=L4S838e3r5V3cM54ncDt5yU8BcFFqMQDkA1b0LUKUrM=;
	h=From:To:Cc:Subject:Date;
	b=G+z1VXplWChwGFpXuL/+3hO0oAuUxNVv2XhM+9q+83bRJSS+iKlhTpICaD6sLK/IZ
	 IAaXGyY2kTh7ULzNXiwuim86EXHJCeef7KntsLvCWklxefixSnoOIe76VjcLvN8ZQC
	 li/LN7yYttF+X4VC8buwzS+q+PwcOLJ2UhafH4qaAR7fcbczCHSTTEy/TfDkW1kXPU
	 W5go1KjlBocjtWAdLPpkFLslFvjaKL9mkauEBfPpDx2NXtYkCkzx5L3lZmsMURc/Ea
	 wNtzKOc5LZH6p5D8U9E9SPihwmNF/ysS6jHMzXSrycMpbcoctRulGjE2EHP3GHubK9
	 zjPU4k+mx95aw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
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
Subject: [RFC PATCH v1.3 00/11] mm/damon: update, optimize, and clean up doc, tests, and code
Date: Thu, 25 Jun 2026 17:16:31 -0700
Message-ID: <20260626001644.85825-1-sj@kernel.org>
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

SeongJae Park (11):
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


base-commit: 7221b218afc0bff75d656bb193cb6709737cbbf6
-- 
2.47.3
