Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D273BCD21
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762713; cv=none; b=cC5QnjfbVzEvrhXsV7RU5kWZWChgoCOfhEU0liaEYsDI7m3hhFcPTbBzyZTuEBc+SznGR9ptzWn+dqIY+fsy4F7TVC4rceBoCzIza0km6r8yrMWX2bGX+Smiwi5KbM+b2BDLAiEsa0ryGhVOQkcEGC9OJQeP+slol9u8zxftYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762713; c=relaxed/simple;
	bh=/xZpJfc+MMT2Go4zzAz9fySPVHyXU0eBmCEs+HKZav4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZhYulkmEbPNvPTe4KBqC7R5b4lcH2grli37B0V47rKmL9oDysQOr3OegqbEAREWPHxz9HcCXiHFIKET/i8G8qh4c73/4vYyzr5b8yyzDjXVveapG27Jt60aSVqtnV2+IdV5KCq2RjKzfeODDFn4svGSqUDolzJQMcVMT2F7I88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3Kvy3AX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3Kvy3AX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E731F00898;
	Wed, 30 Sep 2026 10:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762711;
	bh=M9cs0wUyVUHRNVJ8d2aHZYaTOKu1rdeWKBuaXg4P4hs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X3Kvy3AXZMXQc8/I1SnFlWcKCvlaKkQISjxPYiqLfPfaAgZ7C22xQ69IqdtQ26kzD
	 sM/nLWXKMhQcVuu3lBr6PqWrMBwj2T+L5VZYax6BLSFkRs6qfELo+nXamegx1tqNHC
	 8mVRD0lhyg1RjMkX00xp2d4awGhuKpnaZmeEdQjiOP0n5zYvJc++wS1I3+PnnQF1Os
	 FLZw8CHhSMi59gejhNJp/hHx0YHAcEldsnIFaiO+ETytXib7bPrQA0yrsYskBe3XcP
	 Y2T9yfNs8UkvEgOiUmZjxsQGr5xqzF+78iAqIyh4qevYizJ9iCWVtZV4cipcMIZOnM
	 50jO0l/uLpisQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/core: fix unconditionally skip last
 region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260930094853.52736-1-sj@kernel.org>
References: <2026092949-surpass-thimble-02a8@gregkh>
 <20260930094853.52736-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:05:10 +0000
Message-Id: <20260930100511.53E731F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/damon: out-of-bounds memory access when region split fails on l=
ast region
--

commit e8c0d519ccfab8bb3783274c1139b24ab75f8aa1
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix unconditionally skip last region

This commit fixes an issue where the last region of a target is
unconditionally skipped and reset when a quota is set, even if it hasn't
been processed.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 859a6a636ab0e..64ff03b15fdef 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
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

[ ... ]

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
Since this patch removes the early check for the last region, what happens
in damon_do_apply_schemes() if damon_split_region_at() fails on the last
region?

If damon_split_region_at() fails under memory pressure, it returns silently
without splitting the region. The code then unconditionally calls
r =3D damon_next_region(r).

Because r was the last region and was not split, its list.next points to the
list head. damon_next_region() then returns an invalid pointer.=20

The next line calls damon_sz_region(r), which dereferences this invalid
pointer and causes an out-of-bounds memory access.

Does this code need a check to ensure the region was successfully split bef=
ore
advancing the pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930094853.5273=
6-1-sj@kernel.org?part=3D1
