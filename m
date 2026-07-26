Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2E3DA5D9
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785088350; cv=none; b=s/SJqJ1whqVhA5e02dDdxNZWb15/QuVWiLeLfX7OLGDDYdY2imJ7V3sXDDSAyuygPLO5ItfA85f7yMhYKPtyGv66yXMWSQJSluBsYlrzfVWm40JZhA2jQHj4bgFdw1QY7Y66YIR2zyq/rEhvc0fzEyu61zJqYLHM3zNftYzYKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785088350; c=relaxed/simple;
	bh=BYO0uA7FyBkP1ofbaiKfDWf7MRU+4KsdO3PNQ+axCMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QlKl+QFmRtFVvoGi4cpwFAA9xg7tMN2jCWa9ctjm/GRnY+zcRpUdK+flblMKKF73qg/kA6OV5BLFORCmFfBgcZnUg2yIYkYUCgRMMw89/wkfZoSo0YZKZN5S0I+Y9wu/9nNsqJ1uUn/4/ABZDZBIvfKGFCr6XjyuS5Z+AZNG1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fanqjUdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fanqjUdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD7A1F000E9;
	Sun, 26 Jul 2026 17:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785088348;
	bh=rx/gS0Q+EwUXuVjjqd2PQfhtolE/iil6uZfMuBNCzYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fanqjUdxgmhAKKgpZ/Vg/eiWXCfAXBTI4RZ+jQ/EAvTM0ow+rIu0wFqUDj3JZ0LkA
	 UxGZlARR42/0CArPQh5C2t1ebifQfGgjJVKBaCOyV9JeaUDnPH/6CQEr/0AB5iNjhR
	 4CSV7Oh9uLcKZgrP28WtIdz+MVUEuS3YoNWV30kMcdoW23USD7ahc0007l2lrmm1jP
	 qq0Yndh3C3WLyEC9D+GLQ6ik/TZTXA22VnryCwcS7NckY2RihqhMH1Svzaf/QjjI07
	 sdaAbEIAoz4OkwMTOxNpOgzFcA1BvTRwoaUiIuEv21WBvE4n1bKiXGHdw1mziiXd5B
	 lOpTTsALv8FTQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/17] mm/damon/core: introduce damon_prep struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260726173935.94046-6-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
 <20260726173935.94046-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:52:27 +0000
Message-Id: <20260726175228.3CD7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing synchronization of the `preps` list during DAMON context=
 commit operations.
- [Low] The parameter names in `damon_for_each_prep` and `damon_for_each_pr=
ep_safe` are reversed compared to their semantic meaning.
--

--- Patch [5]: [RFC PATCH v2 05/17] mm/damon/core: introduce damon_prep str=
uct ---
commit 9f7bafc6bbe2ee2b7391d751512d413fcf3bdf98
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_prep struct

This commit introduces a new data type damon_prep to specify preparation
actions for DAMON probes. It adds lists and iteration macros for these
actions, as well as an initial action DAMON_PREP_SET_PGIDLE.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a8bb9ee6979e3..24b362fcf53b1 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h

[ ... ]

> @@ -780,6 +801,8 @@ struct damon_filter {
>  struct damon_probe {
>  	unsigned int weight;
>  /* private: */
> +	/* Preparation actions to apply to each probing memory. */
> +	struct list_head preps;
>  	/* Filters for assessing if a given region is for this probe. */
>  	struct list_head filters;
>  	/* Siblings list. */

[Severity: Medium]
Since this patch introduces the preps list to struct damon_probe, should
damon_commit_probes() in mm/damon/core.c be updated to synchronize this new
list?

Currently, damon_commit_probes() copies probe parameters and filters, but
it appears to omit the preps list. If a context is updated via
damon_commit_ctx(), wouldn't any configured preparation actions be silently
dropped for new probes, and existing probes fail to update their preps list=
s?

For example:

mm/damon/core.c:damon_commit_probes() {
    ...
    damon_for_each_probe_safe(dst_probe, next, dst) {
        ...
        err =3D damon_commit_filters(dst_probe, src_probe);
        ...
    }

    damon_for_each_probe_safe(src_probe, next, src) {
        ...
        new_probe =3D damon_new_probe();
        ...
        err =3D damon_commit_filters(new_probe, src_probe);
    }
    return 0;
}

[ ... ]

> @@ -959,6 +982,12 @@ static inline unsigned long damon_sz_region(struct d=
amon_region *r)
>  	return r->ar.end - r->ar.start;
>  }
> =20
> +#define damon_for_each_prep(p, prep) \
> +	list_for_each_entry(p, &(prep)->preps, list)
> +
> +#define damon_for_each_prep_safe(p, next, prep) \
> +	list_for_each_entry_safe(p, next, &(prep)->preps, list)
> +

[Severity: Low]
Are the macro parameter names here reversed compared to their semantic mean=
ing?

The parameter 'p' is used as the list iterator (which represents a prep), a=
nd
'prep' is used as the parent structure (which represents a probe). This dif=
fers
from the convention used in damon_for_each_filter(f, p).=20

Will this force usage like damon_for_each_prep_safe(prep, prep_next, p), wh=
ich
could be confusing to callers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726173935.9404=
6-1-sj@kernel.org?part=3D5
