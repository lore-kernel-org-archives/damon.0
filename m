Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395652C21C4
	for <damon@lists.linux.dev>; Fri,  3 Jul 2026 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099467; cv=none; b=i0Pc7g7TVcRpqm91heHygJGWtZcFz/iU/G4qyf/5GIru1ZBf+aBXKbLI+ezvfMG6229Si51w+Czhj9Wt9toaUWOZ8rNcMZR8xWYOVYDpDpxxHZzhkBaeVJ/rf6FPPC5DpHFelEiMQ6O8j/B3TgC8D2xqm9vtROhDo1QbbSKpsms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099467; c=relaxed/simple;
	bh=V2u1PomqTlHTl9JP+mZwCipz2sX19s1B0B9TfWfeYiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYJpiaTcBsqQcQKshBR9jsUhuZQni/FTKCVqgW4PxHbRh/t0Mo0b+ZATBBqjDoCqXpBgU2umXuTi1MrFqCkpnw+J5cW8xE2PpDk0ofYXlhn7Lid1EOB1VVxy2bc6Sxy4adAVeTrQyZrkKlyjq+3pNKtqkxgWPdC7KHTpTDOUZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCMY7JUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCMY7JUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BC71F000E9;
	Fri,  3 Jul 2026 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783099465;
	bh=KGWObvyALrbc2mH5QAsjdfDuOtTm3T2EZUHDJT3a5wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MCMY7JUJxTc+FFUIoTXS66+bnvtIvSmLqH57cVdrvMg4PNacAcCj5hrCc3BgLUCPt
	 R35BQyG8HCa6uuDnIirrwFjUcJIUvz5HkcIC/JrW1vRFn1C091bHdwH7ii6JetymGo
	 9c2ZZINZFLrnNVq4UPfS739yg12Iyqaun94cnFMDZof8cuVtaR6lRgVXRpgg3KcOUW
	 21IkEWUVFpQ0t/GFClKP3AXdFcBugGSI45Y8dEpE4H76KBkg5FLquW5rCyBtgXZiUZ
	 llVJaYsfXRRNxx0ApDSqMBkWVdlajZeHvOyEYiLC4dLk+ASQbjHIJ6Hkv6m77FNuY9
	 hWgVTwS6NcsPQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: disallow overlapping input ranges for damon_set_regions()
Date: Fri,  3 Jul 2026 10:24:15 -0700
Message-ID: <20260703172417.95426-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703171141.F37E31F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 03 Jul 2026 17:11:41 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:

No blocker for this patch.

> 
> Pre-existing issues:
> - [High] Execution of ALIGN() and ALIGN_DOWN() macros with a non-power-of-two `min_region_sz`, violating alignment subsystem guidelines.

Wrong finding.

> - [High] TOCTOU race due to lockless concurrent reads of `sys_ctx->ops_id` and `sys_ctx->addr_unit`.

Correct finding but not a blocker of this patch.

> --
> 
> commit b68f48fc29d6aa945e1dd1ef0c694913e40d3854
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: disallow overlapping input ranges for damon_set_regions()
> 
> This commit reinstates validation in damon_set_regions() to ensure that input
> ranges are sorted and do not overlap. It checks the boundaries and returns an
> error if they are invalid, preventing unintended DAMON behavior.
> 
> Link: https://lore.kernel.org/20260630041806.151124-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c6fc35be633b3..b2fc15a3804ff 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -418,12 +418,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >  {
> >  	struct damon_region *r, *next;
> >  	unsigned int i;
> > +	unsigned long last_end;
> >  	int err;
> >  
> >  	for (i = 0; i < nr_ranges; i++) {
> > -		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=
> > -				ALIGN(ranges[i].end, min_region_sz))
> > +		unsigned long start, end;
> > +
> > +		start = ALIGN_DOWN(ranges[i].start, min_region_sz);
> > +		end = ALIGN(ranges[i].end, min_region_sz);
> 
> [Severity: High]
> This is a pre-existing issue, but does this safely handle a non-power-of-two
> min_region_sz?
> 
> The ALIGN macros rely on bitwise operations that produce incorrect
> boundaries if the alignment argument isn't a power of two. A user can
> write a non-power-of-two value to addr_unit via sysfs, which sets
> min_region_sz to a non-power-of-two in damon_sysfs_apply_inputs():
> 
> mm/damon/sysfs.c:damon_sysfs_apply_inputs() {
>     ...
>     ctx->min_region_sz = max(
>         DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
>     ...
> }
> 
> Even though damon_commit_ctx() eventually validates and rejects the
> configuration, these unaligned boundaries are actively used here to
> allocate and merge regions during setup. Could this lead to overlapping
> regions or division by zero before the rejection occurs?

We do the validation "after" the alignment, so no overlapping region can be
created.  Hence no division by zero.

> 
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can a time-of-check to
> time-of-use (TOCTOU) race occur with sys_ctx->ops_id?
> 
> damon_sysfs_apply_inputs() locklessly reads sys_ctx->ops_id multiple
> times:
> 
> mm/damon/sysfs.c:damon_sysfs_apply_inputs() {
>     ...
>     err = damon_select_ops(ctx, sys_ctx->ops_id);
>     ...
>     if (sys_ctx->ops_id == DAMON_OPS_PADDR) {
>     ...
> }
> 
> Meanwhile, a concurrent sysfs write can update ops_id without acquiring
> damon_sysfs_lock:
> 
> mm/damon/sysfs.c:operations_store() {
>     ...
>     context->ops_id = ops_name->ops_id;
>     ...
> }
> 
> If ops_id is changed between the damon_select_ops() call and the
> subsequent check, could it result in a torn configuration where the
> context operates in one mode (e.g., DAMON_OPS_VADDR) but the region size
> scaling logic is applied using rules for another mode (DAMON_OPS_PADDR)?

Nice catch!  Not a blocker of this patch, though, as Sashiko also mentioned.  I
will separately work on this.
> 
> > +		if (start >= end)
> > +			return -EINVAL;
> > +		if (i > 0 && last_end > start)
> >  			return -EINVAL;
> > +		last_end = end;
> >  	}
> >  
> >  	/* Remove regions which are not in the new ranges */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260703165610.92894-1-sj@kernel.org?part=1


Thanks,
SJ
