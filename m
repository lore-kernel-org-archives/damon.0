Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090895;
	b=jfPU5tF+kOjAPbI9VaK42pN5iraS4XUQgaQ4WDYy+8RDTuVJfbsOjVSmpkaZJZXNyyz6
	 2Rcc3F9v9d2qx7HrP03AfLTDyvdTdnYKVz7lMyyCtclss3XfJfQBj0ikodUhb9fTw9nmr
	 2+NNh51f7nfI2gQBSMsC42+PRjsAi+dvu6w/B0jV141HJ/vgdMYaIKGktZeozJ0wX097s
	 vN2xzB2RFD4kctR+LcEZO+X5LnYo93dUYm479q4UI/+b3E75zS2e74N2MM1Jxd34rKDeC
	 EG61lnj7u2S2Uzmb3qSievwUymxzbcQgjdkxRrA37U1TbEHW2tiXG1rkTxangzzXCfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090895;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1SQ55M2ZKFspye6i6a+mymWWbMlbcuU/lYS14dDVkcA=;
	b=doR1iC8gxR3Qr6EWvYTW3LGm9fuExQvNAVYEX+Nn9gm6QZDJrYjwbMeN3ozlTn1rAidQ
	 EJQFk11kzrtHr0ch9ooLz1fk9mFzY9sJshaADRhi9A2tVtusldgocIB+wSeznZz+Fp2/r
	 a/t0IbIXIZocT3LBPnGHTDncsKZgCVMwUYJNPSNRY8iRb45uQGdQKgZT7CykYcsE2hoGd
	 caUE0UJ4l8DfBEHWMNy35uz+u0EXMrgaZK3HVziG1BV1fBXxE+k99dD0F+bx+6Y/mDGo2
	 CKX2awSc0I9DouzcrdMtwZWto6couIAnsRF0KJHc9cHmJ3Nn7VyFiU2Yx+SyI6Kz2qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fk/ZoTkP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3C606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fk/ZoTkP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B568C1F0089F;
	Sat,  7 Nov 2026 22:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090895;
	bh=1SQ55M2ZKFspye6i6a+mymWWbMlbcuU/lYS14dDVkcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fk/ZoTkPNPRS7R8Gb9VFJDMml0zqWgTOUtZeHJj/hjcPAN6iRlseZFNsqZY6BZFN9
	 MaHb+Vekxwlm9uAxQlUXey/O1ubJyDSj5OTjXFU5784ipL0lDKGGgYJYoufhsxEMzH
	 re/SpBoOLuz/3rAERj4VyWzVilq0ZQmFAJL5i44MEMzBxyzoPybxHXdJqp0AsWapnM
	 ivK5gCAh1Odmg6EOzjUhvYDntI2JLgVVafhJoDFYhVwyNqZDKD/mAo8f7QbFvHQ1SS
	 Km4nXht5EjK8kd1yHsKD2gKZlaSeuYHA4PxgzCxG6deTlPhHxjeBMUpR4mPVnh9S8r
	 VI++l7WN95BIQ==
Message-ID: <sashiko-outbox-203367@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.6.y 3/3] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261107222202.331476-4-sj@kernel.org>
References: <20261107222202.331476-1-sj@kernel.org>
 <20261107222202.331476-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 22:34:54 +0000
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
- [Medium] mm/damon/core: dangling pointer ABA match in
  damos_fix_stale_charge_pointers()
--

commit f7e621ee98abae5b2fb7828ae72ea3e96d1173fd
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove unreachable damos charge_{target,addr}_from

This commit adds damos_fix_stale_charge_pointers() to damos_adjust_quota() =
to
reset quota->charge_target_from and quota->charge_addr_from when the target=
 is
no longer in the context or has no regions.

Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 99e934a6d1ce9..61d45d40fc1d3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1088,6 +1088,27 @@ static void damos_set_effective_quota(struct damos=
_quota *quota)
>  	quota->esz =3D esz;
>  }
> =20
> +
> +static void damos_fix_stale_charge_pointers(struct damon_ctx *c,
> +		struct damos *s)
> +{
> +	struct damos_quota *quota;
> +	struct damon_target *t;
> +
> +	quota =3D &s->quota;
> +	if (!quota->charge_target_from)
> +		return;
> +	damon_for_each_target(t, c) {
> +		if (t =3D=3D quota->charge_target_from) {
> +			if (damon_nr_regions(t) > 0)
> +				return;
> +			break;
> +		}
> +	}
> +	quota->charge_target_from =3D NULL;
> +	quota->charge_addr_from =3D 0;
> +}

[Severity: Medium]
Can t =3D=3D quota->charge_target_from falsely match a newly allocated
damon_target if the old one was freed and its slab slot reused before
damos_adjust_quota() runs?

When an online commit removes a target in damon_sysfs_apply_inputs(),
damon_sysfs_set_targets() frees the damon_target via damon_destroy_target(),
leaving quota->charge_target_from dangling, while damon_set_attrs() advances
s->next_apply_sis past ctx->passed_sample_intervals so kdamond_apply_scheme=
s()
skips damos_adjust_quota() on that cycle.  If another target is added before
damos_adjust_quota() next runs, kmalloc() can allocate the new damon_target=
 at
the same address, causing damos_fix_stale_charge_pointers() to return early
and leave the stale charge_target_from and charge_addr_from values active in
damos_skip_charged_region().  Clearing charge_target_from and charge_addr_f=
rom
when the target is destroyed during commit would avoid keeping a dangling
pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107222202.3314=
76-1-sj@kernel.org?part=3D3
