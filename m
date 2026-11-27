Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818813;
	b=Dda8mSZqdYJlp8VtPkQwUmqCNL+l1+TmD06rbIiWeilUJ733x3xxZFlAhP9SGJK6eNUN
	 gV+uFt58TAiwLA5W6Ju2sNJkFu/qSlp8WD16SIZk5PQEYNvDTGKGPdlF8K2nHsEMqvzkN
	 3ApUek1s38u5lVowneyfatk1+EZ4hNZa4771Ao/coHovljo/pRCTLgqr5UGzsEcXfBKKU
	 yzuZiWRO2BE21mXwrcQClBp1obLwVYueT/zdYidxTe7bvWqols0n2rWTJFhUUv+sUAQVZ
	 qV7VDYEgS7JMLkSMlyfHGMCTpIdPTnWq6lKvbucLQ5l9c/2qiCatihMrlbO4+WVqnSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IVmY0pCpM6LntaMWmUr3NRIGkIMDmQmHgaKoV3DNWuM=;
	b=APWwWYCarnCAi0vdQ+cA+szU3BPBG4s5bvBmgDq4XMjgDAwe7hrOrEdCoGyCUWL10inY
	 a38bW6O7HvnVQ5BCPUccxz4mXR/qGULM+IsmiL/rzR7hAtGFHGJiw34IMFqzRDujNGj53
	 iUDwk7XIk91cbJYY8ED7J51qT3RPUSh/D+Kv2bJhcanvD5eANvIhKxXyGXmvRfSVFE6nx
	 66qb6W0XhaXY4vcAto+3Iz0unowag89aucJt0bLAoNwayeD+p5Or6A3F4G2cXIoqmBNJA
	 60JvNpKyBoUhobUc04b+DTC9LsvEsZOtIojnq4nipXyRTFeLRhs6I6/Rs4y/jlT4uAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHVgZtVZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0856606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHVgZtVZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824311F000C1;
	Fri, 27 Nov 2026 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818813;
	bh=IVmY0pCpM6LntaMWmUr3NRIGkIMDmQmHgaKoV3DNWuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHVgZtVZXHuord/NHnQH7Ls7JKGChInZ5aFM2i1Dv6Gjslb0wreWcmFAMHixFmiYL
	 l2rCt5+dbyOmrJF1HcI7EmDvoh3lBNDCfiZo4UtLba5tUE5VGFe9bC7U/FKU57GNDr
	 43mgfjxujA5Hm1tMG4xFt/q/8lIAUeU4X+On5d/kV/91YK+R4C6WtlJRFAb3mYZZ20
	 e8Hg9pjM4dPZ6JRq+xen7GrYUf9C48R+NLNPsxYTP05lESlg1ovsE+/8q3UUCgrmP0
	 vv1BOO0htKfdqNkJJhgpcp6Hm22PfrgyskbIHfua2Gvm5M7tzIWgWOBG9di4LmF0+h
	 t1+72JqgEhshg==
Message-ID: <sashiko-outbox-238332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/7] mm/damon/vaddr: use damos->last_applied for
 migrate action
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261127222719.105510-3-sj@kernel.org>
References: <20261127222719.105510-1-sj@kernel.org>
 <20261127222719.105510-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 22:33:33 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] mm/damon/vaddr: NULL folio dereference in
  damos_va_migrate_pmd_entry()
--

commit 28e5ee87b052dd198d574f424c2cf49c18aacf24
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: use damos->last_applied for migrate action

This commit updates damos_va_migrate_pmd_entry() to track and skip the last
applied folio via damos->last_applied using damos_va_invalid_folio().

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index ca7ce9bd96e7d..c8f93a19c840e 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c

[ ... ]

> @@ -881,10 +888,11 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, u=
nsigned long addr,
>  		if (pte_none(ptent) || !pte_present(ptent))
>  			continue;
>  		folio =3D vm_normal_folio(walk->vma, addr, ptent);
> -		if (!folio)
> -			continue;
>  		page_idx =3D folio_page_idx(folio, pte_page(ptent));
>  		nr =3D folio_nr_pages(folio) - page_idx;
> +		if (damos_va_invalid_folio(folio, s))
> +			continue;

[Severity: High]
Can this dereference a NULL folio when vm_normal_folio() returns NULL, such
as for the shared zero page or a special PFN mapping?  Removing the !folio
check before folio_page_idx() and folio_nr_pages() passes NULL into
folio_nr_pages() -> folio_test_large() before damos_va_invalid_folio() is
reached.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127222719.1055=
10-1-sj@kernel.org?part=3D2
