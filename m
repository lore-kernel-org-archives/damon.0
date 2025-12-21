Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD130F92D
	for <damon@lists.linux.dev>; Sun, 21 Dec 2025 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766345274; cv=none; b=laz9U3xzha3fA2ilTAyzgd6GzN2VdBYPrR4t/yrEK7BEEF8K9T/LFb85ptNeogkqR+fFRgMMmxoPXUHYqotAkjeSdb/asH45numsTceT9/w36zMY1QpVe5oW2cB6xwdWlyLRgzGqoqPIMu/7vaCa3WBWWBImXxZOhvlLjcj148M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766345274; c=relaxed/simple;
	bh=7F4TPMVb6bOzlf1ttXAT3unF5sWnabnhKyb4rPY4OUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggKmTWkIRpq8sYJlFA2wFazJHZjLQjch/m0ccnTxD382yn1Eq2xoFQpWLZwBdakmANMzv1rTOAo+c5MDXMjTNZs/tsCmUacCzcgLBt7PjgPMZn8iXq85IktxZfIyKIYG0SMTzqpkqYZAvJNqUeKLIgScpWLU2MLI5MF8EYVSn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOckPfkz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOckPfkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0983DC4CEFB;
	Sun, 21 Dec 2025 19:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766345273;
	bh=7F4TPMVb6bOzlf1ttXAT3unF5sWnabnhKyb4rPY4OUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOckPfkzVyDWVRPTUlGTXT2Y5N9C+tgKYm06vcUwNmzBNR8STdiHzelZhq4zyio7C
	 dB01Bh9JO5Z5/IHCtKN2My5ZEsIJB67JdsH5rhqQwlpBCejHkxeIioVOQamYxl5Pce
	 foeevengrQikpbKOOqbS6Xe9IJkxY7gTabg65Br1rHyrlMyT/XbtTsV/KnkDG6kaXY
	 /wrFYyzZzAwILKPHZTpIZ1P/GZJbvLQWDlTYGVRzY5owroIzhi2EVSydOqC0ZB/ltR
	 IBN1ZJM/OVayWl551QQINU9itAVnmCVUc3Z9sTvf0EhCiEJRLr6sdYbcrppgrt3RMF
	 zQ4l73tmWnypw==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Enze Li <lienze@kylinos.cn>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
Date: Sun, 21 Dec 2025 11:27:50 -0800
Message-ID: <20251221192751.42586-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC4opA5kdX0c3RrUL0g9e95JJb5hr=ZaGS7FGoQ-nxgF3Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Dec 2025 20:04:23 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Sun, 21 Dec 2025 at 17:12, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Sun, 21 Dec 2025 11:42:43 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Fri, 19 Dec 2025 at 21:52, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Thu, 18 Dec 2025 21:46:37 +0800 Enze Li <lienze@kylinos.cn> wrote:
> > > >
> > > > > On 2025/12/16 07:16, SeongJae Park wrote:
> > > > > > Hello Enze,
> > > > > >
> > > > > > On Mon, 15 Dec 2025 22:20:55 +0800 Enze Li <lienze@kylinos.cn> wrote:
> > [...]
> > > > If runtime controls are essential, I think using DAMON sysfs
> > > > interface or DAMON user-space tool is a better choice.
> > >
> > > I also think the current DAMON design structure is suitable for DAMON sysfs
> > > and user-space tools.  DAMON sysfs can run multiple nr_ctxs, so I think it
> > > would be a good idea to consolidate it into this.  As Enze mentioned, DAMON
> > > was originally designed as a kernel loadable module,
> >
> > I don't recall where Enze mentioned so.  Could you please give me a pointer?
> 
> Although Enze did not directly state this, His patch is a loadable module,
> which implies that it was "designed as a kernel loadable module."

Thanks for clarifying.  I understand you are saying Enze's prdm module is
designed as a loadable module, while you are not saying about other parts of
DAMON.

