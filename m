Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885112CDBE
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883424; cv=none; b=nNOiKDl95EQHgG8qnid2xBk69wLIvtb05iqPRQbcqhLBrAc9P56sh3z/lBGFSWniRjzzPWDH+u6wQmhj5gc3o8SiXwM9Cc82utCl1PHdGdn3ktsyVT8W0cr0YPrVLsIvIrK78ff27t72WjO8sML8XIwE55b5ea3KRQL3o7flouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883424; c=relaxed/simple;
	bh=/3AxX6eVbCyH06Y2eez24hjlaPrieJrSqToGepAelaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZmcSFzL5iXygMrJMJ6CPmHhAxt7nupLOvZb6nVKoHG88LbriMRi0CkRddaYI6sEl2On4mJeQtRED7/FpthGPurYSuYjtsC9q3zxMPFgERdFR3A0GL9ofCEuYG9d4UWE5AEC7c0npBJcQSg3pSe0D/JMVcyX2pxSA97pUVHcr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAPuipFm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAPuipFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378E1C19421;
	Thu, 19 Mar 2026 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773883424;
	bh=/3AxX6eVbCyH06Y2eez24hjlaPrieJrSqToGepAelaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAPuipFmfUEcAW7WnCMY3N6M4TDhtF3TymnzjXk/rla5o2MsX7IL2lqcXX6jJ8VEd
	 /pURuC7PZKRb+F7HL4g0B6lG5N7CBdBfz4K8Jay0Onx2pyKE4rTqYFQ0I1jadKaQzp
	 Y7lIKnql0orZ6fl4UDGmJnI9a+JzzLY6L86lEklxgmDTKEmfDCJSVi++aR8vtzZ93D
	 8rMlZ5YhSaxMNmYtFNmp4V89oaAMN0P8GnWIHTUkgVl8qVGWyqntr8BvSmHJYvqS4r
	 /semblQTA00WzDuRfTC+b+aSG2brsc06AA3t9fH8N8YR49ZU+9ktS8J9xsc7AQlgTl
	 O7tPyceFmgeNg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [Question] mm/damon: min_nr_regions constraint and inconsistent error handling
Date: Wed, 18 Mar 2026 18:23:36 -0700
Message-ID: <20260319012337.96726-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318153731.97470-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,

On Wed, 18 Mar 2026 23:37:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> TL;DR
> =====
> 1. Why does DAMON require min_nr_regions >= 3? Is there a technical
>    rationale?
> 2. Could we improve error reporting when sysfs parameter validation
>    fails? Or document it?
> 3. [Bug?] DAMON_LRU_SORT doesn't disable itself when commit_inputs fails,
>    contrary to documentation.

Thank you for nice questions, I will reply below in line.

> 
> Details below. Happy to help with patches if helpful.
> 
> Details
> =======
> 
> 1. Error feedback for min_nr_regions validation
> -----------------------------------------------
> 
> While configuring DAMON_LRU_SORT via sysfs, I noticed that setting
> 'min_nr_regions' to a value < 3 (e.g., 1) succeeds at write time, but
> the error only appears later when writing 'Y' to the 'enabled' file,
> which returns -EINVAL.
> 
> Since multiple parameters (intervals, watermarks, etc.) are often
> configured together, a generic -EINVAL at enablement makes it difficult
> to identify which specific parameter violated constraints.
> 
> Code reference: mm/damon/core.c:damon_set_attrs()
> 
>     if (attrs->min_nr_regions < 3)
>         return -EINVAL;
> 
> Question:
> 1. What is the design rationale for requiring min_nr_regions >= 3? (eg.,
>    algorithmic requirements, sampling accuracy, etc.)

The initial version of DAMON was supporting only 'vaddr' operation set.  And
'vaddr' is designed to have at least three regions, for the two large unmapped
areas on normal virtual address spaces.  Hence we enforced min_nr_regions to be
three or larger.

There is no real reason to keep it for 'fvaddr' and 'paddr'.  Maybe we can lift
the restriction for 'fvaddr' and 'paddr' operation sets.  But, we found no real
reason to lift it, either.  As a result, the restriction is still there.  If
you find a reason to lift the restriction, please feel free to let me know, or
send patches for that.

The VMA-based target address range construction desgin doc [1] should explain
more details about the two large unmapped areas.  Please feel free to ask more
clarifications if it doesn't give you enough details.

