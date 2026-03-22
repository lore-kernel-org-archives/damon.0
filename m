Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772B264617;
	Sun, 22 Mar 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215024; cv=none; b=d/qVM3ISgX4EiBQjqntH4slNYSyB+phq46bzPiVwnzQg+fJUOwrAHNs7a/qJ1gz2zCpp/7xPdpGwcczVsWCWK/Phnu+PjPbTGposPkOm8wJgY+/ncCpTgiTY91oYRnfowi9ZAqmJ7m6r3WQdqlDkZ547uQSFNcBOaRkQ2ew/5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215024; c=relaxed/simple;
	bh=PTlhhQzw40J9uUqv3p0SdVsqS3y8OudgMfIgsbJNjG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok8os7Sg7h+Vwh7+H/N2QOqtM6xOrFDz27ntxvKC6XRT5MdjKNSzHwChnYwK/PjOeGB4AvE6U7+yyvhaRIsP8Cv3D4OkI9q8izLySPfjI71A3kS3jBKmRjO3pYSyCJlBj5cfTRP/60NhUIoROJdfwb4JfzQb0yaLHYlEnbr+zbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9Hcaiwg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9Hcaiwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34D8C19424;
	Sun, 22 Mar 2026 21:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774215024;
	bh=PTlhhQzw40J9uUqv3p0SdVsqS3y8OudgMfIgsbJNjG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9HcaiwgB8MPr5UR1dgiijiNs3I15Ty0podWkwwY8tMX1PP/G2F+OvXXl2BYTkMQA
	 uvlMZKIDFVNG720KfYXuL7Nn9D5Sgty879SIN4iHD/KW0e0zbzsTh1i/lzrpJXHIbc
	 3/wYW1NZ8a21M7k3Pc6J3rYNewBc7jDwmpAe3F4R/4TDBwQESWYMfOrpyA/QkRUoYy
	 /Aoj+836eszpmRXsTadmZEKKTFMQ7VPPfpK3/imVDZHq2rDNLWU/KBxIVywSKngI7a
	 YV8cKCgrZ8bfx7FZIaT7NF/zvvEb/zHkDHtpu2GPw+6/b22+aKeMeW7Id/KAlSt/XJ
	 qzw0byazU3WRQ==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Sun, 22 Mar 2026 14:30:15 -0700
Message-ID: <20260322213015.89161-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322184641.251966-3-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 18:46:41 +0000 Josh Law <objecting@objecting.org> wrote:

> Hardware integer division is slow. The function damon_max_nr_accesses(),
> which is called very frequently (e.g., once per region per sample
> interval inside damon_update_region_access_rate), performs an integer
> division: attrs->aggr_interval / attrs->sample_interval.
> 
> However, the struct damon_attrs already caches this exact ratio in the
> internal field aggr_samples (since earlier commits). We can eliminate
> the hardware division in the hot path by simply returning aggr_samples.
> 
> This significantly reduces the CPU cycle overhead of updating the access
> rates for thousands of regions.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  include/linux/damon.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6bd71546f7b2..fffdb08326a2 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -960,8 +960,7 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
>  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
>  {
>  	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> -	return min(attrs->aggr_interval / attrs->sample_interval,
> -			(unsigned long)UINT_MAX);
> +	return min(attrs->aggr_samples, (unsigned long)UINT_MAX);

checkpatch gives below warning:

WARNING: min() should probably be min_t(unsigned long, attrs->aggr_samples, UINT_MAX)
#39: FILE: include/linux/damon.h:963:
+       return min(attrs->aggr_samples, (unsigned long)UINT_MAX);

Can we use min_t() as suggested?

Otherwise, this patch looks good to me.


Thanks,
SJ

[...]
