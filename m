Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B401392C46;
	Tue, 13 Jan 2026 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318056; cv=none; b=FtlywKKzb8aPGWj3lxsBsNHZdSAEHrKT23Mxl1aXAtQajlM1fDafgs89JESwsdBUHf04mXY0TcXuq0Mbxww6Zg/y8qWCESTkjuMXxjbtQ21uArpVPolfKTM+DgcONo5DfpV6Tve90x28fYiz1Rr18RtHwg95ZjbHqa0GT1xhCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318056; c=relaxed/simple;
	bh=ZmJrAkMA9Irtz6OhLBZFE9S6wzn9oxN2fIfGy091mqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IntY2JYnrj7DA/uguqwns/SCZdcKn7LXO1pVjt/rHycmGchLwwqFaJoJK4V3eTrz/bdbqTcTbpxHYALaUg030w6D7Bz2JpYcvUoZhu1ytjhRB0WBdiUS6UTStGFjmiZ5Rkn//dI8XZoKxJCKcUNAqCgM6IQw65JXvl/jJ+Fwlo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbKz/WvZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbKz/WvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97C6C19421;
	Tue, 13 Jan 2026 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318054;
	bh=ZmJrAkMA9Irtz6OhLBZFE9S6wzn9oxN2fIfGy091mqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbKz/WvZSBUAf7ErFfDMyIrvtRdGi7BE8mJZkAoVw+9dngIBXggRh0/SXNXLO0k5j
	 0y05XEwmUbLtA0ZMkjsp1RJ3840rkwwpZmnzxnCv9PnMkWzdR2LyQIrxGuhgdbQV5e
	 hdOyvmKV/84XqF0TwTVJflLYzgJp5feHdBlmkqoGxfGCTvbd6S5BjYgh1cPWBQRnWC
	 pscrF2vTCU/q+j2+xq3tib+MHqM3uygZTYqB8lsiM0Xx1b9o7VEgDjp1dxyhEPO6cP
	 gIJtE7TZb31/2wsfsA1rp4zOwLOabR45EF4qSEtFqorzu38cLfJ5De1HPsDYpLp6jq
	 TLPrD4cR7us2A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/11] Docs/admin-guide/mm/damon/lru_sort: document intervals autotuning
Date: Tue, 13 Jan 2026 07:27:16 -0800
Message-ID: <20260113152717.70459-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document a newly added DAMON_LRU_SORT module parameter for using
monitoring intervals auto-tuning feature of DAMON.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 6af3ab5579a3..20a8378d5a94 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -91,6 +91,17 @@ increases and decreases the effective level of the quota aiming the LRU
 
 Disabled by default.
 
+Auto-tune monitoring intervals
+------------------------------
+
+If this parameter is set as ``Y``, DAMON_LRU_SORT automatically tunes DAMON's
+sampling and aggregation intervals.  The auto-tuning aims to capture meaningful
+amount of access events in each DAMON-snapshot, while keeping the sampling
+interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this as
+``N`` disables the auto-tuning.
+
+Disabled by default.
+
 filter_young_pages
 ------------------
 
-- 
2.47.3
