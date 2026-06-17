Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D83C1F
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781657031; cv=none; b=kjZwg/zqNwJfBvlByeVqs19m8n5RUocCm0LDKrZ6FibOskZnNpUqLD0zgorqul8qSUsd0WeZAMf5XzSfkiPGOw5imhILulH7lmE86uMNC1hJqIKSeBms8egjmOA946T5uswq2dN09/oTx5SQyz7VJrcKooCHHHeRJhGVgkX4/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781657031; c=relaxed/simple;
	bh=14AMIYN9/ksYTmk+Q8m6qMuYQIHleSlHw5v+iXlUeBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuPYXqJSzEd3jqJZz3YZSsZ3l2hgjptjWndluGdux7F8LTK6+W9c2gY6UmxlxT1xbSnZ0/Fm2zKoXmcEi4pfF8IZ2txpbJm/qLwm5bHbK1BwEL/cLDmsLza1iTQ8oJvx+drFeZcoFFFmiXOsuk+3pndS8rkrLqTHxq6cw/UONd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEskHdbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEskHdbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CDA1F000E9;
	Wed, 17 Jun 2026 00:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781657029;
	bh=xPOm1+O65SgJZpv4xC2V7pmznLjZuwFYEI37DV6iUhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aEskHdbPKR20VUYc9C/Iy5cmqnSDRtO4TVTtEmWdTiLA+EhIk2W1IIWk6lT04sE2X
	 twyGTE2/qSlJ3cbaaQRKpffKqtqNaoKEN+QpCv3NyBa6a564Wp3ePfJOLnkWPkJART
	 6RX3WeVyfpidE2gD/zyZO56ihEn6+EovJ0H/XkfmMMZU2clnOlQxrx1cvkw+DdHkPJ
	 7CQDgAtOkVwd7OtOAZNmYODZ/5YYuIynuxRiV3acFzGTBRd+kbZ/t3LcVZ/a1rdmGD
	 qxDfUOZdrRP8hrLUrPgXiF5yhfVoB9hwLysDdyTe4QArw8y7+8xOsW2OweUlcyLUhv
	 Qm+F0INWCzRqA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 4/9] mm/damon/sysfs-schemes: kobject_del() scheme region dirs
Date: Tue, 16 Jun 2026 17:43:37 -0700
Message-ID: <20260617004337.96212-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616152536.2481C1F00A3F@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:25:35 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incomplete Fix / Missing kobject_del() in sysfs directory array teardown and error paths.
> - [High] Memory leak of `stats` object in `damon_sysfs_scheme_add_dirs()` error path.
> --
> 
> commit 30488832bf0bcf915d5cbb6c2727b7cdedd8440e
> Author: SeongJae Park <sj@kernel.org>
> Subject: mm/damon/sysfs-schemes: kobject_del() scheme region dirs
> 
> This commit addresses directory creation failures due to name conflicts
> when CONFIG_DEBUG_KOBJECT_RELEASE is enabled. It fixes the issue by adding
> missing kobject_del() calls before kobject_put() for scheme region
> directories during removal.
> 
> Link: https://lore.kernel.org/20260517205828.6204-1-sj@kernel.org
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 37cf6edb54f17..bf08e6e1f1635 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -334,6 +334,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
> >  	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
> >  		damos_sysfs_region_rm_dirs(r);
> >  		list_del(&r->list);
> > +		kobject_del(&r->kobj);
> 
> [Severity: High]
> This is a pre-existing issue, but since we are adding kobject_del() here to
> fix the name collision bug, could there be similar omissions in other array
> teardown and error paths?
> 
> For instance, looking at damos_sysfs_probes_rm_dirs() which is called
> just above via damos_sysfs_region_rm_dirs():
> 
> mm/damon/sysfs-schemes.c:damos_sysfs_probes_rm_dirs() {
>     ...
>     for (i = 0; i < probes->nr; i++)
>         kobject_put(&probes_arr[i]->kobj);
>     ...
> }
> 
> Does this code also omit kobject_del() during probes array teardown,
> potentially leaving directories in sysfs during array resizing?

No.  probe directories are generated as sub directories of scheme region
directories, when scheme region is created.  They are also removed together
with the region directory, which is kboject_del()-ed by this patch.  Hence, the
not yet deleted probe directories are linked to the deleted region directory,
so no name conflicts can happen.

> 
> Similarly, in several initialization loop error paths, such as in
> damos_sysfs_populate_region_dir():
> 
> mm/damon/sysfs-schemes.c:damos_sysfs_populate_region_dir() {
>     ...
> out:
>     kobject_put(&region->kobj);
> }
> 
> If aborting region population, does this path fail to call kobject_del(),
> breaking subsequent retries by leaving the directory name occupied?
> 
> Other functions like damon_sysfs_schemes_add_dirs(),
> damon_sysfs_targets_add_dirs(), and damon_sysfs_contexts_add_dirs()
> appear to have the same out path pattern omitting kobject_del() for
> partially added objects. Would it make sense to update those paths as well?

Good catch.  I will fix this in the next revision.

> 
> >  		kobject_put(&r->kobj);
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential memory leak in
> an error path nearby.
> 
> In damon_sysfs_scheme_add_dirs(), the error cleanup sequence handles
> dropping the tried_regions and then ops_filters:
> 
> mm/damon/sysfs-schemes.c:damon_sysfs_scheme_add_dirs() {
>     ...
> put_tried_regions_out:
>     kobject_put(&scheme->tried_regions->kobj);
>     scheme->tried_regions = NULL;
> put_filters_watermarks_quotas_access_pattern_out:
>     kobject_put(&scheme->ops_filters->kobj);
>     ...
> }
> 
> Does this error path completely omit dropping the stats kobject?
> 
> The stats kobject is initialized prior to the failed call, so
> wouldn't skipping kobject_put(&scheme->stats->kobj) leak it permanently?

Good finding, but you already shared this with the reply to the first patch of
this series.  I promised to separately work on it.


Thanks,
SJ

[...]
