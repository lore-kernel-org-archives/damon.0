Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647164;
	b=HMGVHJelHKnutWtYoOocmlnujuM9QHYEaOfFzUEYp3LwV/SEIsTdd8Ta79vwb1QpODLk
	 nbdDHdSDi/jUb4zHXx8VkE+P2oJ+izorIP1T2T9TV8+gbmXTYySQKJWOYgHIeQRzyFf5P
	 OB1FpP1rsouqWj9dVX2J41ZxoN/7+wShNwZViqT212s/6oC1NAnxbWtHsat0kuvXEZUt4
	 3TmQEd7Xo1BgHghtoxtuVNWPAmeOECfSoUF0Yho57YNsw6W1m6IzaufRE0Uxfr7XT0+HX
	 bZyA/BIThjY8mynMb/GU71KLL+jgco0Wbbq/LzoecwCF5I6nrAiuO77QiP+6xYLziyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647164;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CKiMLBOs1QLQP3rpiUjYHRnraw4ME+Y8+IXUIx1Xl8M=;
	b=HV1/bR0lRgMquesg9zvCOCBllvWWokmN+63DMA/ddF264h89i3BIj9j8W4IvQBFvv3xH
	 T79CxYzRNsy0i/ZOuwLKRv5B+a7PgJS7ucODSo219L/cPowdQHbkNKxyTPkkOKRQPibw0
	 xRie4Qj361iok3rN2igpVzFlQH8DbYDxlANQqYK0FRGbj5Fxe5qyUXs+ihzFeP5s6Fvlc
	 ztXC3AO6CHKjy2+wDj6vNus/NIi4yK0xOPMcKFMqYcZnC9c/SdktfW/JtI43TL03uMoaN
	 oSRtYZtuAtzfkE4FrIAWe8BfoD62eZ3zQD9i1o/WU596jiUzJovEpXn3lJY4JpN5nQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JirLoP/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43F606A319
	for <damon@lists.linux.dev>; Thu, 22 Oct 2026 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JirLoP/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FDE1F000C1;
	Thu, 22 Oct 2026 05:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792647164;
	bh=CKiMLBOs1QLQP3rpiUjYHRnraw4ME+Y8+IXUIx1Xl8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JirLoP/ZcBiqGI360sZ+JWaawS1Re5u9FnAmETbjVPyO9NL4+VYBhx9DsMweJjHuZ
	 tNilTk8f1fvWvRx4lhj33T0AOseMj05ak8XqbJC0SQ3z9Tfpv4EQuaUfs6Jxwl34+6
	 K1sS/tPS7Y0vhM+Rgs/IllugEjLJL+Z4eqy2BEFmSxXeigMTqrzo1Tr81TD/DwitEW
	 ZIF2+tYJptPxU8n0VHHLbSJXI5qAfmgB5+w7pPuXrB4iSt7pMnvF7A5bcCnbVszTur
	 NMXAiaQmMUUyfo5d5ZmanbxAugb40bFW3HoB4YWjFB43sh2bCRdDqzYkebJ+4M6oAg
	 Q89a2fLNQNsVw==
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
Date: Wed, 21 Oct 2026 22:32:26 -0700
Message-ID: <20261022053227.90608-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022041708.2690-1-ravis.opensrc@gmail.com>
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

On Wed, 21 Oct 2026 21:17:08 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Hi SJ,
> 
> On Sun, 18 Oct 2026 13:08:07 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Good question.  damon_report_attr() will save the register contents and pid
> > into report, too.  And the probe in kdamond context will decode the instruction
> > and get the memory address.  For physical address, it will also do the page
> > table walk of the process of the pid.
> 
> I measured what the samples carry, to see how far decode would go.
> 
> On AMD, cpu-cycles:p is IBS Op, and its memory-op samples carry a
> hardware data address.  On Intel (Granite Rapids), cycles samples carry
> no data address at all; the PEBS memory events
> (MEM_INST_RETIRED.ALL_LOADS/ALL_STORES) do.
> 
> Share of samples with an address inside the 2 GiB test buffer (random
> loads and stores; perf record -d; one run per event):
> 
>   Xeon 6960P   cycles:p / cycles:pp / :ppp     0 %
>   Xeon 6960P   mem_inst_retired.*:pp          100 %
>   EPYC 9555P   cycles:p, cycles:pp, ibs_op//  ~21 % of all samples
>                                               (the memory-op ones)
> 
> How often the saved AX holds the target address when AX is the base
> register (perf record -d --intr-regs=AX; store to (%rax) vs
> pointer-chase load mov (%rax), %rax):
> 
>   Xeon 6960P   store loop 100 %    pointer-chase loop 0 %
>   EPYC 9555P   store loop   0 %    pointer-chase loop 0 %
> 
> PEBS saves registers just after the instruction retires, so a load that
> overwrites its base register defeats decode.  IBS saves no general
> registers (perf reports the registers at the NMI), so decode is not
> reliable on AMD.  Decode in kdamond must also survive exec, munmap, exit
> and pid reuse.  These are synthetic loops chosen to separate the cases;
> how often real code hits the failing case is not measured.
> 
> For the physical address, taking it at sample time, while the task is
> current, avoids walking a page table that may have changed by the time
> kdamond runs.  IBS supplies it when valid; on Intel the producer can
> call perf_prepare_sample() in the overflow NMI to do the walk.

Thank you for these testing, Ravi.  Unfortunately I'm still learning perf event
and therefore not yet fully understanding these tests.  I will revisit after
gaining more understanding.

> 
> So the suggestion is for the first report type to use the PMU-captured
> address and load/store flag (AMD cpu-cycles:p; on Intel, the PEBS
> memory events, which moves them into milestone 2).  Your call, of
> course.

Meanwhile, I will start with the current plan (capture register contents in NMI
and decode in kdamond) if you don't have strong concern.


Thanks,
SJ

[...]
