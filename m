Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B22AF1B
	for <damon@lists.linux.dev>; Wed, 28 Jan 2026 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769562754; cv=none; b=kc+FIprft6FmUMjYG7NqozZ7eIP1d3GrXgSfAAnC43C3BTmr6VDooCITbsP5BiZYBWFGRCsKm4O2wZhNHAC2fH54fE6y4xRZhEAeLhncdPtJ+BxGWq5P0DD89RpvZnPL/6pQKDyFo9c8HWRhCVPQBI++N/Zdnp4UX1QnGt5eTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769562754; c=relaxed/simple;
	bh=E5JEMqlLEKZnt8z5iHSfEMcCreszMzlgNWP4t5dtXMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qT2+f8KWDpIo1gqVBNMe+pcoc7fHpwiGLgUuqOZ4QxRiKaAUIKdNgjdKhLNl2M5t9CuJz9nftYlCyL5fIwCV7LrF+OHfwWMXmPgvgEm/QkgDLyTlRiiSDf4mr4YCCh6vwnkxkXmNxefj3NqXFCxOMvG2AT0v9CN2P3S3QJ+Xj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxqdV3Qz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxqdV3Qz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F6BC116C6;
	Wed, 28 Jan 2026 01:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769562753;
	bh=E5JEMqlLEKZnt8z5iHSfEMcCreszMzlgNWP4t5dtXMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxqdV3QzmqE23Ry78g1bCQioiq3nA4bvXkHT1V6pCLpVvEuXb5ssg/rJcGXS5eXjw
	 fl/upZyEHbqOe1lATexJOXlcguVJ9aKGLJ9GLNdP06rji/kL666kC4qdjDNcGlc/QK
	 Jg9B8F0kWbxWLzzofAYSd0fnpoNqrWIFiup4FmlaGFbHsnkdbpCYlCoGrdwuPp563X
	 6LvzSkpwgbNvcSP8SeDQ3KcmRNUbtNPz/7+PPDHWG6gRq/hJFHJz0Oxr/2ugkkU0DX
	 YBO0VUMLVMiufH0tsRSksgwVjozQzg9J0pTBF72Vdol5dhf+umd0U04c8AfwgsllU1
	 V/b7t0x4ktffQ==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Date: Tue, 27 Jan 2026 17:12:23 -0800
Message-ID: <20260128011225.71964-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umyhVW+Rh2YfUCZCPu_7NuBh8FSGrsK23_EopDv2ixAe36w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 27 Jan 2026 21:56:43 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2026年1月27日(火) 15:43 SeongJae Park <sj@kernel.org>:
> > Actually DAMON is internally setting such maximum region size based on the
> > min_nr_regions parameter, via damon_region_sz_limit().  Nonetheless, the limit
> > is applied only in regions merge time.  That's why it requires the regions
> > split to happen sufficiently until the real fixed granularity monitoring is
> > started.
> >
> > And I think this behavior is just a bug, or suboptimum implementation at least.
> > That is, users set the minimum number of regions but it may not really be kept.
> > That's definitely confusing behavior.  Actually there was a similar case that
> > number of regions can be larger than the max_nr_regions.  We fixed it, with
> > commit 310d6c15e910 ("mm/damon/core: merge regions aggressively when
> > max_nr_regions is unmet").  I think we discussed about similar case for
> > min_nr_regions, but I cannot find the discussion for now.
> >
> > So, I think it is better to fix this rather than introducing a new parameter.
> 
> I agree with that.
> 
> > Maybe we can split regions based on the min_nr_regions based size limit, before
> > starting the main loop of kdamond_fn().  Similar to the max_nr_regions
> > violation, there could be yet another corner case on online parameters commit
> > situation, so it would better to check the case, too.  You could implement such
> > fix on your own, or let me do that.  In the latter case, if you don't mind, I
> > will add your Reported-by: tag to the fix.  Please let me know your
> > preferrence.
> 
> You'll be better able to fix it, so please fix it at your convenience.
> Adding Reported-by: tag is fine.

Sounds good, I will do so!


Thanks,
SJ

[...]
