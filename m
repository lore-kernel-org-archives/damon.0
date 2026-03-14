Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AC419CC0C
	for <damon@lists.linux.dev>; Sat, 14 Mar 2026 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447680; cv=none; b=o9onkyF8Aq/uToBcFxkJ++63l8QEMp8aJZlSkVieXYSp0vR95QyjVAIW4wLE5QNsaK12NB9WCWiOulE3MkkvM7fcIzfzLmNtvOx/0XvpmXb8dsesRHHnXdESyhgN9y4OI16dLUqXoCblBNuze6MbgbsqxIPfVCwcny5jbNhGkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447680; c=relaxed/simple;
	bh=UJbfjXt9aVSOiW5buRYz/cMornZh+o9XMfOB8wS5ODw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdrFxS5GG53vsEB480n0Fjuobb8e2ItyFEUpEASQufS4dW/chhx30uzzy1CBDgtJkyEwe35k7du1vX6B0y770ObNJifkSksagezf4IMXYu9VOzSzQKaSgVfspA64dcNvmOGJSvFG+WGZhvGM91qw48m1H0p+vjFe0WIYm1mxd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlMnrYsf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlMnrYsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9FFC19421;
	Sat, 14 Mar 2026 00:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773447680;
	bh=UJbfjXt9aVSOiW5buRYz/cMornZh+o9XMfOB8wS5ODw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlMnrYsfkcmXiMzp0R9Fy9lNXxphl9+8SdFOUvmZBrJb7A5Yjy9BNtfgTWiXQEyvP
	 5XU3wmEKnGqzQ2CCTIQ8kc+cWYraMBJgUVR1DAGkrP4VKjUwdJg+GtzekpmvffYuAB
	 65CFALocwvsnhOTwOukU2smnhLdAgLznSpIGtUqfxH/VQetRYSuOZwFnp4N3d9crBN
	 eW1edtyYB+u+/enfauhYREDy3OPqqlI2aaqwCnVnydA1rs13cU+SrfW2L9KQwXreBh
	 meqOa07Gc0+u0tpXdzhDVrZ9ukUva90nUNAt14/9C0s8eITbdOZMqIvKjslcJhBQbT
	 w/8fVKxQLRbsQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [Question] mm/damon: conflict between DAMON_STAT and DAMON_LRU_SORT?
Date: Fri, 13 Mar 2026 17:21:17 -0700
Message-ID: <20260314002119.79742-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAPLv50pLx+Jk+7so9uWrpy8qzOnvSr5QkbJkQL-kctEwkx=qOQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 14 Mar 2026 03:42:35 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Fri, Mar 13, 2026 at 10:52 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Yes.  But, I think 'Special-Purpose Access-aware Kernel Modules' section of
> > Documentation/mm/damon/design.rst is a better place to document it.
> >
> > Would you mind sending a patch for that?
> >
> 
> Hi SeongJae,
> 
> Thank you so much for your quick and detailed reply!
> 
> I'm happy to send a documentation patch for this. As you suggested, I'll
> add the explanation to the "Special-Purpose Access-aware Kernel Modules"
> section of Documentation/mm/damon/design.rst.
> 
> Additionally, would it be helpful to add a short note with a :ref:
> cross-reference in Documentation/admin-guide/mm/damon/lru_sort.rst
> pointing to that section? I think this could help sysadmins quickly
> understand the reason behind the -EBUSY error without having to dig deep
> into the full design document.

Yes, I think that will be helpful.  Let's do so!

> 
> I may need a few days to prepare the patch properly, I want to
> familiarise myself with the reStructuredText syntax and the current
> design.rst. I'll do my best to send it soon. Is that okay?

That's perfectly fine.  No rush, take your time :)

> 
> Thanks again for your guidance and for maintaining DAMON!

My pleasure!


Thanks,
SJ

[...]
