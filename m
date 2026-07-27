Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC54314BE;
	Mon, 27 Jul 2026 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172015; cv=none; b=ewRFhWBQBdWzDy+abWAvUPJ5er47MrnaDTKNWZEGTJyWeTuD7nycZXS7HVZjPwPV9SSbwSa8U0Hp9Q0Y4KlOqYr4fCSaMxGf1eqVHDLvn4uvvoZt1GpDaexRFpY+3ILCcHijGuT8jNt0GOPKpZSI1Kmdotg79XMhVoSDKry61us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172015; c=relaxed/simple;
	bh=1Pt8RW8OZ0poXIcWABXdix/BD4J6rxZO9sO7YNLvlmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aa2WBhuda1BmLFoxYss66+XcGcRq0UVZz9Idl+/OPc2FW2joUU4U1BQg5dV0TXrGd1ztGUNbUPFwFQ+f/MZPbLlqkwvTK70yRfFwhxjocrBpNtm8tPpuUv4MALeOZ+yAW+VV0zydRxSoFGx8etlvu3P+fKAZDd+JzEA3djdcuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQKAQIYq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQKAQIYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8A21F00A3A;
	Mon, 27 Jul 2026 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172014;
	bh=g87WMwuws+VANruMejxcqQAAkoeK94qaInNTk/9P8MM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eQKAQIYqzxRloI9oceYUuvwMrQQnljrJzDOdNP+OkpXVimLYUyuINC0mNOcXsOvHZ
	 rxFpNjUphykN/lmBJkJCNFlQjqvS4t//ozsCjcbckpsuAK6RIkVsMkK8zNCdYk8dqx
	 PLc1do8DGPY0qAlOfWeJ9M4DSuLO8mcKrziexe7MLhKjBHdtr5Vdn5l8/C/3eaLTJF
	 CSXRl+wuurylRUSj/sfOIqa5LUs+P/rDVV8CDgQkOpJ4LOeEsG3dh6Rp6U9cD2ydau
	 Wa+TM4RzioY0BbmAsC4jxCdv+Ckbusf/mw7cF9bS/ZshI2jkndw1utJxF+HrcIjzd9
	 P4RaKxLtIEKXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/11] xen: use hw_pte_t for PTE range callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, damon@lists.linux.dev
In-Reply-To: <20260727164715.2866609-12-usama.anjum@arm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-12-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:06:53 +0000
Message-Id: <20260727170654.1B8A21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing VMA boundary checks in privcmd_ioctl_mmap_resource all=
ows arbitrary page table overwrites.
- [High] User-triggerable BUG_ON in alloc_empty_pages via multiple privcmd =
ioctls on the same VMA.
--

--- Patch [11]: [PATCH RFC 11/11] xen: use hw_pte_t for PTE range callbacks=
 ---
commit f1d3c6242b9edd333d296aa7d48a89b6d4261d91
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

xen: use hw_pte_t for PTE range callbacks

This commit updates generic PTE range and remapping helpers in Xen drivers=
=20
to use hw_pte_t * for PTE table storage pointers, replacing pte_t *. It=20
retains logical PTE access via existing helpers.

[ ... ]
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 725a49a0eee72..b4a487dcc9ecb 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -1658,7 +1658,7 @@ static int privcmd_mmap(struct file *file, struct v=
m_area_struct *vma)
>   * on a per pfn/pte basis. Mapping calls that fail with ENOENT
>   * can be then retried until success.
>   */
> -static int is_mapped_fn(pte_t *pte, unsigned long addr, void *data)
> +static int is_mapped_fn(hw_pte_t *pte, unsigned long addr, void *data)
>  {
>  	return pte_none(ptep_get(pte)) ? 0 : -EBUSY;
>  }

[Severity: High]
This is a pre-existing issue, but can a user trigger a kernel panic via
multiple ioctls on the same VMA?

Looking at drivers/xen/privcmd.c, privcmd_ioctl_mmap_resource()=20
unconditionally calls alloc_empty_pages() which contains a BUG_ON:

privcmd_ioctl_mmap_resource() {
    ...
		rc =3D alloc_empty_pages(vma, nr);
		if (rc < 0)
			goto out;
    ...
}

alloc_empty_pages() {
    ...
	BUG_ON(vma->vm_private_data !=3D NULL);
	vma->vm_private_data =3D pages;
    ...
}

If a user maps /dev/xen/privcmd and calls IOCTL_PRIVCMD_MMAP_RESOURCE twice
with the same mapped address, will the second call trigger this BUG_ON and
cause a local denial of service?

[Severity: Critical]
This isn't a bug introduced by this patch, but does
privcmd_ioctl_mmap_resource() miss VMA boundary checks that could allow
arbitrary page table overwrites?

Looking at privcmd_ioctl_mmap_resource() in drivers/xen/privcmd.c:

	vma =3D find_vma(mm, kdata.addr);
	if (!vma || vma->vm_ops !=3D &privcmd_vm_ops) {
		rc =3D -EINVAL;
		goto out;
	}

Since find_vma() only verifies that vma->vm_end > kdata.addr, does this
allow a caller to pass a size (num) that extends far beyond the end of the
VMA?=20

If so, could the subsequent calls to xen_remap_domain_mfn_array() or=20
xen_remap_vma_range() (which use apply_to_page_range()) overwrite PTEs of=20
adjacent VMAs with Xen foreign memory mappings?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727164715.2866=
609-1-usama.anjum@arm.com?part=3D11
