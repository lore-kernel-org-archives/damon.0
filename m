Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D851BC2A
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774690567; cv=none; b=gGOz3+7Bd6IS0TkxQzc5inA+3hpvWTQa7CRPPNnQf1s6jaYLGUDe7qrGfb9X/No8nQeoHRxhwkJYXkhzJL7MxtfsYzrhy0Gsb/WDcYoCRyJx47wYA54o3Z0rcdgLtvhw9+edhFmRaIqQyun4+U6k1rOAWrgw9lONPY3653Sj92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774690567; c=relaxed/simple;
	bh=1HfcQmVwUhbf2dGpWMP9a7YKEL9E/fACPHRqg4CHmIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGgQi7Q7fQ0TmTVRL9h4ahHaF1r0KTUecTo9C4hXKddDSbGqQgJZ12Ram5FlCl16DhDEIu2Gxo3Bo1OlZQsKlpIT1hmH6XNZfuAEFWaJH8k4M/ESIhk+32r4FiJWF+nhOduoq9cLffSMLYtF59ifJfmeR4CB6OjnfLY4ebSUN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfKxyDbi; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfKxyDbi"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70c112cb61so1910946a12.0
        for <damon@lists.linux.dev>; Sat, 28 Mar 2026 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774690565; x=1775295365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0tXXkVj9kz6CKSAsrdagep4arIWjfRejhsyyWUGg9E=;
        b=cfKxyDbiMM2u7h4z6AkYNFeE6MsNEyiQR9ZzfQ8deTquCDPmjIq/kGVfPGp/TrKorf
         4cd21eiYLZNJOYKAGKtVJKhRsDwPwkLMSTqq0epghvbi3na/WufU5BV1Xi7o1EnUnv00
         FqJ4glL2epL2K2NVMkzc/00WDtWdKQa2rKb1bLzQ3Xks6UjRovCVstHjHrWLQ7pkraE4
         fFF39I/mqKf8WIM3DiKLo8a6sGRynqrwrHUOy9eSiUip5nFVJV4PSAhs4T+Gcs/LLY2w
         xxXwQzR/LGDlORUJl/H75yA9cIAoTowk1bEPPGe6IROCaVha2zPoS+4V+mI2JnBrQViR
         sWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774690565; x=1775295365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0tXXkVj9kz6CKSAsrdagep4arIWjfRejhsyyWUGg9E=;
        b=mUrLkrqATRgDhciLKxXdZnxGE8ugDZhn13bd4TB3H+sbFd98hjHBmC8gPqBj5n9DJN
         eNtzM1URV6nku471sluN/uSzAT6CebCiIXnND6IeONjUUa2QwDgCN6NoB1sR8EluiLhv
         QSIF7Zj3eu27jBszSxqGx9kkwW+D8FP2RcQh11zBEdDB6V3iM/aol00u6t0jwFM9+5Z2
         g/H8DxZpKx2iw0Aa22KlJ0pz4KkZhRBAmWkDiXUO1qVpPPgzRwKt44Mzj6oI/yIwm9Ac
         9kavnksHx7MOUZOuO4PHgJoyk8GHqMLZGjUMGUZMx6SCu6T4Tr6sG9KwTIpxNvyXlxMc
         xBsQ==
X-Gm-Message-State: AOJu0Yy8JSt67rvo2YCvGHYFH1fAHXIXQlvd/Si7IYZHTW3bpu3Kpw/i
	o9tSVg3VGsYpL+pVo8/ROPIUX4AQRGiYzzWYAumYGHwwB7Z74H32wXeD
X-Gm-Gg: ATEYQzzFRutwKWSSnl6+iTGcJ7l78ycZD2MdW3eUV8NBin/WBuEnQLjaUOc7xCW0AeI
	OB3i1UjlEzr6UTk3ENSs9dhYJ63NZa9xbRHa/aXhWzgdzvgKZLuYkJslZkzxJZko7IDJnKOjM33
	Tq+3qAMYpKRbRvQpz89NfxZA/xN47Z/6YnQepqDkPxwF/C+nnLNT4Jt+shBTDNuV+vDGIT12CFM
	kD7+ACK7e80DlQjP3Wblj/z+CX2Tf8NScHVL1KaEOjX6+7Ac/rYwbw8Qps1PIXZg86zuszJr7nz
	THf3K1ykOOGKBLtJDYnc/Ne0fbIWGgrDZQ4ZSHucSg1+Th1zvFPpT4uN2sD1Vfp2gjXcNGcKAmC
	xSUjSpBzfBgK8k2vuXrPoOVhCCESHwZT0c6EzGUPWrjz38h5loxZRrRAjYNC1uZwxTg4faDx4Vg
	KnsptRyurUn0PFI1rxdDo55dyGRiAH3A60MNrajA==
