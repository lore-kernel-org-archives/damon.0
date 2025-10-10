Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694CEEC0;
	Fri, 10 Oct 2025 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124263; cv=none; b=aPoy1w1drM2qiv/TLlUrPwzyEmrxvgqvrERtkklEiPn/qM7ova6HmtiQr0pkBpE+Re1GsmayY3B6rZNzvIfFYTER8j8ZXpHz0YSaSJRIwEJHegVC7F4Zo7ckchBPh3D7s5QPW6PaAS5nAjh/RUaCGYHeMwcZcThUZt6pxzUkavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124263; c=relaxed/simple;
	bh=wacxqjhaNJRFe2toN8dkgWa+u2eeZuIHOC9tnNjzXwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVIa/UUWsnnmfyB9xT1aKhEdQ0KZBRp0u5Gy2dbsBigG+kyuPhFH4BJVldUP7/v0pXcKrS7px56TYTCsey1U60PGUjDu9NrFj3s8YIEBs+8RHx1JtwbKTQG/5lpein+lmgCF7XVNIEgaFM4upwVVsC83HulWxznWxiiy6DBMpC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4QcnGoK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4QcnGoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B1BC4CEF1;
	Fri, 10 Oct 2025 19:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760124262;
	bh=wacxqjhaNJRFe2toN8dkgWa+u2eeZuIHOC9tnNjzXwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4QcnGoKb4eqLodZH8ZADPFVrayuFGCLWwmkhL1uXt4HvAuJL++oM6fG+yDSDfz8j
	 /mDnSWDcHIkLmcBMymCrFh+yUBbM6Ll6cymBlcKZtBfdkBDMOpumKF099cMjZxNcM7
	 1LNAX7rpVAk8lSPZx1NHUshVxV5k46Po1snq4247ajiPPtM5Uqqcr3pe1AiiXBT4Ye
	 cOZEjs0Qw3n9k7MbvE9DecTqjWzde2s0/dAi6CVV/9oNc01XFym8OeTQZyUzAIcBWS
	 tRyDiXqqCzOkWoUUTQoioy4v9mXlS/lgoz7zP6/2SRRoWgafiZu3GBW6uorf0dH0nQ
	 QNnI1IaQXptbw==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 110/125] include/kunit/test.h:856:55: error: initialization of 'long long int' from 'struct pid *' makes integer from pointer without a cast
Date: Fri, 10 Oct 2025 12:24:19 -0700
Message-Id: <20251010192419.80269-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202510110228.zqDtbwu2-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 Oct 2025 02:09:20 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   5a0a5c1e0bffb2e9e03585bc8dc55d9f92cae922
> commit: 5ec355855dbc2d67587b6a10fef52c6cd3b1716e [110/125] mm/damon/tests/core-kunit: check target fields one by one
> config: um-randconfig-002-20251010 (https://download.01.org/0day-ci/archive/20251011/202510110228.zqDtbwu2-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110228.zqDtbwu2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510110228.zqDtbwu2-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from mm/damon/tests/core-kunit.h:15,
>                     from mm/damon/core.c:3165:
>    mm/damon/tests/core-kunit.h: In function 'damon_test_commit_ctx_ensure_target_committed':

Apparently this is same to another one [1].  Just pushed a fix.  For more
details, please refer to the another thread [1].

[1] https://lore.kernel.org/202510110139.QxBWTjZO-lkp@intel.com


Thanks,
SJ

[...]
