Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166508;
	b=YKizA3ztT4lzZ9Xd4GVyKex/DedIO3vvu7baATmGaV6dOATWMZGHjlAUdt2HMOxSmF7Z
	 yl/oAoTVpHP7KL8BPzCmZ5vWmjgcvlENlALPw1OSpPoa88Hy6dkhFIFXEndmUiHg1zVfd
	 d1sV5bDtY6/yiU1b3YjyI6vPUKZdfq2EqX4cFE/FhwW+wQi3PLoanVu61X4w0p2o6SShB
	 RGSuQXU5SuwSzDxAQdL1C0PvHjfzdOs6WLb4/jkGazjiL8FM08iidchaqrr0tdLGQl718
	 d8ncJeReRvYPZAU8P2vSVIIWQuGWn+WdbyHou+bpFCwBF6A1bziAEhmsbHsW/3c9f5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166508;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qMoelyuk2VfMurY6waAlYQD8QytmPxb/gWAf2drSJiI=;
	b=xw7750tdPiiy5CsDZnx2eWqwpHJrLPoapJ46MLXPJE9f14MIW+ztcPfvuon0QgP2Hf7y
	 HlPp1lU/aUCfThUSOvmD+tXfQBLJLPJZfif8itDQGtHsWfaJbQi4P0EfSs6b6kKy6aCRY
	 UxknkcMW4lEQ430lnm5JWddFubc8HdEZnzmXT3VrT99fb4+zOMfHs2Bg4kYr4eDgpiQIj
	 gwBYeRAT7vZwfCLwa6TRsZNkIawtKzEOD1hfQKvoGZdZIKs5sTR9e1AI5px3kVoXsk1UC
	 95vCs/CTPXe+sjxYCorMKu8FPNkJj+mUynO1jIbNpIoX7l/yULmdeS6xsxESvfHAfFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgIoyWxd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F7606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgIoyWxd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917121F0089F;
	Sun,  8 Nov 2026 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794166507;
	bh=qMoelyuk2VfMurY6waAlYQD8QytmPxb/gWAf2drSJiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cgIoyWxd5IGfr+5BDqb3s16fRCgVR/zP2v1rPaXGaBZomrweBeELCPCfn7LrOnOKW
	 wx8Zsb9KQZ3Jmkc+nfR5GzDOoBTkoo99Bk9xzu2wWulblYaBY1Br9Jh4xxQgAfgyo5
	 SbKORKY451zq/oBphMFweWck94KZYapODD69Ey90NZ3wFDgR6SqsWcM3Arsz3DdoUt
	 w+Cr5kyk3YNTccMLmHD/R99ihqSXS02kCQMLIZbocpJkN55zucp+GmuU3u0tbB1R4c
	 PZqYPwzbGf/lilYinYkl/bqRRljeBD02+v/uzKgDE9hdu5XqblYEfN/9dIqe7buI6D
	 4Ju0cQrTa1c5w==
Message-ID: <sashiko-outbox-203968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 1/5] mm/damon/core: skip applying scheme if
 region split for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Usama Arif" <usamaarif642@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261108192221.114362-2-sj@kernel.org>
References: <20261108192221.114362-1-sj@kernel.org>
 <20261108192221.114362-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:35:07 +0000
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
- [Low] mm/damon: damos_apply_scheme() inflates stats on region split
  failure
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] mm/damon/core: total_charged_ns overflow in
  damos_apply_scheme() [1]
--

commit 9174bd7b58d2e2acd57046175fb6abb05138bbb9
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip applying scheme if region split for quota fails

This commit updates damon_split_region_at() to return an error code on
allocation failure and skips applying a scheme in damos_apply_scheme()
when splitting a region for quota enforcement fails.

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 8fa788b0d709c..4c536a9b958e4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2000,7 +2000,8 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  					c->min_sz_region);
>  			if (!sz)
>  				goto update_stat;
> -			damon_split_region_at(t, r, sz);
> +			if (damon_split_region_at(t, r, sz))
> +				goto update_stat;
>  		}
>  		if (damos_filter_out(c, t, r, s))
>  			return;

[Severity: Low]
Does jumping to update_stat when damon_split_region_at() fails inflate
s->stat.nr_tried and s->stat.sz_tried?

At this point sz is the non-zero aligned remaining quota size.  Jumping to
update_stat calls damos_update_stat(s, sz, 0, 0), which increments
s->stat.nr_tried and adds sz to s->stat.sz_tried even though
damos_filter_out() and c->ops.apply_scheme() were skipped.  Because
quota->charged_sz is not updated on failure, subsequent oversized regions
in the walk that also fail to split will repeatedly add sz to
s->stat.sz_tried.

[Severity: High]
This problem wasn't introduced by this patch, but can
quota->total_charged_ns overflow on 32-bit architectures [1] in
damos_apply_scheme()?

struct damos_quota defines total_charged_ns as unsigned long, which wraps
around zero after roughly 4.29 seconds of accumulated scheme execution on
32-bit platforms:

include/linux/damon.h:struct damos_quota {
    ...
	unsigned long total_charged_ns;
    ...
};

mm/damon/core.c:damos_apply_scheme() {
    ...
		quota->total_charged_ns +=3D timespec64_to_ns(&end) -
			timespec64_to_ns(&begin);
    ...
}

mm/damon/core.c:damos_set_effective_quota() {
    ...
		if (quota->total_charged_ns)
			throughput =3D mult_frac(quota->total_charged_sz, 1000000,
							quota->total_charged_ns);
    ...
}

When total_charged_ns wraps to a small value, damos_set_effective_quota()
computes an inflated throughput and effective size quota (quota->esz),
causing DAMOS to process far more memory than allowed by the time quota.

[1] https://sashiko.dev/#/bug/linux-c8969436-aa48-48c6-9f46-a12a64361494

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108192221.1143=
62-1-sj@kernel.org?part=3D1
