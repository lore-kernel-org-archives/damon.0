Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B62DB795
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784605837; cv=none; b=det2HUAmnRXMI+4+PDMuUW11SAJVnltcjZqNwyFda1pH7P3JIYGetj3k5uPuGAHPR88NwH46ZI9jQsDTIhxIO5EmmIwoJ9USjckrtKpbB4Qgrj2QCi0oQWU/CDgexmP5zGMmn7qAzWEiQQORn32qe/+hbJtNIW83ilR4baI5xQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784605837; c=relaxed/simple;
	bh=lXlQ7MRT134VI9jTlrGBkHWhcaAsFyYefLesZXeT8vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAnWEF5k+YWgPPiEPbZWit46YJoRsAOhDr5VeaezXkGM443uMbl4upI3qbNjo0oFsKAaclbq2n90PKBs7R7/xasoXkSl+BWI6oIBy8omwDwWVjSt0Jnq3tQQGkd+gCOaGRSat1dwmhMcYK1j+I8Mlkmim5JTpPFpWYrE5qUQHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLrakx2f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLrakx2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FF41F000E9;
	Tue, 21 Jul 2026 03:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784605836;
	bh=VFp1orJlO3AAWZjZtJBaM8vYB3B2UiEEPEiReORNIQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LLrakx2f4tkU9KaLTKRPj1MmtCUUHHGVTe4qt35iJSZ9Rbbmflf4Zlu43dSLeuKOr
	 EaVnsRNCSNssOjtKvOiy0yzyiMIMl2LJQ993LEfIcLUz+eqpc57A2SRrqX+M6QmOwE
	 uKL0LoOHpukBu2iojU4DX/TN9x6LDt1ObMZ8CdLbG05fUYbS7GAfwTowW9szwsMrdF
	 iwGQ+58KrYbO7gHtTMn2Bp8yuVGuEIHnzZ8a+g+mtHYkkEMy/r9yNzqeNSawtir9HY
	 WDvT2RwvH5wnmaVH8Qcui8haXceh9HcWbF9lHXfbw59qP/VLXVgYQEaOYdYolKyKjj
	 qP180AZbDlcxQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	gutierrez.asier@huawei-partners.com,
	damon@lists.linux.dev
Subject: Re: [PATCH v3 2/3] mm/damon/sysfs: support hugepage_mem_bp quota goal metric
Date: Mon, 20 Jul 2026 20:50:23 -0700
Message-ID: <20260721035025.147141-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720121538.9C1381F00ADF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 12:15:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Integer underflow when computing 'total' in `damos_hugepage_mem_bp` causes DAMON to become maximally aggressive on highly idle systems.
> - [Medium] The new `hugepage_mem_bp` sysfs metric is missing from the DAMON sysfs selftest script.
> - [Low] Missing documentation for the `hugepage_mem_bp` metric in the DAMON design guide.
> --
> 
> --- Patch [2]: [PATCH v3 2/3] mm/damon/sysfs: support hugepage_mem_bp quota goal metric ---
> commit 304fd61bee6da0356569e9c8297451d15a43e10f
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon/sysfs: support hugepage_mem_bp quota goal metric
> 
> This commit exposes the new DAMOS_QUOTA_HUGEPAGE_MEM_BP autotune policy
> metric through the DAMON sysfs interface. It adds "hugepage_mem_bp" to
> the sysfs-schemes interface.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 32f495a96b17a..d9b81d7b5910e 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -1269,6 +1269,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
> >  		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> >  		.name = "node_eligible_mem_bp",
> >  	},
> > +	{
> > +		.metric = DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> > +		.name = "hugepage_mem_bp",
> > +	},
> >  };
> 
> [Severity: High]
> While this patch exposes the new metric, is there a potential integer
> underflow in the underlying implementation of damos_hugepage_mem_bp() in
> mm/damon/core.c?
> 
> Due to per-CPU vmstat counter drift, pending positive deltas from freed
> memory can cause the global NR_FREE_PAGES count to temporarily exceed the
> fixed totalram_pages(). In damos_hugepage_mem_bp(), total is computed as:
> 
>     total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> 
> On a highly idle system, this could cause the unsigned subtraction to
> underflow, resulting in a value near ULONG_MAX. The subsequent !total check
> would fail, and mult_frac(thp, 10000, total) would evaluate to 0 due to the
> enormous denominator.
> 
> Would this score of 0 lead damon_feed_loop_next_input() to perceive a maximal
> divergence from the goal, forcing the scheme to maximize its quota
> aggressiveness instead of minimizing it?

As I replied to the same report, the user impact is trivial.  No blocker.

> 
> [Severity: Medium]
> Should tools/testing/selftests/damon/sysfs.sh be updated to include the new
> metric?
> 
> The test_goal() function validates writes to target_metric for all existing
> metrics:
> 
>     ensure_write_succ "$fpath" "active_mem_bp" "valid input"
>     ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
>     ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
> 
> Could hugepage_mem_bp be added to this sequence to ensure the sysfs interface
> is regression tested?

Definitely better to do this.  No blocker, though.  I will do this unless
someone steps up earlier.

> 
> [Severity: Low]
> Does this new metric need to be documented in
> Documentation/mm/damon/design.rst?
> 
> The documentation lists all available target_metric values, such as
> inactive_mem_bp and node_eligible_mem_bp, but it appears hugepage_mem_bp
> is missing.

No blocker.  The next patch of this series does that.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260720120140.881468-1-gutierrez.asier@huawei-partners.com?part=2
> 


Thanks,
SJ
