Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C0380FE0
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028919; cv=none; b=GJyPnFz2xUyxjtu2L7suTjf7ekXdM2ANkjVzbSe96B4BHQJwSUydH6JyfuUUdh3x09wQw6b0nZ1m31zDsFXg5eLH9v6X92h2mO0NJ9Nq6N8ZV/voBonVU+ilaN+2rJqRi9u4s8G2AI2ndp73AVETR7b8pxd3uN2QmlCEWltrdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028919; c=relaxed/simple;
	bh=Ccsyb8u0G7JHyVv/k0q4uZPRN0be6M05FyxhH1wgs7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu0rGaL1WKxq5EUAh3io4KyshlAhmYYGQb7VrhHw09p2aQLux9Scbz58ojYEbaNj0m+8dCY9mjZkYbFn/HEHF7LDeyG/EhGhajqh6lcy/7DkGZJ7Cn/2K+zw1xfW0xQlGdPAwzS8CWIxlDmMLO6Yp0JQTTbEB0Uv/6D2nNJoX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4AAqv8x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4AAqv8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C4A1F000E9;
	Thu,  2 Jul 2026 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028918;
	bh=mn6fspDqWWElSgEnDyz80i88sswFJBE6XFxQaIfWrc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4AAqv8xHHFiyqSpJM7sXN6ODcjbgT3RasDIaqm/G/h+DPZfmRUskjXvveMpd5nOP
	 v8CTARhkgq74AnyrXWJCC31d9HHBFPXbxruBCxD6dYZRvJ+7eJdOSf+rnxaEw56cpS
	 NDxJCv0l6SIx0q+VCkYkZzVmfynwyK5dvs/Pa5vYa5dYP6MaWt6xCte1jhFMKrUa6B
	 sfHsa1SwpobFeN93cRFg52Y/PubmeaoXT9HIBgOQpBmUj7e+hAqk5vJZtDtWyRi6lf
	 GoL88uXKYKfsicYjAVF9qGGiFbhaAy+yUqF/17rLPAHvKEnOB0z4kUlRPSe/liKbpg
	 rW5SU01O5lhXg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 6/8] mm/damon: document region size validation in damon_set_regions()
Date: Thu,  2 Jul 2026 14:48:30 -0700
Message-ID: <20260702214831.97260-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702211954.794F81F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 02 Jul 2026 21:19:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] `damon_set_regions()` creates duplicate and overlapping regions if input ranges share aligned boundaries, corrupting DAMON's internal state.
> - [Medium] `damon_set_regions()` inconsistently bypasses size validation, silently accepting and re-aligning negative-sized (`start > end`) ranges instead of rejecting them.
> --
> 
> commit ded29c13e7c58ad791814e55b8139da57477556b
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon: document region size validation in damon_set_regions()
> 
> The kernel doc comment of damon_region clearly specifies every region
> should have positive size. But it is unclear who should verify it.
> damon_set_regions() is the recommended DAMON core function for setting
> regions from the callers, and has the verification.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 805e089ff4f2f..b3c0ac5bf9b88 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -49,7 +49,8 @@ struct damon_size_range {
> >   * @list:		List head for siblings.
> >   * @age:		Age of this region.
> >   *
> > - * For any use case, @ar should be non-zero positive size.
> > + * For any use case, @ar should be non-zero positive size.  damon_set_regions()
> > + * does the validation.
> 
> [Severity: High]
> This is a pre-existing issue, but if callers rely on damon_set_regions() to
> do the validation, can it create duplicate and overlapping regions when input
> ranges share aligned boundaries?
> 
> If userspace passes multiple valid non-overlapping ranges (e.g., [0, 100] and
> [100, 200]) that align to the same min_region_sz (e.g., 4096), and the target
> is empty, the loop in mm/damon/core.c:damon_set_regions() blindly adds
> aligned ranges without checking for previous alignments:
> 
> mm/damon/core.c:damon_set_regions() {
> ...
> 			r = damon_new_region(
> 					ALIGN_DOWN(ranges[i].start,
> 						min_region_sz),
> 					ALIGN(ranges[i].end, min_region_sz));
> 			if (!r)
> 				return -ENOMEM;
> 			damon_add_region(r, t);
> ...
> }
> 
> When regions exist, the iterator is not reset per input range:
> 
> mm/damon/core.c:damon_set_regions() {
> ...
> 	r = damon_first_region(t);
> 	/* Add new regions or resize existing regions to fit in the ranges */
> 	for (i = 0; i < nr_ranges; i++) {
> ...
> 		/* Get the first/last regions intersecting with the range */
> 		damon_for_each_region_from(r, t) {
> ...
> }
> 
> It advances past the first intersection, fails to find the same region for the
> second range, and creates a duplicate [0, 4096] region, which corrupts
> DAMON's internal lists.

Yes, and we are working for this with a separate hotfix [1].

> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does damon_set_regions()
> actually fully validate the size?
> 
> The validation check in mm/damon/core.c:damon_set_regions() uses aligned
> boundaries:
> 
> mm/damon/core.c:damon_set_regions() {
> ...
> 		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=
> 				ALIGN(ranges[i].end, min_region_sz))
> 			return -EINVAL;
> ...
> }
> 
> If a user writes a reversed range (e.g., start=4000, end=1000) via sysfs,
> since 0 >= 4096 evaluates to false, wouldn't the invalid input be silently
> accepted and transformed into [0, 4096], bypassing the intended size
> restrictions?

This is an intended behavior.

Yes, this might be confusing.  But why a sane user would do this?  Maybe we can
update documentation for reducing the confusion, but not necessarily a blocker
of this patch.

[1] https://lore.kernel.org/20260702170326.87255-1-sj@kernel.org


Thanks,
SJ

[...]
