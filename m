Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1855A34AAEA;
	Mon, 23 Feb 2026 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771834127; cv=none; b=YJNFo2wQrj/7T/L1e24n33J6k+WaMmHyJhKRXxpME/YIZII6jLXocnL5R/qeruo1rCWsRuJwyPWi6CPfu+XT99QsAZDMkywumKkkYFuxidApiXqugYdMQZi2D5s41V+u77Rmh2BT1ZCnIjcNNy6cw3Fl/BL0dRuwfsEIgBTGsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771834127; c=relaxed/simple;
	bh=C0LVkrERSBDXQ6ejDtm+umP0yicPpm2CRhoJWRWE03w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flfFvtN7u08JSCtzYsGpfU4PIzf7SoNHDjHPsEdVD1vL0sCcWjC/qfcr3DTF2DVxcX+9SBxapU2kYDA3BXOAaSQP5dDTGyiBv5sv8P0UXD/DJ+74ZLiu529DeE7QO7vhPPQfsgenLU+putdsLoCv1Q0nmAXvYF5dcFwMHkiCuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np2MV9DU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np2MV9DU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A34C116C6;
	Mon, 23 Feb 2026 08:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771834126;
	bh=C0LVkrERSBDXQ6ejDtm+umP0yicPpm2CRhoJWRWE03w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=np2MV9DUO+iActLJHksc9npBnrHu1EqRZMU3Z09S3skooyf15ZzLXA67f+43IjVmZ
	 3OaI+dzW/DV1b52C0vZpSz/KBBJcj78JrMXHN5xGNc+nPW5enV0zx9nxBPQtmMdM5X
	 o5gTYDLYLJv7Z0+6Mm8wkqwNe3vyv7ien7W8LIP6ypiI8SOqSTt/fe8V5Ujj7A4OVc
	 J93XB5OF8pe0xnZCiMhlxe9oaYlWfx9ivj+3TPHqrtMc8G9GLpKrd/u9X/wc6uamG1
	 mK/41ghiYV7fe9Lpbyqp2bEf4Wd36UftYPeot6M2p2oWaSLSFTfQWhFkEShVeeYaYI
	 nWGTbBD0fN54A==
Date: Mon, 23 Feb 2026 00:08:44 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Message-ID: <aZwLDAxf9eP0lPdD@z2>
References: <20260124023917.78649-1-sj@kernel.org>
 <20260124024804.78869-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260124024804.78869-1-sj@kernel.org>

Hello,

On Fri, Jan 23, 2026 at 06:48:03PM -0800, SeongJae Park wrote:
> Cc-ing linux-perf-users@ for any comment from perf people, about the use of
> perf event from DAMON.

Sorry for the long delay.

> 
> On Fri, 23 Jan 2026 18:39:20 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Fri, 23 Jan 2026 11:10:10 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > 
> > > DAMON currently only provides PTE accessed-bit based access check, this
> > > patch series adds a new perf event based access check.
> > 
> > Very interesting patch series.  Thank you for sharing this Akinobu!
> > 
> > I only took a glance on the patches, but my understanding is that this series
> > modifies DAMON to be able to enable perf events of PERF_SAMPLE_ADDR type, and
> > utilize the sampled perf events in the perf events buffer as the source of
> > DAMON's access checks.  In more detail, I understand enabling PERF_SAMPLE_ADDR
> > type perf events makes the perf events buffer filled with memory access event
> > information with the access destination address.  The event will be sampled
> > based on time (e.g., one access event per X milliseconds).  And probably that
> > sample data could include more information includign the CPU and the process
> > that executing the sampled access?  Please correct me if I'm wrong and add more
> > details I'm missing, as my understanding of perf event is very poor.

I'm afraid you need to deal with PMU hardware details.  For example
PERF_SAMPLE_ADDR may not be available depends on events or sometimes it
may not have valid values in some samples like on AMD IBS.  Also hybrid
CPUs may not have same events on both CPUs.

