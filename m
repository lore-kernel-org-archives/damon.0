Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA7302753
	for <damon@lists.linux.dev>; Sun, 29 Mar 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774778166; cv=none; b=OHj8ov6Ja2Q8o/eG0GaIJ+dGCTCOSXt+Ckw2Lvt+nXTHmW+xhfrYaYlGJJbaHwdKXWPAHthJMEaSqRheZX6QCPUyzIn8J9KfRFWeA4XoYDhF8Q7zEBf/yBd8QWvi0H5utPltFdvBuJG3qjuAqS3yLCCbT4E7qAYJpdZZ4vhCXAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774778166; c=relaxed/simple;
	bh=NXEUZdAHVPKuMWcv6mZrU5rz3UVRXNDX3brEV+sCT54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEeS38MCYnjiyNX9bHfOW3BN0qxKYyaze9Vfm4yaYlT38aFeOv1b3IhARLp50/UQ3OQiMKJH8RCVXgfPnSxcqnxnnd0AIRCK3OrHMnW6LLDbbStSU8F2/VoUiSAZTCIKFC3/L932sHkkCYz40nVP6G6b1XJssBx4No2WDSS8Xng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn8vKSX9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn8vKSX9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a871daa98fso27432455ad.1
        for <damon@lists.linux.dev>; Sun, 29 Mar 2026 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774778164; x=1775382964; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0Sqb6Fhd08Evxd/ft0GWEl2Yd/g++AIRyWxcaAdZr0=;
        b=Gn8vKSX9m5FjkjgkFagpPQ/m6JRywVwQuzcJycWUXhetUlGSdXbaKkT9Eng+UWcZXO
         Rpj9barOJnzZ1iqm832pUU0xH/GpKRLmWPdWZB+WZOODxqwz9rDciJ59iEpzl6bVn4LT
         NcEemXijyicfuza32is0weDDAjtN+C0ncVUfnON5HlRCCOxalGSewr5Po+JotgwHi0RX
         5lGxZAQt8zT8dpkCcqr+RtkrPvMLNlgYxwWibQhQTJ+BnNyn9Ba/orDPH/z70NTSNeqH
         N38b61XGyuqmDJmllPwoGpKjd5Drrq1QcFQAuKoToZ5IezPabcqUG0THhRO+aXf7PNjW
         sIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774778164; x=1775382964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p0Sqb6Fhd08Evxd/ft0GWEl2Yd/g++AIRyWxcaAdZr0=;
        b=EA5xxhTqXPtnjpxEgtd0EqVvQDaf2zu/tQ/9DIJmlzDf5R9xqNewBOiAVWcHSaFQVA
         mLMOKAwIue7ocPDucFKXQgKVuBrcvSwDzSHiw4CZPOZvW6RCo+zhyXceaadgVqu8xa9G
         zVkK/d7AffW9pY2Hj8ZEXzkFm4DgWjIMuj3IBKlErtflt7HLNOyFnDJEVTJCpxyFVP8F
         Mx8pMiWZpJlWvCTNmdlaH0RfSmpPFMGrXFvXTNZ7n2YkaVfsXqnpytEabQrvS0h4VcGC
         CFokLsQiJoegJLZr+wzLLI974JniT42Web3tLlmN1wdyy7X8LvfSf3g8ZWEcpQaZODXu
         y4kQ==
X-Gm-Message-State: AOJu0YwpRWyOyZtyBDRxMib9BFyXoyx9b+n5WB9DwKhXhL0iRMhrfwqo
	qpYEi4jhEHH1okyPayJQtHKPCPih0ANCocWxkBhuj319+9apfo+w0WiZ99eGmA==
X-Gm-Gg: ATEYQzwnDM4e5nK7lRtlXPAlIW8mw/zNC5xxQ3gqH2BVNGwOy5dQki0tfdCJQjs6zHk
	XO5Ag+jAo7OnGrQgG/JZ6at2rup3pTQDAbc8P7f24ll8QNFZSRoOSXXuotf5pcJt9Odkv+OppMA
	D1FpcHXMTxMNozzNf5jcHGfEd/qF1ItMBrHo6YpmixXUmAI0YwzNX7pShADSYGcW7w6mFK51Aws
	LCKuTn3IB84qikJHxMl+iopXi9ffBGe0zPaPZVwjThw5YY5rI3fzq20AqihpVRnRczX3hLNTVZg
	79IxsL6Ftmd9h+jTkcvr7OE2ZLllTrtyrcMnNZcc6A+F5M2AV79apAdNv/2p27NF8Kyjvbr5bNf
	ezaTVUqEAL5JOXPwjNXGywofBohf5VBsNWazLCEGjZLHnzYDFoFhkXPJyJMa3WYyFtAIX0H65sh
	Ni3lolZb7Pi94RNH0O7Rol396AFKXxIwWvtAoHx2veIwDydGki1S2AJwpgBvPKAg==
