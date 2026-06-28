Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CD13A258
	for <damon@lists.linux.dev>; Sun, 28 Jun 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782668733; cv=none; b=moaLYqxlHcTti7ChHcxcWyqqh3DZUCaI3uwAX6S0gtj7lWrQrRtluD7gOA2QE2xZT4C1zi4pXLfoJ4HSxovUzxpLkNEqkoS+vx85vN2F+L4cobruu0FvNL4xfsiWNdf7q+yxKbNwzhn8vpb3wPGXrwipTn65swSsNPiHjRVgvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782668733; c=relaxed/simple;
	bh=qtkhln1ST8aba9+dAemZMiPnMAaxS3Vod+QPTSShjGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/Ei1M/YxKEztkMN1gV8frsS7QzSyKvAiLyAdAdf4WxLUAdDG4K8BEFCEPA16xRa9aX6vFyuEOx3592x4Azeqa6iFSWlFzlzdJTCnoICzksWyg9B/Z6OS/TM/jDLXwW3/Dnz9PKztHemEaCc5CDwrV7GK9HnvlvQJlme+sdxglY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvWzux4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvWzux4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEBF1F000E9;
	Sun, 28 Jun 2026 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782668732;
	bh=VPrBZ5ResIa1C1ONfq1oYGXcYKWmgjIND2BZjHPkE8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JvWzux4MfnRbimHeproenb68YZl+k6JT/U7Qybg0bN0afPmsqz6cBBLlh9KyoCvSR
	 dSDcLn/WYn41JXgx0ryGk44wxSq2u9Sa2TGqkfFkQwNRNdVFF4ZdiE0RMfiIefySS3
	 jo9cPpJtMwzHmMOLXEzJ1lK3/lP4XNES4j9jBq+NLjKb/6mx6SXgPXt7cIjgmCPM0q
	 D5WyiIrvAR35hrtWejEkKzF8LlajWqCK3DiZfZon66kWTr+ycfDRWWTq7xuALdvA72
	 IVwK8kxXHtPOpZThH2QJfcVTeUcYwRbeWdz6RfhvhvdENblt7u5e//MRmWp4azZldA
	 RIr3KOyfut1AA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2] mm/damon/core: validate ranges in damon_set_regions()
Date: Sun, 28 Jun 2026 10:45:23 -0700
Message-ID: <20260628174524.88480-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628170922.597F81F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026 17:09:21 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Flawed Validation Logic for Empty and Inverted Regions
> --
> 
> commit 663c371bd35c3a6e3044a1a0a7c4a31852e3924f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: validate ranges in damon_set_regions()
> 
> This commit adds validation logic to damon_set_regions() to ensure that 
> empty monitoring target regions are rejected. This prevents division-by-zero 
> errors and sanity check warnings within the DAMON core logic.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -358,6 +358,12 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >  	unsigned int i;
> >  	int err;
> >  
> > +	for (i = 0; i < nr_ranges; i++) {
> > +		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >> +				ALIGN(ranges[i].end, min_region_sz))
> > +			return -EINVAL;
> > +	}
> > +
> 
> [Severity: Medium]
> Does this validation logic correctly reject unaligned empty or inverted
> ranges?
> 
> It looks like the alignment macros are applied before evaluating the bounds.
> If a caller provides an unaligned empty range like [4097, 4097], ALIGN_DOWN 
> makes the start 4096, and ALIGN makes the end 8192. This evaluates to 
> 4096 >= 8192, which is false, allowing the empty range to bypass the check 
> and silently expand into a valid monitoring region.
> 
> Conversely, a page-aligned empty range like [4096, 4096] evaluates as 
> 4096 >= 4096 and is correctly rejected. Similarly, an inverted range like 
> [4000, 3000] would align to [0, 4096) and be accepted.
> 
> Should the raw input bounds (ranges[i].start >= ranges[i].end) be validated
> prior to applying the alignment macros?

Sashiko's behavior expectation is correct.  And that could be not really good
user experience.  But I think that's what we could improve in future unless it
introduces too much complexity, rather than somewhat need to be implemented
right now blocking this fix.

So, no blocker.  I will consider improving the user experience as a future
work.


Thanks,
SJ

[...]
