Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B21917E3;
	Mon, 25 Aug 2025 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134728; cv=none; b=Dy74x4LiX68WsMCUkHlb2wBKfw+c77EdstlkhaQq7a7PhQMRa9JPOe/ycghwoKfd9rOrYo+UVc8TpM9Yy6nRJjG9A+J9kDgp/9HjhVj4CT5Z06KcvrI6BRqY9BujxVlbUpvuR8mxKYiL8lTU5Cd7WEjCmsaj1t0munwKJQLYbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134728; c=relaxed/simple;
	bh=RCzfFRa9bhcrr9RKjF/YQSphWZ97OW8ZYfBC6HmBfP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gkiK1/cd3aZd5jF+jTQSihHFTS4ye8XTu5cXguJLM+92/6JPVk9qlO8TFpH43Wie8U911/jZdc+CIU2HEjyZ4J35KPKArKPr92w0feBrfGShH7p0/3fOqU+mDcwz8jrBSfYydlBSHVQlVxCvb4in8CfoB6BRDSISvlXsnh0ojtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiRrf02A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiRrf02A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88D3C4CEED;
	Mon, 25 Aug 2025 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756134727;
	bh=RCzfFRa9bhcrr9RKjF/YQSphWZ97OW8ZYfBC6HmBfP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiRrf02AmMTYLGGM314qi6OKtLmE6osCEHMol980vuE6MQZuBnyse61RheqKkDlUQ
	 DtzLAiVgHeU48Pn5/tfFdDsTQMwCRVTiwKkR7DtAgR7VYPleF12dtPRgAtfyrnktI/
	 fUznpf/s6C3U80anf45FZgF4TAgBLVUflzRM7XxS8XIoNPkaLm6qvuPnVlgP+Njl1m
	 t2Mbt9hF06AWNNQvG/qU2TG5tWL1oUgpULkhftHzVmpnZwVhgwIHHN3jKzm+bakEv+
	 q0WDSSspIeZ2vtGC0PaSU9L55d2dmZ4Bb/c52lJ+EgYLwkCNnxtkSVd7JtHn//N6P5
	 qZdMt+Ax8S94g==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	kernel-team@meta.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 03/11] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Mon, 25 Aug 2025 08:12:05 -0700
Message-Id: <20250825151205.36288-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822093420.2103803-4-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 17:34:11 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit for DAMOS_PAGEOUT action handling from the
> DAMOS operation implementation for the physical address space.
[...]
> -	return applied * PAGE_SIZE;
> +	return applied * PAGE_SIZE / addr_unit;
>  }

Kernel test robot [1] found this can cause __udivdi3 linking issue.  Andrew,
could you please add the below attached fixup?

[1] https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/


Thanks,
SJ

[...]

==== Attachment 0 (0001-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_pageo.patch) ====
From hackermail Thu Jan  1 00:00:00 1970
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Cc: kernel-team@meta.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Date: Mon, 25 Aug 2025 07:41:33 -0700
Subject: [PATCH 1/3] mm/damon/paddr: use do_div() on i386 for damon_pa_pageout()
         return value

Otherwise, __udidi3 linking problem happens on certain configs.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5fad2f9a99a0..09c87583af6c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -135,6 +135,18 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
 	return false;
 }
 
+/* convert physical address to core-layer address */
+static unsigned long damon_pa_core_addr(phys_addr_t pa,
+		unsigned long addr_unit)
+{
+#ifdef __i386__
+	do_div(pa, addr_unit);
+	return pa;
+#else
+	return pa / addr_unit;
+#endif
+}
+
 static unsigned long damon_pa_pageout(struct damon_region *r,
 		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
@@ -190,7 +202,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 	applied = reclaim_pages(&folio_list);
 	cond_resched();
 	s->last_applied = folio;
-	return applied * PAGE_SIZE / addr_unit;
+	return damon_pa_core_addr(applied * PAGE_SIZE, addr_unit);
 }
 
 static inline unsigned long damon_pa_mark_accessed_or_deactivate(
-- 
2.39.5
