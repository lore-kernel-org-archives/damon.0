Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E912673AA;
	Fri, 25 Sep 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326966; cv=none; b=GJVCTCCtR6Z7IvssB82RhC6XMCV27x/hy3BKZbmwFMdU7CQP3Q8otWqRJuBneoeYH+11PUS3RGOm887N+QsNyTGmjhNvsN2sNNOZIAsMuzcQLZf4waP2ZuGlm8/jdlX+Z69ELiBG/cO483XWVzg7YA7CROLmUhhrdnh1DpZHVyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326966; c=relaxed/simple;
	bh=Fj3mOvbVT9xCUhbBukmk3cL8upFi2NUM3nGJGdR3y/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2RlhKxQ76PAp/Q08VKTVov2FSYbY2H8oxoBI2NF+erubc4ykZz9gsJ6S9Xv/a0yr2rBKOosv1fLrqR7PgYVtQi0jUqVR2Py8j6v5aIrdBOW3Or0HTOHbZGRrtyNybVjilYcdlAIec7aELDTTwc680aDdiTBkGjkoXYbN6+vhcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLFh2pqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLFh2pqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990F51F000FF;
	Fri, 25 Sep 2026 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790326965;
	bh=rLM0ljOvvM4bUosC68Fkzvro/csdLPxLyGACZG0O20k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLFh2pqyt7vwBmDc2xfuwwE3HOJAa3U3cilehm7Iwjj0EbZo7+crWqLU1COEHF2le
	 MbySZw7N4oqbwgcye2XvZIQcqGk6S4TzH/+Y+1pJl7p1cCrYTIN2jyoaZbI2Zda6Dx
	 KY1fNZkirbh6tu0JFr+2hZasuSViYc71gJvGWlzzmk4RLeptOTd6SI4L81eC72gUEl
	 iKx6jLNKVG8GgncpGP39Luk19+tMaHwJxqCHxJ3R46+gO3XjKR7GyqXiOFSL7dpnJq
	 zeuzrpjYopnspq4L7+yITt2aZ3OhuWzbcs2Qth4NnBjVMjKmhZ8aeJ+/JQYat2tLgH
	 WXPwAp+hLYZrQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Fri, 25 Sep 2026 02:02:38 -0700
Message-ID: <20260925090239.47821-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925045350.66595-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 25 Sep 2026 12:53:35 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Commit 50585192bc2e ("mm/damon/schemes: skip already charged targets and
> regions") introduced a minor issue that causes the last region to be
> skipped before it is processed.
> 
> Example:
> 
>     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
>     2. Quota is configured to process only 100 bytes per window.
>     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
>        addr}_from is saved at (Target, 100).
>     4. Window 2: The loop reaches R2.  Because R2 is
>        damon_last_region(t), the old code unconditionally returns true,
>        skipping R2 entirely and resetting the charge_{target,addr}_from.
> 
>     Result: R2 is permanently skipped even though it has never been
>     processed.
> 
> Add a test to prevent this regression in the future.

The bug is fixed by commit b3723b596b54 ("mm/damon/core: fix unconditionally
skip last region"), which is merged into the mainline for 7.3-rc5.  Could you
update the commit message to mention the fix, rather than the original bug?
The fix commit already has a quite good description of the bug, so I don't
think we need to duplicate it here.

Other than that, looks good to me.


Thanks,
SJ

[...]
