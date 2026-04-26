Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463C30170F;
	Sun, 26 Apr 2026 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777239358; cv=none; b=WK3x5oeZKMGeXnOPRhC4JCeQM7rceOsnrOy91Zi+hG4Ian5iNbag7sNy5fh+Sef6MnZ6fiNlGtK3W32KGCix5cvlPqqThcIHMGaCAoqFZcrzbxrAU6X9WVw5I3d+wEq7pA7nf7+gRbGGXp44o0afwgB598be/JxNf4/0trGd2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777239358; c=relaxed/simple;
	bh=Rq7iGq1NrzSuziVzDDLNRSP6hpEn5cTl6I5YrkUio7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8ZwHO6jImo1hmK4ojt9OL8XCTih8iOggyhF/JEBnSXOIi3wsAaG0HSjh3HHK/Ny5LU+HQi5OQX72Gc6g5+hwLci0R91685GKXBHDO/1VTvBM5XnHOmWJXJH/i+fWmrNVPFqRxRplyouo7liCZLPp/kRqlDL7ui7Jn45uayxbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLiYnCwg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLiYnCwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E54C2BCAF;
	Sun, 26 Apr 2026 21:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777239357;
	bh=Rq7iGq1NrzSuziVzDDLNRSP6hpEn5cTl6I5YrkUio7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLiYnCwgP0wp7fusKepUAGKcPqZ6qJrJ1cygVibKefiQDjvloOse5oGumS0N0Tq5n
	 dGKgII8nHIuV83Xc346HZdcseOMmdv8e4lL/qJt2IjNzVtK+SrvQn20x1ozMzG0Rw+
	 yOxJzr8Qfzr1r874/o8s4qIWTf92aH0Op8eATzwlnQ/gInOuvTzWDDXX6AHaut9Z1S
	 t7Tc6tCmQ7tEA3l2PC7x8UK6q8npfuKTtCy6w+lde3kXKN68deqo7OeHYLXwy9cSHE
	 TufiepTSPw6n08HSJEsSZf4KIDrInae6nKRvb9vXegI7wFnw3jL9N6TIvqU3f9h5L3
	 ZAzUocyK9pEJg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Updates: Tiering, Pagel Level Monitoring and DAMON-X
Date: Sun, 26 Apr 2026 14:35:43 -0700
Message-ID: <20260426213545.94918-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426212048.94069-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 14:20:45 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat,  7 Mar 2026 13:02:48 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > In the last year LSF/MM/BPF, I shared [1] updates of the status and future
> > plans on DAMON development.  Feedbacks were very helpful.  I'd like to share
> > new updates and gather more feedback on LSF/MM/BPF 2026.
> 
> As this topic is scheduled [1] for the conference (kudos to the conference
> committes!) and the day is approaching, I'm sharing a few updtes.
> 
> > 
> > Major topics to discuss in the session include but not limited to below three
> > topics.  Of course, some changes could be made.
> > 
> > Followups on work items that we discussed on last LSF/MM/BPF
> > ------------------------------------------------------------
> > 
> > DAMOS auto-tuning based memory tiering.  I worked on a more flexible evaluation
> > setup for it.  I also upstreamed another DAMON extension that makes memory
> > cgroup-aware memory tiering available.  An unnamed user confirmed positive test
> > results of the auto-tuning based tiering.  Meanwhile other users including
> > people from SK hynix and Micron are continuing development of their own memory
> > tiering approaches and showing good achievements.  Because basic evaluation of
> > my approach is done, I'm not actively working on this now, but working in a
> > support mode for this.  I will share more details about this and discuss if
> > something need to be revisited or if there are anything that DAMON can help for
> > memory tiering.
> 
> Ravi from Micron is continuing their work [2], and now it is nearly ready to be
> landed.  This is only a part of the topics I want to discuss on the session,
> though.
> 
> > 
> > Page level monitoring.  The feature, which accounts the number of pages in each
> > DAMON region of user-interested type (e.g., hugepage, LRU list-position,
> > belonging cgroup) has successfully upstreamed after the LSF/MM/BPF 2025.
> > Because it imposes high overhead on large systems, a lightweight version of it
> > was shared as a future work.  Unfortunately not much visible progress for it
> > has been made so far.  Some progress on the design is made, though.  Briefly
> > speaking, the idea is sampling the types of pages in each DAMON region.
> > Implementation wise, users will be able to set the types of their interests,
> > and DAMON will provide the counts of the samples of the interested types, in
> > addition to the access frequency counter (nr_accesses). I'd like to share the
> > design and get feedback.  Hopefully RFC ideas or patch series will be shared
> > before the conference to help discussions.
> 
> I was able to make some progress and just posted [2] the RFC patch series.

