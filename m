Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911C36215B
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789443067; cv=none; b=dxU2m0nSwiqg+4klw2Q+VHKDLum2JZfFECAteIsrp9UA7vEyWjG+NSYJcqOjRrJCwHUa0T7reVreQ2Y5V10esaEdXYqIyfSSn5mmK5FyLAEQmZJAESbXpwvsQSlp4lFnTDoDlLbQOBUoGa599PSg8M9Q2gSXu/j7recFAw4XiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789443067; c=relaxed/simple;
	bh=s+LsBuhIlfs/w0lJnlNuOPSGSL6VueLtw5zs57ipXSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7PWRtNWKAzkFiQ1ASxY+yVMZA6imPkahWoX/wpCIyVN8YcFKR58r4g49yqgmlk2QhdN9n1aOqViBsSmR6L8K/fCXxgv7UhMeU7uTdZpISqrUQe4gY/Z2Ze6irWHVPV2jp15lIfegXe5modhlDIwMJYYwy0l3ElDVyXIDkXEh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4AJ23ue; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4AJ23ue"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c6920so2540756a91.1
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 20:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789443059; x=1790047859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7nWcLz8pfZOPdgnq2ek5GovUDuRsqxFmdnwCI+6u6U=;
        b=i4AJ23uellIMBAXm/n5ybSgqHOIsyvVaNKnySrOCAoqj/uT47G9vrKfNlJYx13uoo/
         K9Jm9lAhnGIHj8dz47RODtge8mCdgVU2FOOtVEzPl0lYZIrnuPc7cqz3ymdlp/Iz/vYX
         15SH57Y6gU0EQtvT7SCmqp59AL8TqEet23aPOk7DhV5cn83Kz//yy4jcaxnbhALwfVmP
         93G+CrYTGHuvLnvs9z9bKoHmPdM+r+ND16BFuz0021R+dWNuhlWiP9Y30JytkC98Enhq
         TPpkAZzJkucQpGHHaomrap78fFPKix5gi/oS9qFYm7PSH7/AoAZFFU4WWkdSE2uqGJMJ
         1F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789443059; x=1790047859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7nWcLz8pfZOPdgnq2ek5GovUDuRsqxFmdnwCI+6u6U=;
        b=wusb2qHmB6qawk3SFJhofsI3kFQi8GVmW23YHp0eMWWS4B+U3ZHj8OztPSI9fJ7n3a
         x03tKant487yXZlKPmxmk8fHKuJdvT3W/iIzzcKR2Ctm+Jct7oTASzkVPpse42WnJxBt
         YZOMnXc3go3gEyn1ExOYRRCUc4F8r8qVwJWVatDJ9068X4Pv+cymuTl++4H3BDYO+Lwj
         NCaO5Y83H7aLhHoc/L9G90mjjVHbhV3sCVBvAWTlIdfFkC5axxVKykLETig1P6ansq7S
         ZqsqWPD3Z8vBXqd2Sh1p4XBahMsS600GbHFjNyZNyjPIWuQB1IC34mTEmwJVSZU3oMU0
         dw7g==
X-Forwarded-Encrypted: i=1; AKwUvBwBDqhqHVHHgJefQA7Hn7RAOopwwo7TUiiaVqf3bkAAf3GU491yZYkaig9H1wEUcspJXxgBNA==@lists.linux.dev
X-Gm-Message-State: AFuF++kC5PdBNnVpBAPJGynzMZP2o43R45IEHviQAJbP8PEMOEWms+xB
	6pg7V245WcSpmlzchcIOywagk1hGGsIuna0aqFgCljsui1w+4BA+/n4DEgbik1gB
X-Gm-Gg: AYBFou0RFc/n340zEItiJmvHdVqpzEogyUqQ1Rbf9C3eIBX9f4bDwIdrhsDK1Jn9xHC
	63bmYZy0n4VZyb2yhIlKhwJTyyTld14rny7cpi6+BUjr0BYLKSz/rMoRt8W/9mylRpj9kkK3kCC
	biU5zMDWn++p+mqv5QsfXJrtL920dG+bi0IXai1KLDrvsRW7NFAbzWAZyMxbfE6bK3QTEUeP8/J
	BbDc6G7yAP4ptgMye5yijeqDj1g8RUgka1S8jiWCxoYA4asbuMxjiOvCAMiBeuWoqWlB/je/yCB
	o/XxR0Ptu8OD0ZNmGYPkc52fgIU/BEE5M8/oh+vM8l5FTbz/ypKsazJT0NLZwCIN1T6zzyMp2pA
	HgGhVWNUCWUiDkrRZ77AAc9XH3TgBkXahoE9uAh0buknFIA5q/O6TJdmnV3mxU2uRDV7XBw5Ch7
	FesuDu9Ltn6lEbAfZrB03U9+Wgx6P5zAyd/TLTGDsQVtXXdTyo4O91KDayn5BYUfRjQlxwnA==
