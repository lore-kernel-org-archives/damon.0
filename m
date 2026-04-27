Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49941192D8A
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299545; cv=none; b=jhkk4/pZpYGvXHx8N4vXRUF1aedeoJzO/22QxlvRRh64CZvj1oaD0pzfb+O9QB+Yxm+De2l6ISxNeba8t15wYj6g9Jz0+rUjZZTbFWmqZuhebZFBgDJpRU5A3BHbF0j5FesAkuuTu2BXdKu7K58X5Vzb/DUjcbXTrwHC2c8j6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299545; c=relaxed/simple;
	bh=Z8uPFvUofYxjWjPDYMYgoiiaNfjDwiNKad/v6wutxnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSwxH3NlD1Hm//6WRHCYs+gSE+BIgxw9hmzTA+8nwGT3npIWW7T08ihDsxVidToQLcwrKomOwz/b+FAffjxuXqtKmOBXIz5nVdpNt6c1nRUYJLUUAzDu/ALVlKUE5TCLSkGYvDif9M9yn0urIszkCnvjg8DaWq+QB79M6NX/3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4uBGS08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4uBGS08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D346C19425;
	Mon, 27 Apr 2026 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777299545;
	bh=Z8uPFvUofYxjWjPDYMYgoiiaNfjDwiNKad/v6wutxnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4uBGS08pAkDtu6gg6sQuWtzN+qEN8RRpypDpGLg6dbGHFCDV68ajuV2aFMH3B4fr
	 1kdbWeloJPDluB0bCmH0+glYZL2ePBsLPAuzJKg8OhTfbddgQflYU/n/1ZRNKXHom4
	 jmqDnH41QmPpsI+Dzi+JKQvzra5yRf3/09+XQCHGvOok1dSLXGjiAR0t2AeiW2JbDZ
	 Bpi9wwtSptOXhoTOEnYy5AWH8XK48NIcmE2fl5E9Swhvx8V/k+38TGjzAK4jQcBp5v
	 iQWb6Hd+PjAwXMTlnruF1JjCQ4GjpQiIe2TP06at3EiLALrbpuKEGQcOV2Sl8oHDcE
	 BOPqNwMS2+AGg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 1/4] mm/damon/ops-common: optimize damon_hot_score() using ilog2()
Date: Mon, 27 Apr 2026 07:18:46 -0700
Message-ID: <20260427141848.111385-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426232811.618BFC2BCAF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 23:28:10 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 3 potential issue(s):
> - [High] Arithmetic overflow on 32-bit architectures during `age_in_sec` calculation.
> - [Low] The logic using `ilog2()` with a zero-check branch can be simplified by directly using `fls()`.
> - [Low] Unnecessary double blank line introduced.
> --
> 
> commit c096ebdf3dd6d7a6e783e2ac65dec1740282929f
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
>     mm/damon/ops-common: optimize damon_hot_score() using ilog2()
> 
> This commit replaces the manual for-loop used to calculate age_in_log
> in damon_hot_score() with the ilog2() function. This optimization aims to
> significantly reduce the latency of the hotness score calculation.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 8c6d613425c1..3a0ddc3ac719 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -117,9 +117,12 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >  		damon_max_nr_accesses(&c->attrs);
> >  
> >  	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
> 
> This isn't a bug in your patch, but does the multiplication of
> (unsigned long)r->age * c->attrs.aggr_interval overflow on 32-bit
> architectures?
> 
> Since both variables evaluate as 32-bit types on 32-bit architectures,
> if aggr_interval is 1,000,000 (1 second), the multiplication will wrap
> around when r->age exceeds 4294. This wrap-around could result in a very
> small age_in_sec value for extremely cold regions, causing them to be
> falsely evaluated as young and hot.
> 
> Should this calculation be cast to a 64-bit integer prior to multiplication,
> perhaps using div_u64()?

Good point, but as Sashiko also notes, not a blocker of this patch.  I will add
a todo item for thinking more on this.

> 
> > -	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
> > -			age_in_log++, age_in_sec >>= 1)
> > -		;
> > +	if (age_in_sec)
> > +		age_in_log = min_t(int, ilog2(age_in_sec) + 1,
> > +				DAMON_MAX_AGE_IN_LOG);
> > +	else
> > +		age_in_log = 0;
> 
> Instead of using ilog2() with a zero-check branch, could this be simplified
> by directly using fls()?
> 
> The fls() function safely returns 0 when the value is 0 and correctly
> calculates the 1-based log2 value for positive numbers, allowing this
> branch to be removed entirely while preserving the exact mathematical
> result.

We believe ilog2() is easier to read.

> 
> > +
> >  
> >  	/* If frequency is 0, higher age means it's colder */
> 
> This isn't a bug, but an extra blank line appears to be introduced here,
> creating two consecutive blank lines.

Good cactch.  As this is a quite minor issue, I will ask Andrew to fix this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260426231619.107231-1-sj@kernel.org?part=1


Thanks,
SJ
