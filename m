Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED435F5FB;
	Wed,  2 Sep 2026 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788326950; cv=none; b=IZCLxdrApBGUOohkOU/LldwUE787p3QlWoJWHLwTmeBtPTFqB+Yr0fwvUNj7q+fFoB/RPfq9wp6HEvBW14aAiix6J4NBRU5M3gdHy7M5e1Os/ze+RkzaU0D+O6R5mX4eUHiKSoyLHRlM3l6ClLm4LV1QoY1F2cTDvhSk76rQzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788326950; c=relaxed/simple;
	bh=7sfVLE/G81E2E/EhfntbMp2x3qX74OM9v6qrzXfwA8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4byXOHeSK0Y0TVEyG3L//RuXYnHWXumPzZOU/lEQhHIn5tSQUOo+Rv647yCEbyml0ampTlgzWRrRhjEwXaO/eBOc4R/OucimeN+fYSA9ztNHGNEaT5KeohfN7HFs0/00tV8ILI3vV2/PuOgexvUsPpQ1VmzbPB05yyFuUr4D+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/dOHZYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/dOHZYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C871F000E9;
	Wed,  2 Sep 2026 05:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788326949;
	bh=PbloG71Ug3SvdXr7VKnegfG6pXruTE4fT8uwaWdzeco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f/dOHZYrveo4S+nfA1TZXALfefOYlXQGFcxB7Qp4/Zk9IrcG7a6Aq0u9G8h2btvPu
	 I0QuHwo16oZk0XPRDbauasteyo/2gRPLqnYsLjxl0IYEcXANwBcVK2Mm1KpRSYytyU
	 wyRpn5RDeUZXHkZy/k+vFAn1OnZfVTwX1PnCo9Y7F+0ANC4+AurINfu+Ea0rdKL9m4
	 dJ8ADD6XpkKksoyDslfPV9H4yrphc0pF1COFe+8iQ4E95R6oKyoSp+nUthWR+92STj
	 Zb82PyOooHKUJh7RNb/fEG6Ue7NCvqqVuj0whKowcvBoP3AbGSfamDaQqpeOT6qOP4
	 NsapQ8/B74tsg==
From: SJ Park <sj@kernel.org>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mm/damon: support access monitoring of hugetlb-backed memory
Date: Tue,  1 Sep 2026 22:29:01 -0700
Message-ID: <20260902052902.93608-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902025700.17975-1-kiyer@crusoe.ai>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 19:56:57 -0700 Krishna Iyer <kiyer@crusoe.ai> wrote:

> On virtualization hosts, most system memory is often backed by
> hugetlbfs.  On our production hosts, for example, ~95% of RAM is 1 GiB
> hugetlb pages backing guest memory.  DAMON's physical address space
> monitoring is blind to such memory: every access check starts at
> damon_get_folio(), which rejects folios that are not on the LRU lists,
> and hugetlb folios are managed outside of the LRU by design.  As a
> result, all hugetlb-backed memory is silently reported as never
> accessed.  In testing on a 1 TiB host, an hour of 4-thread random
> access over 842 GiB inside a guest was statistically indistinguishable
> from an idle host.
> 
> The first patch moves damon_hugetlb_mkold() from vaddr to ops-common
> as a preparation.  The second patch teaches the folio mkold/young rmap
> walkers to handle hugetlb folios, aging the huge PTE and notifying
> secondary MMUs across the whole huge page size; the secondary MMU
> notification is what surfaces guest-side (e.g., KVM/EPT) accessed
> bits.  The third patch adds damon_get_monitor_folio() and uses it from
> the paddr monitoring primitives only.  DAMOS action appliers such as
> DAMON_RECLAIM and DAMON_LRU_SORT keep the LRU-only lookup and are
> behaviorally unchanged.
> 
> This series is the first half of an earlier six-patch series [1],
> split out as SJ suggested [2].  The second half (the 'aging_flush'
> TLB-flush-assisted aging) is deferred: we will gather more
> quantitative data on the gap it addresses, including the workload-side
> impact of the flushes and the working set measurement details SJ asked
> about, and post it separately once the data is in hand, aligned with
> the ongoing monitoring preparation actions work.
> 
> Per Documentation/process/generated-content.rst, this series was
> developed with the assistance of an AI coding assistant (Anthropic
> Claude, via Claude Code).  The assistant helped draft the code and
> changelogs, and applied the v1 review feedback.  All changes were
> reviewed by the human submitter, who takes full responsibility for the
> contribution.
> 
> The series as posted here was regression-tested on its base commit
> with a full x86_64 kernel build (no W=1 warnings in mm/damon), the
> DAMON kunit suite (41/41 passing) and the DAMON selftests (15/15
> passing) on a kernel booted with virtme-ng.

Looks good to me, thank you for this series Krishna!

With the comment modification I commented to the patch 3, I applied this series
to damon/next [1] tree.  Unless you raise other opinions or Andrew picks this
into mm.git with the comment modification, I will repost the version in my tree
as the next version of this series with the comment modification soon (up to ~1
week later).  If you have a different opinion for the comment modification, it
seems I forgot doing that or you cannot wait for my action, please feel free to
let me know or post the next version on your own.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
