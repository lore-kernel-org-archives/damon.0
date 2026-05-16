Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2027E0E8
	for <damon@lists.linux.dev>; Sat, 16 May 2026 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894872; cv=none; b=IhQLEa1XlFwIYS5Sz7sryuuPzcA0Hq1JJXCUBXBlPr4oy4oZ0mVDsCVOdffMGSK0gcajXMfjI9+Ml4k/IsivBcGIQaKC66HqM5YiRYDPpDgy4v1KoaOzZZzmgMzInYzDz/rdnajnmIMXtwpqmGrXtjehKsoNLMx4sNKPK7ei4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894872; c=relaxed/simple;
	bh=cVABFEo8ZAzAHSBlzcWpzurvR2si7CcY11T6/64dBeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSGIhxLPCfNExsQUdQD2N3dEQWsGUspBNVUnxWC7IKQ86g0HwTBTqCPpboco1k9CLwJvuU2l3sTef/HDS0fPSFavgL9IfYva0Ma1fpuKAR+TMleGr3nE+uYsBngwoW2NsdRjh7dEjsfJg3L6Y2kcleiNdlArexsJ0xHaJyKtoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd7+8sqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd7+8sqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A43C2BCB0;
	Sat, 16 May 2026 01:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894871;
	bh=cVABFEo8ZAzAHSBlzcWpzurvR2si7CcY11T6/64dBeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jd7+8sqezw8NOio6z4+GvBJrorM0DwCJ/YsCP27IO5XrW4vBld5mRAqrPgxpGT9gb
	 BVcPq2OnBJ5MInaZqC5zPw3Fk5K1HPGSgKMSoGMZwz9GKHq4djNIaiPkKEr18LPQFZ
	 33s9eWfiLxm9p8Kweq6amRtxaOfXdS0DGESxzaGYEqZ8XSrMMJMXKOvTQL5os/44eN
	 6bm8oMAv52MYHOKhGLKl1TPuuWKN8MCU3vhj4g44I42u2x8WoE1E6jofWMoROiZtrX
	 E0Pjvj6GQf54uxARaagQLtxnDQNbPg7FggMGKCHdtoh1y8L5HO/WOyhztC/9YaX38N
	 NSYJmPDtjmsOA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 15/28] mm/damon/sysfs-schemes: implement tried_regions/<r>/probes/
Date: Fri, 15 May 2026 18:27:43 -0700
Message-ID: <20260516012744.146410-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515012715.D161EC2BCC6@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:27:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] Use-After-Free and Double-Put of kobjects due to delayed release
> - [High] Lockless list corruption in delayed kobject release
> - [High] State variables (`nr_regions`, `total_bytes`) leak on error paths
> - [Medium] Undefined Behavior from unvalidated pointer arithmetic on NULL
> --
> 
> commit 2a0f4a006e3babc368de4c2d048d4ec6e1aec966
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: implement tried_regions/<r>/probes/
> 
> This commit adds a probes/ sysfs directory under DAMOS tried regions to
> show per-region probe hit counts.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 245d63808411a..0bca89217b8fa 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> [ ... ]
> > @@ -34,10 +61,36 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
> >  	sysfs_region->ar = region->ar;
> >  	sysfs_region->nr_accesses = region->nr_accesses_bp / 10000;
> >  	sysfs_region->age = region->age;
> > +	sysfs_region->probes = NULL;
> >  	INIT_LIST_HEAD(&sysfs_region->list);
> >  	return sysfs_region;
> >  }
> >  
> > +static int damos_sysfs_region_add_dirs(
> > +		struct damon_sysfs_scheme_region *region)
> > +{
> > +	struct damos_sysfs_probes *probes = damos_sysfs_probes_alloc();
> > +	int err;
> > +
> > +	if (!probes)
> > +		return -ENOMEM;
> > +	err = kobject_init_and_add(&probes->kobj, &damos_sysfs_probes_ktype,
> > +			&region->kobj, "probes");
> > +	if (err) {
> > +		kobject_put(&probes->kobj);
> > +		return err;
> > +	}
> > +
> > +	region->probes = probes;
> > +	return 0;
> > +}
> > +
> > +static void damos_sysfs_region_rm_dirs(
> > +		struct damon_sysfs_scheme_region *region)
> > +{
> > +	kobject_put(&region->probes->kobj);
> 
> If damos_sysfs_region_add_dirs() fails, region->probes remains NULL.
> If damos_sysfs_region_rm_dirs() is subsequently called on this region,
> will &region->probes->kobj evaluate the address of a member of a NULL pointer?
> 
> While this evaluates to a NULL pointer because kobj is at offset 0, is it
> safe to rely on this undefined behavior, or should there be an
> if (!region->probes) check?

Good finding.  I think we shouldn't reply on the behavior.

But, this happens because damos_sysfs_populate_region_dir() adds the region to
the list even if the damos_sysfs_region_add_dirs() failed.  I will update the
part to add region only if the region_add_dirs() success.

> 
> > +}
> > +
> >  static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
> >  		char *buf)
> >  {
> > @@ -165,6 +218,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
> >  
> >  	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
> >  		/* release function deletes it from the list */
> > +		damos_sysfs_region_rm_dirs(r);
> >  		kobject_put(&r->kobj);
> 
> If the kobject release is delayed (e.g. because userspace holds a sysfs file
> open in the region directory, or CONFIG_DEBUG_KOBJECT_RELEASE is enabled),
> the region remains on the regions_list.
> 
> If a user consecutively writes to the sysfs state file to clear regions,
> damon_sysfs_scheme_regions_rm_dirs() will iterate over the same region again.
> 
> Will this call kobject_put(&region->probes->kobj) a second time on the
> already-freed probes kobject, triggering a use-after-free and refcount
> underflow?

Yes.  A similar issue was previously found by Sashiko, and I'm working on [1]
it.

> 
> Should region->probes be set to NULL after the put to avoid this?
> 
> Also, regarding the list management, this isn't a regression introduced here,
> but the comment mentions the release function deletes it from the list. If
> kobject release runs asynchronously in a worker thread, can the release
> function list_del() run concurrently while this loop iterates the list,
> silently corrupting the doubly-linked list?

This is also previously answered [1], and I'm working on it separately.

> 
> >  		regions->nr_regions--;
> >  	}
> > @@ -2932,9 +2986,14 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
> >  	if (kobject_init_and_add(&region->kobj,
> >  				&damon_sysfs_scheme_region_ktype,
> >  				&sysfs_regions->kobj, "%d",
> > -				sysfs_regions->nr_regions++)) {
> > -		kobject_put(&region->kobj);
> > -	}
> > +				sysfs_regions->nr_regions++))
> > +		goto out;
> > +	if (damos_sysfs_region_add_dirs(region))
> > +		goto out;
> > +	return;
> > +
> > +out:
> > +	kobject_put(&region->kobj);
> 
> Earlier in this function, sysfs_regions->total_bytes is increased, and
> sysfs_regions->nr_regions is incremented.
> 
> If damos_sysfs_region_add_dirs() fails and the code jumps to the out label,
> these state variables are not reverted. Since
> damon_sysfs_scheme_regions_rm_dirs() only decrements nr_regions by 1 per
> region in the list, do these counters permanently drift, causing accounting
> issues?

Yes, good finding.  I will update this to increase nr_regions only when the
add_dirs() success.

[1] https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org


Thanks,
SJ

[...]
