Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B03870808
	for <damon@lists.linux.dev>; Thu, 18 Jun 2026 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781743479; cv=none; b=m5L49TRXwFiyZ3kh9GuM+d1tWEE9CP4FBIVCnZ/UkIDzvUEj/k8yuzq+VBabsA5X6lE0zlcWsdtJLu9CHq6UdYiJm//6ynWuHKnkaFppmGJzpjbIcEcy374/Rb5t1wcAk9EtZmSTcEH8hs6WjoVCXKTrMK5USxXG3zMSiz+1/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781743479; c=relaxed/simple;
	bh=1daWT6LMpE92G0VcDK5VWTdFrOuXt8tS/81qPjd5oUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbIaO57eUg4+RAr9PEaaC8IWstfEk4/Ro/JcKMMVRp/pjLmNXuY9c31X5RlWoOshH1cr23Bgda7eCT0p5AMlegKa/f9JmxeFirVj/A05u2PA0TbYKzl8/WBbQnLLB6gCUQ1z7PXKckRb/qPKiXWgL0FhjSMgXoHdQ7aGD93S6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvjOIiLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvjOIiLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB581F000E9;
	Thu, 18 Jun 2026 00:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781743477;
	bh=Cj/Lc76Fza4JEezBCw/GZE+usmB156SvS5jAcLbqliw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvjOIiLHB+dKO43MfcKECa1AAR+8yaUrKSNdIk1fjrwIGtiizlbABL2Jvn6Um83eS
	 QPpZeV6r9voxS53DmkvpL9YT8PX7i2BKxzPSOxWeSE+mDqVHrsXrGkLS4tivPwiE0E
	 UTlbCpXd+/L7ys87HJryxxv/LjaOJsQrFf+YFCuRbaX4n8Esg+mpbkK6rt5Hw6cG7B
	 nuuvr2u2VHC2v+MHu8/ivJ2pn9lEu0sbg1SFXuIT57ulFzN/EsVEmSggI3SnImMu5E
	 Ocgr65D1IBZnoDySkr6LCLeFq25RpNT8/kZ73p8GcY7PFnKpvs+Q+ONTaLAr+OszPa
	 MXLuqy3bqlJew==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 01/11] mm/damon/sysfs: kobject_del() target (normal), context and kdamond dirs
Date: Wed, 17 Jun 2026 17:44:27 -0700
Message-ID: <20260618004428.82261-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617150910.1CDB11F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jun 2026 15:09:09 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Memory leak and uninitialized pointer dereference in `damon_sysfs_scheme_add_dirs()` error path due to shifted labels.
> - [Medium] Missing `kobject_del()` in `damos_sysfs_probes_rm_dirs()` causes sysfs name conflicts under `CONFIG_DEBUG_KOBJECT_RELEASE`.
> - [Medium] Missing `kobject_del()` in `damon_sysfs_schemes_add_dirs()` error path causes sysfs name conflicts.
> --
> 
> commit ca062d775b58ea3ec065a28f4400047399c0f380
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs: kobject_del() target (normal), context and kdamond dirs
>     
> On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
> could cause directories creation failures due to the name conflicts. Fix
> those issues for normal creation paths of target, context and kdamond
> directories, and error paths of context and kdamond directories by
> adding kobject_del() calls.
> 
> Cc: <stable@vger.kernel.org> # 5.18.x
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 2e95e3bac774d..dba1c67fc188f 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> 
> [ ... ]
> 
> > @@ -1642,6 +1643,7 @@ static void damon_sysfs_contexts_rm_dirs(struct damon_sysfs_contexts *contexts)
> >  
> >  	for (i = 0; i < contexts->nr; i++) {
> >  		damon_sysfs_context_rm_dirs(contexts_arr[i]);
> > +		kobject_del(&contexts_arr[i]->kobj);
> >  		kobject_put(&contexts_arr[i]->kobj);
> >  	}
> >  	contexts->nr = 0;
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does damos_sysfs_probes_rm_dirs()
> need a similar kobject_del() fix to avoid sysfs name conflicts?
> 
> mm/damon/sysfs-schemes.c:damos_sysfs_probes_rm_dirs() {
> ...
> 	for (i = 0; i < probes->nr; i++)
> 		kobject_put(&probes_arr[i]->kobj);
> 	probes->nr = 0;
> ...
> }

No.  Users cannot directly generate/remove only probe dirs.  Hence probe dirs
are generated and removed together with their parent, region directory.
Because the region directory cleanup is doing kobject_del(), this code path
doesn't need kobject_del().

> 
> [ ... ]
> 
> > @@ -1680,13 +1682,15 @@ static int damon_sysfs_contexts_add_dirs(struct damon_sysfs_contexts *contexts,
> >  
> >  		err = damon_sysfs_context_add_dirs(context);
> >  		if (err)
> > -			goto out;
> > +			goto del_out;
> >  
> >  		contexts_arr[i] = context;
> >  		contexts->nr++;
> >  	}
> >  	return 0;
> >  
> > +del_out:
> > +	kobject_del(&context->kobj);
> >  out:
> >  	damon_sysfs_contexts_rm_dirs(contexts);
> >  	kobject_put(&context->kobj);
> 
> [Severity: Medium]
> This is a pre-existing issue, but does damon_sysfs_schemes_add_dirs() need a
> similar kobject_del() fix in its error path?
> 
> mm/damon/sysfs-schemes.c:damon_sysfs_schemes_add_dirs() {
> ...
> 		err = kobject_init_and_add(&scheme->kobj, ...);
> 		if (err)
> 			goto out;
> 		err = damon_sysfs_scheme_add_dirs(scheme);
> 		if (err)
> 			goto out;
> ...
> out:
> 	damon_sysfs_schemes_rm_dirs(schemes);
> 	kobject_put(&scheme->kobj);
> 	return err;
> }
> 
> If damon_sysfs_scheme_add_dirs() fails after kobject_init_and_add() succeeds,
> the out label puts the reference without unlinking it.
> 
> Could this cause a directory creation failure on retry under delayed release?

Yes, good finding.  I will fix this in the next revision.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while looking at error paths,
> does damon_sysfs_scheme_add_dirs() have an uninitialized pointer dereference
> and a resource leak?
> 
> mm/damon/sysfs-schemes.c:damon_sysfs_scheme_add_dirs() {
> ...
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
> ...
> }
> 
> If damon_sysfs_scheme_set_tried_regions() fails, the code jumps to
> put_tried_regions_out and dereferences scheme->tried_regions. 
> 
> Since damon_sysfs_scheme_alloc() allocates memory without zeroing it, won't
> this dereference an uninitialized pointer?
> 
> Additionally, this jump entirely skips cleaning up the successfully
> initialized stats object.
> 
> Should there be a put_stats_out cleanup label to avoid leaking it?

Yes.  And I'm separately working on this.

Sashiko review comments are only repeating the findings in this reply.  Hence I
will not reply to each of the other replies.


Thanks,
SJ

[...]
