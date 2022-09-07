Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888F360
	for <damon@lists.linux.dev>; Wed,  7 Sep 2022 16:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06ABCC433B5;
	Wed,  7 Sep 2022 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662568528;
	bh=zWkZ/zYNvsz9wwMSJsInl5cy4BtZSxIMhYu8SRbbHak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvHKrwh/2Y7ITz3fzPfOY9GlKwue3RTtkogmJV8qvyt2G369ndgZLJlzezzRonKE9
	 bA1FQJ2X8U7iw5SHtKXRRC/bwUR+90/tSQwoiuvndXrolJZNNbhOuQA8H1BHzf1cig
	 PvmA8eQg3wpjsAOdaCHxCVqzznwaJCCLM2Sdk20NILXsdnzKAS09g6c+fuMoQmbW+Q
	 r3ct0FQE+lG3xpWsovAItnHihd8oLyipTWnq3lBOHGxAEkJlc+eu4gsVY3SOnMDfcU
	 m00uuv4xqAbSmwq8cbIXJtxprkvUP2ggR8QxEyWZBjK/huyqzxFpQCvUIthKrbE5J/
	 YHOfioenVio6w==
From: SeongJae Park <sj@kernel.org>
To: Yun Levi <ppbuk5246@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [Question] About damon_set_regions function.
Date: Wed,  7 Sep 2022 16:35:25 +0000
Message-Id: <20220907163525.78126-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAM7-yPSeNe9v4QGRoqXkjcLtio3xiJKha9bRoPiu7v=o3RG2Nw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Levi,

On Wed, 7 Sep 2022 13:50:01 +0900 Yun Levi <ppbuk5246@gmail.com> wrote:

> > This would fix the specific case, but there might be more than 2 regions that
> > not contiguous.  I think we should also handle the case?  E.g.,
> 
> Thanks for your review! I miss this case.
> In that case maybe some of former regions wouldn't be removed!
> 
> 
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -194,6 +194,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >  {
> >         struct damon_region *r, *next;
> >         unsigned int i;
> > +       bool found;
> >
> >         /* Remove regions which are not in the new ranges */
> >         damon_for_each_region_safe(r, next, t) {
> > @@ -235,6 +236,24 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >                         first->ar.start = ALIGN_DOWN(range->start,
> >                                         DAMON_MIN_REGION);
> >                         last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
> > +
> > +                       /* fill the holes between first and last */
> > +                       found = false;
> > +                       damon_for_each_region(r, t) {
> > +                               struct damon_region *next;
> > +                               if (r == first)
> > +                                       found = true;
> > +                               if (!found)
> > +                                       continue;
> > +                               if (r == last)
> > +                                       break;
> > +                               next = damon_next_region(r);
> > +                               if (next->ar.start != r->ar.end) {
> > +                                       newr = damon_new_region(r->ar.end, next->ar.start);
> > +                                       damon_insert_region(newr, r, next, t);
> > +                               }
> > +                       }
> > +
> >                 }
> >         }
> >         return 0;
> >
> > Of course, the code should be cleaned up (e.g., would better to use
> > list_for_each_entry_from() and factor out to a separate function).  This is
> > only for a PoC.  Is there anything I'm missing?
> >
> 
> I think it's good.
> But, IMHO, I don't know if it would be useful to merge
> first <= new_insert_area <= last with new inserted regions as one region.

In the case, I concern that we will lost the access monitoring information of
the first and last regions that we collected so far.

> 
> if merging is meaningless, LGTM.

Thanks.  If you don't mind, I will post a patch for this soon.


Thanks,
SJ

> 
> Thanks.
> --
> 
> Sincerely,
> Levi
