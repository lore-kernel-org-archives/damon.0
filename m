Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2A330B07
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901415; cv=none; b=oy2N366VUh+RsTSQ1KWNqbrwHP9lcEVMtJDl897ba8opTRG7OyEAyYwj3KTvaXWPvyhRNPVbNDeCvR6Qjx3Av8sb/QFk27xOMnL8Vq6AZ9lji/v77RO3zLjDEgTEr4apBj276e4RhvMqUGrKgbuh8QLh4zvKVXS23I1kt07SHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901415; c=relaxed/simple;
	bh=OSu4ICw+REBHZnPnQvRj79Y9M4DB1X8pIkFUjU6QUiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWigUNplxw+siTxOZBbfSYyHyn3Jy+ebwi0A7EgSVXYO0f6KzqbxRi4QRNIyHm4fcr7rhovLxsX/lskxRnF5REZukuNSN1QYUuJLodfKynmuRGUUjnCP1UylBYvpNu2kPX+5RvlvF8VnW0gPaSlj9KLgSinbin8QabLj6+fzVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alu+qbPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alu+qbPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA161F000E9;
	Fri, 19 Jun 2026 20:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781901414;
	bh=5CVpsCRohKDIanBDjhZ2E+qt+EdAl6YaJW6PU1yon0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=alu+qbPimWAB8EGkyb2BFNGLnnctH2/DZfo1rncFvMMpD1POmeJ9ooow4E1qW/hjT
	 WUS2qvGvLWAxzELILnwPRbY9kqawlJvWpqseuLncAi4eFr0lDiY1UJ3oAesY+c16EK
	 w8dDF/YE91gRZeII5vde5hfGxFod0KgL4oBSokPNXGUGNf9VH3FA0H1WCv6/87WYlB
	 ZBZRlA2lz/e5E2h/g8gUohQJr4n7TZMbq5h9hGGUOWb8byW6t62RWbwvAZ6CvUbQoj
	 QzbPkCxP+XAY2Byf24L4uo1Rjt06f/EM9S0F2wRfsVXNRvAgJefz7mlNinhTRE/4iH
	 Qvec2taet6AzQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 13/13] mm/damon: remove damon_region->nr_accesses_bp
Date: Fri, 19 Jun 2026 13:36:43 -0700
Message-ID: <20260619203643.146096-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619194902.A86311F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jun 2026 19:49:02 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Stale comment in kdamond_fn() references the removed nr_accesses_bp field.
> --
> 
> commit 7fe8c1a02c74da4804760b45a04f15189947a500
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon: remove damon_region->nr_accesses_bp
> 
> This commit removes the unused nr_accesses_bp field from struct damon_region,
> as well as its associated kernel-doc comments.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 4f73d27979f0b..a18d905f28e14 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -77,7 +68,6 @@ struct damon_region {
> >  	struct damon_addr_range ar;
> >  	unsigned long sampling_addr;
> >  	unsigned int nr_accesses;
> > -	unsigned int nr_accesses_bp;
> 
> [Severity: Low]
> Is this a minor regression that leaves a stale comment in kdamond_fn()?
> 
> Looking at mm/damon/core.c, kdamond_fn() still explicitly references the
> nr_accesses_bp field:
> 
> mm/damon/core.c:kdamond_fn() {
>     ...
> 				 * information reset for all regions.  Then,
> 				 * following kdamond_reset_aggregated() call
> 				 * will make the region information invalid,
> 				 * particularly for ->nr_accesses_bp.
>     ...
> }
> 
> Should this comment in mm/damon/core.c be updated or removed to reflect the
> field's deletion?

Nice catch.  I will remove the mention of the field in the next revision.


Thanks,
SJ

[...]
