Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0A1DE2BF;
	Thu, 29 May 2025 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536918; cv=none; b=Y7I7q2gIwTBK/vtkyEYd4251KOjNP4HJELEH/G3GR0EVOx47cQg9HJ/P3kfG9IDYAUemrQYfBlFWoQ4we43PRtXAuYnqqUuBaXFwmwWbXq9OhOoA5CQb3nWfu+b0wgUZagrAcsRLMSY4U9/+jYW1YM10uRu5Sietc0Qhg9iFW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536918; c=relaxed/simple;
	bh=plRZh5Wz52QXKDMH4plLqLqjXqeZOwZbuYE2vkjxQnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A54FXFEMbPUPegiUm/5LJhka2G2SyHi1cDL32oHOIkLJEPiv3c2+lRnCtQeksRpDvZ0Sar3e3kcSUxr4fes31LkXhLdnFzoQwD+AexpHlfnsK0rzms/ZNGfshUi0S0msNSTN2DvKtQ/SqR/QqnVcCo370akM7iSoE+CKxQ9D1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohiQ+cY7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohiQ+cY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2077CC4CEE7;
	Thu, 29 May 2025 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748536918;
	bh=plRZh5Wz52QXKDMH4plLqLqjXqeZOwZbuYE2vkjxQnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohiQ+cY7wYgr7RmLnnI1ubqu7xLQTHtAsX3bo8O5+B6tsjURDfk7xA5Zx28vONzJZ
	 BgahS8HqB4FbF8GnelX6YnMCgUnrU0qjff70HLkzHGXtUOZNcPrSIZgTvCANfzPfeV
	 Eiv0WXpLX5UY+HIW0RM6wBqzahkuoe4GUPph1PISpyEvxn41XtFIFhAD38ClIpziXG
	 lnpF9L6KZEDBeJq6iRPV0PPfgpM1zX6VfV9HyX3c1df7/tAKukIf9ovmwICOPImgMU
	 KtHG1ENUSOcnZBzPThUkow4I+A96rFexf7h5BCPZ+kETHn9G0Ui/tbgiT2hncRGUQx
	 x0EFy2m0U0a+w==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	Enze Li <lienze@kylinos.cn>,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: make region calculations more precise
Date: Thu, 29 May 2025 09:41:55 -0700
Message-Id: <20250529164155.37485-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202505291314.d61b1bcb-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 May 2025 13:53:12 +0800 kernel test robot <oliver.sang@intel.com> wrote:

> 
> Hello,
> 
> kernel test robot noticed "kunit.damon-operations.damon_test_split_evenly.fail" on:
> 
> commit: fe301d6b4b4aec003ff84aa4d2860e772b147225 ("[PATCH] mm/damon: make region calculations more precise")
> url: https://github.com/intel-lab-lkp/linux/commits/Enze-Li/mm-damon-make-region-calculations-more-precise/20250521-151059
> patch link: https://lore.kernel.org/all/20250521070747.1458270-1-lienze@kylinos.cn/
> patch subject: [PATCH] mm/damon: make region calculations more precise

Thank you for this nice report!

[...]
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202505291314.d61b1bcb-lkp@intel.com

Just for a clarification.  We decided to not pick this patch as is, so no fix
for this report will be made.


Thanks,
SJ

[...]
