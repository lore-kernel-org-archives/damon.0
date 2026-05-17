Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77B305672
	for <damon@lists.linux.dev>; Sun, 17 May 2026 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051515; cv=none; b=K/kLLsMEBKUxcCd4yITPVJJNSLMAmuk58f2r6lupXb3qWx0h3T9+evXkBpqgtE4DtK8uC5dZkOylnPyPy56Vey2WtTLcCpjxsmJhHYRpQr9oqnD9oM0uPOGQmgMHPzkpdYBspBSK9R4l6fV1Gm3Yaavl5QlwKlmK25AvjzFnm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051515; c=relaxed/simple;
	bh=7rE/MAFE5pbqBil+terujO0QdpjvYWmjeILCUTD5w6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p91rdavJ3RfVi0yYXdPrpPms0Pom+BSOjZGEJDITxxWVJu37gSIEPaHyjp2qtlUFZNHnUmiW5eacf+CnYkZgUsWFzEM34BjAJYW0H7BN5ZlMEZYtHczxA/+/6uU6j2WRQ6kQFCqVwsZjX4b4ZpZo0w2fXvgIm/Il17CWdybR4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tfncnkf1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfncnkf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1569CC2BCB8;
	Sun, 17 May 2026 20:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779051515;
	bh=7rE/MAFE5pbqBil+terujO0QdpjvYWmjeILCUTD5w6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tfncnkf1Z5Xi3ZE5ZdtT94t3OUKHSNGEugrLzlOmJoV3FOWCrQ884pinhK/Thu121
	 CVpyx2LSddYfTvAF6MH/WMh2RgMx/csW0IBkRgpcj3WQ2ujHDPQdcvs9tICDPQpZBw
	 XLkhODr+41lbhDcQJ1HurkCjkDCS/na6phsM7g/Ea3M3aWLxhuf5ENZMP+xQoRzajs
	 1HIR9IhUCDCqVkVbFuSeWCQQN+pIT+bjiFXrpGTiiBL7y0+RjqPAOgt/rAUaYHohwB
	 Lddq4tuFiYdhURqlonA4Nb/KoJ+89jKSbHeqhY1S1pqGqRYdD93HWXs4yhMAh3+fxy
	 ZBhwesmWUuwBw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Sun, 17 May 2026 13:58:26 -0700
Message-ID: <20260517205828.6204-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260517182750.8F52FC2BCB8@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 17 May 2026 18:27:49 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Moving the `sz_filter_passed` assignment to after `kobject_init_and_add()` exposes uninitialized kernel heap memory to user space.
> - [High] Relying solely on `kobject_put()` to remove directories from sysfs leaves directories visible if references are held.
> --
> 
> commit eda0f7269f695739057cee7bd02d81742d566163
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
> 
> This commit updates DAMON sysfs to remove region objects from the linked list
> immediately before decrementing the kobject reference count to prevent
> use-after-free races. It also modifies region population to only add the
> region to the list after a successful kobject initialization.
> 
> Link: https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -163,7 +163,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
> >  	struct damon_sysfs_scheme_region *r, *next;
> >  
> >  	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
> > -		/* release function deletes it from the list */
> > +		list_del(&r->list);
> >  		kobject_put(&r->kobj);
> 
> This is not a new regression, but does relying solely on kobject_put() to
> remove directories from sysfs leave them visible if references are still
> held?
> 
> If an elevated reference count exists, such as a process having an open file
> descriptor to a sysfs attribute, the kobject is not immediately released and
> kobject_del() is delayed.
> 
> Could this leave the old region directory accessible in sysfs indefinitely,
> causing stale directories to accumulate alongside new ones? Should
> kobject_del(&r->kobj) be called explicitly before kobject_put() to cleanly
> and synchronously remove the directory?

Makes sense, I will work on this.  Not a blocker of this patch, as Sashiko also
mentioned, though.

> 
> >  		regions->nr_regions--;
> >  	}
> 
> [ ... ]
> 
> > @@ -2925,15 +2925,16 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
> >  	region = damon_sysfs_scheme_region_alloc(r);
> >  	if (!region)
> >  		return;
> > -	region->sz_filter_passed = sz_filter_passed;
> > -	list_add_tail(&region->list, &sysfs_regions->regions_list);
> > -	sysfs_regions->nr_regions++;
> >  	if (kobject_init_and_add(&region->kobj,
> >  				&damon_sysfs_scheme_region_ktype,
> >  				&sysfs_regions->kobj, "%d",
> >  				sysfs_regions->nr_regions++)) {
> >  		kobject_put(&region->kobj);
> > +		return;
> >  	}
> > +	region->sz_filter_passed = sz_filter_passed;
> 
> Could moving the sz_filter_passed assignment after kobject_init_and_add()
> expose uninitialized memory to user space?
> 
> If the region object is allocated without zeroing the memory, calling
> kobject_init_and_add() makes the region's kobject immediately visible in
> sysfs.
> 
> If a concurrent read to the sz_filter_passed sysfs attribute occurs during
> this window, could it read the field without locking and leak uninitialized
> kernel heap memory to user space? Should the assignment occur before the
> kobject is registered?

Good finding.  I will set sz_filter_passed before kobject_init_and_add() in the
next version.

> 
> > +	list_add_tail(&region->list, &sysfs_regions->regions_list);
> > +	sysfs_regions->nr_regions++;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260517175915.3352-1-sj@kernel.org?part=1


Thanks,
SJ
