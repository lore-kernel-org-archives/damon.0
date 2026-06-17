Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8851E1E04
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658476; cv=none; b=GA1iQrzr4XJpPJbfgmefJFobWRiw5+55uVsF5+ZNSZNP+sJOyia2u0sKohBlqe1vnx3dDmY++jrI6XJNf4Fc8fdAuvH6w+vkGSoRM3mKZ3ccsiOa8iLdZ1ZsQ4b1gYc41v+NZU9hAPGWJ52WNxqGzXxWHfkm0iL1jJI02BzmGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658476; c=relaxed/simple;
	bh=biJtbP4BDSyRStU4PMobTj/asDh5kFidN5zuSkeAo2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3rdYh0w05DWNl9EG4ju66711+N0rk5LTKl+bFA8gTxxNbVV6cTJy+zqIAD+QWlx/V1nZLSQiC7cCDh4YhWxOSUJN6tv5yvsGrx1EQ1jOn/iE/gxj9w82DamW75TYqUrTy08cRj1D9ZP3wpCE4CcKix+2xht2UK4Z9QV+k/JJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foCMqjHp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foCMqjHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BBC1F000E9;
	Wed, 17 Jun 2026 01:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658475;
	bh=Ps4eSF5jfaWKZkEJGJ4Ss5eV6GRNRN8mOPMM7XRV9fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=foCMqjHp14AbE0a193dOoSo0s3uWKYh30pfMgQehwoZ93trg8/WSD+pxtMjEaXQ0/
	 wUCsFOu88UY6uFh+H+0hxJXinPJg5dHTOmdXi93Z269JO5pgd+CqMryeoLC6P49NdR
	 +SwjNnD1uBlIrLrK5yd9Az2Dhy3NiUReHoPKhOITYuGFGltBa363U79m9AHWFiMjfD
	 5Z5u1ZUDVZIW9pwfwc2OhNFos7Xh4abwgoVp16IdI4W5j2WYnscEn8Td0kdJDPB1C8
	 7Znoez5lSHYqh7KuLrA9hCpeAuG2IPg1ly7EMBEdsekar6ItSlo3kWhCo3GlU+qqin
	 eePezbvxbwSeQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 7/9] mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
Date: Tue, 16 Jun 2026 18:07:45 -0700
Message-ID: <20260617010745.97166-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616153409.CCDD31F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:34:09 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing `kobject_del()` calls on the error paths of numerous `_add_dirs` initialization loops, leading to delayed-release name conflicts.
> --
> 
> commit 635dc3a5238027dd7ff5a0100c509a12408d26da
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
> 
> This commit adds kobject_del() calls to the scheme action destination
> directories cleanup routine. This prevents directory creation failures
> due to name conflicts when CONFIG_DEBUG_KOBJECT_RELEASE is enabled.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 737638be84f15..108f6de32f8c1 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -2148,8 +2148,10 @@ static void damos_sysfs_dests_rm_dirs(
> >  	struct damos_sysfs_dest **dests_arr = dests->dests_arr;
> >  	int i;
> >  
> > -	for (i = 0; i < dests->nr; i++)
> > +	for (i = 0; i < dests->nr; i++) {
> > +		kobject_del(&dests_arr[i]->kobj);
> >  		kobject_put(&dests_arr[i]->kobj);
> > +	}
> >  	dests->nr = 0;
> >  	kfree(dests_arr);
> 
> [Severity: High]
> This is a pre-existing issue, but should the error paths in the various
> _add_dirs() functions also be updated to call kobject_del() to prevent the
> same name conflicts?
> 
> When kobject_init_and_add() succeeds, the kobject is added to sysfs. If a
> subsequent initialization step fails, the error paths call kobject_put()
> without calling kobject_del() first. Under CONFIG_DEBUG_KOBJECT_RELEASE,
> kobject_put() schedules delayed cleanup, so the sysfs directory remains
> visible until the delayed release completes. If the user immediately retries,
> kobject_init_and_add() will fail with an -EEXIST name collision.
> 
> For example, in mm/damon/sysfs.c:damon_sysfs_targets_add_dirs():
> 
>         err = kobject_init_and_add(&target->kobj, ...);
>         if (err)
>                 goto out;
> 
>         err = damon_sysfs_target_add_dirs(target);
>         if (err)
>                 goto out;
> 
>         ...
> 
> out:
>         damon_sysfs_targets_rm_dirs(targets);
>         kobject_put(&target->kobj);
>         return err;
> 
> Does this series also need to add kobject_del() calls to the error paths
> of these functions:
> - damon_sysfs_targets_add_dirs() in mm/damon/sysfs.c
> - damon_sysfs_probes_add_dirs() in mm/damon/sysfs.c
> - damon_sysfs_contexts_add_dirs() in mm/damon/sysfs.c
> - damon_sysfs_kdamonds_add_dirs() in mm/damon/sysfs.c
> - damon_sysfs_schemes_add_dirs() in mm/damon/sysfs-schemes.c
> - damos_sysfs_populate_region_dir() in mm/damon/sysfs-schemes.c

Yes.  Sashiko reported same issue in other replies to this thread and I
promised to fix these in the next revision.


Thanks,
SJ

[...]