X-Received: by 2002:a05:6300:218e:b0:389:8f3f:50d0 with SMTP id adf61e73a8af0-39c87bd1042mr5399440637.60.1774690565116;
        Sat, 28 Mar 2026 02:36:05 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc735sm1550427b3a.40.2026.03.28.02.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 02:36:04 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [PATCH] mm/damon: add synchronous commit for commit_inputs
Date: Sat, 28 Mar 2026 17:36:03 +0800
Message-ID: <20260328093603.10052-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328084524.5451-1-aethernet65535@gmail.com>
References: <20260328084524.5451-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260328084524.5451-1-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 36139818bf6b2abe505ab824b951e904796bcd67
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon: add synchronous commit for commit_inputs

This patch modifies the commit_inputs sysfs parameter to synchronously apply
parameters using damon_call(). It adds custom module parameter callbacks to
return validation errors immediately to userspace.

Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..3af6854ba3da 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c

[ ... ]

> @@ -349,18 +348,46 @@ static int damon_lru_sort_apply_parameters(void)
>  	return err;
>  }
>  
> -static int damon_lru_sort_handle_commit_inputs(void)
> +static int damon_lru_sort_commit_inputs_fn(void *arg)
>  {
> +	return damon_lru_sort_apply_parameters();
> +}
> +
> +static int damon_lru_sort_commit_inputs_store(const char *val,
> +					     const struct kernel_param *kp)
> +{
> +	bool commit_inputs_request;
>  	int err;
> +	struct damon_call_control control = {
> +		.fn = damon_lru_sort_commit_inputs_fn,
> +	};
>  
> -	if (!commit_inputs)
> +	err = kstrtobool(val, &commit_inputs_request);
> +	if (err)
> +		return err;
> +
> +	if (!commit_inputs_request)
>  		return 0;
>  
> -	err = damon_lru_sort_apply_parameters();
> -	commit_inputs = false;
> -	return err;
> +	/*
> +	* Skip damon_call() if ctx is not initialized to avoid
> +	* NULL pointer dereference.
> +	*/
> +	if (!ctx)
> +		return -EINVAL;

During kernel boot, start_kernel() uses parse_args() to evaluate the kernel
command line. If damon_lru_sort.commit_inputs=Y is passed, parse_args()
invokes this callback before the module init function runs, so ctx is NULL.

Since returning an error from parse_args() during boot causes it to skip
parsing remaining arguments, does this regression break the system boot
process by dropping after_dashes arguments intended for the init process?

> +
> +	err = damon_call(ctx, &control);

Since this function acts as a module parameter .set callback, it is invoked
by param_attr_store() with the global param_lock held.

Could this cause a system-wide deadlock of module operations? If a sysfs
write occurs exactly during kdamond thread termination (when kdamond_fn()
cancels pending calls but before ctx->kdamond is set to NULL under
kdamond_lock), damon_is_running() can falsely return true. This would leave
the sysfs thread waiting forever on wait_for_completion() while holding
param_lock.

Additionally, prior to this patch, user scripts could configure parameters
and write 'Y' to commit_inputs even if the monitor was disabled, and they
would be applied when started.

Because damon_call() immediately returns -EINVAL if the kdamond thread is
not currently running, will this regression break existing userspace
configuration scripts that trigger a commit before enabling the monitor?

> +
> +	return err ? err : control.return_code;
>  }
>  
> +static const struct kernel_param_ops commit_inputs_param_ops = {

The previous module_param(..., bool) macro used param_ops_bool, which
includes the KERNEL_PARAM_OPS_FL_NOARG flag. This allows parameters to be
provided as a standalone flag without an explicit value.

By omitting this flag here, does providing the parameter without an explicit
value now produce a parsing error?

> +	.set = damon_lru_sort_commit_inputs_store,
> +	.get = param_get_bool,
> +};

The commit_inputs_store function parses the input into a local variable
commit_inputs_request but never writes to the global commit_inputs variable.

Because param_get_bool reads the unmodified global commit_inputs variable,
will sysfs reads of commit_inputs unconditionally return 'N'?

[ ... ]

(Note: The same regressions appear to exist in mm/damon/reclaim.c)


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260328084524.5451-1-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260328084524.5451-1-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
