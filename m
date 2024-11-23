Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943018C0C;
	Sat, 23 Nov 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732376833; cv=none; b=aiiDcask1kbQ9EInYnJmeAiMYrel6uL2HEudPYPAYS6V5A+IdeOE9ZKTD2tThU/NqiKjDH7zODMGGnjSn7gN9ddztwv7Rf9TgZEgc08fGTyAd0ySwLxnMhczcpgDOfexOnPPZEBQfMoHAtGfhNCvKC/TSrAFFynyxvDwcQYfKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732376833; c=relaxed/simple;
	bh=LU8w1mOFm9HvtBac0/wLpfSHyt0/N/hI4iDHMeXl0KE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQnllaeoGKvbmzgJuej8dOqmWc4r49gvj9z0h5TnD5q3ZmjK/XIGRpwjz3/BJirnQbGBsJTvFmX3cT+rB78QiNs1GtyoKmYFmMrY0BKBhMMqjKVb9vLEsZfdtKILljcV2uIa/uDy3qftKx+PrpDMl5nAu90L4vXL+OMZwUPX104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIrBpsyi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIrBpsyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E29FC4CECD;
	Sat, 23 Nov 2024 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732376832;
	bh=LU8w1mOFm9HvtBac0/wLpfSHyt0/N/hI4iDHMeXl0KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIrBpsyiE2w4F08NatlrgGID9njJb2h1sA05T7qoPFDDwlwxyGOVl9U9OT01kHRxM
	 nxbrVaoH3418ZLgqlby+8rslrVFlKBJQ3HlJkxPzFxrV+Dj9pAHMaZxsJsrV5G1XaC
	 /FAnGavHqquZnH5NkiRiXMQ5MBk9hccsMNvfIAr6+eZin6lupseP2azOlsgRI8dW07
	 jZxqwUUXvKFyfbxmxc8LFHAr6G3bZhe24zmsr1HWadtGE8CIBJZf9cHuVPvfLv2dd+
	 3VHSy5pDPUagiRC1KW0BgusF2O6JLeIY3i+E3uUo5+31U69vWkHGJoIASZhg/0P7V9
	 ewhFWqDzX2w+g==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 12/59] include/vdso/limits.h:13:25: warning: conversion from 'long unsigned int' to 'unsigned int' changes value from '18446744073709551615' to '4294967295'
Date: Sat, 23 Nov 2024 07:47:10 -0800
Message-Id: <20241123154710.52823-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202411231420.di7hRYuZ-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 23 Nov 2024 14:28:19 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   78907e9aaa2afc17557ccada5eeafa2f4423ddcc
> commit: 6a0ed0a7aac349150628bda45521200cb75006c2 [12/59] samples/damon/prcl: implement schemes setup
> config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241123/202411231420.di7hRYuZ-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241123/202411231420.di7hRYuZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411231420.di7hRYuZ-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/limits.h:7,
>                     from include/linux/kernel.h:17,
>                     from include/linux/cpumask.h:11,
>                     from arch/s390/include/asm/processor.h:31,
>                     from include/linux/sched.h:13,
>                     from include/linux/cgroup.h:12,
>                     from include/linux/memcontrol.h:13,
>                     from include/linux/damon.h:11,
>                     from samples/damon/prcl.c:9:
>    samples/damon/prcl.c: In function 'damon_sample_prcl_start':
> >> include/vdso/limits.h:13:25: warning: conversion from 'long unsigned int' to 'unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
>       13 | #define ULONG_MAX       (~0UL)
>          |                         ^
>    samples/damon/prcl.c:86:43: note: in expansion of macro 'ULONG_MAX'
>       86 |                         .max_age_region = ULONG_MAX},
>          |                                           ^~~~~~~~~

Thank you for this report!  I replied to same report:
https://lore.kernel.org/20241123154433.52687-1-sj@kernel.org  Please refer to
the thread.


Thanks,
SJ

[...]