X-Received: by 2002:a17:90a:e7cc:b0:39d:fe64:5725 with SMTP id 98e67ed59e1d1-39dfe6461f0mr4210211a91.5.1789443058917;
        Mon, 14 Sep 2026 20:30:58 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm31317478eec.24.2026.09.14.20.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 20:30:58 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 3/8] mm/damon/core: return an error from damos_commit_filter_arg()
Date: Tue, 15 Sep 2026 11:30:49 +0800
Message-ID: <20260915033050.1579457-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913171706.103052-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 10:17:00 -0700 SJ Park <sj@kernel.org> wrote:

> damos_commit_filter_arg() is supposed to always succeed.  It may not in
> future, for example, if the given filter is invalid.  Prepare the case
> by modifying its signature to return an error when it failed.  Also pipe
> the return value to its callers and let them handle the error.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3d7a973ea8b6f..ea7d8d5a4abf6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1317,7 +1317,7 @@ static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
>  	return NULL;
>  }
>  
> -static void damos_commit_filter_arg(
> +static int damos_commit_filter_arg(
>  		struct damos_filter *dst, struct damos_filter *src)
>  {
>  	switch (dst->type) {
> @@ -1340,28 +1340,32 @@ static void damos_commit_filter_arg(
>  	default:
>  		break;
>  	}
> +	return 0;
>  }
>  
> -static void damos_commit_filter(
> +static int damos_commit_filter(
>  		struct damos_filter *dst, struct damos_filter *src)
>  {
>  	dst->type = src->type;
>  	dst->matching = src->matching;
>  	dst->allow = src->allow;
> -	damos_commit_filter_arg(dst, src);
> +	return damos_commit_filter_arg(dst, src);
>  }
>  
>  static int damos_commit_core_filters(struct damos *dst, struct damos *src)
>  {
>  	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
> -	int i = 0, j = 0;
> +	int i = 0, j = 0, err;
>  
>  	damos_for_each_core_filter_safe(dst_filter, next, dst) {
>  		src_filter = damos_nth_core_filter(i++, src);
> -		if (src_filter)
> -			damos_commit_filter(dst_filter, src_filter);
> -		else
> +		if (src_filter) {
> +			err = damos_commit_filter(dst_filter, src_filter);
> +			if (err)
> +				return err;
> +		} else {
>  			damos_destroy_filter(dst_filter);
> +		}
>  	}
>  
>  	damos_for_each_core_filter_safe(src_filter, next, src) {
> @@ -1373,7 +1377,11 @@ static int damos_commit_core_filters(struct damos *dst, struct damos *src)
>  				src_filter->allow);
>  		if (!new_filter)
>  			return -ENOMEM;
> -		damos_commit_filter_arg(new_filter, src_filter);
> +		err = damos_commit_filter_arg(new_filter, src_filter);
> +		if (err) {
> +			damos_destroy_filter(new_filter);
> +			return err;
> +		}
>  		damos_add_filter(dst, new_filter);
>  	}
>  	return 0;
> @@ -1382,14 +1390,17 @@ static int damos_commit_core_filters(struct damos *dst, struct damos *src)
>  static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
>  {
>  	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
> -	int i = 0, j = 0;
> +	int i = 0, j = 0, err;
>  
>  	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
>  		src_filter = damos_nth_ops_filter(i++, src);
> -		if (src_filter)
> -			damos_commit_filter(dst_filter, src_filter);
> -		else
> +		if (src_filter) {
> +			err = damos_commit_filter(dst_filter, src_filter);
> +			if (err)
> +				return err;
> +		} else {
>  			damos_destroy_filter(dst_filter);
> +		}
>  	}
>  
>  	damos_for_each_ops_filter_safe(src_filter, next, src) {
> @@ -1401,7 +1412,11 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
>  				src_filter->allow);
>  		if (!new_filter)
>  			return -ENOMEM;
> -		damos_commit_filter_arg(new_filter, src_filter);
> +		err = damos_commit_filter_arg(new_filter, src_filter);
> +		if (err) {
> +			damos_destroy_filter(new_filter);
> +			return err;
> +		}

I re-checked this version, and the error return from
damos_commit_filter_arg() is now handled at all call sites,
including the new-filter paths.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

I'll take another look at the remaining patches.

Thanks,
Kunwu


>  		damos_add_filter(dst, new_filter);
>  	}
>  	return 0;
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
