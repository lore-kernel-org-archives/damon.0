Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52C28540E
	for <damon@lists.linux.dev>; Mon,  4 Aug 2025 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325825; cv=none; b=K+5psqe8OnwBOPEhsQOnoTVASX7jXYf4EUSwxt5PnMiK7ikcMLYZD51qmZWf1tPMKnoJlBy3BZJQ0ZsrFPs3aWteCyciQdr5uUwHePlidBookyCgUSKPWSfl1Mm9wmB3y+1sodNVzKcrl+Nwr/bv4y01uMjv36IDrZvedWXbtug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325825; c=relaxed/simple;
	bh=FA/XdteYSfP+n/TCs3uOgXTmu9ANU7eI846Ruobe5CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2r3S8nzZ3ePQMA79EKfGyLGi0uc+DCcvsNAhGji1GOVP2mhQZeZHp/8vArZykDkmItQq+zgJBpW8wlr4gvraw44UTzGnl1XRUtnMLdEpJtkLqM9HFNjRqAg+0imNL8GSfsD2Mkvq5lq2boWY5FMpaTJfOoOB20R/ocYCUWDMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xnb8mJDr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xnb8mJDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0ADC4CEE7;
	Mon,  4 Aug 2025 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325824;
	bh=FA/XdteYSfP+n/TCs3uOgXTmu9ANU7eI846Ruobe5CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xnb8mJDrPD5Zsp4QXUNMBVg7AvQwhcyha1ijo5SDcgzNIvYKvTV5oKjiIjI78661t
	 uOoMHP6aBP+gNxnpJxPCHPwhug2r0nDaANv7AufU4jUHV1ayScXXeR6KxoC/FKjfKj
	 jdXUgIf/4ciZeFA7UxO4JpSsuzmsu99DPi0zP8MtqB4ISf0xaSWu45Yd8fyktenhJe
	 FG3qgeXglXux2zKd3rCLEMQKwyi1gFsTHG6qZFUQihNWK69vQes4prPTXUCwBbfYot
	 u1cRMtvyq0j0MBKtZzmINBTZhziXfpQuJKKrld7VFPdov1EEU13xVSRvQ0JaTCiiY1
	 sod0ktZYGJ7HQ==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	damon@lists.linux.dev,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH] mm/damon/vaddr: avoid unnecessary migration between target nodes
Date: Mon,  4 Aug 2025 09:43:41 -0700
Message-Id: <20250804164341.55371-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804151929.4613-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon,  4 Aug 2025 10:19:20 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Mon, 4 Aug 2025 21:46:49 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 
> > Hi,
> > 
> > 2025年8月4日(月) 3:01 SeongJae Park <sj@kernel.org>:
> > >
> > > Hello Akinobu,
> > >
> > > On Sun,  3 Aug 2025 22:00:28 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > >
> > > > This change avoids unnecessary migration by checking if the folio to which
> > > > the migration is applied is already located in one of the target nodes.
> > >
> > > Each folio will get a single target node among the target nodes, based on the
> > > weights of targets and the virtual address of the folio.  So skipping the
> > > migration because the folio is on one of target nodes can result in wrong
> > > behavior (not doing required migrations)?
> > >
> > > Also, a similar purpose optimization was already made by Bijan.  I guess you
> > > aware of that and therefore Cc-ed Bijan.  Could you further share differences
> > > between this and Bijan's one, and measured additional performance gain from
> > > this patch, if you have?
> > >
> > > [1] https://lkml.kernel.org/r/20250725163300.4602-1-bijan311@gmail.com
> > 
> > In my current DAMON setup, the target nodes for migrate_hot action
> > are 0-3, and for migrate_cold action, they are 4 and 5.
> > 
> > I'm looking for a way to prevent unnecessary movement between target
> > nodes for each action, making interleaving an optional choice. For
> > instance, I'd like to avoid migrations from node 4 to node 5 during a
> > migrate_cold action.
> 
> Where a folio is placed is based on the virtual address of the folio and
> the folio's offset from the start of the VMA it is in. So, as long as the
> interleave weights and the folio's offset in the VMA are the same, folios
> should not be migrated after being placed. This placement algorithm is the
> same as the one used for mempolicy weighted interleaving.
> 
> It sounds like you are keeping the interleave weights constant, and I would
> imagine that the virtual addresses the folios are mapped to are constant,
> so I'm guessing the start address of some VMAs are changing. I don't think
> I've seen the bahvior your describing in the workloads I've run, but I
> guess it's possible if VMAs are being merged or broken up a lot, such as
> through frequent mmaps/munmaps. Do you think something like this is
> happening in your workload?
> 
> How often are the undesired migrations happening? Every time the scheme is
> applied?
> Also, would you be willing to share how you are configuring DAMON?

I also want to learn more about your setup, use cases, and measured amount of
problem and benefit if you have.

> 
> > I've observed a difference in behavior compared to Bijan's patch, and
> > it seems there's a need for both approaches. Would it be possible to
> > introduce a new option that allows us to specify whether interleaving
> > is forced or optional, and then adjust the behavior based on that
> > setting?

We can add options if it is promising.  I have no good idea about if this is
promising or not for now.  It would be helpful if you could share more details
about your use cases and measurements.

> 
> I wonder if this would be better handled as a paddr scheme. That way
> you can configure the schemes such that only physical addresses in nodes
> 4-5 will migrate pages to nodes 0-3, and only physical address in nodes 0-3
> will migrate to nodes 4-5.

Agreed.  If Akinobu's use case is not depend on virtual address space, I think
paddr is a feasible direction to go.  Note that 'paddr' doesn't support
multiple destination nodes for now, so development of that would be needed if
we decide to go in this way.  But, again, I'd love to learn more about
Akinobu's use case and the problem first.


Thanks,
SJ

[...]
