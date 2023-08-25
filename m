Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0234B193A0
	for <damon@lists.linux.dev>; Fri, 25 Aug 2023 21:32:35 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bf1935f6c2so10002545ad.1
        for <damon@lists.linux.dev>; Fri, 25 Aug 2023 14:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692999155; x=1693603955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1m0We/QAA4bFlLvCtmSKD6+YAm7eq6zVv5AOYCjTXaY=;
        b=MD0v9mnq5+jh/hdt9FGeSVC6ddK6V1lXXuzgHpftg4TO0eTA0rxNUCGV8uAAH4jp5r
         zdP53cAAGRqGflCgANRdLLRR9EEcNXCtujUpxiTIFOvBe4yfAH/IPjEqwEdRx6FBsYIb
         Px3/CcXTDnWyHRH2IOU/u5ysDJlOucStNwCBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692999155; x=1693603955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1m0We/QAA4bFlLvCtmSKD6+YAm7eq6zVv5AOYCjTXaY=;
        b=XsRv7rSAPIABt0F+4JPy+y5v78LfDr1HkR0Vav/SfVaQNWoBQQCfvGiJeBcVF8QUX6
         qF9PEWtro0PBtLrfyfIzuA1cSwHyhNUvM4qE/4v4YPRER55DeLhFOm2ITlqvQPdxegHL
         9YJT+1ROhYyIp/abnEV+SXApH2tY3jAaBnL6nY9WRtHXsnqI2oAz30TVTX71tvZsva9W
         LitWTOeKdZMz3MNKh3qkZxvu92RSL26wNB0qD304/xq426rrFA+NPL75fk5/E3pnAl1X
         I0xwh2veUuX5i7N0OxglEBCzhdqGUkpI32RYsEhWXrDz9WM8ylabroGuyt80y3jgJbT7
         H4Ag==
X-Gm-Message-State: AOJu0YzZfIUKBbMr5n9YdyXOPZz/93bFfrxNb/lXRtGP33G0Yd0Qdraq
	FN7DYi8N2EQ5T1dU4fA0vBHt+WZNUOHPx1LNqV4=
X-Google-Smtp-Source: AGHT+IFsAHLNa8Gh9Bds899eVcYt7j1gKgx8ArYRgxeMxNAvCgMFa4Ir2cXJQg1AiKL9zd2jVPSgaw==
X-Received: by 2002:a17:902:db09:b0:1bf:8132:d19f with SMTP id m9-20020a170902db0900b001bf8132d19fmr26111253plx.27.1692999155330;
        Fri, 25 Aug 2023 14:32:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001b8943b37a5sm2216722plb.24.2023.08.25.14.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:32:34 -0700 (PDT)
Date: Fri, 25 Aug 2023 14:32:34 -0700
From: Kees Cook <keescook@chromium.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Qing Zhao <qing.zhao@oracle.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/sysfs: add __counted_by() annotation
Message-ID: <202308251426.94092475C3@keescook>
References: <20230825020441.65431-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825020441.65431-1-sj@kernel.org>

On Fri, Aug 25, 2023 at 02:04:41AM +0000, SeongJae Park wrote:
> Commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> added __counted_by() annotation.  The underlying attribute for the
> feature is still under development, but adopting it can improve the
> readability of the code.  Apply it to four dynamic arrays in DAMON sysfs
> code.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 808a8efe0523..36a176f38726 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -93,7 +93,7 @@ static const struct kobj_type damon_sysfs_region_ktype = {
> 
>  struct damon_sysfs_regions {
>  	struct kobject kobj;
> -	struct damon_sysfs_region **regions_arr;
> +	struct damon_sysfs_region **regions_arr __counted_by(nr);
>  	int nr;
>  };

Unfortunately this isn't supported yet for non-flexible-array-members:

mm/damon/sysfs.c:96:14: error: 'counted_by' attribute may not be specified for a non-array field
   96 |         struct damon_sysfs_region **regions_arr __counted_by(nr);
      |                                     ^~~~~

We'll have to wait a bit before we can add this patch. Thank you for
getting it ready, though! This support is next in line. :)

The FAM support is likely ready to land, though[1]. I just tested it
today.

-Kees

[1] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/628459.html

-- 
Kees Cook
