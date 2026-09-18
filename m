Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288864E3EED
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744117; cv=none; b=IBTok7gqAhJ5QbSsLLSW0bGG9ywPcQMdZgjVIZTEVMX/KXjFil2Uqhmk/PkDbtoUHikbQN3TKIMPyV50zxsKgf6U3lmkcPED5qQltHJpgKIwqYNP8GF8DGmna2zIfeX4Mv4YlVgVAY+1Rr1K0lAryx5dRHZUgdbkNMMl+T79Fyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744117; c=relaxed/simple;
	bh=WDfYOm2872oUwTuoifkSy3EAzu63GPjLEor9PeKnnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dahZ2AcPOGJpr/ANLxLP+8l59RXgI6miBHZ9L/J63PEbtDrlUn3pk7Pkol1HsH5SINA/xhQLOlDKT32Z9Xo8g9i8TTi42Mz0EIvZF5AQnenLQ0pEymsaLNrn2MCNd01GT/yOEgLt6bynrA1k9R9pxTctm85nOP8/eT6n+W1opf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpAu/d+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpAu/d+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8421F000FF;
	Fri, 18 Sep 2026 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744110;
	bh=zOfXrroKCTraD74IVyxB6/Tf60wFb2jg7Mh7+2EyFUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mpAu/d+xQy3YpY1oco61oYnww+tcWYebUTPBkhZtd44oKrvm4hyN4Q+7Ym5M/RQvA
	 /ayjUoY7cN6qcgpTVsNEM+8FXZExdS9pPwFtPi7vN7COQ/mBmcIkLCFeka04uIOosa
	 8ifKOjuShEnkPETfKpdvHh2Dg+R9KSAJ/dDglFTNC9CzQVXqQk5gkvyWqugQya0guW
	 sTtB1JX9+iyRAb3EKT/3MNmBaVM1qZyfWh4INbegCAQjWJysan0ZyvO2WjW/SG/jlo
	 VNvS+E97+Rk4X4pDrXj+Ui8YlzHic5bVgPCdot3aah0MQ1wOANHDUXNSqItjCBDZO4
	 ZYpuDk+O+UyRQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/7] mm/damon/core: introduce damos_quota_goal->complement
Date: Fri, 18 Sep 2026 08:08:22 -0700
Message-ID: <20260918150823.86172-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918144818.18C831F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 18 Sep 2026 14:48:17 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: integer underflow in damos_set_quota_goal_current_value() for complemented metrics
> --
> 
> commit 94b0fa41235165f1d082ca5735dcefbf9f65199b
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damos_quota_goal->complement
> 
> This commit introduces the complement field to struct damos_quota_goal
> to allow specifying whether to use a complemented value of the goal target
> metric. It adds the field and implements the core support, handling the flag
> during quota goal commit and current quota goal metric value retrieval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 2258b72da7a78..25a8221dd2a40 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3238,6 +3239,19 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
> >  	default:
> >  		break;
> >  	}
> > +	if (!goal->complement)
> > +		return;
> > +
> > +	/* updte current_value to complemented value */
> > +
> > +	/* for user_input, users set complemented value on their own */
> > +	if (goal->metric == DAMOS_QUOTA_USER_INPUT)
> > +		return;
> > +	if (goal->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
> > +		goal->current_value = s->quota.reset_interval * 1000 -
> > +			goal->current_value;
> > +	else
> > +		goal->current_value = 10000 - goal->current_value;
> 
> [Severity: High]
> Can this unsigned subtraction result in an integer underflow?
> 
> In damos_set_quota_goal_current_value(), if the measured memory stall
> (current_value) exceeds the reset interval due to kdamond thread
> scheduling delays, heavy system load, or if the user configures
> reset_interval_ms to 0 via sysfs, s->quota.reset_interval * 1000 -
> goal->current_value will underflow.
> 
> Similarly, for BP metrics relying on loosely-coupled lockless kernel counters
> (e.g., global_node_page_state), per-CPU drift can occasionally cause the
> returned value to exceed 10000, causing 10000 - goal->current_value to
> underflow.
> 
> If an underflow occurs, it produces a value near ULONG_MAX.
> 
> Would passing this immense value to the auto-tuner mistakenly drop the scheme's
> reclaim quota to its minimum precisely when memory pressure is highest?

Good catch.  I will fix this in the next revision.

> 
> >  }
> >  
> >  /* Return the highest score since it makes schemes least aggressive */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260918142827.85303-1-sj@kernel.org?part=1


Thanks,
SJ
