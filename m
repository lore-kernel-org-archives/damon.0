Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F743153;
	Tue, 21 Nov 2023 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QACmDvwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24474C433C7;
	Tue, 21 Nov 2023 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700588164;
	bh=aXXUsAbBtqc2m+2Cgi/uIS1tHSwLTPzPAbJEVpba3cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QACmDvwDrSw9cGTMZwyyWquW+zerMzqCFdyc7ofmlMX/k7dJnPrDOh5InvxMg/8MP
	 6K1gbNiVrSRyhlKoa3voQJm9eoTvRdpeP70lJFaJeKIT8WAiw6x9FdpbWN4JtsVXeu
	 46JFs0r9H670wxLUoveti7z5zdt3MDmT0W3HCg/9Li2j/HurLz3CVpydZCKpU6corQ
	 FzSYrJEM8sjQtlQB2MqK2hCwzemn8ecFxe+PIBICrhWu85z3FC4WZM8OsknAuDAmOh
	 tKVwG+s2fm8urKY5n4RH5k56wyIK6+O6ulWDPkEXwQZVZg1PlLfiZIXuFGfMRSI7HB
	 rMPuzTMDrK2Hw==
From: SeongJae Park <sj@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 32/42] mm/damon/core.c:1150 damos_set_effective_quota() error: uninitialized symbol 'esz'.
Date: Tue, 21 Nov 2023 17:36:02 +0000
Message-Id: <20231121173602.62313-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <473b4c2e-863d-42ec-860a-bf8ec4385240@suswa.mountain>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dan,

On Tue, 21 Nov 2023 02:37:12 -0500 Dan Carpenter <dan.carpenter@linaro.org> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   54ffd8ae08121d8cbce1874fe46970cce643a2c7
> commit: 28cef0e565adbb4175f12ffffce9d0680979de60 [32/42] mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning
> config: x86_64-randconfig-161-20231121 (https://download.01.org/0day-ci/archive/20231121/202311210420.URG3QSAS-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20231121/202311210420.URG3QSAS-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202311210420.URG3QSAS-lkp@intel.com/
> 
> smatch warnings:
> mm/damon/core.c:1150 damos_set_effective_quota() error: uninitialized symbol 'esz'.

Thank you for this nice report!

However, damos_set_effective_quota() is called from damos_adjust_quota(), which
ensures at least one among quota->{ms,sz,get_score} is nonzero.  And
damos_set_effective_quota() ensures quota->{ms,get_score} is non-zero at the
beginning of the function.  Then the function sets esz anyway, for non-zero
quota->ms and quota->get_score.  Hence the uninitialized variable usage cannot
happen, if I understand correctly.  Please let me know if I'm missing
something.


Thanks,
SJ
