Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0633A5E78
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774595053; cv=none; b=nUBDBAYlCXT3U9dMRh/N7VGk3xXoMCZD0smGOEgtM+IKM5ca62jfTvB4Sa5ZnGGZ0qWWcRSRUytu+CJxdnIklEEAGs6QlptpaBk6MRX5t+qLWm/23iHrHZ1eDkugEvDfNtPpgSV84tNhfPcsFDGl3CfDe1lmUi5ezhz5aGBJpBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774595053; c=relaxed/simple;
	bh=J+8bbihLhx8j64l0e6SUfnngBFgdpO79jWyQOo/pQ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpcZ7i79lNB0jrrLGkN5O3SQCqH4ELUgHTTLpzIGVzbUPSqGw9r867prZGHm0lYc/ev7RqbHhId/zt8s1/egqli3d7UtwDhIZvWwIhFYuX2Et9668v+t0Lw33Pzk1t1ctCiDdFxZCAWstF/nLCRws5mvFDZk6iXqVCQDh0lvIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KytnqBYW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KytnqBYW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7393536e53so733555a12.2
        for <damon@lists.linux.dev>; Fri, 27 Mar 2026 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774595043; x=1775199843; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJl7pDB0zfAjMt3lYRTDqHzTHNLB8U/7DHfn4W8ruLQ=;
        b=KytnqBYWUP5dO4Ti06jCu7xQCy7ZFgKjQYY7ipmlD08bkabMt1Q+1iMLqRuEmB/Fun
         LnlQ8d/LNalmMwWFW2yltwaFw+i4frPt+plb4sIDVR8TwN/ejf67bOxVfALKnxRJPgUw
         3vPn1XZ0314BDwyvTutCn/PGJTqvoKL1yzypRC2+1Gh9omsUED7kzzqeq2DdlIXvecNZ
         N8v7WpsBShTMsEzx1RxOdR74Jd2mcrhVBCjM5FBECj+1pyfCSJnk9x4kOdoPXnheouhU
         TMxLs3iS5mljidp/jjD97NWfrlYexsokixkFULgeQFsEBSk/FGQkAK5vlEvB2M2BDpKW
         8N0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774595043; x=1775199843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJl7pDB0zfAjMt3lYRTDqHzTHNLB8U/7DHfn4W8ruLQ=;
        b=UNTnO1K379+nPoF4ssS4Y5F+w1OINnTlf5cBF07fAPr0qg1f77EKnfw3Dh5VAKwRdb
         B7p8d6iILmzvf4efdTg0EpxfZH4D8o66LliNjPWjpylP/E24ffY8H8E3srTmBNTvcy4i
         lTVg1Ij4lx0RDNGmJPmu7BFGqGgqDbQ//J2OtcCLhdg3g41bTsTtfWYJBm0rUCIAcJr2
         IBrP90CS+VSdgFpmVxgTQ6v7dx7AIbeCr7SDqPezehPWlx0rqS+eSag9n8sonn1LC233
         AiH/+LYmTiOgFEVFNWZZQIsiYqbD5Sxg2zKMHKVgv8lY1iwohL0wfgIZ3SwAf6lcv7Cv
         LP3Q==
X-Gm-Message-State: AOJu0YynjcZu4R2KTvhZngOHmSHEy3kmDSUezsfY+8mk2IvJZwC9urgR
	Oi1vAV9czaZVbNcKwwCHp+IhyuvSnDqrMpgiPy8MVoMCr7ZXzGkyN3f6
X-Gm-Gg: ATEYQzwv1ORIHu5FcVljJ3rmljmEHh7FezNYmoBFCVKzlLgrqh/Q7r3Na2jt9WMWcAz
	HD92DrEOSk5KMuEaMQYWoXMhEFaN57hg9K8gcr787UB1mcGB1u8gomi63XIIoyjEGI6oVH589Dr
	0f5Kt1gH7D48LTPF3p6vC4eomD777Bp3eHCe0cWKMCBX97CEiIChGCNvv/4Uo7YNcXPJEFyAnME
	seDGQUZl/5EWjOLs5ehCrj4c6g15gp8fBDvbyqUD63ApS4dBTi4NS/BG8TheK8UxcHpaw7fW9Iy
	73XahQO9r7ZZQTYYE+ivb/2WJQ6/yY1abfPGJuEfmkGQROH90rDKNtvSOPmSA9OIBZMAbLThYsF
	Xv7VGvSyMhC6Jgf6B9j7G6nHvvh+mnJWeuHOJCIkcdhcPChP+g4aAmC9XksY34eb/yBtx9nvI0n
	/4U7RHh+EtI+FyVNEAixMA9C+aTSgo6TdxmU5+fg==
X-Received: by 2002:a17:903:19d0:b0:2b0:afb4:7d41 with SMTP id d9443c01a7336-2b0cdc02e54mr17965755ad.10.1774595043512;
        Fri, 27 Mar 2026 00:04:03 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc883c0asm53376215ad.45.2026.03.27.00.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 00:04:03 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [RFC PATCH v6] mm/damon: add synchronous commit for commit_inputs
Date: Fri, 27 Mar 2026 15:04:00 +0800
Message-ID: <20260327070400.71707-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327062558.66392-1-aethernet65535@gmail.com>
References: <20260327062558.66392-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260327062558.66392-1-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 405545126e8bb145d7fb1fbb4f36016bc1f6c42c
Author: Liew Rui Yan <aethernet65535@gmail.com>
Date:   Fri Mar 27 06:25:58 2026 +0000

mm/damon: add synchronous commit for commit_inputs

This commit modifies the commit_inputs_store() callback to use damon_call()
for synchronously committing parameters in the kdamond thread's context.
This change aims to ensure validation errors are returned immediately to
userspace.

Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..453033f3cb3e 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c

[ ... ]

> @@ -349,18 +348,47 @@ static int damon_lru_sort_apply_parameters(void)
>  	return err;
>  }
>  
> -static int damon_lru_sort_handle_commit_inputs(void)
> +static int damon_lru_sort_commit_inputs_fn(void *arg)
> +{
> +	return damon_lru_sort_apply_parameters();
> +}
> +
> +static int damon_lru_sort_commit_inputs_store(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	bool commit_inputs_request;
>  	int err;
> +	struct damon_call_control control = {
> +		.fn = damon_lru_sort_commit_inputs_fn,
> +		.repeat = false,
> +	};

[ ... ]

> +	err = damon_call(ctx, &control);
> +
> +	return control.return_code;
>  }

If damon_call() fails, for example returning -EINVAL when kdamond is not
running, err is set but the error code is never returned or checked.

Will this cause the sysfs write to incorrectly succeed by returning the
default control.return_code of 0?

Should it return err if err is non-zero, or control.return_code otherwise?

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da14778658..03e3300ce607 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

[ ... ]

> +static int damon_reclaim_commit_inputs_store(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	bool commit_inputs_request;
>  	int err;
> +	struct damon_call_control control = {
> +		.fn = damon_reclaim_commit_inputs_fn,
> +		.repeat = false,
> +	};

[ ... ]

> +	err = damon_call(ctx, &control);
> +
> +	return control.return_code;
>  }

Does this function have the same issue where the return value of
damon_call() is ignored?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260327062558.66392-1-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260327062558.66392-1-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
