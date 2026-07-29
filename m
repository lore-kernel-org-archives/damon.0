Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AEF42DA56;
	Wed, 29 Jul 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334958; cv=none; b=GliLoow0dPjbEcsdBBHmQLY1TVJetidNcootUYd4xfU/1qqLn4x51X88OqIFj0yvsVcchmUbUTPBmRb7yrWogm7r9Rei6m6OPsjMWY0UAafqNnWLWycsi4wKBjr2OYlfEP4M95kbjhzreYMYXmRUeaw7envzCFGatQne7oc0C7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334958; c=relaxed/simple;
	bh=GhxjkALf+9Tnjn5zSgFkl1bcMv6i0KNMwvRliFv/xrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iot9lMHGhFgZnw074DMjTNiwUFslKqk8VVO7ziVMzlBkKjzo64JK/4+Rpqk4z2ZOpezmV97/wTVHc42GfxK8IY0lSH7H2naXFbXZrBFiSG74dgO+Mft4Ma0EIs61OiQaa52SH80RAHjUMpNZkAlp3liMnBTUsJpsD9MYB2v7eLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFbRzWFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFbRzWFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CFC1F000E9;
	Wed, 29 Jul 2026 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785334956;
	bh=z8xkxqpsIVSsEuxMP/4DdUH4R6W+2G5DTJRYXvza3Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MFbRzWFnbb5hxbpVRoxQ8dn2ZJ4msskGmYyx7jPEtUlx1uxhlSmoup4qM6Qq3DPFc
	 nkDPZJyHw+bMUNt02DXfcPb67Gi08MNITVy9MZVbawGDzD5+t/t8Yv7hD2ZH8y1vr/
	 ChaCdTfILdbupOWM2PIldGFfAStN6Dm6jPFazOOp0zeW1iyJUCRjOeh8ApqnJ7p/dh
	 u0kg+BoBHX/O6H0kpBhzSrtD3IrCBbiFjNTczlxZt8PJpnP/49V8JcntbyDQJWlRjG
	 GtHhFpzuNK7FI969exerP92C0niqhpNd2LTk9J75a9YF9ivrJ1f9gj5lxQft+AryNS
	 3/kirLT25i2jw==
From: SJ Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in damon_get_folio()
Date: Wed, 29 Jul 2026 07:22:28 -0700
Message-ID: <20260729142228.88390-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <amlZ_6pnt2AC-Ppl@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 22:01:01 -0400 Gregory Price <gourry@gourry.net> wrote:

> On Tue, Jul 28, 2026 at 05:50:36PM -0700, SJ Park wrote:
> > Hi Gregory,
> > 
> > 
> > On Tue, 28 Jul 2026 15:47:11 -0400 Gregory Price <gourry@gourry.net> wrote:
> > 
> > > All DAMON physical- and virtual-address operations obtain their folios
> > > through damon_get_folio(). That helper already excludes ZONE_DEVICE
> > > memory implicitly via pfn_to_online_page() and folio_test_lru(), but
> > > this is inconsistent with other callers in mm/ which test explicitly.
> > > 
> > > Add an explicit folio_is_zone_device() rejection in damon_get_folio()
> > > so the guarantee lives in one place and covers every caller uniformly,
> > > consistent with other mm walkers that reject zone device folios.
> > 
> > Thank you for checking this and sharing this nice patch!
> > 
> > However, I'm not very sure adding a call that not really required for only
> > making it looks consistent with others is the right choice.  I'm especially
> > concerned if this will confuse future readers including myself.
> > 
> > If this is a hardening purpose, we have CONFIG_DAMON_DEBUG_SANITY for the
> > purpose.  What about using it with a good comment explaining why we doing that?
> > 
> 
> It's actually two fold:
> 
>   1) make zone_device more consistently handled across mm/
>   2) make these checks possible to abstract out later
> 
> In the private node work - every location that we'd need to filter
> folios based on private node membership is a zone_device check.
> 
> Where zone device checks are missing (like here) there's some other
> implicit reason (specific to zone device) that allows it to be avoided.
> 
> I pointed out in the sashiko feedback that DAMON depends on a check
> for folio->pgmap in the hotplug code.  This is all quite fragile, and
> we can see that at least one patch in this series fixes an actual bug.
> 
> It seemed warranted to go audit every service and add the zone_device
> checks to make it clear there's a zone device interaction - even if
> presently unreachable - should some silent, implicit filter change.
> 
> The goal is to come back around and replace these with something like:
> 
>     bool folio_allows_mm_op(struct folio *folio,
>                             enum node_states feature)
>     {
>         if (folio_is_zone_device(folio) ||
>             !node_state(folio_nid(folio), feature));
>     }
> 
>     - if (folio_is_zone_device(folio))
>     + if (folio_allows_mm_op(folio, N_MEMORY_DAMON))
> 
> If we ever get to folios having memdesc flags beyond page flags,
> this also gives us a single mm-wide location for these kinds of
> checks in the future.

Thank you for kindly explaining the motivation.

So, what do you think about adding the check under CONFIG_DAMON_DEBUG_SANITY
with good comments at the moment, and later converting to folio_allows_mm_ops()
together?


Thanks,
SJ

[...]
