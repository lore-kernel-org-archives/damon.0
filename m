Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66DF134A8
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46091C433C8;
	Wed,  2 Aug 2023 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691012600;
	bh=mWNsxedk/0WTpVC5xcDAG+vRRRu0kRA2F/h2AlUSJkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VguX3rgruXsHFHwRc94yQOIa+8CYImY184CQKh8Axbc20nSL0haxJ1BelLK/Kl+lI
	 kx6SxHyD4tWBMYM783i5u1pCUHe8HhYxsL2rlAMIDalMA/pSzobIQ0kVeRHt927q43
	 GY99HKHbl5lQyYKaFi3aRreMREW3OX9bCuEV484vLCMGbeKJ4VP8Lm7SQ79For4EkF
	 SjBOeZ5HDzCAWDDmCcfQFXZT0w4jFLg/Z9z3Gm5AKvvbTgI7BD2W96ssE1UHndwOAr
	 aXvpzW8AJ1doO6vO8cwLIrvsu32nTnqlSx2DXFNUYFcDtH52KVI+1vYP/0A+ZQEjWC
	 kT0MuCjPoXQLA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] Docs/admin-guide/mm/damon/usage: update for address range type DAMOS filter
Date: Wed,  2 Aug 2023 21:43:06 +0000
Message-Id: <20230802214312.110532-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added address range type DAMOS
filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 31 +++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 1859dd6c3834..a9cb9949b796 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -363,15 +363,18 @@ number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each filter.  The filters are evaluated
 in the numeric order.
 
-Each filter directory contains three files, namely ``type``, ``matcing``, and
-``memcg_path``.  You can write one of two special keywords, ``anon`` for
-anonymous pages, or ``memcg`` for specific memory cgroup filtering.  In case of
-the memory cgroup filtering, you can specify the memory cgroup of the interest
-by writing the path of the memory cgroup from the cgroups mount point to
-``memcg_path`` file.  You can write ``Y`` or ``N`` to ``matching`` file to
-filter out pages that does or does not match to the type, respectively.  Then,
-the scheme's action will not be applied to the pages that specified to be
-filtered out.
+Each filter directory contains five files, namely ``type``, ``matcing``,
+``memcg_path``, ``addr_start``, and ``addr_end``.  To ``type`` file, you can
+write one of three special keywords: ``anon`` for anonymous pages, ``memcg``
+for specific memory cgroup, or ``addr`` for specific address range (an
+open-ended interval) filtering.  In case of the memory cgroup filtering, you
+can specify the memory cgroup of the interest by writing the path of the memory
+cgroup from the cgroups mount point to ``memcg_path`` file.  In case of the
+address range filtering, you can specify the start and end address of the range
+to ``addr_start`` and ``addr_end`` files, respectively.  You can write ``Y`` or
+``N`` to ``matching`` file to filter out pages that does or does not match to
+the type, respectively.  Then, the scheme's action will not be applied to the
+pages that specified to be filtered out.
 
 For example, below restricts a DAMOS action to be applied to only non-anonymous
 pages of all memory cgroups except ``/having_care_already``.::
@@ -385,8 +388,14 @@ pages of all memory cgroups except ``/having_care_already``.::
     echo /having_care_already > 1/memcg_path
     echo N > 1/matching
 
-Note that filters are currently supported only when ``paddr``
-`implementation <sysfs_contexts>` is being used.
+Note that ``anon`` and ``memcg`` filters are currently supported only when
+``paddr`` `implementation <sysfs_contexts>` is being used.
+
+Also, memory regions that are filtered out by ``addr`` filters are not counted
+as the scheme has tried to those, while regions that filtered out by other type
+filters are counted as the scheme has tried to.  The difference is applied to
+:ref:`stats <damos_stats>` and :ref:`tried regions
+<sysfs_schemes_tried_regions>`.
 
 .. _sysfs_schemes_stats:
 
-- 
2.25.1

