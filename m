Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1D23393C
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693070; cv=none; b=PLG1aR3iA3n3HEU6hy8qPkjBSQiHyrw0TxoWqrIHpdt6FcCON/NHPadcQnbNAUkJdD9gxQdqUqA5wC4ENX6RXne1izIrr1tPX5BUHTUa03vvjeHRddUDwKsGgKZCKuWcopifKC1aw2M4hDq04mmZH/pNpb1iVzWkRbpvy94lq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693070; c=relaxed/simple;
	bh=lFY5aSHyALxMTyErkOD0dd0xblnT/4yyf69LS7VSIwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbW8YAau4PkF2lqB1nSVxJ4JunnTX0YzjZmiZSlM91A4twut0trWjPl9FfJKUipOzzEad16cWkVE07ryvDUI98Kohy+J6A9OdwpBGtpzsbuGglp/Ev7xZwrJrvhtwmLbORq6/gcUo0YTVMyl2PLFfMZt97Cv8mH5YdHmZ57ijGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hobh7c3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hobh7c3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E681F000E9;
	Sun,  2 Aug 2026 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785693069;
	bh=m7nZ9pVspMDApR//PKwy3Zu/cYVBRBfvrmwNNDAHNlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hobh7c3T6Sy5SgJxCg+As7puwEZNHBAinjSDXLVN4Djl0eaMFGzs664BAobIzjxqt
	 Qmz5b+DuBQ49OkJp8MU7yAl2cX1nZFcNzGqmi+QS1wFtGic0qADvhBDGypJZ2rTdds
	 wOjOeYKMB/kQ+l0CxV520+6HiXf/lHZzvJNhtFQ1B5OtK0KRz4vQEi/8nGjIPQ2Iqo
	 JjFw/j9pDH/HDMwL76l60Xe21Tfecnnr20goG3d63JU0hrnmGRBUFfjyv3DA7FS0j9
	 rP9IKcnxbCJRLDcZf58hLLFl6+w/RqLU1I/VIxxXlKSkvN6hvDHkOfElUiooD0+m/I
	 jLqvlDyegWI1w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 8/9] mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
Date: Sun,  2 Aug 2026 10:51:05 -0700
Message-ID: <20260802175106.2012-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802163834.2C72B1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 16:38:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but damos_get_node_mem_bp() contains a severe logic bug and underflow when free memory exceeds total memory (i.totalram < i.freeram).
> --
> 
> --- Patch [8]: [RFC PATCH v1.1 8/9] mm/damon/core: handle extreme memory state in get_node_memcg_used_bp() ---
> commit 0fb31bc202c766c30f5d776d57b867135fba4aa6
> Author: SJ Park <sj@kernel.org>
> mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
> 
> This commit addresses division by zero and underflow issues in
> damos_get_node_memcg_used_bp() by handling cases where total memory is zero or
> used memory exceeds total memory. It returns 100% and 0% for these respective
> edge cases to prevent anomalous behavior.
> 
> Link: https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index e3f3ee75a3d33..67ad1f07c29a4 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2862,10 +2862,16 @@ static unsigned long damos_get_node_memcg_used_bp(
> >  	mem_cgroup_put(memcg);
> >  
> >  	si_meminfo_node(&i, goal->nid);
> > -	if (goal->metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> > +	if (!i.totalram)
> > +		return 10000;
> > +	if (goal->metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP) {
> >  		numerator = used_pages;
> > -	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> > +	} else {
> > +		/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> > +		if (i.totalram < used_pages)
> > +			return 0;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the adjacent
> damos_get_node_mem_bp() function contain a logic bug when free memory exceeds
> total memory?
> 
> If i.totalram < i.freeram, it appears that for DAMOS_QUOTA_NODE_MEM_USED_BP,
> i.totalram - i.freeram will unconditionally underflow, falsely throttling or
> activating schemes. For DAMOS_QUOTA_NODE_MEM_FREE_BP, returning 0 means it
> reports 0% free memory when the node is actually >100% free, which could cause
> schemes waiting for low free memory to trigger aggressively.
> 
> mm/damon/core.c:damos_get_node_mem_bp() {
> 	...
> 	if (goal->metric = DAMOS_QUOTA_NODE_MEM_USED_BP) {
> 		numerator = i.totalram - i.freeram;
> 	} else {
> 		/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> 		if (i.totalram < i.freeram)
> 			return 0;
> 		numerator = i.freeram;
> 	}
> 	...
> }
> 
> Should this pre-existing issue in damos_get_node_mem_bp() be addressed as well,
> perhaps by returning 0 for USED_BP and 10000 for FREE_BP when
> i.totalram < i.freeram?

The previous patch was completely broken by my mistake.  I will fix.

> 
> >  		numerator = i.totalram - used_pages;
> > +	}
> >  	return mult_frac(numerator, 10000, i.totalram);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802162631.90304-1-sj@kernel.org?part=8
> 


Thanks,
SJ
