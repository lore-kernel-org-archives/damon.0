Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1725F1DF989
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737406115; cv=none; b=N+GkXrDSHYHZA2QN3p2kvzXTPMsxjsyX5YOS3cV4+BcqYmQqNzfM6RooTJTL2DxYEHhpDmW8WVgJh0to470tZfcsQqP1TB7iOUJKvRxWAYQvZHW1G5Ln7mZWVK2aJfx5KBMn/yOz7xuGotrI7nT8SMNWAHFhsDpqhBVVado/6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737406115; c=relaxed/simple;
	bh=gdh/Zw5Hi+hthd3e2UYqfLZNX0QeFe/TjoVHAm1V7kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcEmIMxn5EKJPdj2cbEanCVd0MC5pGx+KbvWYlTc5fqHnqvq3KCygHo8FPxwKlfxGr8K/kpAaODuJEpT6xfSKcNtJL29IBmNV5sgV9ikWRt93wVObVq9gAlfpiRUZcHIivyBS5hhTJXWs/DhD8UAj/LwLI1fnOvemde2MIrt3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF5AcHrl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF5AcHrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD77FC4CEDD;
	Mon, 20 Jan 2025 20:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737406114;
	bh=gdh/Zw5Hi+hthd3e2UYqfLZNX0QeFe/TjoVHAm1V7kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YF5AcHrlmzhoxc1dkwJO+OkyW9qH0QBjTlgNQxcVuTkJ+vII/hOufoj0OtZzXKLWT
	 UU5N76Pm6DJEcfwfmCc6VwfgPG1L86mBDV4PTnlIaS/ghNMeKGdMEESJZW5b3qsVn2
	 sxl59t3cZTOp8RDUn4iy8EAVWTX9olpfcRPuTpg5OX/PxmAK/4U0DQkIsF+KgzY6Rs
	 /23HgCD0+WNn443OtCBMP4PuWSI5xIBq2US0yPU/IEFWIW6Xjx0oO/hifq0LURC0V2
	 GziRzNIeDw2mjNiCYbfLV6CO5sQCiMZZ9PDhIGUT5sC0BCOgujXnjfdaBUKSDOLUzy
	 cBtBsioTSxZzQ==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Mon, 20 Jan 2025 12:48:30 -0800
Message-Id: <20250120204830.40088-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <db16fc35-58e7-453d-9fbb-318a88a98cd1@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jan 2025 20:26:02 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> On 20/01/2025 20:12, SeongJae Park wrote:
> > On Mon, 20 Jan 2025 19:58:24 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> > 
> >>
> >>
> >> On 20/01/2025 19:30, SeongJae Park wrote:
> >>> On Mon, 20 Jan 2025 20:23:20 +0100 David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>>> On 20.01.25 20:16, SeongJae Park wrote:
> >>>>> On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:
> >>>>>
> >>>>>> On 20.01.25 19:19, Usama Arif wrote:
> >>> [...]
> >>>>>>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> >>>>>>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> >>>>>>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
> >>>>>>
> >>>>>>
> >>>>>> Can we directly embed in the name and the comments/docs that we are only
> >>>>>> talking about PMD size (both, THP and hugetlb)?
> >>>>>>
> >>>>>> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
> >>>>>
> >>>>> Nice suggestion, thank you!  And we might later add more filter types for
> >>>>> different size huge pages.  What about extending this to handle more general
> >>>>> case, though?  That is, we can let the filter receives a range of the folio
> >>>>> size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
> >>>>> used for any size of interest.
> >>>>
> >>>> That would probably be future proof: either a range or explicitly 
> >>>> specified sizes (ranges?).
> >>>
> >>> DAMON supports installing multiple DAMOS filters.  So multiple DAMOS filters
> >>> that each matching single range can be used for the multiple sizes or ranges
> >>> use case.
> >>>
> >>>
> >>
> >> Does creating something like schemes/<N>/access_pattern/page_size/{min,max}
> >> sound good? with the default value being pmd size?
> > 
> > For user-space ABI, like DAMOS_FILTER_TYPE_ADDR, let's use
> > 'schemes/<N>/filters/<F>/' directory.  File names 'min' and 'max' look good to
> > me.
> > 
> > For kernel-space API, again, like DAMOS_FILTER_TYPE_ADDR, let's use the union
> > in 'struct damos_filter'.
> > 
> > If you will do the extension together with this patch, I think the default
> > value is not really needed.  It will only add a bit of complexity.  So if you
> > will do so, I'd recommend not having the default value.
> > 
> > Also, if you will revise this patch series for the extension, could you please
> > split and post the first patch of this series as a separate one?  I think the
> > fix is important and has no reason to be tied with this patch.
> > 
> 
> Yeah I think it might be best if we get a version with flexible folio sizes merged
> from the start, especially as it involves creating user ABI. I will try and send
> something tomorrow.

Makes sense, looking forward to the next spin!

> 
> For the first patch, do I need to resend? Or maybe Andrew could merge whats in
> this v3 for patch 1, we discard patch 2 and I just send the hugepage
> filter implementation separately as a new series..

I think the first patch is important but not urgent.  I'd suggest to drop it
from the next revision of the filters extension series, and resend it if Andrew
neither pick it nor ask some action by a few days or weeks.


Thanks,
SJ
