Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC537CD2B
	for <damon@lists.linux.dev>; Wed,  1 Apr 2026 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031882; cv=none; b=su2bVerqaAEZkrC0fs+1cgmETVuXIvqk+AW8shAllTU0jWzW1t48rTvdhOw0GGpHimklx3PB9eybRtNOpwSyQQqh5+/rmV5EqT+FRkasj3aVIsehUTPrTmWkPXH3vq+DoHJaEGzh1W8PmCuM8xJLPgK2tpuZzhFczQDBaywh+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031882; c=relaxed/simple;
	bh=4fJfSDABQLI8YXNyTJVrmXihmZcyuxSt1NN55U+6sDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGUQFNIFmthNDOTdFt7qtGzxZYHoGQmdrJMgPvLWgABECl1yhHgwcsSIqreAG74vdQ5t3eKMsXouvDfT+jR/vYNo+R5bpoFdONERst9e+Zp4BS5vgG0sp1DxfMUhppYQl63dl5lWLtCrRxLvt9KIavqELLgEi+O1zaLDGngU7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqdUie00; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqdUie00"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82748257f5fso439599b3a.1
        for <damon@lists.linux.dev>; Wed, 01 Apr 2026 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775031880; x=1775636680; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi8b6kNbARyFvnrDLDVCGkFE4VG0ORxMai3aXTvGZjA=;
        b=ZqdUie00v2z2Sgd/kkT4seFRRwkGyAPC4OL9jX6+crAok2XSZ1rAWmaP5YBSGHs7d3
         38N9f7sWB1EiHBBd+2vJqbScEKW+yY/oi0Dsqlq1OYVRIIE/pEGJcF1dVO/nqa5XMSPw
         Me1u2sd0vvsK/8lZFeKmWt+ET9l/IPsuiIJ3+IL1qgJleYMNxcamDPDqKKe/1Xwy53V4
         XxcJg6oi2PPpQxLDW9F5p+zhI0wR+MSKqj9NN5xBQOWQC3HnHRIUR8nE1YH2J1bA8D+p
         0/umeBE+87J3HrQAMEeErzEemKeCp4yuk1xjcMoEDhJu/LiCIdHl9mLU2aXu6qvpPYsR
         2IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775031880; x=1775636680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oi8b6kNbARyFvnrDLDVCGkFE4VG0ORxMai3aXTvGZjA=;
        b=jsnGvCPu5fZ+/hlMgN22TxRnrkwl1XI0ECP/r5F5JJXVq9MbrApDu0qYuITXi7x2LM
         LSFL46vb3tPOKgyIBawYQhdylkRd3bxw68piBZ9GrORnlLIbFZtYZmi18R4RlzuElv3p
         1vyYK3224crE5bk0ZQqpjLYGFx+LIBv0sRkdMT28HyvJ6sQy5FFpIRBp6Sws2bXMM/Gi
         ah0viT7SBxPpFV2X+6HziRItOe0LOtBYMvEWOkHy/yYC6h/kmWR06OftUN5pWvu0PF5B
         ysM7p82xYovIRotL7GBbU2aBZsTrwSfdVQhvMTLP2Jn7aWTrmIzbzFdxywm1ymuj2H8m
         Ov8w==
X-Forwarded-Encrypted: i=1; AJvYcCWCJW6LZaWbDRPJYcxum13tHlho97VRFqs0WM/v6l3KryaFLJQDRHtsC16vWM1kryGbIUctNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvKtLahXP618aLDYVvio1pgvPAY2bd3pSXgOlQlRSvaHZzpTxW
	hPC9Dh0//tJoH8y55VfS12M/z9Ec8COrEv4k4uEkA1pbCz0pAYX06Co8
X-Gm-Gg: ATEYQzx/hfdH2if5/p48L4bw4KE+8082x/yzOF7+0YqguAY/1Xrs4tTB3/k+ABKTN/n
	Pw0nDJn83JFPe7ya6hqMdC7Q+dAYtP7uMXNq/t5LY6qa4Q5AhVfaDuR+VRwL1ZCisUum2SEi2px
	uaLfq5cMGrn0jR8JbpyABJEz9ElOfGLgwiKIy3jmqeXIwEMWdAVKcympn9lDvtPQ1gEMxBA2ELf
	7TP3eSIDdMxKPVjMAuewePt4YwsdijDGuKkrbkDdpJIxg+LRA00DpGl2T+TIErJfOqzSUu8eCtm
	Aj92hTQmfkaWPU2Tna+CIsrDt4S2a8+4Zsti/+TwwzHQkxK0lTMy5QFTrJL2OAJzntnOiSN3H27
	AX8pbmkMs7utBWdFJKdAWoVl77M0c2X4znquYiVZxO+JnnelinBuhQaMUbXhS8q+OE8oBWxpcm0
	UM02aiA/R0j55xSXtML1bXbk2f1H42B+IwGWg9Mo7ELjYTQptDjjZmwBNYyssl0w==
