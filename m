Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070171E9B38
	for <damon@lists.linux.dev>; Tue, 21 Jan 2025 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737481984; cv=none; b=k8AEI7GgOoWBJscHyNMuPRVuz+zkxkmHbY4lMGsJh5GvaiF58nVR8YDXsp2zDGJC/OjbK62WXBcf2iML5GnZGC+kZ2n3L5uFGeb/4GRNoWN0jsX7NQ60ip6KFxSWKvhFEQIjFnnTaggeC/9pAkR+4eqPGF0QQyRBtsmdfmg0J1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737481984; c=relaxed/simple;
	bh=K7gJF81Ay94qXJTumCAoPn/9y5srjOeDDkMTi4gsNoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFDwxaHJ7NkptwITgxWJR0Q/l9jG4HW8cQSYPT1DBkvO9qYsb8ETuoRvcw2Yirt8AFzxigMkl71ORFvxBFZKdY7Ix+z4tzWdAY8ZvP8OtTjeo0AvtwxfaVcFUmTyjNEVEoJHg6NlwLKPMA949AP/MlKLvhRqTZd68qTkRfRmJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SanEfYfC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SanEfYfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55871C4CEDF;
	Tue, 21 Jan 2025 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737481983;
	bh=K7gJF81Ay94qXJTumCAoPn/9y5srjOeDDkMTi4gsNoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SanEfYfCnWRY20nMIfjisKL1nvEcfQw4UdU+yTrK7jSukEEjNPH6xcsWn3AB+BCSX
	 CnvVWEjGWzr74E2p99hpANpBf+VX5wuFZTsG/OMGMm61uRv8DO2yo8R5OIDUq5DY3a
	 VbjRRzRfW8lsk3RH3SWm3A5B2pephUG1RwXrOorevQCK0iVMa+yl8xqPhEi3oA24My
	 O4clI99nkxAA66OywHRtarGGVMgid3rYbEn09XQ1Pen3FRzD6tAsePbvFUcjUpPnns
	 3+E8pqRZz56XviJ1hWErriYDWO3ZgEAKZHUPyySjtNc9XATAdTmcFkOTqQbho4Z7+4
	 N5Gvf1iW0hOPg==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Tue, 21 Jan 2025 09:52:59 -0800
Message-Id: <20250121175259.42535-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <6750d7d8-0b21-4f0b-88a6-c4c8ad98f9a4@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jan 2025 21:03:05 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 20.01.25 20:58, Usama Arif wrote:
> > 
> > 
> > On 20/01/2025 19:30, SeongJae Park wrote:
> >> On Mon, 20 Jan 2025 20:23:20 +0100 David Hildenbrand <david@redhat.com> wrote:
> >>
> >>> On 20.01.25 20:16, SeongJae Park wrote:
> >>>> On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>>>> On 20.01.25 19:19, Usama Arif wrote:
> >> [...]
> >>>>>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> >>>>>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> >>>>>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
> >>>>>
> >>>>>
> >>>>> Can we directly embed in the name and the comments/docs that we are only
> >>>>> talking about PMD size (both, THP and hugetlb)?
> >>>>>
> >>>>> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
> >>>>
> >>>> Nice suggestion, thank you!  And we might later add more filter types for
> >>>> different size huge pages.  What about extending this to handle more general
> >>>> case, though?  That is, we can let the filter receives a range of the folio
> >>>> size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
> >>>> used for any size of interest.
> >>>
> >>> That would probably be future proof: either a range or explicitly
> >>> specified sizes (ranges?).
> >>
> >> DAMON supports installing multiple DAMOS filters.  So multiple DAMOS filters
> >> that each matching single range can be used for the multiple sizes or ranges
> >> use case.
> >>
> >>
> > 
> > Does creating something like schemes/<N>/access_pattern/page_size/{min,max}
> > sound good? with the default value being pmd size?
> 
> "page_size" might be misleading.

Good point.  I'm suggesting to add the files on another directory, and
apparently Usama agrees[1].  So the term "page_size" will not be used.

> Not sure if we want to use the word 
> "folio_size" here, so far it's more an internal detail that evolved from 
> compound pages.
> 
> "hugepage_size" would at least match /sys/kernel/mm/hugepages/ and 
> /sys/kernel/mm/transparent_hugepage/.
> 
> But if you would also support "single page" == e.g., 4K, "hugepage" 
> would be wrong.

Again, nice points, thank you for letting us aware of this.  We could error
users if they try to set <=PAGE_SIZE filter range.  FYI, DAMOS filters supports
making the filtering in/out action for not only condition-matching memory, but
also not-matching memory, so it will still be able to be used for filtering
in/out base pages.

That said, I now think "folio_size" might be a better term that allows simple
implementation and flexible usages.  What do you think about changing the
filter type name from "hugepage" to "folio_size", and let users set the range
whatever they want?  I still think "hugepage" type name is ok, but if there's
no objection about the naming, I'd slightly prefer more up to "folio_size".

[1] https://lore.kernel.org/db16fc35-58e7-453d-9fbb-318a88a98cd1@gmail.com


Thanks,
SJ

[...]
