Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20321156F3
	for <damon@lists.linux.dev>; Fri, 28 Jul 2023 20:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81061C433C9;
	Fri, 28 Jul 2023 20:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690576492;
	bh=OCzjAXySbo2P2W2ofPo/GLfYFykKqV/gINis3/IWY+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heq5ttnp+0povkEP2NQq2cKCGH6lIIYkoMJQgmhO9vQAax7BDzcr7DdU1Q787/Wq6
	 Q9YeJVWmEHUFLd5qRENHxmVH7CqsLYHLU+C9jYL0lY2f9fTzGd89JOSSEKcugjH5qV
	 +4OBdFvsT2CsHNrjMfFwwft/J4k+Sn3di3qmQeI8yWpwnFfHQadtT9Nhb/Sh+YCC+o
	 13cM5XYudDgbte9YduCx4h3FLlpSG0BPdG2nb3Nhzv20aF3IqPZIVxzyK5nrHmLY1z
	 cePPG89HaxuFAEeiheYUlMAMH8JDYucg43I689mqC6DQhyBbg3QctN4ksFohaXYEeh
	 kBPKIAB9Al3EA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/13] Docs/mm/damon/design: update for address range filters
Date: Fri, 28 Jul 2023 20:34:36 +0000
Message-Id: <20230728203444.70703-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document's DAMOS filters section for address range
DAMOS filters.  Because address range filters are handled by the core
layer and it makes difference in schemes tried regions and schemes
statistics, clearly describe it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 4bfdf1d30c4a..134912166f5a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -380,12 +380,21 @@ number of filters for each scheme.  Each filter specifies the type of target
 memory, and whether it should exclude the memory of the type (filter-out), or
 all except the memory of the type (filter-in).
 
-As of this writing, anonymous page type and memory cgroup type are supported by
-the feature.  Some filter target types can require additional arguments.  For
-example, the memory cgroup filter type asks users to specify the file path of
-the memory cgroup for the filter.  Hence, users can apply specific schemes to
-only anonymous pages, non-anonymous pages, pages of specific cgroups, all pages
-excluding those of specific cgroups, and any combination of those.
+Currently, anonymous page, memory cgroup, and address range type filters are
+supported by the feature.  Some filter target types can require additional
+arguments.  For example, the memory cgroup filter type asks users to specify
+the file path of the memory cgroup for the filter, while the address range type
+asks the start and end addresses of the range.  Hence, users can apply specific
+schemes to only anonymous pages, non-anonymous pages, pages of specific
+cgroups, all pages excluding those of specific cgroups, pages in specific
+address range, and any combination of those.
+
+To handle filters efficiently, the address range type filter is handled by the
+core layer, while others are handled by operations set.  If a memory region is
+filtered by the core layer-handled filter, it is not counted as the scheme has
+tried to the region.  In contrast, if a memory regions is filtered by an
+operations set layer-handled filter, it is counted as the scheme has tried.
+The difference in accounting leads to changes in the statistics.
 
 
 Application Programming Interface
-- 
2.25.1

