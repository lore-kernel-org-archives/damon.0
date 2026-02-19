Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BDA3093B8
	for <damon@lists.linux.dev>; Thu, 19 Feb 2026 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483797; cv=none; b=uXX3p+4W1D4QXgpk9Z5exguMH7twNIu2G/URBl5BKsox6Z7awpDJvEFayAIxmk5jte1RUjhz4yw6pHHtffKjenToG1//NFguNy11y6Lo0XCFGzLY2IsEAAodYyPEt+nmLPlRrg2iV+2ej2W+feam7F5DTa8xzeKIjpZGshzCN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483797; c=relaxed/simple;
	bh=No5q+KFAFL0adk6o24BBnPD16KgW29QFMqaGZlXnjzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8VDwgJ3sW9lrFM/g3DdRyu2muHoZF68B293EtQQP5UsDWfi2x2+ZWYGpAvQrPRYLSmL0Sd6Zer+d1SclfGNW37Nn1IxcQAjluDiWrbCrh5lwN3tj7scP7JKhdHibg6ob59KficRxIvX8g/FVAK3elYdihfGn455DcVamc09DoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OADoDxNx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OADoDxNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2010C2BC86;
	Thu, 19 Feb 2026 06:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771483797;
	bh=No5q+KFAFL0adk6o24BBnPD16KgW29QFMqaGZlXnjzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OADoDxNxPAhgAGUfBr6V3qG9YF2C8AIukY/+0fl3JPmcP3xmwfOjUqn1uTcqAOPHx
	 3g63u36le2+nAnCiFdpyl2BV4ecC3v5Qvx8GcDMET9FefqKyVlGyHetUQWycwUXZ2u
	 sWlEbQC5UdW/IM1BRs34RfHjyiKuJnRaDBuHe0iUZJTLnzZJBmJ9Q0BGXxzsvETj05
	 HsymEhQppEwIcDaAUByjdnMNFpHMRewpDQwiGSUjkLkH0PfghmTjw0X3Cyagtxw4P6
	 iqBdpY+seVXE/xvQfc3tKEdNyneZGQEBLQDI5kAdXiVrOnmmtngzbjh7aMDm9/1XgH
	 8SuHxXn703c2A==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Date: Wed, 18 Feb 2026 22:49:48 -0800
Message-ID: <20260219064950.69068-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umyhNBtcF=O6x3aaQG4uMaSSkzs-kw1E79PHrd_rBLiUeFA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 19 Feb 2026 15:28:24 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2026年2月19日(木) 0:40 SeongJae Park <sj@kernel.org>:
> >
> > On Wed, 18 Feb 2026 17:20:04 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > > 2026年2月18日(水) 0:15 SeongJae Park <sj@kernel.org>:
> > > >
> > > > On Tue, 17 Feb 2026 22:32:43 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > > >
> > > > > 2026年2月17日(火) 9:13 SeongJae Park <sj@kernel.org>:
> > [...]
> > > > > > I just posted an RFC patch series [1] for this.  I will drop RFC tag after the
> > > > > > current merge window is finished.  Please let me know if you find something
> > > > > > wrong there!
> > > > > >
> > > > > > [1] https://lore.kernel.org/20260217000400.69056-1-sj@kernel.org
> > > > >
> > > > > Thank you for posting the patch series.
> > > > >
> > > > > I tried it and found that patch 2/3 made things worse than before in terms of
> > > > > monitoring at page size granularity.
> > > >
> > > > Thank you for sharing the test results!
> > > >
> > > > > This is because, in my evaluation, new
> > > > > target processes are added without stopping kdamond, so processes added later
> > > > > are not initially monitored at page size granularity.
> > > >
> > > > Nice catch.  But, the min_nr_regions based region split of vaddr was triggered
> > > > by damon_va_init(), which is called before the kdamond_fn()'s main loop.  How
> > > > the regions were split before the patch?  Probably I'm missing something.
> > > > Could you please clarify?
> > >
> > > Before applying PATCH 2/3 ("mm/damon/vaddr: do not split regions for
> > > min_nr_regions"), the damon regions of processes newly added to the monitoring
> > > targets after kdamond started were split by damon_va_evenly_split_region().
> >
> > Thank you for adding this explanation.  But, damon_va_evenly_split_region() is
> > called by only __damon_va_init_regions(), which is again called by only
> > damon_va_init().  And damon_va_init() is called from kdamond_fn(), only at the
> > beginning, before starting the main loop.  If you add new monitoring targets
> > after kdamond started and therefore the damon_va_init() is called,
> > damon_va_init() cannot be called again.  So damon_va_evenly_split_region() is
> > also not called.  I confirmed this using damo like below:
> >
> >     $ sudo damo start --target_pid $$ --monitoring_intervals 1s 5s 10s
> >     $ sudo damo tune --target_pid $$ --target_pid $other_process_pid \
> >             --monitoring_intervals 1s 5s 10s \
> >             --monitoring_nr_regions_range 20 1000
> >
> > While running the command, I monitor the number of regions of targets using
> > damon:damon_aggregated trace event, and confirmed the initial region is evenly
> > split, but the new monitoring target regions that added by the second command
> > is not evenly split from the beginning.
> >
> > Am I missing something?
> 
> Your explanation is correct.
> It was only my own internal changes that were affecting it (calling ops.init()
> from damon_commit_ctx()).
> 
> https://lore.kernel.org/damon/20260123021014.26915-2-akinobu.mita@gmail.com/

Makes sense, thank you for clarifying this!

> 
> So the current patch series hasn't made things worse. Sorry for the mistake.

Glad to hear that.  I will post the series without RFC after the current merge
window.  I will also try to make the planned followup for respecting the
min_nr_regions for the online-added targets and updated min_nr_regions before
the next merge window.


Thanks,
SJ

[...]
