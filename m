Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE3288C30
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783286032; cv=none; b=O06FvByqUqxrpIhuf7Ak2M9DPJqRm8+SmP501bdGVZMivGpQ2twcfI3uK7/SQGFwshbnbJS3n3Uhu7/kuz/DCUcZpFEKvjgZrNXrj1FQYV6T4qTaV/LMETXZpSJioGTgFfYhHgDoSmQ3z9TizOnK6uEI4v5agVHj1NOr2hzd9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783286032; c=relaxed/simple;
	bh=r+HVxTqKRdffX0R1s+FFTnkcdCaCLxb64DDbXBGh1aY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WCcJjTqHEuPbP/3hSuhVBGIapQRX5MhiHgvfDJ4gOrRWHRgyfsBmZo4fsjwA1PFhtE7HUhNXMrdLohmLxkafmTsNKspHjKtRD5DzvHvaHJmlS7sJbZlEIGrJol4OP3Q9ycLuTgEjFduN6olbpNYh6Sj5WpLqCkrL9uSkoklFsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAZnIjqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAZnIjqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD861F000E9;
	Sun,  5 Jul 2026 21:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783286031;
	bh=kAgs86f86uHX28Lo5Cfrs7Ovl2JUhesw1cQkL5baMfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HAZnIjqNnwXQQKxdsxvkJHKrdL9vRQ8Kj1M0YaHARw7IfYxIO+i28XiqChgyQSkfz
	 JlmY+bQROKvknYvApuGbJKBntwH2CU/LXbwxxeB1eJNhmdZSbt+mfnkMBFfhGqVW9b
	 lTv/pBYKSNPasxnZIiq61Dvt9awqtSpsabG+dF8s3/nL8fksedciCq7iQ/lRqPvtBQ
	 ufe1R6sYftzuap7wKejhB8IjEtA5KduAocDpaCJ5frssmeE06AyxtVWRP8S0dgvhA3
	 S9MmRiPCpULUEW7V0PR1WB4t1BVgKLAK3hq9Uxxj8smPsB7fJHk+y5TId3yFnfcaaM
	 zqz6W2O7FJEPQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/16] mm/damon/core: implement
 damon_probe_hits_wsum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705205743.98656-6-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
 <20260705205743.98656-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:13:50 +0000
Message-Id: <20260705211351.3FD861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The calculation of the weighted sum in `damon_probe_hits_wsum()`=
 can overflow the 32-bit `unsigned int` datatype.
--

commit fa25d0914791f2e39d32d91b9baaf69eaeb0a208
Author: SJ Park <sj@kernel.org>

mm/damon/core: implement damon_probe_hits_wsum()

This commit introduces a new function damon_probe_hits_wsum() to calculate
the weighted sum of probe hits for a given region. This weighted sum is
intended to be used by both users and internal DAMON logic like region
merging.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ec6b099bd8790..c370eaff5795d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -390,6 +390,30 @@ static bool damon_is_last_region(struct damon_region=
 *r,
>  	return list_is_last(&r->list, &t->regions_list);
>  }
> =20
> +/**
> + * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
> + * @r:		region to get the weigted sum of.
> + * @last:	if the request is for last-window agggregated probe hits.
> + * @ctx:	context of &r.
> + *
> + * Return: the weighted sum of probe hits of the region.
> + */
> +unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
> +		struct damon_ctx *ctx)
> +{
> +	struct damon_probe *probe;
> +	unsigned int sum =3D 0;
> +	int i =3D 0;
> +
> +	damon_for_each_probe(probe, ctx) {
> +		if (last)
> +			sum +=3D r->last_probe_hits[i++] * probe->weight;
> +		else
> +			sum +=3D r->probe_hits[i++] * probe->weight;

[Severity: Medium]
Can this calculation overflow the 32-bit unsigned integer?

Since sum and probe->weight are both typed as unsigned int, if a
sufficiently large probe weight (for example, larger than 16,843,000) is
configured via sysfs, this multiplication and accumulation might wrap aroun=
d.

If the score wraps around to an artificially low value, would this cause
DAMON's region merging logic to behave incorrectly due to unexpected
thresholds?

> +	}
> +	return sum;
> +}
> +
>  /*
>   * Check whether a region is intersecting an address range
>   *

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705205743.9865=
6-1-sj@kernel.org?part=3D5
