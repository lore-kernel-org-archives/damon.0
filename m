Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27037186D
	for <damon@lists.linux.dev>; Mon, 13 Jun 2022 19:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B180C341C5;
	Mon, 13 Jun 2022 19:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655148192;
	bh=sOSbjIcAeZVbU2/qKMJLnCAeX6/kYK4mBHuJd9HgKYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFg5Rpysf9zbj5CtehWxzO10QOsIcqZFMAVehvaCj3ken4joxESy5KiDIEht0Ewdm
	 zM2aLSGCzJ9xYnTsvdov8f30Ez/QfGpjDuaXq9Q5EXlwxWuiRsOp4EGJGYK9Sm1MYn
	 NLr2uMG31AI4D7Wi2+I2cEK3TVzrifqxZ7FfbmCasCdj0PxBhCHRly5PmHnDrxI+nf
	 rz75VQTOAywnAB6tvsLpIVCV3iCRPw1YYPkoesHUHMHLW0228C1/BiFdAAKnPSZLqp
	 QqFWbG/Ltkm/xR6bAEBKwdAlDpNdyY3RasJcTuV9NxwNKLRwwYfoOLMWKNyNLrG0E0
	 MoVQ7WfKoaC9g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] mm/damon/schemes: add 'LRU_DEPRIO' action
Date: Mon, 13 Jun 2022 19:22:58 +0000
Message-Id: <20220613192301.8817-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613192301.8817-1-sj@kernel.org>
References: <20220613192301.8817-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a new DAMON-based operation scheme action called
'LRU_DEPRIO' for physical address space.  The action deprioritizes pages
in the memory area of the target access pattern on their LRU lists.
This is hence supposed to be used for rarely accessed (cold) memory
regions so that cold pages could be more likely reclaimed first under
memory pressure.  Internally, it simply calls 'lru_deactivate()'.

Using this with 'LRU_PRIO' action for hot pages, users can proactively
sort LRU lists based on the access pattern.  That is, it can make the
LRU lists somewhat more trustworthy source of access temperature.  As a
result, efficiency of LRU-lists based mechanisms including the
reclamation target selection could be improved.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/paddr.c      | 20 ++++++++++++++++++++
 mm/damon/sysfs.c      |  1 +
 3 files changed, 23 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4c64e03e94d8..7b1f4a488230 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -87,6 +87,7 @@ struct damon_target {
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
+ * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  */
@@ -97,6 +98,7 @@ enum damos_action {
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
 	DAMOS_LRU_PRIO,
+	DAMOS_LRU_DEPRIO,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
 };
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index f145b1d51e13..dc131c6a5403 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -249,6 +249,22 @@ static unsigned long damon_pa_mark_accessed(struct damon_region *r)
 	return applied * PAGE_SIZE;
 }
 
+static unsigned long damon_pa_deactivate_pages(struct damon_region *r)
+{
+	unsigned long addr, applied = 0;
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct page *page = damon_get_page(PHYS_PFN(addr));
+
+		if (!page)
+			continue;
+		deactivate_page(page);
+		put_page(page);
+		applied++;
+	}
+	return applied * PAGE_SIZE;
+}
+
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
@@ -258,6 +274,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_pageout(r);
 	case DAMOS_LRU_PRIO:
 		return damon_pa_mark_accessed(r);
+	case DAMOS_LRU_DEPRIO:
+		return damon_pa_deactivate_pages(r);
 	default:
 		break;
 	}
@@ -273,6 +291,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 		return damon_pageout_score(context, r, scheme);
 	case DAMOS_LRU_PRIO:
 		return damon_hot_score(context, r, scheme);
+	case DAMOS_LRU_DEPRIO:
+		return damon_pageout_score(context, r, scheme);
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 86c69f980927..7488e27c87c3 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -763,6 +763,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"hugepage",
 	"nohugepage",
 	"lru_prio",
+	"lru_deprio",
 	"stat",
 };
 
-- 
2.25.1

