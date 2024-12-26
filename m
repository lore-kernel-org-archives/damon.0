Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C81CEAD0;
	Thu, 26 Dec 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251306; cv=none; b=SVihn6qhOJtB5tCnDemc287U5T1xbE7lZEWfdQffebajp0840L44448J3f9ChrMcKjsEndaG1NUpfMQ1nb/MK3AxLSPoCYteJ8cV0efLXd2jjpjgNySpKtN3DLoKfqxSFYnxyM4CpO66soW4US9wOh/v8cScP/AvPq6NlttJzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251306; c=relaxed/simple;
	bh=//vhFtbVl0HM6He0HK/Z+ZVxsC9xYIvf1nEXj2Zge2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UsXd6kk9QWZ7i1JQN7uuvyHje8gqVbUG1T2ewgL+x7vh29ZgAlatQ+4Lz8vteqNVz2p3cUi6u+P6w9zH9PXlB0L+zvD2CzEwJod9EttqXEJV6kxcmvt9K9p+3YzgJE2lCtfFzKsfM+bkOfmWrUBoJ+ph63f5DU3xKpYv8W7eB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rp1/LE7w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rp1/LE7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5282AC4CEDC;
	Thu, 26 Dec 2024 22:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735251306;
	bh=//vhFtbVl0HM6He0HK/Z+ZVxsC9xYIvf1nEXj2Zge2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rp1/LE7wL75YYPfqE6SY8gZNoaSFeZEa7VCvo/p2eTd0835XsUSEdUd72yQOjrOqv
	 VpSJXimUnRRGeWrvbBQxqWXKAprKqYpFlTiGYm8Ut41GFZiEymEFh1RSnJNLyeCOtm
	 LPo3Nz8X5PR+wBLZQHV5syAt1hTIpXz4a9GqmrLARSD5ZPqV5Bcl5hrl5wtGQJxVDQ
	 8EDKNtOiHzdjP3TC62fpO9VGP9c3vh/rGSJpqj0yTsq9OqJkS53vSq4CFlafKNHv86
	 BQ4HUUWEQK2+GO87ss3pG5IAd/CR+8BBeHYYBHXLNW2+c2bsxXKqOiQlhERn7hJnZ5
	 sV/wL+qtF8bWA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/10] Docs/mm/damon/design: document pass/block filters behaviors
Date: Thu, 26 Dec 2024 14:14:42 -0800
Message-Id: <20241226221445.78433-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241226221445.78433-1-sj@kernel.org>
References: <20241226221445.78433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMOS filters design document to describe the pass/block
behavior of filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5ebb572d0999..0265aaef2544 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -504,9 +504,30 @@ have a list of latency-critical processes.
 
 To let users optimize DAMOS schemes with such special knowledge, DAMOS provides
 a feature called DAMOS filters.  The feature allows users to set an arbitrary
-number of filters for each scheme.  Each filter specifies the type of target
-memory, and whether it should exclude the memory of the type (filter-out), or
-all except the memory of the type (filter-in).
+number of filters for each scheme.  Each filter specifies
+
+- a type of memory (``type``),
+- whether it is for the memory of the type or all except the type
+  (``matching``), and
+- whether it is to allow (pass through the filter) or reject (block) applying
+  the scheme's action to the memory (``pass``).
+
+When multiple filters are installed, each filter is applied in the installed
+order.  If a memory is matched to one of the filter, followup filters are
+ignored.  For example, let's assume a filter for passing anonymous pages and
+another filter for blocking young pages are installed in the order.  If a page
+of a region that eligible to apply the scheme's action is an anonymous page,
+the scheme's action will be applied to the page regardless of whether it is
+young, since it matches with the first filter.  On the other hand, if a page of
+the region is a non-anonymous page, the scheme's action will be applied only if
+the page is young, since the second filter is also applied.
+
+Note that DAMOS action is eligible to be applied to any memory that satisfies
+other conditions if no filter is isntalled.  Meanwhile, DAMOS filters work for
+only memory that satisfies ``type`` and ``matching``.  It means installing only
+pass filters is same to installing no filter, because pass filters dont' block
+memory of type that not specified to pass.  For any use case, at least one
+block filter should be installed as the last one.
 
 For efficient handling of filters, some types of filters are handled by the
 core layer, while others are handled by operations set.  In the latter case,
@@ -516,7 +537,7 @@ filter are not counted as the scheme has tried to the region.  In contrast, if
 a memory regions is filtered by an operations set layer-handled filter, it is
 counted as the scheme has tried.  This difference affects the statistics.
 
-Below types of filters are currently supported.
+Below ``type`` of filters are currently supported.
 
 - anonymous page
     - Applied to pages that containing data that not stored in files.
-- 
2.39.5
