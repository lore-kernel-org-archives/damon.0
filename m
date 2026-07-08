Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A047DD51
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520541; cv=none; b=bDWQxBJSMsEeAStqB9pQ8dapar3WvXaQafNppiHpvSxDgDxdUDO8+PWLa7sc5HqutU8TTmpPKMMRbaw25DpKGaPlz2D/HmpwtM3gGaRGg6j2jrPr4VXv6zC8p62FzaFSIhMlpMvUkDJ1aXq//jlexfgdmGEx2vPlzurd62c/AtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520541; c=relaxed/simple;
	bh=n9mKfFwMqjE3n7wBjSGq8rC1P8t1/C19DJoau8vuRJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4UuwMmrXRrhpSzPekMsQSzpXhl0TtdnMYDboJbzzF3TgyNTjltVgsA7lAZu1yfMa2tcHhhWYOxC4leEG8tXpIT0Zncg+NTrIVHfrCIHmZwehF9DC7TzrZ7/SCK67uTWwpugzAKKAOzXV7OH6U1Jht9WIByQghCnV6PXJk5wlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEQ3TnuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEQ3TnuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C781F00A3A;
	Wed,  8 Jul 2026 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520539;
	bh=XfcxdDQPOUHFkmp1eSYZJtDFfhPICPsqt5DG8oE7cjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KEQ3TnuN2VyuXNCvt8Ou5vgOcWPjggG6acfxVoQbz6SiCoURq12PxLddNHflgz4r8
	 zUVS+RmPRaMfSxgeu3PD0k5gHrWOR6iHTixUGjf9UnmSIrr9FnMnRl/4FqPK1FywV9
	 TYK9Ap5o7+9LbFvBt/8llha/WO9AChb9xQfLN4m8ZJG7KNiXy0WTS6+ac7J0klhXMF
	 uyv0nmw025FyHBKwhW6yEKYjsqSvBD0lSYjFJePDTcN9Vlc+3fmoVkJ+jZod3ONqrz
	 bxEDkCmUxa+guKBbp/70/GSgGpS1D+N1BLc+1TRonb7yHcx7tYfzcB6qIa5VXf63bY
	 uPGQlDtipyOdA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Guangshuo Li" <lgs201920130244@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix tried_regions setup failure cleanup
Date: Wed,  8 Jul 2026 07:22:11 -0700
Message-ID: <20260708142212.123745-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708082010.10E441F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 08:20:09 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Uninitialized pointer dereference in error path of damon_sysfs_access_pattern_add_dirs()
> --
> 
> --- Patch [1]: [PATCH] mm/damon/sysfs-schemes: fix tried_regions setup failure cleanup ---
> commit b97caf8d3b939c01dca3a53c5340d70ede6714d2
> Author: Guangshuo Li <lgs201920130244@gmail.com>
> 
> mm/damon/sysfs-schemes: fix tried_regions setup failure cleanup
> 
> This commit fixes an uninitialized pointer dereference in the error cleanup
> path of damon_sysfs_scheme_add_dirs(). It changes the failure jump target 
> for damon_sysfs_scheme_set_tried_regions() to avoid calling kobject_put()
> on the uninitialized tried_regions pointer.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 329cfd0bbe9f3..0668a0e539713 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -2516,12 +2516,12 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
> >  		goto put_filters_watermarks_quotas_access_pattern_out;
> >  	err = damon_sysfs_scheme_set_tried_regions(scheme);
> >  	if (err)
> > -		goto put_tried_regions_out;
> > +		goto put_stats_out;
> >  	return 0;
> >  
> > -put_tried_regions_out:
> > -	kobject_put(&scheme->tried_regions->kobj);
> > -	scheme->tried_regions = NULL;
> > +put_stats_out:
> > +	kobject_put(&scheme->stats->kobj);
> > +	scheme->stats = NULL;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing this cleanup,
> I noticed the exact same uninitialized pointer dereference exists earlier in
> the same file.
> 
> If damon_sysfs_access_pattern_add_range_dir() fails during the setup of "sz",
> does the error path dereference an uninitialized pointer?
> 
> mm/damon/sysfs-schemes.c:damon_sysfs_access_pattern_add_dirs() {
>     ...
> 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
> 			&access_pattern->sz, "sz");
> 	if (err)
> 		goto put_sz_out;
>     ...
> put_sz_out:
> 	kobject_put(&access_pattern->sz->kobj);
> 	access_pattern->sz = NULL;
> 	return err;
> }
> 
> Since damon_sysfs_access_pattern is allocated with kmalloc_obj(), its fields
> are uninitialized. If the directory creation fails, the function returns an
> error without writing to the pointer. The error path then jumps to put_sz_out
> and calls kobject_put() on the garbage pointer access_pattern->sz, identical
> to the bug fixed by this patch.
> 
> Could this be addressed with a similar fix?

This is already fixed in the mainline by commit d58fdbe37a82
("mm/damon/sysfs-schemes: fix dir put orders in access_pattern_add_dirs()") to
my understanding.   Let me know if I'm missing something.

> 
> >  put_filters_watermarks_quotas_access_pattern_out:
> >  	kobject_put(&scheme->ops_filters->kobj);
> >  	scheme->ops_filters = NULL;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260708080107.727043-1-lgs201920130244@gmail.com?part=1


Thanks,
SJ
