Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55F442118
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520873; cv=none; b=JyjjR0d1Ixqc15xtc6dWROXyKK7lj7jLgJiPkTum2PPRP7CSGVsUzPc5G9CCo+7z46flaCgqBvdP2CIvqrebw0lmLJcmRAx/6El3GUxxjBDmHEAollqVdV+7d4Ft2beiPMT8Fy93aKvBYoeprqVmAOJuEzFCUWMh0OhtZfTrSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520873; c=relaxed/simple;
	bh=DOq7uidAUSc0seNoWK+1KUsUsA8eyf6dy/Ayw2xVoJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dl9ihp+N+h9yeTbbRE1X+RB87NKXztu315110GRzG4GCFmTa75OltiqIs5BDV1jut864etyC7D1YmIAD+rXd4tVcd41v+hPSY3AAmA1rGPhOHDBzogS6xtgEpAERPAjuQ8391YejkEh8zINHUMWOFElXJLUMTDv0ZD5LvyTIpi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyJ5CApv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyJ5CApv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339A61F000E9;
	Wed,  8 Jul 2026 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520871;
	bh=fQca5snBc66sxi7o2gyN55Cry+hOMN495J1ha8/O8XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyJ5CApvZw1QHARws317yKAjvR20on8pHogMWN2FAyo/+/SAfnuEb1Ou34tcHAUqo
	 m7vlQnBIO5ult64oKfZsuZ8f3BnxDHbafNGbCZh/hqJFr+UrL4LTXAYJIfEsqd4xek
	 dasFJ5gSn3Sv7S5taHaOVxoZKZE3uF4oGCu7Zs0Nq9u0rHKfuT2BrSIw8zXhoI08GY
	 axCKrRqFIfPBiF7mfZw74y3pVtDyXHQwtbDLC5iCsh9q/DdCQY+Uj7ThAA2BM8OoDQ
	 n9x0GJZRgWw72SxhMdtX1Yn6L/lY4wAwDWupwDfNWDVwp7HIT6dBKgOOPPrJgCYARl
	 N0h/HkuCZgEZQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 5/7] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Date: Wed,  8 Jul 2026 07:27:42 -0700
Message-ID: <20260708142743.124162-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708140944.F26821F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 14:09:44 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] 32-bit arithmetic overflow in sample count and basis points conversions leads to incorrect scaling for large interval ratios.
> - [High] 32-bit integer overflow in `damon_age_for_new_attrs` when calculating region age during attribute updates on 32-bit architectures.
> --
> 
> --- Patch [5]: [PATCH 5/7] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/ ---
> commit 7659397725f64a348908ab982da60d557f63b8c0
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
> 
> This commit renames damon_nr_accesses_for_new_attrs() to
> damon_nr_samples_for_new_attrs() to reflect its general use for any positive
> sample count.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 718268df27fa7..800ff6b6d2473 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -890,22 +890,21 @@ static unsigned int damon_sample_count_to_bp(
> >  	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but does this code overflow 32-bit arithmetic
> when the sample count is large?
> 
> In mm/damon/core.c:damon_sample_count_to_bp(), the mult_frac macro multiplies
> the remainder by 10000, which can overflow 32-bit arithmetic.
> 
> Similarly, in damon_sample_bp_to_count(), the 32-bit multiplication overflows
> since both operands are 32-bit unsigned integers:
> 
> mm/damon/core.c:damon_sample_bp_to_count() {
> 	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
> }
> 
> This occurs when the number of samples per aggregation interval exceeds
> roughly 429,496 (e.g., sample_interval=1us and aggr_interval=1s, yielding
> 1,000,000 samples).
> 
> This could cause the region access tracking variables to be corrupted and
> truncated during dynamic attribute updates (damon_set_attrs), rendering DAMOS
> memory management schemes dysfunctional.
> 
> Both intervals are fully configurable by privileged users via DAMON
> sysfs/debugfs interfaces, or dynamically updated by DAMON's auto-tuning
> feature, making the overflow reachable in real-world scenarios.

Known low priority issue.

> 
> [Severity: High]
> This is also a pre-existing issue, but can the region age calculation
> overflow on 32-bit architectures during attribute updates?
> 
> Looking at damon_age_for_new_attrs(), the multiplication is limited to the
> architecture's native unsigned long size:
> 
> mm/damon/core.c:damon_age_for_new_attrs() {
> 	return age * old_attrs->aggr_interval / new_attrs->aggr_interval;
> }
> 
> On 32-bit architectures, aggr_interval (unsigned long) and age (unsigned int)
> are both 32-bit. The product exceeds ULONG_MAX (4,294,967,295) once the
> stable time exceeds ~4,294 seconds.
> 
> This causes an integer overflow before the division, meaning any memory
> region that remains stable for more than ~71.5 minutes will have its age
> wrapped around and reset to an incorrectly small value when DAMON
> attributes are dynamically updated.
> 
> This could break DAMOS schemes that target old pages for reclamation.
> 
> The bug is automatically triggered by DAMON's auto-tuning thread
> (kdamond_tune_intervals), which periodically calls damon_set_attrs, or via
> user-initiated sysfs attribute updates.

Known low priority issue.

> 
> > -static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
> > +static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr,
> >  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
> >  {
> >  	return damon_sample_bp_to_count(
> > -			damon_sample_count_to_bp(nr_accesses, old_attrs),
> > -			new_attrs);
> > +			damon_sample_count_to_bp(nr, old_attrs), new_attrs);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260708135359.122587-1-sj@kernel.org?part=5


Thanks,
SJ
