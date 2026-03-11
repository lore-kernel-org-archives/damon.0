Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1031DD877;
	Wed, 11 Mar 2026 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190301; cv=none; b=gdubz78O4BHW6RVqTNBH0mP/wwWar6ukyIWSZVTqEVbPQP4Pt/vy/l2s/d2/lN2sJjKe66q5Oh4L0afkYCcJUzenudzugBkT/13a68iYEQNnasjVgy+dTsyKiUpReYRnrRP4Gs+MarwAoZlU4vE/J65nNCvWwoOdZvbtYe2fHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190301; c=relaxed/simple;
	bh=cDxvgkx6tl3e7lZvIv3KCaXNgG249qNutfn/S+qhgFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvQl8F22JUaaUqg7c4tbXbRxwufQxf+XM7KO+8VTf2+1coEzjvlwYt9Dn5yPGu5+sLIQEqIB4GutHPq6ywR+i/M3pNQRM2TDu90l5NJE+haUCdmhKxvbhgs2GAkMf6GLGo0GSrrOOyqr2VAe23vC8TgLikNMX4LtzJKnofzppFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quHwNFcj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quHwNFcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF20C19423;
	Wed, 11 Mar 2026 00:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773190300;
	bh=cDxvgkx6tl3e7lZvIv3KCaXNgG249qNutfn/S+qhgFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quHwNFcjm9RQ3g3rqorYfmuFz2SZ6W4bnE4NqkAYUDvCrdmNYDEzRS0hVcLXRUEXp
	 zbCWwRFrRzxwTeTWLfCCji263N50vlYkCQgBSQzrDPOaz7BdQhSxrzL8W9TqZRueWF
	 XaGRFqTo6P7wScMPP/HYWiCWLxjVg88srGOOYGlipyHii0wxzr0opvrXh1lxf+n3m2
	 6nroMV5gxSYeBhecXxnqM2MS37zE62oJqFDUhobcepYMBq+RdrYlFqpW668kwO5vAg
	 yu+CkbRsjCvOHVPk9jUtzEmBz+cBZjwY26SeYTOsM3p0nu5qiXtiTTk3e/gyLRT+8F
	 ab2iaqmOWwEow==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/6] mm/damon: introduce perf event based access check
Date: Tue, 10 Mar 2026 17:51:31 -0700
Message-ID: <20260311005132.90285-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309010009.11639-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  9 Mar 2026 10:00:03 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> DAMON currently only provides PTE accessed-bit based access check, this
> patch series adds a new perf event based access check.
> 
> Since perf event-based access checks do not require modifying the PTE
> accessed-bit for pages representing each damon region, it reduces the
> overhead of monitoring at a fixed granularity of the page size.

Based on my understanding of this patch sereis that I was enlightened from the
conversation with you on the RFC v1 and kind comments from perf community, I
agree to the points of this patch series.  Extending DAMON with h/w features
like AMD IBS and Intel PEBS is what multiple people shown interests.  I believe
it can benefit multiple users.

I hope this work to be continued until it is landed on the mainline, and I will
be happy to help.  Probably not exactly in the current shape, though.  I think
this is still in an early stage.  And for the reason, I will comment on only
high level things here, rather than diving deep into each patch.

> Furthermore, this patch series also includes a feature that allows you
> to set a minimum region size for each target, enabling you to monitor
> at any fixed size greater than the page size for each target.

I'm not very sure if this is really required to be a part of this series.  Can
you further share more details about what is the benefit of this feeature, and
if it should be coupled with this patch series?  It would be great if you can
share some test results proving the arguments.

If this is really beneficial but there is no reason to couple with this series,
I think merging this separately first or later could also be an option.

> 
> Using these features also requires modifications to damo, but these are
> not included in this patch series and are currently under development in
> the following branch:
> 
> * https://github.com/mita/damo/tree/damo-perf-for-v3.1.8

Sounds good.  No rush, but also feel free to send patches or PRs for this.  It
is common to support DAMON features on DAMON user-space tool even before the
DAMON features are merged into the mainline.

> 
> Any feedback or advice on the patch set would be greatly appreciated.
> 
> * v2

Let's keep using "RFC" here.

> - reintroduce damon_operations->cleanup()
> - introduce struct damon_access_report
> - use struct damon_access_report instead of introducing struct
>   damon_perf_record

Thank you for doing this.  I hope using not only the struct but the underlying
infrastructure, though.  Let me comment this more detail below.

> - remove maximum region size setting
> 
> * v1

Ditto.  Let's keep using "RFC".

> - https://lore.kernel.org/damon/20260123021014.26915-1-akinobu.mita@gmail.com/T/

Thank you for sharing the link.  This is helpful for me at reviewing.

> 
> * TODO
> - Currently, it is possible to unintentionally specify a perf_event
>   that cannot obtain either PERF_SAMPLE_ADDR or PERF_SAMPLE_PHYS_ADDR
> - Check if it works in a virtual environment using vPMU