X-Received: by 2002:a05:6a00:4188:b0:82a:7918:7f4b with SMTP id d2e1a72fcca58-82cd66c574dmr5739470b3a.34.1775031880237;
        Wed, 01 Apr 2026 01:24:40 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cec36da5fsm2597927b3a.2.2026.04.01.01.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:24:39 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Wed,  1 Apr 2026 16:24:39 +0800
Message-ID: <20260401082439.12612-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401004400.85613-1-sj@kernel.org>
References: <20260401004400.85613-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 17:44:00 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Wed,  1 Apr 2026 00:09:56 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > > [...]
> > > Option 1: Introduce a generic termination callback
> > > ==================================================
> > > Add 'void *after_terminate_fn(void*)' and 'void *after_terminate_data'
> > > to 'struct damon_ctx' or 'struct damon_operations'. While this extends
> > > the Core API, it provides a clean notification mechanism. When kdamond
> > > exits for any reason, the module can perform its own cleanup (e.g.,
> > > resetting 'enabled' and 'kdamond_pid') within its own callback. This
> > > keeps the core logic decoupled from module parameters.
> 
> Maybe this is the right long term direction.  But to my understanding the fix
> should be backported to stable kernels.  Is that correct?  If so, I'd prefer
> simple quick fix that can easily backported.

I agree. While I hadn't initially considered backporting, this bug
certainly warrants it. A simple and easily backportable fix should be
our priority for now.

> > > Option 2: On-demand state correction in the module
> > > ==================================================
> > > In damon_{lru_sort, reclaim}_enabled_store(), if damon_stop() fails, we
> > > check is_kdamond_running(). If the kdamond is found to be terminated, we
> > > forcibly reset 'enabled' and 'kdamond_pid'.
> 
> I think this can work, and simple.
> 
> > > 
> > > My perspective
> > > --------------
> > > I personally prefer OPTION-1 because it ensures the sysfs state in
> > > synchronized actively.
> > > 
> > > OPTION-2 is simpler and avoids API changes, but it's a "passive" fix
> > > that only triggers when user atttempts a write operation. User might
> > > still see inconsistent value until they try to interact with the module.
> 
> I agree your concern.
> 
> > > [...]
> > 
> > To avoid over-complicating the Core API (Option 1 or current approach),
> > I've implemented a lightweight, on-demand synchronization mechanism in
> > the module layer.
> > 
> > By overriding the '.get' operator of the 'enabled' parameter, we can
> > detect if kdamond has terminated and reset the module-level state right
> > before the user reads them.
> > 
> > Since sysfs parameter access is protected by 'kernel_param_lock', this
> > approach is race-free and keeps the DAMON core decoupling intact.
> > 
> > Core Implementation:
> > 
> > 	if (enabled && !damon_is_running(ctx)) {
> > 		enabled = false;
> > 		kdamond_pid = -1;
> > 	}
> > 
> > 	return param_get_bool(buffer, kp);
> > 
> > Test Log:
> > 
> >     # cd /sys/module/damon_lru_sort/parameters/
> >     # echo Y > enabled 
> >     # echo 3 > addr_unit 
> >     # echo Y > commit_inputs 
> >     # cat enabled 
> >     N
> >     # cat kdamond_pid 
> >     -1
> > 
> > I think this approach is better than my previous OPTION-1 and OPTION-2.
> > Does this looks good to you?
> 
> Looks not bad.  But, what if we read kdamond_pid before reading enabled?

You are right. To make this robust, I could apply similar '.get'
overrides to 'kdamond_pid' as well. This ensures that reading either
parameter would trigger the state synchronization.

Would that be too heavy? Or do you think it's unnecessary?

> Also, what if the user simply try writing N to enabled?  Wouldn't user still
> see the partial-broken status?  So this doesn't seem gretly superior to the
> option 2.

In that case, we could modify the damon_{lru_sort, reclaim}
_enabled_store(). Before processing the write, we check if kdamond is
still alive. If it has terminated, we reset the 'enabled' and
'kdamond_pid'.

> Based on your above reproducer, I understand this issue happens by the
> damon_commit_ctx() failure.  If it is not wrong, can't we catch the
> damon_commit_ctx() failure from the calling place and make appropriate updates?

Yes, we can. We could check 'ctx->maybe_corrupted' right after it
returns, and reset 'enabled' and 'kdamond_pid' immediately if it's set.

Do you think this approach is feasible?

Best regards,
Rui Yan
