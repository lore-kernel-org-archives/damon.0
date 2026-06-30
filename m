Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79DC40D56E
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782779090; cv=none; b=edEFtvBdWD6sc8ZxnOvwCJWZa5fmDSlLnSGnIFFnyytpdskC9qOv+cCXQyX/CQvoVg3K38uboRhTbnuVhREkN4HCiyjhga6/68UMOQaJLS6dNv7P4rhdMCqdSHw/jtTU8r+EqKhpTRAlcge0Olk1c4/dHZmYpX50XluxLQesvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782779090; c=relaxed/simple;
	bh=xhgL1j08IaTL8bBDWWPpjSDiTQime0usLZdi6HaEhQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvSoJR1lMyr+MDJ4JrHaPWH9UVvBAg21UOT0YHhMq0oWjaoankhLbse7ojOMf4mBjdk6uUax9LtyIaeAKIvlgSUFbesyeAp4Q8InILIpBxvjWq16OOcwXn48pDaWSZgm0GW82vzpldWo3289/uHBLarxz9iV/YiVkX2M/oh+2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beODLWeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beODLWeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6020A1F000E9;
	Tue, 30 Jun 2026 00:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782779089;
	bh=++hRphP4/vjeKOKH9fxJwFV8TMjjpBZJOqZO9M4aznc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=beODLWeMgXI/Y6aVUDGT/ZHyMqyNsedyMpUgxnIYdUCIJpfKLpEPhW+WhqZpyQW1b
	 NRYqKchqs/7x+rG5DhWyq+LZymimmD7jZRGQqzGMVhF5hK6rQpEUGZXg5vjkiXIDnc
	 uU9jJuZr+1tXXTX3JC/CZCJL+m9dMge84A8cvc2UAT3Sz/zwPpaZ4bTqFH51elr6J+
	 5jQIeTdHQXi9zWS7CLePeUfJa+DG7OAVMpzwutmHSCdPTl2VCqsmLN9MG8udN8UHv8
	 5ho5y/X4ElCmGb2MCB1XLor0U6U5UpAPbrWNu4lRKFdm5lYwefM9m0L0Z+b1qxkEif
	 Zj8OEKunlGUjw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v3 1/3] selftests/damon: prevent cross-context state pollution in DamonCtx
Date: Mon, 29 Jun 2026 17:24:41 -0700
Message-ID: <20260630002442.141115-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629145553.275BB1F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 14:55:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch introduces a split-brain state corruption in `DamonCtx` by implementing an incomplete fix for Python mutable default arguments. While it replaces the defaults in `DamonCtx.__init__` with `None` sentinels and instantiates them at runtime (e.g., `monitoring_attrs = DamonAttrs()`), it misses the fact that `DamonAttrs.__init__` still uses a mutable default (`intervals_goal=IntervalsGoal()`).
> 
> Because `DamonAttrs()` is now called multiple times (once per `DamonCtx`), multiple `DamonAttrs` instances are created, but they all silently share the exact same `IntervalsGoal` instance. During `DamonAttrs.__init__`, the shared `IntervalsGoal` instance's `attrs` back-reference is overwritten to point to the newest `DamonAttrs` (`self.intervals_goal.attrs = self`). 
> 
> As a result, when an older `DamonCtx` calls `stage()`, its base attributes correctly route to its own sysfs directory, but its `intervals_goal` writes route to the sysfs directory of the most recently created `DamonCtx`. This is a newly introduced inconsistency, as prior to the patch, all properties incorrectly routed to the same directory together. Additionally, the patch leaves identical mutable default bugs untouched in `DamosFilters`, `DamosDests`, `Damos`, `Kdamond`, and `Kdamonds`.
> --
> 
> commit 7d9280d7450287d38ab4b080317de0093ab71119
> Author: Kunwu Chan <chentao@kylinos.cn>
> 
> selftests/damon: prevent cross-context state pollution in DamonCtx
> 
> DamonCtx.__init__() uses mutable default values for monitoring_attrs, targets,
> and schemes. In Python these are evaluated once at function definition time,
> so multiple DamonCtx instances can unintentionally share the same lists and
> DamonAttrs instance. Replace the mutable defaults with None sentinels and
> initialize the objects when needed.
> 
> Link: https://lore.kernel.org/20260601032314.424013-2-kunwu.chan@linux.dev
> 
> > diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
> > index 8b12cc0484405..2f6f2699db256 100644
> > --- a/tools/testing/selftests/damon/_damon_sysfs.py
> > +++ b/tools/testing/selftests/damon/_damon_sysfs.py
> > @@ -624,17 +624,23 @@ class DamonCtx:
> >      pause = None
> >      idx = None
> >  
> > -    def __init__(self, ops='paddr', monitoring_attrs=DamonAttrs(), targets=[],
> > -            schemes=[], pause=False):
> > +    def __init__(self, ops='paddr', monitoring_attrs=None, targets=None,
> > +            schemes=None, pause=False):
> >          self.ops = ops
> > +        if monitoring_attrs is None:
> > +            monitoring_attrs = DamonAttrs()
> 
> [Severity: Medium]
> Does this incomplete fix introduce a split-brain state regression?
> 
> Because DamonAttrs() is now called multiple times (once per DamonCtx),
> multiple DamonAttrs instances are created. However, DamonAttrs.__init__
> still uses a mutable default for intervals_goal:
> 
> tools/testing/selftests/damon/_damon_sysfs.py:DamonAttrs.__init__() {
>     def __init__(self, sample_us=5000, aggr_us=100000,
>                  intervals_goal=IntervalsGoal(), update_us=1000000,
> ...
>         self.intervals_goal.attrs = self
> }
> 
> This causes all newly created DamonCtx instances to silently share the
> exact same IntervalsGoal instance. During DamonAttrs.__init__, the shared
> IntervalsGoal instance's attrs back-reference is overwritten to point to
> the newest DamonAttrs.
> 
> As a result, when an older DamonCtx calls stage(), its base attributes
> correctly route to its own sysfs directory, but its intervals_goal writes
> route to the sysfs directory of the most recently created DamonCtx.
> 
> Additionally, could there be other similar mutable default bugs left
> untouched, such as in Damos.__init__:
> 
> tools/testing/selftests/damon/_damon_sysfs.py:Damos.__init__() {
>     def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
>                  quota=DamosQuota(), watermarks=DamosWatermarks(),
>                  core_filters=[], ops_filters=[], filters=[], target_nid=0,
> }

Good findings.  But no blocker of this patch that makes some improvements.  And
fortunately there is no real callers that causing the issue for now, to my best
knowledge.  So not real urgent.  Someone who get interested in this change will
take time to fix this.


Thanks,
SJ

[...]
