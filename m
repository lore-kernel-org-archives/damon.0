Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9358164CFC;
	Wed, 15 May 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789443; cv=none; b=BbC2TTD6AjchdYCkTuDG32qWbl2k2fJF2K+zWWLQqDM22cDJFBNcpuQ7vn73NnemmKtcqf8WSKhyCS1Z9ziiravmcEUw5TPxwKVUs24kYN9gDDMESHI58m5z9CirPOtgYLzJWXt0p63sPBWh7+2BFSbOdMmqIYk5HrX3GE3VeSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789443; c=relaxed/simple;
	bh=5xAfxwaPOj0PDLQIrXWQC4UVdY3a65c4Z2mw1Rdp9lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H/bWJKl8PFocLy28p8uwFTk+b+lgf4w4waf9ypyEOQ6K6xv1nope8bAAYc3owl9L9E9MAOBOSoFLmGzfaC+p13HYcKQsF3J/0ygKR5csdedvXPl1EKAToWkvwTRTgHlPor1fe0gq46047GIhg7VJHZtfweYqd/AvgR3OJ6V7+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKHNmsvz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKHNmsvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEC9C116B1;
	Wed, 15 May 2024 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715789443;
	bh=5xAfxwaPOj0PDLQIrXWQC4UVdY3a65c4Z2mw1Rdp9lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKHNmsvzGiiFfggvMDXWGtz/DhV6rLSJn3ZEn8DZFy3hpSs9v4PGz+g9dyi9zorG/
	 NUdyzYo54aI4xVkH0aA0j+xd6NtcR4ukkR7RLlgge9OQsV2ohM9EXIKtNM4s/6y55P
	 gDSDCuIlD5vTvglTeUgUW4L4xtyz7Pw/SIxbCbD7I9ew4kP2juhacSy3Q7KFlgOSRC
	 2ZGBqE/B0rTxKFAc2vKqJFqiE4m0zfQK/468RI0UJFni7ETDuvYzh3ZitnEMOo2ZzO
	 GQ+fmUgd6f34aeIcdy/dDp+iAgfC1eiTHZMloiBNvJ7krLAmQKCPw/QcSqlqXoRugT
	 Kf4uAjMuZlEJg==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH v4 1/5] mm: make alloc_demote_folio externally invokable for migration
Date: Wed, 15 May 2024 09:10:40 -0700
Message-Id: <20240515161040.69242-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240513120358.1503-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 May 2024 21:03:56 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> On Sun, 12 May 2024 10:54:43 -0700 SeongJae Park <sj@kernel.org> wrote:
> > From: Honggyu Kim <honggyu.kim@sk.com>
> > 
> > The alloc_demote_folio can be used out of vmscan.c so it'd be better to
> > remove static keyword from it.
> > 
> > This function can also be used for both demotion and promotion so it'd
> > be better to rename it from alloc_demote_folio to alloc_migrate_folio.
> 
> This description doesn't match with the changes below.

You're right.  Thank you for checking this.

> 
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/internal.h | 1 +
> >  mm/vmscan.c   | 3 +--
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/internal.h b/mm/internal.h
> > index b2c75b12014e..b3ca996a4efc 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1052,6 +1052,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
> >          unsigned long, unsigned long);
> >  
> >  extern void set_pageblock_order(void);
> > +struct folio *alloc_demote_folio(struct folio *src, unsigned long private);
> 
> I still prefer to rename it to alloc_migrate_folio.

And I still have no objection at renaming.  I didn't make the change here not
because I want the change removed, but just because I wrote this RFC v4 in hope
of seeing how minimum this patchset can be while addressing my comments.
Please feel free to add the change back on the next revision of this patch if
you write.  Maybe keeping this patchset without the renaming change, and
discussing the renaming with a separate patch is also an option in my opinion.

> 
> >  unsigned long reclaim_pages(struct list_head *folio_list);
> >  unsigned int reclaim_clean_pages_from_list(struct zone *zone,
> >  					    struct list_head *folio_list);
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 6981a71c8ef0..27269bc2bcc5 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -933,8 +933,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
> >  		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
> >  }
> >  
> > -static struct folio *alloc_demote_folio(struct folio *src,
> > -		unsigned long private)
> > +struct folio *alloc_demote_folio(struct folio *src, unsigned long private)
> 
> Here as well.

Ditto.

> 
> >  {
> >  	struct folio *dst;
> >  	nodemask_t *allowed_mask;
> > -- 
> > 2.39.2
> > 
> 
> Thanks,
> Honggyu


Thanks,
SJ
