Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE513793C3
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774694695; cv=none; b=Jq94wzdFuB5jzklInYsOvyMTSsI53pjqYL4/7xHqeLSEc7oK/BVectQFSc0BYQIEmvo7kHskLXFVBSKbQuA1XMMVHn5Chuo1jUXCwomQ4m7cGOwMmpEuq1wZRjZDaWyres10vXXaJzqmhza7vXESlTu+8y3JR1YOhGJIWlAG100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774694695; c=relaxed/simple;
	bh=lunpHWZIN4mSF6XY6ldEqUaeBsMjuBgc5yxGOh5odwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQy6hYd9b07oY8oJTSh4idFsslo0tvw9DK1dT786EL/6+dmYCCEyVI+nOO9R5EqqB9eTsDm78HIcDqFfL0ZRjENurBL3gylPtBnGgblbpgKC87uCKmFbVnOSeaO9pRMa3JdZbZ/yLIbsE1Cxoj++84GfyBE8qqzTaSt1jPwQuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti/IpO5H; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti/IpO5H"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c206f0481so2612050a91.0
        for <damon@lists.linux.dev>; Sat, 28 Mar 2026 03:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774694693; x=1775299493; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6mIvddxM5IjpL3Qx7QZ8ftx4Ml3402nVTogMhOqdes=;
        b=Ti/IpO5HVHpTX7P051dixGux8cdaE9+V9QwsGhVQfqf3UpvIuNirDKx2LmZSCJ1PBL
         O71vbzMaT5LcqaR89gUYOUDKsXAxpjo2bBLuhFvMs1vL1Icn/dpH9LtUY5A3Duarb4pl
         GTJ2bQ25lD3NGu6J9EofiesMiiUp/eqFz0V5CXvMtikG1psHSbgPLRbI268gwEhStAcs
         ychiiX8PyrHI7KKFvX2WTCULpz5DmyPPi0NRHiegqkOesgfhCvJ8Jt9B7tnM8wbD8cQW
         ab0R1uPfxIBPD0y8NyorcLGheDNi/NCcUrkBkldURxaLL+2xqoPdPri1duoHrsrdvL4D
         QsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774694693; x=1775299493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v6mIvddxM5IjpL3Qx7QZ8ftx4Ml3402nVTogMhOqdes=;
        b=e+2Mv1Q4g//HSRhCziDhK87y+Rcqs8nhBZcWQPy2bO01W7VeD5X+M9uqDUO2fbi8y7
         KN2rhaPyuCVwitmbU8h36CPpy3GDffb7a6lc6OEF/RUGCxKbHHTsHhgbApanaBcd5B8i
         /ZeU4Yhm2SuJTYj6tqZALoyKZIM9qDvlG3pDzQcyFFAelN9KXjINBG4oTxJe8KamsgRS
         8ORLdppLopvtZgjfNPo/QFGX96DYbdxvJZTcgxX/QAXpmz8wl8SSP2NTEpKfwnteskfL
         9710RiboWQUiX08lDxmLQHSExivM9aGbwacIQY4sz/CVZQulN0PlUZIlv4XpDCil3P8P
         eSYQ==
X-Gm-Message-State: AOJu0YwOSQS4mTkJ0hgYzaj22+LYqvS9A5P8X/QumRm+TdkCvZqaPcmj
	2FfUn1HOpaafPw+Fmx+Dc8RSYFB+iN+Ao2g7KJdp+Ec27zfpRPsC2EN9
X-Gm-Gg: ATEYQzxyqEpPng+RZdGwBadl+y1VTr+hOkx08mi6Hte7iN4eupWk71g4RZNT7C9IMDE
	2cPK75kQ8MZWMv2xMTtlPEhWQsehM/2eVoCwNZeO5L1aU2YNLf5F65oOhJ2so10RSThA/4FouNk
	A2mHs1bpMntAjgjZueZlky9M6UvDmYB7E3hTzeCRc7lzX3MxEm5oJBINkMhzXq2TDMC8rdNEbNg
	QtopOCJye/PMl/aoq4qqg3+ot13akeSfAj7S9tvGM/9GRiIhqa/MhMJYE2ss3Sm48WLJyqB9y2q
	27qEIsLpMxVHr9yXTtr/Xwzv/mkGYhNOfC8Kc1t19NupxUeMWVFegx4EcsDSLyke3zOt4yI5ktN
	8VJxn7fcF1WWFN5FTrZMo5MIiCeWWXofLIa7KNKGBjL7XXdCOy7V/UMNDO7Mi2f7IID5HADkyWu
	5ywKcbrUaOgOGzZFmWbNt0JleHrks=
