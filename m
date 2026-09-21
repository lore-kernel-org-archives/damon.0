Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB324D0CDF
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015974; cv=none; b=D87jFEbRPVgnmDP3rNVQfLyeSSR4y6++9kdZnX6cVXlk+ekex34rXrBf1e4mbnN7pHmjLlxd9qaDay5qewtM7zjaDu/oO/CPe8SuU4oengvVIMJkliSCGC4N9tThVlKRij69Bh9Ph/PbMQKDFyNU0tLF9YqWKGtApRmoJswwJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015974; c=relaxed/simple;
	bh=kHF55tgxlhodvMYjiaBn8wLp3n68ssCHiTfatMPtKzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpeW2vDqBApw7ItqRlo3amK/VXD0vpDuiaFadiR/DJobaPsFDudW+5mcAJYSDFgVJs/lpegRKPPV+/QQi7RhunEcfPEsgSUWiGlSZS7EhubHvqyaEnUDJPjXn2jZO3nE+W/m201sdFT6QZJEOqaNtaaMLSfC4jgCyLJbTk5hgxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZ72j5lQ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZ72j5lQ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so23110895e9.2
        for <damon@lists.linux.dev>; Mon, 21 Sep 2026 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015971; x=1790620771; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qfp1Yz3ifDR2lWMmmnGcVuQR5yKwqsCt+IibNOfjTJk=;
        b=rZ72j5lQL9WMn/oh8QBL87sAa2ATBoenf+E4BhOw5Yop5NcWop2JHnTVAc/7XWVcmZ
         lGq0YOaXEKJ436ZTsNis5Apwgak/KFW+5UzpN8axtnNoGFimsZTMDaDh2VhuzGPhmtyh
         G0ef25aLX8UVTg3bjS4C9OtZYgguWBisMmF7ntAD68v4uqLo9iyzL4VelNz0u6l/LORL
         rI5NBdQDqpWm14Hb5YZGdNmNRhF0bimOZCKIvJqhI07l4LbNF4HEuhBW9YH6/YMfDQEq
         TxDic3kaFzvX9cNg6vc0eQ+EhSwLr1Uf3tUwMaKNWWqCnGjCKmL6jf4+rVVVZEgmI14g
         aSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015971; x=1790620771;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfp1Yz3ifDR2lWMmmnGcVuQR5yKwqsCt+IibNOfjTJk=;
        b=eg1RQLChXNljLCPQGWAdqh5OfBQzxuLf6PUcdG1v7ikshpRBAapO4EZ0LxxmtBWkZU
         eyZoiUcBHsyJch3XR02iL3G0pI3Yus7Fnbu6rHM37iSFIbcAeJs71mG52g7TKWtS6bNO
         +mrThXmvRig1qpHL6SSdsaPOw8mj7QdEwaxj3qXdFyTDVcx0xXd4r1qfMmJMdZGYU0e8
         Qrks8kaPill4ehgsL/608bAqKqwCws1y7HbwU4uE73neLRktqlBDl8BWJp61kySeSdFZ
         mA/IFJdWaQ3Ki2bSHN7lW7UXfDPzEHw4PrerqLNUY/9EpJKM+C2VYx36swA/j27xLEVK
         0uJg==
X-Forwarded-Encrypted: i=1; AKwUvBz8vnKnC4pGb5SiLyYNcwp5njUZBDEbxHhMxXjkcez1jks4JJLG1teDQIp74ILYVYEPNd1Y6A==@lists.linux.dev
X-Gm-Message-State: AFuF++nuR/D4RMHV70lE4aH73GVPP6ZcY5lfcUbNa7r7bFCYiMWMBvpp
	TXtBvPgkoyqnP8qaBYy1NQTpzcT3xJXHLaAqPx8UFJJBC4SJbhJ1qPGA
