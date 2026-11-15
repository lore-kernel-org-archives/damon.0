Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775992;
	b=fdq+MbkkS93CRMhoIy0dOMpSnEvcjgmRGoO4ZEHGDfbTBOEEVfnPjCtmhKSap1hvQ5wR
	 Cl0vp0MRxzMKGyuUGMAX6U5bscSBW4RKDbVdYYA1e04RpD3UR3mULe99zSYbU8R0Zildh
	 4zmX1DxS1ij3YdDf7URV+jLzQrWhVmlRbKNHOB8enLdVH45PwN/jzHaC2leo5lKA+3NIa
	 47j6+irDXcwITWhS0p8dnowy1JBIViaw1aQUjbCXFq0ahQVtShibBqP90I1P8kmV3BAak
	 bElK/DVei1gb7FgFtv/TgdBgIB1fU5Z/ZPi5ufIcdH/ySH88ADufAk4YY5cjZsA8LZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775992;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=omk9LHBZ0aprcejLRyNU3Mqp3PNlP/G+umWx9ogoIT8=;
	b=D9YXJx6w2CMhK1HfLhPW1+2TgZ6y5dzlsCZwQ0fwZyeFsOSn6SQTyz6SFuygUysEzsTV
	 yIbuLnq8UNKVGXKiSgNMge/C9zVIY46QHK4GE8inpEP2iLz5DHyfEjuGOlqba/wpx386f
	 Qvc+G+Wqm/2cuaG8Ljuulnr2n8VD+O8R0mF9jlZLoV2DfP7+Qe0oyGpFDx/msi65h4FTe
	 iF7Cy91Esmf6siapfzq4OEtdF1PxNdS+0kSZcYkhLNx0I0nhAuxXeAj6QqxKiZ9OG4D77
	 qpbK8p+lvxd6QdsBqCGMG4mJg6BMaTORD/gjjkPupGk8lM0ARiskNTdT4yXymATVx2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJf5UJak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78E606A329
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJf5UJak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E772A1F000C4;
	Sun, 15 Nov 2026 20:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775992;
	bh=omk9LHBZ0aprcejLRyNU3Mqp3PNlP/G+umWx9ogoIT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gJf5UJakh+23diSYRzeWwzqxkx6qDEJcphSVJzROfwOjKaQZrTzvUrvkRfxqirsfP
	 ynfh+Buo3B/xKJDyxEFokr49jNq+Ed8ygpSMSfQujqfyz0IdNrzHaSiiDASDropPmf
	 yONbex2WWHh7Bg+OsOLvqU7E0xVxlJMIHL3k6hnBP8RW6mYk2FMDM+dsAWr5z4Sgz3
	 c6lIDhsA0BBLNWV0o1OGJKAYva6zVgqC/flUcbC96Fqxn4/dtHz1jppp4od5XNi+di
	 yLkpeM9tS8Yh5HnUjvNTxGxublw0HFrVeJdv3sdmuoV8oXApJj4fei5lbZ9+zRzDcX
	 yCVHWth/ykOKA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: milestone 2 proress update (was "Re: Roadmap for extending DAMON beyond pte-accessed bit")
Date: Sun, 15 Nov 2026 12:53:04 -0800
Message-ID: <20261115205305.99823-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260905171537.84217-1-sj@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  5 Sep 2026 10:15:36 -0700 SJ Park <sj@kernel.org> wrote:

> On Mon, 25 May 2026 15:52:08 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > TLDR: Let's extend DAMON for data attributes monitoring, andd then further
> > extend that for multiple access check primitives including page faults, perf
> > memory-access events and optimized AMD IBS-like h/w feature drivers.
> [...]
> > Milestone 1: PTE Accessed bit as one of the data attributes
> > -----------------------------------------------------------
> > 
> > I will work on stabilizing and further extending the data attributes interface
> > and internal framework to be able to support PTE Accessed bit.  This may take
> > no small amount of efforts, but hopefully doable by the end of this year.
> > 
> > Milestone 2: First damon_report_access()-based data attribute monitoring
> > ------------------------------------------------------------------------
> > 
> > Once the first milestone is completed, we will add the damon_report_access()
> > and related infrastructure changes into the DAMON core.  On top of it, we will
> > further implement the first data attribute that utilizing the reporting
> > infrastructure.  I personally think the perf event based one is a good target
> > at the momentt.  I think so mainly because the perf maintainers didn't show
> > special concern yet.  We can discuss the target again after the first milestone
> > is completed, though.  Hopefully this is doable by the LSFMMBPF 2027.
> > 
> > The timeline is just a gut feeling.  It could be done much earlier or later.
> 
> The patch series [1] for milestone 1 is now merged into mm.git.  Having it
> merged into mm.git doesn't guarantee landing on the mainline.  More works for
> making it complete including support of vaddr and DAMOS should also be
> continued.  Refer to my another reply [2] for mroe details on the additional
> works.  But we show no concern for landing the series on the mainline as of
> now.  And the additional works are not blockers of milestone 2.
> 
> Therefore, I believe we can consider milestone 1 nearly done.  Hopefully the
> series will be merged into the mainline by 7.4, which is expected to be
> released on 2026-12-20.  Then we can officially mark milestone 1 as delivered
> on time.
> 
> So I believe it is the time to start milestone 2.  This would take time.  I
> need to start from learning perf event system.  This project is definitely
> important but I'm not dedicated to only this project.  Please bear in mind with
> me.  But I'm still optimistic to the planned timeline.  It still looks doable
> by LSFMMBPF'27.  We are still on the track.

I shared more detailed plans for milestone 2 with as a plan-only RFC v0 patch
series [1].  The plan is to implement the report infra and cpu cycle sampling
based monitoring using the infra.  Once those are done, we can move to
milestone 3 and let people implement more report based modes utilizing more
hardware features like AMD IBS, Intel PEBS and ARM SPE.

I just posted a new version of the series [2] as a formal RFC.  The high level
plan is not changed.  We will implement the cpu cycle sampling based
monitoring.  But the scope of the series is reduced.

I realized implementing CPU sampling is not a small amount of work.  It
requires no simple report infra, and understanding of perf.  It is making
progress unnecessarily slow and make the change unnecessarily big.  So I found
another simple but practical report producer: user-providing reports.

Hence the RFC v1 patch series [2] implements a very simple report system, and
user-provided report based monitoring mode, using the report system.  It is
still not very small.  The series is consisted with 27 patches.  But I believe
this is reviewable and consumable.

I will make this be merged first, and then further advance the reporting infra
and implement the cpu cycle sampling based mode.  Refer to 'Ongoing and Future
Works' section of the cover letter for more details.

Hopefully the user report series will be merged by 7.5-rc1 or 7.6-rc1.

[1] https://lore.kernel.org/20261017195747.89961-1-sj@kernel.org
[2] https://lore.kernel.org/20261115202849.99134-1-sj@kernel.org

> 
> [1] https://lore.kernel.org/20260901132506.99243-1-sj@kernel.org 
> [2] https://lore.kernel.org/20260905165221.83994-1-sj@kernel.org


Thanks,
SJ

[...]
