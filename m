Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602651ADC97
	for <damon@lists.linux.dev>; Tue, 31 Mar 2026 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940318; cv=none; b=ZVI6LAPOuKMPzYToYp4p99XL29FG7jcXrl0dxB7CfotvGNQmU52zf+OzEbagFZlto4itWuGdPFw2UQmDwrznQLQaRxnUSAwbhcud83ozNOg55OS/+TS1PjYIPewmji/kZlginextQGZw7qajUf47CcnuYkonjKLpMKmVOe3RsBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940318; c=relaxed/simple;
	bh=wfktVW9tzgD1rpx5ZAhaURDVY1+Uw4vZBZ65V1+yOlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWy5MTBLupQJ6I0iaQCAkfs0SxOrpYOGgQwjAslY1XlsrY0yj5rEceiBTuU+YPb+jWhO4zdC1xbu/aw4YVpUhzyYcQye20M3g7Mc/WX2vkfq2oV56/Sd1SIrmdubHICtTh9QQlJQAImpaby3qwIgaCSV0kTQv3Y0m5kvuUkl1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1bTGdjo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1bTGdjo"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad21f437eeso35494125ad.0
        for <damon@lists.linux.dev>; Mon, 30 Mar 2026 23:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774940317; x=1775545117; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ctn/dnY47VpD6BEY4z1LNAsyn2RLaR5EVemw/F8Cws=;
        b=A1bTGdjoZhnrLQRu/MBIGpfKrzgFDuR3Zw3iM/kbM6TaAQLtseFW8AebdnIjfZ1dWG
         4GM4gKohb+Jl8BKWlnKYx2tTED8iLppeKWPv0BpJrSiOGM4QQeAqEHmVu1wpv5Q5JyRe
         4b3uN/2xj2o84/H02/esSQNulPpSdzo4BiRMrRJUGAWZuonl5Ga1AcsizvP1hdquyBZP
         KyR0h5QA1ZTLZFfC2B864KjhAfFuuTX1L3s+8A9psta9aPEt+FM/+EufGoE37WS+qV5u
         GrAk6R656EkWATxtCKm0FwQz10tzRHEdRkr5DPeOdm1vlMvS0Frc85vOdx+WrfT29k9C
         5l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774940317; x=1775545117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ctn/dnY47VpD6BEY4z1LNAsyn2RLaR5EVemw/F8Cws=;
        b=YpK2iTqt+o1xYFBHfTLddw6w9JiQtZiu9hgmJalf6jiJPulsz+cH843e9Y0o1uQ0aE
         nIzUx2CsH0chCqN3isRYZcjZ2LDIUbUdRSZvqmFiksbPMDN3FYj4kqxH9+dZwxnPBaLB
         e3hxhKycjpaQzvHbWq2fV5DLjRpkljZT4lQ37tZB0gjF2KpFf2/xdMpIDZK02GK5VMON
         OaHaCh2WN0Bz/0mo1oAXyjndBSa02mZ7Z69ICmJVNO6R96uAkRsD1nvVQpHDU2fRkwNH
         FmAAGsoyM7kG8iClcC9w8Fawn6ONkqWbViyLOBr0I3ZaI0WTffJgIWRmgZXu6i85QSlx
         XWZw==
X-Forwarded-Encrypted: i=1; AJvYcCXBL1pWgEf/DSNeVWvIToZQzKO6TQ50ruFgK0AxWVCYx6xFvttmhybDfo6JPl9T1ufi2Zb1lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQUqI2v6OWq/iJGpwdtH3/Pi4FCFHRaXkp8lbTiSrxZ2B7sFlK
	NZByf1IZWSS9ai1e6moXEl/JsPM4CWv++0/B17zGNmL4jRuFz6fzAiVL
