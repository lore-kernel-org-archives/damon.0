Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5276026
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737401420; cv=none; b=VYnx3/lAP2lDyhx7YKFnjxJe2II+u5X0fqfmEzDEmsGVJYWubAsrttTvzoowf+FnJjllPSXzcZzvzCLufy5+i5OAJFw6t5sX68CC27Y9RG2cM0/56WXmCP4COdlK1gK5PgmhRCNIJtmaFse2GF47kFjmb18GSOvHVvJd7/D63dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737401420; c=relaxed/simple;
	bh=MsHAwJxqXzNPCCQgAFjJH/pOsANQIx5hNNxm2MOvnbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zfkg5x5IER6K+TKBPrKYCRE6ub9bQolwZWzpl779wY/4gFu/REy4hdkQwk8Aeupd4ru7RUVk6786y9saj0c6Dm82BnafthqLdV5UOj0ydcTt4pkVt23f9LH29zf8rfmvU8a+41iS0mUaXJsg/H2uHhVy/rowHBOhuPm3bfdsn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJbRBFBw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJbRBFBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64949C4CEDD;
	Mon, 20 Jan 2025 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737401419;
	bh=MsHAwJxqXzNPCCQgAFjJH/pOsANQIx5hNNxm2MOvnbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJbRBFBwE/FBMw9XG7rlBihbjApSgmh66Sx9/IImCXxkS6hW0+Jwt23VJT8v3d1ud
	 UB0jbZ+mznc2W6TADEILruO1Ne0CkO1jmVvzhfyHOHUAqMt2rc8cj6AqitQ9n6lGdw
	 DGX842FjIM0pxNk3g79Ta4NgyfWep2EZIQIovWpcFD7iTrNlXvc3n2qZ2DnwKOTEyb
	 41X4f/JdhuWFcDwgWVFVJaE9OYPkMPiIFivISylWyfcA9E2rL4MxMVxIubP4KvqFyh
	 gmi7p0LeoRDxBv8+xWRtzBpYGYkJ3X4qv8ZrS+g7StqCNzRL2j/Z3tbyqLXXc95Skx
	 4Naiipd0Ft7Ig==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Mon, 20 Jan 2025 11:30:15 -0800
Message-Id: <20250120193015.38753-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ac40d2ef-a4e8-4b0a-a213-90296eb92dd9@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jan 2025 20:23:20 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 20.01.25 20:16, SeongJae Park wrote:
> > On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:
> > 
> >> On 20.01.25 19:19, Usama Arif wrote:
[...]
> >>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> >>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> >>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
> >>
> >>
> >> Can we directly embed in the name and the comments/docs that we are only
> >> talking about PMD size (both, THP and hugetlb)?
> >>
> >> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
> > 
> > Nice suggestion, thank you!  And we might later add more filter types for
> > different size huge pages.  What about extending this to handle more general
> > case, though?  That is, we can let the filter receives a range of the folio
> > size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
> > used for any size of interest.
> 
> That would probably be future proof: either a range or explicitly 
> specified sizes (ranges?).

DAMON supports installing multiple DAMOS filters.  So multiple DAMOS filters
that each matching single range can be used for the multiple sizes or ranges
use case.


Thanks,
SJ

> 
> -- 
> Cheers,
> 
> David / dhildenb
