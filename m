Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DA183CCA;
	Mon, 20 Jan 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407019; cv=none; b=ZHkiIvUt7B97z8i89cSL5WW+O8Jjan6Kv5EZgZjoGRu2lv9fC7E0IjLlV5az/GuJ/iAFbOUcTNrVeEIPQ2jZyPIpujmuTG0swKh16dbex8Mggt+2+LnB2pIYnuzJnNxleG2CC9d/vq8TC3xjdHwym3H7pLLvxR2KT2iZ5bKDQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407019; c=relaxed/simple;
	bh=GxUo+aTtHc9v9BxtVUCDcktJj2mlsT6BDBbXVjkxp/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4imEK6edJ7Ns9dlkSD7bpVk+xhPknEotwRGpBA++pgVxRtZ9V85coL44BdqUAfroORTtIPq+98UU3NmTkbjMRsCQtF+mPg+S4lEp7U2ZsAo2QmLncae+jB6nioIkhnNUJldv55HBsxPHSWBfBScaHRpdPO2bcVtUi07kEClWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/XDhSmr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/XDhSmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313B9C4CEE3;
	Mon, 20 Jan 2025 21:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737407018;
	bh=GxUo+aTtHc9v9BxtVUCDcktJj2mlsT6BDBbXVjkxp/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/XDhSmrlX59PBLbiIBbkFhczQop711VWq13wQlsrcDYIC3Ih3ljPHFgbQFa4Keiz
	 2yb9Frk09FcgvCTVHSDH3ilnusG2F0lNC92eKJ73r6bW09fdAXMHrWTyyvuUlSQfYg
	 oO9JyR3W/6h/Zq8O+0znYimPDIIo7X+Os6FLrf8/F6SWKnqhCWCRaDLNMawUfpSqIV
	 eOIZgnDCuc7kq1f7Hg+IM4gT+2/ztkgYM4qsDvUrPtBf6uSw+5eifTRAOUOFqAu7IO
	 gAzxmpRBt5zanF5LzT10nBxKg9ptR4MlDf41SLalHJKIKgvkjVbwItAkreURmwhimD
	 8z5q0Vk2SlNhA==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 45/45] mm/damon/paddr.c:316:30: warning: variable 'last_addr' set but not used
Date: Mon, 20 Jan 2025 13:03:34 -0800
Message-Id: <20250120210334.44451-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202501191712.rj88Gj15-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 19 Jan 2025 17:35:50 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   38bf43ccce488ca872dbc52673c7a2223fb13598
> commit: 38bf43ccce488ca872dbc52673c7a2223fb13598 [45/45] mm/damon/paddr: implement a DAMON operations set for cache address space
> config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250119/202501191712.rj88Gj15-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250119/202501191712.rj88Gj15-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501191712.rj88Gj15-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    mm/damon/paddr.c: In function '__damon_ca_check_access':
> >> mm/damon/paddr.c:316:30: warning: variable 'last_addr' set but not used [-Wunused-but-set-variable]
>      316 |         static unsigned long last_addr;
>          |                              ^~~~~~~~~

Thank you always for nice reports!  Just pushed a fix:
https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?h=damon/next&id=2e43bb84cc76ee5e1bc1000d161609ee4c279771


Thanks,
SJ

[...]
