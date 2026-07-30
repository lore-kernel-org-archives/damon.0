Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE832392822
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384471; cv=none; b=VHRSKK9hNv6H+txJDYD1ctFFEKLvGOKXELgeCRIoU0SDat4M4Ay+cquuqANOL15c5vdJum7u/U9x+UJrjHkzUInOk5v+D3JDMCVRk1bB6JILG0Nsai6Xvm/dnvAHlbMTr8TUC+/6xZNIlHmY5QdSjJQ9m9Ac3a1cFt14VJ7bXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384471; c=relaxed/simple;
	bh=MkPTnWgZc9FvewFm50FlCKOR33nmGDxBLDOzT11+oug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0qBR8jYMI9wOv25YrA/wzQ25N2MrZovVVxeJ41UvPS/o6pn8wx3//9ZqtYbWlzCcuh5rG5oz2pn5b0o5smKKWach3vpZA56f8K7dNdu9rhOjBOemsF8X5zqyAEg5eBMZj47FALVP0odTApg/yAmZkUhh+ZTEc2RfSKsEkpvwiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3NIqxWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3NIqxWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465CF1F000E9;
	Thu, 30 Jul 2026 04:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785384468;
	bh=gTc/+pWCs9WTZ1KhEyFbLcIoNcgfPm/5fObiZV2jiHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A3NIqxWT6NbwgrSo12J97Ou6Z3SN3zTucl91rllzqWLzJoW7RwWvZzicYjKkFH2zD
	 3HYTlsZa23ocPvw9NUykmSVkTCUI9U0ahcC5ukMVKbQ9szxfP48AxHe3WeyqklUEmD
	 xQqA3btHJDn5ux9FVPNr7fZabYTTo9X1NAJ0weng/FqQGhM4bnPeupRiyn2IGg1UYS
	 wLmxFDaabFq2hJZebck8paeAbgRRsfYGGEx62Vn5E1m5mQilTy6S3Z7bGGju/VhvuT
	 siqQFZW5h65e9ubJ/YeKC8i23pEMNMVhAHktp8gCurOo9mRlq4ezWV4TXIgzZqKI3O
	 +ucb/ahKGK52Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y] mm/damon/core: validate ranges in damon_set_regions()
Date: Wed, 29 Jul 2026 21:07:39 -0700
Message-ID: <20260730040740.140836-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730011827.71CE11F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 30 Jul 2026 01:18:26 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] The validation check fails to consistently reject unaligned zero-length regions, allowing them to bypass validation and silently expand.
> - [High] The ALIGN() macro overflows to 0 when evaluating regions near the end of the 32-bit address space, causing valid regions to be erroneously rejected.
> 
> Pre-existing issues:
> - [High] Pre-existing leak of `struct pid` references if target addition or context setup fails during sysfs input application.
> --
> 
> --- Patch [1]: [PATCH 6.1.y] mm/damon/core: validate ranges in damon_set_regions() ---
> commit a1c890d67da57c98800fdd95b91daeac6ab475ab
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: validate ranges in damon_set_regions()
> 
> This commit adds a validation check in damon_set_regions() to ensure that the
> provided region ranges are valid. It aims to prevent empty or negative length
> regions from causing warnings and divide-by-zero errors in the core logic.
> 
> Link: https://lore.kernel.org/20260630035221.146458-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 4b434ebd37c53..0a0bb033f28a4 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -212,6 +212,12 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >  	unsigned int i;
> >  	int err;
> >  
> > +	for (i = 0; i < nr_ranges; i++) {
> > +		if (ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION) >=
> > +				ALIGN(ranges[i].end, DAMON_MIN_REGION))
> 
> [Severity: High]
> Does this logic successfully catch unaligned zero-length regions?
> 
> If a user configures a region with start and end both at an unaligned address
> like 4097, ALIGN_DOWN(4097) evaluates to 4096, and ALIGN(4097) evaluates to
> 8192. The check 4096 >= 8192 is false, which allows the invalid empty region
> to bypass validation and silently expand into a full page.

No problem.  It is an intended behavior.

> 
> [Severity: High]
> Will this ALIGN() check overflow on 32-bit systems when evaluating regions
> near the end of the address space?
> 
> If the end address of the physical memory resource is ULONG_MAX (0xFFFFFFFF),
> ALIGN(0xFFFFFFFF, 4096) overflows the 32-bit unsigned integer and evaluates
> to 0. This makes the check ALIGN_DOWN(start) >= 0 unconditionally true, which
> erroneously rejects valid memory regions and prevents DAMON initialization.

For 32 bit systems having >4GiB memory, we provide addr_unit feature.  The user
could avoid the issue by using that.  So no problem.

> 
> > +			return -EINVAL;
> > +	}
> > +
> >  	/* Remove regions which are not in the new ranges */
> 
> [Severity: High]
> This is a pre-existing issue, but does damon_destroy_ctx() leak struct pid
> references if context setup fails?
> 
> Looking at damon_sysfs_build_ctx() in mm/damon/sysfs.c:
> 
> 	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
> 	if (err) {
> 		damon_destroy_ctx(ctx);
> 		return ERR_PTR(err);
> 	}
> 
> If damon_sysfs_apply_inputs() successfully adds targets (incrementing struct
> pid refcounts) but a subsequent step fails, damon_destroy_ctx() is called.
> 
> Since vaddr ops do not define a .cleanup callback and the before_terminate
> callback is never executed, the damon_target structures are freed without
> calling put_pid(), permanently leaking the PID references.

Good finding.  Mainline tree avoided this issue by refactoring the code, with
commits including 7114bc5e01cf ("mm/damon/core: add cleanup_target() ops
callback").  Porting the all commits would be challenging.  I will work on this
with a dedicated fix.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260730010151.119009-1-sj@kernel.org?part=1


Thanks,
SJ