> 2. Would it be acceptable to improve user feedback? For example:
>    - Document this lower bound explicitly in
>      Documentation/admin-guide/mm/damon/lru_sort.rst

Yes, I think this is a nice idea.  Maybe adding a comment on damon_set_attrs(),
or additional sentences to 'Monitoring' section of design.rst [2] would be
appropriate.

>    - Add pr_warn()/pr_debug() in damon_set_attrs() to log which
>      parameter failed validation and why

I'd like to be cautious about adding logging, as it might be a spam.  I'd
prefer making it documented well.  Then, users could find what is wrong.

> 
> I believe clearer errors or document would make DAMON tuning more
> intuitive for sysadmins and developers.

I agree, the documentation should be helpful.

> 
> ---
> 
> 2. Potential inconsistency in DAMON_LRU_SORT error handling
> -----------------------------------------------------------
> 
> The documentation [1] states:
> > "If invalid parameters are found while the re-reading, DAMON_LRU_SORT
>  will be disabled."
> 
> However, testing on v7.0-rc4 shows that when commit_inputs fails (e.g.,
> due to min_nr_regions < 3):
> - The 'enabled' parameter remains 'Y'
> - The kdamond thread continues running
> 
> This behavior may confuse users who expect the module to safely disable
> itself upon configuration errors. Should commit_inputs failures trigger
> an explicit disable (enabled=N)?

Nice finding!  In short, it is an intended behavior, but the document is
outdated.

In the past, the documentation was correct.  When a wrong input is committed,
DAMON_LRU_SORT was stopped.  That's because it was using damon_callback, which
is now removed [3].  The callback was executed inside DAMON main loop, and when
the callback returns an error, the loop was broken.  As a result, DAMON
execution was stopped.  DAMON_LRU_SORT was setting the parameter inside the
callback, and was returning an error when the parameter is invalid.  Hence the
behavior was documented as you noticed.

Commit a30969436428 ("mm/damon/lru_sort: use damon_commit_ctx()") changed
the behavior.  It changed DAMON_LRU_SORT to use damon_call() instead of
damon_callback.  Because damon_call()'s callback function failure doesn't stop
DAMON, the current behavior is made.

Still, committing wrong DAMON_LRU_SORT parameters returns an error to the user.
Hence user can notify it was failed.  The invalid parameters are not really be
committed to DAMON, so DAMON continues running with valid parameters.  So this
is technically speaking a visible user behavior change.  But we believed it is
ok because we were unable to expect users who depend on the old behavior.  I
think I discussed this somewhere, but I cannot find the link right now...

> 
> Reproduction steps:
> -------------------
> VM: virtme-ng 1.40 (x86_64)
> Kernel: v7.0-rc4
> 
>     cd /sys/module/damon_lru_sort/parameters
>     cat enabled 
>     N
> 
>     # Initial setup - works fine
>     echo 65535 > max_nr_regions 
>     echo 3 > min_nr_regions 
>     echo Y > enabled 
>     cat kdamond_pid 
>     91
> 
>     # Observed behavior:
>     echo 1 > min_nr_regions 
>     echo Y > commit_inputs 

I believe the above command should returned an error.  If not, please let me
know.

>     cat kdamond_pid 
>     91
>     cat enabled 
>     Y
> 
>     # [kdamond.0] still alive
>     ps aux | rg "kdamond"
>     root        91  0.0  0.0      0     0 ?        I    22:03   0:00 [kdamond.0]
> 
> If this is confirmed as unintended behavior, I'd be glad to help
> investigate and submit a fix.

So, this is an intended behavior.  But the document is outdated.  It would be
nice if you could send a patch for fixing the document.

Also, if you know users who depend on the old behavior and therefore hoping the
old behavior back, please let me know.

> 
> ---
> 
> Thanks for your time reviewing this!

Thank you for sharing your findings and questions!

> 
> Best regards,
> Rui Yan
> 
> [1] https://docs.kernel.org/admin-guide/mm/damon/lru_sort.html
> 
> [...]

[1] https://docs.kernel.org/mm/damon/design.html#vma-based-target-address-range-construction
[2] https://docs.kernel.org/mm/damon/design.html#monitoring
[3] commit 5add26c0a186 ("mm/damon/core: remove damon_callback")


Thanks,
SJ
