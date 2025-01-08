Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328220B20;
	Wed,  8 Jan 2025 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736309097; cv=none; b=UhohW5oUdcROyEVpBD3TN166iXzszT2NugJuXO1voay4KKeG+UiV/gyoA2iixzVpjzNsQu6Y69fNNZHnEJIYlvfqSkNvVhcdMT2FCOYJasj2q3XlOZ2GCXHdBu/fn5UteO9oLg2ICjv0ovtE4QW58iO5PwS4rHvaGFBoO9YA+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736309097; c=relaxed/simple;
	bh=g8XiEqSr/aXbZ1sJ4dxqWee2PjNC8HDo6PiAWIA2Dlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNOu/rkl/uFcMccrYBmwx554w8SFFdVoCBfaN3BZn9AxJy1bAwWVrpMOVunWNOeKmAKW6KOL0cmnwq/GMGjQTGPjIe4cQWFS6kqd05Md9mJfbDLv4zkUl+eWSOze3t457wMyljNprsMlCvC3aRMBLvtAIV+nX6gSRJXWGC7QiRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3B1EOQF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3B1EOQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABED3C4CED0;
	Wed,  8 Jan 2025 04:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736309096;
	bh=g8XiEqSr/aXbZ1sJ4dxqWee2PjNC8HDo6PiAWIA2Dlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3B1EOQFdiP53gYyVUlSkZK+aFra8bE00Nby8Nj7K5RnURGW1YMMzEQ9NjMkDsf4T
	 9+q2Z6oZoCxKgVI32I5pHeTpd9YZ9v3is1bvYPIV0I3/UOSGgmALZ0+RYGGRqjp2qr
	 ROnCF0N0M4kKFABQx5GocHmdg9VX3xi5CuXmLhC2fMpZCZ0t9OXO4pq2zCn/raf7dI
	 ngzSYyuiKJ6RhTKZKCuWoFe3OZ1DcY0QyQLHCWdkLh9nC+Zv1DpFDzWNaMphLVf2Mv
	 z1Cru56s7R4VBmWoXzASlBnBmeu6kBW2HGqeydHYJJ7j9G6jpkP0tk+zkc40lVf2Pv
	 yonEsOBQ9W0Iw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 07/10] Docs/mm/damon/design: document pass/block filters behaviors
Date: Tue,  7 Jan 2025 20:04:54 -0800
Message-Id: <20250108040454.1283-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107201739.79484-8-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 7 Jan 2025 12:17:36 -0800 SeongJae Park <sj@kernel.org> wrote:

> Update DAMOS filters design document to describe the pass/block
> behavior of filters.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/mm/damon/design.rst | 34 +++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index 449eb33688c2..3682e719b8a6 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -504,9 +504,35 @@ have a list of latency-critical processes.
>  
>  To let users optimize DAMOS schemes with such special knowledge, DAMOS provides
>  a feature called DAMOS filters.  The feature allows users to set an arbitrary
> -number of filters for each scheme.  Each filter specifies the type of target
> -memory, and whether it should exclude the memory of the type (filter-out), or
> -all except the memory of the type (filter-in).
> +number of filters for each scheme.  Each filter specifies
> +
> +- a type of memory (``type``),
> +- whether it is for the memory of the type or all except the type
> +  (``matching``), and
> +- whether it is to allow (pass through the filter) or reject (block) applying
> +  the scheme's action to the memory (``pass``).
> +
> +When multiple filters are installed, each filter is evaluated in the installed
> +order.  If a part of memory is matched to one of the filter, next filters are
> +ignored.  If a part of memory is not matched to any of the filters, the default
> +behavior is applied.  That is, as long as it fulfills other conditions of the
> +scheme including the access pattern and quotas, the action will be applied to
> +the part of the memory.
> +
> +For example, let's assume 1) a filter for passing anonymous pages and 2)
> +another filter for blocking young pages are installed in the order.  If a page
> +of a region that eligible to apply the scheme's action is an anonymous page,
> +the scheme's action will be applied to the page regardless of whether it is
> +young or not, since it matches with the first filter.  If the page is not
> +anonymous but young, the scheme's action will not be applied, since the second
> +filter blocks it.  If the page is neither anonymous nor young, no filter is
> +involved, so the action will be applied to the page.
> +
> +The fact that the action can be applied to any memory as long as no block
> +filter explicitly excluded it means that installing pass filters without any
> +block filter after those is same to not installing the pass filters, in terms
> +of the ``action`` applying.  Statistics for DAMOS filters will still be
> +accounted, though.

The above last sentence is right in a sense, but not useful and could only
confuse readers.  The statistics for DAMOS filters are filters passed size
stat, which is provided as per-scheme accumulated stat and per-region instant
information.  The stat is for any memory that be able to apply the DAMOS action
after the filters check stage.  Hence, whether it has passed the stage due to
existence of a pass filter that matches the memory, or the absence of any
matching filter is distinguishable.

> It is therefore still useful for monitoring purpose.

Hence, the above sentence is completely wrong.  The case (installing pass
filtrs without any block filter after those) is not useful even for monitoring
purpose.

The RFC version of this patch was mentioning it correctly, but was not clearly
describing why it is not also useless for even monitoring purpose.  I was also
confused due to the absence of the context.  I will rewrite this part and send
the whole series again as v2.


Thanks,
SJ

[...]
