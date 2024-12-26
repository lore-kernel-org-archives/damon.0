Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55653450F2;
	Thu, 26 Dec 2024 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251300; cv=none; b=h+2zi+NcK0uc1P+yWmHEsyJu+bIcLOGXBAwGxxi0/lTOk3nvs/6vrnClLcbRIMQvkd/pvybennk68Oj34cTfX04shTYQMr5nvcfcFHjWMXqtfUsJlFt8wxTEIcQKo8QUo6rMc3Er/X34JXWWhVe4ebGEZ7ImaJ3JFgaB7V5nliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251300; c=relaxed/simple;
	bh=D1ZhJfQu00uYQDvRBQE8igXA6gwNlq3NdEPU9xaPj5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t3Ax48HqNeC4QjZB7lkr2Fbb3krAJ4zgGVKFc74Fx/4MtqmNo5tDNDJVKYCp2xUuJ+HloPA9yQuxRQcxD1RrvrUx0TPZAMQ6MkE8O2YMH5XypSVAu4pVnXJr2DhTOWVMUdbkY+2+q0cPTLU1Qc64s+9hE1WhG0rpG/DN+5t6fdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce/F10A8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce/F10A8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9351C4CED1;
	Thu, 26 Dec 2024 22:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735251298;
	bh=D1ZhJfQu00uYQDvRBQE8igXA6gwNlq3NdEPU9xaPj5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=Ce/F10A8cOlAw9eRPDKEj2PpQzJHn/jpoSsd525rPqar0EQ+cZ9ZwwF95Ysr5e2Mu
	 J+a5j3mS/P+bhWK32+ugSMg/rxtbru6ropSrZx25EE8ObgYhzfaTyQaWciwtoWrAVc
	 hVnQ44071eK86VpGNeIvbvf8MWQNNaZow8ltlbwc+606SW4LWzpfO4GOtvc5lMW8sc
	 hrn9QtH4uon3B1t75on4f+pKvUtzhhUmaq3mw4yQhe48VbnsCxKiZa68o2fauMLMo9
	 b8bityahR5ft/MdRvXXLSe69e5mm/g0YqhuZMLWAIRtbK7le4oGkURqUrHwdQydVWw
	 +48+lzETWUeAA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/10] mm/damon: extend DAMOS filters for inclusion of target memory
Date: Thu, 26 Dec 2024 14:14:35 -0800
Message-Id: <20241226221445.78433-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS fitlers are exclusive filters.  It only excludes memory of
specific types from the DAMOS action targets.  This has below problems.

First, the name is not explicitly explaining the behavior.  This
actually resulted in confusions[1] and works to improve the siaution[2],
including wordsmithing documentations and adding features to DAMON
user-space tool, damo.

Secondly, the functionality is restrictive.  This is especially
problematic when multiple filters need to be used.  For example,
building a DAMOS scheme that applies the action to memory that belongs
to cgroup A "or" cgroup B is impossible.  A workaroudn is using two
schemes, each filtering out memory that not belong to cgroup A and
cgroup B, respectively.  It is cumbersome, and makes control of
quota-like additional factors difficult.

Extend DAMOS filters to support not only excluding (blocking), but also
including (pass-through) behavior.  For the extension, add a new
damos_filter struct field called 'pass' for DAMON kernel API users.
Using the API, add a DAMON sysfs file of same name under DAMOS filter
sysfs directory, for DAMON user-space ABI users.  To prevent breaking
old users with a behavioral change, set the blocking as the default
behavior.

Note that DAMOS' default behavior without DAMOS filters is applying the
action to any memory.  And DAMOS filters work for only memory that
satisfies 'type' and 'matching'.  Hence installing pass filter without
any block filter after them makes no filter-behavioral change.

[1] https://lore.kernel.org/20240320165619.71478-1-sj@kernel.org
[2] https://git.kernel.org/sj/damo/c/b6a722c85ff91e5abe9dd47135e300df243da056

SeongJae Park (10):
  mm/damon: fixup damos_filter kernel-doc
  mm/damon/core: add damos_filter->pass field
  mm/damon/core: support damos_filter->pass
  mm/damon/paddr: support damos_filter->pass
  mm/damon: add pass argument to damos_new_filter()
  mm/damon/sysfs-schemes: add a file for setting damos_filter->pass
  Docs/mm/damon/design: document pass/block filters behaviors
  Docs/ABI/damon: document DAMOS filter pass sysfs file
  Docs/admin-guide/mm/damon/usage: omit DAMOS filter details in favor of
    design doc
  Docs/admin-guide/mm/damon/usage: document DAMOS filter 'pass' sysfs
    file

 .../ABI/testing/sysfs-kernel-mm-damon         | 14 +++--
 Documentation/admin-guide/mm/damon/usage.rst  | 55 ++++++++++---------
 Documentation/mm/damon/design.rst             | 29 ++++++++--
 include/linux/damon.h                         | 15 +++--
 mm/damon/core.c                               | 12 ++--
 mm/damon/paddr.c                              |  9 +--
 mm/damon/reclaim.c                            |  2 +-
 mm/damon/sysfs-schemes.c                      | 32 ++++++++++-
 mm/damon/tests/core-kunit.h                   | 14 ++---
 9 files changed, 125 insertions(+), 57 deletions(-)

-- 
2.39.5