X-Received: by 2002:a17:902:fc85:b0:2b0:c451:ae98 with SMTP id d9443c01a7336-2b0cdcf1958mr82436185ad.43.1774778164397;
        Sun, 29 Mar 2026 02:56:04 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642956sm48385955ad.6.2026.03.29.02.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 02:56:04 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: [PATCH v2] mm/damon: add synchronous commit for commit_inputs
Date: Sun, 29 Mar 2026 17:56:02 +0800
Message-ID: <20260329095602.3471-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329075415.36775-1-aethernet65535@gmail.com>
References: <20260329075415.36775-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260329075415.36775-1-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 2fe50c13aebc88839d89dd3cdd5944c18c25dc9b
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon: add synchronous commit for commit_inputs

This commit modifies the commit_inputs module parameter callback to
synchronously apply parameters using damon_call() instead of relying on
asynchronous validation in the kdamond thread.

Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
[ ... ]
> @@ -349,18 +348,51 @@ static int damon_lru_sort_apply_parameters(void)
[ ... ]
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
> +	if (!val) {
> +		commit_inputs_request = true;
> +	} else {
> +		err = kstrtobool(val, &commit_inputs_request);
> +		if (err)
> +			return err;
> +	}
>  
> -	err = damon_lru_sort_apply_parameters();
> -	commit_inputs = false;
> -	return err;
> +	if (!commit_inputs_request)
>  		return 0;
>  
> +	/*
> +	* Skip damon_call() if ctx is not initialized to avoid
> +	* NULL pointer dereference.
> +	*/
> +	if (!ctx)
> +		return -EINVAL;

Does this break module loading if commit_inputs=Y is provided as a boot
parameter or via a modprobe configuration?

During module initialization, parse_args() executes module parameter
callbacks before the module's init function runs.

Since ctx is initialized in the module's init function, won't ctx be NULL
when this callback fires, causing an -EINVAL return that aborts the
entire module load?

> +
> +	err = damon_call(ctx, &control);

Could this synchronous call break backward compatibility for userspace
scripts?

Previously, writing Y to commit_inputs while the monitor was disabled
(enabled=N) would silently succeed and apply the parameters on the next
start.

If the kdamond thread is not running, won't damon_call() detect
!damon_is_running(ctx) and return -EINVAL, causing writes to fail when
the monitor is off?

Since this is a module parameter callback, the global param_lock mutex is
held during its execution. Does calling damon_call() here cause system-wide
latency spikes?

damon_call() blocks on wait_for_completion() waiting for the kdamond thread,
which only checks its call list once per sample interval.

Will this stall all other tasks attempting to read or write built-in module
parameters for up to the duration of the DAMON sampling interval?

Is there a race condition here with the kdamond thread termination that
could result in a permanent deadlock?

When kdamond_fn() exits, it flushes pending controls and then sets
ctx->kdamond to NULL.

If a concurrent sysfs write triggers damon_call() after the controls are
flushed but before ctx->kdamond is cleared, damon_is_running(ctx) will
return true.

Will damon_call() block indefinitely on wait_for_completion() because the
thread is exiting and will never signal it, leaving the sysfs writer
permanently stuck in D state while holding the system-wide param_lock?

> +
> +	return err ? err : control.return_code;
>  }

[ ... ]
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
[ ... ]
> +static int damon_reclaim_commit_inputs_store(const char *val,
> +					    const struct kernel_param *kp)
> +{
[ ... ]
> +	/*
> +	* Skip damon_call() if ctx is not initialized to avoid
> +	* NULL pointer dereference.
> +	*/
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	err = damon_call(ctx, &control);
> +
> +	return err ? err : control.return_code;
>  }

Are these same regressions present here in damon_reclaim_commit_inputs_store()
as well?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260329075415.36775-1-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260329075415.36775-1-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
