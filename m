Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E3831A570
	for <damon@lists.linux.dev>; Tue, 12 May 2026 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563589; cv=none; b=W2Ve+yRrS69vAjAnxWNEkDNrRkUGNmy2KRQK63QQKe7B8f57m2So668XrsMDBOO+rYHuzvBWOqKjjrIiXCZju/RVHtnqsSthIM3RYILGuzjXmTAdqSkMpTru5zkWrAM76NbYRnSc5FN1gp6iXtPxp47BHlQQPRJIaEYkMthGNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563589; c=relaxed/simple;
	bh=pcbupYAETdnFjWjwjxUjICtPffkhWfaFK1CPb8oSsoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PnbtfIKDQ5K00hRGiqkvs2QGFrUFsFfRR+U+KVJynaRuXldRXDRnEfJA8/HXBbb94GPUQCF/dm6u82xpkp7/vDv0u6vxwUy2oS54fP2ncVueUtCuQtoIi8jEN6WpsqciG4qcc5t9zzNhDsg9hKe7t2hFK7M100DBttq8DTnWGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAZ8gW/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAZ8gW/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83798C2BCC7;
	Tue, 12 May 2026 05:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778563588;
	bh=pcbupYAETdnFjWjwjxUjICtPffkhWfaFK1CPb8oSsoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GAZ8gW/ZMyrDzLhBWAqy8rv9sr/KP5gH/L96kjnY1jmT/e0KCvPEKP2E8wTJEhWw0
	 4BR1ch1UGIm+3QApswDs3GJAXMrsuH+YjwagQj2QXWDP8AgNFIyNBMEZqbVVufPH97
	 A5iUxCN2Qg8jib8oYagO3DOz0yeB/VW+KF8CBv37BEnj7AHRdH8lzi2ljCeC0PGBfZ
	 uJJl1dHrs7isajKt0p4DTPjVSJxeiYwa7sP6TzLBZZfTCUESGG8+esvwMus/P+FElX
	 4qhf4JqY3lt129rBAiQie/V9XTBcfdsErKCtq/NlO/LgsEMxR4dhVESY+5gQXckD7V
	 1nYnicrpIHNKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: attempt per-vma lock during page table
 walk
Reply-To: sashiko@lists.linux.dev
To: "Kefeng Wang" <wangkefeng.wang@huawei.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260511132546.1973270-1-wangkefeng.wang@huawei.com>
References: <20260511132546.1973270-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 05:26:28 +0000
Message-Id: <20260512052628.83798C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inconsistent VMA Filtering (VM_PFNMAP) in damon_va_walk_page_ran=
ge()
--

commit b5bde92b4c2b28a90660c48f50de91cd04010328
Author: Kefeng Wang <wangkefeng.wang@huawei.com>

mm/damon/vaddr: attempt per-vma lock during page table walk

This commit introduces damon_va_walk_page_range() to optimize DAMON's
virtual address page table walks. It attempts to acquire a per-VMA lock
and proceeds with walk_page_range_vma() if the range is contained within
a single VMA, falling back to the mmap_read_lock and walk_page_range()
otherwise.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 1b0ebe3b6951e..eed2ae132a589 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -237,6 +237,32 @@ static void damon_va_update(struct damon_ctx *ctx)
>  	}
>  }
> =20
> +static void damon_va_walk_page_range(struct mm_struct *mm, unsigned long=
 start,
> +		unsigned long end, struct mm_walk_ops *ops, void *private)
> +{
> +	struct vm_area_struct *vma;
> +
> +	vma =3D lock_vma_under_rcu(mm, start);
> +	if (!vma)
> +		goto lock_mmap;
> +
> +	if (end > vma->vm_end) {
> +		vma_end_read(vma);
> +		goto lock_mmap;
> +	}
> +
> +	ops->walk_lock =3D PGWALK_VMA_RDLOCK_VERIFY;
> +	walk_page_range_vma(vma, start, end, ops, private);
> +	vma_end_read(vma);
> +	return;
> +
> +lock_mmap:
> +	mmap_read_lock(mm);
> +	ops->walk_lock =3D PGWALK_RDLOCK;
> +	walk_page_range(mm, start, end, ops, private);
> +	mmap_read_unlock(mm);
> +}

Does this code handle VMAs with the VM_PFNMAP flag inconsistently?

In the fallback path using walk_page_range(), the page walker calls
walk_page_test(), which skips VM_PFNMAP VMAs by default since the DAMON
operations structures do not provide a test_walk callback.

However, the fast path uses walk_page_range_vma(), which bypasses
walk_page_test() entirely and directly walks the page range.=20

This means that if a queried address range is fully contained within a sing=
le
VM_PFNMAP VMA, the page tables will be walked via the fast path. But if the
same VMA is part of a larger range, the mmap lock fallback is triggered and
the VMA is properly skipped.

Can this lead to DAMON improperly modifying PTEs on raw PFN device mappings,
such as clearing the young bit in damon_mkold_pmd_entry(), when taking the
fast path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511132546.1973=
270-1-wangkefeng.wang@huawei.com?part=3D1
