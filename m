Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818447;
	b=xcy922UZTH6mVpgbkKIx9HXygvMB4f8OjQ9SuZID9oBA5n9HO0OQZnrfXzJ8q7ktQo2c
	 JiXrl1L6ksNQ2ZDbkrrTacAgFsamJEyjZYZdu6uHVNL0CM/EK+CFJXxf8cxDDxJJdmx0w
	 1S1NAsjJ4d4xN7yjaYOU2HivmM9AMFFu6tXXKbLic80/s8nB0qW4Po7qUi7by61kQc3Mi
	 b1jwV0Hlz/txf+niBosN44YPwqWjLpaASrqxFC2p2j3lSpsXhqIf8B77nz5oxhCDzjb35
	 62PVWyxYK4AkcgK6Y0aB2+7Kvqe6qC53mcYmTAr3uP3y5Ar0siSX8nfJCcq02yrbDow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818447;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bdRKRFKagh7ahfwk2gV4n/6foyOOG7uiXbJX19kNPyY=;
	b=a9jX2UY8wmT2RqTTuYjZC0Y4g8TpPCDIX3Zp061PD772XZpUvKRag5qIhELAHrTazGzI
	 ELVNx837BY4/GI9fryllMmr6RUUeRPgGkiOACYj9OPjY4fFfebpT4mQoERXGaB96YYTJn
	 KaPNazfM2JgiodONmj09QEvLAt4dVoQeoz8ySvU2ppZaQxxF6HEUZFMLYJ+nensX1lNcF
	 jWaH0yPr4aiXV+8ToQY/BpVSnmoIXYcWkMCMFWhPb1hsvM4tCOZmuZ0XZtsZjg9/3kGt9
	 ly2XlU29RWEw2NKjWlz+65zV24FlOe+KnFsJB1dQz9e56QgnT7SE2zEOWGWFKK9ryVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgJzpPXu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DE606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgJzpPXu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779D01F00899;
	Fri, 27 Nov 2026 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818447;
	bh=bdRKRFKagh7ahfwk2gV4n/6foyOOG7uiXbJX19kNPyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MgJzpPXu0BIifZ5pmGjr8ujeHNI9pOSc61O3tOreUSor8axL+/sxxy1wvvLuZofFX
	 6NyPnZC2YA+qi9rQx0+x2ksW1aDWxAM691QEEVS/xQkh5QyvhzYub9q0YTgaxqtwOi
	 IHBA42opq6JPqGSn9ALrzt21vqKerbByqOdkpN3Jt+QdASRwjPjVxFkHKYi3+WrdI5
	 T441iCnXCSztPdMAskpnLU5u/zu6a2+AuxC3MUgNsS2NSorjCaRWen5Rl07+GmS26d
	 h+yGXEWZMl/EYCCiNYLHNjFo/52T3X61ad8VasuyMQeTdNe9Tb0Y0Mg3Aelp1sgmbH
	 dtI9OKnL5crPA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 1/7] mm/damon/vaddr: advance migration attempt in folio level for filter out
Date: Fri, 27 Nov 2026 14:27:12 -0800
Message-ID: <20261127222719.105510-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127222719.105510-1-sj@kernel.org>
References: <20261127222719.105510-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_va_migrate_pmd_entry() finds folios to migrate under the given
pmd, using a loop for the pmd address range.  The loop advances in page
size if a given folio is excluded by DAMOS ops filters.  DAMOS ops
filters work in folio granularity.  Hence it is more efficient and makes
sense to advance in the folio size.

Advance the loop in folio size for the ops filter out decision.  For
that, do the folio size based loop advancement offset update before
applying DAMOS ops filters.

Closes: https://sashiko.dev/#/bug/linux-67c34df7-6dfb-4e18-9ce0-0d26915e5785
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 750e643e020f..ca7ce9bd96e7 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -883,12 +883,12 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		folio = vm_normal_folio(walk->vma, addr, ptent);
 		if (!folio)
 			continue;
+		page_idx = folio_page_idx(folio, pte_page(ptent));
+		nr = folio_nr_pages(folio) - page_idx;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
 		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
 				migration_lists);
-		page_idx = folio_page_idx(folio, pte_page(ptent));
-		nr = folio_nr_pages(folio) - page_idx;
 	}
 	pte_unmap_unlock(start_pte, ptl);
 	return 0;
-- 
2.47.3
