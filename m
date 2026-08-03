Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5340B0FB
	for <damon@lists.linux.dev>; Mon,  3 Aug 2026 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766795; cv=none; b=ulrPbrTO8v+XQv8ehdghJ/7sEHZbgJYIJ7tRdyQcBqfqty8Xxjvd6Kc1C+EY3tco0Carl32PLHaLAcwbZxmTJ3mc9U2jJy22furUnvB+xcxR4llszsRegZocVA4TjR8rAl4QHI2zPAx2NifVcRBcyY5oGnQY3cV5/EWwzaKVSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766795; c=relaxed/simple;
	bh=/0wcblrTvYijRIvBpbapBH/l9aMkJ8Bnt6kYZez+LAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKGyxWQCIouZ6Nn/9f9WCjLHMCb8Kr/wgv26mQL+Qf3eOxflHFTt+1Pgdmn042coAw7dJsnMimeEq+uIBxR+qPlFFYsMGoMXumQMHfWWbvC7+Qb5y3umbvB5g/ITgt3ZzojleUWELaCU5sFbFtzTXLyPcYQpjMb6IlF1ZHgJ+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsXh/bnY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsXh/bnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E039A1F00A3A;
	Mon,  3 Aug 2026 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766794;
	bh=Zv6Ff3pNA48CxInYqzleEzA54Vb9J/ThQNvP9+a02v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LsXh/bnYuXjd1WKG6aU5lErg6w7OOEMJfAaC9OlJQ1fP5iPBGx4CLQ3GVD0fu3VaF
	 +NwJZjayXwc6YqPElZ5B3ak/fQV4J+0eqdceLa4qNS8U5R0Hm30WGbM00eJl2RnMEx
	 4Hys8Jv+asN4tIR323FsooZk8L338WaUQw53T4q36+Rk1ANRyAROe+xHi6Nzpc7rUQ
	 +IEnMzhPtvXh7KyHca6Z234bwMhex/HGwLslvinDlmHSeg5CDhJodelCfGKqhtMDKz
	 gsKnh5sH8CDvFvNrnTppdqGnv+/Bv2kK5qwLnQytWIUrv9suNANA18skLMkeW96jZY
	 sU/f5cBtagjcA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/2] mm/damon/reclaim: skip damon_call() if ctx has not started
Date: Mon,  3 Aug 2026 07:19:46 -0700
Message-ID: <20260803141947.17523-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803140642.0DCE51F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 03 Aug 2026 14:06:41 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] The patch fixes an indefinite hang in `mm/damon/reclaim.c` when `commit_inputs` is written before the context is started, but completely misses the identical vulnerability in `mm/damon/lru_sort.c`.
> --
> 
> --- Patch [1]: [PATCH 1/2] mm/damon/reclaim: skip damon_call() if ctx has not started ---
> commit d00b612017f41a8bee83736cc54b16dba8d079ff
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/reclaim: skip damon_call() if ctx has not started
> 
> DAMON_RECLAIM calls damon_call() for commit_inputs parameter user input
> if the DAMON context is initialized. The context could be initialized,
> but not yet successfully started. In the case, damon_call() could
> indefinitely hang. Fix the problem by memorizing if the DAMON context
> has ever successfully started, and skip damon_call() if it has not.
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 09e941d75f67d..45d5557cc575a 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> [ ... ]
> > @@ -291,11 +293,8 @@ static int damon_reclaim_commit_inputs_store(const char *val,
> >  	if (!commit_inputs_request)
> >  		return 0;
> >  
> > -	/*
> > -	 * Skip damon_call() if ctx is not initialized to avoid
> > -	 * NULL pointer dereference.
> > -	 */
> > -	if (!ctx)
> > +	/* Skip damon_call() if ctx has not successfully started. */
> > +	if (!damon_reclaim_damon_has_started)
> >  		return -EINVAL;
> >  
> >  	err = damon_call(ctx, &control);
> 
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by the patch under review,
> but does mm/damon/lru_sort.c also need this same fix?
> 
> Looking at damon_lru_sort_commit_inputs_store() in mm/damon/lru_sort.c, it
> retains the identical vulnerable logic that was patched here in reclaim.c:
> 
> mm/damon/lru_sort.c:damon_lru_sort_commit_inputs_store() {
>     ...
>         /*
>          * Skip damon_call() if ctx is not initialized to avoid
>          * NULL pointer dereference.
>          */
>         if (!ctx)
>                 return -EINVAL;
> 
>         err = damon_call(ctx, &control);
>     ...
> }
> 
> If a user writes 'Y' to /sys/module/damon_lru_sort/parameters/commit_inputs
> before the damon_lru_sort module has been turned on for the first time,
> damon_call() is invoked before the kdamond thread has been created.
> Will this cause the caller to hang indefinitely in wait_for_completion()
> just like the reclaim.c version did?
> 
> Should a similar damon_lru_sort_damon_has_started flag be tracked in
> damon_lru_sort_turn() to fix this in lru_sort.c as well?

The next patch of this series fixes the bug.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260803134646.16640-1-sj@kernel.org?part=1


Thanks,
SJ
