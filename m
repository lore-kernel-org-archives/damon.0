Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A192B9BF;
	Thu,  9 Jan 2025 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445097; cv=none; b=KykJPcKoZbcdwPM8JX/bJEzmnxtlLIFAR1cuS3M11HC8cstJP8GHsnm/dVUO/nrjydbVkcBpZujApQk7fW5/LMtko9Q9xYqc2GZszraGmp9XctLUfod6P0NzMj0EpK9ufrFrc1xsn9CM91Mo+12piEcFMSwBsRDkWRcc+sS4Y0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445097; c=relaxed/simple;
	bh=woo04ygL2lxI0dVd85HArE72awMxk5N2D1/jValkf2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upJulq1qAKOerGnNHASrXMsWpvhd2VAqyEcASGWmIRxcIvn2d85iyJbaCPY6dY17UjnMRsgIGNd0yNGQue7FANGo6ruuC6AZHg3Pnexv3TEC9OAOm8t/EJ93aQGqsiEYvjGx1ZbSZdNiYsu5ImfCgsPQpPLfIHHhAl/ZJcffzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muOPzRPW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muOPzRPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA164C4CED2;
	Thu,  9 Jan 2025 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445097;
	bh=woo04ygL2lxI0dVd85HArE72awMxk5N2D1/jValkf2I=;
	h=From:To:Cc:Subject:Date:From;
	b=muOPzRPW3Nr68uZt8dg57w9O3cgi6VuGjMnUCVtlyLgoA0CjjuyVx4Z7BbgdyzArE
	 bBQoK74AXble0yFErTawdkb1VlzHqvgDyAMC2rGPGS/OAF84pRA9Dz9omHmKkwt+kY
	 s73d/MufXJNoScOTY22nt8JGwPWVlZDdQrXFN6nlXpqCiPOMFxEF2sOIHnOAXS7qfH
	 epzPkzyCdI5mL9/tQsD1WVr7s63JZSNsE3zyYcX//gnBPJYlRw5VRk6SpgSYAZBeir
	 geSdGPlrQthIburKjhhmiS5IIZZ7LSVi/4PyevunzXUFia1UWK1jLIxWC+l938u9Z1
	 lNvylffMyBOtQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 00/10] mm/damon: extend DAMOS filters for inclusion
Date: Thu,  9 Jan 2025 09:51:16 -0800
Message-Id: <20250109175126.57878-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS fitlers are exclusive filters.  It only excludes memory of given
criterias from the DAMOS action targets.  This has below limitations.

First, the name is not explicitly explaining the behavior.  This
actually resulted in users' confusions[1].  Secondly, combined uses of
multiple filters provide only restriced coverages.  For example,
building a DAMOS scheme that applies the action to memory that belongs
to cgroup A "or" cgroup B is impossible.  A workaround would be using
two schemes that fitlers out memory that not belong to cgroup A and
cgroup B, respectively.  It is cumbersome, and difficult to control
quota-like per-scheme features in an orchestration.  Monitoring of
filters-passed memory statistic will also be complicated.

Extend DAMOS filters to support not only exclusion (rejecting), but also
inclusion (allowing) behavior.  For this, add a new damos_filter struct
field called 'allow' for DAMON kernel API users.  The filter works as an
inclusion or exclusion filter when it is set or unset, respectively.
For DAMON user-space ABI users, add a DAMON sysfs file of same name
under DAMOS filter sysfs directory.  To prevent exposing a behavioral
change to old users, set rejecting as the default behavior.

Note that allow-filters work for only inclusion, not exclusion of memory
that not satisfying the criteria.  And the default behavior of DAMOS for
memory that no filter has involved is that the action can be applied to
those memory.  Also, filters-passed memory statistics are for any memory
that passed through the DAMOS filters check stage.  These implies
installing allow-filters at the endof the filter list is useless.  Refer
to the design doc change of this series for more details.

[1] https://lore.kernel.org/20240320165619.71478-1-sj@kernel.org

Revision History
================

Changes from v1
(https://lore.kernel.org/20250107201739.79484-1-sj@kernel.org)
- Correct wrong comments and documents about pass filters without
  successing block filters
- Rename 'pass/block' to 'allow/reject'
  (to avoid confusion with sz_[ops]_filter_pass)

Changes from RFC v2
(https://lore.kernel.org/20241227210819.63776-1-sj@kernel.org)
- Wordsmith messages
- Wordsmith design documentation about monitoring-purpose usage
- Rebase on latest mm-unstable

Changes from RFC v1
(https://lore.kernel.org/20241226221445.78433-1-sj@kernel.org)
- Fix encoding issue on the last patch

SeongJae Park (10):
  mm/damon: fixup damos_filter kernel-doc
  mm/damon/core: add damos_filter->allow field
  mm/damon/core: support damos_filter->allow
  mm/damon/paddr: support damos_filter->allow
  mm/damon: add 'allow' argument to damos_new_filter()
  mm/damon/sysfs-schemes: add a file for setting damos_filter->allow
  Docs/mm/damon/design: document allow/reject DAMOS filter behaviors
  Docs/ABI/damon: document DAMOS filter allow sysfs file
  Docs/admin-guide/mm/damon/usage: omit DAMOS filter details in favor of
    design doc
  Docs/admin-guide/mm/damon/usage: document DAMOS filter 'allow' sysfs
    file

 .../ABI/testing/sysfs-kernel-mm-damon         | 13 +++--
 Documentation/admin-guide/mm/damon/usage.rst  | 54 ++++++++++---------
 Documentation/mm/damon/design.rst             | 33 ++++++++++--
 include/linux/damon.h                         | 15 +++---
 mm/damon/core.c                               | 12 +++--
 mm/damon/paddr.c                              |  9 ++--
 mm/damon/reclaim.c                            |  2 +-
 mm/damon/sysfs-schemes.c                      | 32 ++++++++++-
 mm/damon/tests/core-kunit.h                   | 14 ++---
 9 files changed, 127 insertions(+), 57 deletions(-)

-- 
2.39.5
