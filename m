Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1E278E5D
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190892; cv=none; b=M6Qvgh4eIXruQ5TmDz6Xgq2bcdq7OqpR87JEStSiJQs7VDxSa5090VGNm9A2lCtE0Z2Z4vQJua0HpmZ4+xRuAWUjFsStZ+6Jt9+rsM8XsQBNADx3XtGHXp7YyJxbebSjcYaQFk2kXZ22D46U1JTv3wPQ633qcYJGQmfGxOoYS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190892; c=relaxed/simple;
	bh=1BkBmk2az3LyRrhDHuL0K1bqeruaAhy6Br+YvkBpDG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubbMr8X3WnVpKMiWi4L3a65qgrUvXbK0WM2awSFAdCI2OXU65oBNBh8UUcouL2nHBJFekZr7gPBDl4Hx/Zi3TiGQ1Pcoy8u1ugqlQei304seqmk87DeQwQikO+oKoIN85dhcEt7Yh9ykqpLFmWVeBIASqcjbZVkVminHBgNg9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNEBCVcR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNEBCVcR"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35c206f0481so1426821a91.0
        for <damon@lists.linux.dev>; Thu, 02 Apr 2026 21:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775190890; x=1775795690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLs2A1L5ldKsuvkAuvcT7bLQaCWLBYPhhpzCbHMmRto=;
        b=kNEBCVcRIGjEFGIR3QZS8P0zPwBv8E0Y8wv16mH+NZA86stl8h/jLN+F7OOX7OCR0N
         SrjQ/u7v8KCC46YbNh8ae/0H03sWA+z3jnDeUX/e3KE+pwUrX+6iLi7Kf+ekdHQv2E86
         D9Q30xkI+envscn2hdYcpcMuCRT6HB97DLb2Exh0M8iKrAqPn5XGZJ51Sf5fffeKmVA+
         DGgJkjX1eFT7A/Rj18nR32mYHg7xiKhfSQw5chDp6A78U2n69weBq/TRR89206cwFUY4
         4C6IJYRo+W4Qt2bj296OkwS3aS0lDG4LUVN2mJ9eMlHwGfjQ3WjH7JHtBww14+RBwa94
         wfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190890; x=1775795690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tLs2A1L5ldKsuvkAuvcT7bLQaCWLBYPhhpzCbHMmRto=;
        b=jZ2bmpVwN/TqZXHKEcKKFRLRkxNuy8IxYmJzdbfChexkujRWehPLalDRDjyivMagkQ
         5VvIS5EmB+tWBJiQgL0OtwHAi4mkw10dF48U9wnomk88Wm6tFnuuJDhLYp4IKmvJ2Hiv
         9sjpwOtBZCgsU4m8mWpjI6GXVEEVxU7MKePv9VLC3m0Zdo+AycGttwII3k9GNgAxuC0q
         STneRM5xNq8Pg5ZkvbofrmILIrC40qw73Sc5N5xD7/zFnQ0cFYtkVS+xo1VTctkx05WL
         G3tlmfaYmw/YeM5Rqp1vdRLJlVeZFH4B0tMVPzHDQyEF5CeyxFOOqDIomr3xg7FaZGhR
         6JEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvyWmrbkAaOmYPT8LaS/rKBwLrfNYgz5xfYzcDic/vDxvLfh+6YlXJjp9VtNL2eGJqWvM2KA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw28PgEqIq7eId1ebOnwyd7D22ybfMwgJ7NZh+ac+QLqFbV5FNE
	o24bMsBqCKVCVffrhwlIGzTEzvkwuJKNaRGswbrg2UHNWtlbPH6pRQsOrO96jQ==
X-Gm-Gg: AeBDieubD2fAFv2QYVXe5YQxA7yaIdo8ImvUpvV15KfbwEsCVu6WQ0bS4CB1RbW0pfT
	lPBn1xNuFN9hIZNQKe/mC9qDoupamzEAbioKWRUYwQptUBegenaaQ+D5jxFvMCGBZBZXTiEmpD6
	FahgZ565e9sTk1BbavSaIh1kFGHOEYeZ4cSRfvdi4vr4FX8mtJUYRATT2l9u6z4E1m9jQ55woUK
	UECGppa1KNAKmTsRzaJmcpebYxEtRz5/tPDc7AFyw8JdrhOGKh1ni+tOASlmVyQiB9kRaUPqNya
	4aAxoyzhSCjHtTIR8zUc8U8IkIC29ntvmy7RFUJ58gzAWNcF3fQvKH3WD0rHKNqfPd3o3WiHZAP
	TNoqnzIQGmCQLWuKNQgiw4PFiq5mHiBqVr7+e1vZi0dodYaiVARRnvxNnM+AZkA3biM53qsbi9q
	uMlVy8JtS1t636ydLv5ryczjzMbVU=
X-Received: by 2002:a17:90b:3a4f:b0:35c:1c77:fac8 with SMTP id 98e67ed59e1d1-35de6957963mr1434066a91.30.1775190890455;
        Thu, 02 Apr 2026 21:34:50 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de4ff7c91sm396760a91.0.2026.04.02.21.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:34:50 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Fri,  3 Apr 2026 12:34:48 +0800
Message-ID: <20260403043448.53045-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402135440.74339-1-sj@kernel.org>
References: <20260402135440.74339-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Apr 2026 06:54:39 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu,  2 Apr 2026 13:34:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > [...]
> > My plan is to add the error check directly in apply_parameters(), right
> > after damon_commit_ctx():
> > 
> >     err = damon_commit_ctx(ctx, param_ctx);
> >     if (err) {
> >         enabled = false;
> >         kdamond_pid = -1;
> >     }
> > 
> > This covers the reproducible case (addr_unit=3 + commit_inputs=Y).
> > 
> > For truly unexpected termination (e.g., memory allocation failure inside
> > kdamond), I'm considering a fallback mechanism in enabled_store():
> > 
> > - When the user writes 'N' to 'enabled', if damon_stop() fails but
> >   kdamond is actually terminated, we reset enabled and kdamond_pid.
> 
> Sounds good.
> 
> > 
> > - When the user writes 'Y' to 'enabled', if enabled is already 'Y' but
> >   kdamond is terminated, we treat this as a restart request.
> 
> This sounds bit odd to me.  User shows enabled=Y and kdamond_pid!=-1.  Why they
> would write 'Y' again?  Yes, they would notice kdamond is terminated in real,
> using 'ps' like tool.  But even in the case, I'd imagine users would write N to
> enabled first, and then write Y to enabled.  In other words, this could improve
> the user experience, but seems not really necessary to me, at least as a
> hotfix.  What do you think?

I see your point. I wasn't thinking of this as a hotfix at first, but
you're right - for a bug like this, simple and backportable is the way
to go.

So I will drop the "Write Y to Restart" logic in the next version. I
will only fix the state in the 'N' path and after commit failures.

> 
> > 
> > This way, even if kdamond terminates unexpectedly, the next user
> > interaction will recover the state automatically.
> > 
> > Does this approach sound reasonable?
> 
> Yes, the plan for the next version sounds good to me.

Great! Thank you for helping me scope this properly! :>

Best regards,
Rui Yan
