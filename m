Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983F7F4
	for <damon@lists.linux.dev>; Fri, 10 Feb 2023 04:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D41C433EF;
	Fri, 10 Feb 2023 04:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676004521;
	bh=CqpSbVgrETNlESqnil/71IVuAjYqx++3GXa0BpC9WVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jFd1M4ITnLbTlj2BE/Kpn28ls8RmN+Q4OzxJJ9aV4F1XQF9xfM/NCs6D/pz9WA9Pw
	 Qvrq6Or2IMB+mDHBPB01nR3Y/uuC+tjnCFPdoERFUwkqh8z4W3LAxkS6bBP/AZ64Iq
	 IJd9lsJ1SJDOoy7aqT1QoYuiPl3lvePq7wqZbdpFMA1gFtz+bjtPMwfsBOFpXDIwCx
	 Y7VmB7dVH3s1urMqATqSnXVa5MxJCe/oP8Tc2Xq918FXlsemo0ddn5eF1FEegjjYM+
	 Mc5X1haE5vR7VzQzs3QXUYjHC6egXQVUB66r0NeuztVYpcMsA7K657Ls0T0z/ueStl
	 LYvEBMT/6ZG0g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] mm/damon: deprecate DAMON debugfs interface
Date: Fri, 10 Feb 2023 04:48:35 +0000
Message-Id: <20230210044838.63723-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1
(https://lore.kernel.org/damon/20230209192009.7885-1-sj@kernel.org/)
- Split DAMON debugfs file open warning message (Randy Dunlap)

-----

DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
kernel is released.  And, v6.1.y has announced to be an LTS[1].

Though the announcement was there for a while, some people might not
noticed that so far.  Also, some users could depend on it and have
problems at  movng to the alternative (DAMON sysfs interface).

For such cases, keep the code and documents with warning messages and
contacts to ask helps for the deprecation.

[1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c

SeongJae Park (3):
  Docs/admin-guide/mm/damon/usage: add DAMON debugfs interface
    deprecation notice
  mm/damon/Kconfig: add DAMON debugfs interface deprecation notice
  mm/damon/dbgfs: print DAMON debugfs interface deprecation message

 Documentation/admin-guide/mm/damon/usage.rst | 20 +++++++++++++-------
 mm/damon/Kconfig                             |  7 ++++---
 mm/damon/dbgfs.c                             | 19 +++++++++++++++++++
 3 files changed, 36 insertions(+), 10 deletions(-)

-- 
2.25.1

