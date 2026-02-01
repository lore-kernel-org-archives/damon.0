Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9921767D;
	Sun,  1 Feb 2026 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769980393; cv=none; b=EvaNaP1me5nBnk2n0RdhzbH8+5vtssEyyBakauSIvd/ugvzw3QxFBdx73nriTkTH/J723SAfDQKr2LWytYjkEEZWZpd6q/EQ4zkB4GVlek+Ptf/0b5A3+ftMokoGejC8fDAHjSFEEhLp5V2iYv+FVIVghwyttvV5LYzEIGpqE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769980393; c=relaxed/simple;
	bh=8mPaUwg4Q4aOCEcnaHaqJ2jRD5NMPk17fSJtRmINmAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzZi8ZisrZYGFVd7QXTQv6LjMgDGtnRclhjX4vl07ZA2BFtVkcWuNW+TS+Xo1Hh3bWle4ThkaNoXtE+//WpBEMibzeyGRPH0ouYQJsqpg8pc8Zl1a8+OeDbzXpPZygPDC94vcriBRmlelKC3tMqXvM0ouzz8joIaeSqCY/LnakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNv0qdL5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNv0qdL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864D5C4CEF7;
	Sun,  1 Feb 2026 21:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769980392;
	bh=8mPaUwg4Q4aOCEcnaHaqJ2jRD5NMPk17fSJtRmINmAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNv0qdL5zkhGOYHu6Z/efGT4YCIuZv0TtNUf0SCml8ezuzeG4QB8sc5tisZq9MGw6
	 +5NY+eHtR99IQA6Tr568zwGZ6ylnRkq5WWXNNA5oY0SWYY4tXmednuaPnEGFiu/7vH
	 3w/K3kbbVIUQC1TkIQbbCpQC5zSTafb1Syfy9HkugVHFLKR9y0+1njBZw32r3t55fK
	 wGM4XiyyYYf7U1MTTMK0baM/8WuGe4ZfguSVlas5XgOY0B5AjTb/6uwFHek8xMYsxf
	 oXiN0uGn5odg0aIJC+SfIl8KSU1m1NbSCDKw5ZCTSmktzqFXMgXWzYtn2Iv2Ccetoh
	 feJFcVsMuZPPg==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 88/101] Warning: mm/damon/core.c:3401 function parameter 'addr_unit' not described in 'damon_set_region_biggest_system_ram_default'
Date: Sun,  1 Feb 2026 13:12:59 -0800
Message-ID: <20260201211303.6133-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202602020406.AepxCDjw-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 02 Feb 2026 04:19:47 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   5421a2e9d5aaa47e870c48ae39e335519e2e62b9
> commit: 3b3c730bfe95de455f2ef37a25f0b46de81a83c3 [88/101] mm/damon/core: receive addr_unit on damon_set_region_biggest_system_ram_default()
> config: riscv-randconfig-001-20260201 (https://download.01.org/0day-ci/archive/20260202/202602020406.AepxCDjw-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260202/202602020406.AepxCDjw-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602020406.AepxCDjw-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> Warning: mm/damon/core.c:3401 function parameter 'addr_unit' not described in 'damon_set_region_biggest_system_ram_default'
> >> Warning: mm/damon/core.c:3401 function parameter 'addr_unit' not described in 'damon_set_region_biggest_system_ram_default'

Thank you for the report, robot!  I just pushed a fix [1] of the kernel-doc to
damon/next tree.

[1] http://git.kernel.org/sj/c/e8e2b3d4553b3c9bffde8698


Thanks,
SJ

[...]
