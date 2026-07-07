Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264C414A19
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433118; cv=none; b=hAHeN2eJfGPIqExy4mcAjfboM8Rt844yumF3RVjs4oF54XpedbPTmZmxA4Ueb3LaepncqWq4sPKgUOBII+/vd7+RtC3qj+MNIRD5N4dKdqoDmf5lgkY94gZ9PutP25oo3HnOOQxD9OFFc0XNdnEJlNHD9jSsrFoXJKDzWYSQJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433118; c=relaxed/simple;
	bh=ZXxL9FOVx3Fo9AqWdPdQV6uiMUzVELfc06Wicml87Ko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V10cRyP9/3ezZBQi+K6/+iCZgcMT/vQlTMtj1o2jlmt3mQlP+75apIn2Dw+LVO9fyKK6OREoprAlqUp7NJJgyY1isdAnncxUzMyRKyW5CIGfn0VYOeOOBGJGdgQjqbpgmRMSBL5t9UkHKeowpQO5xxM63yNXjXPzlcwuJpyZhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSuteV4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSuteV4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3CD1F000E9;
	Tue,  7 Jul 2026 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433116;
	bh=gA1vr9b1TCG90jhR5PV7swM2jkN+THa9nZUHPao4GpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSuteV4HtKvKf+x29tvRktd+Bh12SliApJLIuS9h0z4vJrHVaCIU/krVEf9f1x9ol
	 ZT6J9XsZb/8dMHAkHfx15JZ8z2vh+zJs7LGjXRGVvrRTJsN6zkz3rU/RGGsYIfX6W8
	 kvvLI/EdtepkFn/ClIlhfqju1HhijN9B5fHUa1WHitfctqgLCqdLOUDxpRV6UluInn
	 GwHfAitjcTIcAL1cmX7gv9ZAkhDdL79By6t0j4aw5Mk3JsHqK7K9c6xv07IC73lFtY
	 vk/eKALjYi1DRqXKJfWRXbOiEPjSehaorIG+i5Kl2I7hASP4GgjP6rGxSDSy7CAgAI
	 4i40K/OjNVN4Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 5/7] mm/damon/core:
 s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707135038.90068-6-sj@kernel.org>
References: <20260707135038.90068-1-sj@kernel.org>
 <20260707135038.90068-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:05:15 +0000
Message-Id: <20260707140516.8C3CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Incomplete refactoring: the parameter name `nr_accesses` was not up=
dated to reflect the new generic purpose.

Pre-existing issues:
- [High] 32-bit arithmetic overflow in `damon_sample_bp_to_count` and `damo=
n_sample_count_to_bp` corrupts interval conversions for large aggregation w=
indows.
--

--- Patch [5]: [RFC PATCH v1.1 5/7] mm/damon/core: s/nr_accesses_for_new_at=
trs/nr_samples_for_new_attrs/ ---
commit 17e2132821e6ed9a2213f8cf4fa6bdeba54db3b6
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/

damon_nr_accesses_for_new_attrs() can be used for not only nr_accesses
but also any positive sample count, like probe_hits.  Rename to be able
to be used for such general uses without confusion.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 718268df27fa7..cda318806b65b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -890,7 +890,7 @@ static unsigned int damon_sample_count_to_bp(
>  	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
>  }
> =20

[Severity: High]
This is a pre-existing issue, but does this calculation silently overflow f=
or
large aggregation intervals?

When users configure large aggregation intervals (or very small sample
intervals) such that samples_per_aggr exceeds 429,496, calculating the acce=
ss
frequency ratio overflows 32-bit math.

The mult_frac() macro calculates (count % samples) * 10000 using the 32-bit
type of count. If samples_per_aggr > 429,496, the remainder can be large
enough that multiplying by 10000 causes an overflow.

A similar 32-bit arithmetic overflow can happen in damon_sample_bp_to_count=
():

    return bp * damon_nr_samples_per_aggr(attrs) / 10000;

> -static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_acce=
sses,
> +static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr_acces=
ses,
>  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
>  {

[Severity: Low]
Is the nr_accesses parameter name still appropriate here?

Since the function is being renamed to be used for general sample counts
(like probe_hits) without confusion, leaving the first parameter named
nr_accesses creates a semantic mismatch that limits the readability benefits
of this refactoring.

>  	return damon_sample_bp_to_count(

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707135038.9006=
8-1-sj@kernel.org?part=3D5
