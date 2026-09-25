Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47272440A33;
	Fri, 25 Sep 2026 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326064; cv=none; b=i1Y7ZTbrDqsEJTRY9XE7YwfVjIB4Hdrijvx1pfE6KIXevxQ6e1WdaV4fNImdXUJJEdrHRHIbV946G6qaVWsPQeJkp3XSIsZEvyWfDF/TTPuB8NvMfcBbZlbsNuNqjZW2T0Hu+KXghQKs0Xp5Elke839+npb3lX2WXtYpR6iQ7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326064; c=relaxed/simple;
	bh=Sgo3GIpxGJBDqvnmPeOskab8NY1mloGoZxrclCAZKgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8LAXRFlzg9sbYNq5pSg/7FvWbwig4ZK6QKYcIe2qWHaUJVAhSA927tLFkLJaKCt7Oz2Q1bgmTVV4J/dCeJN1Wsap0uAJGLJG2G7oMSE43Mnlq7s6CebCEjvrUH3T10/7xjtGB5Izr1/JXbmReskqhSQ1qp4Cxp9DwnuocubRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOy3UInD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOy3UInD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6C51F000FF;
	Fri, 25 Sep 2026 08:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790326040;
	bh=y1vL/yQufHRzS8007YyJ1BmyXdeunRacUZuSMuoGx+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oOy3UInDQUVb2Icb2GdANrlDOqYm2WoBKtKvwZCUfs1S/oGOxGpZkfziC70GyA2/5
	 2cyexKetRbt0vlFJKsIJcWfVwRR2Jx2f/bHhgsr2eMaSnvnmDN5tJswN6YcsxEUMkx
	 EkrelxHCJjCdO0grJXBaMOWOxZ5K2sc5U259jiYv2hZcofCoL6ufST58P/IQx/IHVq
	 WV4iwNyyXUrR3ENvaFkivya5BrKrNYR+WA3NigD9XEAdBP7jMkCeGFBAFCCz3wAOxE
	 bQzFwzB9xHRvtpwad2yJeA9MRRqmxdccUR7xF2GG7C/jJmSg7+83t8plPVTxb4/536
	 Jf+/PaswgN0DA==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: preserve the quota passed to damon_new_scheme()
Date: Fri, 25 Sep 2026 01:47:12 -0700
Message-ID: <20260925084713.46887-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924201615.4478-2-kmehltretter@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 22:16:13 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> damon_commit_ctx() first commits the running context's parameters to a
> temporary context for validating proposed updates. When
> damon_commit_schemes() creates the temporary schemes, it passes the
> running scheme's quota as the quota parameter of damon_new_scheme().
> 
> damon_new_scheme() calls damos_quota_init() on that quota before copying
> it to the new scheme. This clears the running scheme's effective quota,
> feedback input and charging state. Even an update rejected with -EINVAL
> loses the running quota state.
> 
> For a size quota, this discards the bytes already charged and allows the
> scheme to use a fresh quota before the reset interval has elapsed. For a
> goal-driven quota, the consist tuner loses its accumulated input and
> restarts from its minimum input. A time quota loses its throughput
> estimate and falls back to the initial estimate.

The end users will show DAMOS works more or less aggressively than expected for
online-commit updates of quotas.  DAMON provides best efforts by detault.
DAMON parameters online commit is supposed to be executed only occationally.
Hence, the issue wouldn't be critical on sane setups.  For user_input type
quota goals, online commit of the user input score is expected to be frequent.
But, for the case commit_schemes_quota_goals command is recommended for optimal
execution, and it doesn't have this bug.

Karl, if you don't mind, I will add the above user impact detail to the commit
message when I apply this to damon/next.

> 
> Commit 60bd24f272d0 ("mm/damon/sysfs: test commit input against realistic
> destination") introduced this problem in v6.19 when sysfs validation
> began committing the running context's parameters to a temporary context.
> Commit b90408ef1163 ("mm/damon/core: safely validate src on
> damon_commit_ctx()") later moved that validation into the core API,
> exposing other callers including DAMON_RECLAIM and DAMON_LRU_SORT.
> 
> Sashiko reported the same side effect [1] on the RFC of the core API
> change.
> 
> Copy the quota to the new scheme first, then initialize that copy. Make
> damos_quota_init() return void, since its return value is no longer needed.

Looks good to me.  Thank you for finding and fixing this, Karl.

> 
> Fixes: 60bd24f272d0 ("mm/damon/sysfs: test commit input against realistic destination")
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/20260702212143.0CB6D1F00A3D@smtp.kernel.org/ [1]
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
