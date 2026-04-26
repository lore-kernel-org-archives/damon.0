Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8D450F2;
	Sun, 26 Apr 2026 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245389; cv=none; b=jQUDCwf6Ur7rspilnTo6Hl6xNUAii+Mpb4hqAVEIMtZJM/mJjGWareDaqOH1cwuYDqcqNU7tFWOSkX9/w47e8yGuRxYrATgThEzF8oHhaIOPbNWjtEEKg3pkLWGjadsyhX9rnjVVxulEjAePXIriaj1WLF9m9bOdrkMAg+rPD64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245389; c=relaxed/simple;
	bh=xK3N5VQUiYZLj+igl9pSNGuZYFek1+bNERSn81pIloY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xd8cEhwvqKkMFFOioam1l+OJQNam57k+H/XLq9B0CsfP8Dy7Gp3XOw5STQZN8C7CFfofWjSDajSeJsV5rvkiWkYv0JkMwTr3+3PwqFgxprlJaB2px7XVUakxZG2vJEwStw+EsWvE20MMparFthIA02cDiJMMZANCaADPS8bfffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ3Xw33y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ3Xw33y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198D5C2BCAF;
	Sun, 26 Apr 2026 23:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777245388;
	bh=xK3N5VQUiYZLj+igl9pSNGuZYFek1+bNERSn81pIloY=;
	h=From:To:Cc:Subject:Date:From;
	b=kZ3Xw33yEQRge/f82YUoMVioGH2Xx8fnIyFxVU/gew+SEqkwR6K9UUxhlOxYfWmw4
	 fz+YwLgLl6rKrDQ7czhrk5AMQLId/KHnncfuR5iVkqgE2C3TKA87ss3suB1k/IbGPD
	 2U7sl8r4uCq0/SIje84IV+jW2UxwIyLPuSIFa4SUUE58ItBr9KcH3Ar3ReHfU0kd61
	 ErSKPe0kba+7xW1UxhfOzA5gQwcEoEVnIvbSpSCE1n2e3rI3thHNq7KGE1gOz4nDC0
	 768QWXaWDnvyMYA4HoO4MWWjmJcuhCK10fpOwBZ6u24mNXcM1x2uPX/2YipArB+iM0
	 7nl2WwK1fcpLA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/4] mm/damon: repost non-hotfix reviewed patches in damon/next tree
Date: Sun, 26 Apr 2026 16:16:13 -0700
Message-ID: <20260426231619.107231-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-posting non-hotfix DAMON patches that reviewed by DAMON maintainer
but not yet merged into mm.git.

The first patch from Liew Rui Yan add a minor performance optimization
using ilog2() instead of inefficient manual implementation of the
functionality.

The second patch from Cheng-Han Wu fixes a minor typo:
s/parametrs/parameters/.

The third patch from Liew Rui Yan make commit_inputs operation of
DAMON_RECLAIM and DAMON_LRU_SORT synchronous to improve the user
experience.

The fourth patch from Asier Gutierrez adds a new DAMOS action,
DAMOS_COLLAPSE for deterministic DAMOS-based access-aware THP system.

Changes from v1
- v1: https://lore.kernel.org/20260402155733.77050-1-sj@kernel.org
- Add DAMOS_COLLAPSE patch.
- Rebase to latest mm-new.

Asier Gutierrez (1):
  mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action

Cheng-Han Wu (1):
  Docs/admin-guide/mm/damon: fix 'parametrs' typo

Liew Rui Yan (2):
  mm/damon/ops-common: optimize damon_hot_score() using ilog2()
  mm/damon: add synchronous commit for commit_inputs

 .../admin-guide/mm/damon/lru_sort.rst         |  2 +-
 .../admin-guide/mm/damon/reclaim.rst          |  2 +-
 Documentation/mm/damon/design.rst             |  4 ++
 include/linux/damon.h                         |  2 +
 mm/damon/lru_sort.c                           | 46 ++++++++++++++++---
 mm/damon/ops-common.c                         |  9 ++--
 mm/damon/reclaim.c                            | 46 ++++++++++++++++---
 mm/damon/sysfs-schemes.c                      |  4 ++
 mm/damon/vaddr.c                              |  3 ++
 tools/testing/selftests/damon/sysfs.py        | 11 +++--
 10 files changed, 105 insertions(+), 24 deletions(-)


base-commit: 1e24f85d7a997307185d5345c1711f485570a123
-- 
2.47.3