X-Gm-Gg: AYBFou0ya+SV9i4XxHeglhUEanXtBHBdSPbw+GQ7xYfrh3mjCbjRHFUeMyt/FL+SKou
	mRQIW8L16NpqXnSTCKt1PRG7VZzW8HtwrIF2xDP7NrOIsiuwA+mXgW2Ru62GFUbPNJUDmDspmAZ
	4OEAU9MgR0x6xS0LONOQGW+kTeA9d8Pmv5VfU0wqXo1pYI8MI8+zN4RCxVc8hOQc2OBSHjOGgzc
	6USvpgMWX7h9A/qo2SktWZtfUcrZ9X1MyZaOPXJrmWcAOjbbuzq7vMLZbPo007ImuacCbFB0Jcu
	SNAWdirIQrL3GHCTUJ7iL9vRRCFhf720UCwRfEEgtm7h3gjouayrzyou21SH4fiVCdIpojY7uZp
	UEQO0UmhE7/S2ETJVq4fLc29SHBdwhhBdafo9CNI0/RKoL2fEMh0zXja9K0O/WbKq2ec/ZS7Zl/
	TTer9YfsRzrIQTzMG8HlY8gqhY9hNUh9F7H2e/2mc0repRdeMNHcXFgzDXfS8+PQBmqClN/BsEw
	Td4I5J/ZeQgjDk+qxZKsnVZMc2dIROSztKTB3bm7AB1dwiRHufpO6lkTr2oBPNasvx0u+uQmzj9
	Sa0/7CWQcgN8ZKhJtyZGfGJMyeEziYAD+HnZzao8pmKqluOwZYIBi2fHdwm8NjLdfyJApD8O4mC
	694BM9oDBYVOKj0Jw
X-Received: by 2002:a05:600c:6214:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49fc568129emr158209655e9.6.1790015970588;
        Mon, 21 Sep 2026 11:39:30 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a8e9-c501-45ee-6f60-3fc5-4072.310.pool.telefonica.de. [2a02:3100:a8e9:c501:45ee:6f60:3fc5:4072])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm10667745e9.8.2026.09.21.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:39:30 -0700 (PDT)
Date: Mon, 21 Sep 2026 20:39:27 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/damon: preserve temporal quota state for
 unmeasured PSI goals
Message-ID: <arF2epnyKAdkwSG-@gmail.com>
References: <20260921020013.33105-1-kmehltretter@gmail.com>
 <20260921164749.82070-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921164749.82070-1-sj@kernel.org>

On Mon, Sep 21, 2026 at 09:47:48AM +0100, SJ Park wrote:
> The patch 1 has wrong Fixes: tag, as I replied to it with two options to path
> forward.  Speculatively assuming your preferrence is option 2 (adding this
> series with fixed 'Fixes:' tag), I applied this series to damon/next [1] tree
> with the suggested Fixes: tag modification.  Let me know if you want the
> options 1 (squash it into the incomplete fix [2] before it is merged into the
> mainline).
> 
> Unless you want option 1, and if this series is not added to mm.git in short
> term (~1 week?) with option 1 update, I will ask mm.git maintainer (Andrew
> Morton) to pick this.  So, no action from your side is needed for now unless
> you want option 1.  If it seems I forgot doing that or you cannot wait for my
> action, please feel free to ping me or Andrew.
> 

Hello SJ,

Thanks for reviewing both patches!

I used b73198a47ffe in Fixes because that commit introduced the problem
with the temporal tuner.

I thought a Fixes tag could also point to a commit that is still in a
maintainer tree. The tip handbook describes that for tip [1], though mm
may handle it differently.

The hash can still change in mm-unstable, so the tag may need updating.

I also found this reply from Andrew [2]. He says he tracks these fixes
by filename and folds them into the original patch before moving it to
non-rebasing git.

Maybe squashing is indeed simpler here, also for backports.

So either option is fine with me. I'll leave that to you and Andrew.

[1] https://docs.kernel.org/process/maintainer-tip.html#ordering-of-commit-tags
[2] https://lore.kernel.org/r/20260313091738.354244f6fb500bef3bad1fa1@linux-foundation.org/

Thanks,
Karl
