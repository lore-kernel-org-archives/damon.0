Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9723EA83
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822962; cv=none; b=Y8xkb1JeURmksET0ksSKNLTV5x6C8ztdfWj5ftwmB+D8RyNuXx9qk7RW8oSbCDC2as6Pw5sb83JDlbsPuAZqC2/FNvBGc56UKMCz1+VCerJO9bKM5br7Hf9yW3XZb53oPbpfvd8i9/B4nOA4kQ0H3zG19wN0NEBTTcFTF0/obQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822962; c=relaxed/simple;
	bh=DUvjoQROS8yk+VfXJeNWxO9qytK3Bfp0yYXrhXYSjQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZTafUsO5jIZLnEBtaULgfG9/vKG5hVAWwdTZUt5BFbYma8JIBiDSsUCA0A0s/FkGHjqFc2hbxQhhwfjGc3eODKzO3lytD6I0TNuqpdUQqNdshTwmfY873ejlXQIuBFzLNV0Ju4ILNAQeOKCAbQMzcFbpzxmJK5TCvWTsLwo0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iRnKcDfT; arc=none smtp.client-ip=95.215.58.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iRnKcDfT"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=DUvjoQROS8yk+VfXJeNWxO9qytK3Bfp0yYXrhXYSjQk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789822958; v=1; x=1790427758;
 b=iRnKcDfTf0v1aSNak1pUAjhodKXLzeUe961jk+nr6pxeNb2rM6+y9wZX9MsE1XJTkqwCogfL
 +NX5Y/XaUTPNylEcBdhj0ucDU+0cs3jHZIfPvfMt03FNHyzO1HSZysRen56eMWENWZj2ZpfKaw3
 fL+tjUNdcbs5FGn8yZ6BYm1g=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 498751209693f72e;
	Sat, 19 Sep 2026 13:02:37 +0000
X-Mizu-Trace-ID: 498751209693f72e
X-Migadu-Flow: FLOW_OUT
Message-ID: <ae900f5b-7f00-4c48-8097-f2f836c09f60@linux.dev>
Date: Sat, 19 Sep 2026 21:02:30 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/damon/api: remove NR_DAMOS_FILTER_TYPES
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-2-sj@kernel.org>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260917142210.90829-2-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/26 10:21 PM, SJ Park wrote:
> Nobody uses NR_DAMOS_FILTER_TYPES.  Remove it.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index bbb190b474015..836353c4ab9aa 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -400,7 +400,6 @@ struct damos_stat {
>   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
>   * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
> - * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
>   *
>   * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
>   * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
> @@ -422,7 +421,6 @@ enum damos_filter_type {
>  	DAMOS_FILTER_TYPE_ADDR,
>  	DAMOS_FILTER_TYPE_TARGET,
>  	DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
> -	NR_DAMOS_FILTER_TYPES,
>  };
>  
>  /**

Similarly we have more definitions of NR_foo in damon.h:

 * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
 * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
 * @NR_DAMOS_WMARK_METRICS:	Total number of DAMOS watermark metrics
 * @NR_DAMON_OPS:	Number of monitoring operations implementations

and only NR_DAMON_OPS is actually used (I checked mm-new).  If the
preference is removing all unused macros, we should probably clean them up
as well.

Thanks,
Zenghui
