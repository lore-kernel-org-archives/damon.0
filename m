Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED18287E;
	Fri, 16 Oct 2026 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110098; cv=none; b=Lokmpi5w0W0F1+4RGj1cOpeQmjwBzjKWhGUoBTGiIrM2TdK8cxTmLR9jmqAJxEuUKEz/aL3YYvTnmWFZmWeIiyOVgxTwL1vyNUtolwFVE2WscspQfNV3JAv+WK40B8V+N17svSGkp1DX1gpopYSKI+E7NSh6GtGhR7O7nfFDB58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110098; c=relaxed/simple;
	bh=AT4W4aPjmvY5Us9MyMhpYvy1JXXgQHfzYXWptPl3uSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jryAiGcwxfShMRlg0spM1TtkD5P5KyogL233EMs70XSIr/KsavmEiqCgUlbS96fOS16K9wB7zx5kq1HozWQcP2z3N3ya3VeWXCYXvq2jCDIQTD46F3sWa85g2SXaRdnxXg11yC9y1Hf07nAyO1qrkD5PfIZrh406l5dfWq+G2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOf9YA9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOf9YA9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B2C1F000C5;
	Fri, 16 Oct 2026 00:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110097;
	bh=9N4EN6ZvO3a8sKtIt1Gi15YCcaB7qMrfMy0PcLy9QgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eOf9YA9nhtK2H+psZ+z21uyPW8H2c8MJseLVkbscqczuYzGIWACbY7HHHKSrpn6F7
	 k3NysYP9IIPV5MJ4Ig2ytACBT8lSMnaeVx52RxK4fz28xyKrOG9fivE5i91gmmIu+l
	 fi0gbNz5bimbzZwojC+Tf5y1PTZ7slGz25YTd2YS0dI7yWNi4Vgvv75f2fUQhdwGWc
	 j+N7h6qpFQ5kNIsHYRb+kJx/ROqZe1Fu0Xg+WNL0V+DyewIuiukcU+sqbi5kndyP9L
	 p5wfFiFcFAMhEaiNU5TNzQ7MdzA70IHm8Qwoicg3KGlMfewyj+SgOC0n5ZDrbeWgc8
	 6DYuAuzhTODyA==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid 32-bit overflow in idle percentiles
Date: Thu, 15 Oct 2026 17:21:29 -0700
Message-ID: <20261016002130.113813-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179207592479.3.11595453180868898703@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Aveline,


This patch is sent as a followup of your previous bug report, right?  Unless it
is very urgent, please make sure the previous discussion is completed before
making a followup action like sending this patch.  As a rule of thumb for
DAMON, I'd suggest waiting for ~10 hours after the last comment on the thread.

On Thu, 15 Oct 2026 22:52:04 +0800 Aveline Noir <jm5905938@gmail.com> wrote:

> On 32-bit, accounted_bytes * 100 can wrap before division by total_sz.
> Some entries in memory_idle_ms_percentiles then keep their old values
> instead of being updated.
> 
> For example, a 256 MiB i386 QEMU guest reported p0=19200 ms, but p50 and
> p100 were both zero.
> 
> Cast accounted_bytes to u64 before multiplying and use div64_ul() for
> the division. Compute the percentage once per region.
> 
> Link: https://lore.kernel.org/r/CANOyQmHad1vamnZT12M5yPrJ69==Pt1U0+MGw6u0MuNtr-DRCw@mail.gmail.com
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> ---
> This is against mm-new ad9f2d463666. With the fix, the original test
> reports p0=p50=p100=19200 ms. The i386 kernel build, x86_64 W=1 stat.o
> build and external arithmetic checks passed.
> 
> I also ran 38 before/after VM tests and 20 same-image controls. Throughput

What is 38?

> was close overall, but median kdamond CPU rose by 0.0053 and 0.0221
> percentage points of one guest CPU for stream and sparse, respectively.
> Some pairs had 5.91% lower throughput or 15.49% higher scan P99. So I can't
> yet tell whether these differences come from the patch.

Do you have a plan to run more tests to be able to tell that?

> 
> 
>  mm/damon/stat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index b05b68f73e10..eccd372810d0 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -114,7 +114,7 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
>  {
>  	struct damon_region **sorted_regions, *region;
>  	int nr_regions;
> -	unsigned long total_sz, accounted_bytes = 0;
> +	unsigned long total_sz, accounted_bytes = 0, percentile;
>  	int err, i, next_percentile = 0;
>  
>  	err = damon_stat_sort_regions(c, &sorted_regions, &nr_regions,
> @@ -124,7 +124,8 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
>  	for (i = 0; i < nr_regions; i++) {
>  		region = sorted_regions[i];
>  		accounted_bytes += region->ar.end - region->ar.start;
> -		while (next_percentile <= accounted_bytes * 100 / total_sz)
> +		percentile = div64_ul((u64)accounted_bytes * 100, total_sz);
> +		while (next_percentile <= percentile)

Any reason to use div64_ul() instead of div_u64()?


Thanks,
SJ

[...]
