Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553399;
	b=I0BbM2mIftYQHJkIpMDV3zyj0z6B0/CGmy3l7ErtniAPCr8B2bIZIBrWjMk8svt7DrNX
	 lKExDK6yIuJnVzgyV0jxCdeQI0+dqGCh8iqV5UtzkirMc19JFZ8Vlg6XhaCpKKNO00fiP
	 b3mC7ZLPgrqG3bSqnye7KwSoy0tMKBzoO4cYtt3kDhKEQ/9IfQpIkXzuEML5guyOAe/sR
	 T9iBKkzkjMDSF5o/AS2cl0i3bGJjGxYNdB2DumeIi2bJo2BKwKenzJMsJIb4BWcZ87jO1
	 i8BXv+ls2/npRH7p+y9ZO7t2aZ1I2U1gHuewDphR5q+uelHgIRkRcrzKL4UAzhE+KjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553399;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m1pJ4mfGksx99HkJq8FYvOx6HIQ0+ynloGyB5SLePdU=;
	b=XNStgeMWy7y03ziOLyYyslpdn6rAdslVRfjOhinu9l7itMriLub934sRM0j1CoaZ3cVB
	 M7RHJHZGwF6nmoIwk+WZvWJfkuOtXuKw0EmNdlGPoDveL3swY6ZZM7wEG7eldcTymo6Nr
	 1TIsEYTK43DrsQjITNtyUQ6LMsbzMMVIaNJWdLHRBCqNS5E49hVcrO3mBnLU5ovaaQQhF
	 T12IAJh2XiDxe9JJE+MTRYIAdrkd862SDNDe1vq+8czCVllBurvgKHnQBBOOjg9uoBrth
	 GDg9yKgcEQPxbhQ1w96v7XblXmRIEW3mvLtRTXc5ivhD+flEvBM6Le0rMNPc0aTLYGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJWLtLVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF0606A324;
	Sun,  1 Nov 2026 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJWLtLVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EEC1F00A18;
	Sun,  1 Nov 2026 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553398;
	bh=m1pJ4mfGksx99HkJq8FYvOx6HIQ0+ynloGyB5SLePdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nJWLtLVsdCYbZA4+cjGbxi6M0J9O8mfTXbAm5CRGXomgvXSAUq/D9DfnSl27G7prw
	 up6J/VDaP6Fckh+RxgIkQnd4QUG5pNOyreJC55WY4rg3q0a6rFRv6J2/sbObhjDeJ8
	 vX2lbQZO1yIqJhITenS9963uinxRDkwgFSx/Z31YesSlJWeDI/BYomtZcGCyvjrH6Z
	 bhGoX6vJ5wr7Axc8EqtVX7vicLNdQBn9eSLdHDHBGL6xmLoPXNQg5bdOMR/3GqioIk
	 22gqLcMVRIC0yo7yLXjysIa9BX6otAs+/ZJ3ojXUDUlT5o6eljxG3wmnHCBJl3N5FQ
	 LXqRRG04YekDQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/6] mm/damon/vaddr: advance migration attempt in folio level for filter out
Date: Sun,  1 Nov 2026 09:16:24 -0800
Message-ID: <20261101171630.81477-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101171630.81477-1-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
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
