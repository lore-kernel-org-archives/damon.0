Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02EC1DED77
	for <damon@lists.linux.dev>; Sat, 20 Sep 2025 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758372785; cv=none; b=my1c7cJ4tRjMnIo13HXfHUyuzDu8x6VyeOHpLha1qDGUjwAUIkpnDuDQKWGyXhhdsYnzatom7qtUqbQkiMl6ywV5uPR5eabOCkEDkAsv62xgdpxArcRuW4jbY+xs2YLYy4+pdTsr2SN/KrJ0zZi7+fuvkM2n4Kwnl/xxqWHRcXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758372785; c=relaxed/simple;
	bh=zOmlwbtn9hBMIVxVRU91NKixfiksz1gaFAzgl2RQ0II=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYDX9ZeNtbMZ5CyPA6vy73fmyPegl2MZTFQ19CNiQesU5LXv79FiFjSxfNmx6/B7NRZV93Upa/VbdlGLk2E+/YYflAbuJTNrekcWY1aQ3ql2PKu83PQtmYRfMISwgUOqyQk8lqhAe7FRHbOX4gCxWxYYdWAfB/zVJiHG8H4royg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlmKcxQe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlmKcxQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B4DC4CEEB;
	Sat, 20 Sep 2025 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758372784;
	bh=zOmlwbtn9hBMIVxVRU91NKixfiksz1gaFAzgl2RQ0II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlmKcxQevV0A9ZYrgdIHLC0acvai7k8FEWjO3uW5QTKZikR96WiFyTLncWVbNKadm
	 bRZ5D+ogV4th279svp+lnDeTRKrFxZEmRbHxLg2FeSVHKPmca+l4N+6IxiSflV8K5P
	 rJzjGpo/HB48whWp5nf1elKkTuvPvChuZnGEgMRFNyEJTO+8q6oHDZKEsfyrbb0Mgh
	 RenoxudT7f3DO/5oQnuae26oK//BFcIE3HP9wUVOlr+tdUgHNM2erkVUDxCI+9L+9R
	 iHDCF7bf+qIPDfRgBkBCaf6wTUB9Q5Yk5jSWPOH/xTaOH2zBJjV6C5ZhezhEGu5Enw
	 xoraeF0AgglhQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	damon@lists.linux.dev,
	stable@vger.ekrnel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/damon/sysfs: do not ignore callback's return value in damon_sysfs_damon_call()
Date: Sat, 20 Sep 2025 05:53:02 -0700
Message-Id: <20250920125302.84101-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250920121131.83174-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Sat, 20 Sep 2025 05:11:31 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat, 20 Sep 2025 19:52:36 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 
> > The callback return value is ignored in damon_sysfs_damon_call(), which
> > means that it is not possible to detect invalid user input when writing
> > commands such as 'commit' to /sys/kernel/mm/damon/admin/kdamonds/<K>/state.
> > Fix it.
> 
> Thank you for finding this issue, Akinobu!  Before the introduction of
> damon_sysfs_damon_call() and its usages, DAMON sysfs interface was returning an
> error in case of such command failures.  So this is fixing a user-visible
> unintended behavior change.  Hence this may deserve Cc-ing stable@ in my
> opinion.
> 
> > 
> 
> So, below may better to be added?
> 
> Fixes: f64539dcdb87 ("mm/damon/sysfs: use damon_call() for update_schemes_stats")
> Cc: <stable@vger.ekrnel.org> # v6.14.x
> 
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> > ---
> >  mm/damon/sysfs.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index fe4e73d0ebbb..97e16f00f23e 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1627,12 +1627,15 @@ static int damon_sysfs_damon_call(int (*fn)(void *data),
> >  		struct damon_sysfs_kdamond *kdamond)
> >  {
> >  	struct damon_call_control call_control = {};
> > +	int err;
> >  
> >  	if (!kdamond->damon_ctx)
> >  		return -EINVAL;
> >  	call_control.fn = fn;
> >  	call_control.data = kdamond;
> > -	return damon_call(kdamond->damon_ctx, &call_control);
> > +	err = damon_call(kdamond->damon_ctx, &call_control);
> > +
> 
> I think the above new line is not really needed, but it is definitely trivial.
> 
> > +	return err ? err : call_control.return_code;
> >  }
> >  
> >  struct damon_sysfs_schemes_walk_data {
> > -- 
> > 2.43.0
> 
> 
> Thanks,
> SJ
> 
