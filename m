Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446D392C4A
	for <damon@lists.linux.dev>; Fri, 13 Mar 2026 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413574; cv=none; b=WvEdGnmO6prngBHoFIprmeIw+KqalZHTcZur4EqUdQ84ruR+4iPb3GbqtrJA5Pp8WB9RAXgPbRdcl9WuByeyMVESvLVIZkESEdCQt7QzdilxbDALQRq3pTKARdEVyvN9Iv9sBi8JWPSsB83I/ReeBeQpurFwcJk9qZzScOX9Dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413574; c=relaxed/simple;
	bh=9+tBGf+6qW8cNORLO7JXvI2gClOkixsr6NngHAxnwk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ae0+bIC0DWEmR4uxw+WVGhQaDRezLviaMkNN4tWnE2fc0zCF/EXWL6Du2APjUDUJtrNxpt2CgHrt8K+GUR5rvjKLisStAkqS7Kqv/3mdw9nq4a66G2qjTt1bQEcRNjm7h8Jhj2OgefF0IyyLw428STBd8vtD1s0Csn7rYapfN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le0W763n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le0W763n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CD6C19421;
	Fri, 13 Mar 2026 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773413574;
	bh=9+tBGf+6qW8cNORLO7JXvI2gClOkixsr6NngHAxnwk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=le0W763nuZ3pgJhbKOvzX0P0kwTYcR2NhqSh6SPGWMp8Wl0f4PTOagjwDs+W3lUrq
	 qAe88u12T/megxzTjVQdzcF1kwg7fRZq/rVZdneVsmNKlRdIxLhAjlzMGDyBd646Cx
	 LHhEzfbANCIl3KXDttBDCDx508LcKSVJ7erwFQT9guUY/B0Kkto69BEmvBo3NB3FSH
	 TwMNH7l5bke7YUuYv5x7MC1NVyYXoYEngCv5DVTJVXUKZTtrvtsSGWtzvwzSNy2DIj
	 f+cFJh4GJ4LcRLK2kgSuidajFvPF1sf3Jb1501butKP6XDOWedVnv5J0GLiY1CY9l1
	 uLBHTpys4umNQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [Question] mm/damon: conflict between DAMON_STAT and DAMON_LRU_SORT?
Date: Fri, 13 Mar 2026 07:52:46 -0700
Message-ID: <20260313145247.46643-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313111702.38667-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 13 Mar 2026 19:17:02 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> TL;DR
> =====
> When CONFIG_DAMON_STAT_ENABLED_DEFAULT=y, enabling damon_lru_sort via sysfs
> "enabled" parameter returns -EBUSY. Is this expected behavior?

Yes, it is an expected behavior.  DAMON modules run in an exclusive manner like
this, to avoid interfering others' monitoring results.

I'm planning to make them be able to run together [1], but that's a future
work.  For now, this is the expected behavior.

> If yes, should
> this limitation be documented?

Good point!  Yes, it would be better to be documented.
 
> 
> Reproduction
> ============
> Environment:
> - Kernel: 7.0.0-rc3+ (x86_64)
> - VM: Virtme-ng (4G RAM, 2 CPUs)
> - Config: CONFIG_DAMON_STAT_ENABLED_DEFAULT=y, CONFIG_DAMON_LRU_SORT=y
> 
> Steps:
> 1. cd /sys/module/damon_lru_sort/parameters
> 2. (optional) tune parameters: hot_thres_access_freq, cold_min_age, etc.
> 3. echo Y > enabled
> 
> Result:
>   bash: echo: write error: Device or resource busy

Thank you for sharing this detailed steps.

> 
> Workaround:
>   Disable CONFIG_DAMON_STAT_ENABLED_DEFAULT, or disable damon_stat at runtime
>   before enabling damon_lru_sort.

Makes sense.  Indeed, DAMON tests use [2] this kind of workaround.
> 
> Questions
> =========
> 1. Is this resource conflict between damon_stat and damon_lru_sort expected?

Yes, as I mentioned above.

> 2. If yes, should this limitation be documented in:
>    - Documentation/admin-guide/mm/damon/lru_sort.rst
>    - Documentation/admin-guide/mm/damon/stat.rst

Yes.  But, I think 'Special-Purpose Access-aware Kernel Modules' section of
Documentation/mm/damon/design.rst is a better place to document it.

Would you mind sending a patch for that?

> 
> Additional Context
> ==================
> - On major distros (Arch/Fedora), CONFIG_DAMON_STAT_ENABLED_DEFAULT is typically
>   unset (disabled), so this issue may not affect most users.
> - However, for kernel developers or custom builds enabling both modules, clearer
>   documentation or error handling would improve debuggability.

I agree.

[1] DAMON-X in https://lore.kernel.org/20260307210250.204245-1-sj@kernel.org
[2] https://github.com/damonitor/damon-tests/blob/master/corr/run.sh#L62


Thanks,
SJ

[...]
