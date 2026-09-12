Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438FB3845D8
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241802; cv=none; b=OXM8olm7XYi1TptYbFVHU6k5i//6ChD8Mzd34yZg62Bvn3jbOWnAR8xhyp5MulakiLvwPNkCOruMb9RxBFayRrdrx56ONLbhzK7oDoytjTQS9pJcIxIVQfgsfroJih5ZyRWuaFGf1yYenXKLXyeyf74jBfnyKD/ZSFLaeTbaBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241802; c=relaxed/simple;
	bh=2QGcNHyN6+NgRL5RLyvRi7EeyNMkg6IyB0bwJQN9bys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U8LyQKU4x5ka9jiGyLkFclzPSJG7w4grIankJC8KKsndXCktelVOXCdx00xDVkyNzpCHRkRBjeqUxa6TZ5mgBqca30JMVx2SX2qWA/4aLCwtWwQDBgtjrScaBqgXdllqtj4wGhMYC3KdFhxOvNjhTorb+3ulTRpNduF7u/j2hDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SscsY2dD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SscsY2dD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AF61F000FF;
	Sat, 12 Sep 2026 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789241801;
	bh=i9S8r4zmURcYhDxc/uTSELlxt4/jIsLyn2UsV2c267g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SscsY2dD3KdofjkWOfFUo7dQXk7BFKK2MhqhVa+8Uq63ZKz69Z5khqCB8ap/9jUFV
	 WpJwpHLF4Oa5nErVtnB99kc0y/eFSd9i8rEFyRLYZnPQ8FJgrcb2m47zGzIdk4iD/2
	 qXrhr5fKmWUbnVJO6RccTI8miONTOBljVenUQKpC8kUjREIqZYy7q+yDInJvxSwfz0
	 NXP+yaRabQre7yjJhuOe/nr9K0/SdI9w54ZyBjt44aSRnhlZ9enin9MXyg/wNxx67I
	 ASuszpGSQxRua5zkmANuuXCxbYpOCg68iZDQkEwg+J/7LlIDI0NcipVfixe2Lrdvua
	 X8GabTgb5OKGQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/8] mm/damon/core-kunit: test invalid damos filter
 commits
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912191807.138502-9-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
 <20260912191807.138502-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 19:36:40 +0000
Message-Id: <20260912193641.04AF61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing error handling for damos_commit_filter_arg() and damos_com=
mit_filter() leads to uninitialized memory use for DAMON filters.

Pre-existing issues:
- [Critical] Memory allocation failure during damos_commit_dests() leaves t=
he active scheme object partially torn down, leading to a deterministic NUL=
L pointer dereference.
--

commit 0ffd278b1f3947b2729c57dd026fc9283304d3af
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: test invalid damos filter commits
   =20
Add test cases for testing the validation of damos filter arguments in
commit time.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 2b0931cf6fb32..527abc2570616 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1184,6 +1184,13 @@ static void damos_test_commit_filter(struct kunit =
*test)
>  			.allow =3D false,
>  			.sz_range =3D {.min =3D 234, .max =3D 345},
>  			}, false);
> +	damos_test_commit_filter_for(test, &dst,
> +			&(struct damos_filter){
> +			.type =3D DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
> +			.matching =3D false,
> +			.allow =3D false,
> +			.sz_range =3D {.min =3D 456, .max =3D 123},
> +			}, true);

[Severity: High]
Does this patch series leave uninitialized memory in the payload of DAMON
filters if an invalid range is provided?

While this patch adds tests for invalid filter ranges, it appears the error
handling in earlier patches of the series might be incomplete. If a user
provides an invalid range (e.g., max < min) via DAMON sysfs, the core
validation returns -EINVAL, but this error is ignored when allocating a new
core filter:

mm/damon/core.c:damos_commit_core_filters() {
    ...
	damos_for_each_core_filter_safe(src_filter, next, src) {
		if (j++ < i)
			continue;

		new_filter =3D damos_new_filter(
				src_filter->type, src_filter->matching,
				src_filter->allow);
		if (!new_filter)
			return -ENOMEM;
		damos_commit_filter_arg(new_filter, src_filter);
		damos_add_filter(dst, new_filter);
	}
    ...
}

Similarly, the return values of both damos_commit_filter() and
damos_commit_filter_arg() are ignored when updating or allocating an ops
filter:

mm/damon/core.c:damos_commit_ops_filters() {
    ...
	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
		src_filter =3D damos_nth_ops_filter(i++, src);
		if (src_filter)
			damos_commit_filter(dst_filter, src_filter);
		else
			damos_destroy_filter(dst_filter);
	}

	damos_for_each_ops_filter_safe(src_filter, next, src) {
		if (j++ < i)
			continue;

		new_filter =3D damos_new_filter(
				src_filter->type, src_filter->matching,
				src_filter->allow);
		if (!new_filter)
			return -ENOMEM;
		damos_commit_filter_arg(new_filter, src_filter);
		damos_add_filter(dst, new_filter);
	}
    ...
}

Since damos_new_filter() allocates with kmalloc_obj() (which does not zero
memory), ignoring the return value of damos_commit_filter_arg() could lead =
to
the uninitialized heap data remaining in the filter's payload
(e.g. sz_range or addr_range) when it is added to the active DAMON context.


[Severity: Critical]
This is a pre-existing issue, but can memory allocation failure during
damos_commit_dests() leave the active scheme partially torn down and lead t=
o a
NULL pointer dereference?

If memory allocation fails for dst->weight_arr, damos_commit_dests() leaves
dst->nr_dests with its old non-zero value, but assigns NULL to the array:

mm/damon/core.c:damos_commit_dests() {
    ...
		dst->weight_arr =3D kmalloc_array(src->nr_dests,
			sizeof(*dst->weight_arr), GFP_KERNEL);
		if (!dst->weight_arr) {
			/* ->node_id_arr will be freed by scheme destruction */
			return -ENOMEM;
		}
    ...
}

Because damon_commit_schemes() breaks its loop on -ENOMEM and returns, the
partially modified scheme is left physically linked in the live context's
scheme list:

mm/damon/core.c:damon_commit_schemes() {
    ...
		src_scheme =3D damon_nth_scheme(i++, src);
		if (src_scheme) {
			err =3D damos_commit(dst_scheme, src_scheme);
			if (err)
				return err;
		}
    ...
}

When the kdamond worker thread later executes damos_va_migrate_dests_add() =
on
this corrupted scheme, it appears it will iterate up to dests->nr_dests and
dereference the NULL weight_arr pointer:

mm/damon/vaddr.c:damos_va_migrate_dests_add() {
    ...
	for (i =3D 0; i < dests->nr_dests; i++)
		weight_total +=3D dests->weight_arr[i];
    ...
}

Is there a mechanism preventing this kernel panic if memory allocation
fails on the live destination context?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912191807.1385=
02-1-sj@kernel.org?part=3D8
