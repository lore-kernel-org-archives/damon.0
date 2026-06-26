Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0837C0FA;
	Fri, 26 Jun 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486684; cv=none; b=Jsc+tcoW3EkQ4hIlRDFBkscWzObsE2XDUVh4uR7J3DyAl8CkP2DG7CihikWncH2izVYwC2H21yQZhPR8mzcU+9l6y8we+oN89dE1Kv9CsZOKyEC3DjPHGEB2PVBVUBrR6zLKQ0xFpzsbVjOkg6hp6mzobB5dwojQiEd8CYjltxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486684; c=relaxed/simple;
	bh=HLesOPYJkipgMtEXgj+X0m1CujMFA3L5DtR77zhaeLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ef6Skp5TFhGi2W1Be05cfqR+w7cCY6tRYWoIhfdhd3YGJgijnxYQjnM3gtpNQQ+WFbad8qQmcAjZDhWFRFxhsNMwRh5ZYy8HB8Y1AQETg7ahoHACLkCTEf0RDmGbfqtzK5YnrS9KQssVWaQ5mjd0fCwahyPtA+XLol00IiqAXCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEEYlLiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEEYlLiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F7B1F000E9;
	Fri, 26 Jun 2026 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486679;
	bh=HUtZMqCOdCenr50gEulAE+IUtkAdGzFUI1qYzhYf1RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZEEYlLiYFtPkSn8WOsmXnHi+2QBy06Jg2Z/jRWe3s+VfvHtNEtokgPFZoftjpMH8H
	 HTfwXFGWdbPY8xS1/iRyzHMijj8q21ns9T+nkNy39sThXxqPgxAyjfb3G5PxX7liBE
	 voqt5LWraogJ6n5Mo3cXc7hVvWiSwc3JxA6VpT8FFIwuJG2J01Z0yfr3QFLUZuGWy8
	 2L0ADCeea7I4Gev6Z6si44rfTV9ON9BITsYUS2vQOZG3ieaXI3LLBM5fqyzevrUtiL
	 XOZIzN1fSKZbzs01W3zVKT/aG3XLSiz4+7MKCQnUaYGEdAJ0KrWJO8LP+D8gsvgcTc
	 10jdgpMzL2YUg==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	ravis.opensrc@gmail.com
Subject: Re: [RFC PATCH 0/2] damo: support perf event configuration
Date: Fri, 26 Jun 2026 08:11:10 -0700
Message-ID: <20260626151113.116999-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umyj0qTqR0HpHux6+G6bvGCQqtM8CVVXSZSCt66OtJU7+AA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 22:56:24 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2026年6月23日(火) 22:50 SeongJae Park <sj@kernel.org>:
> >
> > On Tue, 23 Jun 2026 22:29:42 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > > 2026年6月23日(火) 0:24 SeongJae Park <sj@kernel.org>:
> > > >
> > > > Hello Akinobu,
> > > >
> > > > On Mon, 22 Jun 2026 22:49:31 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > > >
> > > > > This patch set aims to make it easier to specify the perf event settings
> > > > > proposed for DAMON by Ravi's hardware-sampled access reports patch set [1]
> > > > > from the damo tool.
> > > >
> > > > Seems this patch is built on top of the per-CPU/thread/read/write monitoring
> > > > patch series [1].  We made a plan [2] to use another user interface, though.
> > > > The plan is, making the interface ready for page table accessed bits based
> > > > monitoring by LPC'26 (milestone 1), and implementing the perf event based
> > > > monitoring on top of it, by LSFMMBPF'27 (milestone 2).
> > > >
> > > > So the eventual damo part change for supporting perf event based monitoring
> > > > will be quite different from this series.  I guess you are sharing this series
> > > > not because you aiming to merge it as is right now, but just for sharing the
> > > > code with other stakeholders like Ravis, not me?  If I'm not wrong, I will skip
> > > > this series for now, to focus on the milestone 1.
> > >
> > > Since I will align with the final user interface later, please focus on
> > > the optimal interface for Milestone 1 without worrying about that.
> >
> > Thank you, Akinobu.
> >
> > >
> > > > Please let me know if you want more of my feedback.
> > >
> > > However, even if the interface ends up being completely different from the
> > > current one, I believe that enabling configuration via `damo` using
> > > symbolic event names like this would still require calling the perf
> > > python interface (`import perf`) from damo and modifying the `perf` tool
> > > itself; could you please check if that approach is acceptable?
> >
> > I'm bit concerned at having such dependencies.  I'd prefer making DAMON sysfs
> > interface uses a symbolic names and just use it from damo if possible.  If that
> > is not possible, could you share more details about why such changes are
> > required?  I'm still lazily delaying studying about perf events, so please bear
> > in mind with me.
> 
> Theoretically, it might be possible to initialize `perf_event_attr` within
> the kernel based on the symbolic names of specified PMU events.
> However, doing so would require implementing logic to read
> `/sys/bus/event_source/devices/<pmu>/format/*`, as well as duplicating
> functionality within the kernel that is currently provided by the `perf`
> user-space tools.
> 
> However, if we limit processing to only the minimal format, such as
> `pmu/config=M,config1=N,config3=K/`, described in the explanation of the
> `-e` option in `tools/perf/Documentation/perf-record.txt`, it may be
> possible to minimize duplication.

Sounds good.

I'd prefer making DAMON interface as human readable as possible, as long as it
is not duplicating things too much.

I wouldn't mind adding changes that depend on perf user-space tools or
libraries in 'damo' for making it even more human-readable, as long as it
doesn't break the backward compatibility of 'damo', and perf developers are ok
with the perf-side change.  Anyway 'damo' is using 'perf' internally ;)  And
seems perf developers are thankfully very open minded :)


Thanks,
SJ

[...]
