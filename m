Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F012295DAC;
	Mon,  9 Feb 2026 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650023; cv=none; b=Ss1Ff7TVdulCdwiRPoTRkAOih8c0cPiR6RJU41ENvAhobv8DlLhlKv0n7M8k6a+XAmDcGf3NdyDkK5WgVwoeMQBGm2dhG7WhC27X6o/23S3aoxWsCagp+TkLo8qPyxScLWGw5hjRVCPnnrw70LBhC5kO+440MQcjW6993Kj9d94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650023; c=relaxed/simple;
	bh=LLvWvnjKEvr8ODVZOMmqvmiNrDWj15ksQsiwjeWNcgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFFHcQ21C81+o35I8WBP4WOt4IT28i4fUte1NXELN2KW3IEAOXll1ZFTPvtYBqSbAgLVN3nP7Gl1NRBmMvggEFn4fm2G/M0MtrdN0EjUCkDmcpIRIYh3O3m3/XVS++rQB3n7+bKAHDYggUXb+VVE8NtWjScgUecJ2UizdvrIh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWyyTsnD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWyyTsnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3EDC116C6;
	Mon,  9 Feb 2026 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770650023;
	bh=LLvWvnjKEvr8ODVZOMmqvmiNrDWj15ksQsiwjeWNcgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWyyTsnDDNo8ubjfh7e9kJruxzN05OX5+PK4cTZA4LQ2YzOdRA1eAGWXSMYDVituD
	 T1csU8TzC562JLhv+Oy4mSpsQkaGJVrs25KG3YHPepfKVaYdhVQrChiTkwvMeFXwUo
	 sxKf6I9//LUs53dQWKvZ4blREUVoPdwhGbN5L4A8FcGr+AHu2M9cSKdxM0yd8xPfmA
	 SqNx84N1PvwBtJjlwRq9eI28A7h+Ngc5UxJ7Qxcb0W/dt6B1gJ0wzokMwXNi0oHSzc
	 awCGn0mdcK34nNDrDzhBxEbNhboQXsEdCkEv97FFTvELRIsSV4tlXpx/KEpcnXBM1b
	 9ioULSCAOdEDg==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 112/124] mm/damon/core.c:1862:4: error: use of undeclared identifier 'c'
Date: Mon,  9 Feb 2026 07:13:21 -0800
Message-ID: <20260209151322.54520-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202602092126.d6pfqcbG-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 09 Feb 2026 21:52:26 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   74672caf715ec5f49e15d405b8030ce9cb686d4f
> commit: 7fdffc23ed84ea44a9f15f71d15b00a94f326acd [112/124] mm/damon/core: unify damon_warn_fix_nr_accesses_corruption() with damon_verify_reset_aggregated()
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260209/202602092126.d6pfqcbG-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260209/202602092126.d6pfqcbG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602092126.d6pfqcbG-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/damon/core.c:1862:4: error: use of undeclared identifier 'c'
>     1862 |                         c->passed_sample_intervals,
>          |                         ^
>    mm/damon/core.c:1863:4: error: use of undeclared identifier 'c'
>     1863 |                         c->next_aggregation_sis);
>          |                         ^
>    2 errors generated.

Thank you for this report!  I just reverted the problematic commit and pushed
it to damon/next.


Thanks,
SJ

[...]
