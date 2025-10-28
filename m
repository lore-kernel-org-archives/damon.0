Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747DF1B4F2C;
	Tue, 28 Oct 2025 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661980; cv=none; b=i9I7QP9inbc1SrZbXrGMs8jme5zQ5IBQ/lwOni6+8XIMrf8veqZV7opTk1AnuOhRRhsrS0ilpgjzd9+N/+SqLqTSekS3RfvELnhV3hZv5ZKExSCOyBjeN6utisTSsF5s1N0pYDfK4q/o+Hr1c1u6gI786vGIEaqs30SKiRB3pAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661980; c=relaxed/simple;
	bh=m8qK9GrgBHEtoVg+nw/e+zKxXz+F9N3oAZJPB+bVAzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJwQnUWPD9FYFz5S0Pz7Y35g3e2AYEN6Vha9CbPDMmi6Nvt3L6t2tN3rl9W91vsKRzouaqYq2W/BC3/P1ReZ8HcAfl080NZC8LXm4VAYBEA9C/tz4zuioJbdsEH7wzjumNTTwjZmaK1SOityTWN1NEVtVTNPMoei0y9PNKekG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbMXCvkX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbMXCvkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9596C4CEE7;
	Tue, 28 Oct 2025 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761661977;
	bh=m8qK9GrgBHEtoVg+nw/e+zKxXz+F9N3oAZJPB+bVAzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LbMXCvkXhDDPeEkYXnOKpdGA1nfQvLIw5sSl/MYVTkKI7aknfwsfQ24ERHdu4BHIA
	 rselvPLqKbpZ6dnfgJs+13sTqw6xgfGG+gnR89HTweuQYCFj7JI6TtLtrzt2ZyJW4U
	 qTkf3OacDQT0S1135AhcMB+vsUd1HnsvMJSSzqQWIYXfLbuVuoGv8sU5zMU2qqhpCC
	 KDdMK2a4TscA23GUnkYxzY4P/BFPjCkKs30kmDkUR6LZXymGnR2PJn5P91vmV/euD8
	 y4lP/GbEtC4hrmA7Iw7R4S7gi0w9BkFZ2fey1WjDd4vNOLxY7wv2fe8hcgI0FiNUsw
	 Z2cExOhSi1oew==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH] mm/damon/stat: set last_refresh_jiffies to jiffies at startup
Date: Tue, 28 Oct 2025 07:32:49 -0700
Message-ID: <20251028143250.50144-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028141915.49989-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Oct 2025 07:19:14 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 28 Oct 2025 14:19:27 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> 
> > In DAMON_STAT's damon_stat_damon_call_fn(), time_before_eq() is used to
> > avoid unnecessarily frequent stat update.
> > 
> > On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to make
> > jiffies wrap bugs appear earlier. However, this causes time_before_eq()
> > in DAMON_STAT to unexpectedly return true during the first 5 minutes
> > after boot on 32-bit systems (see [1] for more explanation, which fixes
> > another jiffies-related issue in DAMON). As a result, DAMON_STAT does not
> > update any monitoring results during that period, which can be more
> > confusing when DAMON_STAT_ENABLED_DEFAULT is enabled.
> > 
> > Fix it by setting last_refresh_jiffies to jiffies at startup.
> 
> Nice catch, thank you for this patch!
> 
> > 
> > [1] https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
> > 
> > Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
> > Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> > ---
> >  mm/damon/stat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > index 6c4503d2aee3..6dc3e18de910 100644
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> > @@ -132,6 +132,9 @@ static int damon_stat_damon_call_fn(void *data)
> >  	struct damon_ctx *c = data;
> >  	static unsigned long last_refresh_jiffies;
> >  
> > +	if (unlikely(!last_refresh_jiffies))
> > +		last_refresh_jiffies = jiffies;
> > +
> 
> How about doing the initialization together with the declaration?  E.g.,
> 
>  static int damon_stat_damon_call_fn(void *data)
>  {
>         struct damon_ctx *c = data;
> -       static unsigned long last_refresh_jiffies;
> +       static unsigned long last_refresh_jiffies = jiffies;

Actually, a similar issue can happen again if DAMON_STAT is stopped and
restarted by user.  That is, if user stops DAMON_STAT just after
last_refresh_jiffies is updated, and restart it after 5 seconds or more, the
time_before_eq() on damon_call_fn() will return true, so stat updates will
happen earlier than expected.  Shouldn't be a real problem, but better to avoid
if possible.

How about making last_refresh_jiffies a global variable and initialize it on
damon_stat_start()?  To avoid unnecessary name conflicts, the variable name
would also better to be changed, e.g., damon_stat_last_refresh_jiffies.


Thanks,
SJ

[...]
