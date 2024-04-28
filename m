Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401D79EA
	for <damon@lists.linux.dev>; Sun, 28 Apr 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714330640; cv=none; b=OYS2i+gAbMNAWbQKtVlNO401kYm+h/IsjFzTSbtvWJ/d1EYNVnSzaYoCmXon9jGbeBOWUG6MdIbUW+gXpIyiaCRA2pTmdE8wqjv7KhY3ZqxsVwsatOM7yH0owhTJDWlpmNIdB6Q/ljo35TipVJvAieY1OvtKA9kPlvd456sPrvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714330640; c=relaxed/simple;
	bh=wPsymlHYc+Ztzg3q9casVwg5tUSAe61Di1xY6D0Nuhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=haTAEWmxePTPCSeLm6m2m3ZyWg6tExe4GpmlgBcH8gsWrmhZNyoGfPjiya2o5v0JenWjfWEDBtTIXOBqYEkLQzvKSP6POcDKKo623BWFV/JBiTTkWk/kpb1THAuNuEj0qCXsuOIOGJAuc50U7zKUinLpSavbpIEoQdtg0M5ti/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ebf/x5uM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebf/x5uM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7325C113CC;
	Sun, 28 Apr 2024 18:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714330640;
	bh=wPsymlHYc+Ztzg3q9casVwg5tUSAe61Di1xY6D0Nuhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ebf/x5uMAmi/As3DYWrEkkrOGmjM2wCr/XrZ/xdWrI60qfs3DdGEURO9CML32WY0/
	 sX29h91aDX7ekI+hPWv9Fv4bVDeNKeE7eBEZj5V/XGPmxX7lBeZUt9tDJQiKG835cw
	 qERGvY1nm/rDdrgovADBvmGMJ4grYQDCSzI/aec+POrfiCk+++qSld1kZ2giZixPHu
	 V32Qb3TByyHV5c45sW6JGnFCXrmtmmUKBZlebfIica1qVERLKM3Lcaw+3MusK8twde
	 SQR8Z4rtol5FSbCelu590myDLm08DvnNCohrBI9NpV7oJO+8qp90l6hGKrpO7XFVCi
	 AVuA/vGCmE+8Q==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/core: Fix return value from damos_wmark_metric_value
Date: Sun, 28 Apr 2024 11:57:17 -0700
Message-Id: <20240428185717.60110-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240428184159.188535-1-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex,

On Sun, 28 Apr 2024 21:41:59 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> damos_wmark_metric_value's return value is 'unsigned long', so
> returning -EINVAL as 'unsigned long' may turn out to be
> very different from the expected one (using 2's complement) and
> treat as usual matric's value. So, fix that, checking if
> returned value is not 0.
> 
> Fixes: ee801b7dd782 ("mm/damon/schemes: activate schemes based on a watermarks mechanism")
> Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
> ---

We usually post new revisions of patches as new thread, instead of reply to
previous revision.  If you want to kindly letting reviewers understand the
revision history of the patch, you could put the summary of the changes in each
revisions here[1].

[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#the-canonical-patch-format

>  mm/damon/core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6d503c1c125e..53d33b2fa0b9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1480,12 +1480,17 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>  	return true;
>  }
>  
> -static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
> +static int damos_get_wmark_metric_value(enum damos_wmark_metric metric,
> +					unsigned long *metric_value)
>  {
> +	if (metric == DAMOS_WMARK_NONE)
> +		return -EINVAL;
> +

Below switch-case will handle this case too.  How about removing this if
statement?

>  	switch (metric) {
>  	case DAMOS_WMARK_FREE_MEM_RATE:
> -		return global_zone_page_state(NR_FREE_PAGES) * 1000 /
> +		*metric_value = global_zone_page_state(NR_FREE_PAGES) * 1000 /
>  		       totalram_pages();
> +		return 0;
>  	default:
>  		break;
>  	}
> @@ -1500,10 +1505,9 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
>  {
>  	unsigned long metric;
>  
> -	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
> +	if (damos_get_wmark_metric_value(scheme->wmarks.metric, &metric))
>  		return 0;
>  
> -	metric = damos_wmark_metric_value(scheme->wmarks.metric);
>  	/* higher than high watermark or lower than low watermark */
>  	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
>  		if (scheme->wmarks.activated)
> -- 
> 2.42.0


Thanks,
SJ
