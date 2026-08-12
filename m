Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12CA43FD0B
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542692; cv=none; b=pzUgqm71Jr6gIfzwwreZ4qUT+0sHtYD1hqT2LvRkp5NN0FokqfsRSM1sPIq/lBtvWheQkvYkiAUtI4/0Ea8uA4VF5H9s7IEVosvlyDX9Dmtx0zc+sXkSa5qw3CPu8A4lWMuLKxZG/x2pdImisEF+H8oTmAdu+ld21Xc60k6303o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542692; c=relaxed/simple;
	bh=F0FxKLiiUB7LkdhilpFhhJFPVoGTW35eRfZSzNg5fLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XycjOpY/E3iF3QiMIJrY/srmXTTedXVTIOz6iG1/M0UTa4l3YWQmWpGuHHh0ubk7hH1ZiW/h1SWSqtk/8u5R1H7x95dar8C0gkhXJFAZp7lYagpatFxNTXyJhp04jcFbXlkfNVIoTl1EzgTkMKEXPaLWgLy5v59lEic6P29ii+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2V6iN06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2V6iN06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B201F000E9;
	Wed, 12 Aug 2026 13:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786542690;
	bh=67u5wGls1reypvgN6MDJp0xDQmwOUZmdz1mw0B5OzOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2V6iN06kIrDATqqHJaALAq4S4wrtBizEqO1gSQXJIaM+sENCRrfEuDDLs26pAC6y
	 zpjKVlcJZxqMEnv83VjTH+dlSqP+tiREd29rgflzK+ZBwpUC4wMWSCVr7AxFGbVR+C
	 guxl2MghEriHUWazuE9ybY2cmoYUMf3M51Z+QOlnEIFtNVGPHiUZngauYIg7xqXn05
	 VzYr26HI+INILNpX8PCddI6iAJcM4dEvyptClCuWvJW1yAE+TEnlM7l8gzN+WCLqIu
	 BDN42MjDMA3zcpleOcj4XR60MExWRK3liNi/x6MuWNrtNGbJvJm9mf/+kynq328Q5l
	 TgR7pQRB6+CRw==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Question on damon_sysfs_memcg_path_to_id() path resolution
Date: Wed, 12 Aug 2026 06:51:20 -0700
Message-ID: <20260812135122.86809-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b01d7150-42a4-49b4-a3e1-b29d6db9c290@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 12 Aug 2026 21:00:42 +0800 Song Hu <husong@kylinos.cn> wrote:

> 
> Hi SJ,
> 
> Sorry for going quiet on this - things piled up and I let the thread sit.
> 
> 在 2026/7/21 12:43, SJ Park 写道:
> > On Tue, 21 Jul 2026 10:03:07 +0800 Song Hu <husong@kylinos.cn> wrote:
> > [...]
> >>>> I'd keep the first cut to just the read helper + DAMON migration; an
> >>>> in-kernel trigger callback I'd treat as a separate, later step and only if
> >>>> there's a second consumer.
> >>> Seems you have larger picture.  I don't clearly show what is it.  Could you
> >>> share it at a high level?  That might enlighten me.
> >>>
> >> The bigger picture, since you asked: I'm working on node-level multi-domain
> >> (cpu + memory + io) resource coordination for container/K8S co-location -
> >> online/latency-sensitive work sharing a node with offline/best-effort. PSI
> >> per domain is the signal ("who is starved, on which domain"); cgroup
> >> controllers are the actuators (cpu.weight/cpu.max, memory.low/reclaim,
> >> io.weight/io.max). Adjust across domains to defend online SLOs while
> >> keeping the node full. oomd, systemd-oomd and rubik each do one slice
> >> today; nobody coordinates across domains, and that cross-domain part is
> >> what I'm building.
> > 
> > Thank you for sharing the big picture.  Sounds very interesting!
> > 
> Glad it made sense. I owe you an actual answer to the question, though,
> not just the sketch.
> >>
> >> What brought me to PSI/DAMON is the memory domain. DAMOS is already the
> >> strongest memory actuator I'd want to orchestrate rather than reinvent -
> >> proactive reclaim, per-memcg DAMOS goals, the PSI-aware quota - except
> >> DAMOS goals today only take memory-domain signals (mem PSI, mem usage). For
> >> a cross-domain coordinator the useful step is making memory-domain reclaim
> >> also respond to non-memory pressure (e.g. shrink offline footprint when
> >> cpu.pressure rises).
> > 
> > That's a very interesting idea.  I'm not quite sure what would be the expected
> > result of doing cpu pressure based proactive memory reclamation, though.
> > 
> Honestly I'm not sure either - that's exactly why I'd rather measure it
> than argue it. The bet, loosely: on a co-located node, when cpu.pressure
> climbs you shrink the best-effort footprint - fewer resident pages, fewer
> reclaims and faults fighting for the core, and memory given back to the
> latency-sensitive side. You're trading memory to buy back CPU. Whether it
> pays off, and how much, is what I don't know yet.
> 
> I've been building the thing I described so I can measure it. It's a
> per-cgroup, per-domain PSI daemon (C, libbpf) - it reads the pressure and,
> when adding resources doesn't make it converge, it tries to tell real
> scarcity from a leak or pathology before piling more on. A colleague and I
> are still debugging it.

Thank you for transparently sharing this.  And I agree, data will let us be
more enlightened, realistic and creative.

> 
> >>
> >> So the honest question, which I think is where this actually meets the
> >> kernel: is the pattern you'd prefer that an orchestrator just adjust DAMOS
> >> schemes over sysfs in response to external pressure, or have you thought
> >> about DAMOS goals accepting non-memory signals (cpu/io PSI, or generic)?
> > 
> > I haven't thought such things.  That's only because I was unable to imagine a
> > use case that will benefit from that.  If you have some theories and/or data,
> > please feel free to propose changes.
> > 
> > FYI, DAMOS supports arbitrary 'user_input' for a quota goal.  You will be able
> > to do some experiments using it.
> > 
> That user_input goal is the handle I was missing - thanks. The plan is to
> wire DAMOS proactive reclaim to that goal as the memory actuator, feed it
> the cpu-pressure signal, and see what comes out. I'd rather get the data
> before the theory.

Sounds good.  Let me know if you find any problem at doing the experiments.  I
consider lab environment is also an important use case of DAMON.  I will be
happy to help.

> 
> >> I'm asking which side of that line you'd want it on, not pushing either.
> > 
> > No worry.  I prefer DAMON to keep doing random evolution for providing benefits
> > to the users.  If you have use cases that can benefit from some changes in
> > DAMON, please don't hesitate at asking questions and proposing changes.
> > 
> Agreed. I won't bring you a "goals should take a non-memory signal" request
> until I can show it actually helps - and if the numbers say so, I'll come
> with a real proposal.

Sounds good, I'm looking forward to the proposal!

> 
> >>
> >> Thanks for asking for the picture - stating it clarified it for me too.
> > 
> > I'm happy to help :)
> >
> Thanks for thinking it through with me.

You're welcome!

> 
> Thanks,
> Song
> 
> P.S. The code's at https://github.com/sharkct/tools_base_psi if you're ever
> curious - not a pitch, just something I've been having fun with :)

Thank you for sharing this!


Thanks,
SJ

[...]
