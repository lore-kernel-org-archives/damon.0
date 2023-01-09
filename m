Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910F5232
	for <damon@lists.linux.dev>; Mon,  9 Jan 2023 21:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EB2C43392;
	Mon,  9 Jan 2023 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673300026;
	bh=S9qpLQ77vZLkX0Fi/FnXthnFg4be2LJbk3/kO/j1qTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jRDHdTCz4fpg4pSg+atnuiWHPSzA34OuiyN0y4hpkdydvPbEXc5zQNd2rmXYtLG3R
	 3qnhCqhu0s5e6yY71KGAHWgxIuU/eKP9xpeghcLzTaHoAiaNpS1AV6Ixh21DKD0orM
	 uSzwGl7Itp0qOi0SAjUWVJgo6gllE3SdJ2Tfo53cV7OsSDL+n310BVjzmPDIcm0XMO
	 p8wPGPwVOXBEM6ivtFSJskAo1VQNvggSIM9GNleCP4uRobOuMxdi9GBMueeRyyR1Rr
	 BEaar4UIe6j/wPq/l0eaX6+bLZBckUQuURSfg9NUCEN8MXUiJ4raIz5tcuKTpBcfsR
	 BUGNJ394IFnhg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm/damon/vaddr: support folio of neither HPAGE_PMD_SIZE nor PAGE_SIZE
Date: Mon,  9 Jan 2023 21:33:31 +0000
Message-Id: <20230109213335.62525-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109213335.62525-1-sj@kernel.org>
References: <20230109213335.62525-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON virtual address space monitoring operations set treats folios
having non-HPAGE_PMD_SIZE size as having PAGE_SIZE size.  Use the exact
size of the folio.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d6cb1fca1769..c7b192006fe6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -475,7 +475,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		goto out;
 	if (pte_young(*pte) || !folio_test_idle(folio) ||
 			mmu_notifier_test_young(walk->mm, addr)) {
-		*priv->folio_sz = PAGE_SIZE;
+		*priv->folio_sz = folio_size(folio);
 		priv->young = true;
 	}
 	folio_put(folio);
-- 
2.25.1

