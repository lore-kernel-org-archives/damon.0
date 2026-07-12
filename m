Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E81E5B64
	for <damon@lists.linux.dev>; Sun, 12 Jul 2026 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783877099; cv=none; b=f6e6NrCVWCkFG3yNO8l+P5xB8pFQ1kR6H7h7oI+TT9xNvMtgNIx1Alv2iyQhH+g2C00TKT8fQxyBfTdlI4yZjiEsJdCQa7Yjjqt1lIvDvcd0XprFZl2tGsnGHG6JcWMWaUR5P0/ZtmqPkrt4vfyM0/F6lFmrh/pCGBplkUAKy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783877099; c=relaxed/simple;
	bh=bdwty3YnUzhLmlWDN0Xg7wqOiq6/AIwU10iUoew+gXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdnE1tlt+iZmrMakH+fW5mYtaYyewZuBhwpOvbuDWyZ3AyjJ66QVN6FNgB40XP9NNqIUMmFPXOegkSK4XvqENwZ6wyIXyJdgJklAMKML43bW3K4joXtJcsu0sgm9P9lP4v1pO3KjS9DteEdoVj0/BjaJb20C2B8KtpUodkBn4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY4ItlAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY4ItlAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F2A1F000E9;
	Sun, 12 Jul 2026 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783877097;
	bh=QInUzzE2CMN1adJ60e3qHUqEr+a40KUphBj8NhvY1OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PY4ItlAp6YoYkK//Gf/Ao0U86clzrZwPnz/GrSDjbwuDuKLfViCLWX7/FbgzdOzEt
	 rwaZWs4L5hAQr6LOhc+D/4QFAavXZ+J6tdZ+/gtNVW6VDguQO0bpPb+7ZqKUkflw2m
	 RROEhCUfE71oWOqq7oH1Sh5rFROx/CzA9VkTilNfWaItF4yEQYXxXgKBzi5R/rXpie
	 hkdUeCtZjC4CTPY8cOVRX52nf7aJ/5WteO5g1uXZOZSV6RmQibylHvwISVQt+K1fuE
	 QV2Pvh3qoaGyjek9XOBZ3Us46YZ7ZXx/q1snNOEQEeLUzYcH3P2zUJxMGW1qa6Le++
	 fwYIkncIJf5Mw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 3/5] mm/damon/vaddr: drop last same folio access check optimization
Date: Sun, 12 Jul 2026 10:24:52 -0700
Message-ID: <20260712172452.92595-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260712171009.F295E1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 12 Jul 2026 17:10:09 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Unused parameter and dead code tracking logic left behind after removing optimization.
> --
> 
> --- Patch [3]: [RFC PATCH v1.1 3/5] mm/damon/vaddr: drop last same folio access check optimization ---
> commit 40e12defdea3b013644cc026283aa34cdd3ae2fb
> Author: SJ Park <sj@kernel.org>
> mm/damon/vaddr: drop last same folio access check optimization
> 
> This commit removes the last same folio access check optimization from DAMON's
> virtual address space primitives. The optimization was found to cause race
> conditions when multiple kdamonds are running.
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index d10b8042adb5b..16fe210d2042a 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> 
> [ ... ]
> 
> > @@ -496,26 +489,15 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> >  static void __damon_va_check_access(struct mm_struct *mm,
> >  				struct damon_region *r, bool same_target)
> >  {
> 
> [Severity: Low]
> Does this code still need the same_target parameter?
> 
> With the optimization removed below, the parameter is no longer used in
> __damon_va_check_access().
> 
> The caller, damon_va_check_accesses(), also still computes and tracks the local
> same_target variable on every iteration just to pass it here:
> 
> 	damon_for_each_target(t, ctx) {
> 		mm = damon_get_mm(t);
> 		same_target = false;
> 		damon_for_each_region(r, t) {
> 			__damon_va_check_access(mm, r, same_target);
> 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
> 			same_target = true;
> 		}
> 		if (mm)
> 			mmput(mm);
> 	}
> 
> Could we remove the parameter and the dead tracking code in the caller as well?

Good finding.  I will drop that in the next revision.


Thanks,
SJ

[...]
