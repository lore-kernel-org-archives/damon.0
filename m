Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F64C62B
	for <damon@lists.linux.dev>; Fri, 22 Nov 2024 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303769; cv=none; b=WsltQpZEsMMl45FIGwujBVvoIQGFhftjVVJgoQc9DwEKm+M8ZiIDYpR5tvzGvZ4ZDX9q0b61D1lYuye0fCPtJeYEGXli1KEmS+c9wJU5DRH0oWMeuhFswDGhZAQOe/nzvvGFa3GByehirUoR94lXIVJVlKlhK1Yu60t2NGIbbCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303769; c=relaxed/simple;
	bh=/9Syj5imx4NAXQYtw516kR+/mlFGxS/TKuAsPZTVTlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dN4/d3eJh5jszWIfKjBanSZyu58kzuUZbriZNRC16+EKIy3Y5b1fRZ/V7W/4pmrt6Xvi4PGzwb6djabiCxfgX/LL8yHfHPEoKpRI0C1cZb4FQlnyM7k6hrgS7ju5yQ4+ZKsqQBQuN5Ff0COpu7IhoXmIVPvqswlDXcEQRXik58U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUbfDNEc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUbfDNEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EFFC4CECE;
	Fri, 22 Nov 2024 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732303769;
	bh=/9Syj5imx4NAXQYtw516kR+/mlFGxS/TKuAsPZTVTlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUbfDNEckIMLReUAo4ovdrakf9lrv00UF8yL++jBhlV2Dy8lIW/5T7VcOlJVFzY+X
	 Hq42ELNXKCPpThXfmE3gZJC/o2ODG7no3PbEjGMR5H66ZJVT6lMD9awEoZ+XdqRUxd
	 jKFj5eZ1T3j+ErzM+/P4A52KEr9lFsvMotXSsfoq73Ont6X53gZ8rSrv8Iq/Z9+XHG
	 xQZu3uT9Hb2MGLEEcLZWbI2C0Ma2hmX/7TP86mXkdiIeRkvh1gUoLcJm4MZH1jYE2x
	 oRbu5VzDh/IKuUESI7DB3qsB1rvjLz6dqDgJyroS86xvReZiJnZFHHY2l9iEdS2HQ5
	 XFDlBcr7fTRMg==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel_team@skhynix.com
Subject: Re: [PATCH] mm/damon/core: Refactor damos_set_effective_quota
Date: Fri, 22 Nov 2024 11:29:26 -0800
Message-Id: <20241122192926.58718-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122081834.1344-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu,


Thank you for this patch.  Definitely DAMON needs many refactoring and
cleanups.

The subject of the patch is a little bit ambiguous to me.  Could we make it
more specific, e.g., "set esz of damos_set_effective_quota() as ULONG_MAX by
default"?

On Fri, 22 Nov 2024 17:18:34 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> The damos_set_effective_quota checks quota contidions but there are some
> duplicate checks for quota->goals inside.

From the above, I was thinking the duplicates should be somewhat unnecessary.
And indeed the function list_empty(&quota->goal) multiple times.  But, that's
not for a unnecessary reason.  We need to know whether 'esz' is set or not.
The check is for that.

> 
> This patch reduces one of if statement to simplify the esz calculation
> logic.

More technically speaking, this patch gives 'esz' a safe default value, and
removes the checks of 'esz' initialization, which is no more necessary owing to
the default value change.

Honggyu, could you please update the subject and message to more clearly
explain the change?

> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> ---
>  mm/damon/core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 511c3f61ab44..eb2761866dda 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1542,7 +1542,7 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
>  static void damos_set_effective_quota(struct damos_quota *quota)
>  {
>  	unsigned long throughput;
> -	unsigned long esz;
> +	unsigned long esz = UINT_MAX;

Let's use ULONG_MAX.

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
> -- 
> 2.34.1


Thanks,
SJ
