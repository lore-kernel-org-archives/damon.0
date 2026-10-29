Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235712;
	b=CdtfGTuZP57t/7Q74Si9YRvP1usS4SodkhbZyUYz5ctLSaJ4wFLt8a2iB5HHAa0+Wv+V
	 4NFG21bKkHI5uoLQnT6vUQSUmivXab/ImYIiSiMx0Qj2oW6UNTkIgZ9am1QMkBHicqbPK
	 edmKm6IXhMgsOL0vmnLf9IrTkx1o8oYozZwUAtcoXf2EpczG1+Ajz9OFO1TmdFDz+ZEsE
	 vDn8JR9OBYB15vVg3mQ+AwSXDSBC0aNXNwJIRVdDFA1dIKXjQK2xid41Jw6uskIicd8Tn
	 nVakjggM4btj/REdrK98ro4aN7rtnwU7whdXhCq2hgfT7KcJDIIej8OT73AwoBPVZ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235712;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IeVai7414BFTHAGTwhgEP7/ooB/HFDOlmc07AL7nxgw=;
	b=MuqOKEGOWkXZctQ4w8Bxz8mcZZURsy8Iaou0NdO1o8yUpsbBN1SE3zgIpCchjutMZ0V9
	 IV/3tK966KpWFCQJ1sTTjPmP1FkSGsjKfGjJNMItbsfaTjAylvos3nHSM7XN4OHDUc3v+
	 oh+LnpFYlQ67inknjT1KRWWAuAdGEPX+0tIiECwb3w0kD7yyUabMZP4kyoR00bq9DuOl2
	 hyfHQPLnGneipIvrlFWdoCgvdOLkl8/j48qqQnl6Bu35Npi0EUhHsF2AzYLBAYu0UgMMM
	 xub+mtCv20dDB1+RZMKcKW6IXqwFW1RNtFvIL89uoZHwIIbLpTrTx+K+30FRIiplIVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECAqvZmi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D631606A31C;
	Thu, 29 Oct 2026 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECAqvZmi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7750C1F01825;
	Thu, 29 Oct 2026 01:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235711;
	bh=IeVai7414BFTHAGTwhgEP7/ooB/HFDOlmc07AL7nxgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ECAqvZmilqOVTKFJ8qolp8yvMQLx/QSdVSr93C28cvzl/0dxYZCXxgMclau8JKYvM
	 QPnICZw1BDjFIj9n/PPijc33msLgEgd8cMvd5hoYMqY5k60dsG+13SBCRlJX+3Ksxe
	 TBiETsgEiqA9Nk5h1NtWmnC4CAEA371uwU0wThCc9YKWOMmiAYnmm56+7NDzn4CEH0
	 X16wKmenU040CDzh5+aZ3Bb6K4I5l5T969lhWgmr+h+MZ9X/Vx76gXvDG1uboXFruD
	 t3Ml6V9rsfzmb5YJ/9spqNQ7nnxKFwh5gW0zK7o0yRadIOtu+uTHLEn7So14AulCkb
	 dlImzvrIAHX3w==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Bijan Tabatabai <bijan311@gmail.com>,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH] mm/damon: skip folios already on the migration target node
Date: Wed, 28 Oct 2026 18:01:43 -0700
Message-ID: <20261029010144.169906-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179320218513.2.7432933245840036676.damon-same-node-skip@gmail.com>
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

On Thu, 29 Oct 2026 00:05:46 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> While measuring DAMOS migration overhead, I found that the target_nid
> path isolates folios already on the target node, then puts them back on
> the LRU without migrating them.
> 
> Skip them before isolation in vaddr and paddr, as the vaddr explicit
> destinations path already does.

Nice catch!

> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Other than below trivial nit,

Reviewed-by: SJ Park <sj@kernel.org>

> 
> ---
> DAMON KUnit and selftests all passed. In a synthetic same-node fvaddr
> test on a two-node x86-64 KVM guest (8 interleaved runs per kernel),
> guest-kernel cycles fell by about 29%
> with 4 KiB regions and 90% with 16 MiB regions. Median kdamond CPU
> time fell by about 76% with 16 MiB regions, with no clear change
> with 4 KiB regions.

Thank you for sharing the test result.  We don't want to add too much test
results in the commit message.  But the performance part above is informative
and concise, so I think it deserves to be in the commit message.

> ---
>  mm/damon/paddr.c |  2 ++
>  mm/damon/vaddr.c | 22 ++++++++++++----------
>  2 files changed, 14 insertions(+), 10 deletions(-)
[...]
> @@ -858,8 +860,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
>  			goto huge_out;
>  		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
>  			goto huge_out;
> -		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
> -				migration_lists);
> +		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
> +					   migration_lists);

Let's not align parameters on parentheses but just give two tabs indentation.

>  huge_out:
>  		spin_unlock(ptl);
>  		return 0;
> @@ -883,8 +885,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
>  			continue;
>  		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
>  			continue;
> -		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
> -				migration_lists);
> +		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
> +					   migration_lists);

Ditto.

Assuming you accept my humble suggestions above, I applied  this patch to
damon/next [1] tree, together with my above suggestions.  I will repost it for
mm.git inclusion within a week.  So, no action from your side is needed for
now.  Let me know if you think changes to the plan or discussions are needed.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
