Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929720D4FF
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628546; cv=none; b=VBmSBLwS0zoFd02v3rwvn3efrJVfJBlQvnQsw+T2a8wY4zSIoaby9UITtUK+Hn3l+Lkl8q1pA08eeElPER3PkaUCANNsBA5yvlvAIrej0KM+6tHNGU5cuQ1fUrA1hGHIX8UHaQJbDyBtksd7suPGzyrlFP/7Y0ZfBgaMYchTl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628546; c=relaxed/simple;
	bh=GIppXOKf11BNOGUucWA4NliNYaLQk2ql7hcPjWuCm2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCNbXu/NipGZf8Ixl3rWhLpFDNVwJO/wyLjBJktiEhGvaMI7/DBJA8dji0lWPtQjn9cJFv3/5YtEZS3nSMFJGjs2tVRRj84HiVLUUuQIPLa9O7UgUu5u1WcPfK5ggF/V2usYuJDSB0Ad8saQhh83rgOhTxgnXQiDRKV0uRSr3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN5b/qOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN5b/qOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822281F00A3A;
	Sat,  5 Sep 2026 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788628544;
	bh=fZZBs2k/GFn6Fqbu0z0szmRZO1I3LQBslP+g1RshGhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cN5b/qOrOk/l3+Df8AfvLjg+P/Y7JxGyUg7PNhDYfkIkmsFwfzRo1bq7DRIel3YG0
	 7BzV78oZdzuULJQ1MfHqa0dwU3gj47pbHwsZb9XppkNKeWawl6vIw/IriHi7C0n+PB
	 sebNzIzz/Mf4HslccQbfpRyx7WoZnuhvIdVpUrrJMNPSWjp7T/xGpffWN4q4W858zj
	 bzjdjU58lTlrV3PDUNzmM80eqhYe3acV7TNvDiloFfznwhdlOn+AI7zLVfOmwMe5Sa
	 0S5x5g2bMITL3o7Xr5a4GJ82dy/lE6GaKx6RgNCPZZ8casiiUm1NtwMC52EV8omecY
	 dvDWDyC2DABmA==
From: SJ Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: Re: Roadmap for extending DAMON beyond pte-accessed bit
Date: Sat,  5 Sep 2026 10:15:36 -0700
Message-ID: <20260905171537.84217-1-sj@kernel.org>
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
> Milestone 1: PTE Accessed bit as one of the data attributes
> -----------------------------------------------------------
> 
> I will work on stabilizing and further extending the data attributes interface
> and internal framework to be able to support PTE Accessed bit.  This may take
> no small amount of efforts, but hopefully doable by the end of this year.
> 
> Milestone 2: First damon_report_access()-based data attribute monitoring
> ------------------------------------------------------------------------
> 
> Once the first milestone is completed, we will add the damon_report_access()
> and related infrastructure changes into the DAMON core.  On top of it, we will
> further implement the first data attribute that utilizing the reporting
> infrastructure.  I personally think the perf event based one is a good target
> at the momentt.  I think so mainly because the perf maintainers didn't show
> special concern yet.  We can discuss the target again after the first milestone
> is completed, though.  Hopefully this is doable by the LSFMMBPF 2027.
> 
> The timeline is just a gut feeling.  It could be done much earlier or later.

The patch series [1] for milestone 1 is now merged into mm.git.  Having it
merged into mm.git doesn't guarantee landing on the mainline.  More works for
making it complete including support of vaddr and DAMOS should also be
continued.  Refer to my another reply [2] for mroe details on the additional
works.  But we show no concern for landing the series on the mainline as of
now.  And the additional works are not blockers of milestone 2.

Therefore, I believe we can consider milestone 1 nearly done.  Hopefully the
series will be merged into the mainline by 7.4, which is expected to be
released on 2026-12-20.  Then we can officially mark milestone 1 as delivered
on time.

So I believe it is the time to start milestone 2.  This would take time.  I
need to start from learning perf event system.  This project is definitely
important but I'm not dedicated to only this project.  Please bear in mind with
me.  But I'm still optimistic to the planned timeline.  It still looks doable
by LSFMMBPF'27.  We are still on the track.

[1] https://lore.kernel.org/20260901132506.99243-1-sj@kernel.org 
[2] https://lore.kernel.org/20260905165221.83994-1-sj@kernel.org


Thanks,
SJ

[...]
