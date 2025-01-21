Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3C01AF0CA
	for <damon@lists.linux.dev>; Tue, 21 Jan 2025 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489915; cv=none; b=PzgIufE4fo9J5/ESCU5vhqW3va1WDv5N0ATWXNbfUg3SEArG3sUdWEYYcCOvPCDdB33pNH5xPF8NSzdgIbmxyD0hzNrFrf/wig/AiGHAx/ukYTRzyDpOlbgPE1thlpJO46aO6hEbe0LCw8YLwPyLYrva5dcrFdcuJ0ykNI8WxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489915; c=relaxed/simple;
	bh=4OwJPXofw0b0X9F6vhLLxhsdWEct6cZHoBaImZIMFtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QCGHBfKZUxMOeHmJhrY3bbKV/jpjteHoMrZwET4Dzf6Hi2a7+1kuhL6gAiZ6X/384xIaMAUCb+r1I8IrWecWXrXT/YXiIcXMfQRpg6IZfeDik/W8bbKZYBlZGuMG++AFbrxQRsNe2CVACsLyQoggz9srMyg95PSUj98x5mxVl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SccMQ2IK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SccMQ2IK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13F5C4CEDF;
	Tue, 21 Jan 2025 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737489913;
	bh=4OwJPXofw0b0X9F6vhLLxhsdWEct6cZHoBaImZIMFtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SccMQ2IKJdTXa/ezGZbhR2XYstUuMFqp3aQkb1KOxtP+EgWtEbqQtnMuNc2ix1sfO
	 wCZkM9OPMY3pRoe6hnoETF0vb7TWEnBOgMpm8spyfsyXzCy1eiz/dmRID9r3xxQ6yZ
	 8gVKkU5nleudWNgo6xoCCOWPcpVeaCAKO+YfbLKIJTw5D28O2AGLNpL+gAUh9wM+NP
	 3ZSFovG/SL2DCQw9kDbR+P6muGSY/wYT7ESKPnl6MtMoXHRUx5f8i9EGjrbFk1oPN0
	 Rqf+iQAcYH16QDFgnUsOFki5XEQ2HCPnOGYy25qHo4C5cFEMrer3+tJ8UWRg/FKR5Q
	 VS/0+L/8B9IEw==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Tue, 21 Jan 2025 12:05:10 -0800
Message-Id: <20250121200510.43645-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <c2fad5c2-8929-456d-a6f9-286478b93372@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Jan 2025 19:39:01 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 21.01.25 18:52, SeongJae Park wrote:
> > On Mon, 20 Jan 2025 21:03:05 +0100 David Hildenbrand <david@redhat.com> wrote:
> > 
> >> On 20.01.25 20:58, Usama Arif wrote:
> >>>
> >>>
> >>> On 20/01/2025 19:30, SeongJae Park wrote:
> >>>> On Mon, 20 Jan 2025 20:23:20 +0100 David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>>>> On 20.01.25 20:16, SeongJae Park wrote:
> >>>>>> On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:
> >>>>>>
> >>>>>>> On 20.01.25 19:19, Usama Arif wrote:
> >>>> [...]
> >>>>>>>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> >>>>>>>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> >>>>>>>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
> >>>>>>>
> >>>>>>>
> >>>>>>> Can we directly embed in the name and the comments/docs that we are only
> >>>>>>> talking about PMD size (both, THP and hugetlb)?
> >>>>>>>
> >>>>>>> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
> >>>>>>
> >>>>>> Nice suggestion, thank you!  And we might later add more filter types for
> >>>>>> different size huge pages.  What about extending this to handle more general
> >>>>>> case, though?  That is, we can let the filter receives a range of the folio
> >>>>>> size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
> >>>>>> used for any size of interest.
> >>>>>
> >>>>> That would probably be future proof: either a range or explicitly
> >>>>> specified sizes (ranges?).
> >>>>
> >>>> DAMON supports installing multiple DAMOS filters.  So multiple DAMOS filters
> >>>> that each matching single range can be used for the multiple sizes or ranges
> >>>> use case.
> >>>>
> >>>>
> >>>
> >>> Does creating something like schemes/<N>/access_pattern/page_size/{min,max}
> >>> sound good? with the default value being pmd size?
> >>
> >> "page_size" might be misleading.
> > 
> > Good point.  I'm suggesting to add the files on another directory, and
> > apparently Usama agrees[1].  So the term "page_size" will not be used.
> > 
> >> Not sure if we want to use the word
> >> "folio_size" here, so far it's more an internal detail that evolved from
> >> compound pages.
> >>
> >> "hugepage_size" would at least match /sys/kernel/mm/hugepages/ and
> >> /sys/kernel/mm/transparent_hugepage/.
> >>
> >> But if you would also support "single page" == e.g., 4K, "hugepage"
> >> would be wrong.
> > 
> > Again, nice points, thank you for letting us aware of this.  We could error
> > users if they try to set <=PAGE_SIZE filter range.  FYI, DAMOS filters supports
> > making the filtering in/out action for not only condition-matching memory, but
> > also not-matching memory, so it will still be able to be used for filtering
> > in/out base pages.
> > 
> > That said, I now think "folio_size" might be a better term that allows simple
> > implementation and flexible usages.
> 
> The issue with "folio" is that it is mostly a kernel-internal name for 
> how we currently manage metadata for all pages and compound pages. In 
> the future, some of what we call folio today will no longer be called 
> folios ... as soon as we dynamically allocate "struct folio".

Agreed.  I'd suggest using "hugepage_size" or "hugepage" filter type name,
then.  I have no strong preferrence between the two names.  Also, to have a
flexible usage and a simple logic, let's not error users for wrong input, but
just define the filter type as "match" if the folio is "huge AND the size is in
the given range".  Then we can allow users set <=PAGE_SIZE range but make it
just works as sanely expected, like below.

    static bool damos_pa_filter_match(struct damos_filter *filter,
    [...]
            case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
                    size_t sz = folio_size(folio);
    
                    if (sz <= PAGE_SIZE)
                            matched = false;
                    else
                            matched = filter->min <= sz && sz <= filter->max;
                    break;

Thanks,
SJ

[...]
