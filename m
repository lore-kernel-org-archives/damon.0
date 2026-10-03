Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E029D3A4520
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050565; cv=none; b=Ly6iaOgGPna2Ped6SpNrtexT+vGJJDdZaYm0xJ1eLX211Bnv18uvbQApjNGavGrBw2Oy/KO72ADmMI8ZBgO45bKTA6jB2qHm7io+3As4LIGnX64rEc7tOgXvGG7p2Sm5ZgQULWNHrctv3YYJF3WBTunf6UcrDcLjzSajaWgN5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050565; c=relaxed/simple;
	bh=41sEIN8ow8Yztnu5gl3TiT/qJ2R+o8dMoXn8X2ZBIfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqUtlGabUyCjQRJ3mq+0wL8MtK9otKlxzF5Yk/MU2gZNL+3kStoabXb1sS3WzMGQoVDD8Ewr83LGKIyHSxN8xSOGFuSYHhTcNYC4XW4lohk1vjoBSMrUB/YghT7PIGBM4ZIptEur93wcMsGByRhudSiFGHtR/8KntClKREil8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eyz+ytak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eyz+ytak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6731F0089B;
	Sat,  3 Oct 2026 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050563;
	bh=rnimwDC5GwkBtSOYVKNbW17IMHBcVdesYmfNKOrKL/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eyz+ytak7aAlx4442OzxUCmCu4CZppMsi/saNovTBL4OWphqD33ucP6EpA66VFKkV
	 UUtV7WTZN1HSTKx8bkteO27SD/9q5lsH6FZDIJyjYJ5SiktUomVKIHuR/R4uK3n+Pu
	 KuBCPAqlQ5QJvFY31TeE+s4h1R/JT4lLUTHP0iPzFAZKOQcpkU7N9mWSksR8um+5JM
	 /2jVXrYbn9/r3INDuvgM5SwPeL9GRw004INA6cSOpyOccgMmyu5ZZADNke/lqVQv1G
	 3OAYXwbnv3VQGSBw0KTG5J1YLLTik0dYNyF6EOplUJ1PUX0W+6xixN0H8LdcZbCfv6
	 ho20+eW68dcQA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.6.y] mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
Date: Sat,  3 Oct 2026 11:02:38 -0700
Message-ID: <20261003180240.34878-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261003175616.B26E01F0089B@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 03 Oct 2026 17:56:16 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] mm: commit message references nonexistent damos_quota_is_set()
> - [Low] mm: outdated comment for damos_set_effective_quota()
> --
> 
> commit bdd4b48218af232c248d2db96f0af460e859f59e
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
> 
> DAMOS could unexpectedly stop working when a user disables quota using the
> online parameters commit feature. Fix it by correcting a wrong quota
> unset check in damos_adjust_quota().
> 
> Link: https://lore.kernel.org/20260916135020.86483-1-sj@kernel.org
> 
> > Other logic for catching that uses damos_quota_is_set(), which understands
> > the fact and therefore checks the effective size quota in addition to the
> > user setup.  Fix the issue by using damos_quota_is_set() in
> > damos_adjust_quota() to determine if its works should be skipped.
> 
> [Severity: Medium]
> The commit message states the fix uses damos_quota_is_set(). However, the
> code below checks the fields directly inline. Should the commit message
> be updated to reflect the inline check?

No, since this is a backporting of the mainline commit.

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index fe91b296f4c66..bd46a63b611cf 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1087,7 +1087,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >  	unsigned long cumulated_sz;
> >  	unsigned int score, max_score = 0;
> >  
> > -	if (!quota->ms && !quota->sz)
> > +	if (!quota->esz && !quota->ms && !quota->sz)
> >  		return;
> 
> [Severity: Low]
> With this change, damos_adjust_quota() can proceed even when quota->ms and
> quota->sz are zero. This allows damos_set_effective_quota() to be called
> later in the function during a new charge window:
> 
> 	if (!time_in_range_open(...)) {
> 		...
> 		damos_set_effective_quota(quota);
> 	}
> 
> Does this make the comment above damos_set_effective_quota() outdated? It
> currently states:
> 
> /* Shouldn't be called if quota->ms and quota->sz are zero */
> static void damos_set_effective_quota(struct damos_quota *quota)

That's out of the scope of this backport in my opinion.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261003154818.24786-1-sj@kernel.org?part=1


Thanks,
SJ
