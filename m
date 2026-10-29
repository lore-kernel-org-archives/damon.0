Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235979;
	b=zs4/2laepVuPV8lb5sRUzMK45iblFTvH6XR0C6nLL99FWDFuZUNWCckqEWbAqsRw7RWx
	 gv4Cs7veHJnsSMW2yinzN7+YH5Hcnqo+ntudDLWC+q2E5aKciMxAFg0zgmq5WkzJKfq3V
	 fAB3hvTcIV9XHnttL/msvCYdQAUjOUPyVSVNTYNJ+lvkUxRckN5BR1d+1Ar17+U3ndaVE
	 VxbrW4o7OAWcYN60H7zCncECi8ZfOk1x/4Ia2EPEX+81dRuUnOPQqkS0Hg/uMcVLSiUKy
	 Tnp81tl5EjDuudn1kyyCRY9x5HncZVbEG80YhrN7nbiyYCuDizGmag3TwI59i6OZMRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235979;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XhzgWvw9dix6dVykJ5a4PvaQa7adQLn21rzVdWA29fs=;
	b=M+EwDJTNA/b92s1GAwS6Da1E9khg/8Ug+Zpm3N5DtuhBdaIHQWafRIu2AfIleWW93CCw
	 qxGdYqHsJjJrAUbhjmb0z3g8QvHi1/vLV8PPT2PFE1iXaLqOHHDyjuZPXyHPZr0ZlBRXd
	 1+qWDnvM+ijyR/+7s6ofraCZHNzfFlZ1BkGLOq0MOZDxZ2TUFa9Jehrr5kUgHu82Qph+o
	 f+O4F7bVRMLdo0dLJWXFRKp+4diJbWSUinbJcDAn9WK4ymC3SqPnDKZswv1VHueejC6fC
	 BTBNm3dBqz3GbYv59SR9jgZHphdezTKfLbYbsETeoUBrTJ59QaF/RHJ2Qnnz6yCeytg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyWy87D2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A63606A31A;
	Thu, 29 Oct 2026 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyWy87D2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069FF1F01825;
	Thu, 29 Oct 2026 01:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235978;
	bh=XhzgWvw9dix6dVykJ5a4PvaQa7adQLn21rzVdWA29fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyWy87D2HsyvaSuz6Y7G6vhv6Mfp81D3sIv50QRIaDaq19WokIWz8vhdH+0htZQp0
	 DQO4apVKJ7BW8j1BmtfvA45GttkH13CJeuE1yF6LVnbNZgH08Pjt2Gcm7BxyDYDLpA
	 aJAmesjjc7A9bECK4kXjIRnavfGJ2YW5NMY6z166RU+cxn/fNM/kQ3qXTjaU0KAbRH
	 paqPiSdjGCpBzj4OfohAU9A7k74IZcdZY3VG22Pu5Jyzq0lkNxP/5d7cdGrGrHFIzP
	 F+xIO8pz4wrHUjFR+jnbWJN27CNEmegtOb73cAI8f4+0DVdic/y3tBlKpd812MEMwx
	 3hIxSHQOQxyRw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Bijan Tabatabai <bijan311@gmail.com>,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH] mm/damon: skip folios already on the migration target node
Date: Wed, 28 Oct 2026 18:06:10 -0700
Message-ID: <20261029010611.170686-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029010144.169906-1-sj@kernel.org>
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
Content-Transfer-Encoding: 8bit

One more trivial nit.  Let's use 'mm/damon/{p,v}addr:' as the subject prefix.

On Wed, 28 Oct 2026 18:01:43 -0700 SJ Park <sj@kernel.org> wrote:

> On Thu, 29 Oct 2026 00:05:46 +1100 Aveline Noir <jm5905938@gmail.com> wrote:
> 
> > While measuring DAMOS migration overhead, I found that the target_nid
> > path isolates folios already on the target node, then puts them back on
> > the LRU without migrating them.
> > 
> > Skip them before isolation in vaddr and paddr, as the vaddr explicit
> > destinations path already does.
> 
> Nice catch!
> 
> > 
> > Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> 
> Other than below trivial nit,
> 
> Reviewed-by: SJ Park <sj@kernel.org>
> 
> > 
> > ---
> > DAMON KUnit and selftests all passed. In a synthetic same-node fvaddr
> > test on a two-node x86-64 KVM guest (8 interleaved runs per kernel),
> > guest-kernel cycles fell by about 29%
> > with 4 KiB regions and 90% with 16 MiB regions. Median kdamond CPU
> > time fell by about 76% with 16 MiB regions, with no clear change
> > with 4 KiB regions.
> 
> Thank you for sharing the test result.  We don't want to add too much test
> results in the commit message.  But the performance part above is informative
> and concise, so I think it deserves to be in the commit message.
> 
> > ---
> >  mm/damon/paddr.c |  2 ++
> >  mm/damon/vaddr.c | 22 ++++++++++++----------
> >  2 files changed, 14 insertions(+), 10 deletions(-)
> [...]
> > @@ -858,8 +860,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  			goto huge_out;
> >  		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
> >  			goto huge_out;
> > -		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
> > -				migration_lists);
> > +		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
> > +					   migration_lists);
> 
> Let's not align parameters on parentheses but just give two tabs indentation.
> 
> >  huge_out:
> >  		spin_unlock(ptl);
> >  		return 0;
> > @@ -883,8 +885,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  			continue;
> >  		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
> >  			continue;
> > -		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
> > -				migration_lists);
> > +		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
> > +					   migration_lists);
> 
> Ditto.
> 
> Assuming you accept my humble suggestions above, I applied  this patch to
> damon/next [1] tree, together with my above suggestions.  I will repost it for
> mm.git inclusion within a week.  So, no action from your side is needed for
> now.  Let me know if you think changes to the plan or discussions are needed.

I also added the suggested subject prefix in damon/next tree.  Please feel free
to let me know if you have an opinion.

> 
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
