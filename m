Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD5192590;
	Wed, 11 Mar 2026 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238542; cv=none; b=SqKq+VWYC5jpbL8vCfK3w5uwPeTM0OcuvwEJBveOB+h8/ySzUcNipTd+EIDBd1o1EV496vQUVnC8OHuHl2B5RGjssRmPbZhKeAtc9Lvi3pnC1G6ay/tEODsBdrb9blAdMtC8XYW8v5V0XEF8I5feSdZHpZWtUiM3mc1uErrsJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238542; c=relaxed/simple;
	bh=gJf2hT1zxwV0L7MQvy0u3llLuP0G7FBCE3sa8wyOois=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMNyM0HVl6RNBuOly/JwszkE7GYKOYEIm2e/ggm1zFiXipoaq0Yv2gkMe0zI8mFl7L2TPQpqwOI53gjWLxzMZL44/fzjYpCayZJcKXLtz5lip/+j0qoDhjGdIaMHnAnk59hOLBYdpLSqJDVrm4UGMljM8emoyuLYFKH+ICqgqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3DndFFE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3DndFFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECB3C4CEF7;
	Wed, 11 Mar 2026 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773238542;
	bh=gJf2hT1zxwV0L7MQvy0u3llLuP0G7FBCE3sa8wyOois=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3DndFFE9UkffnsBBonl96rB5qoX1Z3uyeu5Mj3TI2ljDgv3/9fzJ89O/jXyrvw1p
	 UkszehXje7Of9U7WRDkWoq885wyPcFnnN6v/CkwRAMuS7HehWQq7eWkySs3TvKCD+1
	 B9cJIeCm603PxlOK17q5MhQiPnrqQL9qwVFPWm2t9EuoyC+GTTUc89bJZ9go7RkbFq
	 yZdianXHsN0JOaeOBsx9vqASMrYEQuXHS/FprXofvqFCaL/8J9G1SRdgMxQFzDMhdX
	 wdurVrXQesYNuBEgARJr6+oQVEh4UzIG06lBd3KpADdGkJKryfMuh1PHogzbm7ncOH
	 CDiZfZfU2bGRA==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] mm/damon: Generic context creation for modules
Date: Wed, 11 Mar 2026 07:15:32 -0700
Message-ID: <20260311141533.96435-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <013c9fcd-bdeb-4508-8495-9ce9cd65b578@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Mar 2026 16:10:19 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 3/11/2026 3:57 AM, SeongJae Park wrote:
> > On Tue, 10 Mar 2026 16:24:17 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> It is more elegant to have a generic version of new context creation
> >> which receives the mode as a parameter.
> >>
> >> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
> >> ---
> >>  mm/damon/lru_sort.c       | 5 +++--
> >>  mm/damon/modules-common.c | 6 +++---
> >>  mm/damon/modules-common.h | 4 ++--
> >>  mm/damon/reclaim.c        | 5 +++--
> >>  4 files changed, 11 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> >> index 7bc5c0b2aea3..143ee0b21da6 100644
> >> --- a/mm/damon/lru_sort.c
> >> +++ b/mm/damon/lru_sort.c
> >> @@ -287,7 +287,8 @@ static int damon_lru_sort_apply_parameters(void)
> >>  	unsigned int hot_thres, cold_thres;
> >>  	int err;
> >>  
> >> -	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
> >> +	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
> >> +				DAMON_OPS_PADDR);
> > 
> > I like the name of the function is becoming shorter.  But I'm not happy with
> > the fact the resulting calling code becomes longer.
> > 
> > I understand you are doing this extension because you want a version of the
> > function for vaddr.  What about introducing another dedicated function, say,
> > damon_modules_new_vaddr_ctx_target() ?
> > 
> > And you can avoid duplicates between damon_modules_new_{p,v}addr_ctx_target()
> > by implementing internal function, say, damon_modules_new_ctx_target() that
> > receives the damon_ops_id.  And damon_modules_new_{P,v}addr_ctx_target() will
> > just wrappers of damon_modules_new_ctx_target().
> 
> Sure, I will do it.

Thanks for accepting my suggestion.

> 
> Since this is some generic code not related to the module I am working on,
> maybe I can move this to a different patch set that we can upstream. What do
> you think?

Please feel free to do so :)


Thanks,
SJ

[...]
