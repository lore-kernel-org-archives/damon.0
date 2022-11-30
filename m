Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4818462
	for <damon@lists.linux.dev>; Wed, 30 Nov 2022 20:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E10C433C1;
	Wed, 30 Nov 2022 20:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669838981;
	bh=mMfylySxLnXAU3Y/Ax0ptN/yAL+W24Pd1ZjoQYO0TNY=;
	h=From:To:Cc:Subject:Date:From;
	b=OVOWegpHTQu7HgDi5T28oMfUtZ6xEOjyqsSvUcSgGZD2WwrM7aI9E32riHaGk+p40
	 fg2Ofgr8mrpTViZHf6X68TDuNWNSJpTXSrfqNkgpXVbby/UpzyZu95q29s4i7mT9LI
	 J9e7G1IY7EuCKw4BpXVQl6OjTSdnPhbVq/JoHyBtxoGdQfWiFRX6RBwP1yjaO2DlFW
	 JlXmVy+OlE3i2+6EqL5SsiHGBHVz00303Z0e8hEPuz28Yy7xpEy0LwqGN328UMwXxp
	 Eej0roYZh93xzOp1vToPsURhX9EZDYMw0bfrOQ342qn4+je4UG/eZMkI11UqWMrBZc
	 GzLqpbfjuzdmg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 00/11]  implement DAMOS filtering for anon pages and
Date: Wed, 30 Nov 2022 20:09:26 +0000
Message-Id: <20221130200937.118005-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from RFC v1
(https://lore.kernel.org/damon/20221124212114.136863-1-sj@kernel.org/)
- sysfs: Clean up filters directory from scheme directory cleanup path
- sysfs: Link newly created filter to the scheme
- sysfs: Ignore removed memcg when checking path
- sysfs: Guard 'struct mem_cgroup' access with CONFIG_MEMCG
  (kernel test robot)

----

DAMOS let users do system operations in a data access pattern oriented
way.  The data access pattern, which is extracted by DAMON, is somewhat
accurate more than what user space could know in many cases.  However,
in some situation, users could know something more than the kernel about
the pattern or some special requirements for some types of memory or
processes.  For example, some users would have slow swap devices and
knows latency-ciritical processes and therefore want to use DAMON-based
proactive reclamation (DAMON_RECLAIM) for only non-anonymous pages of
non-latency-critical processes.

For such restriction, users could exclude the memory regions from the
initial monitoring regions and use non-dynamic monitoring regions update
monitoring operations set including fvaddr and paddr.  They could also
adjust the DAMOS target access pattern.  For dynamically changing memory
layout and access pattern, those would be not enough.

To help the case, add an interface, namely DAMOS filters, which can be
used to avoid the DAMOS actions be applied to specific types of memory,
to DAMON kernel API (damon.h).  At the moment, it supports filtering
anonymous pages and/or specific memory cgroups in or out for each DAMOS
scheme.

This patchset adds the support for all DAMOS actions that 'paddr'
monitoring operations set supports ('pageout', 'lru_prio', and
'lru_deprio'), and the functionality is exposed via DAMON kernel API
(damon.h) the DAMON sysfs interface (/sys/kernel/mm/damon/admins/), and
DAMON_RECLAIM module parameters.

Patches Sequence
----------------

First patch implements DAMOS filter interface to DAMON kernel API.
Second patch makes the physical address space monitoring operations set
to support the filters from all supporting DAMOS actions.  Third patch
adds anonymous pages filter support to DAMON_RECLAIM, and the fourth
patch documents the DAMON_RECLAIM's new feature.  Fifth to seventh
patches implement DAMON sysfs files for support of the filters, and
eighth patch connects the file to use DAMOS filters feature.  Ninth
patch adds simple self test cases for DAMOS filters of the sysfs
interface.  Finally, following two patches (tenth and eleventh) document
the new features and interfaces.

SeongJae Park (11):
  mm/damon/core: implement damos filter
  mm/damon/paddr: support DAMOS filters
  mm/damon/reclaim: add a parameter called skip_anon for avoiding
    anonymous pages reclamation
  Docs/admin-guide/damon/reclaim: document 'skip_anon' parameter
  mm/damon/sysfs-schemes: implement filters directory
  mm/damon/sysfs-schemes: implement filter directory
  mm/damon/sysfs-schemes: connect filter directory and filters directory
  mm/damon/sysfs-schemes: implement scheme filters
  selftests/damon/sysfs: test filters directory
  Docs/admin-guide/mm/damon/usage: document DAMOS filters of sysfs
  Docs/ABI/damon: document scheme filters files

 .../ABI/testing/sysfs-kernel-mm-damon         |  29 ++
 .../admin-guide/mm/damon/reclaim.rst          |   9 +
 Documentation/admin-guide/mm/damon/usage.rst  |  48 ++-
 include/linux/damon.h                         |  51 +++
 mm/damon/core.c                               |  39 ++
 mm/damon/paddr.c                              |  71 +++-
 mm/damon/reclaim.c                            |  19 +
 mm/damon/sysfs-schemes.c                      | 370 +++++++++++++++++-
 tools/testing/selftests/damon/sysfs.sh        |  29 ++
 9 files changed, 652 insertions(+), 13 deletions(-)

-- 
2.25.1

