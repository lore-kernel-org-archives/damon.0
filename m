Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A846AF2A
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200194; cv=none; b=BPPZTtVNEGGTDJsIBGGt1OQKoy/qakuExoihtZ1Bsa+uJO8dXTGYjX2Mafx1WeDklyJabrs5pHfHFO6TXX5PvpIx7tHWHsJJAU6Cu1Z5uwO7jWY+PzY9Sd46iKrJYtMlHSuduHa64ptuPKZqw83576geIZjrENiarV2C9DoRCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200194; c=relaxed/simple;
	bh=r/igl+Vy7pnOVLvzep3jEW051mIyvtDAvqFUY5Is/Ik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NaJB8TokO3iPEF8fledBjjDI9pkYaun36nBnKISPPpMeolhztatskqH9j9O4TAuZhgRG1YY/F/+d0IKqTRS4kY62cisEYI+C4fZsnbpwpwqzl+qw7W1SPi8qBAviax5cj4/8C1opvSpvfkJd+X42LE7Vbqb4KXvXgbkVnF7XT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAjL5nvJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAjL5nvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CD81F000E9;
	Mon, 31 Aug 2026 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200192;
	bh=gOLKwx5xyD7r9Ltfoa5XXNxTGMqzVFM3vHeNg3/OnTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UAjL5nvJ2oXUyrYK+BaV1ZiGRgUqwRFfC8DdrE++EMz7Wr47G/JwaN5H/fN+j2UkP
	 e39CEZnGslMG1dEC7/pNFRLwdwDUEl9z31/eKLmr7wA3PdoAtKtTXi7hQQmCWDX1ER
	 l88UQKVlWMhvEwdpsTRRmCDfE3S/6C7+hMfbhKL9KBLc2gyD6Nccs+MvZeGrdCG3i+
	 pWx1soXBk/CLy0pwtCeMscH4uv3RgYiLVVqkD0E1EGYYOm7EtbIH8HHzckx5YIvRbv
	 E9MbIQtp2EZHTeYZyS6EPFpoj/uQmYQM208H6eiJ0bwTcc3PYiVua/ptgph0yNMdl2
	 0TrlamzcUy1xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto
 tuning
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831144732.80910-2-sj@kernel.org>
References: <20260831144732.80910-1-sj@kernel.org>
 <20260831144732.80910-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:16:31 +0000
Message-Id: <20260831181632.73CD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unbounded metric calculation due to vmstat drift can destabilize q=
uota tuning.
- [High] Silent 32-bit integer overflow in `mult_frac()` during memory rati=
o calculation.
--

commit 59f2c739bce03363ce501965d6708d807908af18
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Date:   Mon Aug 31 14:47:28 2026 +0000

mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

This commit introduces a new DAMOS quota goal metric,
DAMOS_QUOTA_HUGEPAGE_MEM_BP, to auto-tune quotas based on the ratio of huge
page consumption to total memory consumption. It includes a fallback
mechanism for situations where vmstat counters drift and report more free
pages than total RAM.

Link: https://lore.kernel.org/all/20260715151615.99767-1-sj@kernel.org/

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..9c0e42a1d2cfc 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3007,6 +3007,22 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);
>  }
> =20
> +static unsigned int damos_hugepage_mem_bp(void)
> +{
> +	unsigned long thp, total_pages, free_pages;
> +
> +	total_pages =3D totalram_pages();
> +	free_pages =3D global_zone_page_state(NR_FREE_PAGES);
> +
> +	if (total_pages <=3D free_pages)
> +		return 10000;
> +
> +	thp =3D global_node_page_state(NR_ANON_THPS) +
> +				global_node_page_state(NR_SHMEM_THPS) +
> +				global_node_page_state(NR_FILE_THPS);
> +	return mult_frac(thp, 10000, total_pages - free_pages);

[Severity: High]
Could the independent vmstat counters drift enough to produce an
out-of-bounds ratio here?

Because NR_ANON_THPS, NR_SHMEM_THPS, NR_FILE_THPS, and NR_FREE_PAGES are
updated asynchronously across CPUs, they can drift in opposite directions.
On systems with high core counts, if the system's actual used memory is
low but the thp stat artificially drifts higher than the calculated used
memory (or used memory drifts toward zero), the calculated ratio could
vastly exceed 10,000 (100%).

Would this cause the DAMOS auto-tuning PID controller to calculate an
exponentially inflated goal score, ultimately crushing the tuning quota to
zero and paralyzing DAMON's actions?

[Severity: High]
Can this calculation silently overflow on 32-bit architectures?

The mult_frac macro evaluates an intermediate multiplication that retains
the 32-bit type of x. Both thp and total_pages are declared as unsigned
long.

On 32-bit architectures like ARM32 with LPAE (which supports Transparent
Hugepages and up to 1TB RAM), unsigned long is 32 bits. If THP consumption
exceeds 429,496 base pages (around 1.71 GB), the intermediate calculation
(thp * 10000) will wrap around U32_MAX.

For example, 2GB of THP on a 3GB system might falsely report a 9.4% ratio
instead of 66.6%. Will this cause DAMON to mis-tune memory limits due to a
highly truncated quota goal metric?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144732.8091=
0-1-sj@kernel.org?part=3D1
