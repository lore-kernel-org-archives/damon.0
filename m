Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0386522E40F;
	Thu, 29 May 2025 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538060; cv=none; b=dhRkV8F9lWH6DX94piePrCFYxkwcEdKsc81aobUh3ogHubk4Lifu919KdNxNNOdWCVAORrbOUvqd106TZAeLOYPKWp/Yceqm4ge9GZ5DKtAGCd3xjwEgnFWwGSHplVMj+J7NuXD1JOxSz09OT6nRVjzBn8FW8DoR8XsOvPgTCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538060; c=relaxed/simple;
	bh=YODMCTONNUvrZ/fd9rfuLcDesJI0d1/hZyci/ZkyEos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVnUQu/P9/oVwn8Ng4fy9LsA5u4BxQR+/Zee9lMzF8WFDmm3ArBV6gIrFB3KXheAizExYA5531/qtPXXFTUrf3qyHm5IxJ7sNLmUl7rzyus79Y7T1m+0rveUdQroObBpoAd+I+tPmmvouOY9XsMOoxTmE7OFuryWtnhZtFmTcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmUIwspV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmUIwspV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A54C4CEE7;
	Thu, 29 May 2025 17:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748538059;
	bh=YODMCTONNUvrZ/fd9rfuLcDesJI0d1/hZyci/ZkyEos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmUIwspVuC1D+lZAM3ntHBmQVm7Qst8mN7dAFjtSI5Q5f6F9QUoLEMilLjG/LnJLY
	 b3ZNJTw8PLI2vxDaphRq//7vKo+srP56G3ysMNti98u4dKRtPfGnwMpetc7Lwz9K9t
	 KtIJ/dwnPV+0M14uCYsmMEChFAd0NJLrPKdahPKn8bNIkJlFrcHmZVr0LxXJsrdlYd
	 4ESVkCtGZCtlf8Yow9HRVWxA0qqQISInrZtqKQ4Z/uPSojKYAfXN9buJ1J4NzdDKj4
	 Rw2tnFfa8EfwHq4r3wRrh0cjlf50OyPiNvg6T9AfCmpbKhRbaMSzQbxKoUrle5w4ac
	 MHynH4P2nyiVQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel_team@skhynix.com,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm/damon: introduce DAMON_STAT for simple and practical access monitoring
Date: Thu, 29 May 2025 10:00:52 -0700
Message-Id: <20250529170052.37757-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <82ea9158-c71e-4c11-a46d-397e9ec9349b@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu,

On Thu, 29 May 2025 16:21:39 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> Thanks for your work.
> 
> On 5/27/2025 6:09 AM, SeongJae Park wrote:
> > DAMON-based access monitoring is not simple due to required DAMON
> > control and results visualizations.  Introduce a static kernel module
> > for making it simple.  The module can be enabled without manual setup
> > and provides access pattern metrics that easy to fetch and understand
> > the practical access pattern information, namely estimated memory
> > bandwidth and memory idle time percentiles.
> > 
> > Background and Problems
> > =======================
> > 
> > DAMON can be used for monitoring data access patterns of the system and
> > workloads.  Specifically, users can start DAMON to monitor access events
> > on specific address space with fine controls including address ranges to
> > monitor and time intervals between samplings and aggregations.  The
> > resulting access information snapshot contains access frequency
> > (nr_accesses) and how long the frequency was kept (age) for each byte.
> > 
> > The monitoring usage is not simple and practical enough for production
> > usage.  Users should first start DAMON with a number of parameters, and
> > wait until DAMON's monitoring results capture a reasonable amount of the
> > time data (age).  In production, such manual start and wait is
> > impractical to capture useful information from a high number of machines
> > in a timely manner.
> > 
> > The monitoring result is also too detailed to be used on production
> > environments.  The raw results are hard to be aggregated and/or compared
> > for production environments having a large scale of time, space and
> > machines fleet.
> > 
> > Users have to implement and use their own automation of DAMON control
> > and results processing.  It is repetitive and challenging since there is
> > no good reference or guideline for such automation.
> > 
> > Solution: DAMON_STAT
> > ====================
> > 
> > Implement such automation in kernel space as a static kernel module,
> > namely DAMON_STAT.  It can be enabled at build, boot, or run time via
> > its build configuration or module parameter.  It monitors the entire
> > physical address space with monitoring intervals that auto-tuned for a
> > reasonable amount of access observations and minimum overhead.  It
> > converts the raw monitoring results into simpler metrics that can easily
> > be aggregated and compared, namely estimated memory bandwidth and idle
> > time percentiles.  Refer to the commit messages of the second and the
> > third patches of this patch series for more details about the metrics.
> 
> I see the description looks good but it'd be useful if you could share some
> execution commands and expected output examples that some newbies can get better
> ideas.

Thank you for the feedback.  In my humble opinion, nevertheless, this is what
the fourth patch of this series is aiming to provide.  And thanks to your
comment, I now realize I forgot mentioning this on the above comment.

Of course we can add execution commands and output example here, but without
understanding of the metrics, it would just look like mysterious numbers.
Meanhile, user interface of the module is simply module parameters that should
be familiar to most kernel users, so I don't think it necessarily deserves
example commands.

> 
> I honestly do not have a clear idea how I can use this kind of static kernel
> modules as general users although I have developed some features of DAMON.
> 
> So could you please help?

I agree this cover letter is not enough for getting clear idea of how readers
can use this feature.  Thank you for letting me realize this.  But I think this
cover letter might be better to keep the brevity, as long as it points where
readers can get necessary details.  What do you think about revising this cover
letter to

1. point the fourth patch for usage of DAMON_STAT, and
2. elaborate the fact that readers are recommended to read the metric
   definitions and usages to get more clear idea of DAMON_STAT?


Thanks,
SJ

[...]
