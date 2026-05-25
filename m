Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D1F2DAFBB
	for <damon@lists.linux.dev>; Mon, 25 May 2026 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723284; cv=none; b=LiCXdYWpr+qwZl/L3URjnf9KlD55W3cAFN6eM8la7faZ6Wba6z3fWq4M+7H7a5SL8k2MnSy8BbfqBQn8KUA9xNKxV9uWbM2jGNU5gqH7EY6flvLnQTz7uxmMjS9j7V9Unjcf4HWpjg0ATyEcJxJOp22qUXHAX55rBRhK4GLMoD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723284; c=relaxed/simple;
	bh=ljLvyMt8wKhecIBbvP3S4rUWse2mXFl2DFpcZOWBY14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rP51LYs2PD8IqwJuU2d5sCmBvG38ekxYH6jYXaBlFyfjx7oGhmnmVvX1cTeZWO4U/JV6keNV2eusd7X7l3KVgWZKlfhN5lM9CpSCHjiLj8e2Q4ePvd42YDgJvl+Odr8FmlBAn2Hx49GIdkTVIC7KCg7pmQdweI7D54lH2g2qykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXGl02LF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXGl02LF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9621F000E9;
	Mon, 25 May 2026 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723282;
	bh=3zymzHLZ+lmWqrWR9C6uKANOjhryf2nuppP0lizdg3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXGl02LFhFmnk4X+mWiVNCTdbv8cqBcxcfC6nr6mtP9M4QFuI/rzfU01n+Z4vp68z
	 B6URCJFrevFj7oxzI8OhSFm8rXoA0OaW1clUax7AzWXGrOHvu00rSIiMVgqKqgZRWS
	 EWe2FOhPSK90mM92vY7PrWBPqr57ytGDhG5D/aUGARzybbL5/SRlNZ4+dqJwOyv7ks
	 9dprfqNwRzX4DfWE9GnILV12cAnmrDbPbjyrztDtiSQDpx7s+SN0VCOojTbd81PCr6
	 +2PxWUXFvecS1eyQEJfYLrGhsnQUFJf16+M97qR2wh3JT/q0L6jD086ob4g4KUjNIR
	 ZLnd/Hi9UDN4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: fix stale TLB young-state handling on arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260525144846.604907-1-kunwu.chan@linux.dev>
References: <20260525144846.604907-1-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 15:34:41 +0000
Message-Id: <20260525153442.5D9621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Replacing pmdp_test_and_clear_young() with pmdp_clear_flush_yo=
ung() causes kernel panics due to unaligned addresses and introduces severe=
 performance regressions via synchronous broadcast TLB flushes.
--

commit 35d1d30f8c4d83134e4728cac82067099a6e3cab
Author: Kunwu Chan <chentao@kylinos.cn>
mm/damon: fix stale TLB young-state handling on arm64

This commit modifies DAMON's page table access functions by replacing
test_and_clear_young with clear_flush_young variants for both PTEs and PMDs
to resolve stale TLB entry issues on arm64.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 3a0ddc3ac7196..ef154df145310 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c

[ ... ]

> @@ -90,7 +90,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct=
 *vma, unsigned long addr
>  		return;
> =20
>  	if (likely(pmd_present(pmdval)))
> -		young |=3D pmdp_test_and_clear_young(vma, addr, pmd);
> +		young |=3D pmdp_clear_flush_young(vma, addr, pmd);

[Severity: Critical]
Does this change risk triggering a kernel panic due to unaligned addresses?

DAMON randomly generates unaligned virtual addresses for sampling via
damon_rand(). These unaligned addresses are passed directly to
damon_pmdp_mkold() and subsequently to pmdp_clear_flush_young().

On architectures like x86 and s390, and in the generic fallback
implementation, pmdp_clear_flush_young() strictly asserts PMD alignment
using VM_BUG_ON(address & ~HPAGE_PMD_MASK). Passing DAMON's unaligned
sampling address could trigger this assertion.

Additionally, could this introduce a performance regression?

The generic pmdp_clear_flush_young() fallback, which is used by arm64 and
riscv since they do not implement __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH,
invokes flush_pmd_tlb_range(). This results in a synchronous broadcast TLB
flush across the system just for clearing the accessed bit, which seems to
conflict with DAMON's low-overhead design constraints.

>  	young |=3D mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_=
SIZE);
>  	if (young)
>  		folio_set_young(folio);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525144846.6049=
07-1-kunwu.chan@linux.dev?part=3D1
