Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693F4D9F2;
	Sun, 12 May 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536495; cv=none; b=ZY/XV/9k4/mittFtm6m//c65fm5a0ibL8Qr5TtOYk7Fmfcx6gwKfWQ+GQMELNhRIMRCz2RxPBPUTrFkTc1mgXAQk1IUmDzCVk7BbJaQ6GJEcfjky2xdNSUUs/Tz3S3UQt6q4tjrFXBVz2Krkao8e80YflqiBjcJWOSF6PuaQrfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536495; c=relaxed/simple;
	bh=dAqk9DDy2iHhz/atR+7qN/JQ2SHCLI1jeIZ9SIxQ32U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+FgJ61MNBHeBOP6CCBR1dcybslWAvjCOrYhF7Mjpq9PkZYYEgv+Aad2xr+rc9tsMwdimTsqkua9h3n6TgPqSTk4bhZvwsEWnXSkRBB33aeuch7YUMrxd92gPx3m63U36dcUaogqBS3XGA1+ML2yiVPER5z1dZl+SbUUGJtp+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzfZLIO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzfZLIO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FBFC4AF07;
	Sun, 12 May 2024 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715536495;
	bh=dAqk9DDy2iHhz/atR+7qN/JQ2SHCLI1jeIZ9SIxQ32U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YzfZLIO0xU4xk2uGqYmJFr7f3seXBey3bXrqIjZdiw/SFtMH+fG1I9q4CFgFopxqd
	 IVCnp0TttZkN0fqtW1I0HRDOz9zY7Hqm+1AvNaxbdN/NJXc7SOWQOtXo2Ro+ts6agQ
	 t0HwAzSIReX9f0lWCnagZvNE5sfntr6LCRIzsAUroGijBR6Pxq2vnA9Y4IS9H2QvAG
	 L1cQBBw0OLhgd7HoABJbPLpial7xLk3jDLhb3Z1BR9aYlaIGTYdAWCcoHKkSnrIGyA
	 yJRHG4yG8JyLOix4tNXkKsQHuWXDuTQcrpMKOM/c6OV6IW9l/86wjhbPIkQu181ai+
	 HaBDUF3ADFFGw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH v4 1/5] mm: make alloc_demote_folio externally invokable for migration
Date: Sun, 12 May 2024 10:54:43 -0700
Message-Id: <20240512175447.75943-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512175447.75943-1-sj@kernel.org>
References: <20240512175447.75943-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Honggyu Kim <honggyu.kim@sk.com>

The alloc_demote_folio can be used out of vmscan.c so it'd be better to
remove static keyword from it.

This function can also be used for both demotion and promotion so it'd
be better to rename it from alloc_demote_folio to alloc_migrate_folio.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/internal.h | 1 +
 mm/vmscan.c   | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e..b3ca996a4efc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1052,6 +1052,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
+struct folio *alloc_demote_folio(struct folio *src, unsigned long private);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6981a71c8ef0..27269bc2bcc5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -933,8 +933,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
-static struct folio *alloc_demote_folio(struct folio *src,
-		unsigned long private)
+struct folio *alloc_demote_folio(struct folio *src, unsigned long private)
 {
 	struct folio *dst;
 	nodemask_t *allowed_mask;
-- 
2.39.2

