Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F2314A86
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697635; cv=none; b=UK/70zP+BApuWqhBsT9DqGcmfOq3xOW8CGmAARhcj0vEx6fz7lGTx2T9+RZlr4p5MQ9tK2Ej1HB+VyPzk7eeap/LlImxcqS0fXpZaljqMA9DNPjYtHex1yQdeJAvii07/YEhO8IX1cT5zuW+H4sjDPDyDzr51va8pk8LjA+PTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697635; c=relaxed/simple;
	bh=K+H0s+l2XF1muXk0hwS2k0tc9zEvNDnay7+3WcuXPeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkgK0KiTFJWzyIpOrt5Y1cTNpuAviWiwGDcKP8ngpeyFjjkhls0xENViNgjQAsQ9r1A1ctgysNk3Rwr2YNAVZA5sCRzbm6hYyvru0RDnF6cadgCQKiiGb3zGAp+Krk8V2RRYN58WxMHaSiar3AAO0PW+SlMJ5Ttv7w+ZWCeAl5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nODQoubC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nODQoubC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEA01F00A3A;
	Sun,  2 Aug 2026 19:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785697634;
	bh=+2UsLrukQMhr/V3LDjm00NgKIxxEVfTQDOnQbALwq48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nODQoubCp/cW5TdyG1DYT/a0eCg3OkAc/ODqAfPFIYMCGJ/lxSp4Y53O6ZbAkL8o5
	 njcciHJvwSdVy7hep/iQ22+AkpcBOf3pJ/SmK1JCHR5PZ+8i/Yy78Y1ZKZ30fL2N1c
	 kZuYPPFPluSXLZMk2ky29rhllkVJsIi8xsdFk4fgrVDspcSb0B+o+lcP/IQNpoM2hw
	 BL/2aM+lginUCa6Z6X6uUPKMFM/gekUgjkqKfUYeuqJiAvUg9fUslZe6osyHMq/IZ7
	 EEKhfXwKSQEIRx4B7szJpgJbdNZsHg8Y15O9yoJ6ZJ+I7+0VJ8D5i3cHAk41PDgYl+
	 C2LSh97IpVd+A==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/2] mm/damon/reclaim: skip damon_call() if ctx has not started
Date: Sun,  2 Aug 2026 12:07:09 -0700
Message-ID: <20260802190710.10638-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802190431.080611F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 19:04:30 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch fixes an indefinite hang in `mm/damon/reclaim.c` when writing to `commit_inputs` before the DAMON context starts, while failing to apply the identical fix to `mm/damon/lru_sort.c`. This leaves `damon_lru_sort` vulnerable to the exact same bug.
> --
> 
> --- Patch [1]: [RFC PATCH 1/2] mm/damon/reclaim: skip damon_call() if ctx has not started ---
> commit 86e90c966d8636445486cfde6487a797b433cb75
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/reclaim: skip damon_call() if ctx has not started
> 
> This commit addresses an indefinite hang in DAMON reclaim when writing to
> commit_inputs before the context has fully started. It introduces a tracking
> flag to determine whether the DAMON context has successfully started in order
> to safely skip damon_call().
> 
> Cc: <stable@vger.kernel.org> # 7.2.x
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
> [Severity: High]
> This isn't a bug introduced by this patch, but does the same vulnerability
> exist in mm/damon/lru_sort.c?
> 
> It looks like damon_lru_sort_commit_inputs_store() uses the exact same
> logic that was fixed here in reclaim.c:
> 
> mm/damon/lru_sort.c:damon_lru_sort_commit_inputs_store() {
>     ...
>     /*
>      * Skip damon_call() if ctx is not initialized to avoid
>      * NULL pointer dereference.
>      */
>     if (!ctx)
>         return -EINVAL;
> 
>     err = damon_call(ctx, &control);
>     ...
> }
> 
> If a user writes to commit_inputs for damon_lru_sort before the thread has
> started, could damon_call() blindly invoke wait_for_completion() and hang
> indefinitely without a running thread to signal it?
> 
> Should a similar fix be applied to mm/damon/lru_sort.c to prevent a task
> from hanging in an uninterruptible sleep state?

Yes, and the next patch of this series is fixing it.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802185430.9940-1-sj@kernel.org?part=1


Thanks,
SJ
