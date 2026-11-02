Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632086;
	b=fhBEXSYgEh4JUFeOZqY8ErNOlOu2aHNlilc90xLu/8Oh93HhykRKKloF3C7aCmjWcqML
	 akiKETD7AlQPrYQs4RjlDpiNWboPDz+VN8hVpyeZsc1dFFRuePR2mHXxqDhqhh+XbS9ze
	 V9qV3Wigq5gKA1p57tI1UiFXVaqd5S98+dSs5ro9dK6REpqIxU8MksRJPsI5/6TTKCFXA
	 J+Lk2oTsSRYEoHbrzZ7bGRdXjILRkra8W+4TMt0UYj+iHiEieFnY/gWTE5jRRi4nGqH8A
	 wp/xqEAnHyDzh7TMlnjA92PmFaJVThfphxAh5vCiTuSo4hozBzV2cYVNYIoBDeTzWCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=awuxY1FvzsoS1AnamJJIhHpAk0A733zuvxu39gKku+U=;
	b=Pe9ju3dcR1ni4w49N7vp2EgBd8QkJv/Abc6bA80Eq84aPKVrqNNoclhBXczjEm5LvvzV
	 cUQb/pcN37TAP8eAzAlJLJuo7wZTlnDBJDWLg6SvtEPomV8K6zqHGoFHfbI+8Gly/Tbi9
	 4nI7J2Z1o5PVdXcmaMsmd4iHg6awkBeiZKkxGj4FzaR1pDGbyYMYDQhQgpzWcce9yQ1lq
	 Sp44uuOHrcCcQUKBCu9RtwIdki5bzZvS5+QzftCDSTeoX8tu/Yhyh7aX6pGQWPMvcKpxr
	 mQIM+9cKioYAWuCpDkll7kYLXMSHB/XDCAcCZIy2owtFRmzqNYX0J9ErhowGkqaGP3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ag3K53I0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0560A0FE9;
	Mon,  2 Nov 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ag3K53I0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9AF1F00A1D;
	Mon,  2 Nov 2026 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632085;
	bh=awuxY1FvzsoS1AnamJJIhHpAk0A733zuvxu39gKku+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ag3K53I0Csd3ikdmc6KReqMvi/VyGvfqEHpgseRbEL1brw4iXQitfE5arNES3VbsB
	 50u+rHAwCPanrp577miARyXu7d0J14BF952So/jncCy8Mhbj8Slb4Zp3jio3RV86J9
	 KT6Da6cOMPynOo0CwHrzLzWzlkV5G0lkfD0oURrHQFrzocfDppWxqL4fzxf7mfqJ1k
	 tiYd1ZTjd5hJqzG4DbnOP0+oKwfr3APif41tdiQPYW/8hGFFijtfUpz9/oK37+DQJI
	 39a6lz78YeIT5IZMmNOwIheYMUhGOg1jPy5GXwM8FcxmHA0e6wjVve3INVygwZ7ckA
	 qQr3r9LchhW/g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	SJ Park <sj@kernel.org>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH 2/9] mm/damon/ops-common: align MMU notifier range when clearing PTE young bit
Date: Mon,  2 Nov 2026 07:07:49 -0800
Message-ID: <20261102150757.93058-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102150757.93058-1-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
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

From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>

DAMON selects a byte-granular sampling address.  damon_ptep_mkold()
clears the young bit of the PTE covering that address, but passes the
unaligned range [addr, addr + PAGE_SIZE) to MMU notifiers.

For an unaligned address, that range extends into the following page.
KVM ages every guest page intersecting the notifier range, so it can age
a secondary mapping for the following page although DAMON cleared only
the sampled page's primary PTE.

Align the address before both the primary PTE operation and the
MMU notifier call so that they cover the same page.

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261021-damon-align-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org
- Collect R-b: from SJ.
- Collect R-b: and T-b: from Aveline.
- Update subject prefix.
- Rebase to latest mm-new.

 mm/damon/ops-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 2f3bf86a221be..f88c6fd189fca 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -64,6 +64,8 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 	bool young = false;
 	unsigned long pfn;
 
+	addr = PAGE_ALIGN_DOWN(addr);
+
 	if (likely(pte_present(pteval)))
 		pfn = pte_pfn(pteval);
 	else
@@ -83,8 +85,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 		 * Arch implementation of ptep_test_and_clear_young() may
 		 * require aligned @addr
 		 */
-		young |= ptep_test_and_clear_young(vma, PAGE_ALIGN_DOWN(addr),
-				pte);
+		young |= ptep_test_and_clear_young(vma, addr, pte);
 	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
 	if (young)
 		folio_set_young(folio);
-- 
2.47.3
