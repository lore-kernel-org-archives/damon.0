Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5A7B
	for <damon@lists.linux.dev>; Sat, 18 Jun 2022 22:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1643C3411A;
	Sat, 18 Jun 2022 22:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655590473;
	bh=ymVsLH0KE4VrF43Ag/7+Yxg82jmAKVxvgbxpdN+xyh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mEyDnY8iq1jQ+7lT2UR5le8W87Db4jHpoAMfcZJ5b37qZW2NY4OP329Tp8D3vMPmq
	 PSb/JwVDUZH03drvpFxhkNoGAX62la0+pD0w61UZRxxc2Hc6R2mnViUfJ+t3dhT0UD
	 DJyoG3AjvNbg7eRYQPDQFnj7rHWBhRIbLNoIwucnHUKLyszuHWCsDUcQ9fFUN3P2ta
	 f+El9FZUtG+S48xlHW4okYZZ3iK9LjVZKv3N4G1+cBUdkSBK7UhU4YPN7PZYreTZ2W
	 F1p/WHx029uHJpHRdTuINO0grOqwtdUXD7B/sErBH+CWT0im2QbkmXJKBE+9qUmd7I
	 R2XsXxfndTTrQ==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: about DAMON lru_sort
Date: Sat, 18 Jun 2022 22:14:30 +0000
Message-Id: <20220618221430.110362-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <888e1dfc-6ccc-6a06-bef0-e2c8aedfb667@linux.alibaba.com>
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

On Sat, 18 Jun 2022 23:17:02 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Hi sj,
> 
> On 6/18/22 1:04 AM, SeongJae Park wrote:
> > Hi Xin,
> >
> > On Fri, 17 Jun 2022 18:00:30 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> Hi sj,
> >>
> >> I have another question,  if the mglru patch merge into upstream, which
> >> is more accurate, whether it can be proved with test data, or
> >> combination them to use ?
> > I think a fair comparison should be made with fair amount of combinations, of
> > course.
> >
> > I'm unsure if I'm fully understanding your question.  Could you please clarify
> > your points?
> 
> I spent some time comparing damon and mglru, I was curious to see how 
> each of them would play out in the memory reclamation scenario, or if 
> each had its own appropriate scenario，so If I want to reclaim memory in 
> my service, which one do I choose between damon and mglru?, i think 
> others people know about them also have the same confusion.
> 
>  From my humble point of view, I think damon is suitable for long cycle, 
> targeted active reclaim or others, and mglru  is suitable for the whole 
> system.

Please note that I haven't read MGLRU patches in detail, and therefore some of
my answers might wrong.  To my humble understanding, MGLRU is an approach for
making the page granularity access scanning more lightweight and the LRU lists
finer grained.  DAMON_LRU_SORT is a similar approach.  I think the differences
are the method of access scanning and proactiveness.

MGLRU uses an optimized form of page granularity access scanning, so it would
provide quite accurate results but the overhead could increase as the size of
the memory to scan increase.  Meanwhile, DAMON provides upperbound limited
overhead but its accuracy could relatively lower than page granularity
approaches.  Also, DAMON is designed for finding not only cold pages but also
hot pages (by default, DAMON conceptually scans all memory every 5ms).

MGLRU works in the reactive manner as similar to current reclaim logic, though
it provides a way to proactively incur the LRU-lists sorting (or, aging).  That
is, LRU lists would not be well prepared when the first aging of MGLRU is
incurred.  DAMON_LRU_SORT is for making LRU lists proactively prepared for
later uses including reclaim.

Therefore, I think using DAMON_LRU_SORT together with MGLRU would make sense.
In the case, DAMON_LRU_SORT makes LRU-lists more prepared for later reclamation
before the first aging, and MGLRU will make the later reclaim more efficient.


Thanks,
SJ

[...]
