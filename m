Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A4BE6C
	for <damon@lists.linux.dev>; Wed, 30 Jul 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914282; cv=none; b=famWPblF6RA/w4N0jB57CdHFfiFE1iPetxpOs6AHqxaAYWlgogczT8LiehefFQbD8EufSvw3CxHz+fbc5cEfAqAw4tRHMCpfRrxVw7ZN/sW6fS7Ls1RCqlDVVFwEobXU4uT9uHRmx15Te7Kg9sdFUrOVL6MIh+N1zKyvrw+m6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914282; c=relaxed/simple;
	bh=EX1pUNxp1hbod6lA6ki6m6Q9fp/HW28UG7wPzYiWJ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e09Hp6TS+4pH6NEb9MpOk2satMJj0vM3ZYhnFuRM3GERCF661lFY/4LSYXx+7ZWIlP/Sg4cQmMk6g30aEgsNkRfPI1sdYJBF8A2+CJVKOIfE9moO/vUqD0+ERcL2kC/HJUYey8hM6PrurBrfoJukhsoOW7hS0pUCq+58U8NR34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blTpLiml; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blTpLiml"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4561607166aso2024135e9.2
        for <damon@lists.linux.dev>; Wed, 30 Jul 2025 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753914279; x=1754519079; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCbT9/cz+rXGQ8ARnOwy7QkIK/KpaHmQmlR+7AOK0Pc=;
        b=blTpLimlSVEMCV/NraKbgYt4gDPY+ECEMIX2JzIO/NpAoqHz0BqryoQ3P8vRx2nvfh
         KqE2xjRNbtR3mUE9jj2IdFnhcaIQ/9uMDRXJ+JrbKuTr1fB/iyblk1obJGqTe/z0nVCK
         4xid9bDTdb49Z4mhJ21Ad0biyQdxtFGk2SKc1jmOuFblNUo3/aWIAHXQOKIYevMXKu8u
         I55kH0yBTILEbvep3StP2kAiyotwb75VugKZWR/8twcSUi1Xiwn6D2hQDdFJ6jZAg8a9
         qRZJMYLZ28wICOh0BXENEx37HNqVfmU98p4V7ArdPIY6OXJL6GQeM3sa36V1oeJVrcOL
         zsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914279; x=1754519079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCbT9/cz+rXGQ8ARnOwy7QkIK/KpaHmQmlR+7AOK0Pc=;
        b=XIhJyjuMFK6I3P0/mdTKrFt5troHt8A6jJGDDyMLB57j1/BGftW9LpO1dAPlDEy4gH
         IKMn8pPHb0q1W5/Hsm6dJ6h758hHdrs7ZKenx1w+rcNm4rUbcwQNnZ1fbQc0VyvH9+St
         yldDO18B9h8vKl4sYNAqqRpxd/TqRCPZLlH19Xr935lmk0YBAKaKPH6J3btIcsYb0UuW
         G4eRGui0s17QilQBMKfLIcvqXr99waZeQQ2WGYp4nQUtcwWvRBrXBCQD0fXEcGMgqoYR
         OYM0I1qKB/36th/9LBvb5WNo4zpO9CJqmjpSC2jO3YpnRCnoFb+LdmzuqJQIP31qa5YE
         Ed0w==
X-Forwarded-Encrypted: i=1; AJvYcCVmhyJAZ/fNpEfazS0FE4FL5zLL0KHYNynOY5QMewLQ7JVgzY5tXtkJ61CTEyrWIpuEHLWjVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxivrx/g8R0mscg3wyU8n72IacS+9vxnHyYvrH28q+9eXi/Cq2U
	gBRvbBlcooSuGWuVEfJ/10VfPMj2AT9h2VKUkCalTvXB0MNjrxBC9K9M
X-Gm-Gg: ASbGnct0jlH+53bkAk70qoNEiNMuZP+R2LMlT7z/7Vhf+/YBRWxKTfeFoRArI6NXzgv
	YoTHum8oqiU70SO1q/WjDC9NNomr9971IJDoLC7JVVX02WHHyfeJs4hAdnHoWnTJn7smEcCY9W1
	AnkG98NytVPRzVmSmj4ly5nprwzpD4XiaNEVJ4CmNxeHSTabWS2t7rCWIFIbm5A7MXpw2Mvjr3l
	heiJI6m6n6a2MIF4ORtSeSh59wO9yjyvxVopEsAhMrylZLNa5WEllNiGshglgYB56vu84b+i55W
	QsHZkI1qRTO7cxmSv3Y5rRXKbNYUO2fu30nJgu4LCg9Tt8EuVXWcbgcQJJQ9AlSV5Ti5gWVtmUp
	EGMA6/lSkgmK/u/Ko1zufXeqZmzBLL2XreiOXGw==
