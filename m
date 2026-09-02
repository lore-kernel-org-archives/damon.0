Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423EB2DC792;
	Wed,  2 Sep 2026 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788322012; cv=none; b=CA3ZDbKPyyyAfV1L58sFWyK0jagH1A4U4PoTjm5amh86tb9bF7OchJwHN/xhsrg8cxwUDQl2TeK9pwS3OsC9UfMm56PXdfy/y4bwYW2CFyg234F2hB8ZiGque+VmLBLwU9aAlaZFZaHW4eoeM3oEQjjMwgj88SbGd9l2W3HFNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788322012; c=relaxed/simple;
	bh=XTHG5wJj5NGKqwrE2Y7mCf0nsNqjmH3ry1IzuYt2aic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h04acVqLXyOF6eMdLYzkeFOQfCIVZj+kxiElUD0OE0fM4Kdd+Z0F/pU16fgfS7zOnEvNQ0H/7y17Nivjofim/VgGm09Xy81QYXam4MI/tJERy5Y/XWgXQfkv5LYPntCw5be7znPu/FnadBd48mZ9ulxfl3rN+kej1jjnm2AUGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ1AADmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ1AADmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27D81F000E9;
	Wed,  2 Sep 2026 04:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788322011;
	bh=rCDBGWhjOow6BVaXEWKL/bvhPOmCcwouuBw7qgvnDDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WZ1AADmmQSSKkceQoWmcRuNr2I+ritEKK0lzbaH2WL8WAtsQRXEA/HP/1V8mTLmA4
	 wY9glCWTT9p+9d5dc10HVqE3WbWRdPCriT4WIU46oMIVfv/hsHYGOuvvWH2Ehbzv2c
	 T4zotcImWkaRHriM4rztuOff+Szmh1twI+Xs3XaM4NC1Ja+1sU4PUEK3jPAdsMIU6+
	 vqlM/Sd/wF7jDMqQrJEDfPoVKoEB1IaamSynXftgSEe1Ax8mgFUblaS1Jckrt3Bvgw
	 KVq0umxJ5deFr4I8vpZCO83MgKUIYiqS7iVOqcvdZlC1UJag7Bb8sVJ2wUQISczts4
	 YnhepOW6Ry6yg==
From: SJ Park <sj@kernel.org>
To: Nathan Gao <zcgao@amazon.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v4] mm/damon/ops-common: use a page-aligned address in damon_ptep_mkold()
Date: Tue,  1 Sep 2026 21:06:42 -0700
Message-ID: <20260902040643.83720-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902031655.84721-1-zcgao@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Sep 2026 20:16:55 -0700 Nathan Gao <zcgao@amazon.com> wrote:

[...]
> Triggered by the full 7.1/7.2 kernel selftest suite on arm64 (EC2
> c/m6g.4xlarge). The kernel sometimes crashes at or shortly after the
> DAMON test.
> 
> What the overrun does depends on the page that happens to follow the
> page table, so there is no single signature. If that page is read-only,
> the write faults in the sampling path itself:
> 
>   Unable to handle kernel write to read-only memory at virtual address ffff0003c5d2d000
>     FSC = 0x0f: level 3 permission fault
>     CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>   CPU: 10 UID: 0 PID: 3487 Comm: kdamond.2
>   pc : contpte_test_and_clear_young_ptes+0x70/0xc0
>   lr : damon_ptep_mkold+0x1e8/0x1f8
>   Call trace:
>    contpte_test_and_clear_young_ptes+0x70/0xc0 (P)
>    damon_mkold_pmd_entry+0x150/0x170
>    walk_pmd_range+0x110/0x2b0
>    walk_pud_range+0x10c/0x208
>    walk_pgd_range+0x134/0x258
>    __walk_page_range+0x98/0x1b0
>    walk_page_range_vma_unsafe+0x90/0x148
>    walk_page_range_vma+0x28/0x40
>    damon_va_walk_page_range+0x114/0x2b8
>    damon_va_prepare_access_checks+0xec/0x1a8
>    kdamond_fn+0x534/0x770
>    kthread+0x128/0x138
>    ret_from_fork+0x10/0x20
> 
> Otherwise the page is writable, the PTE_AF clearing succeeds silently
> and the damage only surfaces later, in whatever happened to own the
> page, so the backtrace is unrelated to DAMON and differs between runs.
> 
> Pass a page-aligned address to the ptep_test_and_clear_young() call in
> damon_ptep_mkold(), which is the only place DAMON can reach
> contpte_test_and_clear_young_ptes() from. Nothing else sees the aligned
> address, and r->sampling_addr itself is left as is, so the sampling and
> region bookkeeping semantics are unchanged.

Thank you for finding this nasty bug and sharing this great fix, Nathan.  Also
appreicate again for your revisioning efforts that accepted my humble and picky
revisioning requests.

> 
> Fixes: 6f0e1142173a ("arm64: mm: support batch clearing of the young flag for large folios")
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand (Arm) <david@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Gao <zcgao@amazon.com>

Reviewed-by: SJ Park <sj@kernel.org>

> ---
> V3 -> V4:
> - Align only the address that is passed to ptep_test_and_clear_young(),
>   rather than @addr for the whole of damon_ptep_mkold(), so the
>   mmu_notifier_clear_young() call keeps seeing the sampled address (SJ)
> 
> V2 -> V3:
> - Move the alignment into damon_ptep_mkold(), instead of aligning in
>   damon_va_mkold() and damon_va_young().  The ptep_test_and_clear_young()
>   call in damon_ptep_mkold() is DAMON's only path to
>   contpte_test_and_clear_young_ptes(), so damon_ptep_mkold() is the
>   closest place in DAMON to the function that requires an aligned
>   address (SJ)
> 
> V1 -> V2:
> - Align inside damon_va_mkold() and damon_va_young() rather than aligning
>   r->sampling_addr itself, so that sub-page sampling addresses remain
>   possible for future non-PTE access check primitives (SJ)
> - Point Fixes: at 6f0e1142173a instead of 3f49584b262c, since the
>   unaligned address was harmless before that commit (SJ)
> - Describe how the issue was noticed and what it does to the kernel (SJ)
> 
> v3: https://lore.kernel.org/all/20260901201001.33271-1-zcgao@amazon.com/
> v2: https://lore.kernel.org/all/20260831221151.50561-1-zcgao@amazon.com/
> v1: https://lore.kernel.org/all/20260827193821.46115-1-zcgao@amazon.com/

FWIW, I insisted on this version to make clear the intention of this pin point
important fix.  I still believe this minimum and clear change is better as the
hotfix.

Meanwhile, to v3, Baolin mentioned it would be prefered to keep page alignment
from callers.  As I replied to the comment, that makes sense to me.  And it
seems some DAMON code has unnecessary unaligned address usages that could be
problem in future.  I will try to revisit such DAMON code and fix/improve as a
followup.  As a result, the resulting code might more look like v3 or v2.  If
you are interested, please feel free to send patches, too.

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~2 days?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
