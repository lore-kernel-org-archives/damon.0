Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329E3A2E2B
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050667; cv=none; b=nQmx4GuI4vwmu9jcTOkZVmC5d7b7CvqD+k95oaALYeqi/Qy+jguokD1//1Y+MAZCmTcv8tudPpte2DGe9zVzbPDAYwIM83IjzRbfxMmGHqfcXxqLz349VngUVCVr2jMPa4dDlSNZkFgCIldcsJgrWx/phfdIbPZBF/nmSrMagaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050667; c=relaxed/simple;
	bh=rNtMGRbEX9meqOm88/3aDMwo5JTPYbP+jxOpt7nz3VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZD3lhlrICOZ0K6xcHULcTL0xCEIiu3mLG1M1R0ciDcOo7Pht1P5S/mUsW6WnAumPqiaKN30yqVn1Bjf0VoguyydFVsBnA9srLurZf9RCJWVZj7nN1Z8Shx0ouG+TO5h6jtpEmMWMbwlEEyAcysrIgjKJIVuO6X+EJkumxReA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXVVqZRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXVVqZRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0311F0089B;
	Sat,  3 Oct 2026 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050665;
	bh=klcO8WRFaduNE3ISPdwikv7ltQjmNYYg2LMkgnDywlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXVVqZRRAlkQJfnI+SU9Q3BgdZJDQgH4DuJfU3bkuN+5tIejfxXTWgUsSktaJ2HFQ
	 QdAR0GGiQuOKcbCiOkNG6NXuo6k3p3psyww1djIe6db+C4Hno0smyB5P5xVWigca7y
	 iGji789cFfQWK3/ORSad5+MKyQW9JphyonIOlG7cT/v3YRVZ11wSLcOTh/GNKzC/gk
	 XbgdjyW9N7Edf/xFdZQ9dBEC8UHFqFeF/i/bFRQiWJApYYlReMRT/6r2hdeE4IjlXA
	 zzPsYyQrnKuhdcnA5NwWCZxhoONEUKuLDhkvmZuQgswM1ivmcedAbYjkz0TC9shcXP
	 JuCNHNVeXTO/A==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y] mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
Date: Sat,  3 Oct 2026 11:04:21 -0700
Message-ID: <20261003180422.35043-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261003175615.6AF5C1F0089E@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 03 Oct 2026 17:56:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm/damon: commit message claims to use non-existent damos_quota_is_set()
> --
> 
> commit b8bc1e659853d831a5550c37c3c7adcd48423fd1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
> 
> This commit fixes an issue where DAMOS stops working unexpectedly when a
> user disables quota using the online parameters commit feature. It addresses
> this by updating damos_adjust_quota() to not skip its work while the
> effective size quota is non-zero.
> 
> Link: https://lore.kernel.org/20260916135020.86483-1-sj@kernel.org
> 
> >     Other logic for catching that uses damos_quota_is_set(), which understands
> >     the fact and therefore checks the effective size quota in addition to the
> >     user setup.  Fix the issue by using damos_quota_is_set() in
> >     damos_adjust_quota() to determine if its works should be skipped.
> 
> [ ... ]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 32737cc5f877b..2f6d60b9ca0f4 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1677,7 +1677,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >  	unsigned long cumulated_sz;
> >  	unsigned int score, max_score = 0;
> >  
> > -	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
> > +	if (!quota->esz && !quota->ms && !quota->sz &&
> > +			list_empty(&quota->goals))
> 
> [Severity: Medium]
> The commit message explicitly states the fix uses a helper function
> damos_quota_is_set(), but the code implements the check inline here in
> damos_adjust_quota() and the helper does not exist in the codebase.
> 
> Should the commit message be updated to match the inline check, or is there
> a missing patch that introduces the damos_quota_is_set() helper function?

This is a backport of the mainline commit.  I want to make the change as
minimum as possible, so no blocker in my opinion.

> 
> >  		return;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261003154616.22092-1-sj@kernel.org?part=1


Thanks,
SJ
