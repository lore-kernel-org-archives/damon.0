Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9C1F75A6
	for <damon@lists.linux.dev>; Sat, 16 Aug 2025 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755372963; cv=none; b=a62kNHvdL1Zppr7TVqUe1/JCU8c2eAq1ZmD899BQeiUyChPepu81L+ZiNcH15Nu+yQdrtl7+VAup/u0BCX+CswpHpkkGAhvYf75YcZNcz5DwkyqPm1+dnomnANyPjz7mxq28diyZw4TisBJVBzMLGXDLVG0VLYqYFP3uu9Fd4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755372963; c=relaxed/simple;
	bh=QzrSxmFk6iveACVr/9rEhCqobbpcZhNFTVK5ExiN5Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cggXRee/JUYI7c5SO+0e1Ln4bTvLTQ8O7dc7KNWlov8PCp0V0nrdpHDZbcGNCIuXIvoHEWY4sCdjME1WOEx4xm25B3mOD4LAPtPe0RCLRpjkkQ1br6UaDai8nBZDdP4MkXQpwcD7ipGwvUj2b7bAZjQAByuIEbugAWyO8XiJPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7FD744349;
	Sat, 16 Aug 2025 19:35:56 +0000 (UTC)
Message-ID: <c5bf56b8-da06-4e17-86bc-1b69af3065cd@ghiti.fr>
Date: Sat, 16 Aug 2025 21:35:50 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/sysfs-schemes: put damos dests dir after
 removing its files
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250816165559.2601-1-sj@kernel.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250816165559.2601-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeejjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhephffhuddtveegleeggeefledtudfhudelvdetudfhgeffffeigffgkeethfejudejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdefrddvfeegrdduudeirdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdefrddvfeegrdduudeirdduhedupdhhvghloheplgdutddrudehhedrudejuddrjeekngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepshhjsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrmhhonheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmhesk
 hhvrggtkhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi SeongJae,

On 8/16/25 18:55, SeongJae Park wrote:
> damon_sysfs_scheme_rm_dirs() puts dests directory kobject before
> removing its internal files.  Sincee putting the kobject frees its
> container struct, and the internal files removal accesses the container,
> use-after-free happens.  Fix it by putting the reference _after_
> removing the files.
>
> Reported-by: Alexandre Ghiti <alex@ghiti.fr>
> Closes: https://lore.kernel.org/2d39a734-320d-4341-8f8a-4019eec2dbf2@ghiti.fr
> Fixes: 2cd0bf85a203 ("mm/damon/sysfs-schemes: implement DAMOS action destinations directory") # 6.17.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> Not Cc-ing stable@, since the broken commit is in 6.17-rc1 and hence probably
> this fix will land on the mainline before the release of the first 6.17 stable
> kernel (6.17.1).
>
>   mm/damon/sysfs-schemes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 74056bcd6a2c..6536f16006c9 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2158,8 +2158,8 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
>   {
>   	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
>   	kobject_put(&scheme->access_pattern->kobj);
> -	kobject_put(&scheme->dests->kobj);
>   	damos_sysfs_dests_rm_dirs(scheme->dests);
> +	kobject_put(&scheme->dests->kobj);
>   	damon_sysfs_quotas_rm_dirs(scheme->quotas);
>   	kobject_put(&scheme->quotas->kobj);
>   	kobject_put(&scheme->watermarks->kobj);
>
> base-commit: 9aa69ba9d9e220ea1d8ba62592fe7ffba376b2cc


Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for the quick fix!

Alex


