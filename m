Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98A343D85
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400534; cv=none; b=gBr+Y3wx6QR5aLwOaEpmhD6lkYszVrGNi5gjYJl55dmrgNosAYSqpvQEgX7moVYTgh+7ZzwnY9sk+UYw37o7b8k1vZaxJbkxuq4FGpeW3nKV/rhmO+bbFO63Nd6chmbyYYrM5fMW11VEGtE6t5YYfS0NJ0gJ1bB0AheTq95/ZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400534; c=relaxed/simple;
	bh=qmEdg8X9bKgzBpz3/rgYaM2CdX7er/3JR6KvUyuHzGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U38MV7fkPu0B18SoUyt4Yf4VdrKro2/eAW/DO8c2isO2+nFXoSfwhgVND0Xdl4r7E/PL9QQ4WTAEtwKeMxccvz7/Hz6LsdaS+7U6Ee8Tt0clYbko6ztqb4K5/8HZL4TUxyWPxwI7UlMtHxjdrkkilPs/7UA08Ltg8IkvWIjILRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjIhRD2f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjIhRD2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8A01F000E9;
	Tue,  7 Jul 2026 05:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783400533;
	bh=fzwouJZOP3+Am6uG4EtLrTb/INxN0g6yy2/HL1MdYNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SjIhRD2fig0l671ULzin5BtVPq483QIXZjeBL/ks7jZxuzBfIyr4fUt52oS0/vpZp
	 qxZ9zumFgK+5yirozVfHUe50/zLfmjB/NuGE8cuwReJoNF1sZJZmuyLCO1gis1v8rl
	 eZDW8RIrA3R2GEr8Zyr7n+qmwjWYvt6A6Pe8v/BCsawHp+EwvhnMcCojTRI+AqQAbU
	 3RrBcR49ShlGe1j3AROQr2SsLFL2bVjVDkHXE12dX32YBecgce3fqspCiUhI65sYUM
	 wV0PR7lXGHmTgRXqFl0T4MNNtCLvPrpNb0MM20+3mf/ODThv+7EN5ZX3WNUxQ/HyMa
	 dh3exeJO5HKXQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/6] mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/
Date: Mon,  6 Jul 2026 22:02:02 -0700
Message-ID: <20260707050204.102256-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707044906.CF30C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Jul 2026 04:49:06 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] 32-bit integer overflow in conversions between basis points (bp) and sample counts due to large number of samples per aggregation interval.
> --
> 
> --- Patch [2]: [RFC PATCH 2/6] mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/ ---
> commit 26f76c0115cf94c7177c6588b38ff64dabf63ab2
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/
> 
> This commit renames accesses_bp_to_nr_accesses() to
> damon_sample_bp_to_count() to better reflect that it converts a samples ratio
> (in basis points) to a count. It also updates the callsites and comments to
> match the new name.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index e710e2789085e..ca530faaa4f83 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -876,11 +876,11 @@ static unsigned int damon_age_for_new_attrs(unsigned int age,
> >  	return age * old_attrs->aggr_interval / new_attrs->aggr_interval;
> >  }
> >  
> > -/* convert access ratio in bp (per 10,000) to nr_accesses */
> > -static unsigned int damon_accesses_bp_to_nr_accesses(
> > -		unsigned int accesses_bp, struct damon_attrs *attrs)
> > +/* convert sample ratio in bp (per 10,000) to count */
> > +static unsigned int damon_sample_bp_to_count(
> > +		unsigned int bp, struct damon_attrs *attrs)
> >  {
> > -	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
> > +	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can the product of bp and
> damon_nr_samples_per_aggr() overflow 32 bits?
> 
> Since both bp and the return value of damon_nr_samples_per_aggr() are 32-bit
> unsigned integers, their product can exceed 32 bits if the number of samples
> per aggregation interval is large (greater than ~429,496).
> 
> For example, a 1ms sample interval and a 10-minute aggregation interval would
> result in 600,000 samples. If bp is 10,000 (100%), the multiplication
> 10,000 * 600,000 overflows 32 bits to 1,705,032,704, resulting in a truncated
> count of 170,503 instead of 600,000.
> 
> A similar overflow can occur in damon_nr_accesses_to_accesses_bp() when
> evaluating (nr_accesses % nr_samples) * 10000 inside mult_frac() for large
> nr_accesses values, falsely marking hot memory as cold.

Known low priority issue.

> 
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707043828.97900-1-sj@kernel.org?part=2


Thanks,
SJ

[...]
