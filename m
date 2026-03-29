Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E425D1E9
	for <damon@lists.linux.dev>; Sun, 29 Mar 2026 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774754456; cv=none; b=KGg0oocIzfBOlbGRI17FBe+u2pqkmN6lvY6SSqSKQhNaLjVSAnV6QapbRYjLLSfgQAUvHMN59oUD0Y6S6sSqvENNIzM6opEusmJWxXvkGkfDSutpcV6p/LFFsdzxRbvzBHPKOJUpQhRtSpfTxT0AkXvxYfrrqCkOCgxCIqXjStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774754456; c=relaxed/simple;
	bh=piAqIhYDF/cuSRB4j6MpAtXLnQgECdf1z6Mkz3i4rhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mM8Qa02hi9m9QqKUj7A2eX5/bGAaZSBGE1HyrHU2VDeinlJatWa0uUy8rh7yCPfL+ys70x8kmfUEDkJ/D9N8Sp1HGQsL6czPMBX38bZAll80mNJTmCSfVqgVvQ52t0OdwNZTxzp/59ADDRHTtV6m+xs/SaTsKZVFc/JDoZ/Mgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOrl0YH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOrl0YH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0284C116C6;
	Sun, 29 Mar 2026 03:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774754456;
	bh=piAqIhYDF/cuSRB4j6MpAtXLnQgECdf1z6Mkz3i4rhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOrl0YH99aD5bDVnGy2oGyWYyNFxNwvun/2UQfVFTfNc3d9GiKPzYJWdQv8B0wIHC
	 uyj82oMyrNQumci0xX/dDa2J25cj94XJw0yfr9qlaKRqwzNgR8uz0fU7xcFEIF6mzs
	 UyUmGwkmLMkjUI1GXi/uEHxFMDdI8fyoH+6LOM/lQ6+jeuWu4GZskXYb5z2xpQYmzF
	 lPeUPkFU9ZoCSDzi0h4j9VRHfQdXUy3GTN8kB5qDipStfEjxBjM6e2g+XCMRp7S6l4
	 wz81eZ/JNH57rzZ5onH/z3jbSjIiSfKA/DMjUsQP6GNLF2HCTCgcKKqglYF3AEwtVR
	 hQ6AwOW0SY1nw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Sat, 28 Mar 2026 20:20:54 -0700
Message-ID: <20260329032054.2443-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328184319.13176-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 29 Mar 2026 02:43:19 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> > Liew, I suggeted two options before.  But you are skipping providing your
> > opinion to those, and adding yet more options.  That makes me difficult to
> > follow the conversation.  Could you please answer to my suggestions and make a
> > consensus about those, first?
> 
> Apologize if my previous email was unclear. Let me directly address your
> two suggestion.
> 
> 1. DAMON_SYSFS Type [1]:
>    I fully agree with this. Centralizing the validation in
>    damon_commit_ctx() is the right approach to avoid "whack-a-mole"
>    problem. This is exactly what I am proposing.

Thank you for clarifying this.  Thanks to that I can show where you are coming
from.  You are misunderstanding what I'm suggesting.  I should have explained
it in more detail.  With this option, I'm not suggesting to update
damon_copmmit_ctx() but the callers, in a way similar to that for DAMON_SYSFS.

> 
> 2. Adding a simple check on existing validation logic (in callers?) [2]:
>    While this is simpler to implement, I prefer avoiding it for the
>    "whack-a-mole".

I suggested option 1 as a way to avoid "whack-a-mole".  I didn't suggest
updting damon_commit_ctx() as the way.

But, the given problem is clear and local.  Validation of addr_unit in
DAMON_RECLAIM and DAMON_LRU_SORT.  There is no problem in DAMON_SYSFS.  So I'd
prefer simpler appraoch on local callers that having problem.

In future, we can make centuralized appraoch, in a way somewhat similar to what
DAMON_SYSFS is doing.  But that's somewhat we can think in future.  For a given
problem, let's fix it first.

> 
> So, to clarify, I choose your first option (centralized check), and I
> believe my "Option 2" is the simple way to implement it.
> 
> Does ths align with your expectation? If so, I will proceed with this
> approach.

So, no, I think we were misunderstanding each other, and I think I understand
you more now, thanks to your clarification.  Also, please don't hesitate at
asking more questions to me if any of my suggestion is unclear.

In short, for this given specific issue, I'd prefer the option 2.  Is this
clear?


Thanks,
SJ

[...]
