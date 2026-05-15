Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7935C1AD
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807828; cv=none; b=GM8CD2D8+ELBgo2J716bMA7zAL6GfM7V9iyBpM8I+qLTWe5kG9an/w11TW8iM+06e5rkJa3dPLdE/qO+7aLfB51LQUPX3aD6Yg+y+zrqDX1NcLfW8QpMXUZEVwGVEOElkDiU2E9x9FPbUtrrmW4CBhxO3HghwuFEwyMspFVa7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807828; c=relaxed/simple;
	bh=4QwHIRBhKXXZN0uZjMc8Z5C796EtVnizd+g6aVpyTMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V5wHeH+L7CLZL3Svo17qPTGDyPg24gh9anIqm02ZiCd2KtPE8dCjcsm3VjtETdKd0NEUn6oYrzadnr/Kanu7rBNN0rqRfsAtlgrxfpPERwCCQ/88+653Wxkw9NIjv/oU+o1rvIp0rE6cxkDIGAuTkh9ZfpC9lj+yncvdYwwriJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGEmlWyv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGEmlWyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C424EC2BCB3;
	Fri, 15 May 2026 01:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778807827;
	bh=4QwHIRBhKXXZN0uZjMc8Z5C796EtVnizd+g6aVpyTMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pGEmlWyv1XdDL5Tlesz5qN4EDB6xn+LEF1h9bs847mdbMPYHC0+M8NSqeyTh86UTv
	 X5pcSO2Ucn4lBsDh4zRnD3vFYH2djfkdJ+JvFkCIsnk2XaRUjtlzkm/vdpWZlghudb
	 I+ksBpAFAauPzflDVGiMOQ7/H1dTxganfTirLAxa1w1GE1pxCqVkCYfzlgrNHLFlKt
	 Np7fBWUnDgO+uuNSzy/fLRf/EAQphq5UQj4445C4gMjzN45GWOqOVR+wbpFJiEAf2m
	 19GQ+MgeLWE1MlA9yBwyNLvkSuZpPuAcB1Fe54RQkbQzIsiFJtrmphg14Ubw9ax9Ym
	 eWXt2rrGCMuDw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 02/28] mm/damon/core: embed damon_probe objects
 in damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-3-sj@kernel.org>
References: <20260515004433.128933-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:17:07 +0000
Message-Id: <20260515011707.C424EC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing parentheses around the `ctx` macro argument in `damon_for_e=
ach_probe` and `damon_for_each_probe_safe`.
--

commit e24428c998724cd2c79829fc347f7cc9804f966b
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: embed damon_probe objects in damon_ctx

This commit adds a linked list of damon_probe objects to damon_ctx. It also
introduces initialization, cleanup, and helper macros to iterate over the n=
ew
list.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a8fff5325b010..3ba5a31b51769 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h

[ ... ]

> @@ -879,6 +880,11 @@ static inline unsigned long damon_sz_region(struct d=
amon_region *r)
>  	return r->ar.end - r->ar.start;
>  }
> =20
> +#define damon_for_each_probe(p, ctx) \
> +	list_for_each_entry(p, &ctx->probes, list)
> +
> +#define damon_for_each_probe_safe(p, next, ctx) \
> +	list_for_each_entry_safe(p, next, &ctx->probes, list)

Should the ctx macro argument be wrapped in parentheses here?

Due to C operator precedence, if a caller passes an expression requiring a
cast like (struct damon_ctx *)ptr, the macro would expand to:

    &(struct damon_ctx *)ptr->probes

Because the member access operator -> binds tighter than the cast, this
evaluates as &(struct damon_ctx *)(ptr->probes). This can lead to
unexpected compilation errors or incorrect pointer arithmetic.

Wrapping it as &(ctx)->probes would safely isolate the argument and match
the pattern used by the existing damon_for_each_scheme macro in this file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D2
