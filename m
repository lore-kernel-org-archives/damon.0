Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3402459F7
	for <damon@lists.linux.dev>; Wed,  3 Dec 2025 04:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764736067; cv=none; b=dD1yGCIvfPb4OVlyuNYr1J1G65meKJCGFzwGoWTXk/yyywrYSm/55KRD1CreZgFiz9pwBGe8DN4XJfOpJ5xUh22gETCppMQjjyOACbCh43+ff1+nylD+rnE/licJq/35XiY/rUHI1t5T+abvgrQAZsikCR9qC78tEYoiiYCqJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764736067; c=relaxed/simple;
	bh=tPlfzQ7ySw2YU91N1d0A6LgeE5AkyUSUmsZCqgfFqsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfAL/oPHaBF7Y+f85MFQIIpqey/k/tDVCjNPqr3UqfrWNInCjGWpQCrhMQLEJeG6qvdqp6fjIfihKdmhM8aXcngaUTWgPaeUgRZ0UV6v3DvvMILvLBdvvfenQnuoUeaP0h0Kh3w1IW/8sFAJahNgDhJ9D6D+XhGs/hBcuFx1VB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1coB1wn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1coB1wn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B92C4CEFB;
	Wed,  3 Dec 2025 04:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764736066;
	bh=tPlfzQ7ySw2YU91N1d0A6LgeE5AkyUSUmsZCqgfFqsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1coB1wnikJJ76puWnf4JrHWVFoeydnfcimJxjAX4L8p6D9gihk5hBHWgav02o+jc
	 /2fSgBF6P47IibKcBCeAocTndDmW3viLdOvudKgbzGC4ID6V27pkXp0r2JxPL4Eqfe
	 mnWIbcLSiYhvxTwek5wRCqSizcS2sOWLfY/mpavUvK9+DTql6gED9HQddzk61RuhOU
	 cZQFvo8R8FaMx5dgkn3/i1bb2iHf4aUEXOS3WWHofzZfDQS55KxY7EiBhiDcAbP1Na
	 BYxz1l3h6YSUJ5Te016O61UTLf45dEwGW0a2SG6s2+CVLWoqACiVKpo0kz17zdkp76
	 fcUK5ITxg75ew==
From: SeongJae Park <sj@kernel.org>
To: Jung-JaeJoon <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	rgbi3307@naver.com,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon: Remove duplicate attrs.intervals_goal at the damon_stat_build_ctx()
Date: Tue,  2 Dec 2025 20:27:38 -0800
Message-ID: <20251203042738.47206-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203033350.14629-1-rgbi3307@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ damon@lists.linux.dev

Please Cc damon@lists.linux.dev for DAMON patches from next time.

On Wed,  3 Dec 2025 12:33:48 +0900 Jung-JaeJoon <rgbi3307@gmail.com> wrote:

> The damon_stat_build_ctx() function sets the values
> of attrs.intervals_goal structure members.
> These values are applied to damon_ctx in damon_set_attrs().
> However, It is resetting the values that were already applied previously
> to the same values.
> I suggest removing this code as it constitutes duplicate execution.

Thank you for finding and fixing this!

> Please check the modified code below:

The above sentence is not needed for normal patch descriptions.  Please drop
it.

Also, I think the subject could be better describe this change, e.g.,

mm/damon/stat: deduplicate intervals_goal setup in damon_stat_build_ctx()

Could you please make the above suggested changes to this patch and resend the
modified version as v2?

> 
> Signed-off-by: Jung-JaeJoon <rgbi3307@gmail.com>

If you agree to my above trivial suggestions and make the requested changes,
please feel free to add below on the v2 patch.

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/stat.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index bf8626859902..51dd29685915 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -173,14 +173,6 @@ static struct damon_ctx *damon_stat_build_ctx(void)
>  	if (damon_set_attrs(ctx, &attrs))
>  		goto free_out;
>  
> -	/*
> -	 * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
> -	 * accesses ratio, keeping sampling interval in [5ms, 10s] range.
> -	 */
> -	ctx->attrs.intervals_goal = (struct damon_intervals_goal) {
> -		.access_bp = 400, .aggrs = 3,
> -		.min_sample_us = 5000, .max_sample_us = 10000000,
> -	};
>  	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
>  		goto free_out;
>  
> -- 
> 2.43.0


Thanks,
SJ

[...]
