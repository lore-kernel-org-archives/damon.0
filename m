Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A0C1A239A;
	Tue, 21 Jul 2026 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784596098; cv=none; b=kWWs2IWyinB6Rd5YTHduRmaROA7TyCcNe6Qny9SWE7omwfaPyloc1J+Bm0VrKkzmWAqaMdOmltHSaNfKF+56gRwkcKfoa/shIdWPm2iJFrwFT2heX77DeKecn/8MNpo8rWRTdXIvgUM6T4NioTHD9Z+HFJSVx1ybhkP5KXV9d6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784596098; c=relaxed/simple;
	bh=OyR+z+whxklo3OIQKw2/WxsKsOwpCZiSzGP1NVoWRYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cg84Mf3n9RfvXx7fFB4oenAn4oLGMBavSqdzq/l5wWuE9BarS3eZlXtkHGMDOVofKOXSk44t9bGWoOQqP9HHaCUFdbIRt/PG2CjjihIw00VwlTgRNaZHKeod/69IcYPPk6+dpJ+gSumxPcznpbTz0mfWgg0s0EaWS9kuKVS1wsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1NNnxX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1NNnxX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1A51F000E9;
	Tue, 21 Jul 2026 01:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784596097;
	bh=iPEDa4y7YnsA2DDrvJuGMFg2pO2MLhdYW/8sh9nMWJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1NNnxX3MNIsRMp9h2f/ABJG909Ow/nvUnsD0tLSYs3Ys3DsVuIEyb2CfvEQ8/Qf9
	 RdKg+Yr1domo41jagvZyZv+mQJgE2yoGx5M/z2j+py6spDZa0PTp7GOvyGcrAJsyry
	 tgxurD/LqwM6fdWZ9LFbFEE2mlDeKHo6fg4IWzLnqPWp3jSldd4L+N2xPAHDSpHAaM
	 MJCOYun6XBmj1zcoIPsCtj2sYrh5mCjZkGlyc/Xw24f7QeQ0gK0zEmlC1WHDH4bTpT
	 xjzxgEoRQDm9kzqX6hcIXizxuK//2wV4MHAdleIa51Nm46CFqU4kcKqx2glJfQpk+q
	 CeqmG4UbOIm9w==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	daichaobing@sangfor.com.cn,
	wangkefeng.wang@huawei.com,
	gutierrez.asier@huawei-partners.com,
	zengheng4@huawei.com,
	kasong@tencent.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lianux.wang@processmission.com,
	kunwu.chan@linux.dev
Subject: Re: [RFC PATCH v3 0/3] mm/damon: introduce DAMOS_SPLIT action
Date: Mon, 20 Jul 2026 18:08:12 -0700
Message-ID: <20260721010813.94016-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720030327.80153-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You were warned at not Cc-ing THP developers in the previous revision, since it
was modifying THP source code.  Since this version is modifying only DAMON
source code, you don't really need to Cc more than DAMON developers.  Asking
wider inputs is good practice.  And it worked very well.  We got great inputs
from Asier, David and Zi.  But some people don't really like having too much
mails in their inbox.  My personal rule of thumb is just running
get_maintainer.pl via 'hkml patch format' [1].  You must have your own rule,
though :)

On Mon, 20 Jul 2026 11:03:24 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> DAMOS_SPLIT splits large folios in a target region down to a
> configured target order, using the existing split_folio_to_order().
> No new core-mm code or exported symbols are introduced.

The last sentence may better to go to changelog.  If you want to highlight, you
can put changelog at the top of the cover letter.

