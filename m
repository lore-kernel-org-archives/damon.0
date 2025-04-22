Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D53293B76
	for <damon@lists.linux.dev>; Tue, 22 Apr 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340914; cv=none; b=KToHuc80ygRi6ziH/76KD1GOGJI4EbKAHPWSHpCjwK5liBtPKkFR3zjLWlkT0vRWGYE0C7y4MymRO01O8pk6THr3ZsL8UGh+uVnSa8/VT0qNlBiCf8Tng75h1S61YL1Iop07TOcNL7KmH7vGo9sJyorlkgsnuymOC5m5qbpoz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340914; c=relaxed/simple;
	bh=6NlG+4FrVHI1VglAibdakrhmpUdt9KakPG7b2mDPRz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aVHlsnok9qKRmA16vYDk+VLJeQEyaBGfwRyTxxlcQIePIxqDQbNcMbgWTAKft53xgQo5+Y6G5FX81JgZl+pq85U59/cB7cIhCAEEAyccw5fY49knoKSTfBJ1lwMBn2x8I4+lfiJBX77JZwyVMzzr/LYXYapv9TsjjB0zT1XVR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0OQQvme; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0OQQvme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F801C4CEE9;
	Tue, 22 Apr 2025 16:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745340913;
	bh=6NlG+4FrVHI1VglAibdakrhmpUdt9KakPG7b2mDPRz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0OQQvmepvkbfYBH+fgcYuZYP5iy4e+LKpYVhOpM420cQv6RohfAo7lx/Ud+2d1N7
	 oJ+qUItt14wyIu5u9XL2yAyjiQ8Je2sbrKH0F4qBv+6w+QbcxKAsIP7/ZCUC4s5rMu
	 I7W41s+tE0owYmpcTLAczZiwYMPFo3RrHEIkqJ7RFwa/YoL1wvqf7Ppn+jOSsIIdMv
	 s2LtrdUB55acyccaEucijjB7rDPIou4PgN2Toikp/qsCKKbKCRLaUJ/MGQhprS0HJ7
	 L0YWMpwAsK/nkZ5gp4QVIJwkmqDLa/pX5FmBPjMvSBweLu3tTw0LvtYRpuTJqjWrVc
	 S2XSVOoTdi2HQ==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: Initialize sampling_addr in damon_new_region()
Date: Tue, 22 Apr 2025 09:55:11 -0700
Message-Id: <20250422165511.58332-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87plh46gf1.fsf@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Apr 2025 14:09:09 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Hi SeongJae,
> 
> Thanks for your review!  When examining this function, I instinctively
> verified the initialization of all member variables.  Personally, I'm
> quite partial to the practice of initializing all fields when creating
> an object - though I fully acknowledge that initializing sampling_addr
> may currently have no practical consequences.  This patch serves purely
> as a preventive measure,

Thank you for kindly clarifying the context.

> so please don't hesitate to drop it if you
> consider it superfluous.

Yes, I don't think we need this exact change, based on the details that you
kindly shared.  Thank you again for the sharing and generously understanding
this decision.

Nevertheless, I feel like maybe the documentations and comments could be
improved to reduce this kind of confusion.  If you find the room to improve,
please feel free to submit a patch or suggest changes.

FYI, please consider trimmed interleaved replies in future:
https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions


Thanks,
SJ

> 
> Best Regards,
> Enze
> 
> On Mon, Apr 21 2025 at 09:55:25 AM -0700, SeongJae Park wrote:
> > On Mon, 21 Apr 2025 11:39:19 +0800 Enze Li <lienze@kylinos.cn> wrote:
> >
> >> Since sampling_addr is used across vaddr and paddr modules, initialize
> >> it in damon_new_region().
> >> 
> >> Signed-off-by: Enze Li <lienze@kylinos.cn>
> >> ---
> >>  mm/damon/core.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/mm/damon/core.c b/mm/damon/core.c
> >> index f0c1676f0599..d197a5e3901c 100644
> >> --- a/mm/damon/core.c
> >> +++ b/mm/damon/core.c
> >> @@ -128,6 +128,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
> >>  
> >>  	region->ar.start = start;
> >>  	region->ar.end = end;
> >> +	region->sampling_addr = 0;
> >>  	region->nr_accesses = 0;
> >>  	region->nr_accesses_bp = 0;
> >>  	INIT_LIST_HEAD(&region->list);
> >
> > I unfortunately cannot find why this is required.  Is there a use case that
> > reads uninitialized sampling_addr or any problem that comes from the fact that
> > damon_new_regions() is not initializing the field?
> >
> > Only operations set implementations write and read damon_region->sampling_addr,
> > so I was thinking not initializing the field on the core layer is no problem.
> > I will be happy to be corrected if I'm missing something.
> >
> >
> > Thanks,
> > SJ
> >
> >> 
> >> base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
> >> -- 
> >> 2.43.0
