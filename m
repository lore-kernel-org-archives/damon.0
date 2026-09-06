Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990EC3CC9E9;
	Sun,  6 Sep 2026 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728725; cv=none; b=PpvlfjNWkcvISvKQibbgtOW+3PGgp6bUzDtsE9rBTVyKc5pEODPnXX+OSe1q0bAYFY+WklR+Hc8ImYRZrTgi5tupIOFbVCp7dMUDzBA1JBHRjl/kuTFrKr20mpjFdmsLcfT0bsJSBrv5XvIIhZtAyg7qefU41xGl4tavMimZlaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728725; c=relaxed/simple;
	bh=mVf9wc6j2RBh8UGDkyG+fy24tCnZhupeyl66dUumXGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYJIshQJwfHVF+x10V1nL6cOWghb96gm3PQx1uYaaKuWBzm1zIOZndgPr1LydRvi4lfGpqsbuAHglFU/9UwtwF5QXbSXLLVU0xHeWlb3pQHalDFNk2nwRnMaHHTxTBz4mzCn7/yAA7/CpKjWqdNHY+i5aDH5nF6xsmny9E48Sbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgRqBFwg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgRqBFwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000641F00A3A;
	Sun,  6 Sep 2026 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788728724;
	bh=0/q3LnB7iB4S2lxLwjnJON3GEVnAZWX6/MrZWM0ze7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TgRqBFwgOPf3NMLYWOjMTAvyvYfHyN86wytu557lkYoCpLgMwBUT9VyLlJQBFZeqg
	 fd95Nzz+4Y2fzuEeI4rHRwzQshf8HTMpxIDhTLtEPGlwBNFH3NLYIA2H/pX0jzRj5J
	 c/06X0wsiGIIg1aZ7rJIoBv4QZRMX3hIFN2JPc408xfZqWzGGYdIfJWG1kX8VJQOOR
	 crLO3lqhAL5zX7CaEAf0I7dgrGwnPRISeDqgmz/9rLRKcDCEYFT9szlftqcP0hckw5
	 JIuep0JKqu0qMUuDiNKSlRBFHTS0k1hn3Fm79ZARebJPk3x+UiC0z77YyKETOptULP
	 AeFVYTNn9OsUA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/6] Docs/admin-guide/mm/damon/usage: update for probe_hits_wsum DAMOS filter
Date: Sun,  6 Sep 2026 14:05:12 -0700
Message-ID: <20260906210513.106895-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906210513.106895-1-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added probe hits weighted sum
based DAMOS core filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 023c6334024f8..d3e37400367bd 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -551,6 +551,10 @@ and ``damon_target_idx``.  To ``type`` file, you can write the type of the
 filter.  Refer to :ref:`the design doc <damon_design_damos_filters>` for
 available type names, their meaning and on what layer those are handled.
 
+For ``probe_hits_wsum`` type, you can specify the minimum and maximum probe
+hits weighted sum value for the filter to ``min`` and ``max`` files,
+respectively.
+
 For ``memcg`` type, you can specify the memory cgroup of the interest by
 writing the path of the memory cgroup from the cgroups mount point to
 ``memcg_path`` file.  For ``addr`` type, you can specify the start and end
-- 
2.47.3
