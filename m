Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA621B9C8;
	Tue,  9 Sep 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381012; cv=none; b=fjcZl2x+p2cgu4IJlhhp+T9QUs5jc5jh1zKkISKrMjFLFM/0gA1IN0zNKC2udaH9C4SI8nrxoZrrnmsTi9wV6THslpoWBTQSkoYoMdMCR5lJ4VeeEhbf6rjFsG6Dk4wfWdNmkixaJmfQJPy0Uyv0sJcT8FksJLAqSCRZ3ZAIOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381012; c=relaxed/simple;
	bh=RZi5ocmJPJF9G1DcWXVwXv/MggPhU7VqkehKrP9eEQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NXpy+E2aMCZewSPWUmgxcamFjbov4owhHykuawJG5iwpLA4OAcfCoJPD/1CZT72uA9VrCzpmGzmGATd4JsNAKhl3K5KYwu2IbtG5bTN0pC9Wx5ZZYuFu4uEZv3MD0gbZ9prAAe1H79LgY6UE5fKZti5R+3VYz5ae4DaLDFGJTqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWB+Zq9D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWB+Zq9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A3C4CEF1;
	Tue,  9 Sep 2025 01:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757381012;
	bh=RZi5ocmJPJF9G1DcWXVwXv/MggPhU7VqkehKrP9eEQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWB+Zq9D+EPxcmEuSUN/CZ/QMxQCsbx/pQTaA2ypiYosTDjzW9x99+wFGlGLc6phF
	 riySFglLMfZCk0vfKmop6U8SFUqAmEr2HVOVFkD8cCBgN8umZQjII7ncEI6s+Wmbaf
	 mYbmXUXaBbsz1BN6P8Xxgn8BAuvh8+RyJpZKNeYj30oK9jNKYUO8dpD2D1/cek7pcl
	 KXTDF4pfhv2Ggt5qEnU8ACLb+xpSWuEbQ6SIOV8BnklqZ950eEvFRKG/A3O4esXZbJ
	 Srd+Sxe683V5+dqlRj4tTad7F6gnpwtDhFUpymiS+HJlIow3iE3MUSGcOUDAsNpM3e
	 r67Y6iLAli75w==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 118/128] mm/damon/tests/core-kunit.h:453:2: warning: unannotated fall-through between switch labels
Date: Mon,  8 Sep 2025 18:23:29 -0700
Message-Id: <20250909012329.66924-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202509082042.24Nb5PCp-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 8 Sep 2025 20:35:07 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   387bf1dec467127e728b28dc7624723d7df2813c
> commit: d53726dd7bd14e94f2c46a842c8c45c2231090b7 [118/128] mm/damon/tests/core-kunit: split out damos_test_commit_quota_goal()
> config: i386-buildonly-randconfig-006-20250908 (https://download.01.org/0day-ci/archive/20250908/202509082042.24Nb5PCp-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250908/202509082042.24Nb5PCp-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509082042.24Nb5PCp-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from mm/damon/core.c:3156:
> >> mm/damon/tests/core-kunit.h:453:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>      453 |         default:
>          |         ^
>    mm/damon/tests/core-kunit.h:453:2: note: insert 'break;' to avoid fall-through
>      453 |         default:
>          |         ^
>          |         break; 
>    1 warning generated.

Thank you for reporting this!  I just pushed a fix to my tree:
http://git.kernel.org/sj/c/922891e5eea9872058e013249d9aeab0eb6471d5


Thanks,
SJ

[...]
