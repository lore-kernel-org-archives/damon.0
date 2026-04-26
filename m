Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F8315D39;
	Sun, 26 Apr 2026 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245390; cv=none; b=rc7oJMF4g1Ig759BfVmmvB/2f+akw+F8UKQR1ou9ER6hDNNjWZyxN2WCPe4OM+4patL+o6Ssm5XhYVXBBuySrCsTksW3qaXDb/epFP2I4JknYgioh2ENTUJL48OnRVsEYLYPzO8hIxMS8dWzHXF4Dfs7ys3z2u47yj1HwSW4Xn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245390; c=relaxed/simple;
	bh=+A1Q9/vaJ9DZib9IiWJOGNTEVd+yWzZrZB7cjC5LjW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clwlolpIhBRNp0H48kibLhlRGrh+/p2yz/tpPxioLv6W758GYdS3v95uDzrN1pQ5BkO3Cz4rHbVj6Y5cRZGxprUDVxnnzWd6gBcreNqD0H02D2DauCXs0JlBB6JQZQOC72RUzQqEQDkvzgG1VwZrhChUDNy5mBOi2NZmQMIH7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dknh61j3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dknh61j3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B893C2BCAF;
	Sun, 26 Apr 2026 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777245389;
	bh=+A1Q9/vaJ9DZib9IiWJOGNTEVd+yWzZrZB7cjC5LjW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dknh61j3XU4h0Xyj+9G0SVVqUrsb9CIH7gsKngAvzMnrOWWDQnAwuPrKuGmP/94nl
	 I9zX28PkLWQO3+RHgrz6pRwjJp5smXBnaU01J/bIN8rr1iknaxT7TuDSGEdORE2Y0V
	 7fVsB7BPCJUSrpy0p0wmnwj4uyuesgi+gR1TwS1GdDIWhJd6jDOJfVqN1UcSnPR0ac
	 lSOg9lRR+OIZk26UmKu4jeSYBIBuF5c8NdfWNa5cdbBS084+QcrPv1sllgdZy8dTnY
	 J9WBN0yH4MHNN9k/0XYSJp5tl/by0yrhBB7g/ki8/0xjHzdzSXN+zkWoVrvfHzQQ/W
	 +I2M6qYF7sa2A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Cheng-Han Wu <hank20010209@gmail.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/4] Docs/admin-guide/mm/damon: fix 'parametrs' typo
Date: Sun, 26 Apr 2026 16:16:15 -0700
Message-ID: <20260426231619.107231-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426231619.107231-1-sj@kernel.org>
References: <20260426231619.107231-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng-Han Wu <hank20010209@gmail.com>

Fix the misspelling of "parametrs" as "parameters" in
reclaim.rst and lru_sort.rst.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/20260324144851.12883-1-hank20010209@gmail.com)
- Rebase to latest mm-new.

 Documentation/admin-guide/mm/damon/lru_sort.rst | 2 +-
 Documentation/admin-guide/mm/damon/reclaim.rst  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 14cc6b2db8973..25e2f042a383f 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -75,7 +75,7 @@ Make DAMON_LRU_SORT reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_LRU_SORT is running are not applied
 by default.  Once this parameter is set as ``Y``, DAMON_LRU_SORT reads values
-of parametrs except ``enabled`` again.  Once the re-reading is done, this
+of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index d7a0225b49508..01a34c215b66f 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -67,7 +67,7 @@ Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_RECLAIM is running are not applied
 by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
-of parametrs except ``enabled`` again.  Once the re-reading is done, this
+of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_RECLAIM will be disabled.
 
-- 
2.47.3
