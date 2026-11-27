Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795819202;
	b=g7P63Okz82zPfu9FnmBvumlypsX3q8SGhZAATZFSBp9Gve3ZVH1K8pXhX3s8FYw9JR21
	 NuIggQ7ChiAEFy/mrvdbkdN5agw8TG6KadH2avlSk2Jp6d6ggTbHpnOmbIero/zeiC1mX
	 khtm1S5jHpGmlOea3C9nSgEvgEeN+SO9PsxpAvt5FwTOYaJRRpcqXz/KlzimJ97ztqLuH
	 fbbHpuu6xQmhfp7cuiT+KwrzbEzh9q5FYQ02dbi495ru1zJ/fv00y+mTP0xKO4cS0rjcP
	 G4ynyU+1Y/neWgtTbQH1dy85crVPXch6IyqirN0rzWebgsHHCdlcqaR46mXr5Rb3EcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795819202;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TqVl7s3nCL3EDQZMn8pCExNUlPAOriUN8Wm6x4Ff9ew=;
	b=iJe07aPKw/O8DfqtuDfHTQt2N/EFCxBARC+95FqV8nU9iL1Lu4vCrqEBtVJBhZv9bS+U
	 l85FYl3U+UPj6u2qeLmEFEXgG+PNPx/9HjAZ5R9/1eC2Q8s8Zm0pQTOWcrVIf41m25+i5
	 TGyparRJR2nndk5Zwmb2El04UWFSb85bAB+vCyHKpaHtr5i3a7jbToqkw840hZRueVGNJ
	 U7lS0Npo4UeE5VM7kcwvI0Vw1pnY+KQ03vDJhzzna41m72XsfrGpVo9ArCyHpJPpXoBzC
	 tTc2l//SSUSNMX771TePDLjg2u6Q22FsAGgR8hFQ17OhSX3rEOjC2QdgeMuIdChA5Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PeGrTfdG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA6606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PeGrTfdG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6511F00897;
	Fri, 27 Nov 2026 22:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795819202;
	bh=TqVl7s3nCL3EDQZMn8pCExNUlPAOriUN8Wm6x4Ff9ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PeGrTfdGw9ydlbpYBaZXm5Z/VqhuWvVZ/+ORT2L8ah+7bHk0KhTMV2Dq8vueRarlZ
	 BvwtW+h7rML7WAVPlcxjc6hNEmbDSCcglK2wMyKNtENm2Y2WH8a9sUXXyiqWl9e0Jv
	 SmUUSH81nE14kP1dVUKINzHpnesu3npKgU+ENrelZlvzZaEEoqJYJjlls/ok7PqaFm
	 hdG7d7Zq2SAMCo8RZ6L4OQwL3l+flxYGWEhw1bj/He0i0sDgqAIW+cECGMKDrGj1Q3
	 L9lRxwaiStycJ9j68BjxxcKGBP9/A3Z5b18TZD0876Ywr0Gb867xLzXL2ShwarAMSr
	 WykBvmW8S2OGA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 2/7] mm/damon/vaddr: use damos->last_applied for migrate action
Date: Fri, 27 Nov 2026 14:39:54 -0800
Message-ID: <20261127223955.106119-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-238332@kernel.org>
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

On Fri, 27 Nov 2026 22:33:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] mm/damon/vaddr: NULL folio dereference in
>   damos_va_migrate_pmd_entry()
> --
> 
> commit 28e5ee87b052dd198d574f424c2cf49c18aacf24
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: use damos->last_applied for migrate action
> 
> This commit updates damos_va_migrate_pmd_entry() to track and skip the last
> applied folio via damos->last_applied using damos_va_invalid_folio().
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index ca7ce9bd96e7d..c8f93a19c840e 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> 
> [ ... ]
> 
> > @@ -881,10 +888,11 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  		if (pte_none(ptent) || !pte_present(ptent))
> >  			continue;
> >  		folio = vm_normal_folio(walk->vma, addr, ptent);
> > -		if (!folio)
> > -			continue;
> >  		page_idx = folio_page_idx(folio, pte_page(ptent));
> >  		nr = folio_nr_pages(folio) - page_idx;
> > +		if (damos_va_invalid_folio(folio, s))
> > +			continue;
> 
> [Severity: High]
> Can this dereference a NULL folio when vm_normal_folio() returns NULL, such
> as for the shared zero page or a special PFN mapping?  Removing the !folio
> check before folio_page_idx() and folio_nr_pages() passes NULL into
> folio_nr_pages() -> folio_test_large() before damos_va_invalid_folio() is
> reached.

Good catch.  I will restore the !folio check.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261127222719.105510-1-sj@kernel.org?part=2
> 


Thanks,
SJ
