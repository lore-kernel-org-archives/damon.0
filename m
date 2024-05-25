Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930F88625D;
	Sat, 25 May 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659267; cv=none; b=sALEvyR5mR5YmmpViJNPcNwYT8Y2pWKckgifntrV7yOg+TtaTbpgXORWxrwYpeEfqlC0SjwI1Hyl47SKXt1NyR+Hkn5jsXG8SxEx+BMpgEowKN/nUwepmsLtUC3fisHZtwoMUcFMH3ay9fFDvUCqgNJU0DnnMATUPM0bipxHgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659267; c=relaxed/simple;
	bh=illGiGfQ49I2VNSiTb2MOLOjTwVVqbsgeAQgzZEz558=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xi3bSPBE2tE+tNP8P3iPjy3vvUvLEDBkzGvVtpdoqNPJf/7T8qhTcBCzFj/Bj1d1GczfJzSrSNp8fuz2B1ZeE539kqFOpNlPBLO1lB7MyLcBzBYiDZMEN4MexMkRQ1RCSxgoMMfYxi9tnCAGNx7oCDvYfeG+hhxbruuOYFbYqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6ZXvtH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6ZXvtH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944D3C2BD11;
	Sat, 25 May 2024 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659267;
	bh=illGiGfQ49I2VNSiTb2MOLOjTwVVqbsgeAQgzZEz558=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6ZXvtH+5o+ojVjbfwckhNoP25GLI7okvZRBgQtCkmlCQ4Bi1r9P6P75UOkbW69n0
	 AP2+EgAtfdD43sne//tBHM8uq1beO80FAX5iTDCb72XlwJRhBelEeH9nGZCWywI9Nf
	 rF6nPx8BkC2nzVXfMdr8NVwxo0/Zoz5y5h7XEhYC4ojIPdX8rhtQ2j8fIzPWkcYLBH
	 tYcUzGI199aEncLasoPGF/Lg3j3rwVfAT5Y8BYYPDW9c7BZOUZKrvL5uf6epxvFmBq
	 DAypWQ8iXZo0RR8DSUK0T1CYLZdHYoo6nKKDfvaM/Nf4pvvJxLNPyYwsGZ8hHK0S6v
	 HNp5omn3Y2X3w==
From: SeongJae Park <sj@kernel.org>
To: Jonghyeon Kim <tome01@ajou.ac.kr>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] Add NUMA-aware DAMOS watermarks
Date: Sat, 25 May 2024 10:47:42 -0700
Message-Id: <20240525174742.83758-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240524052428.GA368050@swarm08>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jonghyeon,


Thank you for the detailed explanations!  Please read my comments below.

On Fri, 24 May 2024 14:24:28 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:

> On Tue, May 21, 2024 at 06:00:34PM -0700, SeongJae Park wrote:
> > Hi Jonghyeon,
> > 
> 
> Hi, SeongJae
> 
> > On Mon, 20 May 2024 14:30:35 +0000 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:
> > 
> > > Current DAMOS schemes are not considered with multiple NUMA memory nodes.
> > > For example, If we want to proactively reclaim memory of a one NUMA node,
> > > DAMON_RECLAIM has to wake up kdamond before kswapd does reclaim memory.
> > > However, since the DAMON watermarks are based on not a one NUMA memory
> > > node but total system free memory, kdamond is not waked up before invoking
> > > memory reclamation from kswapd of the target node.
> > > 
> > > These patches allow for DAMON to select monitoring target either total
> > > memory or a specific NUMA memory node.
> > 
> > I feel such usage could exist, but my humble brain is not clearly imagining
> > such realistic usage.  If you could further clarify the exampected usage, it
> > would be very helpful for me to better understand the intention and pros/cons
> > of this patchset.  Especially, I'm wondering why they would want to use the
> > watermark feature, rather than manually checking the metric and turning DAMON
> > on/off, or feeding the metric as a quota tuning goal.
> > 
> 
> The goal of this patchset is to manage each NUMA memory node
> individually through DAMON. Also, the main target scheme is memory
> reclaim (or demotion in tiered memory). By allowing DAMON to be managed
> by each NUMA node, I expect that users can easily set up memory reclaim
> for each node.
> 
> Additionally, I think that a watermark for each node is an appropriate
> metric for activating DAMON_RECLAIM, because the kswapd reclaim logic
> also follows a watermark of free memory for each node.
> 
> There are two use cases. Let's assume two NUMA nodes are constructed of
> 32GB (node0) and 16GB (node1), respectively.
> 
> The first case is when using DAMON module. If users do not specify a
> monitoring region, DAMON's module finds the biggest size of the two NUMA
> memory nodes and designates it as the monitoring region (node0, 32GB).
> Even if we want to enable DAMON_RECLAIM to node0, it does not work
> proactively because the watermark works based on the total system memory
> (48GB).
> 
> Similarly, if the users want to enable DAMON_RECLAIM to node1, users have
> to manually designate the monitoring region as the address of node1.
> Nonetheless, since DAMON still follows the default watermark
> (total memory, 48GB), proactive reclaim will not work properly.
> 
> Below is an example.
> 
> # echo Y > /sys/module/damon_reclaim/parameters/enabled
> # cat /sys/module/damon_reclaim/parameters/monitor_region_start
> 4294967296 # 0x100000000
> # cat /sys/module/damon_reclaim/parameters/monitor_region_end
> 36507222015 # 0x87fffffff
> 
> # dmesg | grep node
> ...
> [0.012812] Early memory node ranges
> [0.012813]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> [0.012815]   node   0: [mem 0x0000000000100000-0x000000005e22dfff]
> [0.012817]   node   0: [mem 0x000000005e62c000-0x0000000069835fff]
> [0.012818]   node   0: [mem 0x000000006f2d3000-0x000000006f7fffff] 
> [0.012819]   node   0: [mem 0x0000000100000000-0x000000087fffffff] < target 
> [0.012825]   node   1: [mem 0x0000002800000000-0x0000002bffffffff] 
> ...
> 
> When we use DAMON_RECLAIM by default, DAMON_RECLAIM targets node0
> memory (32GB). However, DAMON runs differently from the initial goal
> because the watermark works based on the combined node0 and node1(48GB).
> DAMON_LRU_SORT also faces the same situation.
> 
> The second case is when we apply DAMON to a process. If a process
> allocates memory that exceeds a single NUMA node(node0), some users
> could want to reclaim the cold memory of the process in that node. In my
> humble opinion,áthe reclaim scheme(DAMOS_PAGEOUT) is effective in this
> case.  Unlike the DAMON module, since DAMON monitors process memory
> using a virtual address, it is hard to decide whether to enable a
> DAMOS_PAGEOUT due to a lack of node memory stats. Even though we use
> watermarks for DAMOS_PAGEOUT, it works the same with the above module
> case (thresholds based on total memory, 48GB). To overcome this problem,
> I think the dedicated watermark (for node0) can be an answer. 

