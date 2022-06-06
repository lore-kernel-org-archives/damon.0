Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1577C
	for <damon@lists.linux.dev>; Mon,  6 Jun 2022 18:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15C3C385A9;
	Mon,  6 Jun 2022 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654539796;
	bh=+QqAprUxOaQPSOtLP0LgBQYVTXKMbC246G9bHpmyd0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=gs75g9nmBP5Dow05xpuWiCuO/NgJjCt9gShkU29XnHSJeHDrv5fuK7SmlPmJbH/j/
	 lhbg7TRElq9liJuX1WAqBxjesskhTNSy+t4VKbFPUB2a0Ixl+SMnjWQIBcIio+OO4v
	 S+r4VzUUSY/XXBUy5UKJFRClt0B1DhUqY/Spd0JX3zpGQkRbCPJSldtYrdA6DFNIoO
	 gSNHOnBjTaq6TscYJSjr4X56VvtqPc1d8nKSQLqrkQDMYjwKRbWdfFVVkZcArpNm1W
	 N9fWhzwDHGlxwc5WKIJybAc0YHTB5t1KjBx995LdfkPqumeo2BOekuVQy0yenf7ICF
	 rhWxxTnKAMuTQ==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: corbet@lwn.net,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/6] mm/damon: trivial cleanups
Date: Mon,  6 Jun 2022 18:23:04 +0000
Message-Id: <20220606182310.48781-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains trivial cleansups for DAMON code.

SeongJae Park (6):
  Docs/admin-guide/damon/reclaim: remove a paragraph that been obsolete
    due to online tuning support
  mm/damon/{dbgfs,sysfs}: move target_has_pid() from dbgfs to damon.h
  mm/damon/reclaim: deduplicate 'commit_inputs' handling
  mm/damon/sysfs: deduplicate inputs applying
  mm/damon/reclaim: make 'enabled' checking timer simpler
  mm/damon/reclaim: add 'damon_reclaim_' prefix to 'enabled_store()'

 .../admin-guide/mm/damon/reclaim.rst          |  6 --
 include/linux/damon.h                         |  6 ++
 mm/damon/dbgfs.c                              | 15 ++---
 mm/damon/reclaim.c                            | 40 +++++------
 mm/damon/sysfs.c                              | 67 ++++++++-----------
 5 files changed, 55 insertions(+), 79 deletions(-)

-- 
2.25.1

