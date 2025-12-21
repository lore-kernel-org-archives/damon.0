Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF51B4257
	for <damon@lists.linux.dev>; Sun, 21 Dec 2025 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766304751; cv=none; b=uQNufFdI+KZxqdkRxgAGVwdphL2rxbQzzaqDhaHFR/jcrEZGqb0cLI1QhqcUQBd/7o9xgwlskH/WUq62eHvgTN3fdYwUDx8FJW1X1FBlJszzafWKvaPcG2btoIq/RfWSkBclfABxutJ1T8VIKHlYZAqaSR8nhWbh1YzUw/+0P54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766304751; c=relaxed/simple;
	bh=00D3OOgbeeTpnWzepbjIFgllWxUGULUtJy9deaX29vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IppcfgDXaRSp/Py8MQdKuJBcVsoHXN0OhzvS/asIMOOWRaBR/0YL1sOJ5qvMmluNlYzfWO0HgfTOeFNPhRzS1+rOFCtg4UkjqtbkkQ7s5YiMP0pdFbrCZXKYlT0b8ln5tE1DKgcQBZeBFlkCQ2u9G1iX8ZlUPy7mWPRbWaAJ2f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUYGvdCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUYGvdCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42F2C4CEFB;
	Sun, 21 Dec 2025 08:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766304751;
	bh=00D3OOgbeeTpnWzepbjIFgllWxUGULUtJy9deaX29vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUYGvdCzzogkQZVJP2qm2k7wNlNF213VR4ZFuthM+Z46+gHzu9lOmRqRyuVeCF2jB
	 VumAsYaRFhT6kcqf4uIMPbk5NVdXNN5jVYJyATfGp8bHkJahEqK/y+Rh/Z2nMECLy/
	 KUkuMVo7QFrVnbSCDcXCPz2v8DvSbNZz7ZVbnm29C/imP2ytipLKFFTBomzzL7StwI
	 loOba8T/HdqXQzuNBU3XkJm6kNwd9m/omBTyGTipogn3vHAU8km6QnrfGC/kvphEMX
	 mPAPru95fiDq7vQwQnbv7yMJQ2EZ0m3Vtf+IJLcEeOrBY4gs05eAiuNpUx5DmVSWBQ
	 LewBxkSMuZYFQ==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Enze Li <lienze@kylinos.cn>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
Date: Sun, 21 Dec 2025 00:12:26 -0800
Message-ID: <20251221081227.42071-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC7=t0iHEC-BQPZcF+KiKcc2tVyxNOLMifZQ=JwH2GwFpw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Dec 2025 11:42:43 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Fri, 19 Dec 2025 at 21:52, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Thu, 18 Dec 2025 21:46:37 +0800 Enze Li <lienze@kylinos.cn> wrote:
> >
> > > On 2025/12/16 07:16, SeongJae Park wrote:
> > > > Hello Enze,
> > > >
> > > > On Mon, 15 Dec 2025 22:20:55 +0800 Enze Li <lienze@kylinos.cn> wrote:
[...]
> > If runtime controls are essential, I think using DAMON sysfs
> > interface or DAMON user-space tool is a better choice.
> 
> I also think the current DAMON design structure is suitable for DAMON sysfs
> and user-space tools.  DAMON sysfs can run multiple nr_ctxs, so I think it
> would be a good idea to consolidate it into this.  As Enze mentioned, DAMON
> was originally designed as a kernel loadable module,

I don't recall where Enze mentioned so.  Could you please give me a pointer?

And I'm not sure based on what you are saying it was originally designed as a
loadable module.  Maybe you are saying something before DAMON's mainline
landing, but that's quite long ago and my memory management is not good.  Could
you please add more contexts?

> but I was curious as to
> why it wasn't run that way.

Maybe I could give you an answer if you could give me the context that I asked
above.

> When executing the damon_start(**ctxs,
> nr_ctxs, exclusive)
> function, nr_ctxs=1, exclusive=true is passed so that modules are currently
> executed only one at a time.  Therefore, there is no point in running
> DAMON
> as a kernel module, since you are not running multiple modules simultaneously.

I'm not following your point well.  Could you please elaborate your point?

> I'm doing some more research into why we run modules with exclusive=true.

Hoplefully commit 8b9b0d335a34 ("mm/damon/core: allow non-exclusive DAMON
start/stop") will give you more contexts.

To summarize again, the intention is to avoid kdamonds interrupting each
other's access checks.  For example, suppose the DAMON context for
DAMON_RECLAIM and another one (could be created by DAMON sysfs interface users
or other DAMON modules, say, DAMON_STAT) are running concurrently.  And if
those pick a same page as access check sampling target, their finding of the
access on the page depend on a race condition.  To avoid such a case, DAMON
modules call damon_start() with exclusive argument set.

Maybe this is unclearly documented.  I will recheck the documentation and
improve it to make this more clear.  If you find the rooms to improve and have
ideas for the improvements, please feel free to send patches.

> One more thing I would like to add is that I think it would be less
> confusing
> to move lru_sort and reclaim to the samples/damon/ path.

No, I don't think so.  Those are for real world products, not for samples.

> And it would
> be
> a good idea to organize the core sources toward
> mm/damon/modules-common.c source.

I don't find exactly what kind of reorganization you mean.  But I agree there
could be rooms to improve in terms of the files and code organization.  Any
suggestion is welcome.

[...]
> > > Finally, I would like to add that designing prdm with an extremely
> > > simple workflow -- load the module, set the target PIDs, and enable the
> > > switch -- will contribute to the promotion of DAMON, allowing a broader
> > > user base to benefit from the DAMON system.
> >
> > That workflow is definitely much easier than directly using DAMON sysfs
> > interface.  But, for the reason we have DAMON user-space tool.  Using it, the
> > workflow can also be as simple as prdm, like below.
> >
> >    # damo start $TARGET_PID --damos_action pageout --damos_access_rate 0% 0% --damos_age 2m max
> 
> Where can I find the damo source or documentation?

You could use https://github.com/damonitor/damo and its README.md file.


Thanks,
SJ

[...]
