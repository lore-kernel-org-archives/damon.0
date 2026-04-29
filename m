Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C138AC9E;
	Wed, 29 Apr 2026 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777435959; cv=none; b=M+w4XHyZO9B41h+cu8a9lynILS1Gxfw5nlajY9Q1cnxhkgI8Zrs7npw6c/kPA5tXASiEm/8GbYWY85qCHTcZjoo4nK9lCeUcGTP3RcW6ogSumLqxa+HpKcko4hVOT8xyE29lU8D+8DSfYmXcrIbH0O0lY1xIJWmg/wRx5fFJrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777435959; c=relaxed/simple;
	bh=M+ZCKDs15omwhqSNEq9DSlBKj4hfJOQxX08s5GsHoNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGKPaTLEA2Ds0GmGSiuqIX5N0GxncOESEBYaUCut/cpAwkSgZ5mqaMC7w65O/jxxLU0xNv7tyLmVXNNIqwbJQLsbWG6/IGDs2ChWxO0ZWXgNL6SeaNUuj7Y6XT/b8HD0g6ShPa6xFIbqdgNJWYnt8bPKg2+o/KdqTOdbvSdtg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/Ub3bsI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/Ub3bsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D1DC2BCB4;
	Wed, 29 Apr 2026 04:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777435959;
	bh=M+ZCKDs15omwhqSNEq9DSlBKj4hfJOQxX08s5GsHoNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/Ub3bsI4oZq4qktJLPFghhfsWU/YqsnepWRznNQdTlnYZe4j+m98Qlp5Zc+7deiI
	 pbu/d+QDsUFb5IekgG7Jf1Dv+THzn7tnFjbRF3gOnSYBP0XPRZVzVBsKSmnrzgfJRh
	 YAnMFu4SLPnMna2xRj7nKEoxp3cpYt95ZJRw6DmNHelrggj1oQ1EwzoS/SUGPCjUkD
	 moEcDkIabkGvKq4OGjtID2FsJTgVkRGd/mS+1G9EXhVceIiywg2pVS/CRbwBgLB086
	 Z6oeETCFucNTQB7x4XJRCxESPF80BrzIGTKwAFJpuY0DsIDwDdRt3HZ/G1V4LaFxpI
	 VPZUmYIsbwC+w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/7] Docs/admin-guide/mm/damon/reclaim: update for entire memory monitoring
Date: Tue, 28 Apr 2026 21:12:28 -0700
Message-ID: <20260429041232.90257-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429041232.90257-1-sj@kernel.org>
References: <20260429041232.90257-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON_RECLAIM usage document for the changed default monitoring
target region selection.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 01a34c215b66f..57ab8b1876506 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -229,7 +229,8 @@ Start of target memory region in physical address.
 
 The start physical address of memory region that DAMON_RECLAIM will do work
 against.  That is, DAMON_RECLAIM will find cold memory regions in this region
-and reclaims.  By default, biggest System RAM is used as the region.
+and reclaims.  By default, the system's entire physical memory is used as the
+region.
 
 monitor_region_end
 ------------------
@@ -238,7 +239,8 @@ End of target memory region in physical address.
 
 The end physical address of memory region that DAMON_RECLAIM will do work
 against.  That is, DAMON_RECLAIM will find cold memory regions in this region
-and reclaims.  By default, biggest System RAM is used as the region.
+and reclaims.  By default, the system's entire physical memory is used as the
+region.
 
 addr_unit
 ---------
-- 
2.47.3
