Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B038331C
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202198; cv=none; b=urnwpoXluI5ZJ/fnIuGYIKQHJzS0kx5yWe5u6V6zJBtxjeO5iGdRXRakKsuFSajF76DLrqTnO18old7GOyKwhcg10Si+cVli9HwkEZa6s7svOyGGu0FUNnFX0/7SAiXvgRb/9DQPfECp/PpAGA5qqoKH0VOAEf0hhxVdWOlJn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202198; c=relaxed/simple;
	bh=eYt3TwTju8i6TNd4aIXWcpkQYwxBQfcdtJ1cV06wEAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RrgA6F3sQeZSPvWauQDJpAIypbee1JI2jpyJMSM1fjlb/SLNiEhrvqbVDXB8/MQG/dAI0ePpeR+cAU9FMMR9c+0nrzCeOl0J47KayGyVDwItszYvjT4XOe2CuSSfecGdxw+IDfvarw4y5ijxn949f/bV+rZZ8zoGmfU2COVesbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps5fU4nU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps5fU4nU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA321F000E9;
	Mon, 31 Aug 2026 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788202196;
	bh=mySa4KmYTwZQy38WkIlm81EFzkiaLTSS5SafWxTEk3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ps5fU4nUAG5FFcoTJ7c/fmIbaRLavsQTr+GsXGGCy/uSP6Z5Q+a2lxP3Yr5bTIJVq
	 KiRGt/98/wFW67pQz1W9yD/tVQtp/wCHM7A3/hSRXDqajdRkayyj+AGUdYTUSxgblw
	 rDWvSSd7KODBHErXwZU1EldzP356oZmb/ROjBohgOnZ1NFywA4gtMHLwqXfh4zSMmO
	 jchocREQ7gEE69LnBjwS5PndCaPcTwF1G6x7xIojMPo4sh/FLH+GeVcfA04eHL19ou
	 eB4CJdg46NcOXyfb0BvdDexcb6zq8JodSzWhLYt1qtjMZxFpjpHa5lPChetLrmT/A4
	 mpjM6HcDzgM7A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 8/8] mm/damon/core: handle extreme memory state
 in get_in_active_mem_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831140254.72004-9-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
 <20260831140254.72004-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:49:55 +0000
Message-Id: <20260831184956.1DA321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silent integer overflow on 32-bit systems in mult_frac() usage acr=
oss DAMON quota metrics, leading to drastically incorrect memory metrics.
--

commit ba2ca9efc083502fb5555a81a42e9de1ab623b4d
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle extreme memory state in get_in_active_mem_bp()

damos_get_in_active_mem_bp() uses the sum of the active and inactive
memory amount as a denominator.  In an extreme and unlikely environment,
active and inactive memory might be zero.  In this case, hence, it
results in a divide by zero problem.  Avoid it by changing the
denominator to one if it is zero, before it is being used.

Link: https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3779a04753061..f8dddbff74a77 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3015,7 +3015,7 @@ static unsigned int damos_get_in_active_mem_bp(bool=
 active_ratio)
>  		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
>  	inactive =3D global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
>  		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
> -	total =3D active + inactive;
> +	total =3D max(active + inactive, 1);
>  	if (active_ratio)
>  		return mult_frac(active, 10000, total);

[Severity: High]
This isn't a bug introduced by this patch, but does the use of mult_frac()
here cause a silent integer overflow on 32-bit systems?

The mult_frac(x, n, d) macro calculates (x / d) * n + (x % d) * n / d. On
32-bit architectures, intermediate multiplications like (x % d) * n are
evaluated as 32-bit unsigned integers if x is an unsigned long. This
silently overflows if the result exceeds ~4.29 billion.

For example, in damos_get_in_active_mem_bp(), active is counted in pages.
If active memory reaches roughly 429,496 pages (about 1.7 GB),
429,496 * 10,000 exceeds the 32-bit maximum of 4,294,967,295 and wraps
around, resulting in drastically incorrect memory metrics.

This same unsigned long overflow seems to be pre-existing in other DAMON
quota metrics in mm/damon/core.c as well:

- damos_get_node_mem_bp(): same issue with node memory.
- damos_get_node_eligible_mem_bp(): node_eligible is cast to unsigned
  long bytes, which can overflow if eligible memory exceeds ~419 KB.
- damos_set_effective_quota(): total_charged_sz is in bytes, which
  overflows when multiplied by 1,000,000 if it exceeds 4294 bytes.
- damos_quota_score(): goal->current_value tracks PSI in microseconds,
  which can easily be millions, overflowing when multiplied by 10,000.

Could these calculations be performed using 64-bit math on 32-bit systems
to prevent runaway aggressive memory reclaim or total failure to reclaim?

>  	return mult_frac(inactive, 10000, total);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831140254.7200=
4-1-sj@kernel.org?part=3D8
