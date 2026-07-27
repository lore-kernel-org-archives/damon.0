Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07963BE17B
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163725; cv=none; b=m2nQHDIftmdfdHYhnbEk/EJCqn/rGT8fFQjKGTa9AmJl+EevVP1ShPnYCUhv5J2YX5k0w7njX7KC1TI1MZ5Jy1VnoHbRhpntyI0HhnF55c+aBB8H3ajcnzN+tU5BTSgeoNnrAQjqeP7Zx3lC5Pbxk+/HX7flb1HrCxEzOjdZslg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163725; c=relaxed/simple;
	bh=xQPB4EF0IT5RSa7jFA79FXm2VAd++RP4KxF1b9bWeMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lLZt09v74EiEfBXQrzb8Zm767janFpWimnQQpk7FDPCIHslvRjJhdaKVTSM3p5ScwXSml12EK/pBPr2Eend1LBP8fqxle+EbiRZmER9vz22MF7c9/4ybuB1DUb9pwA8V9t7jM29fIzFh7xPVROTwf+3f/c27oFidcOPWiz8tVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxwkdbFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxwkdbFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5101F000E9;
	Mon, 27 Jul 2026 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163723;
	bh=cESFmwZQZ++pBqgcsVqWvsQXd0elkJ2PS1tUV647/OQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IxwkdbFATOO9eiX9Toks0zi5XDQuanV4xgzn+WSPthwBJXHA3PLIYuQEO20hclxHL
	 V60Kw9zOW2fO19g3Wjs256NczdgRdy5EBvhaM05ebsE7naM5Wv6RYUV0UpbthRLW5l
	 4oKBhh69MlTkvgsIPo1+IqnlC7r3yYix2CX8ZmR4apJl+TkNHgBzGju3FLZKxQ7VT3
	 1GfKYfDRusAM0O1sdUHBigrsZq+qOQdxXCxzA4JjNHVzyHAc/y/UVPXeSuaVi8TaBA
	 7/JYmRYqAm/F24eHFZKR99d6QK6GFp56YYLn2tKqEMauXIJsaYgg+YDweopR8gDslv
	 88SgO+uK32iiA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 05/17] mm/damon/core: introduce damon_prep
 struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260727143829.86236-6-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
 <20260727143829.86236-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:48:42 +0000
Message-Id: <20260727144843.2F5101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] damon_commit_probes() does not synchronize the newly added 'prep=
s' list, leading to lost preparation actions during context updates.
--

--- Patch [5]: [RFC PATCH v2.1 05/17] mm/damon/core: introduce damon_prep s=
truct ---
commit 560f806438365d13be862eb2266c647b1d981d0b
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_prep struct

Some DAMON probe filter types require preparatory actions, like setting
the PG_Idle flag at a specific time. This commit introduces a new data
type called damon_prep to specify preparation actions for each probe.
It also adds DAMON_PREP_SET_PGIDLE as the initial prep action.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a8bb9ee6979e3..1a8de735f955b 100644
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
Does this change also require an update to damon_commit_probes() to copy the
new preps list?

Currently, when updating a running context, damon_commit_probes() only copi=
es
the weight and filters from the source probe to the destination probe:

mm/damon/core.c:damon_commit_probes() {
    ...
    damon_for_each_probe_safe(dst_probe, next, dst) {
        src_probe =3D damon_nth_probe(i++, src);
        if (src_probe) {
            dst_probe->weight =3D src_probe->weight;
            err =3D damon_commit_filters(dst_probe, src_probe);
    ...
}

This applies both when synchronizing existing probes and when creating new
ones to match the source context.

Without a corresponding damon_commit_preps() mechanism to synchronize these
lists, it appears any preparation actions configured on a source context co=
uld
be silently lost when committed to a running destination context.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727143829.8623=
6-1-sj@kernel.org?part=3D5
