Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3C261388
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238024; cv=none; b=i2RrMO8rM4oFOzKcVWwtLkJdKMWjoegHxEdWP41bKL55izemQsLukHE7g8RUgCE55CMc7QhjIyy5TYzwzqGflJODetQX7h3uFgOvRuijwy3ZcfixZTD5EcUYtZW1o4wmkoC42iyafw08Ql+XmnLy6GLA+beMTvfGlqdkBMkvWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238024; c=relaxed/simple;
	bh=IA46eK9KJeQLAPvTx2r8SeFgKK/3V+10MZe6yVrXixw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DK22TnwOKGb6oq8aEz2aLU6YSNiJkibFejgWGeh4H7ikZGVo+Ixw1riB/9hJypewCZaZwBPdiZJs9Rxci7gkMgGZPe1LIEWNLNA7+pisLLJRkPcVHMYIE5BDnXmrJ0gix+vjQvT52Qy8sm2FEYuRqxkY+LfmZxZ+xKfq2CLQ9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ+aIhdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ+aIhdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19E71F000E9;
	Tue,  1 Sep 2026 04:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788238022;
	bh=hMCvYayL4TCUAMWAGjxL94d/P5pjYRp43SI2Gy3Dmjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DQ+aIhdvsUR0/dcptQ/3yp5iy3G76yKsp8OXfcOoU3RmM+UpJZegVGxaidJwt8RcQ
	 13u8AbPsFgsIAvIPBeFstugvaWkhWtlQoulX4K/HcX7ntZ6yROky72Xr086U//ULsj
	 kD31t/OLXdYrARqPioUMLZHGEQ4nYPaF8Qcpdx9MoJg0apR7vxK8lLb83nIHlgRrBz
	 Bk48F0twlwKNQacoRm+hzVakqCeG77oYkxuZ71Xy5QwgGSM3ay6bdEl3sazZwMYI9S
	 H2W34NzPY1ZgYznkHwmhzbEqz6xuzboDsPlTXkpysDKvMenn7p6OGdnv88v/+vFj90
	 idvoipnCo34eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/17] mm/damon/paddr: support damon_prep
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-9-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:47:02 +0000
Message-Id: <20260901044702.A19E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `damon_pa_prep_probes` applies probe preparation actions without=
 checking probe filters, causing unintended page state modifications and re=
dundant folio lookups.
--

commit 05f1236264960a0054ba7741a1b9b7ae78666ee1
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: support damon_prep

This commit implements the prep_probes() callback for damon_operations. It
adds support for the DAMON_PREP_SET_PGIDLE preparation action by unsetting
page table accessed bits and setting the PG_idle flag via damon_pa_mkold().

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5b307dcbb2a50..8fb71183b76c0 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c

[ ... ]

> @@ -105,6 +105,40 @@ static unsigned int damon_pa_check_accesses(struct d=
amon_ctx *ctx)
>  	return max_nr_accesses;
>  }
> =20
> +static void damon_pa_prep_probes_region(struct damon_region *r,
> +		struct damon_probe *probe, struct damon_ctx *ctx)
> +{
> +	struct damon_prep *p;
> +
> +	damon_for_each_prep(p, probe) {
> +		switch (p->action) {
> +		case DAMON_PREP_SET_PGIDLE:
> +			damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr,
> +						ctx->addr_unit));

[Severity: Medium]
Will this unconditionally mutate the page state for every prep action,
regardless of whether the page passes the probe's filters?

Because damon_pa_prep_probes_region() doesn't check the filters, it appears
it will clear the accessed bit and set PG_idle on pages that are explicitly
excluded (e.g., when a probe only targets a specific memcg).

Could this disrupt legitimate LRU tracking and reclaim for processes not
targeted by the probe?

> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static void damon_pa_prep_probes(struct damon_ctx *ctx, bool set_samples)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	struct damon_probe *p;
> +
> +	damon_for_each_target(t, ctx) {
> +		damon_for_each_region(r, t) {
> +			if (set_samples)
> +				r->sampling_addr =3D damon_rand(ctx, r->ar.start,
> +						r->ar.end);
> +			damon_for_each_probe(p, ctx)
> +				damon_pa_prep_probes_region(r, p, ctx);

[Severity: Medium]
Since damon_pa_prep_probes_region() is called in a nested loop for each pro=
be,
could this cause redundant work?

If multiple probes use DAMON_PREP_SET_PGIDLE, this will redundantly invoke
damon_pa_mkold() multiple times on the exact same physical address, leading=
 to
unnecessary folio lookups and reference cycles per region.

> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D8