> 
> >
> > And I'm not sure based on what you are saying it was originally designed as a
> > loadable module.  Maybe you are saying something before DAMON's mainline
> > landing, but that's quite long ago and my memory management is not good.  Could
> > you please add more contexts?
> >
> > > but I was curious as to
> > > why it wasn't run that way.
> >
> > Maybe I could give you an answer if you could give me the context that I asked
> > above.
> >
> > > When executing the damon_start(**ctxs,
> > > nr_ctxs, exclusive)
> > > function, nr_ctxs=1, exclusive=true is passed so that modules are currently
> > > executed only one at a time.  Therefore, there is no point in running
> > > DAMON
> > > as a kernel module, since you are not running multiple modules simultaneously.
> >
> > I'm not following your point well.  Could you please elaborate your point?
> 
> So far in my view, I have analyzed DAMON as follows:
> 
> DAMON core  <---------> kernel module   <------> damo(user-space)
> mm/damon/core.c         mm/damon/lru_sort.c
> mm/damon/vaddr.c        mm/damon/reclaim.c
> mm/damon/paddr.c        samples/damon/*.c
> mm/damon/sysfs.c
> 
> Above, lru_sort and reclaim are DAMON core characteristics, but they have
> a kernel module structure because they are executed with module_init().
> I personally think this is inappropriate.

Could you please further clarify why you think it is inappropriate?

> Additionally, currently, DAMON is
> executed only once at a time according to the exclusive=true condition
> when damon_start() is called.  In this structure, I believe that the meaning
> of "kernel loadable module"  is non-existent.

I have to say I still don't get your points.  More elaboration would be nice.

> 
> >
> > > I'm doing some more research into why we run modules with exclusive=true.
> >
> > Hoplefully commit 8b9b0d335a34 ("mm/damon/core: allow non-exclusive DAMON
> > start/stop") will give you more contexts.
> >
> > To summarize again, the intention is to avoid kdamonds interrupting each
> > other's access checks.  For example, suppose the DAMON context for
> > DAMON_RECLAIM and another one (could be created by DAMON sysfs interface users
> > or other DAMON modules, say, DAMON_STAT) are running concurrently.  And if
> > those pick a same page as access check sampling target, their finding of the
> > access on the page depend on a race condition.  To avoid such a case, DAMON
> > modules call damon_start() with exclusive argument set.
> >
> > Maybe this is unclearly documented.  I will recheck the documentation and
> > improve it to make this more clear.  If you find the rooms to improve and have
> > ideas for the improvements, please feel free to send patches.
> >
> > > One more thing I would like to add is that I think it would be less
> > > confusing
> > > to move lru_sort and reclaim to the samples/damon/ path.
> >
> > No, I don't think so.  Those are for real world products, not for samples.
> >
> > > And it would
> > > be
> > > a good idea to organize the core sources toward
> > > mm/damon/modules-common.c source.
> >
> > I don't find exactly what kind of reorganization you mean.  But I agree there
> > could be rooms to improve in terms of the files and code organization.  Any
> > suggestion is welcome.
> >
> > [...]
> > > > > Finally, I would like to add that designing prdm with an extremely
> > > > > simple workflow -- load the module, set the target PIDs, and enable the
> > > > > switch -- will contribute to the promotion of DAMON, allowing a broader
> > > > > user base to benefit from the DAMON system.
> > > >
> > > > That workflow is definitely much easier than directly using DAMON sysfs
> > > > interface.  But, for the reason we have DAMON user-space tool.  Using it, the
> > > > workflow can also be as simple as prdm, like below.
> > > >
> > > >    # damo start $TARGET_PID --damos_action pageout --damos_access_rate 0% 0% --damos_age 2m max
> > >
> > > Where can I find the damo source or documentation?
> >
> > You could use https://github.com/damonitor/damo and its README.md file.
> 
> Thank you so much for sharing.  I am trying to analyze the related contents
> in more detail to improve your DAMON.  I'll try to organize it a bit better
> and send you a patch.

Looking forward.


Thanks,
SJ

[...]
