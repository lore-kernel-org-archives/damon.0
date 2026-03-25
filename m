Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF5285068
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423034; cv=none; b=QOlsk8RupbDvqJrO7y5lXgVQiUPk46/ACSJMasb6Vkz86+aHQ0ctBnWmblr1EYptpfNBmbLF+F/S4omonQZOjGv9NBInovTnguQNjEkbjjT848vycUNJBO7ioAvzTzjj0tiM429PFq1kdnXWfm5m4qWJQhxBhSsOuT7k+h1haaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423034; c=relaxed/simple;
	bh=HAHeMoWHoGwcyaqVp62f8uAAGF4JwSHo/E3w9IU2xsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyNx49eLVpcXApOL4WnMKlkb6eqa2Isu2aCOpIs3P2b84m57vdOSqyl+T6Gh5wzynP6v6neWp1i526zogWu8SZ5hiyKXbn2PC+v0MabgKonA4mpNTVwXooqvbeJMHEwKdogHfx+sepTSgxA+BBpFrLgKfxWlNGOqek37VaZUS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4qj3XX0; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4qj3XX0"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7393536e53so2027908a12.2
        for <damon@lists.linux.dev>; Wed, 25 Mar 2026 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774423032; x=1775027832; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A07CuX0FMbAmsm6wPhYwAIxkhxeIbAc+QWngeTZUts=;
        b=I4qj3XX0UWf7aK9A3USchbnZbagkoLTPEV+DS5UZJEZn9N3d9yZQC6B4ibuBG8pcjb
         2+wYA+nJ36FL79FLmbFDjuLOnfH4MDLBBriKpgZdt9RTyJWoRsusIkhGaz8QEWZIRufT
         9UNx4dhtZKNqjrri6ss0nnLTXmPNDFqxhkgLnjGnuvHKFTKM9ux1AwtIvJUgY29CrqNI
         o3W2fuX8JnvbNgmeJxxSpZT0DL8c4A2q9QdN08bdV8U5RHXqiCu2Sxq/xhkYjt8840IC
         M6xXOQTyv1u4IT2I1/AH4eAA3hMyc2YkOBB23GlMCtaRjI1F0I5aGKPUv9TflFtX52g7
         2UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774423032; x=1775027832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3A07CuX0FMbAmsm6wPhYwAIxkhxeIbAc+QWngeTZUts=;
        b=tFQFy9LasqxFF364Py9iG9QzIMpem1QQ9vS/783IqMw09/VGsbslwIxpRkCI5be/Aq
         Aqq4FvdrnnpAHYVaoOxkEX1NcwvsnPTNxG2Cu8H3poMQ1k8AoD9r6DsMM0xrMHLDAi7P
         tcO0+RuPNNE96EddypvY161UpXOB3jetw10aKVk56z+WtOFINM8Dabj4rFOjMRlP1PEs
         bsP2m5ncz0wQLcxNWdHpMHCFM+tCPRMD2v/TyuTjGHmxMiu6HS6w2t94aj7e54dCMQ71
         ZN9e0zxPsI8gzeaFA+2lKBSpYBMnLuMT/2EqwrFBKkcon3FOYnBf6nzT12DsUCiGYt5f
         E3WA==
X-Forwarded-Encrypted: i=1; AJvYcCWHloR9nYN1DU/qNkXqp+PSFeKxPXbanLf43GSTGLDSwRz+lg2haPq2au9I9H/nJgSeYjxwZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxW0QPcN796GuqotIB+ZcgJgC3aMbceEXRHpUZVvZE03k8GOo4K
	hx1zJ5zwZdj8ovOoi8jsF9iM0A3WCsPCXm8S+CDUfAAX7eAuSwI+8jKN
X-Gm-Gg: ATEYQzx5eKMlQvjumvxaf2rwxzrfE1jyrrpvkNKmQVFAgVZeuuiFiHSgzAiMilEa0Ha
	5dt8hY5u6XEKWi7854Q/C4QG2bJt8CcBB8uebBx28NnX2lzyIRd/a173giIaV4yq0NhZBqH7tUi
	u4+vFOWVjKKCH3LdYIX1qqNkVKGcj7xPo/tDBxf7o5nKUcIq6yWGr0+Pi3nDB1f8xvKQ3zlzxBE
	LdFbp31KemM6VbJ1/jtmvuLDqW0CyKUopy+EIm7BDu0LIIrI67MNv884nlHxHRpcjVPzfvL9LLF
	+UrbACJ8Tt4IaHjW/zIK5kdxTuIqw6fEXKZ88jywGI/7SuKElEMwO2kc2iHuKfPnh3RbelaLQ+i
	szBpIrB7yz1rQVVCwEP5EQRtXR8wJuqhYML7xLHjCdmZjzy616faBzz+qoUZaR5Ra1z3Mqj/w+T
	M5sEX/eF3U/uBVNlu5geuxlsRo25Ji4K3c02exdYmFiA50YJuSSMY=
