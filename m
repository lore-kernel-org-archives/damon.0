Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DC47D929
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039399; cv=none; b=fSlakj/a/cu+VKYvtmVs+NPTMlgF0yc7lw6PBPoPzApaj02CLE8lZ80SCk4qBpKaZ3H9oy2XKkjNyGtYR7Z3QmoEsfUN2wX4Nr+u/btoFc/rPGKBb6ZDcHJEquxUNeHZWZZJduzzRIHVZYQhVLQA7O8swaLZY0LbdeJIuYztn/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039399; c=relaxed/simple;
	bh=o4auc4LZsy2gEeJuxjRRtOvvJgLdltqocs8fL3dX5nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULZuz325BdyhjBUQBtx34qzxOdEgmyOT3/BI3mRpLq0WMSZIm5ex5ckC1vqkDV0v91MUZyPjz0rZfTOmGxYTlKFgCxImken52KwRG+jL2sasiaru2xcj1R3+kmCyyq3vaR+wcf17YGr1HOz82bYJwpwXV3iLWxVfSMyR+8wz/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi1sgPnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi1sgPnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626DF1F00A3A;
	Tue, 14 Jul 2026 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039397;
	bh=Ot4GAL5KS43MR2L0hHzoFKE8ZaNV/fkWK9D+wFP1xWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mi1sgPncXVKqzu8ivZFP+OywNuZaqgyxoIxrldYkJ4ZL42My4ZlVgm+Kxe7RBg6Q/
	 SYn3Y1AE6+a4njWijYX6JaRrc1DPyW6O4fpKofY/gxMtr3HDuThZ2JmpAg0jrWZqC4
	 T48zU7LaLi2pp0fmMUudG0pbuVbrrEBJBu+UwdxltWRdqH+Ml1ljZlCXTt1UtIhS1B
	 PmB22YQSn+1StudRZqUOuIHZxvrT/RlgjffLmOLRB8rF6X8YmMGw7Aiv9bvlcHAZmt
	 Cq4mi/QC6ovt7y/Yp0OiMQF2r9pd5x0PNNvW7HQastGPfgZyrW7WIf2S00fVBuN4AW
	 D2wP28PKjv2/Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 5/5] mm/damon/sysfs: read ops_id only once
Date: Tue, 14 Jul 2026 07:29:49 -0700
Message-ID: <20260714142950.100711-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714142509.010D91F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 14:25:08 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch implements an incomplete fix for a TOCTOU data race. It correctly uses READ_ONCE() for `ops_id` to prevent `min_region_sz` corruption, but leaves an identical unresolved race condition for `addr_unit` immediately below it.
> --
> 
> --- Patch [5]: [PATCH 5/5] mm/damon/sysfs: read ops_id only once ---
> commit f0f9d921acb64429b2f4e2895a8088cc3b5477d5
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: read ops_id only once
> 
> This commit addresses a time-of-check to time-of-use race condition in
> damon_sysfs_apply_inputs() by reading ops_id only once. This prevents a
> concurrent sysfs write from causing min_region_sz to be incorrectly
> configured.
> 
> Link: https://lore.kernel.org/20260703172417.95426-1-sj@kernel.org
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index b5fe036f78015..60a1a9e4ada34 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -2094,14 +2094,16 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
> 
> [ ... ]
> 
> >  	ctx->addr_unit = sys_ctx->addr_unit;
> >  	/* addr_unit is respected by only DAMON_OPS_PADDR */
> > -	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
> > +	if (ops_id == DAMON_OPS_PADDR)
> >  		ctx->min_region_sz = max(
> >  				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
> 
> [Severity: Medium]
> Is there a similar race condition remaining for sys_ctx->addr_unit?
> 
> While this patch successfully fixes the race for ops_id, sys_ctx->addr_unit
> is read twice sequentially in this same block of code without protection.
> 
> A concurrent sysfs write to addr_unit between the assignment to
> ctx->addr_unit and the division in the max() calculation could cause DAMON
> to inconsistently calculate min_region_sz, degrading monitoring precision.
> 
> Should addr_unit also be read only once using READ_ONCE() here to fully
> prevent the race?

Good catch.  I also found I forgot adding Fixes: tag.  I'll fix this in the
next revision.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714135236.92699-1-sj@kernel.org?part=5


Thanks,
SJ
