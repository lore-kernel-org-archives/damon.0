Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1FB65C;
	Sat, 25 Jan 2025 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737767858; cv=none; b=mL0yz76aPmQlaKBa7DixSNPQT1P1xVLhmybG2/nFu34tt9dBSH0882rbK2NnaQCpu4ufGx0TH93JBzVFhyYdYyXAAKTXkNFHZk9UdHmDd+7+jLGCIOs+ZXC1tlh+tH5XpZqsxPWS2/W4oghNchvGbtd7GVShMv0Or3DvUkfUPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737767858; c=relaxed/simple;
	bh=eQFyexXRNnaCSzGEN+AapSEbEoss+pnTKy4qZAILOK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aiLcktXVITusE26Nlt7UJA02TCftcJ/GWh5jE97A1trjKKDSDHP6Jlc0cgL9uHrNDIWCOT8yMULJ6XSQtWupFwSmQinG9jAGjmXbdyEpwzZcOnP1sagCfqV/T60Kt2jh7kHs2PjF0Za4Prmm3IQ4raDdE/KV89rb0mbNY5fT1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaXShBHm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaXShBHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910CEC4CED2;
	Sat, 25 Jan 2025 01:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737767857;
	bh=eQFyexXRNnaCSzGEN+AapSEbEoss+pnTKy4qZAILOK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WaXShBHm+29dmziNxV8tlOVShsCJ+9njj3EURMkukkDrVJZpMIx8sTAwBqojXsWkX
	 U0KeuynElSRS4mlOC9sXEXA+yddyLTytHwU/+g1j6xVRroUurT0qIek55eIST3OfSI
	 krCpuv8BpuJXA/YGpWCOE/7x/ZfhI1VTCQgitG81Xx19yjuqwcRik34SnIbSQfBHTF
	 YqR1ZPwUJjJIIVgNZmrjSAig6ucPwNVyDXTcTzUa1/Oe5FfRX5xB59Svsfnv+QdhBo
	 AGHUOeCNrvQZlZ2zL3bQGgtYsgZwdifZM90qfKJtSk+yfh/orEbtAskLjMXCtBw5Y2
	 C+iZdB6NxmbgQ==
From: SeongJae Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>,
	lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Raghavendra K T <raghavendra.kt@amd.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of Future
Date: Fri, 24 Jan 2025 17:17:34 -0800
Message-Id: <20250125011734.38912-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <Z5PMG_F9wJXCb8ri@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Jan 2025 12:21:31 -0500 Gregory Price <gourry@gourry.net> wrote:

> On Thu, Jan 23, 2025 at 06:11:53PM -0800, SeongJae Park wrote:
[...]
> > >    This tells me injecting
> > >    an unconditional call into DAMON may be too much overhead. 
[...]
> > I'm also not pretty sure what DAMON
> > call you are thinking about.
> > 
> 
> Just any call, DAMON or otherwise.

Thanks for clarifying.

[...]
> It's not a matter of code size - it's a matter of tightly coupling core
> components of the kernel to extraneous ones.  Adding additional
> dependencies between components increases overall system complexity and
> makes it hard to reason about the behavior of the system.
[...]
> Now you need to understand swap.c, migrate.c, AND DAMON.
> 
> It makes it more difficult to reason about the system when something
> goes wrong. This increases the maintenance burden for maintainers (and
> onboarding complexity for anyone new to the kernel, for that matter).

Thank you for this kind clarification.  This is very helpful at better
understanding your point.  I cannot agree more on your point that tightly
coupling multiple components makes things compelx.  Let me emphasize your
points from other side, too.  This doesn't mean we should avoid using multiple
components together.  If the interface is well designed and being used
correctly, using multiple components together rather reduce the complexity and
maintenance burden.

In the example, swap.c maintainer should easily know something in migrate.c
that being used by swap.c is not working as documented or expected, and ask
migrate.c maintainer to fix it.  I'm trying to make DAMON be designed and used
in such a way.  I'm proposing this LSFMMBPF to help that by discussing in
depth, including specific examples of current or potential DAMON usages and
DAMON interfaces that not well designed for those.

> 
> That doesn't mean we shouldn't consider doing this - it just means that
> benefit needs to outweight the complexity/maintenance cost.

I agree this too, of course :)

[...]
> This missing the scenario where DAMOS/DAMON is not suitible for
> deployment in someone's environment.

I understand that you are saying a scenario that deploying out-of-kernel
components such as DAMON user-space tool is impossible, while those are
essential for a given usage.  And I agree that such case can be in real.

> The kernel should still do
> *something*.
> 
> And that is kind of the point - we can expose more complexity to the
> users with DAMON, but the kernel should be able to do some reasonable
> promotion action without this additional system.

I understand that you mean using DAMON for promotion requires users controls
using additional systems such as DAMON user-space tool (damo).  That's correct,
at least for today's DAMON usages for CXL memory tiering.  HMSDK[1] is such an
additional system.

Nevertheless, that's not necessarily the case in future.  DAMON aims to allow
flexible custom usages, while also just transparently works fairly well.  I
shared the humble ambition at last year's LPC[2].  We will pursue the direction
for memory tiering-purpose DAMON usage, too.

[...]
> > >    but I
> > >    also see value is making tasks handle promotion as a form of fairness.
> > 
> > I agree that could be good in terms of fairness.  I want to learn more about
> > the significance of it, though.
> >
> 
> Fairness in this scenario is simple.
> 
> If one task is causing an outsizes number of promotions to occur, and it
> causes some ASYNC system to handle those promotions, it is effectively
> acquiring more CPU time via that ASYNC system than other residents.
> 
> Trying to charge this time back to the noisey task is harder than just
> having the task incur the cost of migration.  But doing it inline can
> cause the task to slow down.
> 
> So it's difficult to predict how it's going to pan out.  Need evidence.

Yes, I agree that we need more data to say more about this topic.  Nonetheless,
I understand you are saying that's something better to have in future, and need
to aware of its potential risk, not a strict blocker of async approach
exploration.

> 
> > I agree.  DAMON allows combining multiple different mechanisms with its core
> > logic, so I beleive it migt be a place that can aggregate the different
> > identification mechanisms.
> > 
> > DAMON's access monitoring results based system operations feature, namely
> > DAMOS, also has its own aggressiveness control logic, and resides in the core
> > layer, so could be used consistently with different promotion candidates
> > identification mechanisms.
> > 
> 
> Without data this is a nice thought, but we have existing mechanisms
> that work and can be improved - lets not disrupt that.

Cannot agree more.  My intention is not to disrubpt that but ensuring people
who looking into such improvments are on the same page regarding available
current and future options.

> 
> Finding an aggregated promotion solution helps everyone move forward
> without disrupting development in these areas (and makes the different
> indentification mechanisms play nice with each other).
> 
> Trying to also create a voltron "one indentification system to rule them
> all" is a nice thought, but it's heavy-weight compared to adding a folio
> flag check and a call to mpol_migrate_misplaced().  We need to respect
> that reality and not regress the existing mechanisms by trying to
> over-engineer a generalized solution.

100% agreed.  This point is, and should, always be in DAMON hackers' mind.

Thank you for kindly clarifying your points and nice advice :)

[1] https://github.com/skhynix/hmsdk/wiki/Capacity-Expansion
[2] https://lpc.events/event/18/contributions/1768/


Thanks,
SJ