X-Received: by 2002:a05:6a20:7352:b0:398:b16f:7058 with SMTP id adf61e73a8af0-39c4ad64abbmr2830633637.40.1774423032398;
        Wed, 25 Mar 2026 00:17:12 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409f409sm14369493b3a.31.2026.03.25.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:17:11 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC v5] mm/damon: add synchronous commit for commit_inputs
Date: Wed, 25 Mar 2026 15:17:09 +0800
Message-ID: <20260325071709.9699-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325025317.86571-1-sj@kernel.org>
References: <20260325025317.86571-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260325013939.18167-1-aethernet65535@gmail.com
> # start of sashiko.dev inline review
> commit 60ccea4154b0c58741fae2323454a5a9496b67fa
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon: add synchronous commit for commit_inputs
> 
> Writing invalid parameters to sysfs followed by commit_inputs=Y previously
> failed silently. This patch uses damon_call() to synchronously commit
> parameters in the kdamond thread's safe context, returning validation errors
> immediately to userspace.
> 
> Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d72976..a2410f648b51 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c

Thank you for forwarding the review from Sashiko.dev!

> > +static int damon_lru_sort_commit_inputs_store(const char *val,
> > +		const struct kernel_param *kp)
> > +{
> > +	bool commit_inputs_request;
> >  	int err;
> > +	struct damon_call_control control = {
> > +		.fn = damon_lru_sort_commit_inputs_fn,
> > +		.data = ctx,
> > +		.repeat = false,
> > +	};
> >  
> > -	if (!commit_inputs)
> > +	err = kstrtobool(val, &commit_inputs_request);
> > +	if (err)
> > +		return err;
> > +
> > +	if (!commit_inputs_request)
> >  		return 0;
> >  
> > -	err = damon_lru_sort_apply_parameters();
> > -	commit_inputs = false;
> > -	return err;
> > +	/*
> > +	 * Skip damon_call() during early boot or when kdamond is
> > +	 * not running to avoid NULL pointer dereference.
> > +	 */
> > +	if (!ctx)
> > +		return -EBUSY;
> > +
> > +	err = damon_call(ctx, &control);
> 
> Can this sequence lead to a system-wide deadlock on kernel_param_lock?
> 
> Because damon_lru_sort_commit_inputs_store() is a sysfs .set callback, it
> executes with the global kernel_param_lock held.
> 
> If kdamond_fn terminates (e.g., due to an invalid parameter like addr_unit=3
> causing a non-power-of-2 min_region_sz), it processes its exit sequence by
> calling kdamond_call(ctx, true) to flush pending requests. After flushing, it
> eventually sets ctx->kdamond = NULL at the very end of the thread.
> 
> If a user writes to commit_inputs exactly in the window after
> kdamond_call() finishes but before ctx->kdamond = NULL is set:
> 
> Thread 1 (kdamond_fn):
>     kdamond_call(ctx, true);
> 
> Thread 2 (sysfs write):
>     damon_call(ctx, &control);
>         if (damon_is_running(ctx))
>             wait_for_completion(&control.completion);
> 
> Thread 1 (kdamond_fn):
>     ctx->kdamond = NULL;
> 
> Thread 2 will sleep indefinitely in wait_for_completion(). Because Thread 2
> holds the global kernel_param_lock, this permanently freezes all module
> parameter sysfs interfaces system-wide.

I have verified this behavior with the following test case:

    # cd /sys/module/damon_lru_sort/parameters/
    # echo Y > enabled
    # ps aux | grep "[k]damond"
    root   70  0.0  0.0  0  0 ?  I  12:16  0:00 [kdamond.0]
    # echo 3 > addr_unit
    # echo Y > commit_inputs
    bash: echo: write error: Invalid argument
    # ps aux | grep "[k]damond"

    ... kdamond has exited unexpectedly

I will add a patch in v6 to validate 'addr_unit' in addr_unit_store() to
reject non-power-of-2 inputs immediately.

> > +	if (err) {
> > +		/*
> > +		 * If kdamond is not running, damon_call() returns -EINVAL.
> > +		 * Remap it to -EBUSY to better reflect that the operation
> > +		 * failed due to the current state of the system.
> > +		 */
> > +		if (err == -EINVAL && !damon_is_running(ctx))
> > +			return -EBUSY;
> > +
> > +		return err;
> > +	}
> > +
> > +	return control.return_code;
> >  }
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da14778658..4cbd67e08d56 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> 
> [ ... ]
> 
> > +	/*
> > +	 * Skip damon_call() during early boot or when kdamond is
> > +	 * not running to avoid NULL pointer dereference.
> > +	 */
> > +	if (!ctx)
> > +		return -EBUSY;
> > +
> > +	err = damon_call(ctx, &control);
> 
> Does this code share the same kernel_param_lock deadlock potential as
> damon_lru_sort_commit_inputs_store() described above?

As we discussed in the RFC-v4 thread [1], this is a false positive.
Since 'enabled=N' and 'commit_inputs=Y' are both serialized by the
global 'kernel_param_lock', and kthreads cannot be forcibly terminated
by userspace signals, the completion signal in damon_call() will always
be reached in a controlled manner.

[1] https://lore.kernel.org/20260323021648.6590-1-aethernet65535@gmail.com

Best regards,
Rui Yan
