Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA323D0
	for <damon@lists.linux.dev>; Mon, 17 Jul 2023 03:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C5CC433C7;
	Mon, 17 Jul 2023 03:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689565265;
	bh=hA/g9aS2y5CIfLc5yFsDNhX8Ew8lu1YlZr0MxnMf2e4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JIRmxvodRVVUPrkNKLuPrh42JXKHsE1uTAf/t6aF0TMVxlI3PWT+y0lVHXHr1DBOC
	 8IFOcY1NypBmnR5GUsVCspKUFfUNL2S+ouwHfTPy+AAeLpQRKCmyAIa+ThnWjG2+j5
	 5vKMzS9hFXqw7PhXojROzT5Q+0Lv4MfBDYEDGLTpt64BNRPcIYXgmki7nlVwue9PET
	 +jrjlbNJgVAlr4Kww5DwF2pHlv74iD0BRer6pCXXnYfpuTWHyFj0vr9DeUuCVgkhrt
	 dy0PWtIWro0UplZHL1ONG9hyGcMWQ5mDQem+SyjDXJdZv3Hj0PdHUWBCiHno76cg1H
	 xnpDlbX446Nag==
Message-ID: <c7a050b2-4ceb-9888-5e69-36aeec0989cc@kernel.org>
Date: Mon, 17 Jul 2023 11:41:01 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] mm/damon/dbgfs: reduce stack usage in
 str_to_schemes()
Content-Language: en-US
To: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230716010927.3010606-1-chao@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230716010927.3010606-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

It warned because my config is wrong, sorry for the mistake, please
ignore the patchset. :-P

Thanks,

On 2023/7/16 9:09, Chao Yu wrote:
> struct damos_quota quota caused the stack usage of str_to_schemes() to
> grow beyond the warning limit on 32-bit architectures w/ gcc.
> 
> mm/damon/dbgfs.c: In function ‘str_to_schemes’:
> mm/damon/dbgfs.c:292:1: warning: the frame size of 1496 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Allocating dynamic memory in str_to_schemes() to fix this issue.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   mm/damon/dbgfs.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index 124f0f8c97b7..78acc7366895 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -237,18 +237,26 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>   	int pos = 0, parsed, ret;
>   	unsigned int action_input;
>   	enum damos_action action;
> +	struct damos_quota *quota;
>   
>   	schemes = kmalloc_array(max_nr_schemes, sizeof(scheme),
>   			GFP_KERNEL);
>   	if (!schemes)
>   		return NULL;
>   
> +	quota = kmalloc(sizeof(struct damos_quota), GFP_KERNEL);
> +	if (!quota) {
> +		kfree(schemes);
> +		return NULL;
> +	}
> +
>   	*nr_schemes = 0;
>   	while (pos < len && *nr_schemes < max_nr_schemes) {
>   		struct damos_access_pattern pattern = {};
> -		struct damos_quota quota = {};
>   		struct damos_watermarks wmarks;
>   
> +		memset(quota, 0, sizeof(struct damos_quota));
> +
>   		ret = sscanf(&str[pos],
>   				"%lu %lu %u %u %u %u %u %lu %lu %lu %u %u %u %u %lu %lu %lu %lu%n",
>   				&pattern.min_sz_region, &pattern.max_sz_region,
> @@ -256,10 +264,10 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>   				&pattern.max_nr_accesses,
>   				&pattern.min_age_region,
>   				&pattern.max_age_region,
> -				&action_input, &quota.ms,
> -				&quota.sz, &quota.reset_interval,
> -				&quota.weight_sz, &quota.weight_nr_accesses,
> -				&quota.weight_age, &wmarks.metric,
> +				&action_input, &quota->ms,
> +				&quota->sz, &quota->reset_interval,
> +				&quota->weight_sz, &quota->weight_nr_accesses,
> +				&quota->weight_age, &wmarks.metric,
>   				&wmarks.interval, &wmarks.high, &wmarks.mid,
>   				&wmarks.low, &parsed);
>   		if (ret != 18)
> @@ -278,15 +286,17 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>   			goto fail;
>   
>   		pos += parsed;
> -		scheme = damon_new_scheme(&pattern, action, &quota, &wmarks);
> +		scheme = damon_new_scheme(&pattern, action, quota, &wmarks);
>   		if (!scheme)
>   			goto fail;
>   
>   		schemes[*nr_schemes] = scheme;
>   		*nr_schemes += 1;
>   	}
> +	kfree(quota);
>   	return schemes;
>   fail:
> +	kfree(quota);
>   	free_schemes_arr(schemes, *nr_schemes);
>   	return NULL;
>   }
