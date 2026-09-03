Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7B9412BF0
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429714; cv=none; b=s4JRfkd8e46DJ/XnsCJSuWpU/sqzE8KglECAv/XSQ+7TlExpKqqrZTOYWGH9fkxayl3r0rYfROizuWaQ4gzXMdy6poASXXGSXJhRbfDWQlO7CB9t1nYkV6+WSGB4hp4eW702aa991XQ38C8dk+ihWVDAn0PZvKItIqTXZTR20ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429714; c=relaxed/simple;
	bh=eVvi+oZ7zm88Ak3ECTPd8lI8OZXgbUS6E+jFC1A/eAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5UNWsQGhaGeihpgFUd9z9j7Tl6Fo49qqD5uqM/lN7On5GN1vTMKx/GBfMsNKqGgQzaUo8M9tF3eLxyGLr238xjFTECBRIX0RD72iFXj5KeQnyDj994ZNjyzUG9BYfkayaVELnGm/FPnGKezEHzbBPwrIW/J07Zm6QwCTFnTTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNvIAnhp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNvIAnhp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc891373e0so22955725ad.2
        for <damon@lists.linux.dev>; Thu, 03 Sep 2026 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788429712; x=1789034512; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ce8M/7qhkjbYOloNei8s08cubgJ3TDWZ5Dcu7749Xg=;
        b=GNvIAnhp1+e/P+uduV4wj2g75kkNoCgk3Vr9028N4cCHvWNiq2YExWdx3Two+AimQD
         4sePGvypcEIHN/9B/7fsRop75NaU0BOfpJTRPp8DNw+MOhLm+Gwr9AcEtXbNMEEG10HE
         RVOLVOt5keT1RnKjn9YsRmTmLGat7PdT+mSkueakDcxzhoK71IKmV3Y+yXlDkR7lsvnh
         hxz5K0om2dwpR5dHEEA6Mtq2rB/bBtEl8l45hx4WJn7ykqbsLoXVwu6Gqu4ayoKpoa5v
         vZ95fGqy/ITtVDOemaQsfvykM1nI3Na8XYXnIjsAlDBfTXKbQ/v4OgEXOTNcbICAObNt
         uXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788429712; x=1789034512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ce8M/7qhkjbYOloNei8s08cubgJ3TDWZ5Dcu7749Xg=;
        b=TtISzHGKjdGYwbOw3x+wvMYAttXa1epegWsUJ1PF5OMz0bh9GC4NJrBkW2A1izgdw0
         /3ay7AnVx2OJioy74Jb4qiwYNCkDIcNcd/rzry/Oopd1ludLXcs7phJsIXCjdcUb/rTp
         OXdok/x+Pniy+NvDSBPAAnZ+/msbiQrpydGPD7mPKqS2l0uhikQVNQQ3kfTqqr4vxSYv
         Xum7Av9aSX89fJPsZjm3Et/SkVUpvH885gpB9D0wDBv4lTW9MN/EQp6FDqIpeY6VlaI9
         fZwNYCd7I/AEMkmLge3FxgmuV1oBr/q+rIfuhzLJi+QCLi26iXfW6lq+KmrSDWB51j/l
         hPfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNTK4ZC1Wmhds28kb1XJ/24Fogncn4tiN2i9KOV9ex0+qgiZzWNiO+mb++2LpaJSaTTB/mZg==@lists.linux.dev
X-Gm-Message-State: AFuF++msjmVc6Q9xVvxWr/h4crr8TL1f06L5Sv8t0mWpyxi5E8itTFHP
	6RUCsJcivfwcTJ4v1C2eCjoiWwBU7J/tYfiQvztiWmzr8iC3YYF5z3CV
X-Gm-Gg: AYBFou2lHnHaB7jdGsjVXck/5gq+hlQzmtqeZXv+WQMIQ481KcTT0b4wDMVZjUJzkwN
	O6bZKUaRPRX+LyuijD50N7Lc/JXlEOacQoAlJH9eJDGW8dLlwNmWKNXeUjrkKse8+ykmi0krbEa
	cYEUVpSzh0ZHOYx/qfmuVtbGeJeUWkV5E4mZqU7842QGQTPwCjXFLh6kzcarWp/j7ou7vIQRYsW
	EUv5I5j/vkce0tddHCRKHIiY7iXKJlGLH3FFIWnWoH6sJJduwPTgrNyzCIBiYIVx9jA3r4iD64a
	PE4/VEAilnZlQUuv43TqtWM+ohXFluMoeQc/GUkIrTPTTqp1+ORdWmbJnc8HWvUVlxBYcKmg2fp
	5uAwbzDsg9IXJVGY0H323BFryX4KL2UTwaAueKkWMhPSF/ZDRh/uFwGG1l5y8uMj1Ne4M6Bhfax
	lEhE3JFEN+jkH4Unq826JcLXs+Ecn6GS/FS/lhfXnHg1rFVZMZ2huNnDgxghk=
