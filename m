Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28B746D
	for <damon@lists.linux.dev>; Mon, 19 Sep 2022 22:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0558C433C1;
	Mon, 19 Sep 2022 22:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663625696;
	bh=F4147V3uPwnsZw+gV5yfaQbfM/BWcDDhcyj477pupYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dl1EUziTTWn1bPh2JkFoMg49Q75ZdIZsKio5/svKQ9FFZLUfqTiKDQibMShN5Ll9m
	 6r4rawUgYHvChR70WYpb5h3n4WqgMvFJS2sMgH1PSdGZy2Gm02XDxSeoNQXt6lkRcJ
	 kOx2pzmDmPzP4OfJTlJDrmDccQMw+lv1mfI22Rdu3hqCYbTJSQ3UTCyTDHnrIozfI+
	 El7eFIkVbA0d1jhvA7kVXOcVAVeeK8vhbIGDz0Gezc8oupuTsMNFYpkpBzJAmrNqoM
	 4uMXRUWKaNZcLiSJ//k+JsdZC0H5PdIYVj8gYrO/KH3XrT8/NB3rskrKoREFkjhbGc
	 hcgr9yvcjHrgg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Alexander Zhu <alexlzhu@fb.com>,
	damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Mon, 19 Sep 2022 22:14:54 +0000
Message-Id: <20220919221454.94746-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909173856.55818-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


On Fri, 9 Sep 2022 17:38:56 +0000 SeongJae Park <sj@kernel.org> wrote:

[...]
> So, our next DAMON Beer/Coffee/Tea Chat series will be held in LPC2022, in
> person.

We had the in-person DAMON community meetup in last Wednesday, as announced.
In the meeting, I met Alex, who recently posted the THP shrinker patch[1], and
had a very interesting discussion about use of DAMON for his work.  Leaving a
summary of the discussion here.

TL;DR: DAMON cannot be used for Alex' work as is.  But, the goal of the work
can be achieved using DAMON, though the internal mechanism would be slightly
different.  Also, with some works, DAMON can be directly used for Alex' work.

The idea of Alex' work is to measure how many sub-pages in THPs are actually
accessed, to know how much memory we are wasting due to THP-internal
fragmentation, and split THPs having low utilization into regular pages.

So imaginable DAMON ussage here would be using DAMON for the THP utilization
measurement.  Unfortunately, DAMON couldn't be used for the purpose for now,
because current implementation of DAMON uses PTE Accessed bits.  When a THP is
collapsed, hence, DAMON will check the access to the THP in THP granularity,
not in the page granularity.

That said, we have an experimental implementation of DAMON-based THP
improvement[2] which is integrated in DAMON performance tests suite[3].  It
aims to achieve THP improvement that similar to Alex' one, though the detailed
mechanism is slightly different from Alex' one.  The idea of DAMON-based
approach is to find >=2MB virtual memory regions showing high access frequency
and do 'madvise(MADV_HUGEPAGE)' while finding memory regions showing no access
for a time and do 'madvise(MADV_NOHUGEPAGE)', to reduce the memory footprint
increase due to the THP internal fragmentation while keeping the performance
improvement.

So the main difference between Alex' work and the experimental DAMON-based
approach is that Alex' work enables THP always first, then finds under-utilized
THP and split those, while DAMON-based approach finds memory regions that could
get benefit from THP and collapses those, while splitting THPs showing no
performance benefit opportunity.

According to the test results[4], DAMON-based THP improvement removes 80.3% of
THP memory waste while preserving 30.79% of THP speedup.  I'm planning to make
a kernel module doing this work with a conservatively decided parameter values,
and then automate the parameter tuning based on some system metrics.  Time line
is not clear at the moment, though.

We can make the DAMON-based approach more similar to Alex' one by enabling THP
always and using DAMON for splitting cold pages only.  THPs being cold doesn't
mean under-utilized, so still not strictly same to Alex' idea, but given the
fact that one important goal of THP is the TLB miss reduction, splitting cold
THPs would make some sense.

There is still a way to use DAMON for Alex' approach in his idea, though some
work is needed.  DAMON cannot directly be used for Alex' work as is because it
is using PTE Accessed bits based access check mechanism.  But, DAMON allows
multiple access check mechanism to be implemented and configured to be used by
DAMON.  Therefore, we can extend DAMON to use some access check mechanism that
THP-independent and use that for Alex' work.  For example, AMD's
Instruction-Based Sampling[5] can be imagined.  Because it check accesses in
byte-granularity, should be THP independent and therefore able to be used for
checking access to THP-internal sub-pages.  Maybe Alex' THP sub-pages access
check mechanism could also be used.

If I'm missing something or saying wrong, please let me know.

[1] https://lwn.net/Articles/906511/
[2] https://github.com/awslabs/damon-tests/tree/13d1850b79a2/perf/schemes/ethp.damos
[3] https://github.com/awslabs/damon-tests/tree/13d1850b79a2/perf
[4] https://damonitor.github.io/doc/html/v34-damos/vm/damon/eval.html#efficient-thp
[5] https://developer.amd.com/wordpress/media/2012/10/AMD_IBS_paper_EN.pdf

[...]

> For people who cannot join in person there, I will schedule next virtual
> instance of the chat series in the Monday of the LPC's next week.  That is, the
> next virtual instance of this chat series will be in
> 
> 	2022-09-19 18:00 PDT (https://meet.google.com/ndx-evoc-gbu)

And, maybe too late but reminding you that next virtual instance of the chat
series is today, 6PM in PDT as above.


Thanks,
SJ

[..]
