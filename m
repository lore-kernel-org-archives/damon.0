Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4BB7080D
	for <damon@lists.linux.dev>; Wed, 24 Jun 2026 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312986; cv=none; b=gFe7FQux2V9rFyjBcGwyNx3IMLNhdDqdtsWzccG3jCmTrIBZ1I4WT31jmUb4kQjWYkMXlgVnipZwCmcIShlsV5aXPn0ZwwmoUYphKMi3KlFU+t3oQPoMbyMgZ1k4tGXXlpDCTPSRNg1MBOdZEYQMestQM8GP4JDI5hxEVnBaZkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312986; c=relaxed/simple;
	bh=m1Ghz2zCosCICehLFgWTWdwxpVWCq855mhI8FXV4K58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6Eiop3yknnYMUI5URPe8SBBOLZJ3TKcCRScjudgcXEvwsLxrKyW/1K1nxU19erDWta5vMvN1VZ0az7W0O1mgDDXDOwrjiLYi0g8lxtQHURwrW2CK0Q24OsrPGDTpn8itaAXzdAM7TkMb4KcLzCeX3dyudDFM9ZLJUbXyPnFJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMDqFHYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMDqFHYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EA11F00A3A;
	Wed, 24 Jun 2026 14:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782312984;
	bh=KPwftRQ8xnhhZbR0y281yyfH8ninPosFGwGIpR9p0Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fMDqFHYvYchX5jvxBnGrEO7kFh5/8ZtfX4L/TJsMjPBObg6tvXTMQOfv3L1TGPMmn
	 9a0uLUhoZSmJPXh219CZjWo5sW2HhyLaJLmZXDlNGKNj+UAqKVW0xxJ31s4CSlQoR3
	 +535yxSNHYWwv0y+VNV6Oz6Vz2LBsCC42UsiqgkH4gpphjGPQYIZ5ajuDQBSj74sgO
	 J8iE4t6vvo14lwPaZVf9mjQCrnAoOyyfX52GBpfSR8/RqAUib7/WZA89ao63N3xwtS
	 J9uIlev/dKPhLSO/aNUzAWje+GwWl8ATGitRUS8+ShSZaIiKc17tsuc0a6kg9xZ6pU
	 7bKoHJSUpY+OA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: Re: Roadmap for extending DAMON beyond pte-accessed bit
Date: Wed, 24 Jun 2026 07:56:14 -0700
Message-ID: <20260624145614.89437-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260525225208.1179-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 May 2026 15:52:08 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> TLDR: Let's extend DAMON for data attributes monitoring, andd then further
> extend that for multiple access check primitives including page faults, perf
> memory-access events and optimized AMD IBS-like h/w feature drivers.
[...] 
> Roadmap
> =======
> 
> Assuming you agree to use the data attributes monitoring interface, I suggest
> us to do the work in below roadmap.
> 
> Milestone 1: PTE Accessed bit as one of the data attributes
> -----------------------------------------------------------
> 
> I will work on stabilizing and further extending the data attributes interface
> and internal framework to be able to support PTE Accessed bit.  This may take
> no small amount of efforts, but hopefully doable by the end of this year.

Let me share more detailed plan for this milestone.  Nothing is set on the
stone.  Everything can be changed on the road.

The overall goal is, making attributes monitoring be able to do everything we
are doing now with PTE Accessed-bit based monitoring.  It is needed because we
want to do everythin we can do now with the PMU/page fault-based DAMON.  Also
it is needed because we will need to deprecate nr_accesses in long term without
breaking users.  For this, below changes will be made.

1. Support moving sum for probe_hits

nr_accesses is providing a pseudo moving sum for convenient and fast monitoring
snapshot retrieval.  Data attributes monitoring results (probe_hits) is not.
To make attributes monitoring be a foundation for the future PMU-like things
based data access monitoring, we will first make probe_hits be able to provide
the psuedo moving sum.  Currently two patch series for this purpose are posted
on the mailing list:

- nr_accesses_bp infra cleanup/optimization
  https://lore.kernel.org/20260622142139.30269-1-sj@kernel.org
- exposing probe_hits pseudo moving sum
  https://lore.kernel.org/20260621214231.13449-1-sj@kernel.org

I aim these to be merged into the next merge window (7.3-rc1).

2. Support attrs-only monitoring

As a next step, we will add an toption to stop doing the PTE Accessed bit but
only attributes monitoring.  It will allow users to set weights for each probe,
and do the regions split/merge operations based on the weighted average of the
probe_hits.  In this way, DAMON can run in two modes: access + attrs and
attrs-only modes.

3. Extend attrs for PTE Accessed bit check

Further, we will extend DAMON attributes monitoring to handle PTE Accessed bit
check.  We will extend it to let users configure probing preparation
operations.  The first operation to support will be the PTE Accessed bit
clearing operation.  Together, we will introduce new DAMON probe filter that
checks the PTE Accessed bit.  Using those, users will be able to do the
PTE Accessed bit based access monitoring in attrs-only monitoring mode.

4. Extend attrs for DAMOS

Finally, we will extend DAMOS to be able to run with probe_hits.  That is, it
will be extended to let users configure the DAMOS target access pattern and do
its quota-prioritization based on the probe_hits.

After the four major changes are made, the attributes only mode DAMON can do
everything current DAAMON is doing, without nr_accesses.  We will then move on
to the milestone 2 of this project, and start a long term nr_accesses
deprecation.

I hope all changes to be landed by 7.5-rc1.

Please feel free to let me knoow if you have any questions.


Thanks,
SJ

[...]
