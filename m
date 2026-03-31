Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF323DEADF
	for <damon@lists.linux.dev>; Tue, 31 Mar 2026 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973399; cv=none; b=VuxBdO9If0X7BXVYKM+9R0vmDHs2/qVHfnSJIwHQ7TF3k6haJMHBaWeQQ8HuTRmNm6G1MOe0qweDOdA7AYp/ag1nVAhjPQOo74wPRrQ306Qgnnia+TF1bElMBYSREI5v/auAzfRr89i9DK3TEfL6J+EcPXmiBBhD+++qV0PbFD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973399; c=relaxed/simple;
	bh=ZLlEsrzVnW1OKN9Z4UmoRO1HOC1SdhokarQuxJTI1nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZX1kkeoeOP4/hQwZJ7s2TvV9xA+ueKrRePcujpPB5ZQ+vQDQAbBY5H7PXwrYCIOaTvtwMM9F1vGfgiB3s/wSQ8bI+YH+Y2HWXRFiSgLuEqrMx9eeyA7BmA4EZiBQEJt953k1ugT09lOvKEqs7vZQh2Z6L5YutT786Pc+IjVnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb79vK72; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb79vK72"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so2356409a12.0
        for <damon@lists.linux.dev>; Tue, 31 Mar 2026 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774973397; x=1775578197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZGr9JAVPYs6bX/G9eK9B/dVw1nLkQ6GSmMoSIH+BAk=;
        b=bb79vK72hqbFCjvqMCvN1/Ve+BuhyNmn4vEs/RzZcKBqCpWlg015ubGlPO0bZYmEKk
         gmmn19q4y0IEWO5KUFzNn360hQgjZxSwgEx0eDObKCfazQnpnPHaTIS9GS+RAboY8HuU
         D6tsVYovX8K9Dom1l+VCMN+WEAhDcPOt9zFqFDHAJX0Q/K+6DCH/9n5x/XjV/cYfbxOH
         yUmXhJo9I4H/GcDfbHti3KAqrNY/h0LJjtb7s6ytwl3aSmtHvqLpMF2eZ7PWOEaMmlM/
         Mdb6iNKaTtSDfyKhpCJRlIazza4BEziCxZSimbukMUnZWgTlR1u3KPe5DOzciRTFPz21
         lm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973397; x=1775578197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gZGr9JAVPYs6bX/G9eK9B/dVw1nLkQ6GSmMoSIH+BAk=;
        b=KTZX3BBK3/TP1j6mhkfCPMERYSsYG/MZauUBkIVldGVI3NJbUxvLlr1eZwnmSjQuzX
         t+cGl+8boX8OE8KyWCnTAI16WwQ3Uwr0A1QN1j8XwNQZF9wGZNt4NUrie+OUqV2FZu3C
         vgw+SedJwoUYsT7Fnnt08YKVXlktkEbLBt1/5G2Z0aYyMpjkjt2KE7oLqgBK+AgQd+7e
         JSkGpjSdxyvS5NCFZERQWMOD07Qu9f+zlVk2V4UO9N3xJzZv+zvjmcIDMjokaf+VF5pr
         pvWkSvbkxxzbaoASNhCodM5Yu6F3Cz0e6txrv3SLLH0sq0XcDgqp6cp/XTRNubRccp8B
         wYvQ==
X-Gm-Message-State: AOJu0YwkWG7uDwh09U/NtFD2nGfeFXwAOivea1e7Z3sGp7zB8kaJqiZH
	I3vb+IvF5jLnYNERzHRYGCA1FDCNls0mZY6tNIc7sM2G4NxKA8w2k/Pp
X-Gm-Gg: ATEYQzwnD2XwcJ5zMew2GowF2SpltjXtS3mnQW6WlJL6b9VVzxAaYkzjegXkmPaAD+j
	cz2fPWm2lLaBq5FPFUhnz02msYe3tt9Js7Wjbgf/NvYCbtst/+7Xd+VGXCJbjNiPMgznXPNpsE8
	wTQu1EnAtDF57WFt6oSvHaWk+MvHkbdFfFIW07HYVpokD2UMG4zdo40phBdnHfV1/FatyIh6XZx
	wV6bQlvElyKQUfmA7QxfW3a3fOGFMAWVlPB5E6Qld84oqtmV+aEnR1E24eaMjAwaEQWdxv4uLCo
	v5Cd6g47md+NX5egwaci+QiN/xBNv+Xm3TvXf0WBR+b8NnZJUm8RQireImKoBK5GMTACEdb/UAs
	29bCHcES6yPcc9IX626qYkyS4y8zJ/kA6wFwtr4EZHaKg8QXBoD/4fx+nPW3Pw4lL23i2B8QYD6
	fQqKI+a4Y5IX4iw5y6YNy7SUGcxTXWZXavDymysE2XsK4grnfyag4=
X-Received: by 2002:a17:903:228e:b0:2ae:5163:c2aa with SMTP id d9443c01a7336-2b0cdc28166mr162032785ad.20.1774973397201;
        Tue, 31 Mar 2026 09:09:57 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c6a50sm119809455ad.83.2026.03.31.09.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:09:56 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com,
	sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Wed,  1 Apr 2026 00:09:56 +0800
Message-ID: <20260331160956.16312-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331065836.4364-1-aethernet65535@gmail.com>
References: <20260331065836.4364-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

On Tue, 31 Mar 2026 14:58:36 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> [...]
> Option 1: Introduce a generic termination callback
> ==================================================
> Add 'void *after_terminate_fn(void*)' and 'void *after_terminate_data'
> to 'struct damon_ctx' or 'struct damon_operations'. While this extends
> the Core API, it provides a clean notification mechanism. When kdamond
> exits for any reason, the module can perform its own cleanup (e.g.,
> resetting 'enabled' and 'kdamond_pid') within its own callback. This
> keeps the core logic decoupled from module parameters.
> 
> Option 2: On-demand state correction in the module
> ==================================================
> In damon_{lru_sort, reclaim}_enabled_store(), if damon_stop() fails, we
> check is_kdamond_running(). If the kdamond is found to be terminated, we
> forcibly reset 'enabled' and 'kdamond_pid'.
> 
> My perspective
> --------------
> I personally prefer OPTION-1 because it ensures the sysfs state in
> synchronized actively.
> 
> OPTION-2 is simpler and avoids API changes, but it's a "passive" fix
> that only triggers when user atttempts a write operation. User might
> still see inconsistent value until they try to interact with the module.
> [...]

To avoid over-complicating the Core API (Option 1 or current approach),
I've implemented a lightweight, on-demand synchronization mechanism in
the module layer.

By overriding the '.get' operator of the 'enabled' parameter, we can
detect if kdamond has terminated and reset the module-level state right
before the user reads them.

Since sysfs parameter access is protected by 'kernel_param_lock', this
approach is race-free and keeps the DAMON core decoupling intact.

Core Implementation:

	if (enabled && !damon_is_running(ctx)) {
		enabled = false;
		kdamond_pid = -1;
	}

	return param_get_bool(buffer, kp);

Test Log:

    # cd /sys/module/damon_lru_sort/parameters/
    # echo Y > enabled 
    # echo 3 > addr_unit 
    # echo Y > commit_inputs 
    # cat enabled 
    N
    # cat kdamond_pid 
    -1

I think this approach is better than my previous OPTION-1 and OPTION-2.
Does this looks good to you?

Best regards,
Rui Yan
