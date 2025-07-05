Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69E1386B4;
	Sat,  5 Jul 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751736073; cv=none; b=fujlha/TxZzY6SOYpw8oz23VXjsYBa0zR+9ADHmdVG/sGKStHwq7DPP6cHARx3BYvUupNAIGVWuNBsXvq2z/4McXPoW8UICXnFECZY6SjZAtGhQqMhp9XCh/Qyezq++n0aB47UNA/XEDv0TwgrSWwu2Xd9VGs7X0NHeCTdXXEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751736073; c=relaxed/simple;
	bh=/Ho1FCeRMslp0iSFcSbxoqatW7BGcQM6IaPFn39jEGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3Lv/227fl8bXRhnFRUfU6tnI+mBdLOJY+5IB37ZOqTpahB8YjLCX4h/iuhj8FVYfvH2kJoJR4FYyCs6goHUXwsy5wECdGTqbbo+2nJWRVcecnCEuBb9kRh0s/g+umFO0W0OINpLKesgod0n3Fn51aFlV/RAUnyIYVpjlXGGdEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNkQQmxZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNkQQmxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F67AC4CEE7;
	Sat,  5 Jul 2025 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751736072;
	bh=/Ho1FCeRMslp0iSFcSbxoqatW7BGcQM6IaPFn39jEGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNkQQmxZOgbjELn5OEuD/WPCUfVmiAo/wnxuLUDbn3kqbpAXwCgWDMekD4eX4RLks
	 TNcdePjr1DzJKqhCXbKdGXEg0SV9MGBDY4Tns+D6XPHcq3ZInnmBuV/Q0Cw54QFmC3
	 KeYuUIwhr3Q90N3cKuiurlD5vqoERPuuCz93QXbUi1GRaH5H/loHPCz9cPZ/4i4lj2
	 Z9Os9I1b1uDwE0Qf6+G9PiOCXGQZGrZFuSsNkifSGEcX1pklid+fbA1We4ihr3J34F
	 mKC9WP9XdnQ7EPA952+7nYZV9ntr0LtJHJqET1JPxXPsqkBYRqvhlCE1DV6HdQCUmb
	 n7HlEMxcVWPwg==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 10/106] mm/damon/core.c:2023:3: warning: variable 'sidx' is uninitialized when used here
Date: Sat,  5 Jul 2025 10:21:10 -0700
Message-Id: <20250705172110.52351-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202507051517.bs3jd8RW-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 5 Jul 2025 15:07:36 +0200 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   9af2f87d23cb0b15f32e59e4e9da681454a46eab
> commit: 405b04c2042a3448c2986c909608037f05a3bf0c [10/106] mm/damon: add trace event for effective size quota
> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250705/202507051517.bs3jd8RW-lkp@intel.com/config)
> compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250705/202507051517.bs3jd8RW-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507051517.bs3jd8RW-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/damon/core.c:2023:3: warning: variable 'sidx' is uninitialized when used here [-Wuninitialized]
>     2023 |                 sidx++;
>          |                 ^~~~
>    mm/damon/core.c:2017:29: note: initialize the variable 'sidx' to silence this warning
>     2017 |         unsigned int cidx = 0, sidx;
>          |                                    ^
>          |                                     = 0
>    1 warning generated.

Thank you for this report!  I just posted a fix:
https://lore.kernel.org/20250705172003.52324-1-sj@kernel.org


Thanks,
SJ

[...]
