Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5042EEE9D
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606816; cv=none; b=J72B/9EuKRpe8OZNhi6a6x5O0atgoyX3DtRhiRINrryaxBKE5zOskewkjXSu1DGF8i7LI0D8tE89P2unTV41yQgHbhBhgZuim5IMs5jGhvcdDhjIk4isa3B8Wjag3WvmcNVIVw5KZLTfL9smWtztqhjij6R+qP8hsyATkz986Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606816; c=relaxed/simple;
	bh=B7QkQEpAKvmJBCzXEpOaoxiX7btj26P3jwiHOr0jy18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bLJy4q/0WgvgJiTe05DskrLmfsPgTa4J+pBNK1n0wqCwqZZIPlLJ87M+vGvdltu45BGNY2e7tmiOsESpdLpwXY00OJa3qoYuVvJwLj0TMuLu3NSrHPUisg+Hmvxmfc9Qvods/8y/82GkcTIilAaqzE0fGtxCyxeVWRR4zUZ+5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3lCRmhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3lCRmhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7E21F00AC4;
	Sat,  1 Aug 2026 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785606815;
	bh=1wO6wm3F674wRhW1MCA6k0MGc14e6wX7eBvZaGDgSh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c3lCRmhOUh4fNr06qZ0jqYQllZvjHC6pCYWxMDnevHoz+Y0HDLEWiVuMdWp+KR0LF
	 B+TAqO9GJVmE4jdCjJFXpamWDUNOD14dQVHUh0hCCRNjOinelkelEMNONjcKC5ysux
	 xlnjAZxcuc2bXKsV18AgEVXsEEWMXSXfrJoslLHN2U80RkSgNCFFgMwZgcKDW94CgI
	 XA8tQYMVAeA35fdIxQh9m70182RJQMao39f1HNaXdcnUzKuVPLO5yUqpk1bMuTKX6I
	 Gf9oJMwEn4pKEsyEdjX3Sf6c/0avXKueqRyLQ6J6OyiOI5ktGkWsQwmFZ9NQ2UkWY7
	 PgxkmxBwRymlQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/9] mm/damon/core: skip applying scheme if region
 split for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260801173554.94710-2-sj@kernel.org>
References: <20260801173554.94710-1-sj@kernel.org>
 <20260801173554.94710-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 17:53:34 +0000
Message-Id: <20260801175335.2D7E21F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled failure of damon_split_region_at() in damos_filter_match=
() leads to bypassing or incorrectly applying address filters.
--

--- Patch [1]: [RFC PATCH 1/9] mm/damon/core: skip applying scheme if regio=
n split for quota fails ---
commit 812934b542c69c596afadb66403f8c9c11c5bf91
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip applying scheme if region split for quota fails

damos_apply_scheme() splits a region and apply the action to the
subregion if it is needed for not violating the quota.  The split
operation (damon_split_region_at()) could fail for allocation failure.
In the case, the quota could be violated.  From the user's perspective,
DAMOS becomes more aggressive than expected under the extreme situation.
Handle the failure.

Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..e2900d0c984c9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2613,7 +2613,8 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  					c->min_region_sz);
>  			if (!sz)
>  				goto update_stat;
> -			damon_split_region_at(t, r, sz);
> +			if (damon_split_region_at(t, r, sz))
> +				goto update_stat;

[Severity: High]
This is a pre-existing issue, but since we are handling the failure of
damon_split_region_at() here, should we also handle it in
damos_filter_match()?

If a memory region partially overlaps a filter range and the split
allocation fails in damos_filter_match(), the return value is ignored:

mm/damon/core.c:damos_filter_match() {
    ...
		/* start before the range and overlap */
		if (r->ar.start < start) {
			damon_split_region_at(t, r, start - r->ar.start);
			matched =3D false;
			break;
		}
		/* start inside the range */
		damon_split_region_at(t, r, end - r->ar.start);
		matched =3D true;
		break;
    ...
}

If the split fails, the intact region spanning both outside and inside the
filter range is unconditionally evaluated as 'matched =3D false' or
'matched =3D true', incorrectly bypassing the filter or applying it to unre=
lated
memory outside the intended range.

Could this lead to destructive actions (e.g., PAGEOUT) being applied to
explicitly protected memory?

>  		}
>  		if (damos_core_filter_out(c, t, r, s))
>  			return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801173554.9471=
0-1-sj@kernel.org?part=3D1
