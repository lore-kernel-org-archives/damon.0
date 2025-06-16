Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F61288C95;
	Mon, 16 Jun 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094632; cv=none; b=SwQdlwWlcRvFLXEZ/XUpQlyt+bhkTWtDRrUQTkiNeKn4w37nmEIf2GNESen70MMuSkjjiMBGbeBaeUZvUEYC4hUalpkzvZzp5XzhjAuW77zIb81S9Nsn3M7TdZuM5KSHxWFJ6bUU8B3MV5IqLzc+vRslm6F30rLjfl13hFJNbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094632; c=relaxed/simple;
	bh=NOlqXu1Kg0/ms957gwPWMk5PWBJC6WX6Zl6AgwkZrrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VXCJxcg3Jq0VcUmwdsjFHmM7SMgBNV0sxGnUdYZ66wn8T1RrraIp58xnaStxwKsHIAipcsdGoYxJD6K5NvHABNAwvv917hvG5Z9NiKMBtF093G2ALfmt7oPRgW07ZmmQI9SI3jGeeCF0nIeoWMLTOGfeDsELgJxGQ/MJz5CsHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiAc9olN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiAc9olN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12136C4CEEA;
	Mon, 16 Jun 2025 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750094632;
	bh=NOlqXu1Kg0/ms957gwPWMk5PWBJC6WX6Zl6AgwkZrrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CiAc9olN0+Oin6KtnUIi1SwOuIovCaArn6UMRu5OS0/4j0XG54149WQurEDbvvjYs
	 EbWrRBFmipFUA/A14rWbP/Y3dmxaWtL9bFh9trsHZoo37/Cu5p23YIq08XOzp5ZWJB
	 dOF2fH+FpnNuSqfaVCwtNkf1eyrJDrx5b3vydYHpDV4tJ6ruzWxaHxxgYEh6HAo2qw
	 94S3nwkanTR2CjWc6vEc0L5omc/3u1M2tQtlWW6FTSgdP6ObqAjARBltCWaF19/q2u
	 Rkry65PU+o8RVvL/FVove1VKCRnLsHmokXs9arfvUKV7XaurxVSb9fhznJQekV0nbZ
	 rRLIcihU5jWRg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] Revert "mm: rename alloc_demote_folio to alloc_migrate_folio"
Date: Mon, 16 Jun 2025 10:23:45 -0700
Message-Id: <20250616172346.67659-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250616172346.67659-1-sj@kernel.org>
References: <20250616172346.67659-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 8f75267d22bdf8e3baf70f2fa7092d8c2f58da71.

Commit 8f75267d22bd ("mm: rename alloc_demote_folio to
alloc_migrate_folio") was to reflect the fact the function is called for
not only demotion, but also general migrations from
DAMOS_MIGRATE_{HOT,COLD}.  The previous commit made the DAMOS actions to
not use alloc_migrate_folio(), though.  So, demote_folio_list() is the
only caller of alloc_migrate_folio(), and the name could now be rather
confusing.  Revert the renaming commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/internal.h | 2 +-
 mm/vmscan.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3823fb356d3b..aedcf95737ed 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1227,7 +1227,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
-struct folio *alloc_migrate_folio(struct folio *src, unsigned long private);
+struct folio *alloc_demote_folio(struct folio *src, unsigned long private);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a93a1ba9009e..6bebc91cbf2f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1006,7 +1006,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
-struct folio *alloc_migrate_folio(struct folio *src, unsigned long private)
+struct folio *alloc_demote_folio(struct folio *src, unsigned long private)
 {
 	struct folio *dst;
 	nodemask_t *allowed_mask;
@@ -1069,7 +1069,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	node_get_allowed_targets(pgdat, &allowed_mask);
 
 	/* Demotion ignores all cpuset and mempolicy settings */
-	migrate_pages(demote_folios, alloc_migrate_folio, NULL,
+	migrate_pages(demote_folios, alloc_demote_folio, NULL,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
 
-- 
2.39.5
