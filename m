Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D77C
	for <damon@lists.linux.dev>; Mon,  6 Jun 2022 17:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BC6C385A9;
	Mon,  6 Jun 2022 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654536552;
	bh=2UlUlFj3nh/W/pRKzsyTq+wRtsnz9IPug2OoXTxLr28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAun6vD7M1R/E3dkCM+DWA8oR1o2L72aaoM84R4ZAyxpni6mvl3YPMOOJwwiZdJdU
	 65YJFeieE7ZxNP72YPXsgRAZCvsH8jPmx2lsA6QaeRJ9YcK9xbYyrN5oU+7FAo9cLl
	 A4RbKAv3CXblRIV8P+efXMQZmev7x1YSFn1BkQfWIyCTVyxbX2+SSoxOor7Nk6uuHT
	 w6Px7bvE84yMWIT396x7pJqmAcRWeNOBx8k4bANe63y7Qr7igxTQPx++mK30Aj9b4s
	 XoUAA5dCyw7cm8XU9nVJsUFRKvfSAjCjWW1T6ecrG0A/+9zUqA+hXv2pvfuDpgiCwN
	 S0Ea4ouvelUbg==
From: SeongJae Park <sj@kernel.org>
To: xhao@linux.alibaba.com
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	rientjes@google.com,
	gthelen@google.com,
	baolin.wang@linux.alibaba.com,
	tuhailong@gmail.com,
	wangkefeng.wang@huawei.com,
	tangmeng@uniontech.com,
	hanyihao@vivo.com
Subject: Re: [RFC] A few plans for DAMON sysfs extensions
Date: Mon,  6 Jun 2022 17:29:08 +0000
Message-Id: <20220606172908.47683-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <83b86096-089e-c302-874c-c1a27f9c2d84@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xin,

On Mon, 6 Jun 2022 19:37:56 +0800 xhao@linux.alibaba.com wrote:

> Hi, SJ
> 
> On 6/2/22 8:29 AM, SeongJae Park wrote:
> > Hello all,
> >
> >
> > I have discussed with several people about how they want to use DAMON for their
> > specific use cases.  For supporting those in perfectly optimal way, we might
> > need to make yet another user interface.  However, IMHO, almost all of the use
> > cases could be covered by extending DAMON sysfs interface[1].  Hence, I'd like
> > to share my rough and humble ideas here.  It would be great if you could give
> > some comments.
> >
> > [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#sysfs-interface
> >
[...]
> > Efficient Monitoring Results Collection
> > ---------------------------------------
> >
> > Currently, damon:damon_aggregated tracepoint is the only way to get the DAMON
> > monitoring results in full.  I heard some users don't want to get the full
> > results, but only the monitoring results of specific address range having
> > special access pattern.  For the use case, the tracepoint is inefficient.
> >
> > DAMON sysfs already provides some of the results via the stats/ directory under
> > scheme directory, though.  We could further extend it for more efficient and
> > more detailed results collection.  The idea is, adding a file under each scheme
> > directory, say, report_the_detail.  Writing Y to the file will create a
> > directory called, say, 'report'.  The file will have files similar to that
> > under 'targets/<N>/regions/', and have contents that represents monitoring
> > results of the address ranges that fulfills the scheme's target access pattern.
> >
> > For example, below hierarchy is imaginable.
> >
> >      /sys/kernel/mm/damon/admin
> >      │ kdamonds/nr_kdamonds
> >      │ │ 0/state,pid
> >      │ │ │ contexts/nr_contexts
> >      │ │ │ │ 0/avail_operations,operations
> >      │ │ │ │ │ monitoring_attrs/
> >      │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
> >      │ │ │ │ │ │ nr_regions/min,max
> >      │ │ │ │ │ targets/nr_targets
> >      │ │ │ │ │ │ 0/pid_target
> >      │ │ │ │ │ │ │ regions/nr_regions
> >      │ │ │ │ │ │ │ │ 0/start,end
> >      │ │ │ │ │ │ │ │ ...
> 
> It's good that the damon interface is getting more and more detailed, 
> but what my concern is that if we have too many interface to operate, 
> for example to check the region interface to know every region info,  it 
> will lead to high overhead for kdamond thread  and user-mode tools 
> process,  especially when we monitor many processes in one kdamond thread.

Good point, thank you for letting me know your concern!  I think your concern
makes sense, but in my humble opinion, the overhead could be lower than the
tracepoint in many cases and at least be under control, as the users could
still set the maximum number of regions, and the scheme's target access
pattern.  Also, users can decide when to write 'Y' to the 'report_the_deatail'
file.   If it turns out the control is not so easy, I think we could imagine
adding a sort of time quota for the report/ directory population task.  Of
course, the user space app which will read the directory will need to control
its overhead on its own.


Thanks,
SJ

> 
> >      │ │ │ │ │ │ ...
> >      │ │ │ │ │ schemes/nr_schemes
> >      │ │ │ │ │ │ 0/action
> >      │ │ │ │ │ │ │ report_the_detail	<- this is the new file
> >      │ │ │ │ │ │ │ report/		<- this is the new directory
> >      │ │ │ │ │ │ │ │ regions/nr_regions  <- nr_regions would be read-only
> >      │ │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
> >      │ │ │ │ │ │ │ │ │ ...
> >      │ │ │ │ │ │ │ access_pattern/
> >      │ │ │ │ │ │ │ │ sz/min,max
> >      │ │ │ │ │ │ │ │ nr_accesses/min,max
> >      │ │ │ │ │ │ │ │ age/min,max
> >      │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
> >      │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
> >      │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
> >      │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
> >      │ │ │ │ │ │ ...
> >      │ │ │ │ ...
> >      │ │ ...
> >
> > As I told at the beginning, these are just my rough and humble ideas, and there
> > could be some important things I'm missing.  Also, I don't have ETAs for each
> > of the plans, but currently have biggest interest in the efficient monitoring
> > results collection.  All are in my TODO list, though.  All questions, comments,
> > and suggestons are welcome as always!
> >
> >
> > Thanks,
> > SJ
> 
> -- 
> Best Regards!
> Xin Hao
> 
