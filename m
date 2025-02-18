Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1BD1DE2A1;
	Tue, 18 Feb 2025 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918239; cv=none; b=eX2cCFFhhy+hktJUy0bErGvoWjVmZR8iKM3NWS2jtHbWu/lyOpwPyluBEjOVUn9+WpteD4XblQzPSzLaY/W1/tZbSHfuuI63cfsEx9fLL5rqBwBwNhuaQiwewxYy8wtzMBje73QbtUAVMmKqAr7fdjts3AO8an2+EJWtP0PXP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918239; c=relaxed/simple;
	bh=cs8GWYYnDK1JIzMR8vzHgXGMzwJ95MlnMu1w0ifV6mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laXiJ8N7Hhd8pqg4/rmXlwhuUBZ+1wlpaP3VM9tEnuDdZnm2Qi4CCv9CN+zgkDZ3WsJjU6v2OBMIKB6uDEDWKPgivG2qY7TMhIrXUaUtXxD/4hbOZDZ6sRBtWx0sLnhu+asK/pT6Kkp6q+F03wW8sOViNtVTCJNPsGVGqafQS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFPQXAh9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFPQXAh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14831C4CEEB;
	Tue, 18 Feb 2025 22:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918239;
	bh=cs8GWYYnDK1JIzMR8vzHgXGMzwJ95MlnMu1w0ifV6mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFPQXAh9VN+N/yc8FjF9P74m7RQSFVU5vj7N84H2Hx5TnOc5Q14GoVjY0jtuSRlVS
	 EXbY1/CzBriQvD/ml+QMe7tsrwejA4KolgzANUptgJNMuunGt9kyB7WfAcz+uYJroW
	 Qc+HeqmIZpJtzk/tpZpt9wJkK25AVCWMKOVl1Z+YBL1qTr9dNhB2lZ82cOh6l3uqMk
	 rDqRZJX4JUYA7x2Rnuj0MiMJzGQW6+sK7fEPZjnBJYWKLuIINxYFCuiKWzP9iKc7d5
	 KZf6X4g1kpvOllzbjLMW0S/oIffkc9Yjg33uXj3NS093kPNgMnHq8OGKLf8Og7OLLY
	 X1pUSNhMRtpzg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/5] Docs/mm/damon/design: clarify handling layer based filters evaluation sequence
Date: Tue, 18 Feb 2025 14:37:07 -0800
Message-Id: <20250218223708.53437-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218223708.53437-1-sj@kernel.org>
References: <20250218223708.53437-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an element of memory matches a DAMOS filter, filters that installed
after that get no chance to make any effect to the element.  Hence in
what order DAMOS filters are handled is important, if both allow filters
and reject filters are used together.

The ordering is affected by both the installation order and which layter
the filters are handled.  The design document is not clearly documenting
the latter part.  Clarify it on the design doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 7360e5ac0d06..8b9727d91434 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -569,11 +569,21 @@ number of filters for each scheme.  Each filter specifies
 - whether it is to allow (include) or reject (exclude) applying
   the scheme's action to the memory (``allow``).
 
-When multiple filters are installed, each filter is evaluated in the installed
-order.  If a part of memory is matched to one of the filter, next filters are
-ignored.  If the memory passes through the filters evaluation stage because it
-is not matched to any of the filters, applying the scheme's action to it is
-allowed, same to the behavior when no filter exists.
+For efficient handling of filters, some types of filters are handled by the
+core layer, while others are handled by operations set.  In the latter case,
+hence, support of the filter types depends on the DAMON operations set.  In
+case of the core layer-handled filters, the memory regions that excluded by the
+filter are not counted as the scheme has tried to the region.  In contrast, if
+a memory regions is filtered by an operations set layer-handled filter, it is
+counted as the scheme has tried.  This difference affects the statistics.
+
+When multiple filters are installed, the group of filters that handled by the
+core layer are evaluated first.  After that, the group of filters that handled
+by the operations layer are evaluated.  Filters in each of the groups are
+evaluated in the installed order.  If a part of memory is matched to one of the
+filter, next filters are ignored.  If the memory passes through the filters
+evaluation stage because it is not matched to any of the filters, applying the
+scheme's action to it is allowed, same to the behavior when no filter exists.
 
 For example, let's assume 1) a filter for allowing anonymous pages and 2)
 another filter for rejecting young pages are installed in the order.  If a page
@@ -590,14 +600,6 @@ filter-allowed or filters evaluation stage passed.  It means that installing
 allow-filters at the end of the list makes no practical change but only
 filters-checking overhead.
 
-For efficient handling of filters, some types of filters are handled by the
-core layer, while others are handled by operations set.  In the latter case,
-hence, support of the filter types depends on the DAMON operations set.  In
-case of the core layer-handled filters, the memory regions that excluded by the
-filter are not counted as the scheme has tried to the region.  In contrast, if
-a memory regions is filtered by an operations set layer-handled filter, it is
-counted as the scheme has tried.  This difference affects the statistics.
-
 Below ``type`` of filters are currently supported.
 
 - anon
-- 
2.39.5
