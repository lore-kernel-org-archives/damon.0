Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC23876B0
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785614841; cv=none; b=CvNjAzjb878xiGgB6zhcGnn7mNvNwqqKksv/Yq2N9oIFqDeU+UJE9VrG9Fo1uDiWgh5mqTHhDf2uXTjGypJuQEbaLAgjfyyXDsogjA4Ds7TOsICV876vuvrqbGM/oj5Iikqml4v9Df0blcvbgrTk27ehrWdpWuJCJFNCDI6ylkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785614841; c=relaxed/simple;
	bh=4ypZq9om4u3cT5V6ezkzN10h4qeBYt8dqcqi8UMl9B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0LzCQIF2UBVlx/wZsKNYo8bykytT6Kn875/5d8IYhwhYVmNo0xgIQycxx2FilsahJ1ouERyvGE21dXEQr8agVqHab6Xp5FIxT2ph2cI8+vcoAGv2Caa13hu4ZNzTfGYhFQoPS6rRDITU1YjW03YR93+6yHVVigTuaE9Cv83gIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCyHlG+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCyHlG+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7E81F00AC4;
	Sat,  1 Aug 2026 20:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785614839;
	bh=keJw0yJm5+Ml4YDiN9/wpOHdgDNbvL1u+DpWQRw3JYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cCyHlG+/j1KtZOhey8U7HPBtwf/TymneeUeK09Jq/39j2rKoecTGwfqvMuMPYTFbF
	 ut/CRbM7ommz/+yi1zARUxioZ0WNJ4jv3EMSQichfv9eN954y2zBzpeHBcJ7nP2ujf
	 vOsXH1Sd0PJGvYyuBZAExi7LzbEODUIQlSg7KLwh3YSD+8yG+d0+pWo30KTJ5y79cA
	 sJsuIZmN4FVVDzFhAy/zQvyhztdzv/YS0wWs1Tnue8O8dgl7clCkReZlFVvKOgcgkr
	 RLzZX7a3lFIy8GlyARK1HMHH1KGN4zDdqNr9TAVunFlnJr5k5CKUwO73qEjEvxqxtA
	 3H3SR66uAV8aw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/9] mm/damon/paddr: respect folio end for DAMOS_STAT
Date: Sat,  1 Aug 2026 13:07:11 -0700
Message-ID: <20260801200712.114178-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801182102.70BB91F00AC4@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 01 Aug 2026 18:21:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incomplete fix for large folio address iteration boundary bug.
> --
> 
> --- Patch [3]: [RFC PATCH 3/9] mm/damon/paddr: respect folio end for DAMOS_STAT ---
> commit b98d6f7836f4a90b6724f683127a934a339f77d5
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: respect folio end for DAMOS_STAT
> 
> This commit fixes an issue in damon_pa_stat() where advancing the address
> by folio_size(folio) could skip subsequent folios if the start address
> is unaligned within a large folio. It corrects this by advancing the
> address to exactly the start address of the next folio.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 5c6c3a597fd0b..2ab7b3842701e 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -379,7 +379,7 @@ static unsigned long damon_pa_stat(struct damon_region *r,
> >  
> >  		if (!damos_pa_filter_out(s, folio))
> >  			*sz_filter_passed += folio_size(folio) / addr_unit;
> > -		addr += folio_size(folio);
> > +		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
> 
> [Severity: High]
> This is a pre-existing issue, but does this same bug exist in other DAMON
> operations that iterate over folios?
> 
> For example, looking at damon_pa_pageout():
> 
> mm/damon/paddr.c:damon_pa_pageout() {
>     ...
> 		else
> 			list_add(&folio->lru, &folio_list);
> put_folio:
> 		addr += folio_size(folio);
> 		folio_put(folio);
> 	}
>     ...
> }
> 
> It appears damon_pa_pageout(), damon_pa_de_activate(), and damon_pa_migrate()
> all still advance the address by folio_size(folio) instead of calculating the
> exact folio end.
> 
> Could these operations also overshoot subsequent memory and skip valid memory
> folios if the region starts unaligned inside a large folio?

A later patch of this series is fixinfg the bug.

> 
> >  		folio_put(folio);
> >  	}
> >  	s->last_applied = folio;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260801173554.94710-1-sj@kernel.org?part=3


Thanks,
SJ
