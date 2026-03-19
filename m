Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90E3624CE
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 01:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773884789; cv=none; b=Bpez/u1+iyCOAuWXDgib84rFm/S6Vivy2BV0EzK8gUZwKfsQID+FMypKP+tPQILtWrSe972qJGxxBR0xSDbh16R6AJxB9n7N7s/MuCmynk35fYP0qN/+gyjYy1qjzYrqOzxfTVDq829idJCiqQWHILyCJZAKA2WX9aSKoBadtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773884789; c=relaxed/simple;
	bh=QcvGKX/ZN7Y5gU6WL3L+CNAVoppWyxPddVUrpwP7Fd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIanzpUesOP44PLu526VXDzIPRzw5gQ0FAB5+FQ3R7cDrfjAg9RSyvlpYw5S7r93XcJW+hz6ptPvimP8bf9C53d/pHkSfu9G5q4+DtQj7j20jhBXK0VjhDiAxPlTKwdExOmzre53fAX2/DrsK5Ose7Ea9F3PLv5kNMw+PbSq9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL6GFfvE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL6GFfvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA608C19421;
	Thu, 19 Mar 2026 01:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773884789;
	bh=QcvGKX/ZN7Y5gU6WL3L+CNAVoppWyxPddVUrpwP7Fd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nL6GFfvE2dx1eoG5es87nrmfcUg+GS0fPD2jMZHzAz3ihodmB6EUcwfiRV1iQINmM
	 lCHBalkS9+BkUjL/XJ5n4g2pAydJsSpnKFFa7y0dsu5G78PEzLtEPX0E9cKjmJ7cDi
	 ER+29ingjLiq/qgH5mMmYLPQDuQ9lEH0HzOY0+OblctFvHI9PcKpQxtvPIcqHtbCch
	 lHYZvllCPngdsEtWuSljfSQTfZS3MKZnY4qx4hWMWlTi1IvlSlC4YCq/RFHDefvQWz
	 z0HOnZpo18srQw0R0Kmu2gNrZt5Anwj+a7ndhG3K5rTG8me0cFnflJwv1/t+grV4Dc
	 JVhapaBpvHp0Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [Question] mm/damon: min_nr_regions constraint and inconsistent error handling
Date: Wed, 18 Mar 2026 18:46:24 -0700
Message-ID: <20260319014624.97146-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319012337.96726-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Mar 2026 18:23:36 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Liew,
> 
> On Wed, 18 Mar 2026 23:37:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> > 2. Potential inconsistency in DAMON_LRU_SORT error handling
> > -----------------------------------------------------------
> > 
> > The documentation [1] states:
> > > "If invalid parameters are found while the re-reading, DAMON_LRU_SORT
> >  will be disabled."
> > 
> > However, testing on v7.0-rc4 shows that when commit_inputs fails (e.g.,
> > due to min_nr_regions < 3):
> > - The 'enabled' parameter remains 'Y'
> > - The kdamond thread continues running
> > 
> > This behavior may confuse users who expect the module to safely disable
> > itself upon configuration errors. Should commit_inputs failures trigger
> > an explicit disable (enabled=N)?
> 
> Nice finding!  In short, it is an intended behavior, but the document is
> outdated.
> 
> In the past, the documentation was correct.  When a wrong input is committed,
> DAMON_LRU_SORT was stopped.  That's because it was using damon_callback, which
> is now removed [3].  The callback was executed inside DAMON main loop, and when
> the callback returns an error, the loop was broken.  As a result, DAMON
> execution was stopped.  DAMON_LRU_SORT was setting the parameter inside the
> callback, and was returning an error when the parameter is invalid.  Hence the
> behavior was documented as you noticed.
> 
> Commit a30969436428 ("mm/damon/lru_sort: use damon_commit_ctx()") changed
> the behavior.  It changed DAMON_LRU_SORT to use damon_call() instead of
> damon_callback.  Because damon_call()'s callback function failure doesn't stop
> DAMON, the current behavior is made.
> 
> Still, committing wrong DAMON_LRU_SORT parameters returns an error to the user.
> Hence user can notify it was failed.  The invalid parameters are not really be
> committed to DAMON, so DAMON continues running with valid parameters.  So this
> is technically speaking a visible user behavior change.  But we believed it is
> ok because we were unable to expect users who depend on the old behavior.  I
> think I discussed this somewhere, but I cannot find the link right now...

I found it.  Commit 4c9ea539ad59 ("mm/damon/sysfs: validate user inputs from
damon_sysfs_commit_input()") discuss this.  To quote:

    Online DAMON parameters commit via DAMON sysfs interface can make kdamond
    stop.  This behavior was made because it can make the implementation
    simpler.  The implementation tries committing the parameter without
    validation.  If it finds something wrong in the middle of the parameters
    update, it returns error without reverting the partially committed
    parameters back.  It is safe though, since it immediately breaks kdamond
    main loop in the case of the error return.

    Users can make the wrong parameters by mistake, though.  Stopping kdamond
    in the case is not very useful behavior.  Also this makes it difficult to
    utilize damon_call() instead of damon_callback hook for online parameters
    update, since damon_call() cannot immediately break kdamond main loop in
    the middle.

    Validate the input parameters and return error when it fails before
    starting parameters updates.  In case of mistakenly wrong parameters,
    kdamond can continue running with the old and valid parameters.


Thanks,
SJ

[...]
