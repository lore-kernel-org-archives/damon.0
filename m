Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CF31F9A4
	for <damon@lists.linux.dev>; Wed, 27 May 2026 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886180; cv=none; b=V9+JGfhTQa3lD5Ez90qq71Minw82cO0hqi2cKbGav5sIx/gOOJFFSD9wkOZQJdKBQsCB4+ihNwbDbKzr8gxqZHwzrsHcOcbdrUnr7g7DpedtN0ndIZmC8QTH7XP7TSJXlCY7Ki6fBgH52o/wjaQo7dNdTqV6tyeGJKKoAwNysAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886180; c=relaxed/simple;
	bh=PxuajF8MO/jQN6tNXutEyMlNZ/tUz3Zn37DziNWbLSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IZROB65yu+zUCI9j5XqNGylmAji3RUci3em11gOxv4iJKujPzf0x2p4F44IVWqH6isaJnS7zCeSO8JZD1K/AndIdI7OueBph6/Jyl0jvgSF0wRTt5CoFpIoAA0EYroDUjb/vz44bn1a10/ppON30Zbe8+3zL7Kt8A+g8lqqrnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4CGrKGi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4CGrKGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0A71F000E9;
	Wed, 27 May 2026 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779886178;
	bh=5SOA/bfRuTclr5MPCNxxA9RHfrhASfifJuuw6lNj9uA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O4CGrKGiT3yY7fHR7OaLz0rry6g6xHlfekxn0qluGa4Y/IO4U7Z7zgeCq952QItay
	 mAzvbuSxj3nbKj5ZXLxSJIirf5fsjNx480SplITBHef45YsOX4w5LDEktNo0IucSdU
	 gZ4xyHR5DmUwJA2Ft6C+HkqmHJ5Ty3RJ+vTJ15wGDEUYF6ltPLwiNSm4pdIcoZ5qKb
	 JKw2Fgudxpr4emzKOLJntZ1izNOY0s94YEiJzf7TbDg5ejsImQKAIR+1NgPbuTThUS
	 pJdjlDrnrTMOSTo6GOAtAr7T+OJh6qQ/+jIrwIkLkjS5YpLJMjIK0SggNnLyopM2UR
	 u/C9EUsEe2zTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] mm: support merging of ANON_VMA_LAZY VMAs
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-15-tao.wangtao@honor.com>
References: <20260527110147.17815-15-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:49:38 +0000
Message-Id: <20260527124938.BC0A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The `SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT` macro cause=
s a Use-After-Free of the surviving VMA, leaks the original target VMA, and=
 breaks subsequent logic by mutating local variables.
--

commit c3a08dff39965e2def5b757c0b817a9f4a00d8f1
Author: tao <tao.wangtao@honor.com>

mm: support merging of ANON_VMA_LAZY VMAs

Allow ANON_VMA_LAZY VMAs to merge if they share the same root or if one
side has no root. For ANON_VMA_LAZY merges, do not delete the lazy root
VMA.

> diff --git a/mm/vma.c b/mm/vma.c
> index 0a31ef82a90cb..ae1047dcfbc2e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c

[ ... ]

> @@ -776,6 +777,17 @@ static bool can_merge_remove_vma(struct vm_area_stru=
ct *vma)
>  	return !vma->vm_ops || !vma->vm_ops->close;
>  }
> =20
> +/*
> + * The ANON_VMA_LAZY root VMA may still be referenced by folio->mapping.
> + * Keeping the root avoids allocating an extra VMA.
> + */
> +#define SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT(vmg, delete_vma) do=
 { \
> +	if (anon_vma_lazy_enabled()) { \
> +		if (delete_vma && vma_is_anon_vma_lazy_root(delete_vma)) \
> +			swap(vmg->target, delete_vma); \
> +	} \
> +} while (0)
> +

[ ... ]

> @@ -933,12 +945,15 @@ static __must_check struct vm_area_struct *vma_merg=
e_existing_range(
>  		vmg->end =3D next->vm_end;
>  		vmg->pgoff =3D prev->vm_pgoff;
> =20
> +		SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT(vmg, middle);
> +		SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT(vmg, next);

[Severity: Critical]
Does swapping vmg->target and the local variable middle result in a
use-after-free of the target VMA?

By swapping these variables, vmg->target now points to the VMA that was
originally middle, while the local middle variable points to the original
target (e.g., prev). However, this macro does not update the internal state
tracking fields vmg->middle or vmg->next.

When commit_merge() is called, init_multi_vma_prep() sets up the removal li=
st
using the unmodified vmg->middle and vmg->next. As a result, the newly
selected target VMA is simultaneously stored into the maple tree and added =
to
the removal list, leading to a use-after-free when vma_complete() frees the
removal list.

Simultaneously, the original target VMA (e.g., prev) is overwritten in the
maple tree but never added to the removal list, leaking the VMA.

Additionally, because the local variables are swapped, subsequent logic such
as dup_anon_vma() will read from the wrong VMAs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D14
