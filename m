Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BE33E345
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273025; cv=none; b=n/BLoKaNMfq6AQtKdecZne5u+YdB2PYUKZehap1g/6vCW854szQDRkVFGtj0ngTY3gOqD78D7I1E26qpHYDcbnMKWFRTUOE1Y4xydGy2nnSXzkCf2y4auOiCW1zcSAGBDt50Rtq9NUHstaUUG17ar0s4KMewXx+TPt9Gvpk7fWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273025; c=relaxed/simple;
	bh=UncREWWySlPpIIoCIl+83gSkqjcU1S+MOA11TmCM1GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijbMdp5aajtWolO7dGg9P0lCRTAtRAHNqD6CrTsaKJeG3s+9dyiGgHiI3udYdtM74sizJBG3RezA3sQQobiClOmGzrmUQkqUir1n9U//XRFnHmQQxn/jdyZV8n+n9TkLBYGxNOfRx4h6wy9JWPknbKsayEjogEClWBFoqlVbEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHWsB16f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHWsB16f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92CB1F000E9;
	Tue,  1 Sep 2026 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273023;
	bh=9BmbKOgCVZufZ5YfrVj9h0xwhMIBVvMo9V1Oi8jNLlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHWsB16f1d7BXaYQ5u6dOIIZ1MCKCbi9h5jPffPk3GsI23Nq1EimcoOz3FpIWQFhl
	 fuTlLUyTSo/A4TPPov7z2RIG7hVIvwUIh69Zccbvvhw3A4csVcc6gAnbYcQB6auu+j
	 kFeqOUF1FTcR9tyPiRL66WaB9EvErtWP5QB5W2zxHRv5jD9BZ6EauvTjrNpOM15M0e
	 /MoMhquqy+qtbyIemm3/PVRNNaDPpbQwyBtwnIBqtve0O8Q26e5jpUOXTHlvktlTvl
	 l2rRTPwvkLjh5YR1W2jHZ+rYFiuiBS/E10DxZdq9vA4lKTgSF7E6o53urjM0L6P4g+
	 LY2fCSawyXAtw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 8/8] mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
Date: Tue,  1 Sep 2026 07:30:15 -0700
Message-ID: <20260901143017.101058-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901133650.EF4F71F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 13:36:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] 32-bit integer overflow in DAMOS metric calculations.
> --
> 
> commit 4a4658bd5d39473e6ccb07618a88e601987f2acf
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
> 
> The function damos_get_in_active_mem_bp() uses the sum of active and inactive
> memory as a denominator. In extreme environments where both are zero, this
> results in a divide by zero error. This patch avoids the issue by changing
> the denominator to one if it is zero.
> 
> Link: https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3060edf5e4fa6..0df785e72438f 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3006,7 +3006,7 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
> >  		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
> >  	inactive = global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
> >  		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
> > -	total = active + inactive;
> > +	total = max(active + inactive, 1);
> >  	if (active_ratio)
> >  		return mult_frac(active, 10000, total);
> >  	return mult_frac(inactive, 10000, total);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but it's a pre-existing high
> severity issue in the exact function modified.
> 
> Could this mult_frac() calculation overflow on 32-bit architectures?
> 
> When active or inactive memory exceeds approximately 429,496 pages (about
> 1.7GB) on a 32-bit system, the intermediate product in mult_frac():
> (r * n / d) where r is (active % total) and n is 10000
> 
> will overflow the 32-bit unsigned long before division. This wraps around
> and causes Damon to apply completely wrong quotas, degrading memory goal
> reliability.
> 
> Does this same 32-bit overflow issue also affect other metric calculations
> in mm/damon/core.c, such as damos_get_node_mem_bp() and
> damos_get_node_memcg_used_bp() which similarly compute:
> mult_frac(numerator, 10000, i.totalram) ?

Known low priority issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260901131850.98037-1-sj@kernel.org?part=8
> 


Thanks,
SJ
