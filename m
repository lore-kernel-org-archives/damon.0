Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C35188A0E
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403939; cv=none; b=YZLqUh9utGqn7/pl1jmqHZRtVKHatQAduYlc9a1GHpBj7esGN08a2iUxaM/JqOP/MUq1mJoyQvZdc7UYhGIVpmeGYtsxy+XahIXUrg4oe60mo0JDNbr8woOgHBHVO69Y2Jq78gPxia0KPjHky4njj5hmIGvNxFrT6eGqySPov70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403939; c=relaxed/simple;
	bh=78cwvxWzowYMPOAQ/P3Gv/HhiJtvYHGT6olSBLC4/yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=at8nriSX5mmy6168gBm/fsYUPuYkTVM0qgtCD20kxcEvWBVYXHnmbSKIHlY4kbh2dvOZVs0mOHreDdFUMgqxX+PpDeP1EA+KeqOVTefFuZgX8eCd3u97rxD9P+XD62Z9DNv4ojwLu7p0kOhSvuUz/6B2jw5+Oq1LzchgxHOt8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA6U5ZF6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA6U5ZF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB231C4CEE0;
	Mon, 20 Jan 2025 20:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737403938;
	bh=78cwvxWzowYMPOAQ/P3Gv/HhiJtvYHGT6olSBLC4/yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aA6U5ZF6Fs322VyQSWlIkjTmk72N3NyHzMewlm7Fb9RdB8L5bmPyTuwBVS6IpKEcn
	 hl8L/NO0H2lu4U2Qzb3ENMs0R2KUcXnVtMS6mRj+m8GIQh70xN9KHAH5u2MiE2mqep
	 tHZBFMuuZaNVQV8O//rLo7xijqnQ5V2g8kxN/0D0HXLbRYnaXTosdXZHjWgBFY86DJ
	 3cPo9o3NP9FqtKG9X5dQvmdM9bI6/cGCTFomGbcZaBnqoMovULN8mwWHSTYREjETi5
	 VPiGV5wa2Kp8C0/PyFwXq9bqy2Vmu5iEDVQO2zTDGVgflnhgBrsdKyN30gRhM0C58a
	 vYC+6G8IsG7yg==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Mon, 20 Jan 2025 12:12:14 -0800
Message-Id: <20250120201214.39533-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <3b461f19-45b7-4e74-969d-1cdf4d324353@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jan 2025 19:58:24 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> On 20/01/2025 19:30, SeongJae Park wrote:
> > On Mon, 20 Jan 2025 20:23:20 +0100 David Hildenbrand <david@redhat.com> wrote:
> > 
> >> On 20.01.25 20:16, SeongJae Park wrote:
> >>> On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>>> On 20.01.25 19:19, Usama Arif wrote:
> > [...]
> >>>>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> >>>>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> >>>>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
> >>>>
> >>>>
> >>>> Can we directly embed in the name and the comments/docs that we are only
> >>>> talking about PMD size (both, THP and hugetlb)?
> >>>>
> >>>> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
> >>>
> >>> Nice suggestion, thank you!  And we might later add more filter types for
> >>> different size huge pages.  What about extending this to handle more general
> >>> case, though?  That is, we can let the filter receives a range of the folio
> >>> size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
> >>> used for any size of interest.
> >>
> >> That would probably be future proof: either a range or explicitly 
> >> specified sizes (ranges?).
> > 
> > DAMON supports installing multiple DAMOS filters.  So multiple DAMOS filters
> > that each matching single range can be used for the multiple sizes or ranges
> > use case.
> > 
> > 
> 
> Does creating something like schemes/<N>/access_pattern/page_size/{min,max}
> sound good? with the default value being pmd size?

For user-space ABI, like DAMOS_FILTER_TYPE_ADDR, let's use
'schemes/<N>/filters/<F>/' directory.  File names 'min' and 'max' look good to
me.

For kernel-space API, again, like DAMOS_FILTER_TYPE_ADDR, let's use the union
in 'struct damos_filter'.

If you will do the extension together with this patch, I think the default
value is not really needed.  It will only add a bit of complexity.  So if you
will do so, I'd recommend not having the default value.

Also, if you will revise this patch series for the extension, could you please
split and post the first patch of this series as a separate one?  I think the
fix is important and has no reason to be tied with this patch.


Thanks,
SJ
