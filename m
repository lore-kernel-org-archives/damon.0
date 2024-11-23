Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38B2770B;
	Sat, 23 Nov 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732376676; cv=none; b=nV0XzAK7H3rVmDRMId1jYKnEd47CzsgCYYEwiAMAf0BWs5t6EFJ9He1OVDOwaGmPMSvd3waOhoXDYmwztoZRvgkZSq9QAuKVNuYhWs7GTJdrKWfM0jrbmIebrSyBUb+9+4isLEwaxcVpFE8qM0tHEnRgy7dI67a2+MeFJCvQ4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732376676; c=relaxed/simple;
	bh=eREf6+PuvHEx4ifTbBV5FzQdlxai1Wh0qMkDepBAK+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGOBYMKOa2EgVqXMUtNtcstOZ1Ctj+vEGWwm7rWqLyMdFnJD/nUqUcZkf93WNQIdDQT4al8pbwTGbvz62H9BK9X9nKpdjzReId9fVFcFvsCsAVEQYN7fuXZaPGbz7YyZ2VufDl8q9ULHz/9f6RnYl/IBaEa+4CZblMBeTZMy8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/gklImV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/gklImV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D92DC4CECD;
	Sat, 23 Nov 2024 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732376676;
	bh=eREf6+PuvHEx4ifTbBV5FzQdlxai1Wh0qMkDepBAK+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/gklImVYLZnKfye/A2lUAQh0bJn/XDsHIFWCvrFmH80F2915SUhLLPeRkYFfJrt6
	 97QnjBWzD3o+SoNHXCue1fGw+HUHxjpYV1+tQTcCszFLo4hI3je+7t499jRH0k69l/
	 iSRSVQj90bSZ5ue3UC6blHSCMOOH91kVGp+8Dlp0Q1ceAxWsMFUo3hS4az90n8TqlE
	 LQygokn9sLABP+5+0SPCNDD8W/CVtWayUtWJqU0xItNH81ShqBQ0NGl5E+UhYXTFH4
	 oF+ipK8TuuVGxX3E7hcNFkzAK1gU0rmb1o0g+wp3LjxJBORV/ZNSmeNvzCuazYOMpQ
	 59LX8NLBj2AGQ==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 12/59] samples/damon/prcl.c:86:22: warning: implicit conversion from 'unsigned long' to 'unsigned int' changes value from 18446744073709551615 to 4294967295
Date: Sat, 23 Nov 2024 07:44:33 -0800
Message-Id: <20241123154433.52687-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202411231754.4u5u1Nwv-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 23 Nov 2024 15:20:07 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   78907e9aaa2afc17557ccada5eeafa2f4423ddcc
> commit: 6a0ed0a7aac349150628bda45521200cb75006c2 [12/59] samples/damon/prcl: implement schemes setup
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241123/202411231754.4u5u1Nwv-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241123/202411231754.4u5u1Nwv-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411231754.4u5u1Nwv-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
[...]
> >> samples/damon/prcl.c:86:22: warning: implicit conversion from 'unsigned long' to 'unsigned int' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
>       80 |                         &(struct damos_access_pattern) {
>          |                                                        ~
>       81 |                         .min_sz_region = PAGE_SIZE,
>       82 |                         .max_sz_region = ULONG_MAX,
>       83 |                         .min_nr_accesses = 0,
>       84 |                         .max_nr_accesses = 0,
>       85 |                         .min_age_region = 50,
>       86 |                         .max_age_region = ULONG_MAX},
>          |                                           ^~~~~~~~~
>    include/vdso/limits.h:13:20: note: expanded from macro 'ULONG_MAX'
>       13 | #define ULONG_MAX       (~0UL)
>          |                          ^~~~
>    5 warnings generated.

Thank you for this report!  Just pushed a fix:
https://git.kernel.org/sj/c/74b866938a402fc479938747f93b9ced3c9a1282


Thanks,
SJ

[...]
