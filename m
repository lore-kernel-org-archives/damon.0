Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B51DFF7;
	Fri,  3 Apr 2026 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775175419; cv=none; b=ho+6GzegGGaIgqLhVImsbZBhTDYzGBfXGOkAdyj6eN7oJEIMpw3lIIlsO3gaonaQSMANXLYwZlgfPywFTNMq9VOhgMhWSbTEIQGn9aWdYPi4TA18ipodxvd/AP5crjGqm9K8Tn7e9smIwEKHua76ttvsqp/F5FKKQMTnEZEV9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775175419; c=relaxed/simple;
	bh=G6deAPR3LX44+jdQ75wNRcyM0FcG1HTaX0DBHFp77B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgCsICfUfAF1eW1G1NOZAVnSwzm7qHv5tUSnIOJ4HTCdP91HiOP3WALnb2zGpx0jH57Xop80xCJO/BZ580PiX3OKzBZOoCvxA1Q9TuJvfv85haKsh+EgKmF9hiSi365kU4g4A1SXUvWU4mu5YQp+z/NXU41Ku0N4LgTY3wpVfx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELVrL166; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELVrL166"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767C8C19423;
	Fri,  3 Apr 2026 00:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775175419;
	bh=G6deAPR3LX44+jdQ75wNRcyM0FcG1HTaX0DBHFp77B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ELVrL166n9hqhE3T/Pu9JB47LFzgNwWbtM+heqapekFShmlxAhZDkFKYf0uQEd0GD
	 GY/OaKlRXMY/ncvggFCAio7fkpQrriF2IPx+sXyFLPDFXxRSp/6FzEKAKubJ9RxGN8
	 a5KVmtcc67tgBN6mx+gJ1I6nAhANxl96GkpU7ImxSX+kHb+PuQBi9hytRWRysT72Wn
	 qCxCHOTl6NQKxm/4dSVL2OefVZgcdAymeEef9/iCZow+QjT11DlLg807UBtDoEmgBQ
	 QNtdkilNaCBs3c+Rl6mzwedevJ5cAuWRam2n9IxW9kwo/SyvnPnj7jmAaj00vaOQXI
	 rQqUe6tAQTsnw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH 1/3] mm/damon/ops-common: optimize damon_hot_score() using ilog2()
Date: Thu,  2 Apr 2026 17:16:57 -0700
Message-ID: <20260403001658.46229-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402155733.77050-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko didn't find a blocker for this patch.

Forwarding Sashiko review in a review format with my inline comment, for
sharing more details of my view and doing more discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260402155733.77050-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 3d1d9600685998aeba66926091d5a11897567bd0
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/ops-common: optimize damon_hot_score() using ilog2()
> 
> This commit replaces a manual for-loop with an ilog2() based calculation
> to optimize the derivation of age_in_log in damon_hot_score(), improving
> latency during performance tests.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> [ ... ]
> > @@ -117,9 +117,12 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >  		damon_max_nr_accesses(&c->attrs);
> >  
> >  	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
> > -	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
> > -			age_in_log++, age_in_sec >>= 1)
> > -		;
> > +	if (age_in_sec)
> > +		age_in_log = min_t(int, ilog2(age_in_sec) + 1,
> > +				DAMON_MAX_AGE_IN_LOG);
> > +	else
> > +		age_in_log = 0;
> 
> This isn't a bug, but could this logic be simplified and the branch avoided
> by using fls() instead of ilog2()?
> 
> For non-constant variable arguments, ilog2(x) internally resolves to
> fls(x) - 1. By evaluating ilog2(age_in_sec) + 1, this code essentially
> calculates fls(age_in_sec) - 1 + 1.
> 
> Since fls() natively returns 0 when the input is 0, using fls(age_in_sec)
> directly would remove the need for the conditional branch entirely and
> reduce the block to a single expression.

We decided to use ilog2() since it makes the code easier to read in my taste.
So, this is not a blocker for this patch.

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260402155733.77050-2-sj@kernel.org


Thanks,
SJ

[...]
