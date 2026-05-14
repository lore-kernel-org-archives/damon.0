Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C427442
	for <damon@lists.linux.dev>; Thu, 14 May 2026 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778733815; cv=none; b=ojNMMvg4XtIU645C4O0bpNH03Ef9DX0+wJiBS0Kxt8BCEWmwYTf+/diqAwIcDmI6PGY5r8bQtTAhUwoV4Rl3Kn45xoJiUoNG6wM9UTIZ8DSt7Oh6zVe/sNb88PGNk9bwYIbrXD/BddIdk49WTbUN3hRPpnzgDGy7fEmSAutTeds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778733815; c=relaxed/simple;
	bh=rO2uQTus7iOihtUlzFNBPpJL/lmLkSfFwE6YwWSiqYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cctgDmDg99wsnZl8b6XD+W5YddYP6hbTnC7uqWMzHkiY0tKlyw8zaoDhxEIgiesSYPlrMwH/ALx7u7H+/eGa72RbbEVEHWYZ26ftsXJolWV3BRogbE3W3Es3Tv2IPDr6cm4eXjZk+DK03XBmPAJ4gYXnssq0yoOacHiLgZ76NUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLrHVPnO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLrHVPnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF9BC2BCB7;
	Thu, 14 May 2026 04:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778733815;
	bh=rO2uQTus7iOihtUlzFNBPpJL/lmLkSfFwE6YwWSiqYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLrHVPnOif8T2R+4Ddhzahhfe4DQrROd0xZdECCrrwT4lpQl0/HOXyryQLtARxCKi
	 rIo+JT/HQFTX+xDwAzB4x/zzHm2gjMIMEDaZcxu6jO2t7ZfEd00EfHL6+CeZAsj5Pc
	 KQav+vik+6UnwY+QhPgt6feZUwcfGVjrj0IvhSJmJgK1rSeOvi0jOUmMlrz1+BNSNp
	 ZXXb8smQNvsgWqbAmHUR7C1NZI7aEheGq0joScXoWevrP71X68ivZgu+awzGknZ9WH
	 wi5RwIFMu3PMCQbWUH9DRi21g5hz57bpiEIruBGPcEmGi07N9acEYBZl+fRRZwZeSv
	 b074jAHhHZvKw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y 1/2] mm/damon/core: implement damon_kdamond_pid()
Date: Wed, 13 May 2026 21:43:20 -0700
Message-ID: <20260514044323.95504-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514013924.20D23C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 01:39:23 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit message references a non-existent function `damon_is_running()` and makes inaccurate claims about the current state of API callers.
> --
> 
> commit 79a54a37fc83e2191edada566d0eb1ab79303fd8
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: implement damon_kdamond_pid()
> 
> This commit hides the kdamond and kdamond_lock fields from DAMON API callers
> by implementing a new damon_kdamond_pid() function to retrieve the worker
> thread's PID.
> 
> Link: https://lkml.kernel.org/r/20260115152047.68415-1-sj@kernel.org
> Link: https://lkml.kernel.org/r/20260115152047.68415-2-sj@kernel.org
> 
> > For the first use case, a dedicated API function, namely
> > 'damon_is_running()' is provided, and all DAMON API callers are using the
> > function for the use case.
> 
> Is damon_is_running() actually present in the codebase at this point?
> 
> The commit message states that damon_is_running() is provided and all API
> callers are using it, but it appears this function does not exist in the
> codebase at the time of this commit. It seems to only be introduced in the
> subsequent patch "mm/damon/lru_sort: detect and use fresh enabled and
> kdamond_pid values" as a backported dependency.
> 
> Furthermore, API callers like mm/damon/sysfs.c (via
> damon_sysfs_ctx_running()) still directly check ctx->kdamond != NULL under
> kdamond_lock.
> 
> Could this description be inaccurate, perhaps due to patches being applied
> out of order during a backport?

Sashiko is correct, this description is inaccurate.  But that's intentional for
stable kernel backports.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/2026051243-crevice-spool-75d8@gregkh?part=1


Thanks,
SJ
