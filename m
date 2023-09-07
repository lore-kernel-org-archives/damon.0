Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89AA29
	for <damon@lists.linux.dev>; Thu,  7 Sep 2023 02:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58E7C433C8;
	Thu,  7 Sep 2023 02:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694053772;
	bh=4jvhHwmojf1N1ScmiTRSf81bUPIFUZAdFcnyTSgTh30=;
	h=From:To:Cc:Subject:Date:From;
	b=dp5fJs4bWQca4lDJUBnJZn7y/0m70XnX03LEKYPGjcmIO/TJ76AkgpmSJH369axGd
	 ofP7ksIhxB3n1u4kO3nkzyC7pN0y8NbgQntwcqfqWJpPt0lvSFI8k9EIwKnnYOt/Tr
	 jFBBAKaSwjJ2PxXF2naDgZcFJxN2QHtXrFCyNZrBh0UmTGa7HAQbQPY7KMlEKPSkPk
	 KGGwo+uYKxfd9NwBmgZqSGfyzG7kSPeBOlb6uhcdOabuawy27ruTmVbWl6VZLSfT/y
	 FEKDUGZHH4/RahCdsa8bgxaFqe+EFdUzYq9de/UwZU4H6+LZKu2ttvEw5+7zqWfpal
	 Xwzh0lpSPHWeg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] mm/damon: misc fixups for documents, comments and its tracepoint
Date: Thu,  7 Sep 2023 02:29:18 +0000
Message-Id: <20230907022929.91361-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains miscellaneous simple fixups for documents, comments and
tracepoint of DAMON.

SeongJae Park (11):
  Docs/admin-guide/mm/damon/usage: fixup missed :ref: keyword
  Docs/admin-guide/mm/damon/usage: place debugfs usage at the bottom
  Docs/admin-guide/mm/damon/usage: move debugfs intro to the bottom of
    the section
  Docs/mm/damon/design: explicitly introduce ``nr_accesses``
  Docs/admin-guide/mm/damon/usage: explain the format of damon_aggregate
    tracepoint
  Docs/mm/damon/design: add a section for kdamond and DAMON context
  Docs/admin-guide/mm/damon/usage: link design doc for details of
    kdamond and context
  mm/damon/core: fix a comment about damon_set_attrs() call timings
  mm/damon/core: add more comments for nr_accesses
  mm/damon/core: remove duplicated comment for watermarks-based
    deactivation
  mm/damon/core: remove 'struct target *' parameter from
    damon_aggregated tracepoint

 Documentation/admin-guide/mm/damon/usage.rst | 86 +++++++++++---------
 Documentation/mm/damon/design.rst            | 23 +++++-
 include/linux/damon.h                        | 22 ++---
 include/trace/events/damon.h                 |  6 +-
 mm/damon/core.c                              |  8 +-
 5 files changed, 90 insertions(+), 55 deletions(-)


base-commit: ac8e8303c9c11b5c2e1d2e110866eb66c9fd771e
-- 
2.25.1

