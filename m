Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A161D5CC9
	for <damon@lists.linux.dev>; Fri, 22 May 2026 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779416212; cv=none; b=kXdEOlLReOVzedZTdBDt0H+vu6iALTKbBqhcoU1kvnHnPcGHG021PVN82kffTFmpsCraxJMNZU/5P0PymAAvu2oZjlLgQRxN72uKU7CFsuWq0mdD9nzovQvf9kJ1SveIwxBYGdWPcrPfJQMv2BYnhdStwDauAGO68vsFZxgJp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779416212; c=relaxed/simple;
	bh=hivPe1xeW7A2SO8RYYLqaP+LrTGSZDlCXtTzAEg5C/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPYgDUaUHCC7OGXm03qFvfDWTTIgdaln1pfQIS1qhOiLwLgNj6BAZLkv0vma977kvsDz6x0M3p/q4bHx5T0T44E+Npu7NyHhVvFvxqeD3HbcI+p2Mm52Q77HKpn3XyQxpcprkgMPIDus7/3xqi40jSvoynscHl2km3+qJswHN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxKBhvEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxKBhvEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B2E1F000E9;
	Fri, 22 May 2026 02:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779416211;
	bh=x54Jcat3kL1SPHSo2BGoG5c4FtAjtaXnHfnbt2b5R2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KxKBhvElMX/J6ynq0987JA6JFJcjQYHKZYke/0o1mo8tExF88c/3C+33p8IE68p75
	 DBnjw8YqWmE+kIHQs5rS2q2yMXhbnnmVwx7MythcDlKowJPSyEwK2t8ShXfAZv33Sa
	 Ihw3du41nem7aNEmh3XbfiBoFUPZtMbIE2vS7OUXoumNdBPlKmwLoOD6OndNJ7TNBY
	 NYZp2FXaeCWvZVDC77zzqEkMxYJ59T5/A+lGQL6GVTQ9EqXPT6cRvLty7gtrdM0phr
	 yDgWZd1qiiQeUVeO/OoydOOb9NTxJ2P4Czjo6bXKsXeoY/E2iaEMUYgvoLpfVE9Y0q
	 /nI1pwZGkKzvQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 01/14] mm/damon/core: safely handle no region case in damon_set_regions()
Date: Thu, 21 May 2026 19:16:42 -0700
Message-ID: <20260522021642.87089-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521151929.5C25C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 May 2026 15:19:28 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] The ALIGN() macro can overflow when processing malicious or overly large user-provided region 'end' values, creating invalid regions where start > end.
> - [High] min_region_sz can be a non-power-of-2 value, which corrupts region boundary calculations when passed to ALIGN() and ALIGN_DOWN().
> - [High] Userspace can maliciously trigger a kernel warning (WARN_ONCE) by providing a region where start == end via sysfs.
> - [High] A memory allocation failure during region creation results in a partial state update without a rollback, potentially leaving the running DAMON context corrupted.

No one is caused by this patch, so no blocker for this patch.

The last finding seems worthy to separately work for.  I will work on it.

Please read below for more details.

> --
> 
> commit fa588352eaf7b151171cca8c2acb0bb710a71c75
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: safely handle no region case in damon_set_regions()
> 
> This commit refactors damon_set_regions() to explicitly handle the empty
> region list case without depending on the internal implementation of
> list_first_entry().
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 4e223857a0f99..d0bdf6e01dff8 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -356,6 +356,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >  			damon_destroy_region(r, t);
> >  	}
> >  
> > +	if (!damon_nr_regions(t)) {
> > +		for (i = 0; i < nr_ranges; i++) {
> > +			r = damon_new_region(
> > +					ALIGN_DOWN(ranges[i].start,
> > +						min_region_sz),
> 
> [Severity: High]
> This is a pre-existing issue, but can min_region_sz be a non-power-of-2
> value here?
> 
> If sys_ctx->addr_unit is set to an arbitrary value via sysfs, min_region_sz
> might not be a power of 2. The ALIGN() and ALIGN_DOWN() macros internally
> perform bitwise AND operations with ~(a - 1), which assumes the alignment
> is a power of 2.
> 
> Could passing a non-power-of-2 value truncate arbitrary bits and result in
> misaligned boundaries where start > end?

DAMON_SYSFS enforces the power of 2 using damon_commit_ctx() based parameter
validation.  DAMON_RECLAIM and DAMON_LRU_SORT also do the checks in their
..._apply_parameters() functions.  So this cannot happen.

> 
> > +					ALIGN(ranges[i].end, min_region_sz));
> 
> [Severity: Critical]
> This is a pre-existing issue, but can ALIGN() overflow when processing
> overly large end values?
> 
> If a user passes ULONG_MAX as the region end via sysfs, ALIGN(ULONG_MAX,
> 4096) will overflow and wrap around to 0.
> 
> Would this result in damon_new_region(start, 0) being called, creating an
> invalid region where start > end, which could underflow the size and cause
> out-of-bounds memory accesses?

As I previously answered [1], that input is unlikely in real use case.
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but what happens if userspace
> provides a region where start == end?
> 
> The sysfs interface end_store accepts arbitrary values, and if start == end,
> both bypass the start > end validation check. Since ALIGN_DOWN() and ALIGN()
> return identical values for identical inputs, would damon_new_region() be
> invoked with equal start and end arguments, allowing an attacker with sysfs
> access to maliciously trigger a WARN_ONCE(start >= end)?

Again, unlikely input in real use case.  To intentionally to this, the user
need sysfs write permission.  If a malicious user got the permission, I think
they can do anything bad?

> 
> > +			if (!r)
> > +				return -ENOMEM;
> 
> [Severity: High]
> This is a pre-existing issue, but does this allocation failure leave the
> DAMON context in a corrupted state?
> 
> If damon_new_region() returns NULL due to memory pressure, the function
> immediately returns -ENOMEM without rolling back the regions that were
> already removed or added in the previous loop.
> 
> Could this leave the running kdamond thread with a partially modified list
> of regions?

Yes, and the caller should do damon_destroy_ctx() of the ctx.  And DAMON_SYSFS
does that, while vaddr doesn't.  I will work on this.

[1] https://lore.kernel.org/20260521060523.80684-1-sj@kernel.org


Thanks,
SJ

[...]
