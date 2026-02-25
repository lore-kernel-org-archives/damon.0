Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A03D4135;
	Wed, 25 Feb 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034899; cv=none; b=aM1x+f9eKEE0+85DZJYHUQ++8eBYAR2eD/cn1cjX7V46W/NFN4+eG9SiuzWD4PYI8XfdJ/k2/tq9Bfg3TJ2/BkZ2mgW3O6BrbOA/ZY1Ol25m0EbIWecNQXa/NpN6GWCQl+qMHRMeW2l22eZNIi9GPM1BMSxzBRQ0rgBi4O2aKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034899; c=relaxed/simple;
	bh=eQBaVBK8jOBeogv/d30fTOZYNITYZ66n5VNM9sqcYcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsbgoTs3Y66CY4S7D/WPshTKhxSgLIyTsWEKkTIl9R6hGQ2FvR36E1t+Bfd2gWrPywV5YNuyDnT5XYkEeqJYOti1U7BL+cLfLRH6kCJ77E7ctzxiIOkQnainwQOYWaCg2GvHkGxCCDwukM+F0vYA4Rh9KNTi2lWZKQKk+vzniOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4sJC46Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4sJC46Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BA2C19421;
	Wed, 25 Feb 2026 15:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772034898;
	bh=eQBaVBK8jOBeogv/d30fTOZYNITYZ66n5VNM9sqcYcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4sJC46YdONZk2t/+61BPKhKEKTY9JhQwFxobW+G7T+TDA5tYE/BhHy+nlKFRxNpW
	 gtL/b1r2VxqhuzDnSRYBWvd74nv4c8KqrR5z3yuj7mcSsQjOrcAU8oJyOgcKMl4aQZ
	 LkNPvelx1ei9cCKWepsT5jEpmB6myND/HiJxgnhTdI8PGHoNf6caixSurNGN7bcsGE
	 cn0VMT5fVennQ7CwTc2yu+0RGSZJOnAVABjYCHofcwIMddP96RgzkhrQyEvLSkA87y
	 nUYX8bcHyuZkvV5zE2cWX4NhsLNJzCYIz8Jzw8yMaysxd181d0WtFwjwYiQ/PcLpWW
	 OmNT5iXo+Qf2A==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 106/145] mm/damon/core.c:3434:(.text.damon_set_region_system_rams_default+0x138): undefined reference to `__udivdi3'
Date: Wed, 25 Feb 2026 07:54:56 -0800
Message-ID: <20260225155457.4481-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202602251636.PpfZGJU3-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Feb 2026 16:41:28 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   2f2b1e72c03fda4cb12c7027c47840d955d77820
> commit: 38a56aedfeccddd0f844633d1b4c55e2e12c4258 [106/145] mm/damon/lru_sort: cover all system rams
> config: powerpc-randconfig-001-20260225 (https://download.01.org/0day-ci/archive/20260225/202602251636.PpfZGJU3-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 12.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260225/202602251636.PpfZGJU3-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602251636.PpfZGJU3-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    powerpc-linux-ld: mm/damon/core.o: in function `damon_find_system_ram_range':
> >> mm/damon/core.c:3434:(.text.damon_set_region_system_rams_default+0x138): undefined reference to `__udivdi3'
> >> powerpc-linux-ld: mm/damon/core.c:3435:(.text.damon_set_region_system_rams_default+0x164): undefined reference to `__udivdi3'

Thank you for this report!  I just pushed a fix to damon/next.  I'm currently
in travel with limited testing environment, so I was unable to reproduce the
issue, though.  Please let me know if the issue is not yet fixed and bother
you by any chance!


Thanks,
SJ

[...]
