Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F73AE713
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889608; cv=none; b=q4+oPhJj6Z83MyhJ8xubViAJBmPpaGJ7lzlUipGqr07xdobP9BbAKrlbezHab5DAUYPw///48hICn5I8FMJg24pfiQM8Gawe5PwT2d5RiMvYaZOGLpb6sxxQp5whA6UTEPkws0k4nc/vtpJefyucSfay6uQaIVUBZHuQdgJAvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889608; c=relaxed/simple;
	bh=Zn+AIrmF0AVNoZFHPA81gQXKhbPcNqU7a3t2IJTk6d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBSgBywNBiT8KZMtvrCs4EkQuROiyO/CrGDqq77h03ViPiJBx7l6aGe797/7y6q2KtIKcupUADS4Csox8jlTuX3xiXQDUJbYpYifNqvcGJocZipGbUiMPOgcY8Sndkjn0sUUQU6n3CIQ0AtNI89wwnQJkM5Vcmo99AoeeAx86M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J0mcbCvY; arc=none smtp.client-ip=95.215.58.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J0mcbCvY"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Zn+AIrmF0AVNoZFHPA81gQXKhbPcNqU7a3t2IJTk6d8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787889604; v=1; x=1788494404;
 b=J0mcbCvYD4VM8SleU+j2QybbNKtChjqZvc27Ti9ifUxxLr6oW5fNcjuvsBesWGc3mQiJkjit
 5NgMyPd56OExI4vzdTisEbj7ZNghoMmbIg+m3qGP2iVVrAIVT87g0+g32JLx7/YSJ5mCTTWSkIg
 s4JF3TUUdk+faxRsid299/wY=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 293d25efb3c88b71;
	Fri, 28 Aug 2026 04:00:02 +0000
X-Mizu-Trace-ID: 293d25efb3c88b71
X-Migadu-Flow: FLOW_OUT
Message-ID: <3cb41363-76e8-434b-add3-3cb4b83a6d9e@linux.dev>
Date: Fri, 28 Aug 2026 11:59:47 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 22/37] mm/damon/sysfs: implement cpumask file under
 sample filter dir
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251208062943.68824-1-sj@kernel.org>
 <20251208062943.68824-23-sj@kernel.org>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20251208062943.68824-23-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/25 2:29 PM, SeongJae Park wrote:
> The DAON sample filter directory has files for only common properties.

DAMON

> Add a file to further specify the CPUs to filter in or out.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 74594e6e461c..d6b0b6513fd1 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -758,6 +758,7 @@ struct damon_sysfs_sample_filter {
>  	enum damon_sample_filter_type type;
>  	bool matching;
>  	bool allow;
> +	cpumask_t cpumask;
>  };
>  
>  static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
> @@ -765,6 +766,19 @@ static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
>  	return kzalloc(sizeof(struct damon_sysfs_sample_filter), GFP_KERNEL);
>  }
>  
> +struct damon_sysfs_sample_filter_type_name {
> +	enum damon_sample_filter_type type;
> +	char *name;
> +};
> +
> +static const struct damon_sysfs_sample_filter_type_name
> +damon_sysfs_sample_filter_type_names[] = {

Looks like this should be defined in patch #21.

Thanks,
Zenghui
