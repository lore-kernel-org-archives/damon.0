Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66A134B6
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF748C433C7;
	Wed,  2 Aug 2023 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691012599;
	bh=OCzjAXySbo2P2W2ofPo/GLfYFykKqV/gINis3/IWY+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUY46xF7JqWyv4xqIFT5XLrz9FauytM1EkCm1oel9sWJQ0iCMj0WzZBtKq2pXQ+eH
	 2wuOPp+Gpx8XS7jBUD5QU1IobXgPnT/MdQMklMZD/IoaZQRWBVJfnLrtqGBljC1BZ8
	 oSrKO0CnfUwrjpnPBPt7lHU4RAIrgaJY18cWctBUEzU/3n+5ZfAZdkq9XBuaANfRKO
	 QYaY46+oWoNTKZJrtiEGDB8ls7al1YS94keLHmddp2Es71dupRGlPFPdY9Clwc9uI6
	 f3waIxdyaJ652r3kNBOxrQAZXy7XuA9Owyh3fs5aRS/bIsxrpEHBuERf7H7wP0Ptxl
	 FekurPKo97gLg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] Docs/mm/damon/design: update for address range filters
Date: Wed,  2 Aug 2023 21:43:04 +0000
Message-Id: <20230802214312.110532-6-sj@kernel.org>
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

