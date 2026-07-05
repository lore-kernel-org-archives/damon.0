Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665BFC0A
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267931; cv=none; b=YlAGkwrArs/UwQ62gLqWFFfsP+BX2RfHn2J6edW0R9wxOOAsvvaRvtPrkeRy7lcnPRX+SeAtAaCQcD8nAuKMjL1tAmrj54pZNIk8035IGVn4+gYnN1Y0Zffx/Irg1reZUvkirIYR8kV+67FQoT8tbBgrF/zjBt+ezz4l0jkbm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267931; c=relaxed/simple;
	bh=96CEwYnDw09AKP4ogjqTT5h9zTEpxUfEsbTesj49hw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kdQUBh+I9phK0cykenrDzikMDlZq1ZlLH/9whptggrQKH/MVL3PJQsZsAqjYQa7gUFXPmpQKZlTUCek9gMlN+fEP1o5/T9/FHKBugjEvQmK+SYwiW98pVILbGcwoLtCvV5uOVG4TqJCnm/whH5Cl3fJzRQBbmnP/72EPuzx0u/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqCktwxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqCktwxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E286A1F000E9;
	Sun,  5 Jul 2026 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267930;
	bh=D7sClcZ4OIb3AlHm1ho1tRR9/IhD6aTzmWDv4y7d4hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gqCktwxgR9wr8CY+ROljBtsEG8gePsWzW4oml2zHsFBOq//udQFDlLyiKEvKVvLR0
	 D1XDpi6wTxcyjnAn0LzEpPrePCzoMrIIuiqbx+9wvLV/CAcftW13R2cpawq4pQIcxz
	 LiIcC1Cs/FK+UwB62WZgA/oo7iqVJY7yH1JONEUqSYpauNbNwvGgb1unwAxB9sLpYc
	 qNVZA+/wTtj7vL8J0idplqm9zmQ5B5pWZwUgZ8ywRegOkJBnXpYMsuVK5LNNnuOSTZ
	 tvrMyswU+LBWVtpyK6dGbh1bKSz65y8JTKAwCY4UzXf3vI9g+xkPVIuYhvJmL4HgVn
	 4dY8pAAHGPhDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] mm/damon/reclaim: remove duplicated min_region_sz
 power of 2 check
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705155600.96555-5-sj@kernel.org>
References: <20260705155600.96555-1-sj@kernel.org>
 <20260705155600.96555-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 16:12:09 +0000
Message-Id: <20260705161209.E286A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] State Corruption on Error Path: invalid `addr_unit` permanently co=
rrupts global monitoring region parameters.
- [Medium] API Contract Violation: `ALIGN` macros are invoked with non-powe=
r-of-two inputs, computing garbage values.
--

commit f2a479c4ed9e6eb22e5e61615eb62f684e1703b1
Author: SJ Park <sj@kernel.org>

mm/damon/reclaim: remove duplicated min_region_sz power of 2 check
   =20
This commit removes the power-of-two validation for min_region_sz in
damon_reclaim_apply_parameters(). The change relies on the assumption
that identical validation in damon_start() and damon_commit_ctx() is
sufficient to catch invalid parameters.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 11b70d0a9a6f0..6469b25cc34f9 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -208,11 +208,6 @@ static int damon_reclaim_apply_parameters(void)
>  	param_ctx->addr_unit =3D addr_unit;
>  	param_ctx->min_region_sz =3D max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> =20
> -	if (!is_power_of_2(param_ctx->min_region_sz)) {
> -		err =3D -EINVAL;
> -		goto out;
> -	}
> -

[Severity: High]
By removing this early check, does an invalid addr_unit now proceed to call
damon_set_region_system_rams_default() before damon_commit_ctx() rejects it?

If so, could this permanently corrupt the global monitor_region_start and
monitor_region_end parameters on the error path?

For example, damon_find_system_rams_range() scales and overwrites these
global pointers before the context validation has a chance to fail:

mm/damon/core.c:damon_find_system_rams_range() {
	...
	*start =3D damon_res_to_core_addr(arg.res.start, addr_unit);
	*end =3D damon_res_to_core_addr(arg.res.end + 1, addr_unit);
	...
}

[Severity: Medium]
Additionally, if we allow a non-power-of-two min_region_sz to be passed
downwards, does this violate the requirements of the ALIGN macros?

When damon_set_regions() processes the temporary target structure:

mm/damon/core.c:damon_set_regions() {
	...
	start =3D ALIGN_DOWN(ranges[i].start, min_region_sz);
	end =3D ALIGN(ranges[i].end, min_region_sz);
	...
}

Since ALIGN relies on bitwise operations, won't passing a non-power-of-two
min_region_sz result in garbage address calculations?

>  	if (!damon_reclaim_mon_attrs.aggr_interval) {
>  		err =3D -EINVAL;
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705155600.9655=
5-1-sj@kernel.org?part=3D4
