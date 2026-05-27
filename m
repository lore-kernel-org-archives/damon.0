Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC83DD535
	for <damon@lists.linux.dev>; Wed, 27 May 2026 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884506; cv=none; b=e1/WCYUxs5QO31Kd0dxAl93ZShFhgxLQXijnXlugyd5QdhCHf5jyS2bpUXNpmzGhMb7Y/SksUQP8fk8qoqE9o+Ycbsz48TnudAhNWHh9JH/q2tPWF+nQLWhB9a0nz1rpOZ+1xQpUetx3r5pL4Fnb+N30eQjFio/GagKiLkuYDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884506; c=relaxed/simple;
	bh=hcinehTAzt1qdWYJZ4sJQJQa8VYl7GXSORojDkDfqJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KAuF2mNvou/Qg2CppQPIMk/ayt6Fo0wxSjKw0mcRf3WMgg66PMbpHrJcjXAGbQsHSDgc0Ak/iJcMen6CffzkVgI9vHG/QLKiCst3OCo9Eh25tLKa7i41RzkFVCrG99S3HiSKPJ12AD0ZILFuGEpBaTCRjQkpBcvnJPZRoak8uME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+BUXB0X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+BUXB0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28F51F00A3A;
	Wed, 27 May 2026 12:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779884504;
	bh=HiRpUoUD2VbzDbvm09cETW0oFqMQN/x4oPWEm0PFOwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+BUXB0X7qv3RfY5ITeZ04r9sCBXFvLiSmD9e8v8j5xQPyh3RQW3wPKo5ytm3Ouux
	 Xo0Ri73STNQPJizAXNXYXvD8e8RJqy72jIj5VEVXbCN1MAHRO7h9SHDWPQ8v9RKrua
	 kOfQfsb1c7bq/12mW4SBaYUR7dADzBL7LFXoSV/hWHgSMv+Q17kfBn58OEOKGILsK9
	 z7i7BHwPAbxCH2OlrXHGPU9wOm8LcjvdfMoYmOalOQ7cy/l30EFt10mSbi1qthowGB
	 ywEu/bvwl514G7eyheCS3NKSsKpwPkp82yDZUQfNI+feMdoZVHo6eYzPKT8xwcCr9O
	 e22sDEfPe+66w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] mm: handle ANON_VMA_LAZY in huge page operations
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-12-tao.wangtao@honor.com>
References: <20260527110147.17815-12-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:21:44 +0000
Message-Id: <20260527122144.A28F51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Concurrent page faults can cause a time-of-check to time-of-use (T=
OCTOU) race when upgrading a lazy anon_vma, leaking memory and corrupting r=
everse mapping (rmap) tracking.
- [High] The `maybe_huge` heuristic fails to account for PTE-mapped large f=
olios (mTHP), allowing them to be mapped with a lazy anon_vma and leaving s=
ubsequent split operations unprotected.
- [High] Calling `vma_upgrade_anon_vma_lazy()` from `collapse_huge_page()` =
on an unfaulted VMA triggers a `VM_BUG_ON_VMA` assertion, causing a local d=
enial-of-service (DoS).
--

commit 8822fc57fbd81ecdc76a5f519160ce64bb983477
Author: tao <tao.wangtao@honor.com>

mm: handle ANON_VMA_LAZY in huge page operations

This commit updates the huge page allocation and khugepaged collapse
paths to upgrade lazy anon_vmas to regular anon_vmas. This aims to
ensure that split operations on huge pages are properly protected by
an established anon_vma.

> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 747748eace916..a33cda026be7b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
[ ... ]
> @@ -1164,6 +1164,11 @@ static enum scan_result collapse_huge_page(struct =
mm_struct *mm, unsigned long a
>  	if (result !=3D SCAN_SUCCEED)
>  		goto out_up_write;
> =20
> +	/* Upgrade anon_vma_lazy to protect the anon_vma. */
> +	if (vma_upgrade_anon_vma_lazy(vma)) {

[Severity: High]
Could this trigger a VM_BUG_ON_VMA assertion if the VMA hasn't been faulted
yet?

If collapse_huge_page() processes a completely unfaulted VMA, vma->anon_vma
would be NULL. However, vma_upgrade_anon_vma_lazy() unconditionally calls
VM_BUG_ON_VMA(!anon_tree, vma) at the beginning of the function, which
would cause a local denial-of-service.

> +		result =3D SCAN_FAIL;
> +		goto out_up_write;
> +	}
>  	anon_vma_tree_lock_write(vma->anon_vma);

> diff --git a/mm/memory.c b/mm/memory.c
> index 8fd3877f69fb3..26d116b3393cd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
[ ... ]
> @@ -3819,19 +3819,28 @@ vm_fault_t __vmf_anon_prepare(struct vm_fault *vm=
f)
>  {
>  	struct vm_area_struct *vma =3D vmf->vma;
>  	vm_fault_t ret =3D 0;
> +	bool maybe_huge =3D pmd_none(*vmf->pmd);

[Severity: High]
Does this heuristic properly account for PTE-mapped large folios (mTHP)?

If a large folio is being mapped into an already populated PMD directory
using PTEs, pmd_none() will return false. This would allow mTHP allocations
to continue using a lazy anon_vma, leaving any subsequent split operations
on those large folios unprotected.

> -	if (likely(vma->anon_vma))
> -		return 0;
[ ... ]

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 59848e1aaf531..cb104310cdc9b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
[ ... ]
> -static int vma_upgrade_anon_vma_lazy(struct vm_area_struct *vma)
> +/**
> + * vma_upgrade_anon_vma_lazy - upgrade a VMA's lazy anon_vma to a regula=
r one
> + * @vma: the VMA whose anon_vma_lazy is being upgraded
> + */
> +int vma_upgrade_anon_vma_lazy(struct vm_area_struct *vma)
>  {
> -	anon_vma_tree_t vma_tree =3D vma->anon_vma;
> +	anon_vma_tree_t anon_tree =3D READ_ONCE(vma->anon_vma);
>  	struct anon_vma *parent_anon_vma =3D NULL;
> =20
> -	if (anon_vma_tree_is_parent(vma_tree))
> -		parent_anon_vma =3D anon_vma_tree_anon_vma(vma_tree);
> +	VM_BUG_ON_VMA(!anon_tree, vma);
> +	if (!anon_vma_tree_type(anon_tree))
> +		return 0;

[Severity: High]
Can concurrent page faults cause a time-of-check to time-of-use race here?

Since anon_tree is evaluated outside of the page table lock or anon_vma
lock, multiple threads faulting simultaneously might both observe a lazy
tree type. They could then concurrently proceed to upgrade the anon_vma,
which might lead to memory leaks and reverse mapping tracking corruption.

> +	if (anon_vma_tree_is_parent(anon_tree))
> +		parent_anon_vma =3D anon_vma_tree_anon_vma(anon_tree);
>  	return vma_prepare_anon_vma(vma, true, parent_anon_vma);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D11