X-Received: by 2002:a17:90b:1850:b0:35b:b52d:f34d with SMTP id 98e67ed59e1d1-35c2ffaffdcmr6074190a91.5.1774694693018;
        Sat, 28 Mar 2026 03:44:53 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a82231sm10415940a91.6.2026.03.28.03.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:44:52 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com,
	sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] mm/damon: add synchronous commit for commit_inputs
Date: Sat, 28 Mar 2026 18:44:50 +0800
Message-ID: <20260328104450.14719-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328093603.10052-1-aethernet65535@gmail.com>
References: <20260328093603.10052-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > +	/*
> > +	* Skip damon_call() if ctx is not initialized to avoid
> > +	* NULL pointer dereference.
> > +	*/
> > +	if (!ctx)
> > +		return -EINVAL;
> 
> During kernel boot, start_kernel() uses parse_args() to evaluate the kernel
> command line. If damon_lru_sort.commit_inputs=Y is passed, parse_args()
> invokes this callback before the module init function runs, so ctx is NULL.
> 
> Since returning an error from parse_args() during boot causes it to skip
> parsing remaining arguments, does this regression break the system boot
> process by dropping after_dashes arguments intended for the init process?

This is a deliberate design choice. The 'commit_inputs' parameter is
intended to function as a synchronous trigger (like a button) while the
kdamond is running.

Regarding the concerns about setting 'commit_inputs=Y' when 'enabled=N'
(or during boot), I believe this is non-issue in practice. I plan to
provide an update to the admin-guide after this patch is merged to
clarify the proper usage sequence for users.

> > +
> > +	err = damon_call(ctx, &control);
> 
> Since this function acts as a module parameter .set callback, it is invoked
> by param_attr_store() with the global param_lock held.
> 
> Could this cause a system-wide deadlock of module operations? If a sysfs
> write occurs exactly during kdamond thread termination (when kdamond_fn()
> cancels pending calls but before ctx->kdamond is set to NULL under
> kdamond_lock), damon_is_running() can falsely return true. This would leave
> the sysfs thread waiting forever on wait_for_completion() while holding
> param_lock.

You are correct regarding the potential deadlock. But this is a known
issue, and SeongJae Park is already working on a fix [1].

> Additionally, prior to this patch, user scripts could configure parameters
> and write 'Y' to commit_inputs even if the monitor was disabled, and they
> would be applied when started.
> 
> Because damon_call() immediately returns -EINVAL if the kdamond thread is
> not currently running, will this regression break existing userspace
> configuration scripts that trigger a commit before enabling the monitor?

I understand your concern about backward compatibility. But providing a
'commit_inputs' request while the kdamond is not running, is technically
redundant. Since parameters are applied automatically at the next
'enabled=Y', the new -EINVAL response serves as clearer feedback for
userspace, ensuring that synchronous commits are only invoked when the
kdamond is actually running.

> > +
> > +	return err ? err : control.return_code;
> >  }
> >  
> > +static const struct kernel_param_ops commit_inputs_param_ops = {
> 
> The previous module_param(..., bool) macro used param_ops_bool, which
> includes the KERNEL_PARAM_OPS_FL_NOARG flag. This allows parameters to be
> provided as a standalone flag without an explicit value.
> 
> By omitting this flag here, does providing the parameter without an explicit
> value now produce a parsing error?

To be honest, I was not aware of the implications of omitting the NOARG
flag. It was not a deliberate choice on my part.

SeongJae, what are your thoughts on this? SHould we stick with the
explicit 'commit_inputs=Y' requirement for the new synchronous behavior,
or should we restore the NOARG compatibility?

> > +	.set = damon_lru_sort_commit_inputs_store,
> > +	.get = param_get_bool,
> > +};
> 
> The commit_inputs_store function parses the input into a local variable
> commit_inputs_request but never writes to the global commit_inputs variable.
> 
> Because param_get_bool reads the unmodified global commit_inputs variable,
> will sysfs reads of commit_inputs unconditionally return 'N'?

This is actually a design choice we discussed [2]. Since 'commit_inputs'
is now a synchronous trigger (or a "button") rather than a persistent
state, it doesn't necessarily need to store the 'Y' value.

> [ ... ]
> 
> (Note: The same regressions appear to exist in mm/damon/reclaim.c)

Thank you for your review. :>

[1] https://lore.kernel.org/20260327233319.3528-1-sj@kernel.org (Lastest
but may not the last fix)
[2] https://lore.kernel.org/20260323150544.81042-1-sj@kernel.org

Best regards,
Rui Yan
