Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37053DD503;
	Thu,  6 Aug 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006625; cv=none; b=uGcFiWuEwuAuLshHuVvntNlgumkm35z4/DG2I5fFkwj081xJnhZou7TQjCV8nwvPrDZYnxxEqwWH9tziujDB8lsCwrr5YUdIptD8caltqYkj9nLGU8i1hzT85WTYI+9G1FRWoXpGjAZ79n4MsKUB4UPzLur9/QrNNQW4icErpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006625; c=relaxed/simple;
	bh=Nu7eFX7wBmVApyLrp0W4D+TxguEMgc8XT0oa1R1Xo2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=grNGcMTep/pD0ULdVvWulHayHFa76MSRG8YoV0undbo6fDkJPLIAWw3Cvj16RPKLC+jiceIEzc+zqL/GayMVGeZO9eQvUoerTpNbcMrO9aXlM/t8/YBQPkxwXet9VwZisCDdmIp+fC/6nps5aVzc+gmjATpddIkx4lsL/scZYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuqJXkF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuqJXkF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BF01F000E9;
	Thu,  6 Aug 2026 08:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786006624;
	bh=c/H7nzTYi6BF4atfEvy+zdPRq8nTLE/WDkGn5YmUguE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XuqJXkF4wbrEQAxo3nqLKqmFQFapXB9waPDXoQsaGr5tDjxrkJKIBCabmI1CMdgIR
	 Q77k5rlz1g/mbYg0tq8vVsk+AMi2ec0uBpplqSC4EdPWDBcVnQe4dEi5oam6fLS5UK
	 h8ICKMdv3kC2OkmtsGX6FJJ6K+4Do0vwqMf6C36DmIH6BA22fSYja410lvh/zQrbPV
	 oUBgXL2twPkBbrS/yQ5cm5f3SfAG4cwtZvDXrZYjiIb6rIQB18i76jz2hXXgZR9ifh
	 FQg/XacnA3fvzsUfjkhAnHGGZC1UC/buoRYm6k1hTITOrTMCQ51b01LUkIfFMmcSpa
	 2JR/o0f+QanCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] mm: convert PTE table entries in ptep_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org, damon@lists.linux.dev
In-Reply-To: <20260806083926.1807279-6-usama.anjum@arm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-6-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 08:57:03 +0000
Message-Id: <20260806085703.C2BF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] ptep_get_lockless() fails to compile when both CONFIG_ARCH_HAS_HW_P=
TE_T and CONFIG_GUP_GET_PXX_LOW_HIGH are enabled.
--

--- Patch [5]: [PATCH 5/9] mm: convert PTE table entries in ptep_get() ---
commit 697ecf53dc0bc83c57005a208e0294657ed963f8
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm: convert PTE table entries in ptep_get()

ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
return a logical pte_t value. Add __pte_from_hw for both generic hw_pte_t
definitions. Read the hw_pte_t table element atomically before converting
it to pte_t.

> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index dad80d264aac2..1768421755a9c 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_are=
a_struct *vma,
>  #ifndef ptep_get
>  static inline pte_t ptep_get(hw_pte_t *ptep)
>  {
> -	return READ_ONCE(*ptep);
> +	return __pte_from_hw(READ_ONCE(*ptep));
>  }
>  #endif

[Severity: Low]
Does this change cause a compilation failure in ptep_get_lockless() when
CONFIG_GUP_GET_PXX_LOW_HIGH and CONFIG_ARCH_HAS_HW_PTE_T are both enabled?

When CONFIG_ARCH_HAS_HW_PTE_T is enabled, hw_pte_t becomes a wrapper struct.
However, ptep_get_lockless() still attempts to access pte_low and pte_high
directly from the hw_pte_t pointer:

include/linux/pgtable.h:ptep_get_lockless() {
        ...
	do {
		pte.pte_low =3D ptep->pte_low;
		smp_rmb();
		pte.pte_high =3D ptep->pte_high;
		smp_rmb();
	} while (unlikely(pte.pte_low !=3D ptep->pte_low));
        ...
}

Should ptep_get_lockless() be updated to handle the wrapper struct, perhaps
by accessing the __pte member or extracting the logical pte_t first?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806083926.1807=
279-1-usama.anjum@arm.com?part=3D5
