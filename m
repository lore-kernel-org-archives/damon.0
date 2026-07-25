Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0471DE4F1;
	Sat, 25 Jul 2026 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013356; cv=none; b=UQYm5HdvrCcC26vY055C162dFV/fQ961foG4L5SNw8ljmpT/gy21iK5qtblyfrwfqSvV4CPBQ7FUCbxfBu+/GTNu30yi9XWkK8kSm4k9HLx1K+mxwOKHszr2puLbM7Zo0PGtJkMdXS9bCzEl50U6HMHTchsWU3HyzDwIEusMqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013356; c=relaxed/simple;
	bh=gigoF117kb/U/u0kCBL1Mi+zmjsVSlwJJxV1V147ZXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpkETryeJPWqRz7pi1k1vKVukPIQc58rKxvMrEgrV78nL1jTmLe6gdwLYwfWjCK5Y1lpxvs4Ds0FLxTCBSzlgbD3+AigdS86s+2F1EsJaI+Mvt3Gnvx4DZwkjepRx8pThdQFS0HsgF5XdfgI0+ebW8qg8t5V56AWfhgsmlL/Htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3yfrMYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3yfrMYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A111F000E9;
	Sat, 25 Jul 2026 21:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013354;
	bh=LAM6Abu94jF1fie/uC+MUDrkB67RvOMdcnz1WP+Dz24=;
	h=From:To:Cc:Subject:Date;
	b=F3yfrMYAMcesNgY7mhclt8oYvBnIALQgc9Uaj+QIiqtb4xavNYvUqyvzWeQPJMtgp
	 i+rB98S8vnDk7V2CSDovXsaqYSZqTZajgVO2y2pOcahrLiUR2Jvck7og1wEe+qYRBN
	 m3Ec3QJcf2lSnJmsWUDdm39c0eZhRKS67cs1nHrjGxFDubf+SVSVNzmHQOs3AEAvGd
	 9GUSBsP7BHYs1NSummgKqJUJzBWrSxwXDP/SLT4PGMpnlh9CKkHysvP8Nc63189nf3
	 BKKvStil7yUMlob+mUD2WKar7mnNUgKKd6odRxFRv8ZTFkacgOlNaUygxpRVXHTGlu
	 qdRk+W6942lCQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/17] mm/damon: introduce data access-as-a-data attribute
Date: Sat, 25 Jul 2026 14:02:04 -0700
Message-ID: <20260725210225.129944-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR: extend DAMON's data attributes monitoring system to support page
table accessed bit and PG_idle based access monitoring.

DAMON was initially introduced as a data access monitor.  Users found
data access pattern becomes more useful when it is combined with other
data attributes such as belonging cgroups and backing page types.  For
such cases, DAMON has extended to support such data attributes
monitoring in addition to the original data access monitoring.  The
DAMON probes system was introduced for this purpose.  Users set probes
for filtering data attributes of their interest.  For use cases where
the primary interests are the attributes but the access pattern, probe
weights system has been introduced.  When it is used, DAMON applies its
adaptive regions adjustment based on the monitored data attributes.

However, DAMON stops access monitoring when the probe weights are used.
DAMON cannot optimally help users who have interests in both data
attributes and access patterns.  Data access can also be thought of as
another data attribute, though.  Extend the probe system to support data
access as a data attribute.

Introduce a new probe filter type, pgidle_unset.  It shows if the page
is not set as idle.  Specifically, it shows the page table accessed bit
and the PG_idle flag.  It can inform if the region is ever accessed. But
it cannot say when it is accessed.  To answer the second question,
introduce a new probe feature, prep actions.  Using the features, Users
can specify what preparation actions should be made to each region for
each probe.  DAMON executes the preparation actions for each sampling
interval, like it is doing the preparation for access check in the
access monitoring mode.  To help 'pgidle_unset' probe action use case,
'set_pgidle' preparation action is introduced together.  The action does
exactly what the access monitoring was doing: clearing the page table
accessed bits and setting the PG_idle flags.

Patches Sequence
================

First four patches (patches 1-4) introduce the new probe filter type for
knowing if a region is accessed.  Patch 1 defines the new type in the
core.  Patch 2 implements the execution of the new filter in the
physical address space DAMON operation set.  Patch 3 implements a user
interface on DAMON sysfs interface.  Patch 4 updates the documentation
for the new filter type.

Following 13 patches (patches 5-17) introduce the probe preparation
actions feature.  Patch 5 defines the data structure for specifying the
preparation actions.  Patch 6 completes setup of the API parameter for
the prep.  Patch 7 extends the DAMON operation set callback list to
connect the parameter with the underlying operation set.  Patch 8
implements the execution of the prep in the physical address space DAMON
operation set.

Following five patches (patches 9-13) extends DAMON sysfs interface for
the new prep feature.  Patch 14 adds simple selftest for basic file
operations of the new sysfs files.  Final three patches (patches 15-17)
respectively update design, usage and ABI documents for the new feature
and its interface.

SJ Park (17):
  mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
  mm/damon/paddr: support PGIDLE_UNSET probe filter type
  mm/damon/sysfs: support pgidle_unset probe filter type
  Docs/mm/damon/design: document pgidle_unset probe filter type
  mm/damon/core: introduce damon_prep struct
  mm/damon/core: commit preps
  mm/damon/core: introduce damon_operations->prep_probes()
  mm/damon/paddr: support damon_prep
  mm/damon/sysfs: implement preps directory
  mm/damon/sysfs: create probe preps directory
  mm/damon/sysfs: implement probe prep directory
  mm/damon/sysfs: create probe prep files for preps/nr file write
  mm/damon/sysfs: pass preps to DAMON core
  selftests/damon/sysfs.sh: test probe prep sysfs files
  Docs/mm/damon/design: document probe preps
  Docs/admin-guide/mm/damon/usage: document probe preps sysfs files
  Docs/ABI/damon: document probe prep sysfs files

 .../ABI/testing/sysfs-kernel-mm-damon         |  13 +
 Documentation/admin-guide/mm/damon/usage.rst  |  18 +-
 Documentation/mm/damon/design.rst             |  17 +-
 include/linux/damon.h                         |  42 ++-
 mm/damon/core.c                               | 103 ++++++-
 mm/damon/paddr.c                              |  41 +++
 mm/damon/sysfs.c                              | 280 +++++++++++++++++-
 tools/testing/selftests/damon/sysfs.sh        |  27 ++
 8 files changed, 527 insertions(+), 14 deletions(-)


base-commit: 7c69a13f116ab63f525a2c4b0be7ce89f73befcd
-- 
2.47.3
