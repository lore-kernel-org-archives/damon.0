Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72A1EB18E
	for <damon@lists.linux.dev>; Tue, 22 Apr 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318293; cv=none; b=Ge+RP7XNPa3ABLms/vOom51RANMWYjT6LxrF36A+kEccAiu1DZJRG8Tuu8SjctL1iSgxGy8NA43s/4mzLPnidST6osfbe5VA/z4rKMSDeTkG35NEm0NOFPjNg0In9jyXSwx1xjfyRXZN0vdhhm5BHqEQrAkxlgXz9iMGMNvhCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318293; c=relaxed/simple;
	bh=Z6c8uzRwUL9CRemIiGxumCOt8oUxWa50U/RnhdvAm6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUZixHolmUViYOGfaXYBm+zawNWmw1kyx7H8bTOcj6m1oBYTuZbh5L+8HowRmCq64597HihWF0CyDEko+YAzZftQvku2kshMSRsMBb3gXtkUfs9xfl5vEjiidDDjP/hBh86JG8EEKnh7J3o0QSbHO8ksz1AM904pF/44AXFLVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xLVknmxt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLVknmxt"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c14016868so4911552f8f.1
        for <damon@lists.linux.dev>; Tue, 22 Apr 2025 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745318290; x=1745923090; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x36ME9YCkgctStKKRl+yxhgMtdLAC+ajKdEDhmCB47Q=;
        b=xLVknmxtviCkqfLugrBXq24rRPgzaxI8fksp1lw7piPOEFrRmDSoVjW70jwS6q14V+
         ecbKT4TJSu/BjPgoCW3GbZLkyWBDbgwuucXhzwrDE83BjgPrs+P6FmFdxAonkfQv/Ua+
         dXdOKapRjkccuS9VCQiw5/UTFOOiAZuFIq8R/RLZt+a+B9wMBT9jFe8JgpTW3c7m7g6D
         URJyEE3mPoSohgkxH6S9xH3udbbw62+YXmebams6znNVTFISe1UF6NzzMfbmeHVQuGeT
         hBFNASPhzELgQTyLDbsDesIcht2mZcHgdU9Lj7X8iNgU/h4dvDt3jy3J3kGfm6LvXh7a
         ePXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745318290; x=1745923090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x36ME9YCkgctStKKRl+yxhgMtdLAC+ajKdEDhmCB47Q=;
        b=VA8sY7aXuxc8prfLLJygDbIsd4BIQ+NbWxRtrm0OP8fyxoykfe996xEA2kyGt7fnQz
         6p2XfVFZ0yldwzNlFtZpUSjM6F25dPcZwWKhJ1ZFNSo22Is0xWNA0gUp+Qr7hINssCmS
         ivhbG4HbaaJv4lUd3Wuq73Ev4aWJ5UAagAGJsGYE/Awtk7SKUSCI4q63I9gyegBa4gl+
         9MujzTolIK354WYJgAOeK+ybBZY6+82QN//Vni9Zn8UIUSxThauYAMe3PYnzuBPhSodc
         JWHA+ed5cHn7fdeh19BlHNqJM3lFcWPyDHM0jqv24+ecpUu268U7NvaELF/Lo0/wHUeo
         tqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQd3W6movde5pZfZSBNs4dCY3kQvLm5nJuZVDg+DXVmOjfMDhagwMbZ/7t5ahY5Mqyo437vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkcumpEm3kduTefwQ6+H/IvZfrU2wwgmXsftJyjA++4z295k5M
	44t+EKDnR3OeNhs9oya0cNRDT+H8DZgwcOyolw+R78C4WhR+P1U6uB4DnB1Tz2E=
X-Gm-Gg: ASbGncuRnASu0qJKkVbaDYEbgXDUvyWSywOyBrPvOAByw/3iSq9fODtKA3qEUS7jjzE
	HRRcM2mcAnNM9sxV7fknrx+wq1Bmy8h6uk90nJYrYByE/+CQYyfALLalRypnUddNvaAeDm87MP4
	x4nivm316+1e+V5ahs/uUrhclglVBriL3EoIDC9PYt0ZdRWR23yAg8LfPAnKX3j4v59DYRh6U5M
	uP6yQExwszJG79J+nvxhq/0Kz9LCJeSaL6JiyRzSWvTZJSymTAdO9wJChquWHPLgafHp/c7le77
	MrJjg8YHaocZS2G0V7UHJPZLByThXTXlaQ+j/ZzR/I1atg==
X-Google-Smtp-Source: AGHT+IHmdZrRl8dVYpwJVQVgKnWXt370mTD794FHi8G5zh54eb5aEDf4XYuBmeYKL/FdPLvQGd7cdw==
X-Received: by 2002:a5d:64a5:0:b0:391:4914:3c6a with SMTP id ffacd0b85a97d-39efba5c644mr10470205f8f.29.1745318289843;
        Tue, 22 Apr 2025 03:38:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa421c79sm14615464f8f.1.2025.04.22.03.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:38:09 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:38:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and
 size_add()
Message-ID: <2713f419-760b-4ccc-aeed-de9c4c899506@stanley.mountain>
References: <20250421062423.740605-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421062423.740605-1-suhui@nfschina.com>

On Mon, Apr 21, 2025 at 02:24:24PM +0800, Su Hui wrote:
> It's safer to using kmalloc_array() and size_add() because it can
> prevent possible overflow problem.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  mm/damon/sysfs-schemes.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 23b562df0839..79220aba436f 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -465,7 +465,8 @@ static ssize_t memcg_path_store(struct kobject *kobj,
>  {
>  	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
>  			struct damon_sysfs_scheme_filter, kobj);
> -	char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
> +	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
> +				   GFP_KERNEL);

Count is clamped in rw_verify_area().

Smatch does a kind of ugly hack to handle rw_verify_area() which is that
it says neither the count nor the pos can be more than 1G.  And obviously
files which are larger than 2GB exist but pretending they don't silences
all these integer overflow warnings.

>  
>  	if (!path)
>  		return -ENOMEM;
> @@ -2035,7 +2036,7 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
>  	if (!memcg_path)
>  		return -EINVAL;
>  
> -	path = kmalloc(sizeof(*path) * PATH_MAX, GFP_KERNEL);
> +	path = kmalloc_array(PATH_MAX, sizeof(*path), GFP_KERNEL);

If we boost PATH_MAX to that high then we're going to run into
all sorts of other issues first.

regards,
dan carpenter

