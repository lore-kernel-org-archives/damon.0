Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097691C5D6C
	for <damon@lists.linux.dev>; Mon, 13 Jan 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795049; cv=none; b=EbBLjW8R2yt2Lybk72nrjvDZL6wqfL4nZa2WcAZyMF42iILbHKCZQUHZomSeNpYGschDFIl97T3CgozTe07lCxJ/p+wNsO42jQ1LvJxtotS7dGnOPnNEfs7NKZl4/nWm3cVpgh5xBwQdY42FlsaPbhInHx0EJlxTUvODDSojcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795049; c=relaxed/simple;
	bh=PXaYPVze67MNjcAL8KOaIthXn9N3NZETV3oeJga+h7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEZzif7+ROzPWgxRTWmx2vRsW26ej6elFXlNluUNHgfFsVjmmZVPZ5nknCLNSo+a5dllzSnL29VmAfk/WBw/+S+UD+PTez8gAHVL0kQTbQKYmhuy98xvPrpNXZgI0wADWIJcLJeBRqvNZ2F/gBUqS1CIVLKb/P6277NLQd65J/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWX7QdTL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWX7QdTL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B29C4CED6;
	Mon, 13 Jan 2025 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736795048;
	bh=PXaYPVze67MNjcAL8KOaIthXn9N3NZETV3oeJga+h7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWX7QdTLaC+S0H6Ng1DygEk8hmS2i8460t5UpswUYziik0EIIk6T5kajeGEuyzO9t
	 shWZaaOLp9nAnZJme0ICAO2v676BOCmF0QnQIUlYb6EGcptDiaP7ApTSOUnWD48i3O
	 sHs6dlXY/QpprjBusNRdCNr/1o6+yXA8cTXNYsflBjocttIjqsHs02tgNCoJX6Hi43
	 W/mm+3t9StyjRphQjTwS2AmnhEtb0G+0HrlavOvwZsOw38hO37nDYt2xnySmm/q/1B
	 tumLgtcMotZUyNsSLuSwUYJ+bR9YaHNfSuGnet8einkUt6HMyO5Iwld9Kz8D0GiBLh
	 NFfp+j2iMnB4w==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: increment pa_stat damon address range by folio size
Date: Mon, 13 Jan 2025 11:04:05 -0800
Message-Id: <20250113190405.6723-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <8892b42c-3363-4fdf-ad3c-4bbd2a0a801b@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Jan 2025 18:53:32 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> On 13/01/2025 18:43, SeongJae Park wrote:
> > Hi Usama,
> > 
> > 
> > Let's use "mm/damon/paddr: " prefix for the patch title, to be more consistent
> > with others.
> > 
> > On Mon, 13 Jan 2025 18:03:40 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> > 
> >> This is to take into account for folios with size > 1 page.
> >> Iterating at PAGE_SIZE increment would increment sz_filter_passed
> >> multiple times for the same folio by folio_size, providing incorrect
> >> stats.
> > 
> > damon_get_folio() returns NULL if the page is a tail page.  Hence I think it
> > will not increment sz_filter_passed multiple times?
> 
> ahh I didn't look at the definition of damon_get_folio! just assumed it will get
> the folio irrespective of if its a tail page or not. Will change the commit message.
> 
> Just curious if returning NULL is what is expected by the user?
> I see damon_get_folio used in a bunch a places. If the user limits damos action/
> damon monitoring to a specific address range, and that covers some of the tail pages,
> but not the head page, I guess the damos action wont be applied.

Yes, I think damon_get_folio() users (mostly DAMON operations set layer) should
aware that and use different functions if it can be a problem, depending on
each case.  I find no problematic use cases of the function off the top of my
head, but if you find, please help us fixing those :)

[...]
> >> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> >> index 6b4397de4199..cc789a97c6f5 100644
> >> --- a/mm/damon/paddr.c
> >> +++ b/mm/damon/paddr.c
> >> @@ -504,7 +504,8 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
> >>  	if (!damon_pa_scheme_has_filter(s))
> >>  		return 0;
> >>  
> >> -	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
> >> +	addr = r->ar.start;
> >> +	while (addr < r->ar.end) {
> >>  		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
> >>  
> >>  		if (!folio)
> > 
> > In this case, the code does "continue".  'addr' is not advanced, so it will
> > result in an infinite loop.  Let's do 'addr += PAGE_SIZE' here, to avoid that.
> 
> Thanks! Will fix this in v2.

Nice, looking forward to it!


Thanks,
SJ

[...]
