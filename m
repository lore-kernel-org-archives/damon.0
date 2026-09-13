Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9213438A0
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789321310; cv=none; b=oODrcS/JbmaQtUWvaks8tVnEu3abRPpXGHcJl7FfaUUIzxaqwgLu0Nifsu2/pEpPDHSzq248ylC5ZLlBG3UcCDLna3TcSmy5Md6PBeV68Xqd8v8+dzbZZ8lLjPXpIxYZSGMtInJJ3WJO5KNmXRUCPqvJ1HMBRKyOvSXLSoF3/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789321310; c=relaxed/simple;
	bh=R6yhLAYXibZrubgAooU34EbmcONZzNcfiochE1XZivg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZkJENENmpqeKG5ax1EBAw/Z+ETYmeTQtv737Uo85jwLulZ3rbtDPvmIeh9z3BYI3h4xDrz5lFk+T2FWzlJd+aOn+M2WFV6JCgyNFxHdQ/F8Bg861HUNP9xuqP1dTv1gKiVPiJJfLQMDgQrJvChgzJvQMGnx0O5uI1KxiHQuZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYiMCUeO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYiMCUeO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8161F000FF;
	Sun, 13 Sep 2026 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789321309;
	bh=1ygj0kkeNQVIvlfTtE6I4xdKd9EyQFDx/NQIe4A910Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oYiMCUeOXQWQ+6+5tqtdh9y3ym5pyK3ODc3592Pg9Zy3YETfTDjafbn5/qkdzz2uq
	 LRVQuA9jJtdsN6ZDKFQ85e3mN8hIqsUEf7vFqPX3Qii2rCZNvAvr2alP9n+h1ikVAq
	 L0aebVAt0UKKqo8k7dM5YVRaEHbpDCdcqI/SBAwu7KbJOOg8EWV1t0stFgVUUDK71W
	 n44qhx67+68czpP4gyNYWcCNMXFNKr6gy8MNtW0s/8pmgjEHQPDHBGzElz+Edd7AvX
	 cKYWVMpYOJ2Rmm9NI6qDyQoAjA64GZFdXwmBZqop+nAQT3SePeYgr13PWGJPnTD/jO
	 NetD3/vsFNKqw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/8] mm/damon/ops-common: support hugepage_size damon filter matching
Date: Sun, 13 Sep 2026 10:41:41 -0700
Message-ID: <20260913174142.105047-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913173502.104385-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 10:35:09 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 13 Sep 2026 17:24:42 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] damon_commit_filters() leaves range_min and range_max uninitialized for appended hugepage_size filters.
> > --
> > 
> > commit 377608c283881250a794879309e80b931825b0d3
> > Author: SJ Park <sj@kernel.org>
> > 
> > mm/damon/ops-common: support hugepage_size damon filter matching
> > 
> > Update ops-common data attribute filter matching logic to support
> > hugepage_size filter type.
> > 
> > > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > > index c36cc39cd2c70..77366f42b3e5b 100644
> > > --- a/mm/damon/ops-common.c
> > > +++ b/mm/damon/ops-common.c
> > 
> > [ ... ]
> > 
> > > @@ -558,6 +559,15 @@ bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio)
> > >  			matched = filter->memcg_id == mem_cgroup_id(memcg);
> > >  		rcu_read_unlock();
> > >  		break;
> > > +	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> > > +		if (!folio) {
> > > +			matched = false;
> > > +			break;
> > > +		}
> > > +		folio_sz = folio_size(folio);
> > > +		matched = filter->range_min <= folio_sz &&
> > > +			folio_sz <= filter->range_max;
> > > +		break;
> > 
> > [Severity: High]
> > Does this new filter type need to be explicitly copied when a newly appended
> > filter is committed?
> > 
> > When userspace adds a new filter to an existing DAMON probe via sysfs,
> > damon_commit_filters() in mm/damon/core.c invokes damon_new_filter() which
> > allocates memory without zeroing it. The attributes are then copied in a
> > switch block:
> > 
> > mm/damon/core.c:damon_commit_filters() {
> > 	...
> > 	new_filter = damon_new_filter(src_filter->type,
> > 			src_filter->matching, src_filter->allow);
> > 	if (!new_filter)
> > 		return -ENOMEM;
> > 	switch (src_filter->type) {
> > 	case DAMON_FILTER_TYPE_MEMCG:
> > 		new_filter->memcg_id = src_filter->memcg_id;
> > 		break;
> > 	default:
> > 		break;
> > 	}
> > 	damon_add_filter(dst, new_filter);
> > 	...
> > }
> > 
> > Because DAMON_FILTER_TYPE_HUGEPAGE_SIZE is missing from this switch block,
> > range_min and range_max will be left uninitialized for appended filters. This
> > could result in the filtering logic using garbage memory values.
> > 
> > Should DAMON_FILTER_TYPE_HUGEPAGE_SIZE be added to this switch statement
> > so the range boundaries are properly copied to the new filter?
> 
> No issue.  DAMON sysfs is not allowing hugepage_size probe filter at this
> moment.  Later, it will add the support with proper range setup.

I was wrong.  I will fix this in the next spin.

> 
> > 
> > >  	default:
> > >  		break;
> > >  	}
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260913171133.102366-1-sj@kernel.org?part=3
> 
> 
> Thanks,
> SJ
> 


Thanks,
SJ
