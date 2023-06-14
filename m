Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC617F
	for <damon@lists.linux.dev>; Wed, 14 Jun 2023 17:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85914C433C9;
	Wed, 14 Jun 2023 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686763622;
	bh=nOmqxI9b0TrFL/JHYbhyIO1ZCsdC/twp0abB7a7rTBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMAWwNPV4mXfAWAAqgNMb0OaqOwo+bWwwWfB0RpASEJtKRSGel2zdH3s7H78hUst8
	 lhvrDXq2i1WA4R8Dc5QfB1a6hCjaMeX6yvcMalSH3ldE9P0r0tau68O2Q8uCZFSzeU
	 3y2PkRPIJPvDWMKvzGVUZ3ip8nAL0c9dglYrnZkYHy3zr41AzzF4JCPMnSAWEHGlH0
	 WsW3F2cvdMwuBV0XSvjEPhzK7f1dRStpopCRUoCqs/iGGzxF4r6Lvm/y/bUC7CFiz6
	 6u6B/7GKBkkqz3y9P+7qBDmLCXz76IjlzDKpyZHaNU9gbu/le20ekLl0jMvHvw2TQx
	 ZUONulM1fhk8Q==
From: SeongJae Park <sj@kernel.org>
To: Piyush Sachdeva <piyushs@linux.ibm.com>
Cc: sjpark@amazon.de,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	aneesh.kumar@linux.ibm.com
Subject: Re: DAMON testing and benchmarking
Date: Wed, 14 Jun 2023 17:27:00 +0000
Message-Id: <20230614172700.82480-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e6e8c252-f7b4-e71f-0315-f6cc774354d2@linux.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Piyush,

On Tue, 13 Jun 2023 12:18:48 +0530 Piyush Sachdeva <piyushs@linux.ibm.com> wrote:

> Dear Mr. SeongJae Park,
> I hope this email finds you well.

It did, thank you for this email :)

> 
> For the last few months, I have been looking at DAMON from an end-users
> perspective and a developer's PoV. Most recently, I was focusing on
> `lru_sort.c` module that uses the `lru_prio` and `lru_deprio` operations
> which result in a more precise reclaim. In my understanding, enabling
> the "lru_sort.c" module would make intelligent decisions based on the
> access frequency of the pages and end up preventing hot page
> swaps. Hence, when integrated with an LRU algorithm, it should improve
> it.
> 
> If you could share any test/benchmark that you might have run to verify
> the above assumption?

Yes, of course.  I will share those soon.

> I did find the result numbers you posted (link below), but that doesn't
> mention the "plrus-*" scheme numbers. It also doesn't have numbers for
> running the `pageout` operation on the entire physical address space (paddr)
> i.e. the `pprcl` scheme. So, if you can link those too, it would be amazing.

We run an automated test[1] every day, against the latest damon/next tree.  And
the page you linked is the output of the test.  The latet version contains the
results from `pprcl`[2] and `plrus`[3], but I was too lazy at updating the
document, sorry.  I will try to clean up the mess as soon as possible.

> 
> Can you also share any real-world (memory-management specific) workload
> results that you would have used with DAMON in your experiments? Like
> either MongoDB or memcached over Parsec3.0 (including splash2x) - which,
> in my understanding, is less memory intensive and more architecture
> inclined.

On my personal testing setup, I'm using only parsec3 and splash2x at the
moment.  We heard some production DB system is using DAMON_RECLAIM and achieved
about 20% memory footprint reduction, though.

> 
> I also had a question regarding schemes - A scheme is highly tweakable,
> and it's what the efficiency of DAMON rests upon. The more precise the
> scheme, the more efficient DAMON will be. Hence, I'd be thankful if you
> can help me derive a config that would provide the best results.

Very good point.  Unfortunately, repeats of experience and adjustment is the
only way as of now, like other tuning practices.  Nevertheless, DAMOS supports
some safeguards such as quotas[4], watermarks[5], and filters[6].  Because
quotas feature provides prioritization, setting the access pattern a little
wide, and more focusing on tuning of the quotas might be a good practice.

I'm trying to add some more easy-to-use intuitive tuning knobs, including
feedback-based quota auto-tuning, which I shared the rough idea at LSFMM[7].

> Hope to hear from you soon.

Thank you again for this great questions.  Please feel free to ask any question
or helps :)

[1] https://github.com/awslabs/damon-tests/blob/next/perf/full_run.sh
[2] https://github.com/awslabs/damon-tests/blob/next/perf/schemes/pdarc_v4_2_2.json
[3] https://github.com/awslabs/damon-tests/blob/next/perf/schemes/plrus-2.json
[4] https://www.kernel.org/doc/html/next/mm/damon/design.html#quotas
[5] https://www.kernel.org/doc/html/next/mm/damon/design.html#watermarks
[6] https://www.kernel.org/doc/html/next/mm/damon/design.html#filters
[7] https://lwn.net/Articles/931769/


Thanks,
SJ

> 
> Test results: https://damonitor.github.io/test/result/perf/latest/html/
> 
> --
> Regards,
> Piyush Sachdeva
> 