> 
> Based on mm-unstable at 61cccb8363fc ("mm/swap, PM: hibernate:
> atomically replace hibernation pin").

This is also not feasible to be the cover letter main content.

> 
> Different addresses within a PMD-mapped folio resolve to the same
> PMD Accessed bit.  Accesses to a small part of the folio can
> therefore coarsen DAMON's observed hot set relative to the actual
> working set.
> 
> DAMOS already provides promotion actions (HUGEPAGE, COLLAPSE) but
> has no corresponding demotion action.  DAMOS_SPLIT fills this gap.
> It is a mechanism, not a policy -- it does not decide which folios
> to split.  Selection is left to DAMON's existing access patterns,
> filters, and future probe/PMU signals.

As I commented to the previous version [2], this sounds like you are saying two
very different things.  Monitoring quality degradation issue and better THP
handling of DAMOS.  This makes understanding the motivation of this series
difficult, as other people also pointed out.

Based on your replies to others, now I understand you are proposing DAMOS_SPLIT
as a way for improving the monitoring results.  I'm waiting for your more
clarification of the issue, to better assess if this makes sense or not, as I
commented on the reply to Zi's reply.

> 
> target_order selects the split target: 0 for order-0 base pages,
> or a supported smaller mTHP order.  Both anonymous and file-backed
> folios are supported.  The locking follows split_huge_pages_in_pid()
> in mm/huge_memory.c.
> 
> Tests
> =====
> 
> damos_split.py (VM + Kunpeng 920):
>   anon THP -> order-0 split: PASS
> 
> sangfor_exp.py (Kunpeng 920, tmpfs, 4096 MiB):
> 
>   - Created a 4 GiB PMD-mapped tmpfs workload.
>   - Applied DAMOS_SPLIT with target_order=0.
>   - ShmemPmdMapped dropped from 4194304 KiB to 0 in every round.
>   - Repeated for five rounds without functional failures.
> 
> The functional selftest (damos_split.py) is included in this series.
> Additional experiment scripts and raw results are available on
> request.  Performance characterization using masim [1] and KMB [2]
> is in progress.

It is completely fine to keep having tests in progress.  But, please make the
story complete.  What damos_split.py and sangfor_exp.py do?  What the results
mean?  What the performance tests will do with what expectation?

> 
> [1] https://github.com/sjp38/masim
> [2] https://gitee.com/OpenCloudOS/kernel-multi-bench
> 
> Open questions
> ==============
> 
> - Selection policy: this series keeps folio selection outside the
>   action and relies on DAMOS access patterns, filters, and quotas.
>   Is this the appropriate layering for future probe-based signals?

You mentioned this series is for monitoring quality improvement.  If so,
shouldn't you just apply it to all THPs, regardless of the access pattern?  I'm
again being confused.  More clarification of the motivation would be useful.

> 
> - Hysteresis: khugepaged may re-collapse a just-split folio.
>   Should cooldown live in DAMON policy or khugepaged?

Ditto.

> 
> - File-backed folios: adjust target_order upward to filesystem
>   minimum, or keep current "fail and skip"?

I don't fully understand the question.  Could you please elaborate more?

> 
> Beyond the action API itself, feedback on real workloads that need
> proactive large-folio demotion is particularly welcome.  Follow-up
> work will evaluate candidate selection signals, including DAMON
> probes and hardware-assisted sampling, as well as target-order
> selection and split/collapse hysteresis.  Those policies are
> intentionally kept outside this series.

You mentioned this work is for monitoring quality improvement.  Now you are
saying somewhat followup.  I'm again being confused.

> 
> Changes since v2 [3]
> ====================
> 
> - Split-only series (collapse deferred).
> - Dropped SPE feedback (mechanism/policy separation).
> - DAMOS_MTHP_SPLIT -> DAMOS_SPLIT.
> - order field in existing union (no struct size increase).
> - Added functional selftest (damos_split.py).
> - checkpatch: 0 errors, 0 warnings.
> 
> [3] https://lore.kernel.org/20260701123000.00000-1-lianux.mm@gmail.com/
> 
> Lian Wang (Processmission) (3):
>   mm/damon: introduce DAMOS_SPLIT action
>   mm/damon/vaddr: implement DAMOS_SPLIT handler
>   selftests/damon: add functional test for DAMOS_SPLIT
> 
>  .../ABI/testing/sysfs-kernel-mm-damon         |  7 ++
>  Documentation/mm/damon/design.rst             |  5 +
>  include/linux/damon.h                         | 15 ++-
>  mm/damon/core.c                               |  2 +
>  mm/damon/sysfs-schemes.c                      | 48 +++++++
>  mm/damon/vaddr.c                              | 90 +++++++++++++
>  tools/testing/selftests/damon/Makefile        |  1 +
>  tools/testing/selftests/damon/_damon_sysfs.py |  9 +-
>  tools/testing/selftests/damon/damos_split.py  | 99 +++++++++++++++
>  tools/testing/selftests/damon/sysfs.py        | 11 +-
>  10 files changed, 279 insertions(+), 8 deletions(-)

[1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#formatting-patches
[2] https://lore.kernel.org/20260702183551.91007-1-sj@kernel.org


Thanks,
SJ