X-Received: by 2002:a17:90b:4c4c:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39aedfc9616mr16315183a91.11.1788429711355;
        Thu, 03 Sep 2026 03:01:51 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08766a2dsm4456658a91.15.2026.09.03.03.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:01:50 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 4/4] mm/damon/sysfs: set next refresh jiffies per sysfs context
Date: Thu,  3 Sep 2026 18:01:41 +0800
Message-ID: <20260903100142.106449-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902002725.108635-5-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:27:23 -0700 SJ Park <sj@kernel.org> wrote:

> When 'refresh_ms' is set, DAMON sysfs interface periodically updates
> auto-tuned parameters and DAMOS stats.  The timestamp for the next
> refresh is initialized when a DAMON context starts, and updated in its
> damon_call() callback function.  That is, each DAMON context updates it.
> However, the timestamp is a global variable that is shared with all the
> contexts.  When there are multiple DAMON contexts having different
> refresh_ms, the update frequency will be changed, depending on the order
> of the contexts.  When there are multiple kdamonds, it will be even more
> chaotic.  Fix the problem by having the timestamp per each context.
> 
> The user impact is not very critical.  It does not leak, corrupt or
> crash.  The update will not be faster or slower than the lowest and
> largest refresh_ms values of the contexts, respectively.  The user can
> also manually ask the updates on demand using kdamond state commands.
> That said, clearly this is a bug and can easily be reproduced.
> 
> Fixes: 9fd7bb5083d1 ("mm/damon/sysfs: change next_update_jiffies to a global variable")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 3c81b4c91ac0d..dcb739ce0a729 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1788,6 +1788,7 @@ struct damon_sysfs_kdamond {
>  	struct damon_sysfs_contexts *contexts;
>  	struct damon_ctx *damon_ctx;
>  	unsigned int refresh_ms;
> +	unsigned long next_refresh_jiffies;
>  };
>  
>  static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
> @@ -2213,17 +2214,15 @@ static struct damon_ctx *damon_sysfs_build_ctx(
>  	return ctx;
>  }
>  
> -static unsigned long damon_sysfs_next_update_jiffies;
> -
>  static int damon_sysfs_repeat_call_fn(void *data)
>  {
>  	struct damon_sysfs_kdamond *sysfs_kdamond = data;
>  
>  	if (!sysfs_kdamond->refresh_ms)
>  		return 0;
> -	if (time_before(jiffies, damon_sysfs_next_update_jiffies))
> +	if (time_before(jiffies, sysfs_kdamond->next_refresh_jiffies))
>  		return 0;
> -	damon_sysfs_next_update_jiffies = jiffies +
> +	sysfs_kdamond->next_refresh_jiffies = jiffies +
>  		msecs_to_jiffies(sysfs_kdamond->refresh_ms);
>  
>  	if (!mutex_trylock(&damon_sysfs_lock))
> @@ -2271,8 +2270,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
>  	}
>  	kdamond->damon_ctx = ctx;
>  
> -	damon_sysfs_next_update_jiffies =
> -		jiffies + msecs_to_jiffies(kdamond->refresh_ms);
> +	kdamond->next_refresh_jiffies = jiffies +
> +		msecs_to_jiffies(kdamond->refresh_ms);

The fix looks correct to me.

Moving next_refresh_jiffies into struct damon_sysfs_kdamond gives 
each kdamond ownership of its refresh schedule, so refresh activity 
from one kdamond can no longer interfere with another.

I also checked the initialization path: the new field is zero-initialized 
by kzalloc_obj(), and damon_sysfs_turn_damon_on() sets it to 
jiffies + refresh_ms before registering the callback via damon_call().

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>  
>  	repeat_call_control->fn = damon_sysfs_repeat_call_fn;
>  	repeat_call_control->data = kdamond;
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
