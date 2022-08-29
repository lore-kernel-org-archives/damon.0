Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9034699
	for <damon@lists.linux.dev>; Mon, 29 Aug 2022 17:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0587EC43145;
	Mon, 29 Aug 2022 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661792543;
	bh=4pEZlSmJdDF1JN/EGNx6SD2ZgK0UVXZj72Ehq/Kq6Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkhAyAULGB4RzDU4hu99I6+7TSfXd8I9SkPztsg/c98fPqwc67F2XvyYDwyAjPUov
	 1bEYlyg7vaOpZda9i/hReJu95XiDpIL+OA1Vco+AzIuSDgIQ2xqE5fg9SyEMurX8Oc
	 C2N1JEGTGvUJoVZhxpS+Op8AM0EEVwHTbXxYCgfPAbFdx92Ka4k6r0PhV3i28SuRLj
	 6h8uOgF14vr7QDl65zPSiJi7e/78oKKm4Dc6IhIHFxiCAb7krhiuZ+NvGCbkkMucaF
	 xmVSp+lmsH92hOKOIEoscNcetcLmH192xHJPt/oXJLbdM+5Aj3IlHk+13bD5/kNCbh
	 V6TnoYeNBAmNg==
From: SeongJae Park <sj@kernel.org>
To: xiakaixu1987@gmail.com
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon: get the hotness from damon_hot_score() in damon_pageout_score()
Date: Mon, 29 Aug 2022 17:02:19 +0000
Message-Id: <20220829170219.51527-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1661766366-20998-1-git-send-email-kaixuxia@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kaixu,

On Mon, 29 Aug 2022 17:46:06 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> We can get the hotness value from damon_hot_score() directly in
> damon_pageout_score() function and improve the code readability.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/ops-common.c | 46 ++++++-------------------------------------
>  1 file changed, 6 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index b1335de200e7..f599838b5f64 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -88,7 +88,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
>  #define DAMON_MAX_SUBSCORE	(100)
>  #define DAMON_MAX_AGE_IN_LOG	(32)
>  
> -int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
> +int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>  			struct damos *s)
>  {
>  	unsigned int max_nr_accesses;
> @@ -127,48 +127,14 @@ int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
>  	 */
>  	hotness = hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;
>  
> -	/* Return coldness of the region */
> -	return DAMOS_MAX_SCORE - hotness;
> +	return hotness;
>  }
>  
> -int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> +int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
>  			struct damos *s)
>  {
> -	unsigned int max_nr_accesses;
> -	int freq_subscore;
> -	unsigned int age_in_sec;
> -	int age_in_log, age_subscore;
> -	unsigned int freq_weight = s->quota.weight_nr_accesses;
> -	unsigned int age_weight = s->quota.weight_age;
> -	int hotness;
> -
> -	max_nr_accesses = c->aggr_interval / c->sample_interval;
> -	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE / max_nr_accesses;
> +	int hotness = damon_hot_score(c, r, s);
>  
> -	age_in_sec = (unsigned long)r->age * c->aggr_interval / 1000000;
> -	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
> -			age_in_log++, age_in_sec >>= 1)
> -		;
> -
> -	/* If frequency is 0, higher age means it's colder */
> -	if (freq_subscore == 0)
> -		age_in_log *= -1;
> -
> -	/*
> -	 * Now age_in_log is in [-DAMON_MAX_AGE_IN_LOG, DAMON_MAX_AGE_IN_LOG].
> -	 * Scale it to be in [0, 100] and set it as age subscore.
> -	 */
> -	age_in_log += DAMON_MAX_AGE_IN_LOG;
> -	age_subscore = age_in_log * DAMON_MAX_SUBSCORE /
> -		DAMON_MAX_AGE_IN_LOG / 2;
> -
> -	hotness = (freq_weight * freq_subscore + age_weight * age_subscore);
> -	if (freq_weight + age_weight)
> -		hotness /= freq_weight + age_weight;
> -	/*
> -	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
> -	 */
> -	hotness = hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;
> -
> -	return hotness;
> +	/* Return coldness of the region */
> +	return DAMOS_MAX_SCORE - hotness;
>  }
> -- 
> 2.27.0
> 
