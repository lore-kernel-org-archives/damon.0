Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560431;
	b=FdTBhGCYDNHVeBZ4MOIUXDeH7zfjlCXs/KS0KBBthveyxQPkgM6TXrCUxv3CD4inMmLY
	 O6J3bc2edeKYYwYKgdwspa9CYAa13NOJnvdRTvgD/IaqzBhIC3/1IHww+1R6Sw6lvueLj
	 RYch1+ve9EcP1eZgaAFP8tZ33322APhlNr8+0lbgCT5IijJxrhnP1xd8xucbDfF5sTRkj
	 +vDj+2UETbQDvout3U5SIhC/CLxh3DI0KzynnSBbml8VF58NeBEFEQq2BvF/Hgb1MXEjt
	 kPqM4hp8l74nTk/cMUK0nlYeDzUybsY5TDlTRiQ9ZpTtGVi6T5IqeAdp4MPmkl1v7/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7S6qxSAluU5AdwDGWk4KFzyP5dBcL1YEzQEDbpdNMCo=;
	b=xOAlnsrPSIi3Fk1j9atr+8X5DlGsg6KGyZS3SF3kt9z/2G53N6C1PDE5WvdGGEUkVY4N
	 k7gEZQASCRadzfrC+i41C7yW6JBSKSntikxwZh5BNuHui3U4W/tCmCOnEMwp5D1DK0ERx
	 g6YVFFwMceshc1g7OaX2EW91ZTtkS9NJ9YDEVA/auSR91uxVIjP7JDYuVx88hILwg5rLR
	 /VvF9DkjiQafJHS0H/iV3gB0NkTeJWTCzXfadqs8h5gXIVolYMS139tou6QqtYrd7G/8/
	 UGz2TXahjhL3ESS+PSDJRzutPEeG4bfAnQsrVTz5AfYJYeEiHRumzoBAJILA7SScT+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9orr59w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B412606A324;
	Sun,  1 Nov 2026 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9orr59w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73061F000C1;
	Sun,  1 Nov 2026 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793560431;
	bh=7S6qxSAluU5AdwDGWk4KFzyP5dBcL1YEzQEDbpdNMCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J9orr59wDCUxwTVoMXio+VZBFQqFXKqHct9qyTpQX6AYK/aEi3wlWAxRJBT9bbsXV
	 6OKkw1BaGmeNdzruw8FpzJ2nH5WG2lANAchqxlO7c/eXUHh+h7vdXM8XdWdN48ehGP
	 xpERGMWHbF3etUfiIfbY6RKViVcKjL5oI32mIOTZ4c0CctH3j+jQ68bIlFwCDsf6dV
	 5ksod5lN/+lhd2xVF7Xo26Cxz2vGQcF6X4qz4lUwaO74N29SCOavE/kCOCHJoJdHnr
	 A7fD0qR+jzmV+VuDv70p1epw1+s7AjNLDHpvXu83VWyMWI4dpwsm5ssrk2MamC4Llj
	 l6msJQyclhn5g==
From: SJ Park <sj@kernel.org>
To: Wang Guangke <gkwang@linx-info.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid overflow in estimated_memory_bandwidth calculation
Date: Sun,  1 Nov 2026 11:13:43 -0800
Message-ID: <20261101191344.85683-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101180001.167198-1-gkwang@linx-info.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Wang,

On Mon,  2 Nov 2026 02:00:01 +0800 Wang Guangke <gkwang@linx-info.com> wrote:

> The calculation of estimated_memory_bandwidth computes
> access_bytes * USEC_PER_MSEC * MSEC_PER_SEC / aggr_interval directly.
> On 32-bit systems, the intermediate product
> access_bytes * USEC_PER_MSEC * MSEC_PER_SEC may overflow before the
> division is performed.

Do you find this issue from real usage?  Or, jsut theoretical?  Could you
please clarify it, and user impacts of the issue?

> 
> Fix it by splitting the division into quotient and remainder,
> multiplying each part separately.

Thank you for this patch.

> 
> Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated
> memory bandwidth")

Please do not wrap Fixes: tag line.

Could you clarify why you do not Cc stable@?

> 
> Signed-off-by: Wang Guangke <gkwang@linx-info.com>
> ---
>  mm/damon/stat.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index b05b68f73e10..7cfa3a8d6801 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -32,8 +32,8 @@ static bool enabled __read_mostly = IS_ENABLED(
>  module_param_cb(enabled, &enabled_param_ops, NULL, 0600);
>  MODULE_PARM_DESC(enabled, "Enable of disable DAMON_STAT");
>  
> -static unsigned long estimated_memory_bandwidth __read_mostly;
> -module_param(estimated_memory_bandwidth, ulong, 0400);
> +static u64 estimated_memory_bandwidth __read_mostly;
> +module_param(estimated_memory_bandwidth, ullong, 0400);
>  MODULE_PARM_DESC(estimated_memory_bandwidth,
>  		"Estimated memory bandwidth usage in bytes per second");
>  
> @@ -55,15 +55,20 @@ static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r;
> -	unsigned long access_bytes = 0;
> +	u64 access_bytes = 0;
> +	u64 remainder, bytes_per_interval;
>  
>  	damon_for_each_target(t, c) {
>  		damon_for_each_region(r, t)
> -			access_bytes += (r->ar.end - r->ar.start) *
> +			access_bytes += (u64)(r->ar.end - r->ar.start) *
>  				r->nr_accesses;
>  	}
> -	estimated_memory_bandwidth = access_bytes * USEC_PER_MSEC *
> -		MSEC_PER_SEC / c->attrs.aggr_interval;
> +	bytes_per_interval = div64_u64_rem(access_bytes,
> +			c->attrs.aggr_interval, &remainder);

This is not bytes per interval but bytes per microsecond.  Let's rename the
variable to bytes_per_us.

> +	estimated_memory_bandwidth =
> +		bytes_per_interval * USEC_PER_MSEC * MSEC_PER_SEC +
> +		div64_u64(remainder * USEC_PER_MSEC * MSEC_PER_SEC,
> +				c->attrs.aggr_interval);

Let's use USEC_PER_SEC instead of 'USEC_PER_MSEC * MSEC_PER_SEC'.

>  }
>  
>  static int damon_stat_idletime(const struct damon_region *r)
> -- 
> 2.47.3
> 
> 


Thanks,
SJ
