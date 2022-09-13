Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C83C10
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 15:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E53C433C1;
	Tue, 13 Sep 2022 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663081955;
	bh=4luCPVtQTAZm35zZrX2IGMQkLhYUQiShAN4g1WJcn8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ij4X0cM3XlwT37LgX3kv5/sJHbizPuQndngFDP4EWnIj8AVrjyh4b6G9rr27MVHl/
	 L9zwqqsdFItrXT/VRvx4kXzTOHe1gxIRCPfkEr3Y3+E1lJpJZOKHSYEpoDFRsX1fBm
	 /r05Dqt4Sl93xrzWV5J+iLKyySpzW9ouyBkoLD4nXCfxOkbDjc8zz3MpD1m5vivW/U
	 74G/ZkhqNkD4iuQ6a4eMjCFTw0Jyqv0p2dTzMwVec8oghCfQdpqnjvYwAsNa5vQffI
	 X0kQJWcLHfymzX2s66tgDXwPqC9nSdpgKUw5z6Lx04wsIRPrHwjJiBrGQL3X+Gp4OE
	 WIUOoz/X0WFyA==
From: SeongJae Park <sj@kernel.org>
To: xiakaixu1987@gmail.com
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH 0/4] mm/damon: code simplifications and cleanups
Date: Tue, 13 Sep 2022 15:12:33 +0000
Message-Id: <20220913151233.103245-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Sep 2022 17:11:23 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> This patchset contains some code simplifications and cleanups
> for DAMON.

For the first three patches,

Reviewed-by: SeongJae Park <sj@kernel.org>

But, I have a question for the last one.  Please answer it.

Thanks,
SJ

> 
> Kaixu Xia (4):
>   mm/damon: simplify the parameter passing for 'prepare_access_checks'
>   mm/damon/sysfs: simplify the variable 'pid' assignment operation
>   mm/damon/core: simplify the kdamond stop mechanism by removing 'done'
>   mm/damon/vaddr: indicate the target is invalid when 'nr_regions' is
>     zero
> 
>  mm/damon/core.c  | 24 +++++++++---------------
>  mm/damon/paddr.c |  5 ++---
>  mm/damon/sysfs.c | 11 ++++-------
>  mm/damon/vaddr.c |  9 ++++++---
>  4 files changed, 21 insertions(+), 28 deletions(-)
> 
> -- 
> 2.27.0
