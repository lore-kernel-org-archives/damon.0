Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BFA1B414E;
	Mon, 25 Nov 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560192; cv=none; b=jsPlsgKgnVLTBu9UpiIF0HYdOnqxmdrcsQM+N6GJtrGaI0tSPD+Y1vvk8RN6ySjMzxY4ZD+bJ7UKJyl2FcQ1wu4JdTJZvTXYgsRTV/TqgMEKMbDS6vBItfl6e1kuxHuJcuDueYQoK3ua5SKLc2HMRXStkcvFVyx6bereFYl2ZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560192; c=relaxed/simple;
	bh=exBysk/gwG+hJSt0eY9Rdc6fApKmU2lD8WQSb+dR+9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m1NyHozQ2WiF/P2hE5gsgrxkn80hqB3XNUaeaUcqtMygaO4B2oVTM2bgSqEfCpwOsF6+pljhvspkpqIk0yCdmv/QcccS/Y+gfEEE1c14PUMBLELO1+vNmuiF9uQw99wTjnVXX/765jX7JI+vE4KrlYWp/wTKSEqcpPDgQnD4EwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deyYo0yM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deyYo0yM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B31FC4CECE;
	Mon, 25 Nov 2024 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732560192;
	bh=exBysk/gwG+hJSt0eY9Rdc6fApKmU2lD8WQSb+dR+9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deyYo0yMxuvwrFzZOiyuZARsOKyFCsTQYjplknyvIfrhW/Q516c9TmvqsjJfTciSb
	 /Q+1FT+lmTc0mc/iDc+nOIoFBnqexBJA9qU8QhHyEp++vEAKYcCyEOoLP9b6IqUOfo
	 Et9PG1i5CXrKc6rWRHXg7USs3wkBOqPeFLMCRT2CtWFlk/MPgt5yHQZE1/QBNCfZMt
	 GyIxJbMCMDihrqk3EDe0BWm3zPJLejfAoc6Odr/ret8YtG5gO75/CdfBDADdAJbvQg
	 mHol8NPejh4MhYJBhvDWZEh0d3skarT3qDWmU7yHSi4tdwa0Uo98jKQzutVH4wSHGc
	 1uWmEkIteWWOQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel_team@skhynix.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: remove duplicate list_empty quota->goals check
Date: Mon, 25 Nov 2024 10:43:07 -0800
Message-Id: <20241125184307.41746-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125045655.1452-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 Nov 2024 13:56:55 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> The damos_set_effective_quota checks quota contidions but there are some
> duplicate checks for quota->goals inside.
> 
> This patch reduces one of if statement to simplify the esz calculation
> logic by setting esz as ULONG_MAX by default.
> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 511c3f61ab44..ecaf78270035 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1542,7 +1542,7 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
>  static void damos_set_effective_quota(struct damos_quota *quota)
>  {
>  	unsigned long throughput;
> -	unsigned long esz;
> +	unsigned long esz = ULONG_MAX;
>  
>  	if (!quota->ms && list_empty(&quota->goals)) {
>  		quota->esz = quota->sz;
> @@ -1564,10 +1564,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
>  				quota->total_charged_ns;
>  		else
>  			throughput = PAGE_SIZE * 1024;
> -		if (!list_empty(&quota->goals))
> -			esz = min(throughput * quota->ms, esz);
> -		else
> -			esz = throughput * quota->ms;
> +		esz = min(throughput * quota->ms, esz);
>  	}
>  
>  	if (quota->sz && quota->sz < esz)
> 
> base-commit: adc218676eef25575469234709c2d87185ca223a
> -- 
> 2.34.1

Thank you for addressing my comments on the v1
(https://lore.kernel.org/20241122081834.1344-1-honggyu.kim@sk.com), namely
- making commit message more specific, and
- using ULONG_MAX instead of UINT_MAX for esz default value.


Thanks,
SJ
