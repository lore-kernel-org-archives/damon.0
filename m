Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE510F1
	for <damon@lists.linux.dev>; Sun, 28 Apr 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714323448; cv=none; b=scnkOl61PmwvYRTIMLV3abnAdM7tk2urAHF0GeBJsJR/jDFpyQh5aDWF5EpSw4J1SiujZilo0QLWXMNvuMgL8TppOf1yFyohwUzP+Jdmw95RC5c28DZORxhNWOonkbG2rnV0CLvNlkOmR8KaZUeJlmBnOoFvsLA3CMhylCY6/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714323448; c=relaxed/simple;
	bh=+q0HngoqBGEOM4n3Pd5X4NB98f/1ih4IqA8etWcm2MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmOAYxHRIzUAtDk3LTuT8i3QWL5j3tf2GWY3B57/iOTV9fjlEWErW/nggKe/6KgURWHzZwRqk4lO75ZfHa46ayQmc1CVfBCxMalwD0kYcn+MHk+ENBHQ7OvZ1wyZoAPmmqTJrhg/0s0oZK+daumRa14F5mwcFURCPddba8OAn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBRZROkL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBRZROkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EA9C113CC;
	Sun, 28 Apr 2024 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714323448;
	bh=+q0HngoqBGEOM4n3Pd5X4NB98f/1ih4IqA8etWcm2MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBRZROkLVOQA1TvZFVN3l6RjptyiM01VfEwTPrqFPMCF6fJhw9byKoWA/BfwQ9KBb
	 bBZpldHojrG4G+xecw1NM8BcCyl+Cf6y7XeHPxNwF/aeiYB7eB8F7VtQ0CIh7DaunP
	 wSJ7e+mftMKLxmeLyscaAmdb6/nTjAI2bTD0o2YrwxETIK8SUxqybPrOV8M9XXzQbe
	 QgNyFD8gbiLqRoOlJ3+ASoFNcGz1N7j53j7cdvNWmfCAowyU6j0y50WUNqdY4kRgQw
	 fLZyX0cYj+V73XBVpajhjPfGaWuTD71l7ME9XyNdiJoynUEt6rWCm01JMCGsR5osSL
	 KlTGOMrSkmRqA==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] DAMON: Fix return value from damos_wmark_metric_value
Date: Sun, 28 Apr 2024 09:57:25 -0700
Message-Id: <20240428165726.46959-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240428154933.183760-1-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex,


Thank you for this patch!  I have a few comments below.

For the consistency, could you please use 'mm/damon/core:' as the patch subject
prefix instead of 'DAMON:'?

On Sun, 28 Apr 2024 18:49:33 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> Signed-off-by: Alex Rusuf <yorha.op@gmail.com>

Could you pleae add more detailed explanation about this patch, including why
the return value is wrong?

And, I think we would better to add below tags?

Fixes: ee801b7dd782 ("mm/damon/schemes: activate schemes based on a watermarks mechanism")

> ---
>  mm/damon/core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6d503c1c125e..994ccd272555 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1480,12 +1480,14 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>  	return true;
>  }
>  
> -static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
> +static int damos_wmark_metric_value(enum damos_wmark_metric metric,
> +				    unsigned long *metric_value)

Because the return value is no more the metric value, what about renaming this
function to, say, 'damos_get_wmark_metric_value()'?

>  {
>  	switch (metric) {
>  	case DAMOS_WMARK_FREE_MEM_RATE:
> -		return global_zone_page_state(NR_FREE_PAGES) * 1000 /
> +		*metric_value = global_zone_page_state(NR_FREE_PAGES) * 1000 /
>  		       totalram_pages();
> +		return 0;
>  	default:
>  		break;
>  	}
> @@ -1500,10 +1502,10 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
>  {
>  	unsigned long metric;
>  
> -	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
> +	if (scheme->wmarks.metric == DAMOS_WMARK_NONE ||
> +	    damos_wmark_metric_value(scheme->wmarks.metric, &metric))
>  		return 0;

DAMOS_WMARK_NONE check can be handled from damos_wmark_metric_value() function.
Could you please remove the check here?

>  
> -	metric = damos_wmark_metric_value(scheme->wmarks.metric);
>  	/* higher than high watermark or lower than low watermark */
>  	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
>  		if (scheme->wmarks.activated)
> -- 
> 2.42.0


Thanks,
SJ
