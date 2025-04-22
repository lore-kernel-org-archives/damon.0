Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD681F1313
	for <damon@lists.linux.dev>; Tue, 22 Apr 2025 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318687; cv=none; b=bR0BUZUDSqF8+4g27Eut54MIESiEnuSiXacM95U/rN9wXUZwXzZ7Mi3eKO1g2WluV/zARS6ZI+UqIz7Xl2fuNAMrZ7L6SyniZvvKfg6dD/bmf8NrCuHegTEax77zzk4HZlWd6mLLskAxNzUhJX1yNHKts9IMct5kGL+5wrYwkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318687; c=relaxed/simple;
	bh=jaIK3y9skttjOZKNe7Pdvk/sD+BmWmSRwYZmKO1UDRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4tlijQaXbGkLyjO6JhkQYmUkyET8ZQlpHB1VqlxWp28tZjhXkfuwISi3P1BFv3CDmyConn7eL1m9rh2O3rENv/wCam4CdCQ8FQsIUkrG0cDAADbn/K1IRtxTF0B2Ufu553fd6Xw6zn1kwTG3rmAVWQCDpICCavOVXXczQ3OWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxxMfLoP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxxMfLoP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso41157665e9.3
        for <damon@lists.linux.dev>; Tue, 22 Apr 2025 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745318683; x=1745923483; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2ZlSb8C4TopIE9lOnaluqGxSWa7ZTy/niRKFxlJXsg=;
        b=NxxMfLoPpNdjA0inmXtg7booLBJNJnhOPFSBhJEq1B42nyG63dC841KfmFNnHH3vPy
         vyBcOX18iTu/NiPvbdgHmjupez0axkPumoxGYTr6cTBcYXD2wBA5GaMLB8NQV7EjkZnC
         x61gFhFgIAzOoVjxqwpHpofQuadN7/lVH8CDu5bntiDIVTVHfoKd/2Po1502GmV0AYKf
         19UDjYuM+2RXSVdiIf+jb+dHJL4/tK04kpkJAlXugkYux4RpkZiawX8kfymR5EMGkzXm
         MqNh3FRUAs4mwHbe5EkARhoBKxflu+YPZ11FmGjGlXaBEHXwUvQxW3rd3QzWe3nWnN1j
         bLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745318683; x=1745923483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2ZlSb8C4TopIE9lOnaluqGxSWa7ZTy/niRKFxlJXsg=;
        b=YGWVPVYS++Hav6PjaZ1t15nKSre3ubDfBYEdYE+QQFmlh1a0eqy0fM5XV84l87UzvL
         Xw2sz+UgtIDbWjPmWWbmUA36B+umhM1ksEium5oLmX2YLPMUgaqtsW0A1GS0UY4qqyrt
         3LeVWccEAFG/heaLcrRs2J0zkJT5JDRU6rTaWhqWMQP0FBLXRMJ3+h2vuG5UNoH9EMo6
         ndGW7+0Qp3SsMg0SyXFR+XP7EvWKe81c782juyad2nKIX+L50mPFDvRdlqPpBjukkmcx
         ZhAR8LgZKm8JRwVpeM4tkuk3/5mGOjIs8bDLZg4L0QtchjpAPGgykx6D0dfg8w6eLEJw
         sHGw==
X-Forwarded-Encrypted: i=1; AJvYcCU/KLhAaKsAuTnaQ42Y3p8efsdExrFmsQNqUZlLccEflHhV3TOZ30i3uF43nwOU09LywAdGig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/x27dJ9czRylsAqCrRmdCxOi2ywQDnmuRbkGnXP/9f+aBdJi7
	P9ZipNfFK1rUowS9AtDfjy6KlakPvPwOEGsyNwuli2Hq20BPT/8T/vSRMsZmcVE=
X-Gm-Gg: ASbGncs60fRMBJ6W2/ibyJlmiCR0o4J7CJXgKjBfQzERNSmzkxup38iC4+pvuBNemrW
	bvE/JchkGi0V6rukjQPhuUVBAxeAVA6Dhh7Wm6dmMkg5ozFsUZH43Pm4PqrL6N9GsmNPlgR2haH
	VVzMQwoMAyy6jQ5wAM/SEYKwy+pRqzOjLQCq8tmrn4WTZlOc0CAzpW2PflFno+7r2MTLJ7t9kgL
	ljKE7Cx3oVuVr9xpdtNoIWTV717SQy40APN+5KIGzRMJvJNVdhG2zisiM6XQ+uyq7tAtyDFV8r9
	UsoDWD9Z36qSSL9YdRedD426jkMgr+Bmi2d5F2kCYtl2r9jF8PcQAgBY
X-Google-Smtp-Source: AGHT+IGmQB87kk25ssevPLdZ7b8PjzlRTbK4qnCrbpA2fIVwAWfGo22Ft+WhXErpVr6BVQJ+4nZjZg==
X-Received: by 2002:a05:600c:5395:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-4406ab96f63mr141741765e9.12.1745318683311;
        Tue, 22 Apr 2025 03:44:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4406d5d712esm166577665e9.36.2025.04.22.03.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:44:42 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:44:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and
 size_add()
Message-ID: <adbc06d8-1a6c-4279-9596-d743505d64dd@stanley.mountain>
References: <20250421062423.740605-1-suhui@nfschina.com>
 <2713f419-760b-4ccc-aeed-de9c4c899506@stanley.mountain>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2713f419-760b-4ccc-aeed-de9c4c899506@stanley.mountain>

On Tue, Apr 22, 2025 at 01:38:05PM +0300, Dan Carpenter wrote:
> On Mon, Apr 21, 2025 at 02:24:24PM +0800, Su Hui wrote:
> > It's safer to using kmalloc_array() and size_add() because it can
> > prevent possible overflow problem.
> > 
> > Signed-off-by: Su Hui <suhui@nfschina.com>
> > ---
> >  mm/damon/sysfs-schemes.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 23b562df0839..79220aba436f 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -465,7 +465,8 @@ static ssize_t memcg_path_store(struct kobject *kobj,
> >  {
> >  	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
> >  			struct damon_sysfs_scheme_filter, kobj);
> > -	char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
> > +	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
> > +				   GFP_KERNEL);
> 
> Count is clamped in rw_verify_area().
> 
> Smatch does a kind of ugly hack to handle rw_verify_area() which is that
> it says neither the count nor the pos can be more than 1G.  And obviously
> files which are larger than 2GB exist but pretending they don't silences
> all these integer overflow warnings.
> 

Actually rw_verify_area() ensures that "pos + count" can't overflow.  But
here we are multiplying.  Fortunately, we are multiplying by 1 so that's
safe and also count can't be larger than PAGE_SIZE here which is safe as
well.

regards,
dan carpenter

