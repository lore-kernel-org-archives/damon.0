Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792802967;
	b=R+qgZviM1EP8obuVm+jmPozPiwvDVU87ASjnQn6IWQKgrXAqCo5ldwy1fqcTl4ggPjnT
	 +dPWnA3fMUfA5dc27i7CYWcpura1tO+bVzsslWtAi3sIQKNTrwjghD2QJPzq0VU+0BDWz
	 ouwxdoNEtCAfXqaix2NQpWxQNXq8Cj0pAmPTVOZscavZ4hre8C5N0vFxuPyk7GfJSmrkN
	 tbR8Zziyj7NDuHK/6WG1BwApEUfOKlJsYa8oSvFBoSwGyMdn6fVrsndbCN0n5eSNiMIzL
	 aUgAGfPOxyPvaW6Bd6mk+ShJsUuQXqVWkufm4UkYrAvFOdKUhMZjUP84GBgEVODeqfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792802967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hRNeFuA2pYlESeNLcoEeMIof/8ARD78QxbjEPZKg0Yw=;
	b=k2xLtaQJAdg/P5dU1BblDmxykWUzErsvWgkA9WVJtGS61pDbbzONSSb62mnuBl3zNuXC
	 EtttEkRlTtmcjiFT6VEJREIPfziRWhIaBscpmWQ/noFEz5DVI/5QfBCqvNTczqtYRQewd
	 EtQllJtwF+czq34WiCL1QdEu75l0X4FIMzfvmHuZOQ4/yWPlTI9adAhSF9iAvB58h0vMQ
	 7im4MhFN3InzxVy1MtoP5ZO6KV7ajYSoj6n/VJlwQN9oPUwP9SJOVKH2hGHp29yEVruXm
	 6qeoiQ7cgjgBssG5Hj7/cC0E5cP8brnWC2vDYGiTVKQbNE712haYTXBzlFapcWYVk1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TQRlw/Ke";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D6606A31A
	for <damon@lists.linux.dev>; Sat, 24 Oct 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQRlw/Ke
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430521F01825;
	Sat, 24 Oct 2026 00:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792802966;
	bh=hRNeFuA2pYlESeNLcoEeMIof/8ARD78QxbjEPZKg0Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQRlw/KeCb5kMLBUqrRLMMTLQrtP8H4BL3lQkQcIwCo4zXYavKcdn+E8vm0sNYmzk
	 ksGeI553hbHyUwhF48+d1cfPFHMgrnScs+TB5f0qIjpP8ZIIqLrEiRK5XR0+w/pIKq
	 molVmRhl2eE3F93jy7Q2o7QT1Nv5FFOQAjXdC3O4j5gO2i4Y9CWtrc2KFE7akRTfcZ
	 gD9U6CBzeeEz9Km6ZvCcoOI5hG7OALYWCAAu4dxv0BjRJdnQJUSHIpnsmLXTdvRVmf
	 P0KrtX8XIIJsshW0xmyj5yBB1O9XfMuHfq9LGtwitbTUDNOalrN8PYWowr+2Us4+Is
	 auGefqa302zZA==
From: SJ Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	corbet@lwn.net,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	sashiko-bot@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
Date: Fri, 23 Oct 2026 17:49:14 -0700
Message-ID: <20261024004914.87522-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023194848.2449-1-ravis.opensrc@gmail.com>
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

On Fri, 23 Oct 2026 12:48:48 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Hi SJ,
> 
> On Wed, 21 Oct 2026 22:32:26 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Wed, 21 Oct 2026 21:17:08 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
> [...]
> > > PEBS saves registers just after the instruction retires, so a load that
> > > overwrites its base register defeats decode.  IBS saves no general
> > > registers (perf reports the registers at the NMI), so decode is not
> > > reliable on AMD.  Decode in kdamond must also survive exec, munmap, exit
> > > and pid reuse.  These are synthetic loops chosen to separate the cases;
> > > how often real code hits the failing case is not measured.
> [...]
> >
> > Thank you for these testing, Ravi.  Unfortunately I'm still learning perf event
> > and therefore not yet fully understanding these tests.  I will revisit after
> > gaining more understanding.
> >
> > > So the suggestion is for the first report type to use the PMU-captured
> > > address and load/store flag (AMD cpu-cycles:p; on Intel, the PEBS
> > > memory events, which moves them into milestone 2).  Your call, of
> > > course.
> >
> > Meanwhile, I will start with the current plan (capture register contents in NMI
> > and decode in kdamond) if you don't have strong concern.
> 
> No strong concern.  Starting with decode makes sense, and VMs are a
> good reason for it: in the KVM setups tried on Intel and AMD hosts, no
> guest got a data address from the PMU, whereas every guest had a
> software CPU clock (PERF_COUNT_SW_CPU_CLOCK) or basic hardware cycle
> counter (PERF_COUNT_HW_CPU_CYCLES).
> 
> As quick background on why those earlier test tables brought up PEBS
> and IBS: in perf_event, sampling CPU cycles has two modes, selected by
> attr.precise_ip (the :p suffix in perf record):
> 
>   - Plain cycle or timer sampling (attr.precise_ip = 0, the default):
>     a counter overflows and raises a normal interrupt/NMI.  The
>     hardware does not record a data address; the handler just sees
>     pt_regs where the CPU stopped between instructions.  Even though
>     the interrupt lands a few instructions after the overflow ("skid"),
>     regs->ip is the next instruction about to run and pt_regs holds
>     its untouched input registers -- so decoding regs->ip gives the
>     address it is about to access.
> 
>   - Hardware "precise" sampling (attr.precise_ip > 0, which routes to
>     Intel PEBS or AMD IBS): the PMU hardware itself snapshots the
>     instruction and, on supported events, the data address it touched.
>     My earlier tables tested this mode.  Because PEBS records registers
>     after the instruction retires (when a load into its own base
>     register has already overwritten it) and IBS does not capture
>     general registers, software decode breaks there -- which is fine,
>     since in that mode you use the hardware-captured address instead
>     (your Milestone 3).
> 
> So there is no need to revisit those earlier test tables for your
> Milestone 2 prototype.
> 
> Two small tips for the prototype:
> 
>   - use PERF_COUNT_HW_CPU_CYCLES (or PERF_COUNT_SW_CPU_CLOCK in VMs
>     without a virtual PMU) with the default attr.precise_ip = 0;
>   - skip, and count, samples whose instruction does not access memory;
>     in typical programs, only ~15-60% of cycle samples land on a load
>     or store.
> 
> If you want to inspect what those samples look like from user space on
> a program:
> 
>   R=AX,BX,CX,DX,SI,DI,BP,SP,IP,R8,R9,R10,R11,R12,R13,R14,R15
>   perf record -c 2000003 -e cycles:u --intr-regs=$R -- <program>
>   perf script -F ip,iregs,insn
> 
> (In a guest without hardware cycle counters, use -e cpu-clock:u
> instead.)  Each sample shows the IP, the registers and the instruction
> bytes to decode.

Thank you for these useful information an tips!


Thanks,
SJ