X-Gm-Gg: ATEYQzzxTmXokW71uEvyPOc852nJBiBr4N9J4ty4gedyG9yWmHgTRKSXeKrrS8NCT5A
	Lz+Or4msqfFj7PoMblURkuTBWCoTuPfCMhIvkaVsbRHjNMcYwObZ3MFS02VGBYiiiycrLDUIrdb
	1IM9KPOEeqox+zHUReD3BWPrvCBI/MUSpuUS5Mp1tPPEtYJr2k4q0Jsrv7NtnMjishPzrbf7M6w
	dt/2URZGhZMqzrkG9pKNRaIRmQ5MbfUBQPE3u1gp88CR/fx1V0ul8cLhv+sYD91BVTpYV5oSD+E
	/ds6as696k8vdVQo+BH5zII+Ku+OfPF+lDdsMmIymmaJUNfVkI5f9oe+3Qy0aORo/53Jt8Qd5AF
	HKq3/yxPxjfQo1yyZbh0gaL09K8dGOMguUu988cVf7joJklohSFy/ayneJ/UAe9Y7hhzeJZJnz/
	2qEEflLlOk9Ayp00SsWcJypDsQF0c+dNxowxYVbhjC/qltiHu8Jcs=
X-Received: by 2002:a17:903:90b:b0:2b0:b214:3bf0 with SMTP id d9443c01a7336-2b25ef39cd7mr24743905ad.17.1774940316646;
        Mon, 30 Mar 2026 23:58:36 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24b02a11esm92674675ad.65.2026.03.30.23.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:58:36 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Tue, 31 Mar 2026 14:58:36 +0800
Message-ID: <20260331065836.4364-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331050229.67637-1-sj@kernel.org>
References: <20260331050229.67637-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

On Mon, 30 Mar 2026 22:02:28 -0700 SeongJae Park <sj@kernel.org> wrote:

> Nice catch!
> 
> I guess this can easily reproducible?  Sharing detailed reproduction steps
> would be nice.

I will include the reproduction steps in the next version.

> > Solution
> > ========
> > Introduce a 'thread_status' structure to link the internal kdamond
> > state with module parameters ('enabled' and 'kdamond_pid').
> > 
> > Specifically:
> > 1. Extend 'struct damon_ctx' to include pointers to the module's
> >    parameters.
> > 2. Initialize these pointers in damon_lru_sort_apply_parameters()
> >    and damon_reclaim_apply_parameters() to point the respective
> >    module variables.
> > 3. Implement damon_update_thread_status() to reset 'enabled' to
> >    false and 'kdamond_pid' to -1 when the kdamond thread finishes.
> 
> This feels too much extension of core API for a problem that can more simply be
> fixed.  Can't we detect the unexpected termination of kdamond from the modules
> and update the paramter values accordingly?
> 
> If we cannot due to a limitation of the DAMON core API, I'd like to extend the
> API for letting the caller detects the unexpected termination.
> 
> Because this is an RFC and I already have question for the high level
> direction, I will skip code level review.
> I agree that the current approach was too heavy as it forced the DAMON
> Core to directly manipulate module-specific parameters, leading to tight
> coupling between layers.

To address this, I've brainstormed two alternative directions and would
love to hear your thoughts:

Option 1: Introduce a generic termination callback
==================================================
Add 'void *after_terminate_fn(void*)' and 'void *after_terminate_data'
to 'struct damon_ctx' or 'struct damon_operations'. While this extends
the Core API, it provides a clean notification mechanism. When kdamond
exits for any reason, the module can perform its own cleanup (e.g.,
resetting 'enabled' and 'kdamond_pid') within its own callback. This
keeps the core logic decoupled from module parameters.

Option 2: On-demand state correction in the module
==================================================
In damon_{lru_sort, reclaim}_enabled_store(), if damon_stop() fails, we
check is_kdamond_running(). If the kdamond is found to be terminated, we
forcibly reset 'enabled' and 'kdamond_pid'.

My perspective
--------------
I personally prefer OPTION-1 because it ensures the sysfs state in
synchronized actively.

OPTION-2 is simpler and avoids API changes, but it's a "passive" fix
that only triggers when user atttempts a write operation. User might
still see inconsistent value until they try to interact with the module.

I value your judgment on which path better aligns with DAMON's long-term
design philosophy, as your experience with real-world kernel maintenance
is far beyond mine. :>

Best regards,
Rui Yan

[...]