Sorry, the link marker is wrong.  [3] is the link.

> Conference driven development works! :)
> 
> > 
> > FYI, in future, the counters of interests could be extended to do the DAMON
> > region merge/split based on not only access frequency but one of the
> > user-defined interests.  Then DAMON might pivot from Data Access MONitor to
> > Data Associativity MONitor.  It’s just somewhat possible and sounds funny for
> > now.  I find no real use case of that.
> 
> I now think this is the right way to go.  This can also make page faults and
> PMU events based mointoring like access check primitives addition easier to do.
> I added more details about this on the 'Future Works: Long Term' section of the
> cover letter of the RFC patch series [1].

Again, the above is using a wrong link marker.  [3] is the right one.


Thanks,
SJ

> 
> > 
> > New Project
> > -----------
> > 
> > DAMON-X.  In Crusoe, which is a neocloud company that I’m now working for, we
> > want to utilize DAMON for both memory efficiency and observability.  More
> > specifically, we want to show the memory idle time percentiles, and run memory
> > PSI-driven proactive memory reclamation.  The straightforward way would be
> > doing that via DAMON sysfs interface, or DAMON user-space tool.  It requires
> > some user-space programming, though.  I want the kernel to just work.  A way
> > for that would be running DAMON modules that were developed for the purposes,
> > namely DAMON_STAT and DASMON_RECLAIM.  But DAMON modules run in an exclusive
> > manner, so we cannot run those in parallel.  The exclusiveness is required to
> > avoid interference between DAMON worker threads (kdamond) for different
> > modules.
> > 
> > I plan to let DAMON modules share kdamonds to let them run in parallel without
> > interference.  The shared kdamond would be able to run on the system from the
> > beginning or on demand, and directly attach/detach DAMON applications like
> > DAMON_STAT, DAMON_RECLAIM, and future ones for NUMA-aware page migrations etc.
> > It will work with a very minimum number of knobs in nearly automated way, but I
> > plan to also extend the DAMON sysfs interface for more flexible and manual
> > control of it for experiments and investigations.  With my humble naming sense,
> > I’m currently calling it "DAMON Enabled Computer System", or DAMON-X in short.
> > Actually this is a followup of what I shared in LPC 2024 kernel mm
> > micro-conference, as a long-term DAMON project for the kernel that just works.
> > I want to share Crusoe's desired use case, problems, and design of the
> > currently planned solution during the session and get feedback.  Hopefully RFC
> > ideas or patch series will be shared before the conference to help discussions.
> 
> I was unable to make much progress on this.  As we still have one week, I will
> try to share a detailed RFC idea at least, before the conference.
> 
> > 
> > More Topics Out of This Session
> > -------------------------------
> > 
> > There are two more DAMON-related development works that are ongoing, that I
> > want to discuss in LSF/MM/BPF.  Because I think those cannot be discussed in
> > single session with the above three topics due to the limit of the time, I
> > proposed separate sessions for them.
> 
> The two topics are also scheduled [1] for the conference.  We will have one
> hour session for all three topics.  Appreciate the conference committees for
> their works!
> 
> > The two topics are "production level
> > access-aware THP [3]"
> 
> Asier from Huawei made DAMOS_COLLAPSE [4].  I will repost it after 7.1-rc1, and
> hopefully it will be merged into mm-new by the conference.  This is only a part
> of the topics I want to discuss on the session, though.
> 
> > and "per-CPUs/threads/reads/writes data access monitoring
> > [4]".
> 
> The page level monitoring RFC patch series [3] is now also considered to be the
> foundation for the interface of this work.
> 
> Akinobu continued thier PMU based mointoring work [5] and I now think that
> could be a viable option for some of users including Crusoe, if page fault
> based monitoring is rejected or delayed too long.
> 
> > 
> > 
> > 
> > [1] https://lore.kernel.org/all/20250102222317.48760-1-sj@kernel.org/
> > [2] https://lpc.events/event/18/contributions/1768/
> > [3] https://lore.kernel.org/20260211050729.69719-1-sj@kernel.org
> > [4] https://lore.kernel.org/20260218054320.4570-1-sj@kernel.org
> 
> [1] https://docs.google.com/spreadsheets/d/1mGEdDrWskp7Ua91jGXzquQGinorcD58DAVXhOiRp2Gg/edit?gid=1852749899#gid=1852749899
> [2] https://lore.kernel.org/20260426003245.2687-1-ravis.opensrc@gmail.com
> [3] https://lore.kernel.org/20260426205222.93895-1-sj@kernel.org
> [4] https://lore.kernel.org/20260409150128.1566835-1-gutierrez.asier@huawei-partners.com
> [5] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.com
> 
> 
> Thanks,
> SJ
> 
> [...]
