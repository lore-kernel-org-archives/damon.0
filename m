Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792802580;
	b=CHA3JxroNSW//DK3ujLtND9zjw9mSHNnkJRT9OeSIcv2I0q9Id1n6wy2VmeLC/XgWh0E
	 6viw7pm82zDcRxDwm1Zn+mJrDmfAQMJklu2UpszLpwk1aRxl3Zv2VzGNNNMMXjLKCscSZ
	 Z/vNLkUCa7ZmOe0raK2ReBAQhwDKQZZ2CHEN8nzqo7yvaCOyAgwM9/zK4XHsMAPevfkhC
	 IeE0kDB801hIUtMrSJbUnYuWmqGDcTaG2fxaQd3emPzqYAG91zzeoxdygmwoZsXDkq6jT
	 4DkbdyeW6JPI4gBXYE3p5DBxozNcbAD3JFqbV7TjDkzaI+3RKRG/mqyUdw9qJGHkhAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792802580;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=80H2lZ/+xPdhTPazfU9LTQ5TA67GAupaXXZBnmrhJik=;
	b=5B05u6DaBUxdtL6DbpEBIxtriSCG6jBsNz/yemJ4Isa0qetbdkUllyvd7eZwVWWvqIYb
	 G0TktoUU/vTtdWLNimmmqgRWyAQXOrOERRPp97RTSuqA11WbK6wHiIUuiK4xW9lrPM+aS
	 b/ZaqAH4PNjLG5R7TD13/FsqAWmxikbb9aKc5gij1VTZ6VFC8/k76/jdlu3DZoYHlH9B+
	 E1jvwL1+jDqwsAzpgCCVduqbmejIcjJ7+ujB4I2OzPUwFa4/eGgA+1CK5soOkWpMhhZDA
	 CjRY4jAMUTnEMx/RQOeU4DAKMqRuLgzavAM5xDX8kDmB5BO150HLlKVXqI010RmnLLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLNCM00C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB45606A31A;
	Sat, 24 Oct 2026 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLNCM00C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8E31F01825;
	Sat, 24 Oct 2026 00:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792802579;
	bh=80H2lZ/+xPdhTPazfU9LTQ5TA67GAupaXXZBnmrhJik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CLNCM00Cgw3YHxikMpZ2wacAXPGQowY94cvy7BRdu1M5I1GGPmhVpvy+FkBA/VWJ2
	 Qq9hXIMXkNmmDr80GccmDklzMalTR2UTrVHZcqpi38PlXQEoFZtK8AEtmt0IgvkB8D
	 Oy5ahhndGyQbSy3OOcQjRgmZt/z1BypSPvpu4hEy5CHmjyFM1bwXLJdjk7Gd9wTDOi
	 FyMnfBDGLgzRxHPhrSPwh0+Ajuuj7cXyeD47NkOGFeLeMyoYZsLOLwH8gzjsfn7Hs0
	 A7vOD8d/6zLSxDl+fM3AoufwoVAXRoMvY1kIVZgPQ3cOchRv48ZhINyAMDLzZdtAUm
	 dKbVN3IFCTMhA==
From: SJ Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	corbet@lwn.net,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
Date: Fri, 23 Oct 2026 17:42:51 -0700
Message-ID: <20261024004252.87352-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023195122.2481-1-ravis.opensrc@gmail.com>
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

On Fri, 23 Oct 2026 12:51:22 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Hi SJ,
> 
> On Wed, 21 Oct 2026 22:29:12 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Hi Ravi,
> >
> > On Wed, 21 Oct 2026 21:17:24 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
> [...]
> >
> > Thank you for your detailed review and testing of the first design!  I'd still
> > like to try decoding idea first, mainly for quick prototyping.
> 
> Sounds good.  Starting with decode makes sense, especially for VMs
> where hardware address-sampling PMUs are often unavailable; some tips
> for the prototype are in the other reply [1].

Thank you for confirming and the tips!

