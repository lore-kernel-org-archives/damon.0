Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F1282F0C;
	Sat, 11 Jul 2026 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741490; cv=none; b=C0jtiOtJdncwmk0Y6NXGZbHSPOueBZx/tnAv8kl0CJ+rLuFNZH4zXzu5ItLm2LAXemdr5j1QdakfirxgAf5VIOYm5T0InEvsLbJVXeX52tT9Xjj3RoZaCNoKbuQaQ1GwySrLBP9N5ON0OQefr+08+2k0Jx4wB/DU4EBhHC21bVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741490; c=relaxed/simple;
	bh=lowi9IqD1dJQZbR21/xALdGC3zgG8No6AfNlnW8BU8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhmvU1ClCBoG4uXrjKIjIjwcSwrNY2aLezqJ2YB5oLuXMEfugIr3qLaPHXTrc3sn0KZZBHBFQG47WFZ7PPMFuAeG0hAsqeAbvk6zNKrCENsCeqBSLQwOR0vWGHMe/fZtoE7rZUGO11nubkMy267sVGnKLfQl27WJqhsj0VVZsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2i9TPF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2i9TPF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9981F00A3A;
	Sat, 11 Jul 2026 03:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741489;
	bh=BTaZPCJkshbVC0cjDuIaqPS/hoZ0+n2t+cgmTXTNVGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N2i9TPF94kk+zeAntmEO9cTW7EMqqfAQNGx/e+WlWkZTiNISt/Dqcurhpc2DgUdCy
	 6IoSMXrv5ZMjIhUtsVT07M0c4VtflQdKoeopWzXxO+XG0ntjaXaC4Az65v+ol4vYsJ
	 t3woP6eh7XnUkJ495yD+ic4JAN5CWyyXsf+HZvwp03Nqo9/Y6mkwm9lZGSpB/iqdfi
	 un6hQwGPn5b1S+VnZm5DQsPRiRATUVkRmWYm/eGHQ1XQLFhensKGdgVrgQSI6g6lCi
	 eA/C2HW6tnXoDyIszoAuhLMhXR9aP8UUzTAxjKVGZIH1Ll+6f8Rqqt3WOa77/bQ6QA
	 3rnofq7sxLs4Q==
From: SJ Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SJ Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 151/151] mm/damon/vaddr.c:196:13: warning: variable 'tidx' set but not used
Date: Fri, 10 Jul 2026 20:43:37 -0700
Message-ID: <20260711034339.63677-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202607111055.NqcvApT6-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 Jul 2026 10:36:45 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   b617f1f8428697a2583fb6882864224d59a91bf2
> commit: b617f1f8428697a2583fb6882864224d59a91bf2 [151/151] mm/damon/vaddr: remove debug message
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260711/202607111055.NqcvApT6-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 16.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607111055.NqcvApT6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202607111055.NqcvApT6-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    mm/damon/vaddr.c: In function '__damon_va_init_regions':
> >> mm/damon/vaddr.c:196:13: warning: variable 'tidx' set but not used [-Wunused-but-set-variable=]
>      196 |         int tidx = 0;
>          |             ^~~~

Thank you for this report.  I just pushed a fix to damon/next.


Thanks,
SJ

[...]
