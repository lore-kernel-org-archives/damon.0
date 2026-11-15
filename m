Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778947;
	b=5Dbg14W2UmPCWWvWv2IiViWpEq6PEjRaSlNsXDzB7yAqYos2k5q4qXhQ17Js4JNYm1g4
	 TgbVIxgFiRmKYeScN5NnsiqtLQX8pwRcRjOoPlngEzCP0CW94rWNxAcR5IqwIdG05mWW7
	 TCXfhunTGaQv35vmbLuqoD3e4FbRnhwSwnQkImLzNgLZp5Kon0RMA6QnYsDbJMsStVZqw
	 DLnIIRM+H7JObEPFOe6LoOaT/7kSoMTqXLtz4Mxc8IaTqXimSNgVC0AAcu3Uz3A2O/6ig
	 /KlF4ECKpes3kIydImQTgs300v4/B2Zt/rPrOhdrGQsV9oI3sRd94xE7B0AzlS8v/cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778947;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=t0D1RubYmGsNEhaSdDTnNXY/ONXMzZn2GmBi+6KjjSU=;
	b=a2fa9F4SWughwpihjHsyYKJHzY+z3dDy9mei3ZsRJ2pstyZSFDsr8JLToFpXp2Kb5QKu
	 F6ZPlgBtr4038vwCbGmflVZObnlKqXR8CfCYtmbt6vJytK+YGG2gvWrF6gfnSLSRY4YVs
	 BFD8OB7U8JtUjn/CHV9koAGj5pCz5fi/qc3ygYI5oGPgoUUaQpcIqDctCSaREdwBHwvJ+
	 F8V8RNej6tXj/WdrXfKUk9eh33hH94+OBSV6cBdSk3vGYW1zDrVuZzdyw7OIpbnN1u5Ii
	 9mRveF0SDliPTVjsBawCrjwAXRORxizwPslB4kZU/mdIF5VMTVNXZHbftAL8/STwUQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VH06rsBq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B317606A31F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VH06rsBq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DB81F000C4;
	Sun, 15 Nov 2026 21:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794778947;
	bh=t0D1RubYmGsNEhaSdDTnNXY/ONXMzZn2GmBi+6KjjSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VH06rsBqiZHRMiVAjPZ/Z2nxFxK0WsMQgsV5i9o52Gk+n5ZDg7zx7EFB2HRFrmYtx
	 SFMSQXXjIbWIRLhk4vZakW2oS0Cegc60Kp2JqtITQXMyHbAFeQVAr1w/6QaJAaYhqu
	 heKKjKF7foFZft+ffXxCpx7W7FU76X+PRbwDOnN4oYKb6Ybji2cGt+fy+3vKVD9rF8
	 bN0pS6iTL8JTFuh7e97siS9kV/3hVrvEtaW7WV6SJlrXVnCOH1bsJBH5hRYQXeyOoq
	 ebQMVKfIch6yFRaAb0nvhWa/xOvtIsCf+TvqGq01Q/9zx+dJOB1D5FaLHAt0OawE1w
	 WLKBIkWbB5ixA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 16/27] mm/damon/sysfs: support REPORT_MADE type probe filter setup
Date: Sun, 15 Nov 2026 13:42:18 -0800
Message-ID: <20261115214220.103983-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-215848@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 15 Nov 2026 20:41:12 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] mm/damon: out-of-bounds and uninitialized access in
>   damon_report_exist()
> - [Medium] mm/damon: uninitialized report_type in damon_commit_filters()
> --
> 
> commit 6058e18a855d5b73c171dc4b94eb6031f06fdc63
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: support REPORT_MADE type probe filter setup
> 
> This commit adds "report_made" to the DAMON sysfs probe filter type list
> and copies the filter's report_type when setting up probe filters.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index ca971cf1dcf6d..1c171af4590a8 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1016,6 +1016,10 @@ damon_sysfs_filter_type_names[] = {
> >  		.type = DAMON_FILTER_TYPE_ACTIVE,
> >  		.name = "active",
> >  	},
> > +	{
> > +		.type = DAMON_FILTER_TYPE_REPORT_MADE,
> > +		.name = "report_made",
> > +	},
> >  };
> >  
> >  static ssize_t type_show(struct kobject *kobj,
> 
> [Severity: High]
> Can enabling DAMON_FILTER_TYPE_REPORT_MADE filters cause uninitialized and
> out-of-bounds accesses on queue->reports[]?
> 
> In damon_submit_report(), each report is stored at queue->reports[tail] and
> then queue->tail is incremented, so queue->tail points to the next slot to
> write rather than the most recent entry:
> 
> mm/damon/core.c:damon_submit_report() {
>     ...
> 	tail = queue->tail;
> 	if (tail == queue->size)
> 		tail = 0;
> 	queue->reports[tail] = *report;
> 	queue->tail++;
>     ...
> }
> 
> When damon_pa_filter_match() calls damon_report_exist() for a report_made
> filter, the loop reads queue->reports[idx] starting at idx = queue->tail
> before decrementing idx:
> 
> mm/damon/core.c:damon_report_exist() {
>     ...
> 	idx = queue->tail;
> 	for (nr_read = 0; nr_read < queue->nr_reports; nr_read++) {
> 		report = &queue->reports[idx];
> 		if (idx)
> 			idx--;
> 		else
> 			idx = queue->size - 1;
>     ...
> }
> 
> While queue->nr_reports < queue->size, the first iteration reads the
> unwritten slot at queue->reports[queue->tail] and the loop stops before
> checking queue->reports[0].  Once queue->tail reaches queue->size,
> damon_report_exist() reads out of bounds at queue->reports[queue->size],
> and the next damon_submit_report() wraps only the local tail variable
> before incrementing queue->tail past queue->size, causing subsequent
> submissions and lookups to write and read out of bounds on the heap.

Yes, I will fix submit_report() and report_exist() in earlier patches.

> 
> > @@ -2336,6 +2340,8 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
> >  		} else if (filter->type == DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
> >  			filter->range_min = sys_filter->range_min;
> >  			filter->range_max = sys_filter->range_max;
> > +		} else if (filter->type == DAMON_FILTER_TYPE_REPORT_MADE) {
> > +			filter->report_type = sys_filter->report_type;
> >  		}
> >  		damon_add_filter(probe, filter);
> >  	}
> 
> [Severity: Medium]
> Does committing a new DAMON_FILTER_TYPE_REPORT_MADE filter to a running
> context leave new_filter->report_type uninitialized?
> 
> When damon_sysfs_commit_input() commits the context built here via
> damon_commit_ctx() -> __damon_commit_ctx() -> damon_commit_probes() ->
> damon_commit_filters(), newly added filters are allocated with
> damon_new_filter(), which does not initialize the union in struct
> damon_filter, and the switch in damon_commit_filters() does not handle
> DAMON_FILTER_TYPE_REPORT_MADE:
> 
> mm/damon/core.c:damon_commit_filters() {
>     ...
> 		new_filter = damon_new_filter(src_filter->type,
> 				src_filter->matching, src_filter->allow);
> 		if (!new_filter)
> 			return -ENOMEM;
> 		switch (src_filter->type) {
> 		case DAMON_FILTER_TYPE_MEMCG:
> 			new_filter->memcg_id = src_filter->memcg_id;
> 			break;
> 		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> 			...
> 		default:
> 			break;
> 		}
>     ...
> }
> 
> As a result, damon_pa_filter_match() passes uninitialized slab memory in
> new_filter->report_type to damon_report_exist().

Yes, I will fix this in the earlier patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261115202849.99134-1-sj@kernel.org?part=16
> 


Thanks,
SJ
