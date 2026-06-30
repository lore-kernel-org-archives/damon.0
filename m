Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333191C5499
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780120; cv=none; b=JCBW+mzvrteSmpkjGOiEslg7DsxRs84UFR7Kjs8J5C+nR4hfqfvMpE6o3uZ7Ydj5Xxg3+6+qUnUTk8pGuaXsbqW9qUUJSgJtSjG5Nk9IALC/fjl09Dga9rmaINgGP/Ftcto2RhypHq/I/vcSB0VdQ/9ivgDFc2gCGqx5cxu/nAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780120; c=relaxed/simple;
	bh=Ngrn3FqrtK73EqB9geFNkeI3kERwk4h5ZVGE0saYNn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dubey82yYykwRapSCcN5YBFTrwuvXaZXaHUVK55HvWurrOG5gGFogd4EaY8p82/i+HqbYE+ZzlVI4MYOrp6h6obz4LSLsEZK0eWXDbGtPpNh8kYNiopgRfv5x1I1y/ZGLy2/dvEfcOl3iTWQr6Bncc7sOiZU1KiMDK3UQNWOVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CohUd+HU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CohUd+HU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819781F000E9;
	Tue, 30 Jun 2026 00:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782780118;
	bh=g+8i3W9I6tn5lgbamHg5myUvT6Lp0H43TRFkQmotPog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CohUd+HUOaWCvG+d9mB45B/G1KmMiBKwsQk15yR9fNzA8bl51GOSVrL4VZqSPIZx4
	 5lAn3tMGlTgAcOVcZPT9knK3PoC4Q8VkdtRb+CSyNWIyfXrQL5dfcTXr2wkiEC5hlJ
	 XtTgFBoHCliCiMYz0sgfnfFEvLGmOuLBb6P8+BsYruoypccugLUwAR97vl7ESfndX8
	 sySqkCH42iajMCHbXbdZuzufPQ3ubVWIQxtjPg5t4WaiZOvgX7TezGo7vSk/ng+IrC
	 oZkpvcTgkQ/kGNDoLhiN8wwv3b1ZqupHvKXVlSbIZ3FF6T8Awc14hrAS+iHeXgmGrH
	 k+rxFuZCHO4+w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	IgorpetinDev <igorpetindev@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/vaddr: remove redundant RCU lock
Date: Mon, 29 Jun 2026 17:41:49 -0700
Message-ID: <20260630004150.141638-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629170627.B06481F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 17:06:27 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The removal of `rcu_read_lock()` breaks the KUnit test `damon_test_three_regions_in_vmas()`, causing a lockdep splat.
> 
> Pre-existing issues:
> - [High] VMA tree iteration on an external mm_struct is performed without checking if the address space is stable, risking a crash on unstable MMs.
> --
> 
> commit e3efcd87bda8a6d5dd6bcc064e6f5876f9980a31
> Author: IgorpetinDev <igorpetindev@gmail.com>
> 
> mm/damon/vaddr: remove redundant RCU lock
> 
> This patch removes the rcu_read_lock() and rcu_read_unlock() calls from
> __damon_va_three_regions(), assuming that the mmap_read_lock is always
> held by the caller.
> 
> > __damon_va_three_regions() is called only by damon_va_three_regions(),
> > which already holds mmap_read_lock(). Since mmap_read_lock() is held,
> 
> [Severity: High]
> This is a pre-existing issue, but when damon_va_three_regions() acquires the
> mmap_read_lock on an external task's mm_struct, is it safe to begin
> traversing the VMA tree without first verifying address space stability?
> 
> If the target process is concurrently undergoing an OOM kill or failed a
> dup_mmap(), the mm_struct could be flagged MMF_UNSTABLE and the maple tree
> could contain XA_ZERO_ENTRY markers. Should damon_va_three_regions() call
> check_stable_address_space() before __damon_va_three_regions() traverses
> the tree, to prevent a potential kernel panic from dereferencing invalid
> markers?

A similar question was asked [1] before.  As I also replied at that time, I
believe this is safe.  Correct me if I'm wrong.

> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index e73ec1ce016e5..882cc7cb09027 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -82,7 +82,6 @@ static int __damon_va_three_regions(struct mm_struct *mm,
> >  	 * If this is too slow, it can be optimised to examine the maple
> >  	 * tree gaps.
> >  	 */
> > -	rcu_read_lock();
> >  	for_each_vma(vmi, vma) {

> 
> [Severity: Medium]
> Will the removal of this lock break the KUnit test
> damon_test_three_regions_in_vmas() located in mm/damon/tests/vaddr-kunit.h?
> 
> The test framework calls __damon_va_three_regions() directly using a dummy
> mm_struct and a maple tree initialized without the MT_FLAGS_LOCK_EXTERN flag.
> Since the test environment doesn't hold the internal maple tree lock or an
> external mmap_lock, won't removing this rcu_read_lock() cause a lockdep
> warning (suspicious rcu_dereference_check usage) when for_each_vma()
> attempts to traverse the tree?

Sounds like making sense to me.  IgorpetinDev, what do you think?

[1] https://lore.kernel.org/damon/20260607172650.93719-1-sj@kernel.org/


Thanks,
SJ

[...]
