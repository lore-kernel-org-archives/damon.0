Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055503E5EED
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933336; cv=none; b=Ygs8H4APg+ANzCZNmfgTEcyDUEJSaVlEvVrFfe+pwPPo74zdjj8FdAq0Gq8mVQBJMd+ph84HVq5/ZdqJ4fapiwkfjVlDzIzsbuPtpW8VUYG+eOGcrKpAhDTZmDI9anlhtkGZGgr6D87yIUZDprMIixFlncwgPIabZlKtbpULUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933336; c=relaxed/simple;
	bh=myApSUFfBWDq6Jiq2hPNW90QakIWQOgZc24gvNSByvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j87vJDNh0QFpTxaKCDtGEefu7y7a+depykYWmaeQG8iRDnK8wnNoTHTvCBSaVBu+SnHjjFZU1T3n0iROwtms1Lu80NI1mLdCUUCygRQkTpNlgVylNp+rzKKW15AVR+RZ7ShGMNJ9AOFPhu7XoWTCA0Z/pCuiplDF6Gj2g+ULSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7+R6c3T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7+R6c3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C11DC19425;
	Thu, 19 Mar 2026 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773933335;
	bh=myApSUFfBWDq6Jiq2hPNW90QakIWQOgZc24gvNSByvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7+R6c3TvD4reuMqaSWbBaN71cbGEHp5t4wjlNIpedgQAAywdK8HymV19kd+OPMAJ
	 jKqxpny15NG2CYZN/udcjNez4C3yl7sAxJCwvkM77z5t2Hdwk36Frb2hGHlIg20kk7
	 YI8GJmsSoUZdtgcdp2xkD1r6CScNNUeH5cfvBusNXG5jjBrGnbuAzKDRsR7fpZLAnR
	 5T/nO/sP2XfN9YJ/ja5OP7pavRVCq7IwpuGjH8Zo2krSK+D0Wr420HxaFgeW/s48Sd
	 QR2+Le0IERhiR8azGDO8RVubNPmX2E2Swp7XyRVZrUf4VsO+s0GpbC8BdoaY1KiUcb
	 caeybmlYyauWw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [Question] mm/damon: min_nr_regions constraint and inconsistent error handling
Date: Thu, 19 Mar 2026 08:15:27 -0700
Message-ID: <20260319151528.86490-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319083639.36440-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 16:36:39 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Thu, Mar 19, 2026 at 9:46 AM SeongJae Park <sj@kernel.org> wrote:
> 
> > Hi Liew,
> 
> Hi SeongJae,
> 
> > The initial version of DAMON was supporting only 'vaddr' operation set.  And
> > 'vaddr' is designed to have at least three regions, for the two large unmapped
> > areas on normal virtual address spaces.  Hence we enforced min_nr_regions to be
> > three or larger.
> 
> Thanks for your explanation! It makes perfect sense.
> 
> > Yes, I think this is a nice idea.  Maybe adding a comment on damon_set_attrs(),
> > or additional sentences to 'Monitoring' section of design.rst [2] would be
> > appropriate.
> 
> Agreed. I will try to figure out which method is better,

Doing both may also make sense.

> and I might
> send out a patch in the near future.

Looking forward!

> 
> > I'd like to be cautious about adding logging, as it might be a spam.  I'd
> > prefer making it documented well.  Then, users could find what is wrong.
> 
> I see. I understand your concern about log spam, I will focus on
> documentation.
> 
> > I believe the above command should returned an error.  If not, please let me
> > know.
> 
> I re-tested it on v7.0-rc4 and it did NOT return any error when writing
> 'Y' to 'commit_inputs' with an invalid 'min_nr_regions=1'.
> 
> This might be unintended. Here is the full log of my session:
> 
>     [root@virtme-ng x86_64]# cd /sys/module/damon_lru_sort/parameters/
>     [root@virtme-ng parameters]# cat enabled 
>     N
>     [root@virtme-ng parameters]# echo 65535 > max_nr_regions
>     [root@virtme-ng parameters]# echo 3 > min_nr_regions 
>     [root@virtme-ng parameters]# echo Y > enabled 
>     [root@virtme-ng parameters]# cat kdamond_pid 
>     89
>     [root@virtme-ng parameters]# echo 1 > min_nr_regions 
>     [root@virtme-ng parameters]# echo Y > commit_inputs 
>     [root@virtme-ng parameters]# cat kdamond_pid 
>     89
>     [root@virtme-ng parameters]# cat enabled 
>     Y
>     [root@virtme-ng parameters]# ps aux | rg "kdamond" | rg -v "rg"
>     root        89  0.0  0.0      0     0 ?        I    10:15   0:00 [kdamond.0]

Thank you for sharing this test results.  I also confirmed you are right.  My
above assumption (error on commit_inputs writing) is simply wrong.  In the case
of wrong argument writing, it just silently fails because the commit_inputs
handling is done in background.  So, not a bug.  But maybe something better to
be improved.  I think it is better to return an explicit error and/or document
the behavior in near future.

> 
> > Also, if you know users who depend on the old behavior and therefore hoping the
> > old behavior back, please let me know.
> 
> I don't know of anyone who depends on the old behavior.
> I am a student exploring the kernel (DAMON) as a hobby, so my
> perspective is limited to individual research rather than large-scale
> production environments.

Thank you for sharing the context.  People from different background gives us
very different and important perspectives.  I appreciate all such voices.  And
knowing the context of from where it was made is very helpful at discussing
suggested changes.  Thank you again.

> However, the current behavior (staying alive
> with valid params) feels much more sensible to me. But it should return
> an error when 'commit_inputs=Y'.

I agree.  Maybe something that we can improve.

> 
> ---
> 
> Plan
> ====
> Based on our discussion, my current plan is to:
> 1. Document the 'min_nr_regions' constraint in admin-guide.
> 2. Add the design rationale for the "at least 3 regions" rule in
>    design.rst.
> 3. Remove the outdated sentences claiming DAMON will disable itself on
>    invalid parameters input.

I found an issue in the current behavior, and just posted a fix.  Assuming the
fix is merged, the behavior will again be changed.  So, please do this only
after the fix is merged or completely abandoned.

If the fix is merged, the changed behavior will be something like,

"It will continue running with old valid parameters if the parameters are
wrong.  It will stop running if the parameters update was unable to be
completed due to internal error."

> 4. Investigate and try to fix the missing error return for
>    'commit_inputs'.
> 
> Does this plan cover everything you'd expect?

Yes, this sounds like a very nice plan.  I'm looking forward to your next mail!
:)


Thanks,
SJ

[...]
