Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF0F577E4C;
	Tue, 22 Sep 2026 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097958; cv=none; b=sLZrpRTTsv+dNkTsNpbwi/BRCJZINjITA/spP8zIvOBsOF6GQeaUIL8u2lbX4kwmQ8Hfa/3MBoo3xxt6Lr+yeqL33SaCI9suIY5Adv6omfuXXy1S+kd71IrXsMuq6/clFfQ1F3tm66wlFXzPuLnaPX1J+zBrGN+Vr1ZVgzx6cmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097958; c=relaxed/simple;
	bh=BrohACcClQNc55mg96PWnJRkpqjoryxqZNt3fQWsZ64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tD5/EPIGBr3ONCIMG7+SP8atY/RUP6k3+4JSBxlBT/ljpXTWK2TugpvfgZHQaOxKiy6JLYVJ74gi7KdIl9x96LpFAqeUSscVkbFvb6n7YMv4S6Z5bbOuwbnNmjxVzlsTKKWVYcPjYowIlRS39PosWqWvb/Kr6+NLzM6cKYpfA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ+COoeH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ+COoeH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE771F000FF;
	Tue, 22 Sep 2026 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097956;
	bh=GH5NHM9SMF3Y3qqzIYDs7t0XJRudoDanszTIA7TBNl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJ+COoeHnUsfulxKqmrHOgHPmfFsPFDR1BHEd7DN5EkuDT+uLwT+DVh6nKnhhx0kd
	 6jOF39OHwCoQKodyfnRa9zMMqnPruPv0F5Y4uRUrN3i+bQ9O82bTIwnkGhf350SmMH
	 fsgZAIwzEREmJcXInwshoN3qyHED7DKELRu6bhNyO3e4WXLGerFLhQjDY2VwWNbOPs
	 5xPMvggl9ITtHem2X3h4BEL3c41zYL7BElmVh0TwPXZSbMUSIQdUP9iD5gdynrNlcl
	 XZmQaxOGRU7L/ratpMDHur9SA9WJNWu1+3H6a5o8mZyCiwZeiKCL5nCsJ0trfBvRm5
	 y6D9shH+H31Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] mm: convert PTE table entries in ptep_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org, damon@lists.linux.dev, bpf@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-4-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-4-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:25:55 +0000
Message-Id: <20260922172556.1BE771F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: build failure in ptep_get_lockless() with ARCH_HAS_HW_PTE_T
--

commit 5a58c0b37be320a1ff8bd51ae9ca94d50bf27375
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm: convert PTE table entries in ptep_get()
   =20
ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
return a software PTE value. Add __pte_from_hw for both generic hw_pte_t
definitions. Read the hw_pte_t table element atomically before converting
it to pte_t.

[ ... ]

> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
> index 07da05d375c2c..d6c5a7548550b 100644
> --- a/include/linux/pgtable_types.h
> +++ b/include/linux/pgtable_types.h
> @@ -8,8 +8,10 @@
> =20
>  #ifdef CONFIG_ARCH_HAS_HW_PTE_T
>  typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
> +#define __pte_from_hw(pte)	((pte).__pte)

[Severity: Low]
Does this wrapper struct cause a build failure in ptep_get_lockless()
when architectures using CONFIG_GUP_GET_PXX_LOW_HIGH (like x86-32 PAE)=20
opt into ARCH_HAS_HW_PTE_T?

When hw_pte_t is a wrapper struct instead of a typedef, the direct member=20
access fails to compile:

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

Since ptep is a pointer to the wrapper struct, it lacks the pte_low and
pte_high members.

>  #else
>  #define hw_pte_t pte_t
> +#define __pte_from_hw(pte)	(pte)
>  #endif
> =20
>  #endif /* !__ASSEMBLY__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D4
