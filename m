Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B903C4576
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774595662; cv=none; b=ddDaFOKOFhOFW7uGqWvHOL1rYbO9Bv8xGUhQdIjSxdr77bBXYGdVjELj6fA783cY0OGnfstk2YgklrogxHOZwt0mtCQeWJvLn+gnxqhT3PUP5WTWIyiY/7l7Pjn04OM9aNv8WbwCk+1BQe0Vc0miXyyrZ5cXHPoSyKWI3GF/9SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774595662; c=relaxed/simple;
	bh=T5Ir1rZYK3bL6Vcyz+08GQDpvfnKnhYZedwUxLjLbCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pP0hM1Ewvt1AsGMGR6sF3zZU9h5vftR5JKj3ZAaIHV5rCcY54Efrx+kC5OLHYfEehWUxlgTOFdZUue7v5wV+S4FvRsb1+UJULf56rmOST6QPxDpt+3yUZDzP+a4LClIGLPuWkCHtGQHC2ejWXRpZ7LERj88vsA9/SKrL3gVwdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUbitXIt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUbitXIt"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82c20b9fb16so831470b3a.0
        for <damon@lists.linux.dev>; Fri, 27 Mar 2026 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774595654; x=1775200454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZzuSLhFEjANxlJ2fyZwwyQQ1OfEXmu8TUE3Vg6THPg=;
        b=lUbitXIt/SqLoa0pWnBlH3g+21SkKNFzSLNFaMNA72yfLBjkkqXObQXAma4QTat2CW
         aSOXhFosDXwvbnpcm86Kk+X70yoKtVVPppcWwX9tkFrJEWu81YIFFTJ0BfWFRsM3qhg8
         6A2fk+oHm9zjEegOJN0Vv6rxYYkFWqn+b3wPuI8qFSWVIWibaFWprDSoPiRdXkOWI87h
         6is4796+jRTrkEqb5IKnyObkkRbmzCUMG8yOn6662VBoRTQJbwooTdNkMAIi6/4r7wu8
         35NC9cmDpRbg7j6ByPNHYsJyIfhI21LHQD+9DUBUBNtXZmpPcX/OUuh4iO8LGZbiq8kP
         Q53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774595654; x=1775200454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZzuSLhFEjANxlJ2fyZwwyQQ1OfEXmu8TUE3Vg6THPg=;
        b=pyWkAwoBJsF2fzZnabjrsdERS2srsWJ7netdvVXb6JAeuYl9KT/kS8dzEcqB1xvU1l
         fHLdIQc5GcPV/Zc8ffDaykiEkrrdPkI1wjx85jZMnDnOzwat7nDs4oCKpiOuUQF4gcl2
         SZBgw1yZ4sv/L8NQA1/5bEIaOr+vdgrY65QKjemURb7tePVp7KwFVw6xMETR7FcGk+Lg
         413syfOnmOA5wGqFTR/pALuHzxPVkZtxliTPds0xD7qBoTwN2BTbXezoS+kAWYSaIunc
         21pSizWlr7bJH/yQm7obM+VoMZd+knvnkzqxrgmYSkAclVFzvQG+bMgmcWVidEafDn31
         FDfw==
X-Gm-Message-State: AOJu0YykyWUEQT12+K+2BLVGgEejs26KeriP/NxFBMjPOlIBAr0uXwDd
	wsrqwpiE9AXKkx8EZDGHtkE9de7MMWzM4BqaKm5VbfZAlc2s8eN30Wpy
