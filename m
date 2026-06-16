Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B21A682B
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623624; cv=none; b=hf5Sm91oOp8W+ASZ/OOPkVK4XxBcGAQ8mwD/yTWWsZ220psIGNvN8tJJPYYi4/q/cs4Wt2IIbKF2/ye2hZW6RsCXSa9BK33FMRXKcNEmSlevCn3qk2mj6L+xo2ID9g4SQC7bIdKUEGCOP9crPw9i9nLPPNA6Q8RBgxbruDxIHq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623624; c=relaxed/simple;
	bh=rwVKdxVwNhRqovEEZ2N7YQAOMbhwU9nNxY4JnkSKRig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N+fy38NC+ESglBG+KJ/vVHgW7uck4lBHJpTmOzCujVmaUY11JZufgkbiyASdg2UJAMaAi7Z4g2t2vOf3EKUSJ61HmVxWzlq6lZaI4p0PCjc92Mvo5f8cdPu8pcPNnlbZp6ENwoyrymB/C30CRKqZ57RxJUSo2kA+n7BWrzqsFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx0k/2a3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx0k/2a3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D771F000E9;
	Tue, 16 Jun 2026 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623623;
	bh=k3bJ0DpPaXEzNdjnj0VovFQYBEVWFEp4IJqtlRu1nOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bx0k/2a3sKMexOQaV0REEMr+CuwrSU5FSvZlbA5g89VVJ2hp9G8mBvZ8NJCEjlmiS
	 rkUFZ5BMkjKOSybEYdortVSr2YO7cps8B4sWpiPCOpQPfbdPy5wVv2O+LR5kGfpKnD
	 FnNPUNEI3e87E9qPpEtipe8/Dx+S4l9UuCpp8vcLH/8jsqZOSykOsBYjD0XTz2lVSp
	 7ebtFqhBZFGKpqS8OTi26uwSDsG8jJSJNY6J3x+nBFf/fGDCSqYe+mM2yr624O4ZiU
	 2NkLb9w5mRaSZofwy7fN4gCPO3F4y4/4tXfMeXSFy7AFQpEMcpISh7CDD6WxSuc2Jx
	 DQ+hjDZ5nbXXg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/9] mm/damon/sysfs-schemes: kobject_del() scheme
 dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150844.88305-4-sj@kernel.org>
References: <20260616150844.88305-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:27:02 +0000
Message-Id: <20260616152703.04D771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect `goto` ladder in `damon_sysfs_scheme_add_dirs` causes an=
 uninitialized pointer dereference and a memory leak of the `stats` kobject.
- [Medium] Missing `kobject_del()` in the `out:` error paths of `*_add_dirs=
()` loops leads to delayed sysfs directory removal and name collisions.
--

commit a283ef4fe4b682b7b66cf9b57221cb6884b386cc
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: kobject_del() scheme dirs

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme directories by adding kobject_del() calls.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 329cfd0bbe9f3..37cf6edb54f17 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2686,6 +2686,7 @@ void damon_sysfs_schemes_rm_dirs(struct damon_sysfs=
_schemes *schemes)
> =20
>  	for (i =3D 0; i < schemes->nr; i++) {
>  		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
> +		kobject_del(&schemes_arr[i]->kobj);
>  		kobject_put(&schemes_arr[i]->kobj);
>  	}
>  	schemes->nr =3D 0;

[Severity: Medium]
This isn't a bug introduced by this patch, but since we are fixing delayed
sysfs directory removal here, do we have the same name collision vulnerabil=
ity
in the error paths of our *_add_dirs() loops?

If kobject_init_and_add() succeeds for a scheme, but damon_sysfs_scheme_add=
_dirs()
fails, the error path drops the reference without calling kobject_del():

mm/damon/sysfs-schemes.c:damon_sysfs_schemes_add_dirs() {
    ...
		err =3D kobject_init_and_add(&scheme->kobj,
				&damon_sysfs_scheme_ktype, &schemes->kobj,
				"%d", i);
		if (err)
			goto out;
		err =3D damon_sysfs_scheme_add_dirs(scheme);
		if (err)
			goto out;
    ...
out:
	damon_sysfs_schemes_rm_dirs(schemes);
	kobject_put(&scheme->kobj);
	return err;
}

Under CONFIG_DEBUG_KOBJECT_RELEASE, would the delayed kobject_release
callback leave the "%d" directory around temporarily, causing -EEXIST
if the user immediately retries?

The identical pattern appears to exist in damon_sysfs_targets_add_dirs(),
damon_sysfs_contexts_add_dirs(), and damon_sysfs_kdamonds_add_dirs().

[Severity: High]
This is a pre-existing issue, but there appears to be an uninitialized poin=
ter
dereference and a memory leak in the goto ladder of
damon_sysfs_scheme_add_dirs().

If damon_sysfs_scheme_set_tried_regions() fails, we jump to
put_tried_regions_out:

mm/damon/sysfs-schemes.c:damon_sysfs_scheme_add_dirs() {
    ...
	err =3D damon_sysfs_scheme_set_stats(scheme);
	if (err)
		goto put_filters_watermarks_quotas_access_pattern_out;
	err =3D damon_sysfs_scheme_set_tried_regions(scheme);
	if (err)
		goto put_tried_regions_out;
	return 0;

put_tried_regions_out:
	kobject_put(&scheme->tried_regions->kobj);
	scheme->tried_regions =3D NULL;
put_filters_watermarks_quotas_access_pattern_out:
    ...
}

Because scheme is allocated via kmalloc_obj() (which wraps kmalloc and does=
n't
zero memory), and the failing set_tried_regions() doesn't initialize
scheme->tried_regions on error, doesn't scheme->tried_regions contain an
uninitialized value here? Dereferencing it would cause a panic.

Additionally, this jump target falls through to
put_filters_watermarks_quotas_access_pattern_out without ever calling
kobject_put(&scheme->stats->kobj), so wouldn't the successfully allocated
stats kobject be permanently leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150844.8830=
5-1-sj@kernel.org?part=3D3
