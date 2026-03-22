Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197C40DFC5;
	Sun, 22 Mar 2026 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774218534; cv=none; b=hcm99KN41iynx8RyNzGcIXVUcWCa26ElBpHyGIOuZ+A5APCAFxgmDI/F/wG6C8Tpura4f6iirqgKb527Z1LlG75Barnj4R941bUbR41lX85Amx50M2j5KmPxBxwoJH+kxftSEgXC8rD1snWcarroqh3Kyd1/17ULi8ZmoBRn090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774218534; c=relaxed/simple;
	bh=kzW9ex6Pn6zhGRYRBf0VzvojUC0+Ma6yBVZIRqEFZgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf0MHXdOtFO1uJX1nmhRAMrLyqT17y0SkM6jAn05fCpfcF0k/nsXoDaxeJvxFYcw5JpRg2WFDbqIHC1b3L0vIbevGccIhpAGy5kBLklv1CgmolyQi9Y6q+qeqt62pmwWLq+qWK7EvmZFogCsbWHKQYfDdgEmX3SthpRETI/70dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6n5jTaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6n5jTaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F152C19424;
	Sun, 22 Mar 2026 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774218534;
	bh=kzW9ex6Pn6zhGRYRBf0VzvojUC0+Ma6yBVZIRqEFZgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6n5jTafHSgCE/WZyy9MLx2HnUUkhFROw6fw3aG4gXqsajLr9q14Oz1zvL+bwDdWX
	 cTFzWywbkrHGXuwKGCq9rlxskr5ZZ0Uw4r4Nm/TBmvfpPqNFCTTuC7pFVk5uSAzp3A
	 Opcdadiyw271v1LSD8WETHlUd8wZZuc8ZuAlQT7pUs4qhpjaTmT5FMqxMdr0QYemDt
	 AZ7ZtLeRp3NuC9RvCHFlgK00WQPvKV4yyr3M1V9QjYpMpOd5sRGsSaTebAj7K1TgOu
	 l0Q8v8aw6Dzh5zLvRPAjjXm74eaZ/93jlv6GQoCP/SGTB5XPtgdeElQS2ZUkLvA1TN
	 aWZuaEp8pLpgw==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: optimize kdamond_ap =?US-ASCII?Q?ply=5Fschemes=28=29_by_inverting_scheme_and_region_loops?=
Date: Sun, 22 Mar 2026 15:28:44 -0700
Message-ID: <20260322222845.89757-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <C9B59023-161D-405F-8941-1B0E0B8E1D6B@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 21:59:45 +0000 Josh Law <objecting@objecting.org> wrote:

> 
> 
> On 22 March 2026 21:44:18 GMT, SeongJae Park <sj@kernel.org> wrote:
> >Hello Josh,
> >
> >On Sun, 22 Mar 2026 18:46:40 +0000 Josh Law <objecting@objecting.org> wrote:
> >
> >> Currently, kdamond_apply_schemes() iterates over all targets, then over all
> >> regions, and finally calls damon_do_apply_schemes() which iterates over
> >> all schemes. This nested structure causes scheme-level invariants (such as
> >> time intervals, activation status, and quota limits) to be evaluated inside
> >> the innermost loop for every single region.
> >> 
> >> If a scheme is inactive, has not reached its apply interval, or has already
> >> fulfilled its quota (quota->charged_sz >= quota->esz), the kernel still
> >> needlessly iterates through thousands of regions only to repeatedly
> >> evaluate these same scheme-level conditions and continue.
> >> 
> >> This patch inlines damon_do_apply_schemes() into kdamond_apply_schemes()
> >> and inverts the loop ordering. It now iterates over schemes on the outside,
> >> and targets/regions on the inside.
> >> 
> >> This allows the code to evaluate scheme-level limits once per scheme.
> >> If a scheme's quota is met or it is inactive, we completely bypass the
> >> O(Targets * Regions) inner loop for that scheme. This drastically reduces
> >> unnecessary branching, cache thrashing, and CPU overhead in the kdamond
> >> hot path.
> >
> >That makes sense in high level.  But, this will make a kind of behavioral
> >difference that could be user-visible.  I am failing at finding a clear use
> >case that really depends on the old behavior.  But, still it feels like not a
> >small change to me.
> >
> >So, I'd like to be conservative to this change, unless there are good evidences
> >showing very clear and impactful real world benefits.  Can you share such
> >evidences if you have?
> >
> >
> >Thanks,
> >SJ
> >
> >[...]
> 
> 
> My last email:
> 
> Hi SeongJae,
> 
> I've looked into this further and ran some extra benchmarks on the kdamond hot path to see if the gains were actually meaningful.
> 
> The main issue right now is that kdamond spends a lot of time "spinning" through regions even when there's no work to do. For example, if a user has 10,000 regions and a few schemes that have already hit their quotas or are disabled by watermarks, the current code still iterates through every single region just to check those same flags 10,000 times.
> 
> In my tests:
> 
> Typical setup (10 schemes, 2k regions): ~3.4x faster.
> 
> Large scale (10k regions, hitting quotas): ~7x faster.
> 
> Idle schemes (watermarks off): ~7x faster.

Thank you for sharing these.  This seems like not a real world workload test
but some micro-benchmarks for only the code path, though.

In real world DAMOS usages, I think most of time will be spent on applying
DAMOS action.  Compared to that, I think the time spent for the unnecessary
iteration will be quite small.

> 
> 
> It's also a cache locality win. Right now the CPU has to bounce between different scheme metadata inside the innermost loop for every region. Inverting the loops lets us process one scheme completely, which keeps the hot data in L1/L2 and gives about a 10% gain even when everything is active.
> 
> The goal isn't just to shave cycles, but to make DAMON scale better on high-memory systems (512GB+) where the region count is high. This keeps the background "CPU floor" much lower when DAMON is supposed to be idle or throttled.

DAMON does adaptive regions adjustment for such large memory system
scalability.  I understand some users might dislike the adaptive mechanism and
stick to a fixed granular monitoring, though.

So I'm not yet convinced to this change as is.

Meanwhile, I'm thinking about a way to make similar optimization without
changing the behavior.

We already have the first loop of kdamond_apply_schemes() to minimize some of
the inefficiency that this patch is aiming to optimize out.  Maybe we can
further optimize the first loop.  For example, modifying the first loop to
build a list or array that contains schemes that passed the next_apply_sis and
wmarks.activated test, and make damon_do_apply_schemes() to use the test-passed
schemes instead of the all schemes in the context.

This will keep the behavior but have a performance gain that similar to what
this patch is aiming to.  If this can be done with a fairly simple way that can
justify the maintenance burden, I think that's a way path forward.  But, from
this point, I realize I want it to be *very* simple, and I have no idea about
the simple way.

So I wanted to help making this be merged.  But I fail at finding a good path
forward on my own.

In my humble and frank opinion, finding other place to work on insted of this
specific code path optimization might be a better use of the time.


Thanks,
SJ

[...]
