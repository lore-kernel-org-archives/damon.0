Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEFD79DA;
	Sat,  7 Mar 2026 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772917374; cv=none; b=X+g5AInkelUpiywravC6B3Rtz4Fza8GWVGmACFhvNmwhw952jsqucSKaGITCmjuzdY1KuiF4ebcJgIjwbl12WYVBH2RItvRe9Px1BbG/df7ETvSB4n/2SpjsNci7HYUh64DnSqpMr/t0jN9mFrRMfJ0lHhgDfdhD+7OJWYKgjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772917374; c=relaxed/simple;
	bh=U9kK/VbZNvIYMl23ToOaVPKCak2t7IyWptoDNzgEeDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FzIkVnIYOHV+lLtAmsI0iKZ3YPUCDF2S6/sNsc0ZwQwSHOynmqXHJk9s46Hc4NwIyIJS+ZdUBXEPoJe1K02jAYVSgFrVtrBb+kLDTawfWttPZulE4usDucKQzg5H4KLyR0AIWLoZx5Rr+89ISktf0lCT1W/bQV6WRM8kk+uDliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G346BLJB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G346BLJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B188C19422;
	Sat,  7 Mar 2026 21:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772917374;
	bh=U9kK/VbZNvIYMl23ToOaVPKCak2t7IyWptoDNzgEeDU=;
	h=From:To:Cc:Subject:Date:From;
	b=G346BLJBP6m8uwFhjscFYwSKaSVOU/EWK/dMAADEQ+jCKjY8xm9RaxOLyIjh78noL
	 JR25BgKuE5VnpxSTT4/ubb0psd0RB+1Xgl2Yos8AfIePNoZr8SvbSNP6RvixAsG0tL
	 JFJNjiu1E94u5Dve9RfGz4taCwOnnasXXTDPj/LOTSv8cEILyBEYafKHk7+dCmNxSj
	 tZJiBJdAvVWbjCnD5O5VvVypN6hIzlaY1uqw1BdGvfm34pVRmlxBwQKXIuI/PVLyc9
	 uHiZlFAamtzeJyjpne4U0sBrOZSEcfrKM92ZU5F8qkNmUTMhE/Q53roMViId3I6z0U
	 1A/IKnSnYkB/g==
From: SeongJae Park <sj@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] DAMON Updates: Tiering, Pagel Level Monitoring and DAMON-X
Date: Sat,  7 Mar 2026 13:02:48 -0800
Message-ID: <20260307210250.204245-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,


In the last year LSF/MM/BPF, I shared [1] updates of the status and future
plans on DAMON development.  Feedbacks were very helpful.  I'd like to share
new updates and gather more feedback on LSF/MM/BPF 2026.

Major topics to discuss in the session include but not limited to below three
topics.  Of course, some changes could be made.

Followups on work items that we discussed on last LSF/MM/BPF
------------------------------------------------------------

DAMOS auto-tuning based memory tiering.  I worked on a more flexible evaluation
setup for it.  I also upstreamed another DAMON extension that makes memory
cgroup-aware memory tiering available.  An unnamed user confirmed positive test
results of the auto-tuning based tiering.  Meanwhile other users including
people from SK hynix and Micron are continuing development of their own memory
tiering approaches and showing good achievements.  Because basic evaluation of
my approach is done, I'm not actively working on this now, but working in a
support mode for this.  I will share more details about this and discuss if
something need to be revisited or if there are anything that DAMON can help for
memory tiering.

Page level monitoring.  The feature, which accounts the number of pages in each
DAMON region of user-interested type (e.g., hugepage, LRU list-position,
belonging cgroup) has successfully upstreamed after the LSF/MM/BPF 2025.
Because it imposes high overhead on large systems, a lightweight version of it
was shared as a future work.  Unfortunately not much visible progress for it
has been made so far.  Some progress on the design is made, though.  Briefly
speaking, the idea is sampling the types of pages in each DAMON region.
Implementation wise, users will be able to set the types of their interests,
and DAMON will provide the counts of the samples of the interested types, in
addition to the access frequency counter (nr_accesses). I'd like to share the
design and get feedback.  Hopefully RFC ideas or patch series will be shared
before the conference to help discussions.

FYI, in future, the counters of interests could be extended to do the DAMON
region merge/split based on not only access frequency but one of the
user-defined interests.  Then DAMON might pivot from Data Access MONitor to
Data Associativity MONitor.  It’s just somewhat possible and sounds funny for
now.  I find no real use case of that.

New Project
-----------

DAMON-X.  In Crusoe, which is a neocloud company that I’m now working for, we
want to utilize DAMON for both memory efficiency and observability.  More
specifically, we want to show the memory idle time percentiles, and run memory
PSI-driven proactive memory reclamation.  The straightforward way would be
doing that via DAMON sysfs interface, or DAMON user-space tool.  It requires
some user-space programming, though.  I want the kernel to just work.  A way
for that would be running DAMON modules that were developed for the purposes,
namely DAMON_STAT and DASMON_RECLAIM.  But DAMON modules run in an exclusive
manner, so we cannot run those in parallel.  The exclusiveness is required to
avoid interference between DAMON worker threads (kdamond) for different
modules.

I plan to let DAMON modules share kdamonds to let them run in parallel without
interference.  The shared kdamond would be able to run on the system from the
beginning or on demand, and directly attach/detach DAMON applications like
DAMON_STAT, DAMON_RECLAIM, and future ones for NUMA-aware page migrations etc.
It will work with a very minimum number of knobs in nearly automated way, but I
plan to also extend the DAMON sysfs interface for more flexible and manual
control of it for experiments and investigations.  With my humble naming sense,
I’m currently calling it "DAMON Enabled Computer System", or DAMON-X in short.
Actually this is a followup of what I shared in LPC 2024 kernel mm
micro-conference, as a long-term DAMON project for the kernel that just works.
I want to share Crusoe's desired use case, problems, and design of the
currently planned solution during the session and get feedback.  Hopefully RFC
ideas or patch series will be shared before the conference to help discussions.

More Topics Out of This Session
-------------------------------

There are two more DAMON-related development works that are ongoing, that I
want to discuss in LSF/MM/BPF.  Because I think those cannot be discussed in
single session with the above three topics due to the limit of the time, I
proposed separate sessions for them.  The two topics are "production level
access-aware THP [3]" and "per-CPUs/threads/reads/writes data access monitoring
[4]".



[1] https://lore.kernel.org/all/20250102222317.48760-1-sj@kernel.org/
[2] https://lpc.events/event/18/contributions/1768/
[3] https://lore.kernel.org/20260211050729.69719-1-sj@kernel.org
[4] https://lore.kernel.org/20260218054320.4570-1-sj@kernel.org


Thanks,
SJ