Thank you very much for the detailed explanation.  I think quotas might be the
better appraoch, though, for below reasons.

We initially designed quotas to control DAMOS (schemes-execution part)
overhead, and watermarks to further eliminate DAMON (monitoring part) overhead.
That is, when every scheme is deactivated by watermarks, DAMON does only
watermarks check every user-specified time interval (5 seconds by default for
DAMON_RECLAIM), so the overhead is effectively zero.

However, this causes some problems on monitoring results quality.  For example,
let's say DAMON_RECLAIM was deactivated by watermarks, and reactivated after
long time, say, one hour.  DAMON_RECLAIM will start work with the monitoring
results that made one hour ago, which may not really reflecting current access
pattern.

We also found some users are not actively using the watermarks feature.  They
set mid watermark pretty high so that DAMON_RECLAIM almost always be active.  I
haven't met DAMON_RECLAIM users who relying on watermarks so far.  Your use
case sounds reasonable, but I guess that's still not production use case?
Please let me know if you are!

For the reason, nowadays I think it might better to consider deprecating
watermarks, and let users use quotas instead.  Quotas is more flexible, and it
recently got feedback-driven auto-tuning feature that allows user feeding it
with arbitrary metrics.  When it receives negative feedback only, it reduces
quota down to zero, so it can effectively deactivate DAMOS.

Of course, quotas cannot eliminate the monitoring part overhead.  However,
DAMON allows users set upperbound monmitoring overhead.  And in many use cases,
I feel users are setting the overhead unnecessarily high.  For example, we
usually show 2-3% single CPU time with DAMON's default setups (5ms sampling
interval, 10-1000 number of regions).  In many use cases, I think 5ms sampling
interval is too small.  Especially for DAMON_RECLAIM, because the 'min_age'
parameter is two minutes by default (I found some users who using DAMON_RECLAIM
on production is setting it much larger), increasing sampling interval wouldn't
make big degradation.  How much we can increase?  Depends on the use case, but
I think 20x (100ms) or even 200x (1s) is ok.  In the case, DAMON's
monitoring-part overhead would be only about 0.1-0.15% or 0.01-0.015% single
CPU time, so it wouldn't be real problem.  We are planning to add more
enhancement on the overhead/accuracy control, though.

So, what do you think about handling the NUMA use case via quotas?
Specifically, users could provide NUMA-specific free memory rate as arbitrary
user feedback for DAMON_RECLAIM (quota_autotune_feedback parameter).  If such
manual feeding is not desirable, we could add NUMA-specific free memory rate as
another self-feed metric, like quota_mem_pressure_us parameter.

[...]
> > Following up to the above question, why they would want to use DAMON modules
> > rather than manually controlling DAMON via DAMON sysfs interface?
> 
> IMHO, some users want to use DAMON feature without mannualy
> configurating via DAMON sysfs due to complexity.

I agree.  But also for same reason, I try to be careful at adding more
parameters for the modules.

> Since this patchset can be adopted to sysfs interface, I will update
> supporting NUMA-aware watermarks for sysfs interface in the next version.

DAMON sysfs interface aims to provide full features for users who prefer having
control plane on the user-space.  So, yes, please add that.  Further, I
wouldn't mind having the knob on only DAMON sysfs interface.


Thanks,
SJ

[...]
