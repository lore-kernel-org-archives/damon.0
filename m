Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206AE3B19A9
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029245; cv=none; b=CgXn7IjjInyQjFk0uojWDP6GirxmbsxtRBvRXKCHameACnHOEhOzM88VTxv53jzp+i1umtNFCqwyWvg2zpNTi5VVd9RoDsaIFwbqRcqwsjJBPzwO+MMxaeowi4DCTpaRZ3iiWRZoun/uqJQ2xqGebgXfgIAYUWoNTumHY5K+dY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029245; c=relaxed/simple;
	bh=QCfPM4m/EDnluzBld2wxQSlPodyHk9fcrvjqyR3ggGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GepGs++GMQFLSgDr7mzmPB0571lzkoWcRMLJRKbQx8HpKZhKxhSobI3vue1166XeJl8sPj+Q4rtUylSaKrf7DqccXiVhvIvI3I36knQLoVquh+HnnzwzxNJyo/cqNx/bKqtBLkUTdk7T8+Vzf/l3hizSvSII9MUZnXWyubwFJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5f2YyLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5f2YyLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB591F00A3A;
	Thu,  2 Jul 2026 21:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783029243;
	bh=9oysDJdznOcEgi/iftmDoOirgEUZT90l7fk7XrGoIiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a5f2YyLM9E3xoN9h2MXzycmWMujJUbVfsjwhEqz2n1SSREtCFNSCcQOLg3Shq6ITW
	 EMpqZITUEFfq6v6TA0LkFvMwKvkXWnJmIFP5l68mwUien2yiettMH5aeCC14slK2qD
	 1COakMrx0O51O/B14ODFac+AidWHXNKnCGLyu4GIVGI8RhjfcRxh0wK7bJqis4e3Qa
	 u8evaBPbfPiiMVf4bT3UM51XgqXzip3fhdaHMs+1LEg186KX9/mYeQALSMtmOCZfeO
	 1XDWOFBdRElAbvDxRnKjUM/yEBfp8qYHw15cDxbcEFd7UgJrXfuQXYGmL5fwI0orEu
	 3d7IstXaxmVKg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 8/8] mm/damon/sysfs: remove region size validation
Date: Thu,  2 Jul 2026 14:53:56 -0700
Message-ID: <20260702215356.97530-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702211540.07DA01F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 02 Jul 2026 21:15:39 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the `start > end` validation allows negative-sized regions to bypass subsequent validation, resulting in overlapping regions and eventually negative-sized regions in the DAMON core, leading to unbounded memory allocation (OOM).
> --
> 
> commit d23d0a5af36c320aac75064c21548cc9de76c4f1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: remove region size validation
> 
> DAMON_SYSFS validates user inputs for monitoring target regions to
> disallow negative size regions.  DAMON core assumes only positive size
> regions, though.  The validation is incomplete.  Fortunately
> damon_set_regions(), which is eventually used by DAMON_SYSFS, does the
> complete validation.  Remove the incomplete and unnecessary validation.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index e666dddf1feba..b65651498e0d1 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1987,9 +1987,6 @@ static int damon_sysfs_set_regions(struct damon_target *t,
> >  		struct damon_sysfs_region *sys_region =
> >  			sysfs_regions->regions_arr[i];
> >  
> > -		if (sys_region->ar.start > sys_region->ar.end)
> > -			goto out;
> > -
> 
> [Severity: High]
> Does removing this validation allow negative-sized regions to bypass the
> subsequent overlap checks in damon_sysfs_set_regions()?
> 
> If we have an inverted region (e.g., start=2000, end=1000) followed by another
> region (e.g., start=1500, end=3000), the overlap check in
> damon_sysfs_set_regions() evaluates:
> 
> 	if (ranges[i - 1].end > ranges[i].start)
> 
> Which results in ranges[0].end (1000) > ranges[1].start (1500).
> 
> This is false, meaning the inverted region bypasses the overlap check.
> 
> Will this inverted region also bypass the alignment-based bounds check in
> mm/damon/core.c:damon_set_regions()?
> 
> mm/damon/core.c:damon_set_regions() {
> 	...
> 	for (i = 0; i < nr_ranges; i++) {
> 		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=
> 				ALIGN(ranges[i].end, min_region_sz))
> 			return -EINVAL;
> 	}
> 
> If the regions fall within the same alignment block (e.g., start=2000 and
> end=1000 with min_region_sz=4096 align to 0 and 4096), the check evaluates
> 0 >= 4096, which is false, passing the invalid input to the core.
> 
> When the negative-sized region reaches mm/damon/core.c:damon_apply_min_nr_regions(),
> can this cause an out-of-memory loop?
> 
> mm/damon/core.c:damon_apply_min_nr_regions() {
> 	...
> 			while (damon_sz_region(r) > max_region_sz) {
> 				damon_split_region_at(t, r, max_region_sz);
> 				r = damon_next_region(r);
> 			}
> 
> The inverted region size would underflow to a very large number, which appears
> to cause this loop to continuously split the region, allocating region structs
> until the system runs out of memory.

We are working on a fix [1] of this in a separate thread.

[1] https://lore.kernel.org/20260702170326.87255-1-sj@kernel.org


Thanks,
SJ

[...]
