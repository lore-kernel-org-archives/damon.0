Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744B1DF751
	for <damon@lists.linux.dev>; Fri,  1 May 2026 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597481; cv=none; b=UK9z4K3GDq/nYmpDvZqNJVa7NDYAXS3fGx7fQAQoWlt2WyBGHp5ItprLl1a4DzGrJzmhtixE6K2GQuanahBNtj1pNiukoDulRG+ER2FmBx0OEg/O2BumQmPm09nM/swT7osuJ9K2tYTo4zVufG5U3Ikyukvkskeh4P5t1aoWVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597481; c=relaxed/simple;
	bh=ShzcgDUo43hF0A9DMxPXQpTH0bvTmZBRpp2+lM7R+ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euaR4J8D6uO0x1Cxy47ou2yndP0mL/DZDNgxcUyo+PoN9+Gi5TM7oSSvVqBheie2DQTYQL+Thve48/5JbMbeUq0H/DzD+XT3MyyH2l/CKLQYLaCime/nlaHeiaWEPVHAPXxdFdUgvZZgyNXmIe0xIr+irkdQdYUWBd7wfpxRdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An6BqchR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An6BqchR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E129FC2BCB3;
	Fri,  1 May 2026 01:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777597481;
	bh=ShzcgDUo43hF0A9DMxPXQpTH0bvTmZBRpp2+lM7R+ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=An6BqchRjo503V8Op0nmmhLPtHvYnfRHqoTn3teRmAb2Fv25h7M2AJ1IEHz+oZlc9
	 fijW2CQNZuGYmqfyD3veHKaxdtCVnAij2qO5YMdZwa3Ai5b1aAsKF6W0sDxH81AorR
	 vemaAcGVDQIesSl+Wea4HxLEh5rYkbKtkM92PLAm6SokP93wIkY71THRckbHKaSwpu
	 aXtbtnl4LNAYqh8TgBmeZOpJnO3HiS2QxKliqGCjB3c/DItBLEhkw1pWosndxLZyok
	 LsVw7ZoCyH5fi5qWgNBvEjg9JK80CoX97xrMo4awWMFFf/1M4xw0xya9Zpo9bTr/lx
	 /P/CF5jF0gE2A==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Thu, 30 Apr 2026 18:04:37 -0700
Message-ID: <20260501010437.79477-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430151419.589FEC2BCC7@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 30 Apr 2026 15:14:18 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The newly added `kdamond_pid` module parameter lacks a `MODULE_PARM_DESC` declaration.
> --
> 
> commit d56734720ba3e7838cd85a1ac6661cf5e54d9a3b
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/stat: add a parameter for reading kdamond pid
> 
> Expose the pid of DAMON_STAT kdamond via a new read-only module parameter
> named kdamond_pid. This standardizes DAMON module usage, as DAMON_RECLAIM
> and DAMON_LRU_SORT also provide this information.
> 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > index f4d3203e92639..37964683839d0 100644
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> [ ... ]
> > +static const struct kernel_param_ops kdamond_pid_param_ops = {
> > +	.set = damon_stat_kdamond_pid_store,
> > +	.get = damon_stat_kdamond_pid_load,
> > +};
> > +
> > +/*
> > + * PID of the DAMON thread
> > + *
> > + * If DAMON_STAT is enabled, this becomes the PID of the worker thread.
> > + * Else, -1.
> > + */
> > +module_param_cb(kdamond_pid, &kdamond_pid_param_ops, NULL, 0400);
> 
> This isn't a bug, but should this module parameter include a MODULE_PARM_DESC()
> declaration?
> 
> Other parameters in mm/damon/stat.c like enabled, estimated_memory_bandwidth,
> and memory_idle_ms_percentiles have corresponding MODULE_PARM_DESC()
> declarations.

Good finding, I will add that.


Thanks,
SJ

[...]
