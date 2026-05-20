Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DC43438A4
	for <damon@lists.linux.dev>; Wed, 20 May 2026 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240505; cv=none; b=scg3+q8jIJOZNY5s85sYDuI6l1HKHBilFNxTHz8KQ7OPWYwcYS+79gPpjHArDc+im7QFwua9/ABdTC+IrB/R7/kUTAilR9NJ/Luw+RjDnQ7nDTYNRM1TwxQKB0gVJGqf/x2Oy4mGpYG0it3yPJIYZoTlavHhvkYyMHmr26bqamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240505; c=relaxed/simple;
	bh=+PeOsYNneenxi722yOMG/HdGnkm6OQFfHOBLEEnkmZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKsjjQNmxHpuppEP3xpvWriWfekTxskaA7D5cHZjXnwlE4qOOZxaZ64PlWtt8kGYlFwj9uyjK8HakSvLe5bRkSWh1hcIhNM/7VPHJTW3Zi14i3587yOhYhbKm2VDL9mn5roKzBbv6yDW0xVuDbuW8WNRznONJUSCwarirffO474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUvzgkIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUvzgkIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522E11F000E9;
	Wed, 20 May 2026 01:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240504;
	bh=FLDkYL4mrlFrbe0Iuz8aiEB/hHPKezAFet5UoV2GBng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUvzgkIfdCqY610E2QpwjciBlN+4Nt212XiPSNV59ZBbyO0a/e26m4pIpFqjiFN0Y
	 6bDDwhCAGVAttbNIQ9hCJtTfoy92FsdsZekH4C2bsKEpQgRK1H7pcgPMNcuXbdlqz/
	 6F4aMqiRYfH1av/fFrRqiJsMRJpSHI+n8eRR2/CGZYll56ZZOX9XfI8AeZ1wea/WlO
	 laDHZSAGDKLAr8XO5NrzCr40VGF8Qq25cW8dntMgXwdUMLx2hW+FLbf2eOR03S+Vl8
	 62R1rsqrbR89hsy6GmT9rQfC5nqrLMRDJL06tfb/aaYlqIPDOafewtZlX9cp/SAW56
	 4OcT67fA0Xgsw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon/core: trace esz at first setup
Date: Tue, 19 May 2026 18:28:14 -0700
Message-ID: <20260520012814.94187-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520011837.6192D1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 01:18:37 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The monotonic accumulators `total_charged_ns` and `total_charged_sz` will rapidly overflow on 32-bit architectures, breaking the throughput estimation logic.

Not introduced by this patch, so no blocker.

> --
> 
> commit 4cb83c3ed801305fa15e94548668201c275a1037
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: trace esz at first setup
> 
> This commit fixes an issue where the initial effective size quota is not
> traced, which leaves tracepoint investigations incomplete when using the
> temporal tuner. It updates the quota adjustment logic to unconditionally
> trace the initial quota value.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 4e223857a0f99..0db6530825d1d 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2883,6 +2883,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >  	if (!quota->total_charged_sz && !quota->charged_from) {
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but will total_charged_ns and
> total_charged_sz overflow on 32-bit architectures?
> 
> Since unsigned long is 32 bits on those systems, total_charged_ns will
> overflow after roughly 4.29 seconds of total active execution time.
> 
> Additionally, the throughput calculation in damos_set_effective_quota():
> 
> damos_set_effective_quota() {
>     ...
>     if (quota->total_charged_ns)
>         throughput = mult_frac(quota->total_charged_sz,
>                 1000000, quota->total_charged_ns);
>     ...
> }
> 
> uses mult_frac() which evaluates (x % d) * n internally using the type of x.
> Since the remainder could be up to total_charged_ns - 1, multiplying it by
> 1,000,000 will quickly overflow the 32-bit boundary. This produces incorrect
> throughput estimates and impacts the effective size quota calculations on
> 32-bit systems.

On 32-bit environment, addr_unit can be used to workaround this issue.  On
systems that runs DAMON after a reasonable amount of tests, the issue should
not happen.  I'm thinking about a better solution, though.

Anyway, not a blocker of this patch.


Thanks,
SJ

[...]