The above two TODOs make sense to me.

I'd like to request below things as main TODOs.

First, I hope the benefit of this change is described in more detail.  The
current description mentions it is more lightweight since it doesn't need to
update the accessed bit.  But, PMU-based monitoring should also have its own
additional work.  It would be nice if you can describe what additional works
for PMU-based monitoring induce, and why it is generally lower than that of
access bit modification.

Having a more clear motivation, or expected use case would be nice.  You don't
neeed to share real details of your use case.  You can anonymize sensitive
things if needed.  But giving a reasonable and realistic use case will be nice
to understand where this can really be beneficial.

Sharing a test results showing the benefit will also be very nice.  It doesn't
need to be huge real world test, but some reasonable amount of data that
collected on a realistic test setup could be very helpful.

Second, I hope this patch series to reuse the DAMON primitives extension
infrastructure if possible, to reduce possible future duplications.  I'll add
more details about this below.

> 
> Akinobu Mita (6):
>   mm/damon: reintroduce damon_operations->cleanup()

Thank you for doing this :)

>   mm/damon/core: introduce struct damon_access_report

Again, thank you for doing this.  I understand this is an answer to my previous
question to the RFC v1 of this series.  I was asking if you considered the
infrastructure part of my page faults based DAMON extension series, and you
borrowed the main data structure of the series here.  But, I hope us to reuse
more of the code, since it is more generic from my point of view.

>   mm/damon/core: add common code for perf event based access check

This patch is introducing a few of sysfs files under DAMON sysfs context
directory, namely 'perf_events/' and its underlying files.  The files is for
registering perf events for the access monitoring.  I don't dislike the basic
concept, but concerned if it is too specific for only perf events and therefore
cannot be easily extended in future.

The faults-based DAMON extension patch series [1] implements files for similar
but more general concept.  It defines a concept called sampling primitives.  It
is the low level primitives for access check.  It could be access bit checking,
page fault event, or something new, like perf events.  It adds
monitoring_attrs/sample/primitives/ sysfs directory, which can be used for
selecting what primitives the user wants to use.  I think perf events can be
defined as another access check primitive, and the sysfs files can be added
under here.

I was also bit concerned at the fact that the filees are effectively exposing
perf_event_attr struct.  That is, I was concerning about stability of the
struct.  I now see it is a part of linux user api, so I assume it is a stable
api.  Could you please confirm this?  Also, adding more clarification about
that fact on the patch would be nice.

>   mm/damon/vaddr: support perf event based access check
>   mm/damon/paddr: support perf event based access check

My understanding of the above two patches is like below.

1. The perf event samples are added to a circular buffer whenever it is
   generated.
2. At the end of each sampling interval, the ops reads each sample in the
   buffer, find a matching DAMON region for the sample, and updte the
   'nr_accesses' of the region.

For this, this patch series implements the circular buffer for storing samples,
and xarrays for finding the matching DAMON region for a given sample.

The page fault based DAMON extension patch series is doing something similar.
The first patch of the series implements the buffer for storing access samples.
I think the perf event samples can be stored here.

The seventh patch of the series implements the logic for finding the matching
DAMON region for each of the samples in the samples buffer, and update the
'nr_accesses' of the DAMON region.

Because the page fault based extension's infrastructure is quite general for
any future types of the primitives, I think it would be nice to reuse it.

The infrastructure is quite simple and not optimized for performance.  But
optimizations can be made later.  I'm more interested in the long term
maintenance of the interface.  And I think the page fault based extension's
infrastructure is easier for long term maintenance.  Of course I might be
biased.  Please let me know what you think.

If it helps and if you don't mind, maybe I can try to implement this series on
the page fault based infrastructure and share it as another RFC patch series.

>   mm/damon: allow user to set min size of region

As I mentioned abovely, I'm not sure if this is really need to be coupled with
this entire series.

> 
>  .../ABI/testing/sysfs-kernel-mm-damon         |  10 +
>  include/linux/damon.h                         |  63 ++
>  mm/damon/core.c                               |  77 ++-
>  mm/damon/ops-common.h                         |  39 ++
>  mm/damon/paddr.c                              | 105 ++-
>  mm/damon/sysfs-common.c                       |  11 +
>  mm/damon/sysfs-common.h                       |   1 +
>  mm/damon/sysfs.c                              | 399 ++++++++++-
>  mm/damon/tests/sysfs-kunit.h                  |   2 +
>  mm/damon/tests/vaddr-kunit.h                  |   5 +-
>  mm/damon/vaddr.c                              | 654 +++++++++++++++++-
>  11 files changed, 1332 insertions(+), 34 deletions(-)
> 
> -- 
> 2.43.0

[1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org/


Thanks,
SJ
