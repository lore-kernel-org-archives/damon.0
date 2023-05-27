Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162537D
	for <damon@lists.linux.dev>; Sat, 27 May 2023 02:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5480C433EF;
	Sat, 27 May 2023 02:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685153347;
	bh=HN9NwkpD1iuTdQGq2w1K5FjteO+8O/u8Z419WVY0jwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=YYMmaGwo67YMuvAG4IqiZxvJBDzjj1lsDAT9lxqlhcLdxk4tYmTRwTqv7gDVLzWiQ
	 f4jqOoGVEU/vaCd5z7MG8XvlRr4iuJrBhQ1/6ffwKU6mW/qPwLqrtPS/otAo3dYLyQ
	 wLgvfXYJaV+62HBxf520xvXF3Fu+BYHAt2DfdcBChjruXxCJZ8fjdU7DBa5abQFL27
	 H18U1jrgQZiycmV9ZucdsYjG2P1oC5tnaJy/+ULlPqoOnCdU7i73Mdd+NwwtRDI/Gb
	 A2Wb3/TwLatioa0XJKJF6GjC2o1zhZ89B5aBPazxNExc5iLoCsPwXib+v34lLXjyJg
	 QLn8Z1y75EJOQ==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	syzbot <syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [damon?] divide error in damon_set_attrs
Date: Fri, 26 May 2023 19:08:51 -0700
Message-Id: <20230527020851.7855-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <81956ca8-8228-1210-c855-e652e2f263dc@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

On Sat, 27 May 2023 10:02:38 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> 
> 
> On 2023/5/27 9:46, SeongJae Park wrote:
> > Hi Kefeng,
> > 
> > On Sat, 27 May 2023 09:15:01 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > 
> > [...]
> >>>
> >>> Nice and effective fix!  Nevertheless, I think aggregation interval smaller
> >>> than sample interval is just a wrong input.  How about adding the check in
> >>> damon_set_attrs()'s already existing attributes validation, like below?
> >>
> >> Yes, move the check into damon_set_attrs() is better
> > 
> > Thank you for this kind comment!
> > 
> >> , and it seems that
> >> we could move all the check into it, and drop the old_attrs check in
> >> damon_update_monitoring_results(), what's you option?
> >>
> >>
> >> diff --git a/mm/damon/core.c b/mm/damon/core.c
> >> index d9ef62047bf5..1647f7f1f708 100644
> >> --- a/mm/damon/core.c
> >> +++ b/mm/damon/core.c
> >> @@ -523,12 +523,6 @@ static void damon_update_monitoring_results(struct
> >> damon_ctx *ctx,
> >>           struct damon_target *t;
> >>           struct damon_region *r;
> >>
> >> -       /* if any interval is zero, simply forgive conversion */
> >> -       if (!old_attrs->sample_interval || !old_attrs->aggr_interval ||
> >> -                       !new_attrs->sample_interval ||
> >> -                       !new_attrs->aggr_interval)
> >> -               return;
> >> -
> >>           damon_for_each_target(t, ctx)
> >>                   damon_for_each_region(r, t)
> >>                           damon_update_monitoring_result(
> >> @@ -551,6 +545,10 @@ int damon_set_attrs(struct damon_ctx *ctx, struct
> >> damon_attrs *attrs)
> >>                   return -EINVAL;
> >>           if (attrs->min_nr_regions > attrs->max_nr_regions)
> >>                   return -EINVAL;
> >> +       if (attrs->sample_interval > attrs->aggr_interval)
> >> +               return -EINVAL;
> >> +       if (!attrs->sample_interval || !attrs->aggr_interval)
> >> +               return -EINVAL;
> > 
> > In my humble opinion, the validation for monitoring results and for general
> > monitoring could be different.  For example, zero aggreation/sampling intervals
> > might make sense for fixed granularity working set size monitoring.  Hence, I'd
> > prefer keeping those checks in the damon_update_monitoring_results().
> 
> 
> ok, will keep that,

Thank you for agreeing.

> I check the damon_set_attrs() called by 
> lru_sort/reclaim monitor and sysfs/dbgfs, the above changes should be 
> ok, maybe missing something, the working set size monitoring is not 
> public for now?

You're correct.  Working set size monitoring is not somewhat currently
publicly exists, but only possible usage of DAMON at the moment.


Thanks,
SJ

[...]
