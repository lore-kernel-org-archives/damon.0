Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A68E571;
	Sat, 24 Jan 2026 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769222891; cv=none; b=V7QqUzvvJ+VMZ/NqIBv33JCG9WEW5OJZK+Zd+4LEjAoul3TlDR8RKKnVhHkGfOKSvP5D5z00IqQqCSqvyZ3uZHYFI+hUZ5KaBSZ1xpC+6AO8Da0QBmnBwdhNk82xxh+Jj63HjA32AyY9OBuuOwLgfr2W6nWEMAHE4Pt5OrRguCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769222891; c=relaxed/simple;
	bh=VzaMqe48iN0XZTX4vhaBuP8tfowR7R/vjCTaWf/n5m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0HB7eDzHEhZBcr2z/Vb1Fri2jnZBlncOmCG/NkdLfNeYxQaQ66uXG65gMu0h+gvhK+rqOOTKuETSSh95STfVP2fEX4jXzdnXQiD9WYORsO9OZPchmaEWQwOVvh5Rer846KRin4jeo7UNrY4qFEowb904IkR57yUnfJ4mbdIqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTNS6NvG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTNS6NvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9B7C4CEF1;
	Sat, 24 Jan 2026 02:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769222891;
	bh=VzaMqe48iN0XZTX4vhaBuP8tfowR7R/vjCTaWf/n5m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTNS6NvGEAGQeTb9Bmwh9QGZp2xLUT1pdCeIEyeocIpnjJrYqpK0FFpmSdTGORVmF
	 IksK+bH+ENec075q163PAfFmQ/FOINkifNTgrlp5NA7KlOZ839YIBSFo3pSP38DzvG
	 Ff6/oUPWAI+ed47YcXgUJ9IVXH66nbi1rwgPJ/Ma79NT3G6QK9mOv3NzAtuLZbe4kI
	 ByfF65eRG699UkyHEdfVebk2DZpKnM0MxP8n8PbbQ91l5MW0mGlRzQzW3zMnL6Fi0r
	 V2kkku7W+DmETCqKV6Hw+SpmRzANiqqob42HEyRCQirkr0yo+tfK5wjTi3kWN3L/id
	 qgfqAOrt6pXqw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Date: Fri, 23 Jan 2026 18:48:03 -0800
Message-ID: <20260124024804.78869-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124023917.78649-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc-ing linux-perf-users@ for any comment from perf people, about the use of
perf event from DAMON.


Thanks,
SJ

On Fri, 23 Jan 2026 18:39:20 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 23 Jan 2026 11:10:10 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 
> > DAMON currently only provides PTE accessed-bit based access check, this
> > patch series adds a new perf event based access check.
> 
> Very interesting patch series.  Thank you for sharing this Akinobu!
> 
> I only took a glance on the patches, but my understanding is that this series
> modifies DAMON to be able to enable perf events of PERF_SAMPLE_ADDR type, and
> utilize the sampled perf events in the perf events buffer as the source of
> DAMON's access checks.  In more detail, I understand enabling PERF_SAMPLE_ADDR
> type perf events makes the perf events buffer filled with memory access event
> information with the access destination address.  The event will be sampled
> based on time (e.g., one access event per X milliseconds).  And probably that
> sample data could include more information includign the CPU and the process
> that executing the sampled access?  Please correct me if I'm wrong and add more
> details I'm missing, as my understanding of perf event is very poor.
> 
> And one quick question.  Can this work on virtual machines?  I'm asking this
> question the for following reason.  I'm actuaally working on a similar project
> that extends DAMON for page fault based access events sampling [1].  The
> project aims to use page fault event rather than other h/w features such as AMD
> IBS or Intel PEBS, because my understanding is that such h/w features are not
> available on virtual machines.
> 
> > 
> > Since perf event-based access checks do not require modifying the PTE
> > accessed-bit for pages representing each damon region, this patch series
> > also includes a feature that allows you to set upper and lower limits on
> > the damon region size to enable access checks with finer granularity.
> 
> I was also thinking about extending DAMON with AMD IBS or Intel PEBS like h/w
> features for this kind of sub-page granularity access monitoring.  So this
> makes sense to me, and sounds useful!
> 
> > 
> > Using these features also requires modifications to damo, but these are
> > not included in this patch series and are currently under development in
> > the following branch:
> > 
> > https://github.com/mita/damo/tree/damo-perf-for-v3.1.0
> > 
> > Any feedback or advice on the patch set would be greatly appreciated.
> > 
> > Akinobu Mita (4):
> >   mm/damon/core: add common code for perf event based access check
> >   mm/damon/vaddr: support perf event based access check
> >   mm/damon/paddr: support perf event based access check
> 
> I find your patches are introducing new infra code for this extension.  It
> seems bit specialized for perf event only, though.  I'm concerned if future
> extension for another access check primitives cannot reuse the infra.
> 
> My DAMON extension project [1] is for page fault based access monitoring, but
> it also introduces a framework for general multiple access sampling primitives.
> I'm wondering if perf event based extension can be implemented using the
> general acces ssampling primitives infra code, and if you already considered
> that but found it is not feasible.
> 
> >   mm/damon: allow user to set min and max size of region
> 
> The min size setup makes sense.  I understand the max size is for disabling the
> regions adjustment (merge/split) mechanism.  IOW, for fixed granularity
> monitoring.  Users can do that by setting min_nr_regions and max_nr_regions
> same [2], though.  So, max size setting seems not really needed.
> 
> Again, great RFC patch series, thank you for sharing!  I'm looking forward to
> your answers to above high level questions and comments.
> 
> > 
> >  .../ABI/testing/sysfs-kernel-mm-damon         |  11 +
> >  include/linux/damon.h                         |  42 +-
> >  mm/damon/core.c                               | 202 ++++-
> >  mm/damon/ops-common.h                         |  39 +
> >  mm/damon/paddr.c                              | 106 ++-
> >  mm/damon/sysfs.c                              | 402 +++++++++-
> >  mm/damon/tests/core-kunit.h                   |   2 +-
> >  mm/damon/tests/sysfs-kunit.h                  |   2 +
> >  mm/damon/tests/vaddr-kunit.h                  |   7 +-
> >  mm/damon/vaddr.c                              | 690 ++++++++++++++++--
> >  10 files changed, 1425 insertions(+), 78 deletions(-)
> > 
> > -- 
> > 2.43.0
> 
> [1] https://lore.kernel.org/damon/20251208062943.68824-1-sj@kernel.org/
> [2] https://origin.kernel.org/doc/html/latest/mm/damon/faq.html#can-i-simply-monitor-page-granularity
> 
> 
> Thanks,
> SJ
> 
