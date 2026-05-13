Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A531A046
	for <damon@lists.linux.dev>; Wed, 13 May 2026 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635164; cv=none; b=WGx2zLI32omzcAX089mxWfmT1U9bBwjXaecSzVyaTl4hERI0ngnkipDVlSXLmTVh3frk9aDNRxgXMvSjZKkhjMtrUXpdsX7Yt1021fogpzrdpG4TE8gXrCK/o+k7ePGHqaZKfMOexOnCyqXAM90PiIjrbgrGLJV1qA+Q0u0Tqcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635164; c=relaxed/simple;
	bh=SMr7UJ9w6M7iT98EsueHOhUR1h/fk096I17rPGV3Swo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4bwMlDfVNH5AGB9ExUqm2fUB7PUdot08h5uoA/imKaQ/R4Mo3K+jSiVsuJLI+AjBxlBQ++Lr7k+NsPwusGhnY5fYfbhS33aJrchvlyqKZ7ZaQzDKGdaNppVy/r9+/GdYqxMWFrknzWL7v6lwJB3D1NYGI3RG2h/xzYi0AI/PGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3jBncux; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3jBncux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1C5C2BCB0;
	Wed, 13 May 2026 01:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778635164;
	bh=SMr7UJ9w6M7iT98EsueHOhUR1h/fk096I17rPGV3Swo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3jBncuxHF5sMEf0BIwkEH70pjW0x1DAmOKVoC4d2rCoV4BTxgt7/mnxlPFoRqAXU
	 W30lGb8orm21Eq0+dhRVOOafcL/v6zg0dnHlOvagXNukxYr2qSxVLmD7GDoqbE8lYY
	 pwoQ+gePhCcTlQiTuxUj2TGrH6mfTJQZdiRVqklOgaC4ckw1eseVewOuM41CquryRD
	 5K+bd9NN+7IjaB3tHGhVXhn5f15Ni7XNx7UOeFkud1L4nwPiPxPWng7E743Roa+Vuh
	 VTXh/oXYnELW+TenuUVuY6isE0jqzIvcxS+0gMNOEObCf2bIDw5iAXF43RPRgR0HtH
	 NR0jQYFYYaM0w==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Vineet Agarwal" <agarwal.vineet2006@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon/sysfs-schemes: fix double increment of nr_regions
Date: Tue, 12 May 2026 18:19:19 -0700
Message-ID: <20260513011920.119183-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513000838.D0CFFC2BCB0@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 May 2026 00:08:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] The patch fails to restore the documented 0-indexed ABI, leaving region directory names 1-indexed.

Not this patch's fault.  No real issue.

> - [Critical] Pre-existing: Use-After-Free and list corruption due to synchronous `kobject_put()` assumption.

I will work on this.

> - [Medium] Unbalanced `nr_regions` increment on `kobject_init_and_add()` failure causes a permanent state leak.

Not this patch's fault.  No real issue.

> --
> 
> commit 66d182db7d03e02c982ddd51e0ba311b2642559b
> Author: Vineet Agarwal <agarwal.vineet2006@gmail.com>
> 
> mm/damon/sysfs-schemes: fix double increment of nr_regions
> 
> This commit changes damos_sysfs_populate_region_dir() to use the already
> incremented value of nr_regions for naming new region directories,
> preventing the skipping of directory numbers.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 622c3799db87b..5d966ac864193 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -2998,7 +2998,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
> >  	if (kobject_init_and_add(&region->kobj,
> >  				&damon_sysfs_scheme_region_ktype,
> >  				&sysfs_regions->kobj, "%d",
> > -				sysfs_regions->nr_regions++)) {
> > +				sysfs_regions->nr_regions)) {
> 
> Does this change the ABI from 0-indexed to 1-indexed? Since nr_regions is
> incremented just before kobject_init_and_add(), the first directory will be
> formatted with the value "1". The kernel documentation indicates these
> directories should start from 0.

Not a new behavior.  And it should be fine.  Users could reasonably deal with
it.  Refer to my first reply to the patch for more details.

> 
> >  		kobject_put(&region->kobj);
> 
> If kobject_init_and_add() fails here, we call kobject_put(&region->kobj) but
> do not decrement sysfs_regions->nr_regions. Will this permanently inflate the
> counter and cause subsequent directory names to skip numbers, since
> damon_sysfs_scheme_regions_rm_dirs() decrements the counter based on the
> remaining successfully added elements in the list?

Yes, and it is an old behavior, so nothing to blame for this patch.  Also same
to the 1-index, users should be able to reasonably handle it.

> 
> There might also be a pre-existing issue with the region list lifecycle. If
> damon_sysfs_scheme_regions_rm_dirs() iterates regions_list and calls
> kobject_put() on each region's kobj, does it assume the kobject release
> function will synchronously remove the region from the list?
> 
> If the release is delayed, for instance by external sysfs references or
> CONFIG_DEBUG_KOBJECT_RELEASE, the object could remain on regions_list. If
> damos_sysfs_populate_region_dir() then concurrently adds to regions_list
> with list_add_tail(), could the delayed release race and cause list
> corruption?
> 
> Could a subsequent call to damon_sysfs_scheme_regions_rm_dirs() traverse
> freed list nodes and call kobject_put() on zero-refcount objects if the
> release hasn't completed?

Good finding, I will work on this.


Thanks,
SJ

[...]
