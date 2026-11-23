Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448170;
	b=Ty47cWpp/QayDi4nQ6U5xE4dm+QK4MM0Ncw+prRkT4GtFYGnW+qerGzwbGJh9xrDr/GH
	 NP6uWheTtf8JFGWtwPiru2+eumbKMgfBTRB5V76LTq2wwvJF+2KL2G5tKumAGGVemWq6e
	 yU9Dv2VQ4QNvNrdw83/bMMhsIHjASP1lt8IUvN4dwBgVHmp3BtftcMaCpXq/beF9pKjR8
	 VrhVF7NF2XpTGDNew0JVPSwCboeL0mIXlXEowJOy7s6kIixE7S5j2c8fLb3HrnaechWOb
	 4gSybj8BSCHCr8fJjY2RXEiJwTZ45nRhKqeh51QyOLZSt4eWpf0Eq+vNuCHTIG49AJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448170;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+N93dfL1tS4vcORykzmFFgpIx1SWzI8NCvELJJ4qcd0=;
	b=PqWs8H0EQcELg9DChjN/XH2zO4K2l19uc98MuhGC1csPtzTsBMx15xLgIwDRo4o+v+tM
	 iaFDgMW5MoR9Xmd1SYMC8tNvlTwjej+tOf0rb7y84G1jB3X8W5YE3fstpW2Wo2rCDCmry
	 lqdiMggOQtaQGo5niqsVb4qHdNAOD5hSMCzp4zqNvi2lWtu86kGkUyimc7nxENHLPqJdQ
	 Lz60hwFMY+OvX+IepBDMxBoykGiFNUSfEh3xD3xz9ybWy3g3K5xTYNhqwjEnCTlmvdWDh
	 XapbRsgwf1KL9I+JfRsbJ7LOg8xrXODy5CuUCJy7tsPa2h8N9QNlIzdEXJT0Q3DllaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJzrcT9e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A4606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJzrcT9e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD1C1F000EF;
	Mon, 23 Nov 2026 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448169;
	bh=+N93dfL1tS4vcORykzmFFgpIx1SWzI8NCvELJJ4qcd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dJzrcT9e/7DPR395fu2ht/DhVdesdi7aWR9+JQfaBM7llt5JPXs0pLQXpe8jkukYs
	 6u/VYUmPrVSDW60ljr4xuXs5jJb0FrBXWo3cxP3HY1g1pt3SECgpRMzVk5I3G42OEz
	 p+qBpQPPR5pSkM41CpIo+fEZk+m0QAqandp3uEkzJxN4c4tKtFf549ZyugT8uQKO2P
	 b069Q1VyBsXwoC56ZxAPQd4ffvRBiJuGoIgMzxAW5DxhAnfBcmyPi3IX/U7G3BRIHM
	 w7mC/K0bpNWGMI6kjrXZFnIwc/3fUmuCq440Gq0qLSBl8YMunma2zzGThmH0hlM8ua
	 jQbU5gqFwk6GQ==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Dawei Li <set_pte_at@outlook.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/sysfs: skip registration if DAMON core init fails
Date: Mon, 23 Nov 2026 07:36:00 -0800
Message-ID: <20261123153601.85440-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123-damon-sysfs-init-guard-v1-1-a2a6ca65693a@gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Nov 2026 18:51:45 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> Here's the sysfs fix I mentioned in the report queue review.
> 
> -- >8 --
> 
> While reviewing the DAMON report queue series, I noticed that DAMON
> sysfs still registers its interface if DAMON core initialization fails.
> If damon_init() fails to allocate damon_region_cache, starting a
> kdamond with an initial region can pass a NULL cache to
> kmem_cache_alloc() via damon_new_region().

"While reviewing ..." part seems unnecessary for git history.  The user impact
(NULL dereference) could better be documented.  What about below?

'''
DAMON sysfs registers ints interface even if DAMON core initialization fails.
If damon_init() fails to allocate damon_region_cache, starting a kdamond with
an initial region can pass a NULL cache to kmem_cache_alloc() via
damon_new_region().  As a result, NULL dereference can happen.  The
initialization failure is unlikely, but the consequence is quite bad.
'''

> 
> Check damon_initialized() before creating the DAMON sysfs directory and
> return -ENOMEM if the core is unavailable.

Thank you for finding and fixing the issue!

> 
> Fixes: a18709442869 ("mm/damon: improve damon_new_region strategy")
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Other than the above commit message,

Reviewed-by: SJ Park <sj@kernel.org>

With the above assumption, I applied this patch to damon/next [1] tree with the
commit message update.  I will repost it soon (~1 week) as an mm.git merge
request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
