Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D808235BF0;
	Mon, 17 Feb 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816679; cv=none; b=CLRNJ1Gc8Q2BgH6JX/p1vLL8nG79H56G71ZEbHF+klyOirYD7nVMw/K/ECtNUfn7TnLROunMMaAvXGr8yz170+b5002JOLHUaO9Yw9loe05MaHVG217Am1aXqabJyE3cAadmEqHE7+6Xg7Uwp0DZn2lIOfAdmgytCmKzBmZJJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816679; c=relaxed/simple;
	bh=dcwzxtOsebPRYaT47Ci4qA40e9Jf4rUjg3IbUYkLncE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jf3ZJvP/eESgajKX1A0DmRdcMn+UHyusCaNH2yvMunmztKPAuBDYs3a3EBF17LwoTRI9vNEZq7EhzSfgut9GoFkdYNvRys7/Ibq1XdWXq6XPC6/NF/jTLi3sGpVOzZs8ZMhikeMupx4CecBImNJKvHAAr/ptWIT7Vv1lloDNzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrBKNuLM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrBKNuLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8861C4CED1;
	Mon, 17 Feb 2025 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739816678;
	bh=dcwzxtOsebPRYaT47Ci4qA40e9Jf4rUjg3IbUYkLncE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YrBKNuLM8rLmx+95+HufFztYWSA39erHM9nbXFJ92OoJOPpQWpvx9FM4YI33ZdVFo
	 AsOs/1pWO/1bu5KLrcNbr+VGino9sFq1bxIEsISLVUxzPADMFYmfss3CdGVkJ9etWW
	 UfgZFqCVcXAIbSuPLmx+4/fvv6AlAJFlRe55hcbvbYAaGuFOg4BUl1LWuO1D0VPlDr
	 6kwQ2L8cRGTa8DWiFHcfPg8UAyAbiV6ibn9XA8bV2ho0F5tkIeVyULX9yUqSOacDKy
	 dlQIxxfwETF68/tNoC2xvdtEVa4zqTW53MP++5mpwq97ou+cZ5zWXFVxfzEal9Knoh
	 TiscRlyUw+Evg==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [linus:master] [mm/damon/sysfs]  9a5aa3349b: kernel-selftests.damon.damos_quota_goal.py.fail
Date: Mon, 17 Feb 2025 10:24:35 -0800
Message-Id: <20250217182435.45244-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202502171423.b28a918d-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 17 Feb 2025 15:01:23 +0800 kernel test robot <oliver.sang@intel.com> wrote:

> 
> 
> Hello,
> 
> kernel test robot noticed "kernel-selftests.damon.damos_quota_goal.py.fail" on:
> 
> commit: 9a5aa3349b9428ae451b22c331d0d9a9cfc7ac90 ("mm/damon/sysfs: use damon_call() for update_schemes_effective_quotas")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      0ad2507d5d93f39619fc42372c347d6006b64319]
> [test failed on linux-next/master 0ae0fa3bf0b44c8611d114a9f69985bf451010c3]
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
> with following parameters:
> 
> 	group: damon
> 
> 
> 
> config: x86_64-dcg_x86_64_defconfig-kselftests
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202502171423.b28a918d-lkp@intel.com
> 
> 
> 
> # timeout set to 300
> # selftests: damon: damos_quota_goal.py
> # score: 0, effective quota: 0 -> 16 (-1.000x)
> # score: 15000, effective quota: 16 -> 1 (0.062x)
> # score: 5000, effective quota: 1 -> 5 (5.000x)
> # score: 18000, effective quota: 1 -> 1 (1.000x)
> # efective bytes not changed: 1
> not ok 7 selftests: damon: damos_quota_goal.py # exit=1

Thank you for this report!  I just posted a fix[1] for this case.  Please refer
to the patch for details including the root cause.

[1] https://lore.kernel.org/20250217182304.45215-1-sj@kernel.org


Thanks,
SJ

> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250217/202502171423.b28a918d-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
