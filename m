Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74DA37DE85
	for <damon@lists.linux.dev>; Wed, 13 May 2026 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712724; cv=none; b=Tdcu8iucGhg0TNb3GkC9mH1n2jyqkPuiytRVzEJpYwGUxVLba8F03gUTnxxXpktnyTKGvsu6XYWpg3KngfEHNem/jPLfSU+sH+LEF6V4uOu5t/hN1hWRsdWgCzBW4IYMpOsP1vdWymx5xLHqonhESi7aW2mT9LXj5jspXvp6/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712724; c=relaxed/simple;
	bh=Cb8w9FqD2O8qoybDhH8nwY6tg9kyhQWpLicjctJyq04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qcuy8/xu11ziSQjfU8Bz+xNhY82cP4/GVubaa4rdLPDOT+EfxYJqnx+qisdceEeS1jtXKttJ2/KVHLFh8/rGcPYJpxBJcs2KSmreacF0dTWiwD4lE4sGHEBCHct7T9R/PJ5tacSDn7tzov3D1VBWpSEXc09dBcPd3RJw7ffxIxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mawl/kZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mawl/kZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4157FC19425;
	Wed, 13 May 2026 22:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778712724;
	bh=Cb8w9FqD2O8qoybDhH8nwY6tg9kyhQWpLicjctJyq04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Mawl/kZBe16o40V908WEeQLB9qgy2tCrlBIDdLi44mQU6fykxrWKPrRl3IQ+hfsus
	 8cBP8USvDCAKTYyr2TGyfmROylg/bGqdyESB2vRVGKKqoKLebyStrJXLUGHRiXkV4L
	 /4PkEmP3YFPHvBoL/6iaL+XnOxjr40f0aV7EPAHICXhZriRxuWPaHewpM0sTdtka/Z
	 sc/GpXf9XW5MIayKYaVvOIr2ZPy7vWJ0/SftYA4xpZ7jzNGTVIZqj6GjQB0vlMez47
	 pPVykJj9IbTk/s4h9CehBR9JvStRRQUCaxhiKtTElJ5OnZeGZDaXAwxsqPfcMyY6aQ
	 Fr8Ym9QcCgWxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/vaddr: attempt per-vma lock during page
 table walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kefeng Wang" <wangkefeng.wang@huawei.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260512151523.2092638-1-wangkefeng.wang@huawei.com>
References: <20260512151523.2092638-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:52:03 +0000
Message-Id: <20260513225204.4157FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `damos_va_migrate_pmd_entry` and `damos_va_stat_pmd_entry` incorre=
ctly advance iteration by the full folio size, skipping unrelated PTEs for =
mTHP.
--

commit 25c04a646a951de8c86c5c718af6cfc459b7b5e0
Author: Kefeng Wang <wangkefeng.wang@huawei.com>

mm/damon/vaddr: attempt per-vma lock during page table walk

Currently, DAMON virtual address operations use mmap_read_lock
during page table walks, which can cause unnecessary contention
under high concurrency.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 1b0ebe3b6951e..d271476035641 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]
> @@ -750,7 +773,6 @@ static unsigned long damos_va_migrate(struct damon_ta=
rget *target,
>  	struct mm_walk_ops walk_ops =3D {
>  		.pmd_entry =3D damos_va_migrate_pmd_entry,
>  		.pte_entry =3D NULL,
> -		.walk_lock =3D PGWALK_RDLOCK,
>  	};

This isn't a regression from this patch, but there appears to be a pre-exis=
ting
issue in damos_va_migrate_pmd_entry() and damos_va_stat_pmd_entry() when
handling large folios.

In the PTE iteration loops, when a large folio is found, the code sets
nr =3D folio_nr_pages(folio) and updates pte +=3D nr and addr +=3D nr * PAG=
E_SIZE.

Could this skip unrelated PTEs if the iteration started on a tail page of t=
his
folio (e.g., halfway into an mTHP)?

Advancing by the full folio size could overshoot the end of the folio and s=
kip
unrelated PTEs mapped immediately after it within the same PMD.

Would it be better to subtract the offset within the folio to safely skip o=
nly
the remaining pages of the current folio?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512151523.2092=
638-1-wangkefeng.wang@huawei.com?part=3D1
