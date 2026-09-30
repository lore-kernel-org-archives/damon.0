Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833323E7167
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762017; cv=none; b=ajfrlPcfcCIizd9nhP/mzSP6eD53IunRsW0h8Vd3rJ2vcGWCV/D+E1W5819ci8Da4lwTdNYxwsXTGeXRQYiqy+UFXLmFxA5BH3j9tfH+IXWQW8x1xIZdXu77fjMW2nrbGeBrMIPugMh1vwTENAGXFSNjZ3WEj86SYO+FIHHwt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762017; c=relaxed/simple;
	bh=J9z4jtYAHW0vCKp/0q5XOG3GMECoLrjGjBleDGBz3kI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B5nvPRNeNwuLbaBJOCXpzVXZgP3KixK6SR8JHBTfNWgAKWmyLAtiOgfJKYKcuHtITxwJwnSsKi63FUylMcZs8BHEijqx7BUkNkgwj88K1vtgoB+lyCqBSZcfB09dR73an8HOssXSN+MojZ3mgezb97ii3040/9DjJp5g0d+fvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/GAzfPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/GAzfPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B6A1F000FF;
	Wed, 30 Sep 2026 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762015;
	bh=lmNU7mrFL2RzJqncaEfh5yobeJ0LJSXIsGJuiHpVALM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N/GAzfPdeEtVrKjCg6sZVV6mLuqwfk+GTxAs7jH+iOs0nz33z/d1nMhrfmHxQ6ibE
	 UiPu6i8YMUzLKBt0s5pWBA5T3oKyD81GxGWmSFJylUJNRNSDQ6H5txS+rxxqZ8cZkF
	 NghKux/cFdRHIPIL2scLE3Dt9My7G12rNp0Xcr3P7vUGWVFIzRAzGZdPJSWH1d9wU+
	 wl5v+sCjh0MCz4hrW1tGWX8HEc5w4C09oj/zqbwRB8Ko4FSeiRH3niUyx89PBQJqkh
	 Jx0vatUcMIBHwZ3lLdxe2rPE5+r4x2FeHzPYwNSv+wJ71L4DwZxxj7QXlQfMXyz36W
	 0fn8mZwRT6Z6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/core: fix unconditionally skip last
 region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260930092829.45885-1-sj@kernel.org>
References: <2026092948-agency-overhand-3fd1@gregkh>
 <20260930092829.45885-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 09:53:34 +0000
Message-Id: <20260930095335.05B6A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] damon: OOB write and list corruption when damon_split_region_a=
t() fails
- [High] damon: permanent skipping of targets due to charge_target_from sta=
te leak
--

commit 035ce5241b6b256409f7ad3d4de6c01dbe7e8563
Author: Liew Rui Yan <aethernet65535@gmail.com>
mm/damon/core: fix unconditionally skip last region

This patch modifies the skip logic in DAMON to only reset the
charge_target_from state when the last region is reached. It also updates
the function to skip the region only if it is applied or cannot be split,
rather than unconditionally skipping the last region.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 32737cc5f877b..802005d9186e8 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1348,11 +1346,15 @@ static bool damos_skip_charged_region(struct damo=
n_target *t,
>  			damon_split_region_at(t, r, sz_to_skip);
>  			r =3D damon_next_region(r);
>  			*rp =3D r;

[Severity: Critical]
Could this lead to out-of-bounds writes and list corruption if
damon_split_region_at() fails?

This patch removes the early exit condition for the last region, exposing it
to damon_split_region_at(). If memory allocation fails, the split function
returns silently without modifying the list:

mm/damon/core.c:damon_split_region_at() {
	new =3D damon_new_region(r->ar.start + sz_r, r->ar.end);
	if (!new)
		return;
...
}

The pointer is then unconditionally advanced with r =3D damon_next_region(r=
).
If r was the last region, damon_next_region() wraps around to the list
head (&t->regions_list), generating an invalid struct damon_region pointer
pointing outside valid regions. Subsequent writes to this pointer will
corrupt the target sibling list integrity.

> +			skip =3D false;
>  		}
> +	}
> +out:
> +	if (r =3D=3D damon_last_region(t)) {

[Severity: High]
Does the early return inside the region size check bypass this cleanup logi=
c?

If sz_to_skip evaluates to 0 and the region size is <=3D DAMON_MIN_REGION,
the code hits an early return:

mm/damon/core.c:damos_skip_charged_region() {
...
		sz_to_skip =3D ALIGN_DOWN(quota->charge_addr_from -
				r->ar.start, DAMON_MIN_REGION);
		if (!sz_to_skip) {
			if (damon_sz_region(r) <=3D DAMON_MIN_REGION)
				return true;
...
}

Because this early return bypasses the new out label,
quota->charge_target_from remains populated if this occurs on the last
region. For all subsequent targets, the check
if (t !=3D quota->charge_target_from) evaluates to true and indefinitely sk=
ips
those regions, causing targets to be starved.

>  		quota->charge_target_from =3D NULL;
>  		quota->charge_addr_from =3D 0;
>  	}
> -	return false;
> +	return skip;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930092829.4588=
5-1-sj@kernel.org?part=3D1
