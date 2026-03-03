Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6E155C97
	for <damon@lists.linux.dev>; Tue,  3 Mar 2026 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772499945; cv=none; b=tkhKZ3Tvaw7OpjO8uGBLOelqcfKIxVvhJ7WffewbqXdohIwrBxtsrX3KXQhiQ1YpA+Z6UGaiePhnXFppAR32JWQSE7MAJ/dxH0vgF5GuOIsqI8tviEmUp5E9GLzqPGg7rEI3NzsffXaFjb9VHma2X7PwHGed5ZyYsZ826rVIp6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772499945; c=relaxed/simple;
	bh=aquX/5Im7BIOG/WaZwMpuu7pu3dnShuPU7uWvizQkVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gS9ucGdvcplcMni5nnrfAIFc8x0OTpIukOWvoIcycl0n+b+DGOacIvjfwDK/jgTqKYP6ptK1O6TohgVKCULMY/3G6w8i4VZYAQLxHbjsw0PdM/Kkh312Qq4ONMMXE91x6k2NneBBpeoRDdOFWuzalGxIGmis8RrJpVvtKkAirZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwAmIBOj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwAmIBOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F573C19423;
	Tue,  3 Mar 2026 01:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772499945;
	bh=aquX/5Im7BIOG/WaZwMpuu7pu3dnShuPU7uWvizQkVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwAmIBOj7wt6dzJJHHYIXtFJkLh/IlRhXTSq8RlAaqoHh/rzGk9/rgX/myB0EgGZs
	 fq6I9IqbjNLtJh/iy+uUq3g6UPOHg+svJ1ct6M+9jyERFgox1tLn0ETFLcbs+nFsFK
	 hlpGL/KhKM/wf1Smsh8ea2xi0VCQdNnGYesvFkApCw8PNFu/k1MBmK+9adW7uTFYw9
	 TeOrB7F45/2vP+adVfYSewTpbBHCfU7Kvr+ntYtUXeEEXvqdAE7H4fnHG2V1Z1CGZ5
	 FGkflrUw7+S10jfXoH4qkrYXskq7yQ9VscKo2/O+GyDGnZm5HMKcRPZbfoCV6xLC8f
	 zvo+h+YE5JLLQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Date: Mon,  2 Mar 2026 17:05:36 -0800
Message-ID: <20260303010538.82135-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219064950.69068-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 18 Feb 2026 22:49:48 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 19 Feb 2026 15:28:24 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 
> > 2026年2月19日(木) 0:40 SeongJae Park <sj@kernel.org>:
> > >
> > > On Wed, 18 Feb 2026 17:20:04 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > >
> > > > 2026年2月18日(水) 0:15 SeongJae Park <sj@kernel.org>:
> > > > >
> > > > > On Tue, 17 Feb 2026 22:32:43 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > > > >
> > > > > > 2026年2月17日(火) 9:13 SeongJae Park <sj@kernel.org>:
> > > [...]
> > > > > > > I just posted an RFC patch series [1] for this.  I will drop RFC tag after the
> > > > > > > current merge window is finished.  Please let me know if you find something
> > > > > > > wrong there!
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/20260217000400.69056-1-sj@kernel.org
> > > > > >
> > > > > > Thank you for posting the patch series.
> > > > > >
> > > > > > I tried it and found that patch 2/3 made things worse than before in terms of
> > > > > > monitoring at page size granularity.
> > > > >
> > > > > Thank you for sharing the test results!
> > > > >
> > > > > > This is because, in my evaluation, new
> > > > > > target processes are added without stopping kdamond, so processes added later
> > > > > > are not initially monitored at page size granularity.
> > > > >
> > > > > Nice catch.  But, the min_nr_regions based region split of vaddr was triggered
> > > > > by damon_va_init(), which is called before the kdamond_fn()'s main loop.  How
> > > > > the regions were split before the patch?  Probably I'm missing something.
> > > > > Could you please clarify?
> > > >
> > > > Before applying PATCH 2/3 ("mm/damon/vaddr: do not split regions for
> > > > min_nr_regions"), the damon regions of processes newly added to the monitoring
> > > > targets after kdamond started were split by damon_va_evenly_split_region().
> > >
> > > Thank you for adding this explanation.  But, damon_va_evenly_split_region() is
> > > called by only __damon_va_init_regions(), which is again called by only
> > > damon_va_init().  And damon_va_init() is called from kdamond_fn(), only at the
> > > beginning, before starting the main loop.  If you add new monitoring targets
> > > after kdamond started and therefore the damon_va_init() is called,
> > > damon_va_init() cannot be called again.  So damon_va_evenly_split_region() is
> > > also not called.  I confirmed this using damo like below:
> > >
> > >     $ sudo damo start --target_pid $$ --monitoring_intervals 1s 5s 10s
> > >     $ sudo damo tune --target_pid $$ --target_pid $other_process_pid \
> > >             --monitoring_intervals 1s 5s 10s \
> > >             --monitoring_nr_regions_range 20 1000
> > >
> > > While running the command, I monitor the number of regions of targets using
> > > damon:damon_aggregated trace event, and confirmed the initial region is evenly
> > > split, but the new monitoring target regions that added by the second command
> > > is not evenly split from the beginning.
> > >
> > > Am I missing something?
> > 
> > Your explanation is correct.
> > It was only my own internal changes that were affecting it (calling ops.init()
> > from damon_commit_ctx()).
> > 
> > https://lore.kernel.org/damon/20260123021014.26915-2-akinobu.mita@gmail.com/
> 
> Makes sense, thank you for clarifying this!
> 
> > 
> > So the current patch series hasn't made things worse. Sorry for the mistake.
> 
> Glad to hear that.  I will post the series without RFC after the current merge
> window.  I will also try to make the planned followup for respecting the
> min_nr_regions for the online-added targets and updated min_nr_regions before
> the next merge window.

The non-RFC series is posted [1].  The version also do the min_nr_regions
respect for online updates together.

[1] https://lore.kernel.org/20260228222831.7232-1-sj@kernel.org


Thanks,
SJ

[...]
