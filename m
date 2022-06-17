Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C63201
	for <damon@lists.linux.dev>; Fri, 17 Jun 2022 16:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEB4C3411B;
	Fri, 17 Jun 2022 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655484055;
	bh=TNeA4V2xFwaUu2mpVFD4qUYUWxlFfV0BWWmbBfs0hFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCK99QNRU4wVC4A0Wd6PehZv0SyeZcAASU4YXlCZalLVI/ZJjXIJUuTY9exzpUwxu
	 CRxFYKFC9g+yCMiMgar/HI5ysqjTkv6nwmsUIoFmQ004aHtqlx+I8CRjtq52/j+3Hl
	 fEM7WtXvVWtx+WA/5lQk/Qj3prmue0cBtAjrm/CREiebeuKo5oZF0MSKWrGVjZMeaQ
	 hFLxa29kMwwUsw+6OA+wpWrlKqCNxGIfT24t9nWcYgQFEo7yiETpdp06e78MbJ1Xr5
	 cf2SIMu5GiLWNmba+U5r+InhNKgj+ZtebGzOWD77jLJZkjATXOgAWEwgNqGfgw7YG7
	 Ikkq2LwiCejJA==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: about DAMON lru_sort
Date: Fri, 17 Jun 2022 16:40:52 +0000
Message-Id: <20220617164052.106011-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3cbc9e83-566b-ca6d-bc1b-0f9ede3e8872@linux.alibaba.com>
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

On Fri, 17 Jun 2022 10:47:22 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Hi sj,
> 
> On 6/16/22 12:51 AM, SeongJae Park wrote:
> > Hi Xin,
> >
> > On Wed, 15 Jun 2022 17:50:16 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> Hi sj,
> >>
> >>       I have seen the DAMON + LRU codes detailedly， i really think it is
> >> a good idea, but i have a few question,  why we can not to monitor whole
> >> per node zone automatically,  i think it is hard to pass a physical
> >> address when you do not  sure which physical address range to choose.
> >>
> >>       for example,  i do not care which physical address range need to be
> >> minitored, i just want know the whole memory which includes how much
> >> inactive pages and
> >>
> >> to better reclaim them.
> > Thank you for this question, Xin!  For the use case, I think you can get the
> > physical address range for the whole memory using '/proc/iomem' or similar
> > things[1].  If you could use DAMON_LRU_SORT module instead of manually using
> > DAMOS with DAMOS_LRU_(DE)PRIO action, you can further reduce such efforts,
> > because it tries to cover almost whole memory by default[2].  If I'm missing
> > something, please let me know.
> 
> Yes, you are right,  I know what your mean,  The only difference is that 
> you manually find the physical address
> 
> to monitor, and another is damon automatically helps me get the physical 
> address of all the zone to check. I prefer the latter
> 
> ，why not support them both ?

So you're suggesting adding a change for DAMON sysfs interface that can help
users set the whole physical address space as the target area in more
convenient way, e.g., setting the whole physical address space as the default
for the 'paddr' monitoring ops, right?  Good point.  I think there's no reason
to not do so in general.  I'm wondering if the default values approach could be
shown as an unexpected behavior change to some users, though.


Thanks,
SJ

[...]
