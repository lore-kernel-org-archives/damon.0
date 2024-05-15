Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AD43144;
	Wed, 15 May 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789919; cv=none; b=fFB2o5AOoqAKC9rUhTIxNd7D6xIIkYfb+ZG63XYdDmRL5q6ZqgcD2p04fBMmKVZ2h7/QgJgv3zGARENtTUfsf1V4xVq6d0MMeooQk49V7f/zbFrtG1alt3mYm4rs/DWYKFyubF3iqIUnEDEYLdTE8dQ4xMqGg++PvwyuWGE73yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789919; c=relaxed/simple;
	bh=UMfHPJyXzxgzFEud5yIQpsOUvadwlPqB7VqN5ZzAC3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=az/NTZI6cV7dwiNyKj6OcpzrSDDAyMr6n8ypiJevbBnR+kym0UO6BIqeCoqPP4ZCra9wKiiGoXbHy6jJFXsta6eJ5WupP1CFdGAMYPYCq0wkDo2yzEUQDPSA7TnQul4eIPoKDIt4YJSPwwxbIGd6/OwvnGb0By58CHozEu3FeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHXMfcKa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHXMfcKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B679C116B1;
	Wed, 15 May 2024 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715789919;
	bh=UMfHPJyXzxgzFEud5yIQpsOUvadwlPqB7VqN5ZzAC3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHXMfcKav5r0I7ORkDgFdS5FZtTc2v/NsQTQTv2TlwmceVoCi2/Dk2+3se4u+ukdD
	 yembcZx6USAJww2YGhH5koDlQ4w+eUTtADowT22gZ7Yitu7qBK98tsVJpWo7w24oOA
	 i0wfT3SrO0DGfRUxETRRf299eLdJ7Q7W8P47iP5dmqwyJw4GyxGm/xL9gWzB8oDiwD
	 LcHAqQA0dn+ZV+NMZhVOEqVfQrmDGNv66KxfKiW4V28l50BDoxo2ZocRy/1Hh8MDv0
	 gDKqjrNIryOlWaxpOA3wWrHFmA0vEhoHmFCiDpJu8LkeZJtGW4uWKNg4En7hqxKlHP
	 xfhuoPzGaq58Q==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH v4 0/5] DAMON based tiered memory management for CXL memory
Date: Wed, 15 May 2024 09:18:35 -0700
Message-Id: <20240515161835.69311-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240513115918.1479-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu,

On Mon, 13 May 2024 20:59:15 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> Thanks very much for your work!  It got delayed due to the priority
> changes in my workplace for building another heterogeneous memory
> allocator.
> https://github.com/skhynix/hmsdk/wiki/hmalloc

No problem at all.  We all work on our own schedule and nobody can chase/push
anybody :)

> 
> On Sun, 12 May 2024 10:54:42 -0700 SeongJae Park <sj@kernel.org> wrote:
> > There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> > posted at [1].
> > 
> > It says there is no implementation of the demote/promote DAMOS action
> > are made.  This RFC is about its implementation for physical address
> > space.
> > 
> > Changes from RFC v3
> > (https://lore.kernel.org/20240405060858.2818-1-honggyu.kim@sk.com):
> 
> This link cannot be opened.  I will share the link again here.
> https://lore.kernel.org/all/20240405060858.2818-1-honggyu.kim@sk.com

Thank you for checking the link!  It's weird though, since I can open the link
on my Chrome browser.

> 
> >   0. updated from v3 and posted by SJ on behalf of Hunggyu under his
> >      approval.
> >   1. Do not reuse damon_pa_pageout() and drop 'enum migration_mode'
> >   2. Drop vmstat change
> 
> I haven't checked whether I can collect useful information without
> vmstat, but the changes look good in general except for that.

I was thinking you could use DAMOS stat[1] for the schemes and assuming no
reply to it as an agreement, but maybe I should made it clear.  Do you think
DAMOS stat cannot be used instead?  If so, what would be the limitation of
DAMOS stat for your usage?

> 
> >   3. Drop unnecessary page reference check
> 
> I will compare this patch series with my previous v3 patchset and get
> back to you later maybe next week.

Thank you very much!  Unless I get a good enough test setup and results from it
on my own or from others' help, your test result would be the last requirement
for dropping RFC from this patchset.

> Sorry, I will have another break this week.

No problem, I hope you to have nice break.  Nobody can chase/push others.  We
all do this work voluntarily for our own fun and profit, right? ;)


[1] https://lore.kernel.org/damon/20240405060858.2818-1-honggyu.kim@sk.com


Thanks,
SJ

> 
> Thanks,
> Honggyu
