Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B09393DF3
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415546; cv=none; b=RvnJY16memCYv3/eysQAQUKKMOMMwR/IYVcKc/DnG98Sn62KfwNQPLPcDEedM+8Lx9eiYz0QrEFGBO1a2wvz2BOdMe+ltFSPLzNfNsCxSY2Ef5LztPhmGdyTu7h8LQbOe12L9jljCAHBm7SudlG+kQReejffi57cUkq3k+sWLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415546; c=relaxed/simple;
	bh=Lfy7JRcBvmt+FT6Qbku1AgGK6Oei/+V9hDTEMbjCHwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FUpOsEU8+ixyZ9drEugKPla+NHT2FexYnG0jgKWNgiH9QLidLiHzzGLJuBk1z+RT5ljQeV7becAAFJdlz/DhFKMhBdaL89yqjhvxZuAEO7351B5/1bSaVwaFhnlZ7r29/nvAm4AlOO4N3FRhOwilPCB1Cq6xnMCm2zZfzpej2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv/0XgAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv/0XgAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ACA1F000E9;
	Tue,  7 Jul 2026 09:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783415545;
	bh=D65W1ejiFUa/zfUrSzJCtKuU7FXqneIJ3e/QEz9h7bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cv/0XgAe5g9Ai52oGKEOuC723G/kOh1yiQHbe27Asj/x0/VVE2L30WIUOisQ13UU3
	 yTh+SrxGcKYycq/XwAQzOqvsj6mhOfhRwdovMj/W7oqMw0OcdVYdmiwQakU/7zhnPl
	 h7hJfXAwhHJ6fg66/Y2Al/j2qSwQrFZlMrbNXdigCSrGVaop8V12lAt3kj1EtxAJXB
	 P1LqBJ2ldamscGnQvPxVvwsGNUIeTGc73it2AukV/9wUWaGs17vTKWS1Exs0vRehuC
	 OPoYSFjcZt860C2eFYpMTAKCnhsT0/OZNi/gDM9bV4qpf8u8PPP9YxS+BvYAS+ROT0
	 12uDHOZiXqklA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/13] mm: prepare anon_node replacement for
 ANON_VMA_FRACTAL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-10-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-10-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:12:24 +0000
Message-Id: <20260707091224.E5ACA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Lockless traversal of the shared `fractal_list` in `anon_node_ve=
rify()` leads to data races and potential use-after-free.
- [Low] Using `#if CONFIG_DEBUG_VM_RB` instead of `#ifdef` causes `-Wundef`=
 compilation warnings when the config is disabled.
--

--- Patch [9]: [RFC PATCH v2 09/13] mm: prepare anon_node replacement for A=
NON_VMA_FRACTAL ---
commit 7ac3c97b907c3a50c0e59be4fc5c3a22d3833da9
Author: tao <tao.wangtao@honor.com>
   =20
mm: prepare anon_node replacement for ANON_VMA_FRACTAL

This commit introduces macros in vma.c to isolate code differences and
split the large code changes into smaller patches for the anon_node
replacement in ANON_VMA_FRACTAL.

> diff --git a/mm/vma.c b/mm/vma.c
> index d2996369e30d6..02178112daa0b 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c

[ ... ]

> @@ -675,12 +675,19 @@ void validate_mm(struct mm_struct *mm)
>  			vma_iter_dump_tree(&vmi);
>  		}
> =20
> -#ifdef CONFIG_DEBUG_VM_RB
> -		if (anon_vma) {
> +#if CONFIG_DEBUG_VM_RB

[Severity: Low]
Does this introduce a -Wundef compiler warning when the config is disabled?

Since CONFIG_DEBUG_VM_RB is a boolean option, it is left undefined rather
than set to 0 when disabled. Using #if instead of #ifdef might cause
build failures when compiling with -Werror.

> +		if (vma->anon_vma) {
> +#ifdef CONFIG_ANON_VMA_FRACTAL
> +			anon_node_verify((void *)vma->anon_vma);

[Severity: Medium]
Can this cause a data race or use-after-free by locklessly iterating over
the fractal_list?

In the legacy path below, anon_vma_lock_read() is explicitly acquired
before traversing the list. However, anon_node_verify() iterates over
the shared anon_node tree using anon_node_next_rbc_child() without
taking anon_node_lock_rmap().

Since the anon_node structure is shared across multiple processes after
fork(), could another process concurrently modify the fractal_list while
validate_mm() is traversing it?

> +#else
> +			struct anon_vma *anon_vma =3D vma->anon_vma;
> +			struct anon_vma_chain *avc;
> +
>  			anon_vma_lock_read(anon_vma);
>  			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
>  				anon_vma_interval_tree_verify(avc);
>  			anon_vma_unlock_read(anon_vma);
> +#endif
>  		}
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D9
