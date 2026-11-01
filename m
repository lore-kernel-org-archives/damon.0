Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554658;
	b=MnxSqNB/YGj6sE6RmBIzb9YvUyB9DB/UfHn7r01jXSPXAZNsgHHUkYnnCoOcw2nBakZN
	 JUc4TukjbDEHwBt+6qWVBEt2FKx12y+GbsWAGWMmq1XfxvnwYmYMB+pY+pYKUBckZrEZa
	 gT3+dwh+G8SUX7rtEle62ySmm4feZlJI63u1hTUpV76nPG2eQBtJPm2jfOFoqr0uGzl00
	 9IgQv842OnrHexhxmgTX9+cPKSJ1SmWbLU3e8rJ7vXexjuMt+d4X4f0YOP1Fq0oNtdaqY
	 pS17MDl8d64PGFEdEmQ1KH9V8MMxWW1bxLs/4lpZXCD4woInnQt9vdBx3jT4xlwkC5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554658;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qMaecMqOlVRGUh+8OqrsInbsoiLpkH+gXXcFWIMg3iQ=;
	b=HjWIH8OaGI7W5A8zLNQC03Jb5FLjmoWhmuSxdbF+ENzPzFuOcs9EYkRZgSguryuWMOn6
	 yzdXBttYTdJDFnY2jUGpgvnm4YTKEs4/T2I0Py9EFt64hhsJJq6vnoM2KTjq40EHbQ14H
	 dYgRjW3mjWBttNKPb8aOJfTQWDXmz6bcGYF0x01b3J9WpqKsXlLVL8pP5ViGRDvu97B1O
	 ikhg/eCD4oDxr9uSaQ+csK+ysxXgZgtDytSMUDfLcbBb9fUQAh2kiDGews0mmmMcp9Ntk
	 T3fL0d8la17uWryfhPJ7NcF7Rg9ughiR7cU2L0yPU1UzaMYxuxuBfp1t58G9hI9zGsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvAYE3bq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5263606A324
	for <damon@lists.linux.dev>; Sun,  1 Nov 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvAYE3bq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275091F000C1;
	Sun,  1 Nov 2026 17:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793554657;
	bh=qMaecMqOlVRGUh+8OqrsInbsoiLpkH+gXXcFWIMg3iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XvAYE3bqY8JCXvb3i2Y5oUe+IYKSKxDpN8J5kkzFBAqNLzZsgBoqTNfEYU6AabKq2
	 bG6g1xqikhvh1v7eMMyORcUWMIk3YoRljaTRVvwURIWWifghbYuAk3hoYNyGqH3H6x
	 wp9FYmPJX0UnF30eZg3GIIKQdPBGWnqn0/gvd2wZhDPEWexHQr7YFwL/AM3lavClkl
	 G6irBLpOJxEOelBT3nx6ifdvzAo4iHqBJK/BflbJu1UpmjwNVUmqBI64FNZhSt7uhQ
	 0r6hoY08nmhezf9QpgmtlDyD+keOc6HcoTZYINpvyScH4qboNt6Ay53B1tpFVR8j+4
	 njjc6CJ0CJRiw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 3/6] mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action
Date: Sun,  1 Nov 2026 09:37:28 -0800
Message-ID: <20261101173730.82717-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-192523@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 01 Nov 2026 17:21:39 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] mm/damon/vaddr: undeclared dests in damos_va_migrate_pmd_entry()
> --
> 
> commit 7670e03c4d866e7e831b34d6066cefe5b658b73a
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action
> 
> This commit adds sz_filter_passed accounting to the DAMON_VADDR
> migrate_hot and migrate_cold actions by passing the counter through
> damos_va_migrate_private and accumulating the size of folios that pass
> ops filters in damos_va_migrate_pmd_entry().
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index b1d7bcf7305bb..6fd0e07b60705 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> [ ... ]
> > @@ -846,7 +847,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  	struct damos_va_migrate_private *priv = walk->private;
> >  	struct list_head *migration_lists = priv->migration_lists;
> >  	struct damos *s = priv->scheme;
> > -	struct damos_migrate_dests *dests = &s->migrate_dests;
> > +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> >  	struct folio *folio;
> >  	spinlock_t *ptl;
> >  	pte_t *start_pte, *pte, ptent;
> > @@ -865,6 +866,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
> >  			goto huge_out;
> >  		s->last_applied = folio;
> > +		*sz_filter_passed += folio_size(folio);
> >  		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
> >  				migration_lists);
> 
> [Severity: Low]
> Was the declaration of dests in damos_va_migrate_pmd_entry() removed by
> accident when adding sz_filter_passed?
> 
> Both the transparent hugepage path above and the PTE loop below in
> damos_va_migrate_pmd_entry() still pass dests to
> damos_va_migrate_dests_add(), which causes mm/damon/vaddr.c to fail to
> compile with an undeclared identifier error when CONFIG_DAMON_VADDR is
> enabled.

Yes, it is a mistake I made while formatting this patch.  I will fix it in the
next spin.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261101171630.81477-1-sj@kernel.org?part=3
> 


Thanks,
SJ
