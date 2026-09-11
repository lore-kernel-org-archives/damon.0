Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3D375ADD
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121081; cv=none; b=FOLrJ3CZgt+Rs1Y5eK0OVCQSCw9/xo9mdUWZIEFCGH3AzhljRZqysmFFQS/Klpe7I6Ph2M3CMpqsunOQC2Kn9b4ad2DPf5QEz7ULIh1+3W0K2SUgb6fXuRJ5zt1WgJKRzhGOUbZea2OvDx2/nqEQz5sVlXgZISbwx95LbcFw1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121081; c=relaxed/simple;
	bh=I25+yut4NdUZ1Sr7JuktfsvDsRjtjZ3ZaLauNYYdOFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5aAEStmTbD1B7wQly98/aYW9cewfHbYJFreu1qIJCywgiTFla50NfsVOb5KMgBqBtMblLcirw/ZQMvyYUdg67yUuAir7Ujm86YtsNuzEf4ZEoZ+rlALqjoBgQe2bRWh7vHrbAvSIIeutOULGFBlTNEu2wWF/u6gWD0UiqqmIY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4HHs1VZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4HHs1VZ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso610657a12.3
        for <damon@lists.linux.dev>; Fri, 11 Sep 2026 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789121075; x=1789725875; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eGxseeOS2BtWoFf00OyiAKmDRr1RXqvuTr0ihtThX8U=;
        b=G4HHs1VZeAouzMze+5hS9r3FNuIUyN8kVYBDHt1DiYeBGcgIA6BCjvkV6r+4Qi+N08
         HEq1COJMCvEqJ213YCZAncHd8tkVq4Uv0C9hY/sPGkYfPoala/T/mhjOogb4tlbqQS/g
         kUGOjSIjRLcJtsEsXLFss4cJ04cjkWSShMukJgz/QXJeiwC0CvNb1RGDYzH1/mL4pGq1
         csu9Z3j4ju/TTgcrky3i1dVI6IGVt14uHNxrDQsU61EvU00o8suPuZKaU/GQeWng3FUr
         DAnSnH/ZbJKWiCbHgxFv7vbrJL3ATp0MUu26W94LAXhV2gOT668zczH/yTnqX7jmKrWc
         U6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789121075; x=1789725875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eGxseeOS2BtWoFf00OyiAKmDRr1RXqvuTr0ihtThX8U=;
        b=c9uN77nvLT8yJydLUrA3W2cHvxaVftIrwyRXdyXPgkYqi+ZoG4OwMjUvWIAAtQroc4
         J8juOmr+lRaWwAzsGOYu6A0WYBAZ5Gld5AXFSDJb1RVKUahw+hUkJItiYX0Fwc1oCsZ6
         hbwosSe4zPbG7l2KyYYK+HJlm6nE0vEa0DJDyIciyC8uW6gnRZoapxHprJntJ8pCjg4p
         NN2kDUv3p291Ia0DfngWSH7miSwTSPxNDXMbX0oJf9rs54S1k7jS890LC1xg7n4gijoP
         kdOKAwbruyWFtQk1RU22cBEshWOgtBGQOQ91I11jSbnKoHSSyGy06nj0wOB2wRN1bMfG
         Yirw==
X-Forwarded-Encrypted: i=1; AKwUvBxmCHJHi4+RaR3LLjL9mZ/JO7KOupNmmGrulRjgiEzbTpE08Wy28Bk59zPh5hsti76hdR3emA==@lists.linux.dev
X-Gm-Message-State: AFuF++nIP95+JtmOhT44S8UUmrppH7fKI8DE4ATTWPGs4lG9M54ugDNf
	taqPbpiMSIw2K2xI0/hdX1EdLZfA8Uw1iMsmPhmIDimCm0NLRG+GFZP/
X-Gm-Gg: AYBFou3+UqCYzfsI3jOxn0npMox1cAz7DK1UFGaWKqNx2y4BNnWkgMqoA0RIfMbqsTN
	MVxrew0ByitVe91ypZ24zzTdUl6SkdM/quaefQgm54n6eJpvhiegDjzx6WUE8LXKVlZ6sCaXyY3
	m2jxGyuTmO8pHWmGW6Q5pW84yY/wlVtM3Jm3T5a+l7KHvQQdLgGwxUL+eFar9eNUxLXVJI0koLj
	9SEc+U/IgyZzwEabbiwCx5NecR+6M+2Y1wXNhI7pTyPl7ZQ2pLq8sqGCE6SDwXOTTBGrYGuov3h
	EU4oVrgwvTUP/dZb6iXat+VeRk+1Xs4rf/CT1P6r56r/tdQ7L/Yvf+r0HJsdpdQVgnQgM5oLVM1
	Gm0lGI6AnM4SFk/Vg+YwiO98cT85NoUeRY8eCEwl6qytZmiISrH11OdwJJqiGUTDZ9oPCS2XXPg
	fqCnTMmm3E819lIArPxPp1dqf0KtXgftyY3c5SDez2ddfrNgWPkezZ7MzgiPWgUks9Bef9Fw==
