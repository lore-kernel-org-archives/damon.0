Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108F2FB6
	for <damon@lists.linux.dev>; Sun,  4 Aug 2024 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722798305; cv=none; b=rrTUL7Naif9BMQ4yuQbJr0Pht2FC/zOnxYgM70ykEKhhbcpREeI2RRF1I3C1+Ncr7KofnTCcGoMd5ZbJC2Lggxh7RfH6esXYTd0342Js8gB4HZwR5C2c8MlDK8FQEQcWUqS7ymQzF2hSbSGbHqkOXFSoCSWAoADlquX/y/ZFfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722798305; c=relaxed/simple;
	bh=LS6IV+czE9tPUoVn3wLrwyLpgpUolytZqciMdRFna3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BovvAKhDVv8Lee+2Q0V2BeihB4TePIbwP4Kd8xbvNw5HVzH0v/sZ46eUylux/3Tn++x92ZcrHMAvOSSnD92fMYC3LGzHOSn9tkDs11+CUpkcVvz1jTrPjAtK6klPf0pwTKii3fcrmdTweVz5I8UVU07EIMMIsS3/B2QsC62kvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPuPwxRp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPuPwxRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40732C32786;
	Sun,  4 Aug 2024 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722798305;
	bh=LS6IV+czE9tPUoVn3wLrwyLpgpUolytZqciMdRFna3I=;
	h=From:To:Cc:Subject:Date:From;
	b=SPuPwxRpHgCPAlSSvGk8ShZlN/8wvmgL0TUSzbfj+G0Hk0YCKKn8kVux7VLwJoRi/
	 A6fD+J/prtq8mTfhPiMUFE4zpXwZuymh8xFK/tNhfE2z8anXQoAHYcAiUJzwcqMpLY
	 PgJqkagaz2/IW0L/CSE5mrfR1cz2pYZQxXMRP7wN1wSDNiiRVyOp6OoKV9IUpauxj/
	 THHtVwp5AmjHMpfG7rd4+Hbi5JW8Ac2u2MH2ghRbUkR2EPzhpjd9thsaOT1uwTHNJ6
	 U4xyzCO5o/T6SUulQ0BUSIVvcjvRB0JnzB220Y1XnzDvma21FOE2z7DUdotEcaNF5g
	 ma9Osd2EcoJtg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>
Subject: Fwd: Re: [sj:damon/next 36/44] mm/damon/vaddr.c:311:22: error: implicit declaration of function 'pmd_present'; did you mean 'p4d_present'?
Date: Sun,  4 Aug 2024 12:05:01 -0700
Message-Id: <20240804190501.92540-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding below to DAMON mailing list for future references.

=== >8 ===
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
CC: SeongJae Park <sj@kernel.org>, oe-kbuild-all@lists.linux.dev
Subject: Re: [sj:damon/next 36/44] mm/damon/vaddr.c:311:22: error: implicit declaration of function 'pmd_present'; did you mean 'p4d_present'?
Message-Id: <20240804185944.92344-1-sj@kernel.org>
In-Reply-To: <202408040440.Oe31R40L-lkp@intel.com>
Date: Sun,  4 Aug 2024 11:59:44 -0700
Local-Date: 2024-08-04 11:59:44-07:00

Hi robot,

On Sun, 4 Aug 2024 04:54:56 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi SeongJae,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   fec73193b080d068291509554d3e4b21622ede2d
> commit: 069dc62c4181e3c1a10fa833c176b52765c05564 [36/44] mm/damon/Kconfig: select DAMON modules to test when test config is set
> config: arm-randconfig-001-20240804 (https://download.01.org/0day-ci/archive/20240804/202408040440.Oe31R40L-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240804/202408040440.Oe31R40L-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408040440.Oe31R40L-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    mm/damon/vaddr.c: In function 'damon_mkold_pmd_entry':
>    mm/damon/vaddr.c:307:13: error: implicit declaration of function 'pmd_trans_huge'; did you mean 'pmd_trans_huge_lock'? [-Wimplicit-function-declaration]
>      307 |         if (pmd_trans_huge(pmdp_get(pmd))) {
>          |             ^~~~~~~~~~~~~~
>          |             pmd_trans_huge_lock

Thank you for this report.  This specific issue can be fixed by making
DAMON_VADDR_KUNIT_TEST depends on MMU, or select MMU.  However, I think this
might be abusing the 'select' too much.

I'll revert[1] the commit and consider adding '.kunitconfig' file for DAMON kunit
tests, like others.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/damon-hack.git/commit/?id=ef79e03b2a6355bd234cf611e5ad55f4f379fbc9


Thanks,
SJ

[...]
