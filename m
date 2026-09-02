Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8B24C06A
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311611; cv=none; b=MUFueK3bIoDtRA6m82ywVY2DjEbCZfUv3Garyq5KGLJ/z29rxUwv3m8ei5h/E9BNcw3G+hVlg4c8ruZSAp9O3ipkpGe4diY0i8WnD6+MnDl/gAfV8V+hHb2WV+2N1qzuWSMvDIhOPWLDRLuMI0JoZNenZt57ULcF/AXZpF+Qy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311611; c=relaxed/simple;
	bh=/4AZLxzjsf0K1vu8tA46hNacaxvJPm/vZ3PF8jwb3nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0fF5f/qY7xr1l8J4txHKqt552edCQyIOHuD+pupuUG0pL/INbNuj9QktOED8J5+EZ4r4WrmEsQ+xp2keagX51cep4Jc6UljcmUwRSsvzT4TX9RCbHK4Ewdn3In0RU2AyCtiq5wtsBfQoI4mRW7gSzndo7G+pL0BdmfzJHUMnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1ydxIlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1ydxIlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C641F000E9;
	Wed,  2 Sep 2026 01:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788311606;
	bh=q9yRBiYdqEZEFyJDWHuQC/XgB5aAIi/lnWTC4TmpiSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U1ydxIlNt72F+vHh/5yhPO/ActrXlHuzjdn8CSS/kMTAvJT7z1FaYOClrPHbK7vgu
	 3KJEdZuCLH0tmytGgebgKx1xQuGgrBcU5aVJ/j3qCj0RMysuC0pmy0kQOYHL1phtCO
	 lBp6EREJlWD5G89gFN4Gpql0KI9ROhoj688Ix7V5OeiwEpBSvlICGcCHuxwbcFmzEk
	 srOqJd5E5PKDA3MKQJ9uhHbjT4UCRw/hRUPLY7tveaa3mFSzt5H8k0gjPKxCmeaH7g
	 6Wm8bwBgSqRiprHT1Gi33dgh5hzhJzwiZtJbafupliut973tlLkyPsri4JawuuJCxf
	 fvOZPQsP04Bxg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 3/4] mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
Date: Tue,  1 Sep 2026 18:13:12 -0700
Message-ID: <20260902011314.110041-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902003951.11EED1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 00:39:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Inconsistent state handling in damon_commit_ctx() on memory allocation failure.
> --
> 
> commit c0fdc35d2fb6726e726ba0e857811cbaefc34918
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
> 
> damos_commit_quota_goal_union() is not updating the ->nid union field
> when the goal metric is DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP.  Hence, if a
> DAMOS quota goal of the type is online committed in a way that it will
> reuse other quota goal's memory space, the new goal will work with a
> garbage nid value.  As a result, the DAMOS scheme can show unexpected
> aggressiveness.
> 
> > damos_commit_quota_goal_union() is not updating the ->nid union field
> > when the goal metric is DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP.
> 
> This isn't a bug, but there's a typo (DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP) in
> the commit message.

Good catch.  I will ask Andrew if he could fix this while picking this.

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 647ac77f573bb..a499d7866c507 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1143,6 +1143,9 @@ static void damos_commit_quota_goal_union(
> >  		dst->nid = src->nid;
> >  		dst->memcg_id = src->memcg_id;
> >  		break;
> > +	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> > +		dst->nid = src->nid;
> > +		break;
> >  	default:
> >  		break;
> >  	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is a pre-existing logic
> flaw in the core DAMON commit mechanism on memory allocation failure.
> 
> In mm/damon/core.c:damon_commit_ctx():
> 
> 	err = __damon_commit_ctx(test_ctx, src);
> 	if (err)
> 		goto out;
> 	err = __damon_commit_ctx(dst, src);
> 
> If the second call to __damon_commit_ctx() fails with -ENOMEM, won't it
> leave the active dst context corrupted?
> 
> For example, an OOM condition can occur here in
> mm/damon/core.c:damon_commit_schemes():
> 
> 		new_scheme = damon_new_scheme(&src_scheme->pattern,
> 				src_scheme->action,
> 				src_scheme->apply_interval_us,
> 				&src_scheme->quota, &src_scheme->wmarks,
> 				NUMA_NO_NODE);
> 		if (!new_scheme)
> 			return -ENOMEM;
> 
> A failure here exits the commit process without rolling back prior scheme
> updates, leaving the active dst context partially updated.
> 
> The kernel handles this by setting dst->maybe_corrupted = true, which
> forces the kdamond monitoring thread to terminate gracefully but permanently.
> 
> Could this be triggered by a user-initiated online parameter update
> encountering an OOM condition during the second __damon_commit_ctx()
> invocation?
> 
> Does this violate the atomic nature of damon_commit_ctx() (which uses
> test_ctx precisely to avoid partial updates on the active context) and
> cause an unintended loss of the running context?

Such user would need to have sysfs write permission first.  With the
permission, the user could do whatever, even worse than stopping DAMON.

So no issue in my opinion.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260902002725.108635-1-sj@kernel.org?part=3


Thanks,
SJ
