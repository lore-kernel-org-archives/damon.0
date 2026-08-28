Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490E36F8E5
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907854; cv=none; b=ObbyIrNQoQRI0KUuQDMHJMkslyCRgiohXF9I7ggrmM/sGvT2xNUxrPQ0vHUgDmMMZtFl22qUnXI+dPgVHRQFHq/xsKOrm24QX1WjmnDS7m2VtpY6FN/QNJJIlxGoAkqqLB+t+aYg70fbjXxvgDw2JXIL6i4oD9jEsJ/l4x2yj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907854; c=relaxed/simple;
	bh=eAgdbhRDlq9PkU4nm0IYL42BywBHbmhydjnWEVKyxdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z5XgDb1ziJDcQ5N/0wQaMweJt1U2q+XWnp7VjfY3+bHnRgs7opTfN4XTi5IjCih+ui5qcxt+qKGewmVvixCs4qhQn2five89Wkpqi8uKs6RA5WOgE+/Z4QY2BBQcyVEG9aQjfeIlB1UrlbyLOQ/EuU6vKVJgTbmjzUYWd7qN1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS19ZhPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS19ZhPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AEA1F000E9;
	Fri, 28 Aug 2026 09:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787907850;
	bh=AKFbLIQAq4IpbT30LkrAp6G+TPsCd1qt7AlP1yye5BQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oS19ZhPVXwXXNukAi217QJeVBaM7yPG7a8qOf3JF5YpS4PhjV8B/i1PDSsJSRv1C+
	 AIDJn8X3+rtU98f+YO0NwUXST1u5lg76Hea2i9IwAU05zQMJkvRQsnA/BWzlYvmuVh
	 G/oDNIsBUYi1lMbnoanXLsitI8guuFU3bWCdltpH+tNNUX8p5YMD7dTlT7FMUscVNG
	 czd46wgiisgu1LyLvFQaFaB+8eR3eDYwW+/+cZVnJ34puJLrgRMIWNt5ixLd4A6+9Z
	 1O5A4CO304DOkGLALyGt2tPTUTzbO72aZu8iMcjqx3H73tdJemPQi/4xfyh6a41c4b
	 hKUIsBAKzUq8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: fix unconditionally skip last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260828084737.290024-1-aethernet65535@gmail.com>
References: <20260828084737.290024-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:04:09 +0000
Message-Id: <20260828090410.40AEA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a logic error that can permanently leak `quot=
a->charge_target_from` if a target's last region straddles `charge_addr_fro=
m`. This causes DAMOS to permanently skip the target and all subsequent tar=
gets, effectively disabling the scheme.
--

commit b16b899bcf256d33234a0a128af51071c5723a6e
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon: fix unconditionally skip last region

This commit modifies damos_skip_charged_region() to only skip the last regi=
on
after it has been applied, rather than unconditionally skipping it and
resetting the cursor. It achieves this by moving the last region reset logic
into the condition checking if the region has already been fully charged.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..21dc6b086c42f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2347,14 +2347,15 @@ static bool damos_skip_charged_region(struct damo=
n_target *t,
>  	if (quota->charge_target_from) {
>  		if (t !=3D quota->charge_target_from)
>  			return true;
> -		if (r =3D=3D damon_last_region(t)) {
> -			quota->charge_target_from =3D NULL;
> -			quota->charge_addr_from =3D 0;
> -			return true;
> -		}
>  		if (quota->charge_addr_from &&
> -				r->ar.end <=3D quota->charge_addr_from)
> +				r->ar.end <=3D quota->charge_addr_from) {
> +			if (r->ar.end =3D=3D quota->charge_addr_from ||
> +					damon_is_last_region(r, t)) {
> +				quota->charge_target_from =3D NULL;
> +				quota->charge_addr_from =3D 0;
> +			}
>  			return true;
> +		}
> =20
>  		if (quota->charge_addr_from && r->ar.start <
>  				quota->charge_addr_from) {

[Severity: High]
If a target's last region straddles quota->charge_addr_from (meaning
r->ar.start < quota->charge_addr_from but r->ar.end > quota->charge_addr_fr=
om),
does nesting the damon_is_last_region() check strictly inside the
r->ar.end <=3D quota->charge_addr_from condition cause it to bypass the res=
et
logic entirely?

Because the unconditional r =3D=3D damon_last_region(t) reset at the start =
of
the function was removed, the code now proceeds to the next block where it
attempts to skip the prefix:

    if (quota->charge_addr_from && r->ar.start <
            quota->charge_addr_from) {
        sz_to_skip =3D ALIGN_DOWN(quota->charge_addr_from -
                r->ar.start, min_region_sz);
        if (!sz_to_skip) {
            if (damon_sz_region(r) <=3D min_region_sz)
                return true;
            sz_to_skip =3D min_region_sz;
        }
        damon_split_region_at(t, r, sz_to_skip);
        return true;
    }

If the prefix length is smaller than min_region_sz and
damon_sz_region(r) <=3D min_region_sz, or if the subsequent
damon_split_region_at() fails due to -ENOMEM, the function returns true ear=
ly
without splitting and without clearing quota->charge_target_from.

Does this permanently leak quota->charge_target_from?

If the function returns true early without clearing quota->charge_target_fr=
om,
the region loop in damos_apply_target() would naturally terminate since it =
is
the last region, leaving the cursor permanently pointing to the current tar=
get.

In subsequent time windows, could this leaked target repeatedly trigger the
same early return, causing all other targets to be skipped permanently
because t !=3D quota->charge_target_from?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828084737.2900=
24-1-aethernet65535@gmail.com?part=3D1