Maybe it's better to fix which event you want to use on each CPU
architecture.

> > 
> > And one quick question.  Can this work on virtual machines?  I'm asking this
> > question the for following reason.  I'm actuaally working on a similar project
> > that extends DAMON for page fault based access events sampling [1].  The
> > project aims to use page fault event rather than other h/w features such as AMD
> > IBS or Intel PEBS, because my understanding is that such h/w features are not
> > available on virtual machines.

KVM supports PMU virtualization.  But the existing vPMU support has a
lot of overhead.  Recently mediated vPMU patchset was added so you can
try that instead.  You'll need to pass appropriate options to qemu.

https://lore.kernel.org/lkml/20251206001720.468579-1-seanjc@google.com/

Thanks,
Namhyung

> > 
> > > 
> > > Since perf event-based access checks do not require modifying the PTE
> > > accessed-bit for pages representing each damon region, this patch series
> > > also includes a feature that allows you to set upper and lower limits on
> > > the damon region size to enable access checks with finer granularity.
> > 
> > I was also thinking about extending DAMON with AMD IBS or Intel PEBS like h/w
> > features for this kind of sub-page granularity access monitoring.  So this
> > makes sense to me, and sounds useful!
> > 
> > > 
> > > Using these features also requires modifications to damo, but these are
> > > not included in this patch series and are currently under development in
> > > the following branch:
> > > 
> > > https://github.com/mita/damo/tree/damo-perf-for-v3.1.0
> > > 
> > > Any feedback or advice on the patch set would be greatly appreciated.
> > > 
> > > Akinobu Mita (4):
> > >   mm/damon/core: add common code for perf event based access check
> > >   mm/damon/vaddr: support perf event based access check
> > >   mm/damon/paddr: support perf event based access check
> > 
> > I find your patches are introducing new infra code for this extension.  It
> > seems bit specialized for perf event only, though.  I'm concerned if future
> > extension for another access check primitives cannot reuse the infra.
> > 
> > My DAMON extension project [1] is for page fault based access monitoring, but
> > it also introduces a framework for general multiple access sampling primitives.
> > I'm wondering if perf event based extension can be implemented using the
> > general acces ssampling primitives infra code, and if you already considered
> > that but found it is not feasible.
> > 
> > >   mm/damon: allow user to set min and max size of region
> > 
> > The min size setup makes sense.  I understand the max size is for disabling the
> > regions adjustment (merge/split) mechanism.  IOW, for fixed granularity
> > monitoring.  Users can do that by setting min_nr_regions and max_nr_regions
> > same [2], though.  So, max size setting seems not really needed.
> > 
> > Again, great RFC patch series, thank you for sharing!  I'm looking forward to
> > your answers to above high level questions and comments.
> > 
> > > 
> > >  .../ABI/testing/sysfs-kernel-mm-damon         |  11 +
> > >  include/linux/damon.h                         |  42 +-
> > >  mm/damon/core.c                               | 202 ++++-
> > >  mm/damon/ops-common.h                         |  39 +
> > >  mm/damon/paddr.c                              | 106 ++-
> > >  mm/damon/sysfs.c                              | 402 +++++++++-
> > >  mm/damon/tests/core-kunit.h                   |   2 +-
> > >  mm/damon/tests/sysfs-kunit.h                  |   2 +
> > >  mm/damon/tests/vaddr-kunit.h                  |   7 +-
> > >  mm/damon/vaddr.c                              | 690 ++++++++++++++++--
> > >  10 files changed, 1425 insertions(+), 78 deletions(-)
> > > 
> > > -- 
> > > 2.43.0
> > 
> > [1] https://lore.kernel.org/damon/20251208062943.68824-1-sj@kernel.org/
> > [2] https://origin.kernel.org/doc/html/latest/mm/damon/faq.html#can-i-simply-monitor-page-granularity
> > 
> > 
> > Thanks,
> > SJ
> > 