X-Gm-Gg: ATEYQzyg4zes4UtHx6DcyDlgp5o/IUGPoasFCLewu+Wdcojop/I4g1YJdL9hdS+CcQS
	0463tUILNzt8P5rzmWN6mXb+JIVdKYtnp0sD7Jkyh4KyttgBlLf4WFPK7A3T2F+12pGZheda6aI
	3BsG6rjZpXAb9CItGz9NaKcganx0ySdadEl8Nl1vtiZO/KcsTBp10RHCCLGvCkghUb4BXWdtBmo
	GUwZKObhiSzTkF14cKqs5u9ay8Lzf4pAYoJsayWWqhsMBZQ7HTIUWIOsDF6RWAjiwTuueBZQPUT
	eRJFUxwe/+D5veWtgLmNSLlqj92Tl+XHGY1gTqOMyI+VVYN51sS4ARm5J/xwG8HYG63gxpDJ6UT
	vj3dEXFb6pbD/1vOT/ny/tKRpjLJAwtReSNVXQZYAegfyoDlv6mncbyffC7nRDwXR0yI3VFejEW
	C2W2p9lpy1MT1vE3dA25MwXD/P7OE=
X-Received: by 2002:a05:6a00:9084:b0:82a:8aa:cbb6 with SMTP id d2e1a72fcca58-82c9607f50amr1358487b3a.55.1774595653812;
        Fri, 27 Mar 2026 00:14:13 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3c1374sm5208488b3a.44.2026.03.27.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 00:14:13 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [RFC PATCH v6] mm/damon: add synchronous commit for commit_inputs
Date: Fri, 27 Mar 2026 15:14:10 +0800
Message-ID: <20260327071410.73642-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327070400.71707-1-aethernet65535@gmail.com>
References: <20260327070400.71707-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260327062558.66392-1-aethernet65535@gmail.com
> # start of sashiko.dev inline review
> commit 405545126e8bb145d7fb1fbb4f36016bc1f6c42c
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> Date:   Fri Mar 27 06:25:58 2026 +0000
> 
> mm/damon: add synchronous commit for commit_inputs
> 
> This commit modifies the commit_inputs_store() callback to use damon_call()
> for synchronously committing parameters in the kdamond thread's context.
> This change aims to ensure validation errors are returned immediately to
> userspace.
> 
> Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d72976..453033f3cb3e 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> 
> [ ... ]
> 
> > @@ -349,18 +348,47 @@ static int damon_lru_sort_apply_parameters(void)
> >  	return err;
> >  }
> >  
> > -static int damon_lru_sort_handle_commit_inputs(void)
> > +static int damon_lru_sort_commit_inputs_fn(void *arg)
> > +{
> > +	return damon_lru_sort_apply_parameters();
> > +}
> > +
> > +static int damon_lru_sort_commit_inputs_store(const char *val,
> > +		const struct kernel_param *kp)
> > +{
> > +	bool commit_inputs_request;
> >  	int err;
> > +	struct damon_call_control control = {
> > +		.fn = damon_lru_sort_commit_inputs_fn,
> > +		.repeat = false,
> > +	};
> 
> [ ... ]
> 
> > +	err = damon_call(ctx, &control);
> > +
> > +	return control.return_code;
> >  }
> 
> If damon_call() fails, for example returning -EINVAL when kdamond is not
> running, err is set but the error code is never returned or checked.
> 
> Will this cause the sysfs write to incorrectly succeed by returning the
> default control.return_code of 0?
> 
> Should it return err if err is non-zero, or control.return_code otherwise?

Thank you for reminder. I will add
'return err ? err : control.return_code' back in next patch.

> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da14778658..03e3300ce607 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> 
> [ ... ]
> 
> > +static int damon_reclaim_commit_inputs_store(const char *val,
> > +		const struct kernel_param *kp)
> > +{
> > +	bool commit_inputs_request;
> >  	int err;
> > +	struct damon_call_control control = {
> > +		.fn = damon_reclaim_commit_inputs_fn,
> > +		.repeat = false,
> > +	};
> 
> [ ... ]
> 
> > +	err = damon_call(ctx, &control);
> > +
> > +	return control.return_code;
> >  }
> 
> Does this function have the same issue where the return value of
> damon_call() is ignored?

Yes, it have the same issue. Thank you for reminder. :>

Best regards,
Rui Yan
