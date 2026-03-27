Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B335E92E
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774588105; cv=none; b=uXY6A8n/ah6F+3VJrdUm9urFRL5nFDPElJqnKJdxVMRsTsso+stLsL1JiVwhSTVxSWr19NiCSJzkaNI7OLaOCHZSNSg6o2MxGecsZ/UICgSf9OQpEcfQUCeuNbHQkh6hskeyB7g40uoOPNaGxJy4IiMeTu8/iM9ijNkEDMGef+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774588105; c=relaxed/simple;
	bh=jLVZdGJLJNiTat3VGSwLzz+NckJVPWrBPPP0mEtDVtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okX/7WE6Pb5kLcUzr4MZHp/ghXm4UGQwtJ1FvMEMBGBBNngtdXJK+IoniC8VG3kimbPBIYcsaDlhu8SVsKIf6TTJtPDYcH3nInjHGRVgSFxR3wBxBGdwQOuzMb+HUrazC26KW6BDKSi32W1dASZ01+1vNsQGmFbBK2+dRUgtHa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib2cxLuX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib2cxLuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3256BC19423;
	Fri, 27 Mar 2026 05:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774588105;
	bh=jLVZdGJLJNiTat3VGSwLzz+NckJVPWrBPPP0mEtDVtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ib2cxLuXrQb5riivetrfLXV+NLae0rUW28MkCQgXBjGZAN3Ny6KTDfiLSCQ+4DxD7
	 xH5XfAR6Mfcq1cMXeFUuBnqmRaHkqUo6xBwQ1tHRaj7sYnf7Uv0UsXyCWg1ry9Z5LQ
	 /j10FjDAyzGUBwxauWd1pNAp/F978uroKinpw4khWxsTA3bgFTUVs069ekgs4ka+0t
	 +jkIulvwALUR93wJSxRmx84ZFz3RJk3KyOXQJvgpbkRpIw4yBsrkre6wLx3DrBqoah
	 JNwK+LFmWQgEaGo6dw5FUftiKyGGrltpDZFLHzjRuYYP22Z2wJRrCDshFS2FKI8rOq
	 Lx+bheL4V2HuA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC v5] mm/damon: add synchronous commit for commit_inputs
Date: Thu, 26 Mar 2026 22:08:22 -0700
Message-ID: <20260327050823.43382-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326061554.20466-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Mar 2026 14:15:54 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> On Wed, 25 Mar 2026 07:19:56 -0700, SeongJae Park <sj@kernel.org> wrote:
> 
> > Hi Liew,
> > 
> > On Wed, 25 Mar 2026 15:17:09 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> > > I will add a patch in v6 to validate 'addr_unit' in addr_unit_store() to
> > > reject non-power-of-2 inputs immediately.
> > 
> > That's because kdamond_fn() has recently changed to exit the loop if
> > damon_commit_ctx() fails in the loop for any reason.  Refer to commit
> > 26f775a054c3 ("mm/damon/core: avoid use of half-online-committed context") for
> > more details.
> > 
> > Adding the validation in addr_unit_store() would work, but it could be a kind
> > of whack-a-mole game.  I'd prefer doing the validation of all inputs in one
> > place, just before the last damon_commit_ctx() call.  DAMON_SYSFS is doing so,
> > by making a test context and try committing user input to the test context
> > before doing that to the running context.  How about doing so here, too?
> 
> Thank you for the suggestion. I have now added the check
> '!src->addr_unit || ! is_power_of_2(src->addr_unit)' to
> damon_commit_ctx().

No, what I'm suggesting is not adding more checks, but reusing the existing
checks in damon_commit_ctx().

And, now I think bit differently.  Given the purpose of this patch is making
commit_inputs synchronous, I think making more complete validation check is
somewhat that can be done separately.  So my suggestion now is just keeping
this part just as is.

[...]
> > So the issue already exists.  But let's ensure the fix is merged before this
> > patch, since this patch adds another exploitable path that can consequence in
> > whole param_lock deadlock.
> 
> Should I wait for your fix to be merged into damon/next before I post
> the next version?

As long as you agree about the mainline merge order, I think you don't need to
wait for my fix.  Please feel free to post next version.

FYI, the latest version of my fix is available [1] on the mailing list.

[1] https://lore.kernel.org/20260327004952.58266-1-sj@kernel.org


Thanks,
SJ

[...]
