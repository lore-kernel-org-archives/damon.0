Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953A1F9ABC;
	Fri, 27 Dec 2024 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735333714; cv=none; b=maotbL0HuyYcIAuViJGsKQkrdBSp4BEFoSlCMLQ77ctNV7wfSP0atvNaTs52Esnma3cLxGZb0DfVD4Wfd5kkLwj6lZRVqkr1IlN73n/4fZ6JLcc6GLG6BNiW0atGYRECS9lY1mutSVfSusHmwIxM2FVsC/ZsZ79VPgD174bPzDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735333714; c=relaxed/simple;
	bh=//vhFtbVl0HM6He0HK/Z+ZVxsC9xYIvf1nEXj2Zge2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aet3xe+sr2NMCIM1zWx3rUqxx2QC6jB+8+IPu7J/lyEOslqwRIE7GpPEdWfg8JpyW2gTA4qWs31Gyo6hCfXGzAZcEa89AsxXkli7bRjVAalmI1hbvqms1YaBE7EGlYSi/3CbpbUbdYsV3Zt4rNQEBMzAqPuLErJaEme88xcVI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQUefMj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQUefMj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD5EC4CED6;
	Fri, 27 Dec 2024 21:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735333714;
	bh=//vhFtbVl0HM6He0HK/Z+ZVxsC9xYIvf1nEXj2Zge2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQUefMj+FWzM4VXbZDc5roHqMXa+dd9KuutCjSQ56NMbUULomhMHqHipp3Wt8VRJ8
	 SjtLPjHWtNuv0pMuFtHg6a2Jh7HSUXt96HVF+2RcySb2IC2QxdilgtLQYf7fqrKLy0
	 oPykW2Z0eAKxfvmtDy2AuQpNB7zW+mxWx8Qo+z8lRvc5+lDBQ5vbQwwNAD1tjUp4VP
	 W46QWVpxZU5cVDdi2xiSOEIA4Aou+m7YChX4uD4y5seECyH9q9zP8iOYgPAJfbWLRw
	 caCg2KF8cu0umenRO1N2fY/uPRQqIqGjrWAaznZFfEKsoWAFa6LhCJVwna5Sp+FrNJ
	 nRcl1uIXj0ESw==
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
Subject: [RFC PATCH v2 07/10] Docs/mm/damon/design: document pass/block filters behaviors
Date: Fri, 27 Dec 2024 13:08:16 -0800
Message-Id: <20241227210819.63776-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241227210819.63776-1-sj@kernel.org>
References: <20241227210819.63776-1-sj@kernel.org>
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
