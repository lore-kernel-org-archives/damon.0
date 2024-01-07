Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94EB11706
	for <damon@lists.linux.dev>; Sun,  7 Jan 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Qzj4nR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6109C433C7;
	Sun,  7 Jan 2024 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704661575;
	bh=lubBGPn2aHJ7qWcEuEBfFDIovn3tJ2PWKQSOLB/edCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5Qzj4nRRS8ZI9NcOClpaQBrmNDgtbYmGEO59eab041TLButdDBObZtkfKpYY5ojY
	 ft4CWxaPhLG6f5NQi0R43hfzEgrLNIcDuCFwFpK5AoGEeJXT9tR6ZBHLir8nARIgg7
	 b8+2fOtM4ATiiebCL0Go7ODBivtsHZFqxRkrRoSm6Z6c0xV9ro0rH7PEcmbtbDh+Yk
	 0mV/3oDlVOdQ1dMcrQ34c6wP1sSAZZIXS3x58wIW9QmCyKOjrEMzYy9v+Nky91UYwE
	 ewIzHzs3kD+rS4oqssp25krb6ikiLnOQCaz7yT2dGAIx08e88HAl7KY/mn0lcirIxw
	 zxRUgWIp0qxLQ==
From: SeongJae Park <sj@kernel.org>
To: Piyush Sachdeva <piyushs@linux.vnet.ibm.com>
Cc: SeongJae Park <sj@kernel.org>,
	sjpark@amazon.de,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	aneesh.kumar@linux.ibm.com
Subject: Re: DAMON testing and benchmarking
Date: Sun,  7 Jan 2024 13:06:13 -0800
Message-Id: <20240107210613.65483-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <87352r6gql.fsf@li-7e025c4c-278d-11b2-a85c-da661cef46c1.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Piyush,


Sorry for late response.  Somehow I forgot replying.

On Fri, 16 Jun 2023 12:22:50 +0530 Piyush Sachdeva <piyushs@linux.vnet.ibm.com> wrote:

> Dear SeongJae Park,
> 
> SeongJae Park <sj@kernel.org> writes:
> 
> > Hi Piyush,
> >
> > On Tue, 13 Jun 2023 12:18:48 +0530 Piyush Sachdeva <piyushs@linux.ibm.com> wrote:
> >
[...]
> >> For the last few months, I have been looking at DAMON from an end-users
> >> perspective and a developer's PoV. Most recently, I was focusing on
> >> `lru_sort.c` module that uses the `lru_prio` and `lru_deprio` operations
> >> which result in a more precise reclaim. In my understanding, enabling
> >> the "lru_sort.c" module would make intelligent decisions based on the
> >> access frequency of the pages and end up preventing hot page
> >> swaps. Hence, when integrated with an LRU algorithm, it should improve
> >> it.
> >> 
> >> If you could share any test/benchmark that you might have run to verify
> >> the above assumption?
> >
> > Yes, of course.  I will share those soon.
> >
> >> I did find the result numbers you posted (link below), but that doesn't
> >> mention the "plrus-*" scheme numbers. It also doesn't have numbers for
> >> running the `pageout` operation on the entire physical address space (paddr)
> >> i.e. the `pprcl` scheme. So, if you can link those too, it would be amazing.
> >
> > We run an automated test[1] every day, against the latest damon/next tree.  And
> > the page you linked is the output of the test.  The latet version contains the
> > results from `pprcl`[2] and `plrus`[3], but I was too lazy at updating the
> > document, sorry.  I will try to clean up the mess as soon as possible.

I just uploaded my daily DAMON performance test results that I collected since
2022-06-10 on the DAMON project web site[0].  It may better to add some more
visualization such as weekly rolling average of the report in future.  I
actually wanted to do that, but I was too lazy.  So sharing the data first.  I
will try to further make it easier to read.

> >
> >> 
> >> Can you also share any real-world (memory-management specific) workload
> >> results that you would have used with DAMON in your experiments? Like
> >> either MongoDB or memcached over Parsec3.0 (including splash2x) - which,
> >> in my understanding, is less memory intensive and more architecture
> >> inclined.
> >
> > On my personal testing setup, I'm using only parsec3 and splash2x at the
> > moment.  We heard some production DB system is using DAMON_RECLAIM and achieved
> > about 20% memory footprint reduction, though.
> >
> 
> Are you aware of the specifications of the DB system that you are
> mentioning? 20% is an amazing number and if possible I would like to
> know more about the details of the workload.

It is a relational database system.  Unfortunately I also not having very
detailed information about the product.  ByteDance also recently shared[1]
their DAMON-based 30 % memory reduction for MySQL.

> 
> >> 
> >> I also had a question regarding schemes - A scheme is highly tweakable,
> >> and it's what the efficiency of DAMON rests upon. The more precise the
> >> scheme, the more efficient DAMON will be. Hence, I'd be thankful if you
> >> can help me derive a config that would provide the best results.
> >
> > Very good point.  Unfortunately, repeats of experience and adjustment is the
> > only way as of now, like other tuning practices.  Nevertheless, DAMOS supports
> > some safeguards such as quotas[4], watermarks[5], and filters[6].  Because
> > quotas feature provides prioritization, setting the access pattern a little
> > wide, and more focusing on tuning of the quotas might be a good practice.
> >
> > I'm trying to add some more easy-to-use intuitive tuning knobs, including
> > feedback-based quota auto-tuning, which I shared the rough idea at LSFMM[7].
> >
> 
> I did go through your presentation and the summary article on lwn.net .
> The feedback-mechanism based self-tuning does sound ingriguing and
> promising to me.

The patches for core part of the feature has recently posted, and currently
merged into the mm tree[2].  Hopefully it will be merged into the mainline in
the next merge window.  The patches require users' intervention though.  A
followup patches for making it almost self-tuned by DAMON will hopefully posted
soon.

Apology again for this too late response.  Please feel free to ask any question
or help.

[0] https://damonitor.github.io/test/result/perf/index.html
[1] https://lpc.events/event/17/contributions/1520/
[2] https://lore.kernel.org/damon/20231130023652.50284-1-sj@kernel.org/


Thanks,
SJ

[...]
