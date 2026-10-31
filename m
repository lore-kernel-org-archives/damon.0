Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478383;
	b=crH/H/hu1dG3ZYpI1XyXJkPmdmkP8vqWgtrJVUufV8ifLgzZvSFQtwGVdyWrDh5rPgMm
	 af8hn1ZGnlPVt9RPt7jcS5OwEoE26R+UhcWrye+MOl2eHXyvEzyifQCgPyF88n1YunxF7
	 DwH5If5bDxiy+G59eIFEYZe5xDwNTqcA6z5QPuONc41ZD4GWVVyd2UrvJALNukibt8oXS
	 vJNhEU++UK/w89DsnzJNajszizz13GU0O6KgIibjxjczaM0C4PFtpIDq4H3DK0Oo8Fq6u
	 hhyjAvT76PPN0TSRMQujZDirJ3KPtPAd8f5nyIid9ngDAiwuaSz4g57TdL3mzHMMOBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m1pJ4mfGksx99HkJq8FYvOx6HIQ0+ynloGyB5SLePdU=;
	b=QQJ9nEWf2CuYLxB5E4PgOuEsTYQI8utV2bNF8KLw1m7x00YLv34WxwTAWOoTIopXCEuF
	 IRGbIrmKJNeQztmm3yc/QpbqrocylP+Ud7mplVnCrlLFaJi+RxhKcgGrVvPVYtxbrmaOv
	 nLdlZeoIT++fug+95NsS8D996JDNzQidFWPDQc9RUOIWR6SgsY0fgzu1M9kJNTj4O4RnX
	 e70BzSaCfMWeD+mK/1l72Rht5rDFkyYJJUnAxUa6Y+7hpM6PLBugoReekOxll1hbYfwPa
	 4p1DK/lvKP+53ddzKdekPnygjXTXlHpYKhYBOeKspwnHW98srF9LjRmdmb7XIe/E1iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftCwKSyr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8A606A322;
	Sat, 31 Oct 2026 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftCwKSyr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4561F00919;
	Sat, 31 Oct 2026 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478382;
	bh=m1pJ4mfGksx99HkJq8FYvOx6HIQ0+ynloGyB5SLePdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ftCwKSyrq/qTTQ3igmVJUHvDKcaYxQvEaPr7Gre89WudutxclXGGdSXc/1Cy2PCyy
	 GVA55+jbA6TSShSdO2sbA/dKMoFUw+I65d9NLTiOIWJX/MgBUmeMW4kep3b1IF9Yb5
	 cgnTdQU45rJaskbG2y6UZvXeuWKcMNtifHCUVpVKgINTMWg8iKbAE9gi92prWrwnXZ
	 x/7NRDBAGyO83guQPk+J+goYXiz4Yl2RQPScs47ZYqmvvP1edrjYVWWLKwvhjBqj6Y
	 c/FnFEiSStslR+N/+BuYdcx3CNKmMMi/O8alqGfj59niN+5ebYdxsQJ9xQHMb9m9VP
	 nD/g40WW2zq9w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/6] mm/damon/vaddr: advance migration attempt in folio level for filter out
Date: Sat, 31 Oct 2026 13:26:09 -0700
Message-ID: <20261031202614.96036-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031202614.96036-1-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
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
index b549496ea8e2c..c271b6d63c027 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -881,12 +881,12 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		folio = vm_normal_folio(walk->vma, addr, ptent);
 		if (!folio)
 			continue;
+		page_idx = folio_page_idx(folio, pte_page(ptent));
+		nr = folio_nr_pages(folio) - page_idx;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 				migration_lists);
-		page_idx = folio_page_idx(folio, pte_page(ptent));
-		nr = folio_nr_pages(folio) - page_idx;
 	}
 	pte_unmap_unlock(start_pte, ptl);
 	return 0;
-- 
2.47.3
