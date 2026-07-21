Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCCA381E84
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 04:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784609025; cv=none; b=EdHvQJMMIt/KgzWT9hW9tt8M6qc5jQZ8qR9IREgNFJLdGNzkkMYr8T/Iu12HZ/Im27ZWY/ZR/XlkGyJ+BHVulEda7hGZkb5KE8pJzHDLdEmsjNFtbxLylLlgumIgL4kdIJih5NLxZZ2IfDcOqNOQB33AF8B3z3ukD3JgYQXOLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784609025; c=relaxed/simple;
	bh=2K8JZZZx2kZzn5Hyw75RgI+Wiolp+n5IMxWUucZMgEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=my8hL2p2rCDit9qe/KUOpaFCjeGV7C3fSc3BSkwbAodQC9vV5EO2UXcgIZr7Y3IZzAfvegBHbvyckhEwBUrtxsMlqNYAPitc2HyLWKOPOAl5YQh6B3a4jI6FyIYIFl10BM5wvCPjOGudogS/wRwlUHayei7M3eNl5q31eN+VtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCbpj0Uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCbpj0Uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A643D1F000E9;
	Tue, 21 Jul 2026 04:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784609023;
	bh=BvZcV0I/kMXiWhNwTtJrhZJsb/X/CbPDVY247We4Rg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCbpj0UuguveBDnEgfqWQ7yfn664pzgNmZqlweSjLHodflvwWkgLnCkS3YlpztKG1
	 jpD/CSJlpwQS9l64zM0kFCMkZ/glnn4409NU4tQljI7rAtVY81h/UUhpEQaxsxc7Ve
	 pFvSyZL7Wh61nq2Ns77HNhRcVAnTavqO2GQGbN/med3lNrxpNoIypc16ZYKsVHZVf8
	 P8+MMB/9SDUNR1/LmhyOkMBVQwwxyGLYmq9YV6HLwv/cPCo+GrNEIHM2OFC5drMFc7
	 qzkbsqwhNP2W3jW73hPaW57tod53smb3w3I6Y5WvJ8wuw8ru9MKKEIXGpEYb9DPb4F
	 6jmCGe43cq1PA==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Question on damon_sysfs_memcg_path_to_id() path resolution
Date: Mon, 20 Jul 2026 21:43:33 -0700
Message-ID: <20260721044334.152061-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2bde5778-532e-4970-a2fa-526a7d4de7aa@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Jul 2026 10:03:07 +0800 Song Hu <husong@kylinos.cn> wrote:
[...]
> >> I'd keep the first cut to just the read helper + DAMON migration; an
> >> in-kernel trigger callback I'd treat as a separate, later step and only if
> >> there's a second consumer.
> > Seems you have larger picture.  I don't clearly show what is it.  Could you
> > share it at a high level?  That might enlighten me.
> >
> The bigger picture, since you asked: I'm working on node-level multi-domain
> (cpu + memory + io) resource coordination for container/K8S co-location -
> online/latency-sensitive work sharing a node with offline/best-effort. PSI
> per domain is the signal ("who is starved, on which domain"); cgroup
> controllers are the actuators (cpu.weight/cpu.max, memory.low/reclaim,
> io.weight/io.max). Adjust across domains to defend online SLOs while
> keeping the node full. oomd, systemd-oomd and rubik each do one slice
> today; nobody coordinates across domains, and that cross-domain part is
> what I'm building.

Thank you for sharing the big picture.  Sounds very interesting!

> 
> What brought me to PSI/DAMON is the memory domain. DAMOS is already the
> strongest memory actuator I'd want to orchestrate rather than reinvent -
> proactive reclaim, per-memcg DAMOS goals, the PSI-aware quota - except
> DAMOS goals today only take memory-domain signals (mem PSI, mem usage). For
> a cross-domain coordinator the useful step is making memory-domain reclaim
> also respond to non-memory pressure (e.g. shrink offline footprint when
> cpu.pressure rises).

That's a very interesting idea.  I'm not quite sure what would be the expected
result of doing cpu pressure based proactive memory reclamation, though.

> 
> So the honest question, which I think is where this actually meets the
> kernel: is the pattern you'd prefer that an orchestrator just adjust DAMOS
> schemes over sysfs in response to external pressure, or have you thought
> about DAMOS goals accepting non-memory signals (cpu/io PSI, or generic)?

I haven't thought such things.  That's only because I was unable to imagine a
use case that will benefit from that.  If you have some theories and/or data,
please feel free to propose changes.

FYI, DAMOS supports arbitrary 'user_input' for a quota goal.  You will be able
to do some experiments using it.

> I'm asking which side of that line you'd want it on, not pushing either.

No worry.  I prefer DAMON to keep doing random evolution for providing benefits
to the users.  If you have use cases that can benefit from some changes in
DAMON, please don't hesitate at asking questions and proposing changes.

> 
> Thanks for asking for the picture - stating it clarified it for me too.

I'm happy to help :)

[1] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#aim-oriented-feedback-driven-auto-tuning


Thanks,
SJ

[...]
