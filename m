Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E512FAC14
	for <damon@lists.linux.dev>; Thu,  2 Apr 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138082; cv=none; b=pb7JC+C4Nr1m2PEx7dHUEK25Mzdhqfc3T9DnG1I0uLe03ZypuB6oPxlH1U3ACMcylJDxC0/aIo4S12k+Dd1X+LUPUghynuVC9g9NmUNy99t0T6jd9xPBf6BTavjLjm2eeuGaRj5OO+30iiglIcqhFETNPyw6a3j+1NWYJh5VpKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138082; c=relaxed/simple;
	bh=jit+uHKm3XCP/g5cWvTSmT120u1mtEgOpbGBxwaH+XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8SbjA/KZP2+XSK45aMnnikb6q8MAy1bLmRvfbgrbDd4+HgkLHPlOYMSAj5x3uPE5LCE2ErC71ny3hFC1dMyHYvINUcYpvk9S2bSmLfS/rsyXBV8tCzXMCKx4z6DRUNdvxl8xJC3OpIdJutlhqbnW/rFcOd9qcGKM3EukMkChVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZVhN5Kl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZVhN5Kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71BAC116C6;
	Thu,  2 Apr 2026 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775138082;
	bh=jit+uHKm3XCP/g5cWvTSmT120u1mtEgOpbGBxwaH+XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZVhN5KlL11K88wefykFNw4z0BUVVaYN+y7IX2XX1QMgigoA+xMSnAjA61UnQT+rd
	 vemx26JRp2EEMsXbJDnOVg4t0JlQxKF86RJ84qZJuRigcnmixLwXajrPFQp2ARiekJ
	 kBL2aAHsuryGKnwU1ozP++iK8aK4els6QMxWiq6YkcECh2oLlH93urvXwe/yH15IIb
	 tBTnl8yZlXbNQeV0cxiI4IUS8/jcPqwj0WNdaZ1KMkT/9kCZuV1NwbZWHdfM0QRb6f
	 wnyFkUWB3uaDe4OJqv202bnVbc2P+fVGfPNtI6Q5ro4FO+XjydWdbxCip3rGi7wwsp
	 y6O85Rk62cy0A==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Thu,  2 Apr 2026 06:54:39 -0700
Message-ID: <20260402135440.74339-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402053458.26524-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Apr 2026 13:34:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> On Wed,  1 Apr 2026 08:41:18 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > [...]
> > What about checking if damon_call() and damon_commit_ctx() failures via therir
> > return value?  It seems damon_call() fails only when kdamond goes to the
> > termination path.  damon_commit_ctx() failure always causes the kdamond be
> > terminated.  So if I didn't miss something that could be a path forward.  What
> > do you think?
> 
> Thank you for the suggestion. I looked into the code and I think
> focusing on damon_commit_ctx() failures makes sense.
> 
> Specifically, damon_call() is only used in the damon_{lru_sort, reclaim}
> _enabled_store() path, which doesn't trigger unexpected termination. The
> main risk comes from 'commit_inputs', which calls damon_{lru_sort,
> reclaim}_apply_parameters() . When damon_commit_ctx() fails there, it
> reliably indicates that kdamond is terminating.
> 
> My plan is to add the error check directly in apply_parameters(), right
> after damon_commit_ctx():
> 
>     err = damon_commit_ctx(ctx, param_ctx);
>     if (err) {
>         enabled = false;
>         kdamond_pid = -1;
>     }
> 
> This covers the reproducible case (addr_unit=3 + commit_inputs=Y).
> 
> For truly unexpected termination (e.g., memory allocation failure inside
> kdamond), I'm considering a fallback mechanism in enabled_store():
> 
> - When the user writes 'N' to 'enabled', if damon_stop() fails but
>   kdamond is actually terminated, we reset enabled and kdamond_pid.

Sounds good.

> 
> - When the user writes 'Y' to 'enabled', if enabled is already 'Y' but
>   kdamond is terminated, we treat this as a restart request.

This sounds bit odd to me.  User shows enabled=Y and kdamond_pid!=-1.  Why they
would write 'Y' again?  Yes, they would notice kdamond is terminated in real,
using 'ps' like tool.  But even in the case, I'd imagine users would write N to
enabled first, and then write Y to enabled.  In other words, this could improve
the user experience, but seems not really necessary to me, at least as a
hotfix.  What do you think?

> 
> This way, even if kdamond terminates unexpectedly, the next user
> interaction will recover the state automatically.
> 
> Does this approach sound reasonable?

Yes, the plan for the next version sounds good to me.


Thanks,
SJ

[...]
