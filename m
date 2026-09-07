Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33F388E4F
	for <damon@lists.linux.dev>; Mon,  7 Sep 2026 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788804289; cv=none; b=kQAdoPSPzDyAZUluWaReDYMwSBsHPThqlINRu8onS4tXCeMM3LpT0eBG/CJXAtei7kRkJg+/3JMZXYagOOFnXBBNnWEu598XulJB9Q6PdZTPNMj53NQsANKB5247ZnEFcvfm2m8sXLlG/kyYL4GJmwfWwzJJoYYnk8W0xppsOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788804289; c=relaxed/simple;
	bh=o9Mn7QT7SYiieB1IWqjd5fr6LK4RLF2n13rNFgTvDpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhArP1ld8HiejZPAQXJBLmmsWI/a5OOKIHuY5UewwLJdThrpOL9HRPuTJH1jnSTLfsrkPY9DrAw7UbWxvyBUiEn5t4y7I50nFLAtJL7fpE/WsQDy/Nnhc9spbJunD51sMaktuWablF0IaGNLNN0z9SR5opl6WegqxQKmukMSacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTYzzV/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTYzzV/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05DC1F00A3A;
	Mon,  7 Sep 2026 18:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788804287;
	bh=tXeqR/9DQ2wSTeNYghCSvEBgYUDmRAHCHzrjUnXqPxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TTYzzV/85JI33fZ3U7NPhvcFdXE0GLBLFqtseIsJdPqhVr/BwP6TwVyIPjODOukvk
	 xjt+sw4qQ3GJ/uUkrtCToASzoZteD/iaXLvz8xItMQqurM0mGAInL4nVb1QXwZ/GOT
	 w5gk1F8xXXelHF9tb2Ekazdfe+6P4gok0eJ/hFIK1f8NhuHr0GZTCRP09xEVzMaMs1
	 K4odXQT1cYgrSZjN3+abdAZ7ZIy0zTcCblmVcdTIO7hJnh8YG5abkmg4P/D7ba4LFI
	 +aIbIqXIUp3k4/MzaiYeuAeaSERXABUydEb3GClaqHyE0zqlJh7ZaQtSAnhbCcvZ8l
	 rO1f1dlLi03qA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()
Date: Mon,  7 Sep 2026 11:04:39 -0700
Message-ID: <20260907180440.102717-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907171613.A09B11F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 07 Sep 2026 17:16:13 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Modifying contiguous huge PTEs by clearing and re-setting without an intermediate TLB flush violates Break-Before-Make (BBM) rules on architectures like arm64, potentially causing fatal TLB conflict aborts.
> --
> 
> commit 1fee0c4237cb61938cdabe61cd4adf713c7ddbec
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()
> 
> This commit attempts to prevent hardware-driven PTE updates (like dirty bits)
> from being lost during DAMON's mkold operation on hugetlb pages. It does this
> by replacing huge_ptep_get() with huge_ptep_get_and_clear() before calling
> set_huge_pte_at().
> 
> Link: https://lore.kernel.org/20260830160545.98969-1-sj@kernel.org
> Link: https://lore.kernel.org/20260906195417.103263-1-sj@kernel.org
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index f884d3f78f30a..91a0d441c1f94 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> 
> [ ... ]
> 
> > @@ -283,22 +283,29 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  }
> >  
> >  #ifdef CONFIG_HUGETLB_PAGE
> > +static bool damon_hugetlb_ptep_mkold(pte_t *pte, struct mm_struct *mm,
> > +		struct vm_area_struct *vma, unsigned long addr, pte_t *entry)
> > +{
> > +	unsigned long psize = huge_page_size(hstate_vma(vma));
> > +
> > +	if (!pte_young(*entry))
> > +		return false;
> > +	*entry = huge_ptep_get_and_clear(mm, addr, pte, psize);
> > +	*entry = pte_mkold(*entry);
> > +	set_huge_pte_at(mm, addr, pte, *entry, psize);
> 
> [Severity: High]
> Does this modification of contiguous huge PTEs violate Break-Before-Make (BBM)
> rules on architectures like arm64?
> 
> By calling huge_ptep_get_and_clear() followed by set_huge_pte_at() without an
> intermediate TLB flush, the hardware might cache conflicting contiguous TLB
> entries, which could cause fatal TLB conflict aborts. On arm64,
> huge_ptep_get_and_clear() clears the constituent PTEs but does not flush the
> TLB. When set_huge_pte_at() is subsequently called, it skips its internal BBM
> TLB flush because the PTEs were already cleared and its internal validity
> check evaluates to false.

But we are changing only accessed bit.  I think BBM is not required for this?
Please correct me if I'm wrong.

> 
> > +	return true;
> > +}
> > +
> >  static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260907170358.100168-1-sj@kernel.org?part=1


Thanks,
SJ
