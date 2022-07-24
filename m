Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BD2F33
	for <damon@lists.linux.dev>; Sun, 24 Jul 2022 10:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14614C3411E;
	Sun, 24 Jul 2022 10:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658657759;
	bh=O48nzOi2R9qh/OWeuXuKdIr+sSdg6b0BKHyG9bM2AlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HK08MJbbuX/2xeE7knccMg1L3ztoSF1Q7UvZZX/WEM4G4jU7ehUy8UeVydTLHY/hm
	 HHEgXlhBn0JPwmEPsx9M6TB7pbFiHZj8EMjXwsBryBQ+sr+UUBDJTfQjngJWZIfjVp
	 AJ5L1FbsiQ3Q3DA52C6x820W8Nk50D/g7LRe0vSeKWJubwyDG2JRU138k/MYICim1o
	 fHL/izzaRAUipaVmeW+beQkbT1h9oiQ5cvYXoD+ldpYoE+Dp+RaN3NAq2qghbcBmdb
	 wjbHOAC4KwCAyuqOTXKJplX1MckID2mE/1wrFXIKo9FucMXbs0CAoFVKl72jqwieW1
	 Dr99gM5d4DuZw==
From: SeongJae Park <sj@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jianglei Nie <niejianglei2021@163.com>,
	sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/reclaim: fix potential memory leak in damon_reclaim_init()
Date: Sun, 24 Jul 2022 10:15:57 +0000
Message-Id: <20220724101557.3137-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YtzyXCR/OCLYRSPx@kroah.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jianglei and Greg,

On Sun, 24 Jul 2022 09:18:52 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Jul 24, 2022 at 02:52:24PM +0800, Jianglei Nie wrote:
> > damon_reclaim_init() allocates a memory chunk for ctx with
> > damon_new_ctx(). When damon_select_ops() fails, ctx is not released, which
> > will lead to a memory leak.
> > 
> > We should release the ctx with damon_destroy_ctx() when damon_select_ops()
> > fails to fix the memory leak.
> > 
> > Fixes: 4d69c3457821 ("mm/damon/reclaim: use damon_select_ops() instead of damon_{v,p}a_set_operations()")
> > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > ---
> >  mm/damon/reclaim.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 4b07c29effe9..0b3c7396cb90 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -441,8 +441,10 @@ static int __init damon_reclaim_init(void)
> >  	if (!ctx)
> >  		return -ENOMEM;
> >  
> > -	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
> > +	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
> > +		damon_destroy_ctx(ctx);
> >  		return -EINVAL;
> > +	}
> >  
> >  	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
> >  	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
> > -- 
> > 2.25.1
> > 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Thank you for the notice, Greg.  Jianglei, please read that great document.

And Andrew already added the 'Fixes:' and 'Cc: stable@' tags in the patch when
he added[1] it in the mm tree.  Hence I think this would be merged in the
appropriate stable series once it gets merged in the mainline.

[1] https://lore.kernel.org/mm-commits/20220717004946.7AD93C34114@smtp.kernel.org/


Thanks,
SJ
