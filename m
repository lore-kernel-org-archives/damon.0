Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698019CD1B
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977563; cv=none; b=Q7RLNhVQyv+ZKp6cq4FXubcoD+YebXcjgxK/R+ZIhS6t2RjIl36n/pL+u1XGMek7pHuaH6czjoAPUaYmESeB0328ue1jiZudcXwErHKNum4Lu4IJg1+A7ZBLf90G3VtpjQW1E2OCnHywEYI2Y+fYKsKMffF7vTVNJSSlTPPSni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977563; c=relaxed/simple;
	bh=733/xex6Tc8S9s0Eqoe2rgFO+1TLhd9VBpkf5lqqb7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTVghxkh/+6BMFz8ZXN2sMu9jl0JFkZ/ZqlNLMoimY5JjqL98SG+n+gx8SrIj+mIVSbA5gKILctemFxPpdGGaBWG8JZEMvTyqs9hbHcQu5+Sh11y5pg/je2fJXUDToYNYj13u/140iHrcUjSOegiZsDEOkBPJyOASQjAhClvnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL/JsuqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL/JsuqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8291F000E9;
	Sat, 20 Jun 2026 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781977562;
	bh=lKNehEQkMRCi5En7z77VejMtZAYaUl+k5VCkKPNsC5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JL/JsuqKbM4o0REuvXaIYVOK0bWA1NdtCjEd9cyLq3WM0Jiy0byWIXP/5iOQlAzU0
	 DaDGKMult3JpyL0WnA0jvipeLH2NqsZhNkDyxvgK3f+qAMzu5kwfwF3u6iDCwI3DMX
	 QWZ5tHuo/y6OP/zIMiNz1yhuY5STYX+t2Ua0xrb5l2zudAGhRxV3oNm6MwEGXV+4EJ
	 +HOtan1n8jrek29vxjfC/ur5Zr8PEuQFIEcXSAIovU00YR43DwIVB1cbUZ6r4Jc2Jl
	 xJH439Tydh07x/O91+yEdl6A+9xL+QXCwSE5yLh6200mhMozOQxFtjvHxrpCUqS00y
	 jEVUyUyLiEKiA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 11/13] mm/damon/core: remove nr_accesses_bp setups and updates
Date: Sat, 20 Jun 2026 10:45:52 -0700
Message-ID: <20260620174553.92751-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620173431.09F911F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jun 2026 17:34:30 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The `attrs` parameter in `damon_update_region_access_rate()` is completely unused after this patch.
> --
> 
> commit ecb338097e9822ecdcbfa5f88676102211ac76ca
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: remove nr_accesses_bp setups and updates
> 
> This commit removes the setups and updates of the nr_accesses_bp field
> in the DAMON core. The field is no longer used for any real purpose and
> has been replaced by a simpler function.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 53568a3c3ad9b..a41b66b26a472 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3779,18 +3774,6 @@ static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
> >  void damon_update_region_access_rate(struct damon_region *r, bool accessed,
> >  		struct damon_attrs *attrs)
> >  {
> > -	unsigned int len_window = 1;
> > -
> > -	/*
> > -	 * sample_interval can be zero, but cannot be larger than
> > -	 * aggr_interval, owing to validation of damon_set_attrs().
> > -	 */
> > -	if (attrs->sample_interval)
> > -		len_window = damon_max_nr_accesses(attrs);
> > -	r->nr_accesses_bp = damon_moving_sum(r->nr_accesses_bp,
> > -			r->last_nr_accesses * 10000, len_window,
> > -			accessed ? 10000 : 0);
> > -
> >  	if (accessed)
> >  		r->nr_accesses++;
> >  }
> 
> [Severity: Low]
> Does this leave the attrs parameter completely unused in
> damon_update_region_access_rate()? 
> 
> Since the removal of the damon_moving_sum() logic removes the only use of
> attrs inside this function, could we also drop the struct damon_attrs *attrs
> parameter from the signature and its callers to fully clean up the API?

Good finding.  But not necessarily as a part of this series.  I will add this
as a todo.


Thanks,
SJ

[...]
