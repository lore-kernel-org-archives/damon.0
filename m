Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0CE4E36C6
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558298; cv=none; b=pWeKjsAVwNiQVnZaW+Tq7AYaHFCeDoUfWBYDFEzsy6/aGPsx3IGEQnEfwdauMhWazwhdfACwNWwNDXDjyQZ0tyMZZYc5gILJQGxlQ9xBqhSBr8mpfDLKO3ZTic4LCocFRl/rB1cXMKelWBkot1h/1TJzRoG22UPS15q0/P9biI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558298; c=relaxed/simple;
	bh=19Za2zHgH1tJffuKLIJWlfSOVh9yY1ArY2covlwu43k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nQofqSZ+U1DZP30YsoYrVQA8JXlTF6LftdHsstHOqaEHwBPAkCbJR+7ULRXe3cJXn8Q7iRpTeXCu68bREqyopPC2qkp/IrqbIc+k1BYFoiyddZoQR0EvWBwY50YSnymFi/nJrtYZ4e5FR1+71CD9U/NesJxtBp9LxLR6JUU1veo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITaCcB/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITaCcB/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C121F000FF;
	Fri,  9 Oct 2026 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791558296;
	bh=MFCZWSzJQLmEnizB4r4SS5Bz6wqPc4kbNu+M1yFYKbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ITaCcB/XQ0A3sWGE1KlN9KMiCI/gqPA5kHj+aG3mjiIFSYXhuSF1QLUK5ByNXefUu
	 D48t4MoKyV5MbIHqIp2XnWFyy1RhNtPi3jyvjHy5JPHljkWmaA5lg9/Em/Zk3ewkgX
	 Qo6XlqKmgOWzOXtSMJyJcpCFoQ2nYegDasJgyb5IPgtZQsmnILkO6yFwN/mdoumQTy
	 XUSBZCcTsGTXKAK7FhlrOuD6DGLwZ5VZ8EBAAMRnJtwkN5Ybx37346z2Mu/iaCvl5F
	 g3PmhHpwVsSbB0qa6hLUwQWLM8YkYmfz+eBmiSzOwGA13J/TVqBNPy2AOkGcUTqIL+
	 xYeYOeaHw2ggQ==
Message-ID: <sashiko-outbox-165748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y v2 2/2] mm/damon/core: fix unconditionally skip
 last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261009144808.18317-3-sj@kernel.org>
References: <2026092949-surpass-thimble-02a8@gregkh>
 <20261009144808.18317-1-sj@kernel.org>
 <20261009144808.18317-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 15:04:56 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/damon: Out-of-bounds access due to unchecked split failure on l=
ast region
--

commit aacf3c387b1624c2944e2e5044dad18623db3d5f
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix unconditionally skip last region

This commit modifies the quota mechanism in DAMON to only reset the charge
target and address from when the last region is reached. It ensures the last
region is not skipped if it has not been processed.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c65d2cbeea6b5..f2f6f125c09b1 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -768,14 +769,11 @@ static void damon_do_apply_schemes(struct damon_ctx=
 *c,
>  		if (quota->charge_target_from) {
>  			if (t !=3D quota->charge_target_from)
>  				continue;
> -			if (r =3D=3D damon_last_region(t)) {
> -				quota->charge_target_from =3D NULL;
> -				quota->charge_addr_from =3D 0;
> -				continue;
> -			}
>  			if (quota->charge_addr_from &&
> -					r->ar.end <=3D quota->charge_addr_from)
> -				continue;
> +					r->ar.end <=3D quota->charge_addr_from) {
> +				skip =3D true;
> +				goto clean_charge_from_skip;
> +			}
> =20
>  			if (quota->charge_addr_from && r->ar.start <
>  					quota->charge_addr_from) {
> @@ -783,17 +781,25 @@ static void damon_do_apply_schemes(struct damon_ctx=
 *c,
>  						r->ar.start, DAMON_MIN_REGION);
>  				if (!sz) {
>  					if (damon_sz_region(r) <=3D
> -					    DAMON_MIN_REGION)
> -						continue;
> +					    DAMON_MIN_REGION) {
> +						skip =3D true;
> +						goto clean_charge_from_skip;
> +					}
>  					sz =3D DAMON_MIN_REGION;
>  				}
>  				damon_split_region_at(t, r, sz);
>  				r =3D damon_next_region(r);
>  				sz =3D damon_sz_region(r);

[Severity: High]
Since this commit removes the check that bypassed damon_split_region_at() f=
or
the target's last region, does this introduce an out-of-bounds access if
memory allocation fails?

If the last region overlaps the charge boundary, it is now passed to
damon_split_region_at(). This function performs a non-blocking memory
allocation that can fail under memory pressure and return silently without
splitting the region:

mm/damon/core.c:damon_split_region_at() {
    new =3D damon_new_region(r->ar.start + sz_r, r->ar.end);
    if (!new)
        return;
    ...
}

If the allocation fails when processing the last region, the region is not
split. The code then unconditionally executes:

    r =3D damon_next_region(r);
    sz =3D damon_sz_region(r);

Because r was the last region and wasn't split, damon_next_region() reads
the list.next pointer which points back to the list head:

include/linux/damon.h:damon_next_region() {
    return container_of(r->list.next, struct damon_region, list);
}

This produces an out-of-bounds pointer derived from the list head. When this
pointer is immediately dereferenced by damon_sz_region(r), could this
regression result in out-of-bounds memory reads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009144808.1831=
7-1-sj@kernel.org?part=3D2
