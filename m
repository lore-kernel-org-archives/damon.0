Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AD3AFD0C;
	Mon, 27 Jul 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171497; cv=none; b=ldfoL88D7P7QCk2gPxWCO6h7qeQ5RhwBu3pnqkoprNTQWbweLSVtaXMbAB/BE2h+Htp1KpaA3Ao5AVgPHXsKpoojCkj2FjZ+9cIuXA2P9QK+kVQ+Z5Lh1eQfmYNY/1s0RHCG6yhLiYZBWMHtWmErbp5RtMhl9FAHAwSoP4AAjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171497; c=relaxed/simple;
	bh=BaEzVh8KGJQttZSj+2xNa6zXeW4JqZBpTAF6kb6T0QE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OqxcFLtOQgM9AjimHt7ux4NMDWTB9B0gWi38ILwejej8J6VaBZfQt+HI7JQp46fjZe3ZWer5oNUaw/7xhHKKZ1IvppO7ejZtTlFp48+eccCTQRTWT+XXrFKzHXgAiF5XiMAbRaN3aaCeVB9TqU2Xh+Wgf/jd5ST/SXns3hD+jV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/Jm4eCp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/Jm4eCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9212C1F000E9;
	Mon, 27 Jul 2026 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171487;
	bh=A9bjCVqW/Ej3dLMulthxoTyFz5V81faOSr+gAOE/olo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i/Jm4eCpGh2eE/GF0a0/6UO6EDBt38eLRhNh0wRLi5Iz79NBA0f/7WjSA9BCfQ+Iq
	 B/3husOAhcsPhxSFyY20tKzeSkHBd6KBJa+mlmzgnNTSX8vyDo1lAWAjkd3d7FPxsx
	 j01rtH2V63/OujMeEcrGwuNDzjBg5bl45mcVrRFIIBDagYFZYHnLyJ9mI2SWCk8gYq
	 Zsmrong6YMMhuJrczsYYq4ADSKuX9eK4ui+UcEbKlX7x1GHOQ2F2bfG2Mhg492P1g6
	 NT/6YYKFZfOOfZlPodzPjRaqp58pEfcu9bcBpu8mT8kt4cG/yKfIenvY1H/qwbl6v0
	 LKqqUMbuDz9VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/11] mm: convert PTE table entries in ptep_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: dri-devel@lists.freedesktop.org, damon@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260727164715.2866609-6-usama.anjum@arm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-6-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:58:06 +0000
Message-Id: <20260727165807.9212C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect placement of READ_ONCE() around __pte_from_hw() in ptep_=
get() breaks atomic PTE reads and causes compilation failures for architect=
ures overriding the hook.
- [Medium] ptep_get_lockless() fails to apply the __pte_from_hw() conversio=
n hook when CONFIG_GUP_GET_PXX_LOW_HIGH is enabled.
--

--- Patch [5]: [PATCH RFC 05/11] mm: convert PTE table entries in ptep_get(=
) ---
commit e1a429a7f2c12fbd880800f901c43b4ccbc922d7
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm: convert PTE table entries in ptep_get()

This commit introduces a conversion hook __pte_from_hw() for ptep_get(),
allowing the function to accept a pointer to hw_pte_t and return a logical
pte_t value. The generic ptep_get() implementation is updated to use this
new hook.

> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index dad80d264aac2..3003ac9cd81fe 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_are=
a_struct *vma,
>  #ifndef ptep_get
>  static inline pte_t ptep_get(hw_pte_t *ptep)
>  {
> -	return READ_ONCE(*ptep);
> +	return READ_ONCE(__pte_from_hw(*ptep));

[Severity: High]
Does wrapping __pte_from_hw() inside READ_ONCE() break the atomic read
semantics and build stability?

READ_ONCE() requires an lvalue to perform a volatile read. If an architectu=
re
implements __pte_from_hw() as an inline function returning an rvalue, this
will cause a compilation error (lvalue required as unary '&' operand).

If implemented as a macro returning a compound literal, it compiles but the
actual read of *ptep occurs outside the volatile scope during the
initialization of the stack temporary. This allows the compiler to tear or
reorder the memory load, potentially breaking the concurrency safety of the
page table read.

Should this be __pte_from_hw(READ_ONCE(*ptep)) instead, to ensure the memory
is read atomically before the conversion is applied?

[Severity: Medium]
Does the lockless fallback loop in ptep_get_lockless() also need to apply
this new __pte_from_hw() conversion hook?

Looking at ptep_get_lockless() in include/linux/pgtable.h for architectures
using CONFIG_GUP_GET_PXX_LOW_HIGH, it currently constructs and returns an
unconverted PTE directly:

	do {
		pte.pte_low =3D ptep->pte_low;
		smp_rmb();
		pte.pte_high =3D ptep->pte_high;
		smp_rmb();
	} while (unlikely(pte.pte_low !=3D ptep->pte_low));

	return pte;

If an architecture using this configuration requires a custom hw_pte_t
conversion, callers might misinterpret the logical bits of the unconverted
hardware PTE. Is it necessary to apply __pte_from_hw() to the assembled
PTE before returning it?

>  }
>  #endif
> =20
> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
> index ed5dba42a4f8c..61afe27307ec2 100644
> --- a/include/linux/pgtable_types.h
> +++ b/include/linux/pgtable_types.h
> @@ -6,6 +6,7 @@
> =20
>  #ifndef __HAVE_ARCH_HW_PTE_T
>  #define hw_pte_t pte_t
> +#define __pte_from_hw(pte)	(pte)
>  #endif
> =20
>  #endif /* _LINUX_PGTABLE_TYPES_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727164715.2866=
609-1-usama.anjum@arm.com?part=3D5
