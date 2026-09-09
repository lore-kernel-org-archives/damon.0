Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626B354AEB
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936064; cv=none; b=A/I8iciw4YfBXU9SgMvTalkQxtMoXiXMuJeqtBovaP6LJnfYsnNV7HcITlu2iXHDLqi4jDIbWKppop6TRZp/uHCTxBGP76pfB1bxGPEPX6YUUDCealv1si+WcbYBQYLbtgCOXenTvaZbKjQMc9x6DkbVwB7GWqn/hdqktM2gC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936064; c=relaxed/simple;
	bh=ztlVkjdYdDaJdrwYzOwzsf6JT1B3JEcFntV8BrqQhaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plDzcOe11yP3CzT9LbRatWgU/bEj1q+vNqHgG2A+2mHcTtg4vtqbZrXiZm8LfVJaI/GFbu94k5k4ZrMlqdJrMk66+R880ZFfadSwvIx6mpmPPeO9ktDaQninyJjVt45S6DDnAp/Y1Piw5XOvhIvCNvhtdR5Zw/fCmIVuk0c/8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTv3xWGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTv3xWGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9721C1F00A3E;
	Wed,  9 Sep 2026 06:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936062;
	bh=FGmopeNcqw7XSGKojCHBuGUSEhDFvc6yjEMDpNR8rPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MTv3xWGM1s4UCkkDLqTyMArRhrEg9zCziEcmZEB6YGEVw3baHoLB+/Hwv9gcu53kb
	 9e4dGYLUt6nP5kh+k3xAG+shbWrY9e7twWP0X00biQtiZ8lWFtVwEguOnxqQcwk8P+
	 EgO+Fx2JE9fl6/pQHPtKB8yYpFZmN/UyG5XqOcAOscgM83MApwn0zavSVOZ8lfkjlb
	 62xNB30bOTFwZ40XNQNVNJbAozC8FbjK/k5T0DKPJZ2NyaNKHB3Lq8DkhEsrmTXuLf
	 fYXUzlRe7Qwlp+4EI/+rg7PeP7asSO9O7gdo9YPbsrJg9hBLFtQn7XVvOOE1tSHHV3
	 xZcy2kgs9WqNA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Tue,  8 Sep 2026 23:40:54 -0700
Message-ID: <20260909064055.102003-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909055216.13A781F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 09 Sep 2026 05:52:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Unused field `page_sz` left in `struct damon_pa_access_chk_result` after dropping the optimization.
> --
> 
> commit 9b0877a60d53720420f674776094bf4134b4f6d7
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: drop last same folio access check reuse optimization
> 
> This commit drops the optimization that reuses the last access check result
> if the region is in the same page. This removes the race condition when
> multiple kdamonds are used and favors code simplicity.
> 
> Link: https://lore.kernel.org/20260715031002.108504-5-sj@kernel.org
> Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 7bc8d79c7fa07..d1d047f494aed 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> 
> [ ... ]
> 
> > @@ -161,29 +161,16 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
> >  	folio_put(folio);
> >  
> >  out:
> > -	*page_sz = result.page_sz;
> 
> [Severity: Low]
> Since the optimization was removed and page_sz is no longer returned, is it
> necessary to keep the page_sz field in struct damon_pa_access_chk_result?
> 
> It looks like result.page_sz is still being assigned in __damon_pa_young()
> and initialized in damon_pa_young(), but the value is never used by any
> caller after this patch. Can the field and its assignments be removed
> entirely to clean up the remaining dead stores?

Apparently the upstream fix is not making such change.  Let's keep it as-is to
reduce unnecessary changes.

> 
> >  	return result.accessed;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260909054255.253652-1-sj@kernel.org?part=1
> 


Thanks,
SJ