> 
> [...]
> > > Yes, if the report has an address field with a validity bit and carries
> > > the producing report-type (attr) id.  Then IBS, PEBS, Arm SPE (through
> > > an adapter, since SPE uses the perf AUX buffer) and device-side
> > > monitors all produce the same report, into the same queues and probes.
> >
> > Thank you for confirming.  And yes, I think we can add more (union) fields to
> > the report structure.
> >
> > However, could you further clarify what are the validity bit and attr id, and
> > why those are needed?  I'm still newbie to perf event, please bear in mind with
> > me.
> 
> Neither is perf-specific:
> 
> - Validity bit (or union tag): a way to tell whether a report carries a
>   virtual address, a physical address, or both.  For example, a decoded
>   sample has no physical address if the page is not mapped.  If you use
>   a union with a type field, that already covers it.

Thank you for clarifying.  Yes, it may have a union with a type field.

> 
> - Attr id: an id of the producer (report type) that made the report.  If
>   several producers later feed one queue (e.g. perf sampling and a
>   device-side monitor), a probe can filter on, or weigh, reports by
>   their source.  If each queue only ever has one producer, the queue
>   already identifies it, and the field is not needed.

Thank you for clarifying.  I agree this kind of information will be needed, and
I will make sure it is in the report struct.

> 
> [...]
> > > 4. Binary search over a sorted region snapshot (your todo in
> > >    kdamond_apply_access_report()) beats a linear walk from about 2
> > >    reports per interval for 1,000 regions (a model, to be measured).
> >
> > Yes, this efficient region-report matching would be important.  We could also
> > consider starting with linear walk and later optimize, though.
> 
> Agreed; starting with a linear walk for the prototype is fine, and once
> it is out, happy to measure where binary search starts to matter.

Cool!

> 
> [...]
> > > 5. Samplers can stop silently: in a report on the v4 thread [1], IBS
> [...]
> > Unfortunately my understanding of perf event is not yet good enough to
> > understand this in depth.  I will revisit this after starting implementation.
> 
> Sure.  The one part worth keeping in mind from the start: a sampler can
> stop without any error, so a counter of reports received and dropped
> helps tell "no accesses" from "no samples".

Good point.  I will try to make it at least easy to debug.

> 
> [...]
> > >   - The queue: the per-CPU seqcount design in note 2 (suggested), or
> > >     ftrace's ring buffer with one iterator per reader.
> >
> > My current plan is to use DAMON's original simple lockless and global queue per
> > report queue.  Let me know if the report queue design is not clearly explaining
> > what it would look like, or there is a clear problem.
> 
> A global queue is fine to start with, and the design is clear.  One
> thing to keep in mind: perf writers run in interrupt or NMI context on
> all CPUs at once, and an NMI can arrive in the middle of another write.
> So reserving a slot needs to be lock-free, and a reader should not see
> a half-written report.  If the design already covers that, there is
> nothing to add.

Design is still in progress, but definitely this should be covered.  Thank you
for calling out!

> 
> [...]
> > As soon as this design discussion is completed, I will start prototype
> > implementation and share it as the next RFC version, as soon as possible.  Your
> > review and test of the version will be super helpful.  I may also ask you some
> > questions for perf event and your prototypes.  Thanks in advance for your help.
> >
> > There are competing works, though.  It would take time.  I expect about one
> > month at minimum.  It might take longer; Thanksgiving holidays could be helpful
> > to give me a time to concentrate.  Please bear in mind.  But once the initial
> > prototype is implemented, I believe we could quickly iterate and meet the ETA
> > (LSFMMBPF'27).
> 
> No rush on the timeline; that plan sounds good.  Please feel free to
> ask any time, and I will be happy to share the test programs and review
> and test the prototype when it is out.

Appreciate your continued support, that will be super helpful!

> 
> Thanks,
> Ravi
> 
> [1] https://lore.kernel.org/r/20261023194848.2449-1-ravis.opensrc@gmail.com


Thanks,
SJ
