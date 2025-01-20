Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378B8479
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737400619; cv=none; b=k4i0VBJRg2i/KhHNBNwcviXh3hlMFMogPh6d/nsP6K0bBz1z6DhmKRYxRWbutiGu49fLWb6XWG9g0kpPi/CG0vzY7qwN45WaEYE6tWg66PJ0T7K5gJFHw3GF1eWURxjX5pZZ1Ehg4fRcNA3txnt4Cyrao5t5nTtF6nDDcduru38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737400619; c=relaxed/simple;
	bh=qk4QSnven6ILIEFsUk/00OcnycBav7of9Es7dyhYB3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+gzKWGc2libzJMYlMrrhbv/9dkPRO1ok8Eo6KfBI0Hh3I6vsRDCd+AbOPv/dBEBMNzELnPsO0N8IjPgRtGj4cBfxGPIUbIaAhuKmWth+1fiLQkp1yS6qCyrzg6kkiGf9rB6EaF9B6vJ4jBByhZ9ubRUvnxZUwhEhVNXEzSUtIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnOaWgSy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnOaWgSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D126C4CEDD;
	Mon, 20 Jan 2025 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737400618;
	bh=qk4QSnven6ILIEFsUk/00OcnycBav7of9Es7dyhYB3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JnOaWgSy0rWj8/f3bFJig2zoUQ064MCp2Lx+hTrTD7tfQef4QCm66ACWiE6bOoTVt
	 lOq2rPp7Fb7lA4ToSVIQSTZCC5xYqt3dYy6o+oetZe5o1NulCUT1QUIBCQ2GMUHcLW
	 vpYnNPDJTpNHvZFAbo7xsvvVGaCkKpVKQihmmgBqt/Gbz9OoQj4gQ4SyY3wgxeC6ta
	 uLmwZ8fOdldBHFqRduwqZhiVt83RMyOg1RhbDe0N099Ljaz56JU34Myen59ewExiDE
	 L+7hPVaqNMf3Qf2DdDNj8lyxJH2v69o9dcnyT6j+h5NjHGOtPpoiO1OW7g2RTGZ3Mv
	 lP2dMwdVqO+Dw==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Mon, 20 Jan 2025 11:16:54 -0800
Message-Id: <20250120191654.38420-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <9257fbb9-d26d-4028-896f-fb8cfad3ddad@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 20.01.25 19:19, Usama Arif wrote:
> > This is to gather statistics to check if memory regions of specific
> > access tempratures are backed by hugepages. This includes both THPs
> > and hugetlbfs.
> > This filter can help to observe and prove the effectivenes of
> > different schemes for shrinking/collapsing hugepages.
> > 
> > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > ---
> > v2 -> v3:
> > - expose hugepage via sysfs even if the kernel is
> >    built without hugepage support. DAMON will just
> >    just return 0. (SJ Park)
> > 
> > v1 -> v2:
> > - Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
> >    CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)
> > ---
> >   include/linux/damon.h    | 2 ++
> >   mm/damon/paddr.c         | 5 +++++
> >   mm/damon/sysfs-schemes.c | 1 +
> >   3 files changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index af525252b853..1d94d7d88b36 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -326,6 +326,7 @@ struct damos_stat {
> >    * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
> >    * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
> >    * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
> > + * @DAMOS_FILTER_TYPE_HUGEPAGE:	Page is part of a hugepage.
> >    * @DAMOS_FILTER_TYPE_ADDR:	Address range.
> >    * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
> >    * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
> > @@ -345,6 +346,7 @@ enum damos_filter_type {
> >   	DAMOS_FILTER_TYPE_ANON,
> >   	DAMOS_FILTER_TYPE_MEMCG,
> >   	DAMOS_FILTER_TYPE_YOUNG,
> > +	DAMOS_FILTER_TYPE_HUGEPAGE,
> >   	DAMOS_FILTER_TYPE_ADDR,
> >   	DAMOS_FILTER_TYPE_TARGET,
> >   	NR_DAMOS_FILTER_TYPES,
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index c0ccf4fade24..224308140441 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -222,6 +222,11 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
> >   		if (matched)
> >   			damon_folio_mkold(folio);
> >   		break;
> > +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> > +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> > +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
> 
> 
> Can we directly embed in the name and the comments/docs that we are only 
> talking about PMD size (both, THP and hugetlb)?
> 
> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.

Nice suggestion, thank you!  And we might later add more filter types for
different size huge pages.  What about extending this to handle more general
case, though?  That is, we can let the filter receives a range of the folio
size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
used for any size of interest.

I think such extension is not a strong blocker for this patch.  We can do the
extension later without breaking users by having the PAGE_PMD_SIZE as the
default value of the address range input.  I have no strong opinion about this,
though.

What do you think?


Thanks,
SJ

[...]
