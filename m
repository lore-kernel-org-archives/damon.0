Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413A20487E;
	Sat,  5 Jul 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751736235; cv=none; b=JRlbz3yTP1x/weBxgeCUjmkm+a5vv+DdQkdnBYtRiy2cyg6bRJiHPrbDXMRDQfMTufKZJHikYqtvaOJG/fa5t2rgs3QBRBC5GXmEQL9TBbGeriE3j1ITroRDPkk5MSvBRrs3WSRN7h3oh5JyZvsGlHmomvUCV0xC83Jpnzg11AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751736235; c=relaxed/simple;
	bh=dA3Qy562uDZFWCLZYoVKhI467BK76NTdqMB+a5tD+lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKTqMtg37wkV6ixTUymfDxoY63XIYMfzJhkdLk80cwPRq6yQFoWhtvkD0TaPk8pADFHttoADRphCzRm1z6MdZL3KkHG9RQWEGSbMIuOjjm6x+CF8k3sfy9709n8sj786l8Gsrc44PTSQcfxCQDsjW5DQ7wCur3w3u6RjJF7bpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaDNgIoi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaDNgIoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBA8C4CEE7;
	Sat,  5 Jul 2025 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751736234;
	bh=dA3Qy562uDZFWCLZYoVKhI467BK76NTdqMB+a5tD+lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CaDNgIoi9/mq4wZNwC2/SDV1+OhQfDCIOJ0Nbj/3TfOeh8AFd+UHaauSxi86Rfx01
	 EHNpzKeu3RMQ7EVEYCyTiwUIOHuR/s0XByestUG+rsvWgYq3Mq0GHJcLV9b6/tq1MQ
	 RtYsZyPhcicivlHnFDvjcvFWT/vHI+9ssKiXpNxWS8asgqnq7uklMWyp5wR0DfF5EB
	 K/OGgVs+2QjG6y9UPDmnvxicF8yjkXW1kRf+RpxAGgIHV9A0WY20hAzvOz2v/+yCKf
	 hfHJ83qv9rARvT1Glwp0LRbPkL3JuqQdik046WpBvWplD35mBWYmEWR4pyIdaGDP7E
	 k1/PeeRThLEsA==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 10/106] mm/damon/core.c:2023:3: warning: variable 'sidx' is uninitialized when used here
Date: Sat,  5 Jul 2025 10:23:52 -0700
Message-Id: <20250705172352.52471-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202507051740.hrB8EaUH-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 5 Jul 2025 17:17:03 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   9af2f87d23cb0b15f32e59e4e9da681454a46eab
> commit: 405b04c2042a3448c2986c909608037f05a3bf0c [10/106] mm/damon: add trace event for effective size quota
> config: x86_64-buildonly-randconfig-003-20250705 (https://download.01.org/0day-ci/archive/20250705/202507051740.hrB8EaUH-lkp@intel.com/config)
> compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250705/202507051740.hrB8EaUH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507051740.hrB8EaUH-lkp@intel.com/
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

Seems this is a duplicate of another one[1].  Please refer to my reply to that
one[1].

[1] https://lore.kernel.org/202507051517.bs3jd8RW-lkp@intel.com


Thanks,
SJ

[...]
