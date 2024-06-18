Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602B14F13E;
	Tue, 18 Jun 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734697; cv=none; b=XPAPSL0oz2k+JHl8U3/WnCm10PdmTITNRrsvH4/J/wJl98jWClf104IxPNk1wARnJjyElBOxJJjD+K5cRoVcaLloIQqsUWaCNoVllebtCbnJ9uXxwa0hbQQBOFG67YZ78ufJk0ZxddO9neMtBZ8OsxijNiyh4EETUCY+s0FeMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734697; c=relaxed/simple;
	bh=sEMSFeBRxlT+xOyI3fcvS3gyAxDb+FQHzwkV0mfmWeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=foLGICuGbWGjmx7R/L6l/tkjM57Zim0OddrLoSsRHb4rMvV5A8ZtiFIxypMr6Ua/MgAjSyDVJenOmz/JmPFlaB4Pwr28IE3ucCiewSNca9RhqZR7Xl7FiAhe0PG0u8XjrwWEu2irQDPGmkdjadTJ9ePEUxaLghNwHNFMr/gqGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/kVjevF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/kVjevF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2F8C3277B;
	Tue, 18 Jun 2024 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734696;
	bh=sEMSFeBRxlT+xOyI3fcvS3gyAxDb+FQHzwkV0mfmWeY=;
	h=From:To:Cc:Subject:Date:From;
	b=G/kVjevFEFQgXplD/GLlcAfRy0ReFQ2H6vdu7tby3Yph5gm5av1ySjHMa/PYQJjw2
	 4oEk7yQYVXobPz8oTfkCNEFkGW6lUNCoj1+tzTyoP/E0wMjaM6kZS+VlYaBo+H3m4U
	 VxLYnGQwHl7kYY3Ql+ZYwtzG/rtOJPq9SuE/Y8/AezcDkbp/SGRAZDKSRkf5WuB/zb
	 xcDQwOUitZ4uM9DcsptxAXZQEQGNr1MUh4YTf26iRsAAWHukJLZy3KRA4DS864vVEg
	 Vbcjman/4VQbT7RKZpnaSooBn8ZdHgoXL7e5j1wcAqMVXAtZOsXa0qjtOoy/3YTQHc
	 o/F6QArRw1Z8A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/12] mm/damon: introduce DAMON parameters online commit function
Date: Tue, 18 Jun 2024 11:17:57 -0700
Message-Id: <20240618181809.82078-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON context struct (damon_ctx) contains user requests (parameters),
internal status, and operation results.  For flexible usages, DAMON API
users are encouraged to manually manipulate the struct.  That works well
for simple use cases.  However, it has turned out that it is not that
simple at least for online parameters udpate.  It is easy to forget
properly maintaining internal status and operation results.  Also, such
manual manipulation for online tuning is implemented multiple times on
DAMON API users including DAMON sysfs interface, DAMON_RECLAIM and
DAMON_LRU_SORT.  As a result, we have multiple sources of bugs for same
problem.  Actually we found and fixed a few bugs from online parameter
updating of DAMON API users.

Implement a function for online DAMON parameters update in core layer,
and replace DAMON API users' manual manipulation code for the use case.
The core layer function could still have bugs, but this change reduces
the source of bugs for the problem to one place.

SeongJae Park (12):
  mm/damon/core: implement DAMOS quota goals online commit function
  mm/damon/core: implement DAMON context commit function
  mm/damon/sysfs: use damon_commit_ctx()
  mm/damon/sysfs-schemes: use damos_commit_quota_goals()
  mm/damon/sysfs: remove unnecessary online tuning handling code
  mm/damon/sysfs: rename damon_sysfs_set_targets() to ...add_targets()
  mm/damon/sysfs-schemes: remove unnecessary online tuning handling code
  mm/damon/sysfs-schemes: rename
    *_set_{schemes,scheme_filters,quota_score,schemes}()
  mm/damon/reclaim: use damon_commit_ctx()
  mm/damon/reclaim: remove unnecessary code for online tuning
  mm/damon/lru_sort: use damon_commit_ctx()
  mm/damon/lru_sort: remove unnecessary online tuning handling code

 include/linux/damon.h    |   2 +
 mm/damon/core.c          | 333 +++++++++++++++++++++++++++++++++++++++
 mm/damon/lru_sort.c      |  53 +++----
 mm/damon/reclaim.c       |  62 +++-----
 mm/damon/sysfs-common.h  |   2 +-
 mm/damon/sysfs-schemes.c |  94 +++--------
 mm/damon/sysfs-test.h    |  10 +-
 mm/damon/sysfs.c         |  81 +++-------
 8 files changed, 425 insertions(+), 212 deletions(-)


base-commit: a7b6f23b7fa3f5d1f3ae64034a4aff12fb8c1df0
-- 
2.39.2