X-Google-Smtp-Source: AGHT+IEHwJ0OF/CEB1lfb4+OzjypEm8jkKSqIIDGkUMeRFWaULpe2YCUA7fNQcqZpUUGznElVR0FJg==
X-Received: by 2002:a05:600c:4fd3:b0:453:697:6f08 with SMTP id 5b1f17b1804b1-45892bd1a95mr42393275e9.26.1753914278856;
        Wed, 30 Jul 2025 15:24:38 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953f8e0dsm41450315e9.31.2025.07.30.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 15:24:38 -0700 (PDT)
Date: Wed, 30 Jul 2025 15:24:36 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon: Add damos_stat support for vaddr
Message-ID: <aIqbpFsoqbt77j8f@devbig569.cln6.facebook.com>
References: <cover.1753794408.git.pyyjason@gmail.com>
 <44a30f700fdcf4470318ef5cd248ba98c59b77a2.1753794408.git.pyyjason@gmail.com>
 <0cb3d5a5-683b-4dba-90a8-b45ab83eec53@redhat.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb3d5a5-683b-4dba-90a8-b45ab83eec53@redhat.com>

On Tue, Jul 29, 2025 at 04:11:32PM +0200, David Hildenbrand wrote:
> On 29.07.25 15:53, Yueyang Pan wrote:
> > From: PanJason <pyyjason@gmail.com>
> > 
> > This patch adds support for damos_stat in virtual address space.
> > It leverages the walk_page_range to walk the page table and gets
> > the folio from page table. The last folio scanned is stored in
> > damos->last_applied to prevent double counting.
> > ---
> >   mm/damon/vaddr.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 112 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 87e825349bdf..3e319b51cfd4 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -890,6 +890,117 @@ static unsigned long damos_va_migrate(struct damon_target *target,
> >   	return applied * PAGE_SIZE;
> >   }
> > +struct damos_va_stat_private {
> > +	struct damos *scheme;
> > +	unsigned long *sz_filter_passed;
> > +};
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk)
> > +{
> > +	struct damos_va_stat_private *priv = walk->private;
> > +	struct damos *s = priv->scheme;
> > +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> > +	struct folio *folio;
> > +	spinlock_t *ptl;
> > +	pmd_t pmde;
> > +
> > +	ptl = pmd_lock(walk->mm, pmd);
> > +	pmde = pmdp_get(pmd);
> > +
> > +	if (!pmd_present(pmde) || !pmd_trans_huge(pmde))
> > +		goto unlock;
> > +
> > +	/* Tell page walk code to not split the PMD */
> > +	walk->action = ACTION_CONTINUE;
> > +
> > +	folio = damon_get_folio(pmd_pfn(pmde));
> > +	if (!folio)
> > +		goto unlock;
> > +
> > +	if (damon_invalid_damos_folio(folio, s))
> > +		goto update_last_applied;
> > +
> > +	if (!damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd)){
> > +		*sz_filter_passed += folio_size(folio);
> 
> See my comment below regarding vm_normal_page and folio references.
> 
> But this split into two handlers is fairly odd. Usually we only have a
> pmd_entry callback (see madvise_cold_or_pageout_pte_range as an example),
> and handle !CONFIG_TRANSPARENT_HUGEPAGE in there.
> 
> Then, there is also no need to mess with ACTION_CONTINUE
> 

Hi David. Thanks for your comment. I was not aware of the convention so I
followed the existing code. I had a discussion with SJ today and in the
next version I will change this by combining *pmd_entry() and *pte_entry().
We will also format the existing code in future patches.

> > +	}
> > +
> > +	folio_put(folio);
> > +update_last_applied:
> > +	s->last_applied = folio;
> > +unlock:
> > +	spin_unlock(ptl);
> > +	return 0;
> > +}
> > +#else
> > +#define damon_va_stat_pmd_entry NULL
> > +#endif
> > +
> > +static int damos_va_stat_pte_entry(pte_t *pte, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk)
> > +{
> > +	struct damos_va_stat_private *priv = walk->private;
> > +	struct damos *s = priv->scheme;
> > +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> > +	struct folio *folio;
> > +	pte_t ptent;
> > +
> > +	ptent = ptep_get(pte);
> > +	if (pte_none(ptent) || !pte_present(ptent))
> > +		return 0;
> > +
> > +	folio = damon_get_folio(pte_pfn(ptent));
> > +	if (!folio)
> > +		return 0;
> 
> We have vm_normal_folio() and friends for a reason -- so you don't have to
> do pte_pfn() manually.
> 
> ... and now I am confused. We are holding the PTL, so why would you have to
> grab+put a folio reference here *at all*.
> 

Thanks for pointing out. I thought someone could still change the folio and
realized it could not happen with PTL. I will use vm_normal_folio* in the
next version.

> -- 
> Cheers,
> 
> David / dhildenb
> 
