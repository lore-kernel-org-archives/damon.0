Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2A32B126
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241854; cv=none; b=bMZC+W0AbefIYJHgEjWgRiEsMNyzFwC8oWKRq9GFs3Sm24+wEBrXRLcnVpYXlLyHx67+yNs5LoKvTXaKtPeNciQGowSEGlwS2kpf9qroe5kMnW3QChGtX/DBd8JDvDR6HmHNkLQVMaA0h0eudajblPH5QXc1d/laBXjwSK8HoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241854; c=relaxed/simple;
	bh=+bQflERObibiPKkgMLTrkMB6vKzpOjYtSLSAVf1F2Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0f26KAOk5RLnNpN04bmCzI4Bn2f4SZBT7zQ1fr1WWqSdtQqbVE2htw3JtpW+a6Qc/dvDfg8rxsvczUCK3GSmFdG/U2R4rK4a1UKkXaPHL7fPCyn8cctHeokDB7Pqbt2VrMvQfhvVAIa34ciW9ISR5OltqkppDZ/s4PHjh57N54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEMHAvPS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEMHAvPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2591F00893;
	Sat, 12 Sep 2026 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789241853;
	bh=EDgQn9P+7qerdWJ/0waF913SbnlvDNkOUQSSCrPH0vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gEMHAvPSxiCdhZQLZXnKqYJNv4NI6vglmq/I6BtfUhq70wJfocNPWqzt81O09Znlr
	 hKSFRgtotaqH2R1Pd5owBl87V6THqN1ejrPwNj4uN1au9P4Rd8cfCr5tftAeoleRG+
	 3L61FWTa1OdhHLZqQtu9djSGcQHhC61QrqlkWUXN0dG/DFI6i2Oj4vDWoanOQyc+ty
	 H6RcFIHlG5kXr1+aEzhFq/Mdoxn/rL7zXJaR/1xv/8VVPypm/8S2pmX5TZowC45vab
	 30037k50VYG5k1vfebr8w6l5q54Fdp9b7txstfOmtg90F70VUeX4jiz8mI7K30gLiU
	 EqE74gNs4hXPg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/8] mm/damon/core: return an error from damos_commit_filter_arg()
Date: Sat, 12 Sep 2026 12:37:20 -0700
Message-ID: <20260912193721.139165-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912192916.F2BE81F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 12 Sep 2026 19:29:16 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unhandled error returns in DAMOS filter commit functions lead to uninitialized memory use and type confusion.
> --
> 
> commit f2946ab5f9d35b397a925510dc71e57f307f11d2
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: return an error from damos_commit_filter_arg()
> 
> damos_commit_filter_arg() is supposed to always succeed.  It may not in
> future, for example, if the given filter is invalid.  Prepare the case
> by modifying its signature to return an error when it failed.  Also pipe
> the return value to its callers and let them handle the error.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 0c98f7e267d07..3ad1fb2f21f3f 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > -static void damos_commit_filter(
> > +static int damos_commit_filter(
> >  		struct damos_filter *dst, struct damos_filter *src)
> >  {
> >  	dst->type = src->type;
> >  	dst->matching = src->matching;
> >  	dst->allow = src->allow;
> > -	damos_commit_filter_arg(dst, src);
> > +	return damos_commit_filter_arg(dst, src);
> >  }
> 
> [Severity: High]
> Does this code leave the target filter in a type-confused state if
> damos_commit_filter_arg() fails?
> 
> Since dst->type is modified before the arguments are committed, if an error
> is returned and subsequently ignored by the caller, the filter could have a
> new type but mismatched union arguments from the old type.

Yes, and the caller will destroy the filter, so no problem.

> 
> >  static int damos_commit_core_filters(struct damos *dst, struct damos *src)
> >  {
> >  	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
> > -	int i = 0, j = 0;
> > +	int i = 0, j = 0, err;
> >  
> >  	damos_for_each_core_filter_safe(dst_filter, next, dst) {
> >  		src_filter = damos_nth_core_filter(i++, src);
> > -		if (src_filter)
> > -			damos_commit_filter(dst_filter, src_filter);
> > -		else
> > +		if (src_filter) {
> > +			err = damos_commit_filter(dst_filter, src_filter);
> > +			if (err)
> > +				return err;
> > +		} else {
> >  			damos_destroy_filter(dst_filter);
> > +		}
> >  	}
> >  
> >  	damos_for_each_core_filter_safe(src_filter, next, src) {
> 
> [Severity: High]
> Does this code ignore the return value of damos_commit_filter_arg() when
> creating new core filters?
> 
> Further down in this loop:
> 
> mm/damon/core.c:damos_commit_core_filters() {
> 	...
> 	new_filter = damos_new_filter(
> 			src_filter->type, src_filter->matching,
> 			src_filter->allow);
> 	if (!new_filter)
> 		return -ENOMEM;
> 	damos_commit_filter_arg(new_filter, src_filter);
> 	damos_add_filter(dst, new_filter);
> 	...
> }
> 
> If damos_commit_filter_arg() fails, does this silently add an uninitialized
> filter with garbage union arguments to the destination scheme?

Good finding, I will fix this in the next spin.

> 
> [Severity: High]
> Are there also missing error checks in damos_commit_ops_filters()?
> 
> It appears damos_commit_ops_filters() wasn't updated in this patch to
> check the new integer return values from damos_commit_filter() or
> damos_commit_filter_arg():
> 
> mm/damon/core.c:damos_commit_ops_filters() {
> 	...
> 	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
> 		src_filter = damos_nth_ops_filter(i++, src);
> 		if (src_filter)
> 			damos_commit_filter(dst_filter, src_filter);
> 	...
> 	damos_for_each_ops_filter_safe(src_filter, next, src) {
> 		...
> 		damos_commit_filter_arg(new_filter, src_filter);
> 		damos_add_filter(dst, new_filter);
> 	...
> }
> 
> Can ignoring these errors leave the ops filter in a type-confused state or
> silently add uninitialized filters to the destination scheme?

Good finding, I will fix this in the next spin.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260912191807.138502-1-sj@kernel.org?part=3


Thanks,
SJ
