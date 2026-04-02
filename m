Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993A19F115;
	Thu,  2 Apr 2026 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145465; cv=none; b=IbtuDReCSDHJ8ViGsvTeCE1Co2VzRcp8GEKBNsdHng0i2jpPw/mVwLout8Whhm8yEOcRww4uYHQgYBdayOFZ1AZUOR+n38zS2yie/eTBsrEIOPuXMfKIzeFzS7vmR4N1pjRlWokRWdsbHqz1EKAc+5LH8JCyXUQgWspD6hK22xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145465; c=relaxed/simple;
	bh=mwE+127Wtx47haHMcKL32qgQUWoqYHGLXcy7Op4nYG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dc+tr7Qe//BTDL4SznvvdCpCs5e84USRL3ZlQTHR2Dd7XcsRSpf2mV+HzziJi0xRHR8zlWZ2NcDRFc+oDPptdHap7205j/QXoHDWq+JlnCxEDsEdZqGqxNZn/xIptcjgqRwUkGE+j51C5VyDUX3EJY83shqIYY2GsvYHQ0j2zuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc4H8f/X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc4H8f/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD62BC116C6;
	Thu,  2 Apr 2026 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775145465;
	bh=mwE+127Wtx47haHMcKL32qgQUWoqYHGLXcy7Op4nYG4=;
	h=From:To:Cc:Subject:Date:From;
	b=pc4H8f/XTzomCfYZ59jP3MuLzWi2yBWgSaIqmouyIFvuL2sGNeJF+/2gQuReQs/e3
	 iTNA6s4/ZcA2Ltrxd0luVTkktrxBGYi3ZjH2FwVGz9PYz9xyzWrppXcmUc+dzfE2Uk
	 jgfg/UkK4yCANQoszttBaIjrFWbcfWJTHuDV6ZCzOn3iQYdrcjGBql7HWwRsdqNyxw
	 RCWs+5Eajl0psUVPKMMfiTson2FI69xlEWnFt5V6TRgmpSElwieZ65kBVtNoWkHRtS
	 kMQ/QO+YmxGyJ3Le/uom4NK0HyxPV75x3F7JIbPMMcJGXgLBviGJUkPegsKKXS9wpF
	 PpTIlBUANSOMA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] mm/damon: non-hotfix reviewed patches in damon/next tree
Date: Thu,  2 Apr 2026 08:57:27 -0700
Message-ID: <20260402155733.77050-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-posting non-hotfix DAMON patches that reviewed by DAMON maintainer
but not yet merged into mm.git.  Those are not urgent, so it should be
ok to be merged after the next rc1.  This is just a headsup.  I will
post these again after next rc1, if these are not merged into mm.git by
then.

The first patch from Liew Rui Yan add a minor performance optimization
using ilog2() instead of inefficient manual implementation of the
functionality.

The second patch from Cheng-Han Wu fixes a minor typo:
s/parametrs/parameters/.

The third patch from Liew Rui Yan make commit_inputs operation of
DAMON_RECLAIM and DAMON_LRU_SORT synchronous to improve the user
experience.

Cheng-Han Wu (1):
  Docs/admin-guide/mm/damon: fix 'parametrs' typo

Liew Rui Yan (2):
  mm/damon/ops-common: optimize damon_hot_score() using ilog2()
  mm/damon: add synchronous commit for commit_inputs

 .../admin-guide/mm/damon/lru_sort.rst         |  2 +-
 .../admin-guide/mm/damon/reclaim.rst          |  2 +-
 mm/damon/lru_sort.c                           | 46 ++++++++++++++++---
 mm/damon/ops-common.c                         |  9 ++--
 mm/damon/reclaim.c                            | 46 ++++++++++++++++---
 5 files changed, 86 insertions(+), 19 deletions(-)


base-commit: 2c5f83f56c4a5ec75db054510007baaa1fbe4ad5
-- 
2.47.3
