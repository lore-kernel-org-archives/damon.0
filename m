Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC31E47A4;
	Mon,  6 Jan 2025 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192068; cv=none; b=czDBHYd9QLSyCbrLx/s10PGkiU+wNlsEOxpfoNhHh77LEAP11BjbxJgKVZV4ezShWKEqnbL9sF3z77exYomUTM3ym5VFevh3H3AXAxxQ0RoyFw45DDTNU2uCfTKZ48cAsPMKVVzYFtH4I9NrSv20mM6eBK3YIuKCaNrj5gxuKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192068; c=relaxed/simple;
	bh=rTeP/RjcXjYoOv0J/uUnolt0hy96UnSrvDc4IrgaeA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9TErN6cwlAg5MskrReurVHqzlpGPlNYnFh0fCDoisjlWd8isK/fRyBVTVhpZEjeiyQyhjrgqlWp36/cLjbKWFGba78mPbZ8BcH49uSqH82dcw93IqDykhx6eVQhEpO+wWJtHmTE524aLwf0Iaz3cNUOq1+W4ga1Lwgq5214vmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSnQVJsP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSnQVJsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E106C4CED2;
	Mon,  6 Jan 2025 19:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192067;
	bh=rTeP/RjcXjYoOv0J/uUnolt0hy96UnSrvDc4IrgaeA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sSnQVJsPXoRIaYHCZbDfi+aHFFaxuVkhI/cB/qynYScRZkhs0we/TK9Sa2gbVyLd1
	 m8neYW8nQcKHUeUp87tJQQPUGSmRC2MjP5+2G2lvrbVC0zBsNIKUvwNYP/Nb3ihXJb
	 AGldb5ldLQbnaZi5GkHBWD77Aj6FKNbLjnXiasCGBSqkpl87p/clR+DhJwXjp5IoOt
	 vZC2kEFVX/2mko5lFX0G6NUI8TBu6XIIY6rqGYX7PZ4zmpdyvCr3hWth+vjag//tW/
	 9Y6h9H57N1sMOu1tJjm1LnpEW4fYtIIWBDwP+yD5MfO7kuVEMxwSZJPTUNr4z/RlKI
	 Nbl1XYrT0gxfw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 15/16] Docs/admin-guide/mm/damon/usage: document sz_filtered_out of scheme tried region directories
Date: Mon,  6 Jan 2025 11:34:00 -0800
Message-Id: <20250106193401.109161-16-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document the newly added DAMON sysfs interface file for per-scheme-tried
region's bytes that passed the operations set handling DAMOS filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 95c174be9c06..71cf29ae8502 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -86,7 +86,7 @@ comma (",").
     │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
-    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
+    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ ...
@@ -494,10 +494,10 @@ set the ``access pattern`` as their interested pattern that they want to query.
 tried_regions/<N>/
 ------------------
 
-In each region directory, you will find four files (``start``, ``end``,
-``nr_accesses``, and ``age``).  Reading the files will show the start and end
-addresses, ``nr_accesses``, and ``age`` of the region that corresponding
-DAMON-based operation scheme ``action`` has tried to be applied.
+In each region directory, you will find five files (``start``, ``end``,
+``nr_accesses``, ``age``, and ``sz_filter_passed``).  Reading the files will
+show the properties of the region that corresponding DAMON-based operation
+scheme ``action`` has tried to be applied.
 
 Example
 ~~~~~~~
-- 
2.39.5