X-Received: by 2002:a17:90b:3885:b0:398:c794:ca26 with SMTP id 98e67ed59e1d1-39d9c3944aamr5330624a91.25.1789121074583;
        Fri, 11 Sep 2026 03:04:34 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95864b85sm4681860a91.14.2026.09.11.03.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:04:34 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH REPOST 5/5] mm/damon/vaddr: support pgidle_unset probe filter type
Date: Fri, 11 Sep 2026 18:04:26 +0800
Message-ID: <20260911100427.2804601-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909140408.104699-6-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  9 Sep 2026 07:04:07 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON virtual address space operation set (vaddr) does not support
> pgidle_unset probe filter type.  Add the support.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/vaddr.c | 55 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 45239f05e113b..9a38dc89a156e 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -522,13 +522,49 @@ static void damon_va_prep_probes(struct damon_ctx *ctx, bool set_samples)
>  	}
>  }
>  
> -static bool damon_va_filter_pass(struct folio *folio, struct damon_probe *p)
> +static bool damon_va_young_addr(struct folio *folio, pte_t *pte, pmd_t *pmd,
> +		struct mm_struct *mm, unsigned long addr)
> +{
> +	bool young = false;
> +
> +	if (pte)
> +		young = pte_young(*pte);
> +	else if (pmd)
> +		young = pmd_young(*pmd);

Hi SJ,
I see that all callers already check pte_present() / pmd_present()
before calling this helper, so I don't see a correctness issue here.

However, the other DAMON young/accessed helpers, such as
damon_pte_young(), damon_hugetlb_young(), and the PMD path in
damon_folio_young_one(), keep the present check together with the
young check.

Would it make sense to keep the same check here for consistency?

Thanks,
Kunwu

> +	young = young || !folio_test_idle(folio) ||
> +		mmu_notifier_test_young(mm, addr);
> +	return young;
> +}
> +
> +static bool damon_va_filter_match(struct damon_filter *filter,
> +		struct folio *folio, pte_t *pte, pmd_t *pmd,
> +		struct mm_struct *mm, unsigned long addr)
> +{
> +	bool matched = false;
> +
> +	switch (filter->type) {
> +	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
> +		if (!folio)
> +			matched = false;
> +		else
> +			matched = damon_va_young_addr(folio, pte, pmd, mm,
> +					addr);
> +		break;
> +	default:
> +		return damon_ops_filter_match(filter, folio);
> +	}
> +	return matched == filter->matching;
> +}
> +
> +static bool damon_va_filter_pass(struct folio *folio, struct damon_probe *p,
> +		pte_t *pte, pmd_t *pmd, struct mm_struct *mm,
> +		unsigned long addr)
>  {
>  	struct damon_filter *f;
>  	bool pass = true;
>  
>  	damon_for_each_filter(f, p) {
> -		if (damon_ops_filter_match(f, folio)) {
> +		if (damon_va_filter_match(f, folio, pte, pmd, mm, addr)) {
>  			pass = f->allow;
>  			break;
>  		}
> @@ -543,13 +579,15 @@ struct damon_va_probe_walk_private {
>  };
>  
>  static void damon_va_probe_folio(struct damon_ctx *ctx,
> -		struct damon_region *r, struct folio *folio)
> +		struct damon_region *r, struct folio *folio,
> +		pte_t *pte, pmd_t *pmd, struct mm_struct *mm)
>  {
>  	struct damon_probe *probe;
>  	int i = 0;
>  
>  	damon_for_each_probe(probe, ctx) {
> -		if (damon_va_filter_pass(folio, probe))
> +		if (damon_va_filter_pass(folio, probe, pte, pmd, mm,
> +					r->sampling_addr))
>  			r->probe_hits[i]++;
>  		i++;
>  	}
> @@ -574,7 +612,8 @@ static int damon_va_probe_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		folio = vm_normal_folio_pmd(walk->vma, addr, pmde);
>  		if (!folio)
>  			goto huge_out;
> -		damon_va_probe_folio(priv->ctx, priv->r, folio);
> +		damon_va_probe_folio(priv->ctx, priv->r, folio, NULL, &pmde,
> +				walk->vma->vm_mm);
>  
>  huge_out:
>  		spin_unlock(ptl);
> @@ -591,7 +630,8 @@ static int damon_va_probe_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	folio = vm_normal_folio(walk->vma, addr, ptent);
>  	if (!folio)
>  		goto out;
> -	damon_va_probe_folio(priv->ctx, priv->r, folio);
> +	damon_va_probe_folio(priv->ctx, priv->r, folio, &ptent, NULL,
> +			walk->vma->vm_mm);
>  
>  out:
>  	pte_unmap_unlock(pte, ptl);
> @@ -615,7 +655,8 @@ static int damon_va_probe_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  
>  	folio = pfn_folio(pte_pfn(entry));
>  	folio_get(folio);
> -	damon_va_probe_folio(priv->ctx, priv->r, folio);
> +	damon_va_probe_folio(priv->ctx, priv->r, folio, &entry, NULL,
> +			walk->vma->vm_mm);
>  	folio_put(folio);
>  
>  out:
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
