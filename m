Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1453363C5E
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774193883; cv=none; b=MbEjaiWWEL94h9ir5m3kPW/lPgvnJqm1kxeRzwoT3Ynpboq7hqLzPgabSxQIUHuqdN3qEyLHrqZ0dDwAhgyC9bvm54uuO1G0GlxJ5D/MDrTr11uSxmD5olJ8Oe64OXViZconecPgQURhqHVhu3m0Ph00UArTKtJyY9FxyIZBXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774193883; c=relaxed/simple;
	bh=y0hPXErnp0jJB1YGd3VZBlcKEKQOUYHh4D+PsxChcZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8U5FVP35DTLn7MEvBE0JTv+b4ruRSJGGAewZKJOP4jjk7NBhsa0wuqXlpOV5gCsXAKKcn04NaVroX9BDPO3ldi4yXFD6y8mKr0hfk1CGLlA4TtJ3oP6/PPIXboxiQ/vuKvhYGitHHK1YEZBxkzEMiZT0lzs+6WPht5PgG3SmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af1Q4QHA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af1Q4QHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE6DC19424;
	Sun, 22 Mar 2026 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774193883;
	bh=y0hPXErnp0jJB1YGd3VZBlcKEKQOUYHh4D+PsxChcZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Af1Q4QHASgml94Q0H8OhreMtj3xwkmCcgbERL32oSJvQ3kRglseHUs1I4hp/fE6Gl
	 szwmpxDh4y8vdSQhLWXrZ9R6jJoq+u3Hz6Tc+Z8Tda5jTZ0Q19Fc+VgH+7keguD4As
	 upagkf+rPILehHqSG1p57jr2gPXpVJPWONI8+A5Kryqe/dW9ZDzIsDw35+568dWh36
	 sgdy6O6/1iMRaQS2LYUQdyFMiUpyMVMH35LqeGw8UeZzENriVDV0C1rcG63HmFWzlt
	 YYre51qPEIshFDf6ePVEiFxBkv/bDemG3fe55shOQK/z+iwQxU5ppJu4DIed4OKXI9
	 EYPwxjTCDK4gA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v2] mm/damon: add synchronous validation for commit_inputs
Date: Sun, 22 Mar 2026 08:37:57 -0700
Message-ID: <20260322153758.80748-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322060630.82964-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 14:06:30 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> I tried implementing the synchronous commit using damon_call() as
> suggested, similar to how damon_sysfs_commit_input() works. This
> successfully returns errors to userspace immediately instead of failing
> silently.

Nice.

> 
> However, I observed a side effect during testing:
> Since damon_call() waits for the kdamond thread to process the request,
> the latency of writing to 'commit_inputs' depends on the kdamond's
> wake-up interval (controlled by damos_watermarks.interval).
> 
> In my test with DAMON_LRU_SORT:
> - With '.interval=5s', the write latency can be up to ~5 seconds.
> - When I temporarily increase '.interval=50s' for testing, the latency
>   increased proportionally.
> 
> I understand this is expected behavior for synchronous communication
> with a sleeping kernel thread. However, since 'commit_inputs' is a
> control interface rather than a hot path, I wanted to comfirm:
> 
> Is this level of latency acceptable for the 'commit_inputs' parameter?
> Or should we consider waking up the kdamond thread immediately upon
> receiving a damon_call() request to reduce the worst-case latency?

I believe this level of latency is acceptable.  The special-purpose DAMON
modules are designed for long term use with minimum control.  So I expect
commit_inputs to be used only occasionally in real use case.

Of course, making it faster would be nice, as long as the required change is
very simple.  I have no good ideea about making it really simple, though.
Nonetheless, I think it is not too late to do that after someone starts
complaining, or we find a really good idea.

> 
> For reference, DAMON_SYSFS seems to have similar latency
> charactheristics when using damon_call().

You are right.  And we got no complain about it so far, so I believe that
latency for DAMON_RECLAIM and DAMON_LRU_SORT should be fine.

> 
> Thank you for you high-level comments and the suggestion! :>

My pleasure :)


Thanks,
SJ

[...]
