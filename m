Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921A222565
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609269; cv=none; b=KpBc6yc4PwQHspds2Fmh6elAAuuUUgK13FE4N42QSB9AzVWwUALfxHqbsvx8KjhhY5JFoz94PoWYixacURQQ8+VOvoQMMnxPlFO+FnH6hbPsW7Uj/FgQFGR3hgvHQ1gpF5zwxClllwGb5PwMts68eixd96OGsgN8RyXJdBAPrXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609269; c=relaxed/simple;
	bh=7mJuMz/KfBDZCEz17IYnwFe4uLODxMQr1AuHtnipXkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1BYRH7kLZzXTBDfoEAFCmj9uvn1J8rbGD1seiNCOqeslP6essW2uJNTCDHP9ys2CJS+cqXpZEVI+fu+6G+KGffY5csVxU1i3CN5I4gfhutdbV10snCTUynqgEeMporEIr7i+bhNvxbP6mK9Y1YztHxqzyuT1tk5If4GF8a61Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFt6MW72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFt6MW72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA001F000E9;
	Thu,  9 Jul 2026 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609267;
	bh=QHWQVGFS03jqNN36guqBwCJP4SMcZohKHkWg0ox+2dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DFt6MW72FmQP6V5P0InUe4BwJKdO/Qhz5cHR0Gl18K7NouplLlTtcm6IV/nfAgDm8
	 KP9sC7+7PSWa18CIIWwE3X24hoffvzO2rFdAbKWO4gDr0Ckxz6yzsHNO1JoDx0qIno
	 HKHksu2Wq6jkTwevBMcrmozdIEzOyw/Dfb+hpBEOGYQ9EOo/NRiVUmiVM7OSr63Eg6
	 X/y433L5/MBW1ycf3Dhog8qJNiutEVzZdTBqbr99dsgWTK76PtzxSpxF1P5j3n3RgG
	 BefZMHNttzome7Ov4H+0Faa8f0ihsc4gXBgyX0lOrSoB11tkvOMBQgrzktZbVK0zBq
	 M0XtHrWjw1szg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 12/19] mm/damon/core: set samples in apply_probes() if probe weights are set
Date: Thu,  9 Jul 2026 08:00:58 -0700
Message-ID: <20260709150059.96929-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709144855.C811B1F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 14:48:55 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] When access checks are disabled, `max_nr_accesses` is not updated but is still used for the region merge threshold. `apply_probes()` is incorrectly called without requesting or capturing the maximum weighted sum.
> - [Medium] Setting probe weights on a context whose operations do not implement `.apply_probes` (e.g., `vaddr`) silently disables all monitoring.
> --
> 
> --- Patch [12]: [RFC PATCH v1.2 12/19] mm/damon/core: set samples in apply_probes() if probe weights are set ---
> commit ffce494dcbbb1125634a81b14be56b2f89aefe7e
> Author: SJ Park <sj@kernel.org>
> 
>     mm/damon/core: set samples in apply_probes() if probe weights are set
> 
> When probe weights are set, the prepare_access_checks() ops callback is
> not invoked, so sampling addresses of regions are unset.  Ask
> apply_probes() to set those together in the case.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index e250b7080708d..f1be748e9a674 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3777,7 +3777,8 @@ static int kdamond_fn(void *data)
> >  		if (!access_check_disabled && ctx->ops.check_accesses)
> >  			max_nr_accesses = ctx->ops.check_accesses(ctx);
> >  		if (ctx->ops.apply_probes)
> > -			ctx->ops.apply_probes(ctx, false, false);
> > +			ctx->ops.apply_probes(ctx, access_check_disabled,
> > +					false);
> 
> [Severity: Medium]
> When access checks are disabled, check_accesses() is bypassed and
> max_nr_accesses is not updated.
> 
> Later in this function, kdamond_merge_regions() uses max_nr_accesses to
> calculate the merge threshold:
> 
> 		if (time_after_eq(ctx->passed_sample_intervals,
> 					next_aggregation_sis)) {
> 			kdamond_merge_regions(ctx,
> 					max_nr_accesses / 10,
> 					sz_limit);
> 
> Since apply_probes() is called with return_max_wsum=false, it doesn't
> update or return a max weighted sum.  Will kdamond_merge_regions() use an
> invalid or stale threshold (often 0), breaking the merge algorithm?

That will be implemented by a later patch of this series.

> 
> [Severity: Medium]
> If a user sets probe weights on a context whose operations do not implement
> .apply_probes (e.g., vaddr), access_check_disabled will be true and
> check_accesses() will be bypassed.
> 
> Since .apply_probes is not implemented, this block is also skipped.
> 
> Could this completely disable all monitoring for the target with no error
> feedback to the user?
> 
> Validation in damon_valid_probe_params() successfully validates this state:
> 
> mm/damon/core.c:damon_valid_probe_params() {
> ...
> 	if (!damon_has_probe_weights(ctx))
> 		return true;
> ...
> }
> 
> Should damon_valid_probe_params() check if ctx->ops.apply_probes is supported?

This is an intentional design.  The user should config DAMON correctly.

> 
> >  
> >  		if (time_after_eq(ctx->passed_sample_intervals,
> >  					next_aggregation_sis)) {
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709140600.90950-1-sj@kernel.org?part=12


Thanks,
SJ
