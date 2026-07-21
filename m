Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492E2D5923
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610505; cv=none; b=U+Vjq6DZPa+9gwl8P8H45DkCBiAknxlYRlGuuifvsyutY/VDFTNbIheJqhfIh1ghoUnN7qvDZRhxgb8fCjpjEEPvr6QUb9w9OgwZ6NKcnDumLmQY4Zho7lagZxsBVkZVYVTm8/Bk8CUJU1agsCOwrJsi7YmAzZZlwYpBle0t0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610505; c=relaxed/simple;
	bh=sUOwSU+BIilu0cf8u5MNtObB0XYvlWmWlHEZWdCC59k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KGLOsOqMsCw1SOwgzrPzJqK5zLXlIcPo1B/bhZkAUpgi8KdnVT+K7H8jLSV8/qz16aLg7mY4ryI/ne6IUImZNYvA07OfDkwI59BjmzOM40To1DbT/Ci563Orbw0IRNhR4QDAU/K6pWgqqJE56T8DSrKlhWa4mLxpblal2h9jE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsIalHoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsIalHoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685471F000E9;
	Tue, 21 Jul 2026 05:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784610503;
	bh=X3yjATfRXXcGAqk3uZc6FvZqz/Y3kViWWhwkaT6czLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VsIalHoc6jRVragrRMWJ0beh7DejaFHpl6nFsRgsgnXLDMuo9C5HsrRkdhzD0Tr+N
	 VKUZGXUkhLwX7CLxeVn6/PwJ8/1r0Lo/oGhAhDTCyLkwGXH4FI2lXYvJVA4yu3GoW2
	 WFuqalYRWYWUevwMMytdgN6oKpqbIz9RJbO0bANeatmfYcz1rVEXdv20P7kPy9mhlo
	 /JajDE5NyHfqoNbvyQlIEnwhV0SU+IUMJQe3mDAjjb5ZWHOIWNH5q48gycmXPGfzs5
	 ScLLhqK8Q5YZWwEOifoaSx8Z+WBhjBSvBTTQNUaUx3QXFD3GME1TJV3Azj3xUCWEzD
	 A+Dy9t7dHJoSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/core: make charge_addr_from aware of
 end-address exclusivity
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260721045818.157773-1-sj@kernel.org>
References: <2026072059-refocus-lizard-6528@gregkh>
 <20260721045818.157773-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 05:08:22 +0000
Message-Id: <20260721050823.685471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying the local region pointer `r` inside the `damon_for_each_=
scheme` loop causes subsequent schemes to miss the first half of a split re=
gion.
- [High] Regions created by `damon_split_region_at()` are silently skipped =
by the caller's safe list iterator.
- [High] Failure to set `charge_target_from` when the remaining quota is le=
ss than `DAMON_MIN_REGION` breaks the round-robin mechanism and wastes CPU.
- [Medium] The scheme's resume logic unconditionally skips the uncharged re=
mainder of a target's last region when resetting the charge state.
--

--- Patch [1]: [PATCH 6.1.y] mm/damon/core: make charge_addr_from aware of =
end-address exclusivity ---
commit 5e517614c6d1a61febddeb99e7bb671793abbca6
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/core: make charge_addr_from aware of end-address exclusiv=
ity

This commit fixes a bug where charge_addr_from was assigned assuming the
end address is inclusive. It changes the assignment to respect the
exclusiveness of the DAMON region end address.

Link: https://lore.kernel.org/20260428042942.118230-1-sj@kernel.org
Link: https://lore.kernel.org/20260428032324.115663-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d293200d824e9..4b434ebd37c53 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -803,7 +803,7 @@ static void damon_do_apply_schemes(struct damon_ctx *=
c,
>  			quota->charged_sz +=3D sz;
>  			if (quota->esz && quota->charged_sz >=3D quota->esz) {
>  				quota->charge_target_from =3D t;
> -				quota->charge_addr_from =3D r->ar.end + 1;
> +				quota->charge_addr_from =3D r->ar.end;
>  			}
>  		}
>  		if (s->action !=3D DAMOS_STAT)

[Severity: High]
This is a pre-existing issue, but does the safe iterator in
kdamond_apply_schemes() skip newly inserted regions?

mm/damon/core.c:kdamond_apply_schemes() {
    ...
    damon_for_each_region_safe(r, next_r, t) {
        ...
        damon_do_apply_schemes(c, t, r);
    }
}

If damon_do_apply_schemes() calls damon_split_region_at(), it inserts a new
region immediately after r. Because next_r is cached before the loop body,
the newly inserted right-hand region falls into a blind spot and appears to
be skipped for the current aggregation interval.

[Severity: High]
This is a pre-existing issue, but is it possible that reassigning the local
region pointer causes subsequent schemes to miss the first half of a split
region?

mm/damon/core.c:damon_do_apply_schemes() {
    ...
    damon_for_each_scheme(s, c) {
        ...
        if (quota->charge_addr_from && r->ar.start < quota->charge_addr_fro=
m) {
            ...
            damon_split_region_at(t, r, sz);
            r =3D damon_next_region(r);
            sz =3D damon_sz_region(r);
        }
        ...
    }
}

Modifying the loop parameter r leaks to subsequent schemes in the iteration,
causing them to evaluate only the second half of the split region and
completely miss the first half.

[Severity: Medium]
This is a pre-existing issue, but could this logic unconditionally skip the
uncharged remainder of a target's last region?

mm/damon/core.c:damon_do_apply_schemes() {
    ...
    if (r =3D=3D damon_last_region(t)) {
        quota->charge_target_from =3D NULL;
        quota->charge_addr_from =3D 0;
        continue;
    }
    ...
}

When resuming from a previous charge window that exhausted its quota in the
middle of the last region of a target, it looks like this clears the charge
tracking and immediately executes continue, skipping the evaluation of the =
rest
of the region.

[Severity: High]
This is a pre-existing issue, but can this jump break the round-robin
mechanism and waste CPU when the remaining quota is less than
DAMON_MIN_REGION?

mm/damon/core.c:damon_do_apply_schemes() {
    ...
    if (quota->esz && quota->charged_sz + sz > quota->esz) {
        sz =3D ALIGN_DOWN(quota->esz - quota->charged_sz, DAMON_MIN_REGION);
        if (!sz)
            goto update_stat;
        damon_split_region_at(t, r, sz);
    }
    ...
}

When the remaining quota is less than DAMON_MIN_REGION, ALIGN_DOWN results =
in
sz =3D=3D 0. The code then jumps to update_stat, bypassing the charged_sz u=
pdate.
This prevents charged_sz from reaching esz, creating a pseudo-infinite
evaluation loop for the rest of the regions without saving the resume state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721045818.1577=
73-1-sj@kernel.org?part=3D1
