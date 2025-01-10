Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8624B22E;
	Fri, 10 Jan 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736535160; cv=none; b=nvopIfbuDkMu/ACv3Y8Pl1kpsxdH+jCmvASB86O4GoONKiDl/vto9txucIny2iGrGOxmR+F9bQrigcgUXVMphJ+5roQhunJesjHmOonXbW/LNbaxrZarumo7AUUNuuggmFCMuJqBmWxJbblk+pTA+3wpfiemGVPjTf5u2nFpcTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736535160; c=relaxed/simple;
	bh=QhEK5aPMdg0VouObn8zkoul2ggLdzKh50BelRljMFNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jjBVv/0N8MxxWhW7oUxGeLT78u1943uO3Gs3l3DfeiyQbd2XCWmfJin59pOQbt55b3tpwsxUTDzDSW8f05CyCKABsiYrLQI5SAog67Cea9tZpyuHA+zLnYkvrsnYQ62XjFvAJwVazlNCOaMSwYuusn8u+AWTdrI+ZXvbWQwi1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW6UNzDc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW6UNzDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE034C4CED6;
	Fri, 10 Jan 2025 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736535160;
	bh=QhEK5aPMdg0VouObn8zkoul2ggLdzKh50BelRljMFNg=;
	h=From:To:Cc:Subject:Date:From;
	b=DW6UNzDcnWD7yIVDkpntUSuNATdwGu1IiWg3F0KiSL6RBTydOa/B+M+7VDitBZY3E
	 EPwJJyavGFDuW5iv781qhikmKGNuVBYXzI2eLRVVXGAyTzbJqo46TmaAm1+/Rl/TUY
	 or+ZGn8kT8JaqEWhU44Rf0kiwfapM9Rw0uWGgtIZjHxkfckMFYzB011MBbfNbAmejK
	 ET+KXRtQbzMzyIaTt57AJpSSA85yCAkFZAV8fa82Kyr++/z+T6PBboBogAweXSl+PL
	 cGmUtrqDIbrD1ELqlZXHRys6wxCBmy7XxFYLg6xLDjPzWm7sJsRedWR/ZL/Tr5jKWT
	 kHWozT6tIUvSQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/5] Docs/mm/damon: add tuning guide and misc updates
Date: Fri, 10 Jan 2025 10:52:27 -0800
Message-Id: <20250110185232.54907-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DAMON monitoring parameters tuning guide (patches 1 and 2), with
misc documentation fixes (patch 3), updates (patch 4) and clarifications
(patch 5).

Changes from RFC
(https://lore.kernel.org/20250102190138.47258-1-sj@kernel.org)
- rebase on latest mm-unstable
- wordsmit commit messages

SeongJae Park (5):
  Docs/mm/damon/design: add monitoring parameters tuning guide
  Docs/mm/damon: add an example monitoring intervals tuning
  Docs/admin-guide/mm/damon/usage: fix and add missing DAMOS filter
    sysfs files on files hierarchy
  Docs/admin-guide/mm/damon/start: update snapshot example
  mm/damon: explain "effective quota" on kernel-doc comment

 Documentation/admin-guide/mm/damon/start.rst  |  67 +++--
 Documentation/admin-guide/mm/damon/usage.rst  |   2 +-
 Documentation/mm/damon/design.rst             |  57 ++++
 .../monitoring_intervals_tuning_example.rst   | 247 ++++++++++++++++++
 include/linux/damon.h                         |  13 +-
 5 files changed, 354 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/mm/damon/monitoring_intervals_tuning_example.rst

-- 
2.39.5
