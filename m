Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD3F4908C3;
	Fri, 24 Jul 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904991; cv=none; b=QqCon1U3ImVJU9iNY1iT5KiKdp1i4SGgazV1MeHxxigcXT+Tu5Bm6zZiJKZDpHPjO8j7kuiefAZt0fzd3llGfIfZL3XOqgEsTQDXXVJLe7bJwqVsxSp816yyoZPd8m2iIgC4BuCQo2iZQItnIJiXow3DLQtD4Dphku0pdpiJ3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904991; c=relaxed/simple;
	bh=8GRrDKuZJZj4E/Xm+k29ZryoSH4Y6+wOVjdVR1qXQek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR8z/4d685SkrCZ/ALcl7LxhIc/ANSX5x6VBIpKwwrK9WLtP3GQQyyOEEb/q7bgt5DiLEvKCfMa7mu/j2+F/SXvfeWvUQwbDUIKvIxY3pHm2RTe+bOycgpjhLoX/EBgiQk1qZxnhwLjICYmC+JLHUKBAVsSnYIZIXgba7H/jveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR89Uyd/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR89Uyd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F1A1F000E9;
	Fri, 24 Jul 2026 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784904990;
	bh=JiA6gXTuTGgHW28jlCoj+TMMGhFDB5U5k/MPS6FjwGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bR89Uyd/XgB4oBVh4s0lK8ELkkaAN+12cpSPi49dnRldX1bdswC+CnbYQfU90xzYV
	 Tbh72IMrIgWPAj0dEi/aR+lfmdDrpNI/TJJVMuMQUTCKVdM2NCvz5xK5gDRr3kQjIn
	 8CUL3N6wVpkg0qZGkoVyDVr+k743IfqtGsRbVSb5rgEmpoLIpOYy0pkvKhYT9eoVWf
	 nowmH4vDHueWAQAESjh/5vi0H3SDonbhTpqJ9357TyZFoYcES0t2ZiOnTJKEyVtfKp
	 z1sCYa4F5jI6ban+BjGttzEZwHsNxGduDi4+MYwnU38rf46caVB3+lIvltJZJVJnLn
	 C/TiXP7pFsvbg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: dayou5941@163.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/ops-common: factor out damon_putback_folio_list()
Date: Fri, 24 Jul 2026 07:56:19 -0700
Message-ID: <20260724145620.94967-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724143917.94375-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Jul 2026 07:39:24 -0700 SJ Park <sj@kernel.org> wrote:

> 'get_maintainer.pl --nogit --nogit-fallback' suggests adding below recipients.
> I added them.  Please consier using get_maintainer.pl from the next time.
> 
> - linux-mm@kvack.org
> - linux-kernel@vger.kernel.org
> 
> On Fri, 24 Jul 2026 14:01:35 +0800 dayou5941@163.com wrote:
> 
> > From: liyouhong <liyouhong@kylinos.cn>
> > 
> > The putback loop is duplicated in damon_migrate_folio_list() and on the
> > invalid-nid path of damon_migrate_pages().  Factor it into a small helper
> > for readability.  No functional change.
> 
> This is not a hotfix.  I'd suggest sending this separately, not together with
> the first patch of this series.  Sending hotfix together with non-hotfix when
> they don't really need to be applied together only makes it complicated.
> 
> > 
> > Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> > ---
> >  mm/damon/ops-common.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index f5ded45fabd1..9a1e8aec5444 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -331,12 +331,22 @@ static unsigned int __damon_migrate_folio_list(
> >  	return nr_succeeded;
> >  }
> >  
> > +static void damon_putback_folio_list(struct list_head *folio_list)
> > +{
> > +	struct folio *folio;
> > +
> > +	while (!list_empty(folio_list)) {
> > +		folio = lru_to_folio(folio_list);
> > +		list_del(&folio->lru);
> > +		folio_putback_lru(folio);
> > +	}
> > +}
> > +
> >  static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
> >  						struct pglist_data *pgdat,
> >  						int target_nid)
> >  {
> >  	unsigned int nr_migrated = 0;
> > -	struct folio *folio;

I forgot mentioning this breaks build, as Sashiko also pointed [1] out.  This
patch cannot be applied as-is.

[1] https://lore.kernel.org/20260724060707.CE1F81F000E9@smtp.kernel.org


Thanks,
SJ

> >  	LIST_HEAD(ret_folios);
> >  	LIST_HEAD(migrate_folios);
> >  
> > @@ -374,11 +384,7 @@ static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
> >  
> >  	list_splice(&ret_folios, folio_list);
> >  
> > -	while (!list_empty(folio_list)) {
> > -		folio = lru_to_folio(folio_list);
> > -		list_del(&folio->lru);
> > -		folio_putback_lru(folio);
> > -	}
> > +	damon_putback_folio_list(folio_list);
> >  
> >  	return nr_migrated;
> >  }
> > @@ -395,12 +401,7 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
> >  
> >  	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
> >  			!node_state(target_nid, N_MEMORY)) {
> > -		while (!list_empty(folio_list)) {
> > -			struct folio *folio = lru_to_folio(folio_list);
> > -
> > -			list_del(&folio->lru);
> > -			folio_putback_lru(folio);
> > -		}
> > +		damon_putback_folio_list(folio_list);
> >  		return nr_migrated;
> >  	}
> 
> Looks better.  But, how about further simplifying it by moving the folios
> putback from damon_migrate_pages(), and doing that from damon_migrate_pages()?
> damon_migrate_pages() would do the putback always before returning, and the
> taregt_nid path will 'goto' the path.  E.g.,
> 
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -391,15 +391,8 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
>                 return nr_migrated;
> 
>         if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
> -                       !node_state(target_nid, N_MEMORY)) {
> -               while (!list_empty(folio_list)) {
> -                       struct folio *folio = lru_to_folio(folio_list);
> -
> -                       list_del(&folio->lru);
> -                       folio_putback_lru(folio);
> -               }
> -               return nr_migrated;
> -       }
> +                       !node_state(target_nid, N_MEMORY))
> +               goto out;
> 
>         noreclaim_flag = memalloc_noreclaim_save();
> 
> @@ -424,6 +417,14 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
> 
>         memalloc_noreclaim_restore(noreclaim_flag);
> 
> +out:
> +
> +       while (!list_empty(folio_list)) {
> +               struct folio *folio = lru_to_folio(folio_list);
> +
> +               list_del(&folio->lru);
> +               folio_putback_lru(folio);
> +       }
>         return nr_migrated;
>  }
> 
> This could be applied to the first patch.  And this patch can simply remove the
> redundanty putback.
> 
> >  
> > -- 
> > 2.25.1
> 
> [1] https://lore.kernel.org/20260724060707.CE1F81F000E9@smtp.kernel.org
> 
> 
> Thanks,
> SJ
> 
