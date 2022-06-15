Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC487A
	for <damon@lists.linux.dev>; Wed, 15 Jun 2022 16:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8624C34115;
	Wed, 15 Jun 2022 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655311868;
	bh=QSUQpxMWYqwjwFSP5EHevOKbX0nSuG083wVcl5zipaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHHRrV8VO8fX/WgO6vXnkqiDz19kdMPYhCSHj9JlCiYdJLGw+rDyjM4D3ldv6u+Wj
	 MVwup72iqkFMPQtqf5LURzCWQGDotibMAlGOa62Xukur2TWiyoqH6GvEevyfvA62CV
	 voNSZmhR0qTD2GxMDG0d0RQyfDkeDxDYveorKDlNGmAPHNUMCaIKvoWfONVBpgj9Aj
	 gx/cM1l3MU3YJQbng+aCKDY4yD9NrrToUTfRx/Ew3TAfQJAcrDR1F4rG8zQ1Y0x5I5
	 F4m3HN3rwY1AkU4CklB2Fj83Wk1/bRixGwMo5Iiy2IqI1kMjwpiSXTIsMeKFmwFg6b
	 jj9BvQemcIWJw==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: about DAMON lru_sort
Date: Wed, 15 Jun 2022 16:51:05 +0000
Message-Id: <20220615165105.12361-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <fe3e0a37-130d-0cda-2104-90a476193262@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xin,

On Wed, 15 Jun 2022 17:50:16 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Hi sj,
> 
>      I have seen the DAMON + LRU codes detailedly， i really think it is 
> a good idea, but i have a few question,  why we can not to monitor whole 
> per node zone automatically,  i think it is hard to pass a physical 
> address when you do not  sure which physical address range to choose.
> 
>      for example,  i do not care which physical address range need to be 
> minitored, i just want know the whole memory which includes how much 
> inactive pages and
> 
> to better reclaim them.

Thank you for this question, Xin!  For the use case, I think you can get the
physical address range for the whole memory using '/proc/iomem' or similar
things[1].  If you could use DAMON_LRU_SORT module instead of manually using
DAMOS with DAMOS_LRU_(DE)PRIO action, you can further reduce such efforts,
because it tries to cover almost whole memory by default[2].  If I'm missing
something, please let me know.

[1] https://github.com/awslabs/damo/blob/next/_damo_paddr_layout.py#L135
[2] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/tree/mm/damon/lru_sort.c?h=damon/next-2022-06-09-19-55-on-v5.19-rc1-mm-unstable#n277


Thanks,
SJ

> 
>      I just put forward my idea in a superficial way and look forward to 
> your reply，thanks.
> 
> -- 
> Best Regards!
> Xin Hao
