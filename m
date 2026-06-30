Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2C2BB1D
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778753; cv=none; b=G1ARrN3KA/UfCkt5wj6zaNSrAtH5bhEV4L8jfNGkxhhAJWoLK31B7i+4FFm25H9VSMWCmYnQpc1UhF8+1kM9i1BAT68UVNYthCdwtWmYKiIwJ3wzYGCJ3J15n0cGvj32/ZyeoVvCZIAFtKl694MHZ/2hK0q1CdXCBfajmokbpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778753; c=relaxed/simple;
	bh=W5GpKS8JK9AdK3LlSCGXpX+zH5BT3Bik9pzCejAPmsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdSEluWrapa6EOj62wQM/SCa6MhSdDPnPmqkh7jE/ffdngX9jY670LbCFAqMWuLR/bEnQ8zHukQDeFCeSqqv/tl+7a8SCbx5S64GvL76nsX5maA94djTwy4cKFBt4wHb2EuYdLFfMYRK7t2qFkNapcWCqe8YZ3yFRdUdnxo0HeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7NGq9io; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7NGq9io"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020E21F000E9;
	Tue, 30 Jun 2026 00:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782778752;
	bh=nNGw0fwJ6aBNu/mhMkhxG4LRBwD3CXn1y7VBhhAYZa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7NGq9io1i8lp+CNmikMCDHg/BTjGOn/WPY+ABayaTMjl68Z4Q9yZ6oJLzF8ozWFg
	 Rg9LbiQJrMj48gKAPobHLKIeTMV8m/aWNbBZauq006k8FCvbtbV5E8bkpG3W32W1Gt
	 PK3Nnu7Jqt0l4/9wzlKJVEKZBaxmJ+Knk5bxMbC4FcGXoEKQjIBwl3TbLV3qekhNWw
	 zeZF0pewXE5LEVaCEfC2QtleKCb8uSo2xjUcsHSRv8QBAiauszJFZMi+yp7fAamuw0
	 Fz6+jrA1EZE+XYnGOgkD1GdFzSD97MrFYQ+n4IKquhHCFovkfLodHB0FikL+yqqGof
	 nzaJtC5b0SDWQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v3 1/2] mm/damon/core: split a fraction of regions when nr_regions exceeds max/2
Date: Mon, 29 Jun 2026 17:19:04 -0700
Message-ID: <20260630001905.140935-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629150812.065511F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 15:08:10 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Cross-context state corruption and data races due to the use of a static local variable `rotation`.
> --
> 
> commit 696204689b6ff0a9b6ca3153698c49bfe10cff24
> Author: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> mm/damon/core: split a fraction of regions when nr_regions exceeds max/2
> 
> This commit modifies the kdamond_split_regions logic to split only a fraction
> of regions when the region count exceeds half the maximum, rather than
> returning early. It uses a rotating offset to select which regions to split,
> refining the count smoothly as it approaches the maximum.
> 
> Link: https://lore.kernel.org/20260626085851.70754-2-jiayuan.chen@linux.dev
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 027250e43c66f..9bbc60a2a8c05 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3234,6 +3234,37 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
> >  	}
> >  }
> >  
> > +/* Split one in every @split_step regions into two, from a rotating offset */
> > +static void damon_split_some_regions(struct damon_ctx *ctx,
> > +				     unsigned long split_step)
> > +{
> > +	static unsigned long rotation;
> > +	struct damon_target *t;
> > +	struct damon_region *r, *next;
> > +	unsigned long offset = rotation++ % split_step;
> 
> [Severity: Medium]
> Will this shared static variable cause data races and logic flaws if
> multiple DAMON contexts are active?
> 
> Since rotation is declared statically, multiple kdamond threads could
> concurrently increment it without synchronization. This might lead to
> data races and cause different contexts to overwrite each other's
> rotation offsets, breaking the isolation of the splitting algorithm and
> resulting in uneven or skipped splits in some contexts.
> 
> Should this state be kept per-context instead of using a static local
> variable?

As I replied [1] to same question on v2, We don't need a strict round robin
here.  We need just a level of fairness.  I think this is no problem.  Of
course we could revisit this if it turns out to a real problem in the real
world.

[1] https://lore.kernel.org/20260626144906.86649-1-sj@kernel.org


Thanks,
SJ

[...]
