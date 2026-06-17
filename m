Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960CC134CF
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781657559; cv=none; b=WQaCixG5/I0FfK0xHCY3sN34s7BoBO4Qq4/l/UlaqF1Gw8TWwd4KaqM/NCRgSI3oqZYXAcLABkBx6LUNB2+iDEq+2BOCm6TVjLGrx8/xXQwCFA1yfxE4+qQXi1wfV5mKLuty2hSgORVIH04xZr/GabZHnk1431se4gI4pzePL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781657559; c=relaxed/simple;
	bh=lShJFRKvR+5Uom1wDvUL+3tIczEbxGA291abkmsCgBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYplvEO5HxKCNyCbO7KTjO/5uYJfIw1c3tcEx4hNXqI1EWU59oXpsAUYVq2ajJznSAgxq8w3rEeRfNyZewBYyIPXUmL9auAFPj6sKdYKmwDreFCQmexVyDPGd0VKWnp3u/CVMjji/y0yUWTzmYLEE5hCHTyBGcdArE3LqQgoTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcvuLufU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcvuLufU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8EC1F000E9;
	Wed, 17 Jun 2026 00:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781657558;
	bh=zil/SWCR8T+TzhzULOq6sb/mRg6lQ22/6qeLiUG4qxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gcvuLufUMFXv/gvYmYnJE0YTvyvNpZl8z397bW49jnTu4h0mrfD+mq7gQlj63X57y
	 OgevLnFLU5HqFcq8R1rOPsXJbketjx1IxnRQuV+57S5mJt1GKs9q2nqsi1+RSl+H6A
	 1fKpqxUz6gye63gq7ZbbTFS2gmSDnMiOwfx8KpCphdgyvXbq830qqfDZ8mMUZe6xfc
	 req6todDIjmARIx2KfhJ80WL9C30YNjbl2X3cTA8ZfsRHQtH2/Kds1PzqG/Fmlpu+H
	 lAoaXyCAxNmB5kyOpf04eQn5HwWSvXxtP7Nmbnvdb6kcS7A5U4nINsAUHXcyF225X+
	 ifSQ0VYvwzYMA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/9] mm/damon/sysfs-schemes: kobject_del() scheme dirs
Date: Tue, 16 Jun 2026 17:52:22 -0700
Message-ID: <20260617005223.96813-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616152703.04D771F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:27:02 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incorrect `goto` ladder in `damon_sysfs_scheme_add_dirs` causes an uninitialized pointer dereference and a memory leak of the `stats` kobject.
> - [Medium] Missing `kobject_del()` in the `out:` error paths of `*_add_dirs()` loops leads to delayed sysfs directory removal and name collisions.
> --
> 
> commit a283ef4fe4b682b7b66cf9b57221cb6884b386cc
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: kobject_del() scheme dirs
> 
> On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
> could cause directories creation failures due to the name conflicts. Fix
> those issues for scheme directories by adding kobject_del() calls.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 329cfd0bbe9f3..37cf6edb54f17 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -2686,6 +2686,7 @@ void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes)
> >  
> >  	for (i = 0; i < schemes->nr; i++) {
> >  		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
> > +		kobject_del(&schemes_arr[i]->kobj);
> >  		kobject_put(&schemes_arr[i]->kobj);
> >  	}
> >  	schemes->nr = 0;
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but since we are fixing delayed
> sysfs directory removal here, do we have the same name collision vulnerability
> in the error paths of our *_add_dirs() loops?
> 
> If kobject_init_and_add() succeeds for a scheme, but damon_sysfs_scheme_add_dirs()
> fails, the error path drops the reference without calling kobject_del():
> 
> mm/damon/sysfs-schemes.c:damon_sysfs_schemes_add_dirs() {
>     ...
> 		err = kobject_init_and_add(&scheme->kobj,
> 				&damon_sysfs_scheme_ktype, &schemes->kobj,
> 				"%d", i);
> 		if (err)
> 			goto out;
> 		err = damon_sysfs_scheme_add_dirs(scheme);
> 		if (err)
> 			goto out;
>     ...
> out:
> 	damon_sysfs_schemes_rm_dirs(schemes);
> 	kobject_put(&scheme->kobj);
> 	return err;
> }
> 
> Under CONFIG_DEBUG_KOBJECT_RELEASE, would the delayed kobject_release
> callback leave the "%d" directory around temporarily, causing -EEXIST
> if the user immediately retries?
> 
> The identical pattern appears to exist in damon_sysfs_targets_add_dirs(),
> damon_sysfs_contexts_add_dirs(), and damon_sysfs_kdamonds_add_dirs().

Good catch, I will fix thse in the next revision.

> 
> [Severity: High]
> This is a pre-existing issue, but there appears to be an uninitialized pointer
> dereference and a memory leak in the goto ladder of
> damon_sysfs_scheme_add_dirs().
> 
> If damon_sysfs_scheme_set_tried_regions() fails, we jump to
> put_tried_regions_out:
> 
> mm/damon/sysfs-schemes.c:damon_sysfs_scheme_add_dirs() {
>     ...
> 	err = damon_sysfs_scheme_set_stats(scheme);
> 	if (err)
> 		goto put_filters_watermarks_quotas_access_pattern_out;
> 	err = damon_sysfs_scheme_set_tried_regions(scheme);
> 	if (err)
> 		goto put_tried_regions_out;
> 	return 0;
> 
> put_tried_regions_out:
> 	kobject_put(&scheme->tried_regions->kobj);
> 	scheme->tried_regions = NULL;
> put_filters_watermarks_quotas_access_pattern_out:
>     ...
> }
> 
> Because scheme is allocated via kmalloc_obj() (which wraps kmalloc and doesn't
> zero memory), and the failing set_tried_regions() doesn't initialize
> scheme->tried_regions on error, doesn't scheme->tried_regions contain an
> uninitialized value here? Dereferencing it would cause a panic.

Good finding, but this deserves another patch.  I will separately work on this.

> 
> Additionally, this jump target falls through to
> put_filters_watermarks_quotas_access_pattern_out without ever calling
> kobject_put(&scheme->stats->kobj), so wouldn't the successfully allocated
> stats kobject be permanently leaked?

Good finding, but you reported this in another reply to this thread and I
promised to separately work on this.


Thanks,
SJ

[...]
