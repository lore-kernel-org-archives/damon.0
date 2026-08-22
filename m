Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7735950;
	Sat, 22 Aug 2026 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787358767; cv=none; b=LZShht55A0zx0sB0fJVbz49Y1OcCXUdonqYWHJTaSz38uOx01VoTKpOYL/mEIixwGtIAt28GdwdSYJZdj4u5Wl8Wk5/wkwtH9AKk9IDfNR76r3njCX2/6VR2IvUETH+nACCVGj8Ohnc3cJbR0EbPqvzrQcLFV2nrKVgqKuT0lw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787358767; c=relaxed/simple;
	bh=9pkU+BuXeoIuReTVx+dAo7FCqMQN9AyiLwimjifQXvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNy1ue1A9SBN+OnN1aiwmDJJaNTZBcMDhF7xCwdkyhS8BSwG0ewtfcVUpGfJOh04ReQcyTKsbBcmZcwaZotxlr9/wpdYS0h5i81Ucm+DquivDEtrDt/SMkijWwl5BIzJV+5A9wJgs3EosHVTCugfQr0B+6F43Pb2paHClfK2IBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsXNAyVw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsXNAyVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952F41F000E9;
	Sat, 22 Aug 2026 00:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787358766;
	bh=oTtbBAC/D/yVNs4AHZW7PqQ57npjfBk80DwpOFSGqOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VsXNAyVwCKVC8F3brKcjy2i0Q3Se1u9PLt8EMAuTPn4JyXMDXYdGOTYb4gOlC4QJW
	 hQ82+4E1eNEI2N2AXhljGYLhVXrAWP4MvG1nSl2nE4ACjjh97QVWZX2yk8Ig9csXd9
	 rqxRGlPy2yLut+EaIj/onPLhEw2F499Lj1i2s+fFIBd2bV4Cb5KXAjAgKcfXVwaGvH
	 WL2zTB1FcKCvo9uypuHEVsYMwRPotzrVeYUhmWcLfL2alnUa0FEZP0sT3Nq8pGoE1C
	 j7FncxtWhdfFvH9In36DhAXVEBSq/Y7Z6/7qmqXgaC6rol3x4E6yo1GNPRMboAI4PP
	 uVna5eMSOHB4Q==
From: SJ Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	KunWu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
Date: Fri, 21 Aug 2026 17:32:35 -0700
Message-ID: <20260822003237.88274-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y15zNhpubyH5GQgu_BHesrwRdH0B8k5cqT3o_U0h5A2e-w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 21 Aug 2026 09:32:02 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Fri, Aug 21, 2026 at 2:55 AM KunWu Chan <kunwu.chan@gmail.com> wrote:
> >
> > Hi Ravi,
> >
> > Thanks for the detailed reply.  The fan-in diagnosis makes perfect sense.
> >
> > > Your series is based on the v1 substrate, and the way an event is
> > > configured is the part that moves most.
> > >
> > > [...]
> >
> > Glad to hear v2 is on the way.  The probe-based model is actually
> > something I encountered while building the AUX backend. When multiple
> > sources can feed the same region (e.g. PTE scanning + SPE/IBS), the
> > question of how to combine their reports becomes interesting.
> >
> > For example, CXL tiering may care about physical-address locality, while
> > per-process monitoring may need virtual-address attribution.  How do you
> > see probe weights being determined — is that expected to be
> > scenario-specific, or is there a more general principle behind the
> > weighting?
> 
> Hello KunWu,
> 
> SJ can answer that authoritatively -- the probe and weight interface
> is his. Here is my understanding which SJ can confirm later:
> 
> Weights are relative, and only among probes. A context can hold up to four;
> each report carries its probe index and credits that probe's own hit count,
> so two PMU-based probes in one context are scored in proportion to their
> weights, and that is where a scenario-specific choice belongs.
> 
> What does not mix is a weighted probe with the other two sources. Any
> nonzero weight switches the whole context to probe-weighted scoring, which
> turns page-table access checking off -- so SPE cannot be blended with PTE
> scanning, it replaces it. Page-fault reports carry no probe index; they
> credit the region's access rate but have no hit count, so under weighted
> scoring they are not part of the score either. Both coexist with a probe
> only at weight zero, where everything feeds the same access rate and is
> indistinguishable afterwards.
> 
> So for your case I would read it as: PA locality and VA attribution are
> different targets and different address kinds, which points at separate
> contexts rather than one context with tuned weights.

Thank you for detailed response, Ravi.  Ravi is correct.  Physical address and
virtual addresses wouldn't be able to be monitored with a single DAMON context.
The user may need to have a DAMON context for physical address space, and
another DAMON context for virtual address spaces.


Thanks,
SJ

[...]
