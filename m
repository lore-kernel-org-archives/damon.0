Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C567382F28
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609093; cv=none; b=sZdsPGprk6kopmliFkR5eG3ylWQuLF6entcG9r6hSsnHYGbYzBmjgnocOM27BXwziEZWWLCPXSt+gArs/L8lHc3QZLK3/DBP9ynJrS7dDieY8HpRNAE8lq9dl6+bdQXLtFcvWxKq4DS+b3hyUtb9kC8JMsl2j0xM8l03e+7l5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609093; c=relaxed/simple;
	bh=ysLvOGSVgAfq+pFBQ5F37iSb80M+3xim2snChkW0IvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPbcU+CaMDEFh/CUcx3f9N7EJ9Itk+Sd06dpcvMDRSOY5vykNiOwz1F9qtnx+7h+MWS6md7kWRDektocUcGR5Fl1RN9FwjhtJM9vb0l0psFVVFFDCE7/NEJcHthR8EKDCfdavtbD+2oa7DejIy8JGj2dYfMI2muswUoTko4n/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUMlupa6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUMlupa6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB0D1F000E9;
	Thu,  9 Jul 2026 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609092;
	bh=9/1HqyWrkZyjYEF/IvFYN45GJgOoUw5a6qAk63F1iqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LUMlupa6hH9ZCnsAvhOcfNEa02zLm+5bNrfTtqyKbrpQL9ATlKLP6FdQy53R+KwHg
	 Erg/af9obJhWp2KxvJ310FljiRoBSKAGVKgLi22kQu4GGOzILwG20e3xq4MFCdVvzO
	 2uZnm5DHkb8SYNRYphP3QZ/msN3CwIJinmTWvM8u4oJqsTw9nOZI9djlfY2QsAS04Z
	 3OMeLgr/TKLr+IVRMRILG1x32qF3PD5Nf9+NcyhgevVAIr+qLqhk6grPLGkzY7aUQi
	 9g7tKZrw/+e1IK+azicTOjNygNp8bIwiszEH62B6CnFpTyRZsXgckEIrWle3rv7e5M
	 67/hbOlX6SuQg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 10/19] mm/damon/core: validate params for probe hits weighted sum overflow
Date: Thu,  9 Jul 2026 07:58:02 -0700
Message-ID: <20260709145804.96776-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709143652.6A8E61F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 14:36:51 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Spelling mistake in comment.
> --
> 
> --- Patch [10]: [RFC PATCH v1.2 10/19] mm/damon/core: validate params for probe hits weighted sum overflow ---
> commit 3e76c3dde55500288f3eccb730acd26964bfdad2
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: validate params for probe hits weighted sum overflow
> 
> This commit adds parameter validation to prevent probe hits weighted sum
> overflow. It ensures that the combination of probe weights and aggregation
> intervals does not exceed the maximum allowed values.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 4f1425e56950b..b585e4bf035f1 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1342,6 +1345,18 @@ static bool damon_valid_probe_params(struct damon_ctx *ctx)
> >  	sample_interval = ctx->attrs.sample_interval ? : 1;
> >  	if (ctx->attrs.aggr_interval / sample_interval > U8_MAX)
> >  		return false;
> > +
> > +	/* invlaid if probe hits weighted sum can overflow */
> 
> [Severity: Low]
> This isn't a bug, but there is a typo in this comment ("invlaid" instead of
> "invalid").

Good finding.  I will fix in the next revision.

> 
> > +	max_probe_hits = damon_nr_samples_per_aggr(&ctx->attrs);
> > +	wsum = 0;
> > +	damon_for_each_probe(probe, ctx) {
> > +		if (probe->weight > UINT_MAX / max_probe_hits)
> > +			return false;
> > +		wsum_to_add = probe->weight * max_probe_hits;
> > +		if (UINT_MAX - wsum < wsum_to_add)
> > +			return false;
> > +		wsum += wsum_to_add;
> > +	}
> >  	return true;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709140600.90950-1-sj@kernel.org?part=10


Thanks,
SJ
