Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6031A057
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416325; cv=none; b=C14mIQB6BPyejxtps6n1la1XnJcbWPVPlTATB9n+Wg8sQeId0snWUY5eYmblak8QREgVsbFNRE0KUfXo/MHgRb+XltH7wnP/1fvYcqY3EB/uRdjUhrMJXW4LsBZNRP/CdVlLN/qwwpSztP7OHp1Wr1rFVNIyl7AE+rp1UIdKP58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416325; c=relaxed/simple;
	bh=5m1PZn+OM4xkH81IZgI9QyKqCeFN7rpupdpJqVYg9bk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YtIMOQTzmdXINHJ2UA6MgNuW7+H0XbEIYDMUzFIU7rr5nSGJymGtWo9FaJzpOtSh/TLBDlxmne3Efk/62GtmdnVPvMxb5idJHAlluHw4qU9sYPIAAjoidinVFjjk9/8JjWQggNb7Xf5VGoMjeZyIuKXLAimQK3I89m6hbUNqZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv+9T4V/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv+9T4V/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419FD1F000E9;
	Tue,  7 Jul 2026 09:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416323;
	bh=jvvm5bOvj9OKnin57dmyB66FG+chfE4LdJ/XeInQt88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bv+9T4V/QlDZD9Q7w5Y5qJFmUdeQ8hV67myvRVMfIIobMc6gowsdQcRbbH04umEX1
	 5zomNNt+p/c8rCB4KlSPUUY9Vox/Wain0XL244heZbTgma9pgCzylzielmb4GXcmeJ
	 HcElZ4wH2UoiEaaSJiNUAiJVYJ2Xhr5MQ/2EyoJ4irEo2fcPKs5gLWM1IJJokSiiAm
	 IAOQTmVU/nE8guQCImrEBonP7gaEQ/hd+icxDqIgrRoH/CI3iRknqlgQrW0Mh1M6XF
	 njWuLisk+VenU+MjXVXCaWuYBEKbr71IMokSQXPJJOLip59EJDTxY01SQYD3MEx2TE
	 YoAu7aqT3j9Rw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/13] mm: replace anon_vma with anon_node for
 ANON_VMA_FRACTAL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-11-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-11-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:25:22 +0000
Message-Id: <20260707092523.419FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Desynchronization of `prev` and `tmp_prev` pointers in `dup_mm=
ap()` leads to `anon_node` tree corruption when VMAs are skipped, causing p=
age use-after-free and structural corruption.
- [Critical] The `ANON_RMAP_FOREACH_VMA` macro enters an infinite loop when=
 callers use a `continue` statement, leading to a hard lockup.
- [High] Stubbing `anon_vma_lock_write` to a no-op breaks locking in `mrema=
p` and `khugepaged`, leading to concurrent page table corruption.
--

--- Patch [10]: [RFC PATCH v2 10/13] mm: replace anon_vma with anon_node fo=
r ANON_VMA_FRACTAL ---
commit 1deef9c4b5a4ec2adb2fbed6a3ce6762667d351c
Author: tao <tao.wangtao@honor.com>
Subject: mm: replace anon_vma with anon_node for ANON_VMA_FRACTAL

This commit replaces anon_vma with anon_node for anonymous reverse mapping
walks, aiming to save memory by removing anon_vma_chain from VMA. It
introduces a new ANON_RMAP_FOREACH_VMA macro and stubs out older locking
APIs.

> diff --git a/mm/internal.h b/mm/internal.h
> index 1c29f98b1b252..7c34ff1abf85c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
[ ... ]
> +/* Huge pages are protected by folio_lock(), these APIs no longer needed=
. */
> +static inline void anon_vma_lock_write(struct anon_vma *anon_vma) {}
> +static inline int anon_vma_trylock_write(struct anon_vma *anon_vma) { re=
turn 1; }
> +static inline void anon_vma_unlock_write(struct anon_vma *anon_vma) {}

[Severity: High]
Does stubbing out anon_vma_lock_write() leave page table modifications
unprotected against concurrent reverse mapping accesses?

Operations like take_rmap_locks() in mm/mremap.c and collapse_huge_page()
in mm/khugepaged.c still rely on this lock to serialize page table changes.
Without it, there could be page table corruption when try_to_unmap()
locklessly scans them.

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2311ae7c2ff45..c283e0de819af 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
[ ... ]
>  	mt_clear_in_rcu(vmi.mas.tree);
> -	for_each_vma(vmi, mpnt) {
> +	for ( ; (mpnt =3D vma_next(&vmi)) !=3D NULL; prev =3D mpnt, tmp_prev =
=3D tmp) {
>  		struct file *file;

[Severity: Critical]
Does this loop advancement logic cause prev and tmp_prev to become
desynchronized if a VMA is skipped?

If mpnt->vm_flags & VM_DONTCOPY is true, the loop in dup_mmap() executes a
continue statement. The step expression will update prev to mpnt (the skipp=
ed
VMA), but tmp_prev will remain pointing to the clone of an unrelated older
VMA.

[ ... ]
>  			tmp->anon_vma =3D NULL;
> -		} else if (anon_vma_fork(tmp, mpnt))
> +		} else if (anon_vma_fork_with_prev(tmp, mpnt, tmp_prev, prev))
>  			goto fail_nomem_anon_vma_fork;

[Severity: Critical]
If prev and tmp_prev are desynchronized due to a prior skipped VMA, will
this cause anon_vma_fork_with_prev() to incorrectly reuse an anon_node from
an unrelated mapping?

This could place child VMAs in the wrong reverse mapping tree, leading to
use-after-free regressions when the kernel attempts to unmap or swap out
pages.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index aa6632790d9af..d3677515fae92 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
[ ... ]
> @@ -3455,9 +3460,7 @@ static void rmap_walk_anon(struct folio *folio,
> =20
>  	pgoff_start =3D folio_pgoff(folio);
>  	pgoff_end =3D pgoff_start + folio_nr_pages(folio) - 1;
> -	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
> -			pgoff_start, pgoff_end) {
> -		struct vm_area_struct *vma =3D avc->vma;
> +	ANON_RMAP_FOREACH_VMA(anon_vma, 0, pgoff_start, pgoff_end, ({
>  		unsigned long address =3D vma_address(vma, pgoff_start,
>  				folio_nr_pages(folio));
> =20

[Severity: Critical]
Can the use of continue inside this macro block bypass the iterator
advancement logic of ANON_RMAP_FOREACH_VMA?

When CONFIG_ANON_VMA_FRACTAL is enabled, ANON_RMAP_FOREACH_VMA is defined
as a while loop that advances the iterator at the end of the block. If a
caller like rmap_walk_anon() jumps to the next iteration using continue,
it will skip the advancement and result in an infinite loop and softlockup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D10
