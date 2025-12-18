Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5578F3A
	for <damon@lists.linux.dev>; Thu, 18 Dec 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067160; cv=none; b=bvaXho1UaDUDUjG6C6YeehSB6C/lodLvwTuDaRR3mluqal2XSnz1YA1nK8bqzIWhHuEyag6X5Dn+knO1lu4vUhVOvCZeOOKTu6GgT+BL8MgMWmva0/HFW829fMUH92Cw6jCiOL/ljy5Wii147FNwgXdrIXZ9hWjH/XBdzelKxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067160; c=relaxed/simple;
	bh=fIxTC+/dKqXabJQT7QRhm1w6rs3bWUUuz2iTjdaGahk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFG5sBLZMFBA20PLQUM4gsF0Voq+nEHrXcXucd3h3vjW9TaoYXItMn+HtP4rlhVbm3fVTW9DlCbRmLCOmjG+rJBIzML3RK/IqZ9XiLgOtXFIWFk9FPcg/R4j4Yvf47TRIGpAv+Mc1co20FuIMYhMOUrfDbaNTMROS14+2FBCBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 95e66188dc1b11f0a38c85956e01ac42-20251218
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:74ad817f-e5e4-4adc-b7fb-aa51c48f489c,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:74ad817f-e5e4-4adc-b7fb-aa51c48f489c,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:9ef8ef8334ebb20d3180378691087ec4,BulkI
	D:251218221231CLVIRIFC,BulkQuantity:0,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:
	0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 95e66188dc1b11f0a38c85956e01ac42-20251218
X-User: lienze@kylinos.cn
Received: from [192.168.3.106] [(61.48.214.33)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 936259664; Thu, 18 Dec 2025 22:12:28 +0800
Message-ID: <dad50753-576b-4c4d-a805-2b7d70a46c3d@kylinos.cn>
Date: Thu, 18 Dec 2025 22:12:25 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/damon: fix typos in comments
To: klourencodev@gmail.com
Cc: linux-mm@kvack.org, SeongJae Park <sj@kernel.org>, damon@lists.linux.dev
References: <20251217224610.8814-1-klourencodev@gmail.com>
Content-Language: en-US
From: Enze Li <lienze@kylinos.cn>
In-Reply-To: <20251217224610.8814-1-klourencodev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/12/18 06:46, klourencodev@gmail.com wrote:
> From: Kevin Lourenco <klourencodev@gmail.com>
> 
> Correct minor spelling mistakes in several files under mm/damon.
> No functional changes.
> 
> Signed-off-by: Kevin Lourenco <klourencodev@gmail.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>

LGTM.

Reviewed-by: Enze Li <lienze@kylinos.cn>

> ---
>  mm/damon/core.c             | 6 +++---
>  mm/damon/lru_sort.c         | 2 +-
>  mm/damon/reclaim.c          | 2 +-
>  mm/damon/stat.c             | 2 +-
>  mm/damon/tests/core-kunit.h | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 68dd2f7acba2..da4820110e48 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -284,7 +284,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
>  }
>  
>  /**
> - * damos_filter_for_ops() - Return if the filter is ops-hndled one.
> + * damos_filter_for_ops() - Return if the filter is ops-handled one.
>   * @type:	type of the filter.
>   *
>   * Return: true if the filter of @type needs to be handled by ops layer, false
> @@ -1586,7 +1586,7 @@ static unsigned long damon_get_intervals_adaptation_bp(struct damon_ctx *c)
>  	adaptation_bp = damon_feed_loop_next_input(100000000, score_bp) /
>  		10000;
>  	/*
> -	 * adaptaion_bp ranges from 1 to 20,000.  Avoid too rapid reduction of
> +	 * adaptation_bp ranges from 1 to 20,000.  Avoid too rapid reduction of
>  	 * the intervals by rescaling [1,10,000] to [5000, 10,000].
>  	 */
>  	if (adaptation_bp <= 10000)
> @@ -2756,7 +2756,7 @@ static int kdamond_fn(void *data)
>  				 *
>  				 * Reset ->next_aggregation_sis to avoid that.
>  				 * It will anyway correctly updated after this
> -				 * if caluse.
> +				 * if clause.
>  				 */
>  				ctx->next_aggregation_sis =
>  					next_aggregation_sis;
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 49b4bc294f4e..9388b091deb7 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -34,7 +34,7 @@ static bool enabled __read_mostly;
>   *
>   * Input parameters that updated while DAMON_LRU_SORT is running are not
>   * applied by default.  Once this parameter is set as ``Y``, DAMON_LRU_SORT
> - * reads values of parametrs except ``enabled`` again.  Once the re-reading is
> + * reads values of parameters except ``enabled`` again.  Once the re-reading is
>   * done, this parameter is set as ``N``.  If invalid parameters are found while
>   * the re-reading, DAMON_LRU_SORT will be disabled.
>   */
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 36a582e09eae..8463a5a5032f 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -34,7 +34,7 @@ static bool enabled __read_mostly;
>   *
>   * Input parameters that updated while DAMON_RECLAIM is running are not applied
>   * by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
> - * of parametrs except ``enabled`` again.  Once the re-reading is done, this
> + * of parameters except ``enabled`` again.  Once the re-reading is done, this
>   * parameter is set as ``N``.  If invalid parameters are found while the
>   * re-reading, DAMON_RECLAIM will be disabled.
>   */
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index ef0a1195a584..5e18b164f6d8 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Shows data access monitoring resutls in simple metrics.
> + * Shows data access monitoring results in simple metrics.
>   */
>  
>  #define pr_fmt(fmt) "damon-stat: " fmt
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 8cb369b63e08..f59ae7ee19a0 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1159,7 +1159,7 @@ static void damon_test_set_filters_default_reject(struct kunit *test)
>  	damos_set_filters_default_reject(&scheme);
>  	/*
>  	 * A core-handled allow-filter is installed.
> -	 * Rejct by default on core layer filtering stage due to the last
> +	 * Reject by default on core layer filtering stage due to the last
>  	 * core-layer-filter's behavior.
>  	 * Allow by default on ops layer filtering stage due to the absence of
>  	 * ops layer filters.

