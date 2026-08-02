Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00222BF3D7
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689577; cv=none; b=OiAhDXU3VRZqd9l/fi+p2guyct5WzNWq68sGkyi9HOZN5DLLH0R8edkfNgYyn/w9Kz9rBS1ZnioFYkrxjYXJh9476cmMPP5jqC4RkvNmnoorvxeGZJ9mco73dTEQSjEpOVALseCGEMGxDPgNdGXhOLU8wBj2YHwl5egmvxRr+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689577; c=relaxed/simple;
	bh=7uQIUAxEb62LxxerfG1DHRSXZiIR7P0y8rxxedD6IB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWr0AnFnZ8t4NlbzT9qv5Rm3/yZ56XozvwhMovJcqWAxFd1V1G/EAuASJylCsHWpIMWxrKW2R2e/IyOWwwAl+kGGrm7vFaXe2fQsL9bePdSjzGdnV8W1pkxiGBUF7MzFvpaN2IuXHp13DUCgIpjn3lvP/+01OZUaTKWoQ+bbgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuSxO4nr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuSxO4nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773571F000E9;
	Sun,  2 Aug 2026 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785689576;
	bh=NJfAohqgDKr2A/x0BvqYLjQqZFikqrz2kDoFoMgFKsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CuSxO4nrSzVgJCUy1Sfl4MyXBHsZHE7ZCe6bWTdA8GPcVaZbyf+an6RsqrVO1lzmX
	 lohA++WuchICYddLrn5AxUybBoambWXK6qAiQRYtHpcVGvwD/9yT64VZvrxckMO36i
	 StKTjLuDW9/63GEvl6a8ArwfQvmLa8UK74PU+E9fIGOVbzhiVIlyhhh3SVGU4+DMVM
	 za7l/N9+dYdK+T/iAHXISwNKWYlWhp+PEYm1CFj5eABWRNjitULqxm7eircG34OBBS
	 qgqUSHtLOmHRLc+fwulRRenIGJsl8ZdZNs5zyiw5Loozzhu1tKrMKVbAbqIQCE4dZM
	 PKdCE+YUI6wFw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 1/2] samples/damon/mtier: error out for zero quota goal target values
Date: Sun,  2 Aug 2026 09:52:47 -0700
Message-ID: <20260802165248.91066-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802163239.A7FFA1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 16:32:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Low] The newly added comment incorrectly refers to `damos_quota_store()` instead of `damos_quota_score()`.
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the division-by-zero vulnerability is only patched at the module boundary in `mtier.c`. The unvalidated core API (`damos_new_quota_goal` and `damos_quota_score`) remains vulnerable and is still exploitable via other DAMON components. For instance, in `mm/damon/lru_sort.c`, an unchecked `active_mem_bp` module parameter can be set via sysfs such that it evaluates to 0, causing a kernel panic.
> --
> 
> --- Patch [1]: [RFC PATCH v2 1/2] samples/damon/mtier: error out for zero quota goal target values ---
> commit a29006e1d33ea981b557928c622fb8487e53dbc8
> Author: SJ Park <sj@kernel.org>
> samples/damon/mtier: error out for zero quota goal target values
> 
> This commit prevents a division-by-zero exception in damos_quota_score() by
> returning an error when users try to start DAMON with zero values for the
> node0_mem_used_bp or node0_mem_free_bp parameters.
> 
> Link: https://lore.kernel.org/20260801202657.117135-1-sj@kernel.org
> 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index ac9c24b92ead8..d1123ebbfab90 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> > @@ -156,6 +156,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
> >  	if (!scheme)
> >  		goto free_out;
> >  	damon_set_schemes(ctx, &scheme, 1);
> > +	/* zero target value causes division by zero in damos_quota_store() */
> 
> [Severity: Low]
> This isn't a bug, but should this refer to damos_quota_score() instead of
> damos_quota_store()?

Good catch, it is a typo.  I will fix.

> 
> > +	if (!node0_mem_used_bp || !node0_mem_free_bp)
> > +		goto free_out;
> >  	quota_goal = damos_new_quota_goal(
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while this change handles the
> zero target value at the module boundary in mtier.c, does the unvalidated
> core API leave other DAMON components vulnerable?
> 
> For example, looking at damon_lru_sort_add_quota_goals() in
> mm/damon/lru_sort.c:
> 
>     goal = damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
>                                 10000 - active_mem_bp + 2);
> 
> If active_mem_bp is set to 10002 via sysfs, this evaluates to 0.
> 
> Because damos_new_quota_goal() in mm/damon/core.c accepts the target_value
> without validation, this zero value propagates to damos_quota_score() where
> mult_frac() performs a division by goal->target_value.
> 
> Could this cause a division by zero exception leading to a kernel panic?
> Would it be safer to add validation directly inside damos_new_quota_goal()
> or damos_quota_score() to protect all consumers?

The next patch of this series is fixing the lru_sort bug.

> 
> >  			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
> >  			DAMOS_QUOTA_NODE_MEM_FREE_BP,
> >  			promote ? node0_mem_used_bp : node0_mem_free_bp);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802162050.89477-1-sj@kernel.org?part=1


Thanks,
SJ
