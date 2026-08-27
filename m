Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1C2C15AC
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806244; cv=none; b=ZtHLm11qravpZfMGTqMlspKdkSXFQOJpIw1DsFbfQpSGbPdw1A1AA+ARmcaEAmPuQwYS39rC5AKHsfV7qH/nNJ6I8WX2ln7cIGquf+FiqMA6oOPrLJek+lC/VSJ6rOZsjb5O/+p0OxEfq9kokHRLNKR+IBTEiS9HEXdHwxdTJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806244; c=relaxed/simple;
	bh=HJNnY6IMnginBOMFi2Mof08e38QXR9DWa3mrP4T5+ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haqY0kHj2fRVb94AzYum+JXNpjM3m63f5w+NlVCPAainIDm2mHFwk3fw8sgJuM/1CptAYsGAzGSfdle2mAI4bFjmzNWyM6QGGIepMlGnOZZR24lJ1j6NfUulTsTLKhzKykunundbeSy09EHyF+Lp5eCSXSY7gDy8x/aWnhfFGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIAV5zMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIAV5zMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBF51F000E9;
	Thu, 27 Aug 2026 04:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787806242;
	bh=cWXeIzj5rZQeqm3rTEXcxrDBrM+dLZqwonlkuF+n8B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VIAV5zMimmHhzTVgKNhlRbxWgu2RLARk6ftrs1Rd6ZlqScx9FsH0B0AcL1N66Om+l
	 aZOPJ62zLqKir49TMPXeMzz8WYMZGS7Vd/66mxm72jNKGT6nGl1fEJPw7a11yzxDkw
	 nUREwy1BWKbkJOqJSRMgRSSQeE4nHKK48WNf5eUcn3e4KwAmTXm7YTKqP8e4f3Hf8d
	 Slzct99nZDl2D8xe/7DLRD1EAayQFtm7Cw08xOHCi0pnwdcqiueM5xnM8HZg3Wtnm8
	 kngjGLvzNoFFVXxURD8WBNa+AaT1vbBETCHtBH1ByGtoASRJ7l3FQKmOx5NJCXFCwK
	 kt7cKOXqHwPbw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/2] mm/damon/core: initialize damos_quota_goal->last_psi_total
Date: Wed, 26 Aug 2026 21:50:34 -0700
Message-ID: <20260827045035.94611-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827044548.65E8B1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 27 Aug 2026 04:45:47 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Low] Implicit declaration of function 'damos_get_some_mem_psi_total' causes a compilation error.
> 
> Pre-existing issues:
> - [High] The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric's 'nid' field is not copied when committing a quota goal parameter update, leading to an uninitialized node ID being used for eligible memory queries.
> --
> 
> commit 9597a197ecbd4f36e4fa8dfa9bd1bdbb5a5f1d93
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: initialize damos_quota_goal->last_psi_total
> 
> Initializes the last_psi_total field at the beginning of kdamond and during
> each commit for SOME_MEM_PSI_US type quota goals. This prevents unexpected
> adjustments during the first iteration of the feedback loop.
> 
> Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a16560..6f360d61390ad 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1122,6 +1122,9 @@ static void damos_commit_quota_goal_union(
> >  		struct damos_quota_goal *dst, struct damos_quota_goal *src)
> >  {
> >  	switch (dst->metric) {
> > +	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> > +		dst->last_psi_total = damos_get_some_mem_psi_total();
> 
> [Severity: Low]
> Does this cause a compilation error due to an implicit function declaration?
> 
> The function damos_get_some_mem_psi_total() is called here, but it appears
> to be defined later in mm/damon/core.c without a prior forward declaration.

Good catch.  I will add the declaration in the next version.

> 
> > +		break;
> >  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
> >  	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
> >  		dst->nid = src->nid;
> 
> [Severity: High]
> This is a pre-existing issue, but does this switch statement omit the
> DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric?
> 
> When a user configures a DAMOS quota goal using the
> DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric via sysfs, a new quota goal is
> allocated in damos_new_quota_goal() via kmalloc_obj(), where the memory is
> not zeroed. 
> 
> Because DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP is missing from the switch statement
> in damos_commit_quota_goal_union(), its nid field is not copied over during
> parameter updates. This leaves the node ID uninitialized and potentially
> causes eligible memory queries to evaluate using garbage data, completely
> breaking the metric's functionality.

Good catch.  I will separately work on this.

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260827042920.93580-1-sj@kernel.org?part=1


Thanks,
SJ
