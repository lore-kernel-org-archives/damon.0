Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB031E1E04
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658613; cv=none; b=YwYX30k782Cd9o+eEhisaSLc1kzbO25gZtGNh/4GJvorGN2SmyAHEyJyzTmaeGaMBM6coex4P+tdyxUbWO5pXb8j/16Iw+bEo20cPn/Fz755StCK/a9jH5jnQVsfnLvUeWLwEdy4F20L6G/Pc701DCbSgWdIcUoYL92Emk753lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658613; c=relaxed/simple;
	bh=HXAGmEpgiKeUsfMhC1LwV517Pd2I6KLP5TWm7zckM2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c10kguUlLB9UrTIuf9kn4vYlHmSKz2HvwgfupFhxNy5LCJDa5JDPFTopXIt6+faSkL3K26Hj75ZnERHWs7iTfHVDy0G0/Ndct45B+oe8N1sncHYI3sN5c+2U7zcv1W4/jZ0ECfNJbr7qu125HQR4h5zeqcamVcoY6PttvFcnOl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctyHzh5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctyHzh5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAC01F000E9;
	Wed, 17 Jun 2026 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658612;
	bh=HZI0RzOj9CU6ZjpZXGhXrQ8GAPBn1Sr3qCRt8dmI1dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ctyHzh5TpHbgEK1f84yqARcwEX2b+LvBNHtEu0IpoawvYGeH21flJVKu0c6SIkgrr
	 BR72YdhcolRVQ/uWczlQDrCabKBRO6FOWPqW4taDl3vC+AoF+KfO/GBhduJRLxa+LZ
	 9fTCVTk6II0u9B5bz0r8oi6Niaef37aH3M1da24o1zI36SKQba18AE+MTyHWuo9esK
	 s6qVSlnX4lwo4ejr+/DsO7Fnw5lMup7xzVfNWRtuO/SC0R8CEusk7OYWF7RfpQsa7D
	 9DA00azPqsTpfmPfj1QZSH6gH6loDkloy00mCjC5xdz6cdFvmC/BQW+4n+cC3tOwYC
	 1G34XwZ+jiCyA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 8/9] mm/damon/sysfs: kobject_del() probe filter dirs
Date: Tue, 16 Jun 2026 18:10:00 -0700
Message-ID: <20260617011001.97302-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616152751.D9DA01F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:27:51 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing `kobject_del()` in `damos_sysfs_probes_rm_dirs()` leading to sysfs name conflicts.
> - [High] Missing `kobject_del()` on error paths in `_add_dirs` array-initialization loops causing `-EEXIST` name conflicts on retries.
> --
> 
> commit d2e0c9ec8c59c96ff7123c668d926efc99e5b382
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs: kobject_del() probe filter dirs
> 
> This commit adds kobject_del() calls in damon_sysfs_filters_rm_dirs()
> before kobject_put(). This prevents directory creation failures caused
> by name conflicts when CONFIG_DEBUG_KOBJECT_RELEASE is enabled.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index f72e1e37df9d8..04725ff3d9f3c 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -960,8 +960,10 @@ static void damon_sysfs_filters_rm_dirs(struct damon_sysfs_filters *filters)
> >  	struct damon_sysfs_filter **filters_arr = filters->filters_arr;
> >  	int i;
> >  
> > -	for (i = 0; i < filters->nr; i++)
> > +	for (i = 0; i < filters->nr; i++) {
> > +		kobject_del(&filters_arr[i]->kobj);
> >  		kobject_put(&filters_arr[i]->kobj);
> > +	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but should this fix also be
> applied to other similar cleanup loops?
> 
> Looking at mm/damon/sysfs-schemes.c:damos_sysfs_probes_rm_dirs():
> 
> 	for (i = 0; i < probes->nr; i++)
> 		kobject_put(&probes_arr[i]->kobj);
> 
> This iterates over probes_arr and calls kobject_put() without kobject_del(),
> mirroring the exact bug this patch addresses. When
> damos_sysfs_probes_add_dirs() fails and calls this cleanup function, does
> this delay directory removal and cause a -EEXIST collision if retried?

No.  I explained the reason to another same report that Sashiko reported as
another repply to this thread.

> 
> [Severity: High]
> This is a pre-existing issue, but do the error paths in the _add_dirs array
> initialization loops also need kobject_del() calls?
> 
> If a nested setup function fails after a successful kobject_init_and_add(),
> the error path drops the reference but misses a preceding kobject_del().
> 
> For example, in mm/damon/sysfs.c:damon_sysfs_targets_add_dirs():
> 
> out:
> 	damon_sysfs_targets_rm_dirs(targets);
> 	kobject_put(&target->kobj);
> 	return err;
> 
> If damon_sysfs_target_add_dirs() fails, the target is not yet in targets_arr.
> Does putting the kobject without a preceding kobject_del() leave the
> successfully added sysfs directory lingering, leading to -EEXIST name
> conflicts on retries?
> 
> Similar error paths missing kobject_del() appear in:
> - mm/damon/sysfs.c:damon_sysfs_contexts_add_dirs()
> - mm/damon/sysfs.c:damon_sysfs_kdamonds_add_dirs()
> - mm/damon/sysfs.c:damon_sysfs_schemes_add_dirs()
> - mm/damon/sysfs.c:damon_sysfs_probes_add_dirs()
> - mm/damon/sysfs-schemes.c:damos_sysfs_populate_region_dir()

Yes.  Sashiko reported same issues in other replies to this thread and I will
fix thse in the next revision.


Thanks,
SJ

[...]
