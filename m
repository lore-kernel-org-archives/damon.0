Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B9403AFD
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339731; cv=none; b=XAS08SlTFtJ8se73wDYLDWffGxnHUWRy1hVkAB0FA7sJYegqvygrc/P9XjgzA23EzxWpenpbCzYlfksLFFZ0qH32JaPJlVsDOTNwInY77AovmE9giSWuTqtIF23DinlwNgRKIlc7iBlESQ4mWGdLWprbzjQDDmrNCKsA4KIUB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339731; c=relaxed/simple;
	bh=LE1FGay9sT7mvcDPSk+q0IW+U2idHpKGbrIWVgYjQao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9SQgikUOTQBMjMDVwW555F3pqZHDg2tf8gYn4HkReGl9VaAjAM7k42VBdwrwTeM6XqPKGUgoNVu/sATI54Nz8aDqJrrHBhfk7DKyOyKeVAl19b9ufRmooQA14xCqjat+WzztTXD1uMotPvI82/XdXdzwtJV22zCDap9iziqKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEgZsAAJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEgZsAAJ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-853c947bfefso765782b3a.0
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788339729; x=1788944529; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fy8D77TbbTZZuJ5DhR2JoC+KqjSKdSPnzBcIAoctkic=;
        b=sEgZsAAJWqNsQcOE2l0bkmYLlYmUv5fFPxpvLiOzVR7Xu6NX3E2rfmxtKggCHDDUNY
         MSFmtI+0u8069ntKfIaOhyrdCx1AmQLDb0WDf8mi5dQs3wiHQslMx+diH/XAOWYNkpBs
         OHukMEoEg8fkglB2zlJiRicQQ49HgKmaLe05l6lEjd/wr2AmFZ9ERpSShJ9yc9zT02gO
         5Kge7hyyfefmg+Cq/KM55crCcf8TdQf3T2TvgU1xxebhGwCO3G23/p6J6594UviJNhf5
         IHPQ/6L1WMRpRVMk2JZyJVhYa8yCUtqyeA/4gHZny2IwoqKvU3mimsoD5ZBR4qW7iGCV
         z3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788339729; x=1788944529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fy8D77TbbTZZuJ5DhR2JoC+KqjSKdSPnzBcIAoctkic=;
        b=LHnni8cFGQJP0lVj5eJUvRv+N0xFKJzi/UzdbKFZJXsLwrY9ChK/23GhNS3MRrhbk4
         ju4TQvZtmrzJIEJ05Kdeug253rsyHRVxM+7kYV1Br0qPPx4RvSkh6Z9R3Uca0GxA3pSZ
         iam1LtJYC3yOXaitMIOceFDcDGVm7vFlINisD1MXe3irp7d1wDZ9neia/o0dFzXiB4n7
         bgy5UOTrWf+xJvGi4WNg2+jh1sKJA3qgQtofXXY5HbCiPQsrGAdcIlkSmBO58l7tGKzd
         36lh3hDuabvEz2NDcrnuonjBubTghACfA277/KZC+mSnO1xFqiFHe+3UMvmiKNKixpSI
         5VfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxF158l84e4UIyEK969dp12VUxEboxLrAEqnO/87z1JKG5uqHHPhZGLBkSsiIJcVEQYqgAiyQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n805XZcpqHrxlTI+MVxBiGeB1raFZKYB0ZBKIQ4uzgRdjDRNgR
	o94+0s5gkfcGt81wKt5CNx9TTL3vKNltLoQPCj5UPzF0KvJq39UH2qsd
X-Gm-Gg: AYBFou2cMhHOiIh85bI3PFs+GC0xhDm1xbh2YRpCRdMjWtUOX//DDGzi0Gpp7aqVk5S
	PrkdFcxiImGF+ERkSZJR65pTUI5VpEwtASarSXP+v07rVEKMChhYUGrFM5wdyB27IScQCB0iZeX
	hzJtLljw6m30cvpm0kKaY5BNGTydvyeaHhlptUO1FP+X2JyGcf9Nr4vKV7Sz65z9fZfCSkSSVCl
	g+EKIKrN5zylfYUcucgBXtE/UNdvPq+SwXlSQJBAxiC76O90scHDVlRVEtPRHJHzujYkHwD55v+
	lAo+xjPZQsRt/sygJWBKtXIGHutSTrUdVPOE9jh3H4S8a0c28K5afG8/FDzrWSXPmMddCQz9jqp
	Fdzyo7OrQkvtdGq+bn2sDQhr+BkZFiVyASxsocIbUl4pmS6Cijqfuqeadu6mDlpWPVXf0404QRo
	B6wW5UrmnHzqfcF9JMs8BiaCC60NLn0bAE74q7kEWNGuY+wJZqj4pwys2OTB0Uki/Um4+OSYDkQ
	zwfc8psCzGFEzTOqQ==
X-Received: by 2002:a05:6a00:7099:b0:848:48d0:934 with SMTP id d2e1a72fcca58-85f448cdd36mr1124512b3a.18.1788339728703;
        Wed, 02 Sep 2026 02:02:08 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db23f7b8bsm1038728b3a.2.2026.09.02.02.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:02:08 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	sj@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix false positive in
Date: Wed,  2 Sep 2026 17:02:17 +0800
Message-ID: <20260902090217.29968-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902081825.18931-1-aethernet65535@gmail.com>
References: <20260902081825.18931-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 16:18:25 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> When setting goal_tuner to 'temporal', if the goal is achieved,
> quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> will always return true, even if no regions have been tried to apply at
> all.  This causes qt_exceeds to increase unexpectedly.
> 
> Fix it by:
> 
> - Returning false in damos_quota_is_full() when quota->charged_sz is
>   zero.
> - Adding an early exit in damon_do_apply_schemes() for schemes with zero
>   esz.
> 
> Fixes: c7ec7d5f6b3d ("mm/damon/core: handle <min_region_sz remaining quota as empty")
> Cc: <stable@vger.kernel.org> # v7.2.x
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
> 
> Changes from v1:
> - v1: https://lore.kernel.org/damon/20260901105925.106186-1-aethernet65535@gmail.com
> - Changed the check in damos_quota_is_full() from '!quota->esz' to
>   '!quota->charged_sz', because the former is an upper bound, while the
>   latter represents the actual quota usage.
> - Added an early exit in damon_do_apply_schemes() to prevent a scheme
>   with zero esz from being evaluated by damos_quota_is_full().
> - Changed patch title, original title: always return false when esz is
>   zero
> 
> ---
>  mm/damon/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 8e3ded1a2cf6..de78ad56c8b3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2560,6 +2560,8 @@ static bool damos_quota_is_full(struct damos_quota *quota,
>  {
>  	if (!damos_quota_is_set(quota))
>  		return false;
> +	if (!quota->charged_sz)
> +		return false;
>  	if (quota->charged_sz >= quota->esz)
>  		return true;
>  	/*
> @@ -2666,6 +2668,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
>  		if (!s->wmarks.activated)
>  			continue;
>  
> +		if (!quota->esz)
> +			continue;
> +
>  		/* Check the quota */
>  		if (damos_quota_is_full(quota, c->min_region_sz))
>  			continue;
> -- 
> 2.55.0
> 
> 

Please ignore this patch.  The title was truncated, so I've reposted it.
If Sashiko provides a report in this thread that differs from the
reposted version, I'll forward it as well.

Best regards,
Rui Yan
