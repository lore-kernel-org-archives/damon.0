Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C581AAE0D;
	Thu, 19 Dec 2024 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581038; cv=none; b=qbkfjLmyzuiOi/vBcNK7GYOaHpCKHt9xnPkoGVLeLf8ep9FUda/HDJiTczsla7DyJG6HcWqFhMmurDTSOu9kjzLWJqjwPxpJtS/FiU3qGuxJjvh0l+ScUC9+JcNcBEvia3TZcPP0VQAyf8h22cAmESEEQo+XE7/EBZ2rNA1V5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581038; c=relaxed/simple;
	bh=h5r/y4q9OO288YZFlZV7V3CQiTTX7mBJ1xQ9QZ3zXD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4Fv5G5RZXCwAZvfKya+yWt9gjKQIfwvnwbyrHR5zzdIvOSv9YFN6MHHt38Lkzxt8W4KPMtVmc15jNzo22a70jamz4ybgOOpn9kfycRIpra9Sa9AQi0enIqmnx13IGF/q94nX84QDJm9BJTv0HxS6Q4OQTnuWUjMdKixsXg/w5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEFCee2b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEFCee2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39983C4CED6;
	Thu, 19 Dec 2024 04:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581038;
	bh=h5r/y4q9OO288YZFlZV7V3CQiTTX7mBJ1xQ9QZ3zXD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEFCee2bmSQtQ9UaGk1XPKYTROA/k1oiKvsqBrXetaeL9jreOXIZlDthVtyNK0w6c
	 QTITd37deEBoPOY8rnjNAMMzSBeAWlyBG4HYLyL1SkvRmk3NXHGDoYnQpwH0Wcso03
	 NR7zGEGK8Ki1cWIuqOilbajHjbrnuc0ToyKh0aX8S+AkqiiErZDO+cYHxYzkNXohkO
	 TMpZXT+pUp1u4Y33yM44o6NPzGnmjB/MsOql//UzofnTPvF0qz3C6Izsidxq2ukucH
	 vbRvVhcePmcwnQnFSbQsQUCyszB1kiMpBlfQPBiri4PbsCDalpVjkjfDyswWc4Fo1L
	 iHSkkL0K7yX3w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 17/18] Docs/admin-guide/mm/damon/usage: document sz_filtered_out of scheme tried region directories
Date: Wed, 18 Dec 2024 20:03:26 -0800
Message-Id: <20241219040327.61902-18-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
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
index 179a9060a32e..a891e830c2a1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -92,7 +92,7 @@ comma (",").
     │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
-    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
+    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ ...
@@ -500,10 +500,10 @@ set the ``access pattern`` as their interested pattern that they want to query.
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

