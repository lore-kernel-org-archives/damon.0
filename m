Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD784A2A75
	for <damon@lists.linux.dev>; Sun, 18 Oct 2026 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361468; cv=none; b=Zr3wkoxAR1Jhz/tAlpN87+CjVvyeckAaM4SZYndwTHXjwkQVOZdUKmfjbV3Jw8l5lWZ6WcGoeqSMd1lzgoYScP8KmBAC8D3bhgsv8kTupeqp9VsKigsVo0JUhQpTX2LlHiGoTlBpvTtFZJQspCS08TaCZGUW6rW+4VmYJ/gGPj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361468; c=relaxed/simple;
	bh=lqy47y+3NndPVo2AbjqJho7REs02UH9Vw/QD0ptG2Xc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lEuUsRrAwWd2hEKzrxhWK8cfkVSr/2rpn4niHl8zqyL4RBHi7LSsc7m3TYhJEB1jtFIDTrrP6mjpSoiGc6eM74uRRNn23wt6AJtyEGd3n2sTBqYpnx44sFEFDTpgW8T4h7FHukqQhv80RfeLFtQKdth2qKDy+nqOXmMtFDPDZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G36YZRXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G36YZRXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896B41F000C4;
	Sun, 18 Oct 2026 22:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792361466;
	bh=Og2EJsxxAc5npVZpLxXfEFaB4KJhNSzXqile489hobU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G36YZRXC/OTU73bwidpCd7iMYyBCjwB4nMI5dHa9raADe6QInW8Wvv7D49l9rjclC
	 kmVh9EOVY/n7HOYeUzsWYtBg4UdIlyIVJaUi8VRQZ3wxmiV/oKmIeX1aUmHVOPcwvF
	 DpH0vuTTSD/iS9TcXeC0YH768wXDoReRd1b0nim/AlmK5635zVpr+tCooybkC76fQ3
	 Wp+r6lb3xha1lBaA60L48NHd6XSxPPaok0ePQLJzGICyTeTCUG2Kn2i7/xWiumzVK0
	 /fcOM9TVP1o9cwLsU2gllYXBtHWEWCwN4DBWOTL0Z4pCl/xBBwN0tcSj6lLRFA/Qp0
	 /tqwHpyLSyq5Q==
Message-ID: <sashiko-outbox-176425@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: filter out damos address
 filter-split failed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261018220253.158238-1-sj@kernel.org>
References: <20261018220253.158238-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 22:11:06 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/damon: unchecked damon_split_region_at() error in damos_filte=
r_match()
--

commit 881e287348e01011e3ec5442e7deb6f9c112db9c
Author: SJ Park <sj@kernel.org>

mm/damon/core: filter out damos address filter-split failed region

This commit updates damos_filter_match() and damos_core_filter_out() to
propagate errors from damon_split_region_at() and filter out the region if
splitting fails during DAMOS_FILTER_TYPE_ADDR evaluation.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b63e60ef89901..4d34587387456 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2551,13 +2551,14 @@ static void damos_update_stat(struct damos *s,
> =20
>  static bool damos_filter_match(struct damon_ctx *ctx, struct damon_targe=
t *t,
>  		struct damon_region *r, struct damos_filter *filter,
> -		unsigned long min_region_sz)
> +		unsigned long min_region_sz, int *err)
>  {
>  	bool matched =3D false;
>  	struct damon_target *ti;
>  	int target_idx =3D 0;
>  	unsigned long start, end, wsum;
> =20
> +	*err =3D 0;
>  	switch (filter->type) {
>  	case DAMOS_FILTER_TYPE_TARGET:
>  		damon_for_each_target(ti, ctx) {
> @@ -2588,7 +2589,9 @@ static bool damos_filter_match(struct damon_ctx *ct=
x, struct damon_target *t,
>  			break;
>  		}
>  		/* start inside the range */
> -		damon_split_region_at(t, r, end - r->ar.start);
> +		*err =3D damon_split_region_at(t, r, end - r->ar.start);
> +		if (*err)
> +			return false;
>  		matched =3D true;
>  		break;

[Severity: Medium]
Should the earlier damon_split_region_at() call in damos_filter_match()
when r->ar.start < start also propagate its return value via *err?

mm/damon/core.c:damos_filter_match() {
	case DAMOS_FILTER_TYPE_ADDR:
		...
		/* start before the range and overlap */
		if (r->ar.start < start) {
			damon_split_region_at(t, r, start - r->ar.start);
			matched =3D false;
			break;
		}
}

When a region starts before the filter range and overlaps it (r->ar.start <
start and r->ar.end > start), if damon_split_region_at(t, r, start -
r->ar.start) fails with -ENOMEM, r remains unsplit across [r->ar.start,
r->ar.end) while matched is set to false and *err remains 0.

If the filter is configured to exclude [start, end) (for example,
filter->matching =3D=3D true and filter->allow =3D=3D false with
s->core_filters_default_reject =3D=3D false, or filter->matching =3D=3D fal=
se and
filter->allow =3D=3D true), kdamond_apply_schemes() -> damos_apply_scheme()=
 ->
damos_core_filter_out() sees err =3D=3D 0, does not reject r, and proceeds =
to
call c->ops.apply_scheme() on the entire unsplit region including the
excluded address range.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018220253.1582=
38-1-sj@kernel.org?part=3D1
