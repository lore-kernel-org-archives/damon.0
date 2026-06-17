Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95F18C2C
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781655526; cv=none; b=OF+dlF+t9VU5RB7TI1wORvMUFo8lwBrXuRT7Ve9GlAtcI6O9QVO5A5fVKWLDTHxugbhXDdR2mzK3FkBlqGsMgD65R2vWYuinePsP/HTqCRUJG3Hhpx9+vnXT82U7fMpPSRZVnwGaxdZr5Eq/j8b72WcSq79E0Fxlxvnm00NB18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781655526; c=relaxed/simple;
	bh=KQvz2+XQugIw27aItvjwVr8xhxBDsyY6GCHjd5oWeco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYDaOhpYGWYnrPV5wosWBqYBLFC8ymnYOoZ2RAW4+/TI7t+Q9MIbr87jkah7TVUp2B1kLFxCEumL0iDscIw4z6BPXCzTFdm7R8/7gx6VfrBe9GGt/rZTWE4WaHqPvAtPNnAmrDRzCygowYiNJkfIzx6vIrEphtHgwFSRuXVoogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCXav63n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCXav63n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6224B1F000E9;
	Wed, 17 Jun 2026 00:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781655525;
	bh=Lb9qiDKWh81sezct0lHtb4legNYYtvK0PvYuTBbhVWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCXav63ncqk9rT/TGMjxvwqJMuepXto4BUmXXJg5VY2GgLiSp8IPlraH6VdxtXU3u
	 /ucGHLO4XvrF+VZLAcgw1AkT4SVxCxr0K3BuGjAmYgTlWFVFH/V7uM1criLDiHrU+9
	 LPkN96VAXQpvVvylH6+wTicKHtR1JiWiReFkE9ATB7QizQC04P1Hh3Vtk2d/zGkYDe
	 n/EqUlOD7Zrhwyd+ET/yX5WDjvqVB3tR6UgojeQWmtjBydZTJZezawgkoC5Gbx+G1w
	 u37jQiJpD2Ai8aJxWrZuroAmki+B4VbcPHIBF8s/lGo/G13pmaVgwx3DEqzvYnkuxk
	 2AonGDRJO/XYg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/9] mm/damon/sysfs: kobject_del() region dirs
Date: Tue, 16 Jun 2026 17:18:34 -0700
Message-ID: <20260617001835.95809-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616152911.9CF261F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:29:11 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing explicit kobject_del() on error paths in _add_dirs loops (Incomplete Fix).
> - [High] Memory leak of stats and scheme structures on the error path of damon_sysfs_scheme_add_dirs().
> --
> 
> commit ba4dfdbea398b3306e96fd3662e872e97251fbe9
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs: kobject_del() region dirs
> 
> This commit fixes directory creation failures caused by name conflicts
> when CONFIG_DEBUG_KOBJECT_RELEASE is enabled. It achieves this by adding
> missing kobject_del() calls to the region directories removal function.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index d93f7919c3ca1..f72e1e37df9d8 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -107,8 +107,10 @@ static void damon_sysfs_regions_rm_dirs(struct damon_sysfs_regions *regions)
> >  	struct damon_sysfs_region **regions_arr = regions->regions_arr;
> >  	int i;
> >  
> > -	for (i = 0; i < regions->nr; i++)
> > +	for (i = 0; i < regions->nr; i++) {
> > +		kobject_del(&regions_arr[i]->kobj);
> >  		kobject_put(&regions_arr[i]->kobj);
> > +	}
> >  	regions->nr = 0;
> >  	kfree(regions_arr);
> >  	regions->regions_arr = NULL;
> 
> [Severity: High]
> This is a pre-existing issue, but the fix for this specific bug class seems
> incomplete as it misses initialization error paths. If a nested initialization
> fails after kobject_init_and_add() succeeds, the code jumps to an error path
> and calls kobject_put() without first calling kobject_del().
> 
> For example, in mm/damon/sysfs.c:damon_sysfs_targets_add_dirs():
> 
> out:
>         damon_sysfs_targets_rm_dirs(targets);
>         kobject_put(&target->kobj);
>         return err;
> 
> This same pattern occurs in damon_sysfs_contexts_add_dirs(),
> damon_sysfs_kdamonds_add_dirs(), damon_sysfs_probes_add_dirs(), and
> damon_sysfs_schemes_add_dirs().
> 
> Does this cause the directory removal to be delayed asynchronously, meaning
> if userspace immediately retries the operation, it fails with an -EEXIST
> conflict?

Good findings, I will fix these in the next revisioin of this series.

> 
> [Severity: High]
> This is also a pre-existing issue, but there appears to be a memory leak
> in the error path of damon_sysfs_scheme_add_dirs() in
> mm/damon/sysfs-schemes.c:
> 
>         err = damon_sysfs_scheme_set_tried_regions(scheme);
>         if (err)
>                 goto put_tried_regions_out;
>         return 0;
> 
> put_tried_regions_out:
>         kobject_put(&scheme->tried_regions->kobj);
>         scheme->tried_regions = NULL;
> put_filters_watermarks_quotas_access_pattern_out:
>         kobject_put(&scheme->ops_filters->kobj);
> 
> If damon_sysfs_scheme_set_tried_regions() fails, the code jumps to
> put_tried_regions_out and bypasses releasing the successfully created
> scheme->stats kobject. Since damon_sysfs_scheme_release() only frees the
> scheme struct and does not explicitly clean up lingering children, both the
> stats memory and the parent scheme memory are kept referenced.
> 
> Could this permanently leak both the stats and its parent scheme when
> triggered from userspace via sysfs configuration?

This may deserve another fix.  I will separtely work on this.


Thanks,
SJ

[...]
