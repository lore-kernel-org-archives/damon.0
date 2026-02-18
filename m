Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26619D8A8
	for <damon@lists.linux.dev>; Wed, 18 Feb 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771429243; cv=none; b=Q+adbn74X+ptacQbTXlup5/0lYe2fxHqbDvObCoYgAqGVgA8LStwgeqqt76LmeEPiWIXddMyf/0eTHD5ItrJPp8VCm0mkIvtgXyiEHx982Y/fiPN2xLOJF0k17Cf+UrTFemeKlIai+goKrqguyNLHfGWK+H/78m8kMN1TI1osT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771429243; c=relaxed/simple;
	bh=3s5ryM7z+WBE7Gy/HnVNQLQu1NQBrzn6mqqQtEbqwhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwsGrODbU7F7f3gbwU+xILIgx+OvO1PfRjjP+fF4J+1ChHLBhBzX9HJ1MfFlNPaiqHaM8GrDrR0h/dDqS/yNmC27zdei6xLhWLf25S0Lw7a6wIjIU10xpFav/pYO2PoYVg81SksqQoKrgCpuqld/ObT9vtsb4+8UDyFSf1VQkdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeldCF3S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeldCF3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6619BC116D0;
	Wed, 18 Feb 2026 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771429243;
	bh=3s5ryM7z+WBE7Gy/HnVNQLQu1NQBrzn6mqqQtEbqwhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PeldCF3S/y0tnSt80SSYI7aA2o33all3lFE/HrqPiwwHwbNKZpoY+89eO+ZA26yGa
	 VM/dlmVZC8p67FYrRv9Ad0JdEm790bZSLHB3Ax+ZwKczoMyJNk5uPzRIpIFe2m0Ial
	 ejH0cn3nUX1/gttwygGhMv/JtJnQ+rWNnwenn9TTNpYwiKr6SC0IZBACjbothSvrEQ
	 W7lQf8qfHwegTXnCntTNwEYqJ0LoGbuHrl7SVoFqMWEIVEbj5NOAmYy38RLh7cN931
	 S6sUD+6GR/6fyuhB52auz/yVkMUg85MOOzjfb/ae5f7hCJMSRNlTfQ9s5bCOUGE2x8
	 DIJbMWBiEiKrw==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Date: Wed, 18 Feb 2026 07:40:40 -0800
Message-ID: <20260218154041.10282-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umyj7jb-RUXJPv+YMC5Fd3ST=YinW_t7Sj5kCpoA2d+rDXw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 18 Feb 2026 17:20:04 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2026年2月18日(水) 0:15 SeongJae Park <sj@kernel.org>:
> >
> > On Tue, 17 Feb 2026 22:32:43 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > > 2026年2月17日(火) 9:13 SeongJae Park <sj@kernel.org>:
[...]
> > > > I just posted an RFC patch series [1] for this.  I will drop RFC tag after the
> > > > current merge window is finished.  Please let me know if you find something
> > > > wrong there!
> > > >
> > > > [1] https://lore.kernel.org/20260217000400.69056-1-sj@kernel.org
> > >
> > > Thank you for posting the patch series.
> > >
> > > I tried it and found that patch 2/3 made things worse than before in terms of
> > > monitoring at page size granularity.
> >
> > Thank you for sharing the test results!
> >
> > > This is because, in my evaluation, new
> > > target processes are added without stopping kdamond, so processes added later
> > > are not initially monitored at page size granularity.
> >
> > Nice catch.  But, the min_nr_regions based region split of vaddr was triggered
> > by damon_va_init(), which is called before the kdamond_fn()'s main loop.  How
> > the regions were split before the patch?  Probably I'm missing something.
> > Could you please clarify?
> 
> Before applying PATCH 2/3 ("mm/damon/vaddr: do not split regions for
> min_nr_regions"), the damon regions of processes newly added to the monitoring
> targets after kdamond started were split by damon_va_evenly_split_region().

Thank you for adding this explanation.  But, damon_va_evenly_split_region() is
called by only __damon_va_init_regions(), which is again called by only
damon_va_init().  And damon_va_init() is called from kdamond_fn(), only at the
beginning, before starting the main loop.  If you add new monitoring targets
after kdamond started and therefore the damon_va_init() is called,
damon_va_init() cannot be called again.  So damon_va_evenly_split_region() is
also not called.  I confirmed this using damo like below:

    $ sudo damo start --target_pid $$ --monitoring_intervals 1s 5s 10s
    $ sudo damo tune --target_pid $$ --target_pid $other_process_pid \
            --monitoring_intervals 1s 5s 10s \
	    --monitoring_nr_regions_range 20 1000

While running the command, I monitor the number of regions of targets using
damon:damon_aggregated trace event, and confirmed the initial region is evenly
split, but the new monitoring target regions that added by the second command
is not evenly split from the beginning.

Am I missing something?  

> After applying PATCH 2/3, the call to damon_va_evenly_split_region() is
> omitted, so those new processes are monitored by larger damon regions.

So I'm still not understanding why you saying this.

> 
> > > Would performing a split operation like damon_apply_min_nr_regions() within
> > > damon_set_regions() solve the problem?
> >
> > Yes, that's the plan.  The split operation should be done for online updates of
> > total size of monitoring regions and min_nr_regions.  I'm preparing a followup
> > patch series for that.  While working on it, however, I found it requires some
> > refactoring and cleanup that taking time longer than I expected.  Meanwhile I
> > was thinking your issue is only at the beginning of kdamond, and I didn't want
> > to make you wait too long.  Hence posted the series first.
> 
> I see, thank you for the work.
> 
> In another evaluation using paddr, no new damon regions are added after kdamond
> is started, so applying the current patch series enabled monitoring at page
> size granularity.

Glad to hear that it helps the case!


Thanks,
SJ
