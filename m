Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5B1EA65;
	Wed, 14 Jan 2026 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404057; cv=none; b=lvMo5O3fVspyHBtTpzfweXMj1ycN7sEDFWfuli3nI2SKhQg1GP+KKy9e1q4yzehmj1jUu0130HTJLkBIeXKOT0wL4KyzvXZ+rZIbtp3JGh52To3Xu8LqEN9uNxA7Z42p541Ml5LGkfaM/X+uDS2XEDc27gnKxzN0xFTcA24zXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404057; c=relaxed/simple;
	bh=D5tB8wxme+mhdJymsubX32VBj8KaE1ZvdlhzozuhqS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsKIwV8o1P7Vh0BDx2GSHNOLezdwHWZ3H9veQXiI5zGQy9iwt9Nv0lKfbsFecOaRK0EukWj7Oi0RY5OgOq3Src/3tvprv5IQQOOox61wfKVxrVfpSYpKNLsmYvl0NJehaRx3uePL6wtHrO6X+t5PNx/wmL+RZp2Q9d1DUh2frPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoVWVWto; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoVWVWto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98387C16AAE;
	Wed, 14 Jan 2026 15:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404055;
	bh=D5tB8wxme+mhdJymsubX32VBj8KaE1ZvdlhzozuhqS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoVWVWtoNYSIuaM67czxWeeltkCUUM80TykrLoivBpiUQqYxmyWbnuHJnKczmocJH
	 8ocxMluyjqNFYjFautQzhwSISBzNuifxGxBl9smTmeva7k2IsUuzDG0ieIzKMseJXz
	 nxFWOMJhyK8cEDM/9V7VR99FNq5YytDF9ncfv+F+jDejbMJQVrOr48Xm1OzLFMWeiE
	 Ot/fX6A4c2ETe+rlKCRiyZ/Ef0t8rzFPicEa0EtWjA1LbPDCRY4LBMglfvGzr8JNNI
	 ezoyqtnr6hS594O2HbIMd0j4QL6D4T/hAZc46Teem52N+zfOnJyGyFN/nnL1IgfQrm
	 uwBDEOX6o+5cg==
From: SeongJae Park <sj@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 01/12] mm/damon/core: introduce nr_snapshots damos stat
Date: Wed, 14 Jan 2026 07:20:48 -0800
Message-ID: <20260114152049.99727-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114122959.1164957-1-clm@meta.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 14 Jan 2026 04:29:56 -0800 Chris Mason <clm@meta.com> wrote:

> On Tue, 16 Dec 2025 00:01:14 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMON generates monitoring results snapshots for every sampling
> > interval.  DAMOS applies given schemes on the regions of the snapshots,
> > for every apply interval of the scheme.
> > 
> > DAMOS stat informs a given scheme has tried to how many memory entities
> > and applied, in the region and byte level.  In some use cases including
> > user-space oriented tuning and investigations, it is useful to know that
> > in the DAMON-snapshot level.  Introduce a new stat, namely nr_snapshots
> > for DAMON core API callers.
> 
> Hi everyone,
> 
> I ran mm-new through the AI review prompts and this one was flagged:

Thank you Chris, this is a very helpful and great gift for the community!

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -157,6 +157,12 @@ void damon_destroy_region(struct damon_region *r, struct damon_target *t)
> >  	damon_free_region(r);
> >  }
> >
> > +static bool damon_is_last_region(struct damon_region *r,
> > +		struct damon_target *t)
> > +{
> > +	return list_is_last(&t->regions_list, &r->list);
>                            ^^^^^^^^^^^^^^^^  ^^^^^^^^
> 
> Are the arguments to list_is_last() swapped here? The kernel's
> list_is_last() expects (entry, head) but this passes (head, entry).
> 
> Looking at include/linux/list.h:
> 
>     static inline int list_is_last(const struct list_head *list,
>                                    const struct list_head *head)
>     {
>         return list->next == head;
>     }
> 
> The current code checks if t->regions_list.next == &r->list, which will
> be true when r is the first region in the list, not the last.
> 
> Compare with the existing damon_last_region() in include/linux/damon.h
> which correctly uses &t->regions_list as the head:
> 
>     static inline struct damon_region *damon_last_region(struct damon_target *t)
>     {
>         return list_last_entry(&t->regions_list, struct damon_region, list);
>     }
> 
> Should this be:
> 
>     return list_is_last(&r->list, &t->regions_list);
> 
> > +}
> > +
> 
> [ ... ]
> 
> > @@ -1978,10 +1984,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> 
> [ ... ]
> 
> > +		if (damon_is_last_region(r, t))
> > +			s->stat.nr_snapshots++;
> 
> If the list_is_last() arguments are indeed swapped, this will increment
> nr_snapshots when processing the first region of each target rather than
> the last, causing the stat to be counted once per target instead of once
> per complete snapshot.

AI is all correct.  Note that this is not making user-visible issues, though it
is clearly a bug that better to be fixed.  I explain the reason in below fixup
patch.

Andrew, the commit to fix is in mm-unstable.  Could you please squash below
attaching fixup to the commit?


Thanks,
SJ

[...]
=== >8 ===
From 551b89fd05f0c40c824d2a5c0ca6c2a63766fbab Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 14 Jan 2026 06:57:38 -0800
Subject: [PATCH] mm/damon/core: fix wrong list_is_last() call in
 damons_is_last_region()

damon_is_last_region() is calling list_is_last() with swapped arguments.
As a result, it works like damon_is_first_region().  Not that this is
not making user-visible impact, because the function is only used to
increment nr_snapshots stat once per DAMOS' regions iteration, and the
stat is exposed users only after the iteration is completed.  That's why
it passed a user space test.  Nonetheless, the bug is a bug and could
cause real user issues in future.  Fix it by correcting the order of
arguments for list_lis_last().

Reported-by: Chris Mason <clm@meta.com>
Closes: https://lore.kernel.org/20260114122959.1164957-1-clm@meta.com
Fixes: bbb3a45f1923 ("mm/damon/core: introduce nr_snapshots damos stat") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 385900733a0b..5d7e58cbd9fe 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -190,7 +190,7 @@ void damon_destroy_region(struct damon_region *r, struct damon_target *t)
 static bool damon_is_last_region(struct damon_region *r,
 		struct damon_target *t)
 {
-	return list_is_last(&t->regions_list, &r->list);
+	return list_is_last(&r->list, &t->regions_list);
 }
 
 /*
-- 
2.47.3

