Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299B315D40
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482834; cv=none; b=amxmakTajrPECloppzgqZ8Li5VLZysXGkbuxpL/xE/bLjsQ71FQi/pmWhqN6nCa3wZRxD2t48vvK6S4B6DvRNu3XQ1jmMr7JyAnJvuVFcxQaQ7ckqxcWCETQ3vWQcEDfbLihRD0N9GssoGEBgiUfvRWdw3Oezt/CqRvAnwOjeI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482834; c=relaxed/simple;
	bh=QZ3+KRsJdHvS9POEqYimYW351esIZ8otdgnlW35KEIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQ/OcZHc50I2Sez35gtRQ7WERufQ2dBZfccB+8mNt6V5GcILOV9rKdiXBYvLYzsZHt12CvynzPtdKKFZx+0L8nDtDJjSkxUtFsXdYgDnNNR+KyA8WddI0LSpRrbqrDo/v8+DmkCkmTvNcnyjpH/EqVfyHCgEwAdRx/m0324UPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFCwCn3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFCwCn3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D141F000E9;
	Wed,  8 Jul 2026 03:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482833;
	bh=A5CiiiuBsGZhajUKbD7t3zTY/x11Aq+Oyu6R0vszlTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PFCwCn3+AE8zNaOa4lxozfLEm8padwO5yWBTiiH+Mu+jkYFuHbTMpsuH3Vg9YCZqJ
	 iryRjd5vfX6x0Nkql86KUEZEBSFF6H7paH2JtUquj+6yOF5CDRLIP3hqCGodLwBDa0
	 y8qRd+QJVHfwdLeuwCgdRbiJNN6QonTlGZPCI/1eZQn+BV/vL4kAJVwh3fpQPmaBfG
	 APTQCC1EUK2H2RUBsA9vrhNKdk+LKZEnopS+FoWAgxEE8qou0oBuvITiwozFiopK6U
	 ZkgdZhcef/g99fAwRGU7yuoJYN1iALji0Zn1gLCYRnuxTRF47TMB7y7pXh+vtych6i
	 1l6CM/ERrZnMA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 5/7] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Date: Tue,  7 Jul 2026 20:53:44 -0700
Message-ID: <20260708035345.118183-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708030154.C6C441F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 03:01:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] 32-bit integer overflow in sample scaling functions `damon_sample_bp_to_count` and `damon_sample_count_to_bp`.
> --
> 
> --- Patch [5]: [RFC PATCH v1.3 5/7] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/ ---
> commit 9db3c90e1f930b4b71612a504362560074396989
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
> 
> damon_nr_accesses_for_new_attrs() can be used for not only nr_accesses
> but also any positive sample count, like probe_hits.  Rename to be able
> to be used for such general uses without confusion.
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
> This isn't a bug introduced by this patch, but can the 32-bit unsigned
> integer multiplication here and in damon_sample_bp_to_count() overflow?
> 
> When a privileged user configures an aggregation to sample interval ratio
> greater than ~429,496 via sysfs (e.g., 10s aggregation and 10us sampling),
> the mult_frac() macro performs a 32-bit multiplication of the remainder
> by 10000. This could overflow when the remainder exceeds 429,496.
> 
> Similarly, in damon_sample_bp_to_count():
> 
> mm/damon/core.c:damon_sample_bp_to_count() {
> 	...
> 	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
> }
> 
> The expression bp * damon_nr_samples_per_aggr(attrs) is performed as a
> 32-bit unsigned int multiplication, which could overflow 4.29B.
> 
> Could this overflow silently corrupt region access counts, causing DAMON to
> make incorrect memory management decisions like paging out actively used
> memory?

Knowwn low priority issue.

> 
> >  
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
> Sashiko AI review · https://sashiko.dev/#/patchset/20260708024855.116614-1-sj@kernel.org?part=5


Thanks,
SJ
