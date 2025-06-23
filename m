Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52650188907
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701789; cv=none; b=rpeJllKuspOGO5sgEawI/bo4t4cTNhIiN5WSIdx7LcKj7hejJjZ3oUGoHLcadn8hGAoUGC4k84lHNNMUa5xBivA4OwPspYsd0b4lJYztud2U+LTVNGnWdU2J5MQkWU3lRnnuYJdslffSurhNVNf4aQOgtlu7dlLohs6nEoXqrxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701789; c=relaxed/simple;
	bh=EjUF144md/K781GFtJ0hEHO/hvbh5XE87mCjkxYGsM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=frp8MoMug7Me4APllQn67s6FYFTBRxHJE9CT4YUDCP7BS+nQG7cKb//3hdS0HVCo0F3KKR54nY/Q9NUqmj2a6Xp4RvljXfmS2hMS0VrNFAQHnUOQhbZU73qF6oHoknkURNyzlj7iE1S8xysZ/zKW9cjyZ8IlDAJGXD174KYMJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j02PsBsS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j02PsBsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F11CC4CEED;
	Mon, 23 Jun 2025 18:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750701788;
	bh=EjUF144md/K781GFtJ0hEHO/hvbh5XE87mCjkxYGsM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j02PsBsSaVPCzjELCgDieddIpt0pdnoOjIxmyGeZAvs/r7x4OYLYgOvE6sMpn+xWt
	 xk6LVdi+inRRAswpM01XXa3T6rhDFdkMlf8GWXZid6ot5KofzN0W4XGmWyS380ioIK
	 77fmYZ294fBMuwUa9wZjFxaUlsK6L4CunyiC3pJG0Z1kiN78zcToaO5YDCxkW766jt
	 c9IpwYzCfBAGYJPSXKYWcdlolPDmX/McQsWpbfM0K/ggjFxj4vW2xe5+MOn2kf+NYE
	 KjzNw9uz/2ADujapJpUdmozbOL7BnZHujUjgXhlvpp4aDwBVldz7sbtV7FaFn7yxtr
	 pA3F6D4u/sTUA==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH 1/3] mm/damon: do not allow creating zero size region
Date: Mon, 23 Jun 2025 11:03:05 -0700
Message-Id: <20250623180305.44277-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <86e91607-f008-4fc1-8660-021b8e257a10@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Jun 2025 11:58:53 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> Thanks for the kind review as always!

My pleasure :)

> 
> On 6/23/2025 1:04 AM, SeongJae Park wrote:
> > On Sun, 22 Jun 2025 21:09:23 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > 
> >> Creating zero size region leads a divide by zero error inside
> >> damon_get_intervals_score() as follows.
> >>
> >>    static unsigned long damon_get_intervals_score(struct damon_ctx *c)
> >>    {
> >>        struct damon_target *t;
> >>        struct damon_region *r;
> >>        unsigned long sz_region, max_access_events = 0, access_events = 0;
> >>        unsigned long target_access_events;
> >>        unsigned long goal_bp = c->attrs.intervals_goal.access_bp;
> >>
> >>        damon_for_each_target(t, c) {
> >>            damon_for_each_region(r, t) {
> >>                sz_region = damon_sz_region(r);
> >>                max_access_events += sz_region * c->attrs.aggr_samples;
> >>                access_events += sz_region * r->nr_accesses;
> >>            }
> >>        }
> >>        target_access_events = max_access_events * goal_bp / 10000;
> >>        return access_events * 10000 / target_access_events;  /* divide by zero! */
> >>    }
> > 
> > Thank you for finding this issue!  Coudl you please further share how zero size
> > region can be made, and if user-space can make the situation?
> 
> The initial values of node*_start_addr and node*_end_addr inside
> /sys/module/mtier/parameters/ are all zeros so I saw this problem easily by
> setting Y to "enabled".

Thank you for clarifying!  Please add this description on the commit message if
you send a next version of this patch, with Fixes: tag.

> 
> >>
> >> This patch makes a NULL return for such cases when creating a region
> >> inside damon_new_region().
> > 
> > I agree zero size region could look silly.  But I don't really think it should
> > be prohibited.  What about modifying damon_get_intervals_score() instead?
> > Maybe we can set target_access_events as 1 in this case.
> 
> Hmm... I don't get what you mean by setting "target_access_events" to 1 for such
> cases.  Could you please explain more?

I mean, something like below.

@@ -1449,6 +1449,7 @@ static unsigned long damon_get_intervals_score(struct damon_ctx *c)
                }
        }
        target_access_events = max_access_events * goal_bp / 10000;
+       target_access_events = target_access_events ? : 1;
        return access_events * 10000 / target_access_events;
 }

> 
> > 
> >>
> >> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> >> Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> >> ---
> >>   mm/damon/core.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/mm/damon/core.c b/mm/damon/core.c
> >> index b217e0120e09..44740da337fd 100644
> >> --- a/mm/damon/core.c
> >> +++ b/mm/damon/core.c
> >> @@ -126,8 +126,11 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
> >>        if (!region)
> >>                return NULL;
> >>
> >> +     if (start == end)
> >> +             return NULL;
> If you're okay, then I'd like to modify this as follows again.
> 
> +     if (start >= end)
> +             return NULL;
> 
> What do you think about this?

I still prefer fixing the found bug on the spot.  I don't think having zero or
negative size regions is really somewhat we always prohibit.


Thanks,
SJ

[...]
