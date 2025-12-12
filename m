Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0D13D891
	for <damon@lists.linux.dev>; Fri, 12 Dec 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765543577; cv=none; b=gMbPDSg9oEXG0kSExDrGxUeMCR4Jkkr0NYzVniQ52daNZ7AvEPyB/nhhZ9kK7GEPX+6opTu7iXdhnJ961uasvIL+MIEJGhVmuhw3Eyn0PrRsqaa2U5Y/KyZBKBVuoBTKZLyYz09jfSO8RtHXMvvhXlt5qb2p1qVEf+YkaccO3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765543577; c=relaxed/simple;
	bh=6H2KYgH+XZqen82sxWQdSGEPG7omAPRoI3c0FktDdKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGDuZZsWDp76tTjwxTsrQvigCH0dlAT4gmd2Tts0Us6tYtiNzth8QaWpqR2FwLR3w6ymHABhD5gisQ6336sxI/xbix0nXz2R5vtvwhd0XK0szWM9LwcqLC1x/z3ne+ny3Qx0DisGEHEuMUjnsEpYEfl899G4FtQla+PdtMV58QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIdMy4FC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIdMy4FC"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78d6eb6956cso11154757b3.3
        for <damon@lists.linux.dev>; Fri, 12 Dec 2025 04:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765543574; x=1766148374; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nA7IxAffT0jShcW8gwjmTQr11pMi+BjOFiGJxDMKjNo=;
        b=RIdMy4FC8KK5ola8O8aUD9VnVhl+ynYQyj0U0p7haJDIn2oZAfLmIVcILb5GSbkXuB
         TyLTuUPgj2BI4R0jc2qMS8y7U4ytG4fPwDltSAIrwxz4AbnxombPhOgESWFwBWwk0DJl
         Ao9h6feLR5kdLBMq6QKENUf35R1NYRk/wdQ5S9C4va6nYZZfwaRrGqMwm7cExPY7/0gA
         ryZe+S1KWa7AJYR28KVZoDN0qISunV4hNsqFvHbeHfFDJmu4GAAmUZMNZxrRXG3nQVWi
         By1CxR1rL1Z5yQnlxgUvM8JbJsfvnX06jdrEqQCgH/gj7nvIyrwjwtD4zpz6QEsxUgsQ
         kFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765543574; x=1766148374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA7IxAffT0jShcW8gwjmTQr11pMi+BjOFiGJxDMKjNo=;
        b=Niem57CcUWIe5j/nfl1wNEf107ZfGnLrd1+RDl1QSRa53rKJ3k9m5CBpTDRvdMMHD+
         2owPsDrNMPV1a2EZovcGn32XNPA9Iee7SKg/7+12SQbsR1B20UodjLuMvqU6sID2jnAl
         lSRjVqztO+GjbjR+bBnsSZZVZDbmgzKrwnmshm0+VdiPbOX9amOVPhKWoj3bL48InohQ
         dNMcrJHn//lyHOOKfSw0h7IP4idX/BdfexN8Jap1h2EqnIe5zA5isN5g9NJ5PQLj4iju
         OL5hxYoookV19zPkSi14jTrTACQzPCO/36vFCIyKY/w8GF2J1wkMgjkeWj6cTpnFYCOC
         GUig==
X-Forwarded-Encrypted: i=1; AJvYcCUlD4fTXiVpvt/2jSbrQXi2lpcabWdd1ptsDMAAxlgWrYR+c9r7uA0f5XMHqLZGlSL6/QfQ0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvYFOHsARjZBJ4BvEgCVL5Jd5AATc02U5w/LgN4FIznckSlKOI
	tCGz5EXeHWZTVO6tLaK/0FNylboS5OfOXdiODPh8Rk56mFi9O9P8lxa18gRUQRxAN9dNdtSazO+
	I5kHYnpVo8FG/AaR6xHnO7pWmLZ+btNg=
X-Gm-Gg: AY/fxX4NXjAj88VxBFEFb63V4rX24lqiXcC9ya5Weegt9MtWyxVd+wfz+M5yxFowk1/
	SzqdQ34rzaD919kqu5ZqSUNwqD3gN1u1slIYUmOvPWJCUr2hZOqIQuc2yTj1MmSqfyKiNjzcxPE
	kqmRBBJb0WuWX41Dh6TShxTU9stHwJgXR9hQpEukXHixtmTNLQNaX3haOdLEmelengi202B39Ih
	Ex+xuEarth5ajXFBrgvGAoXeW32Ra4xa6C3DTK5v2P1d6z0ipbOddRocwZVkgiqOjAw4phr
X-Google-Smtp-Source: AGHT+IHz3KgQ+bSNndy9mQEOrCQS3hjN2SHmQrqtmhCRSLsPMmyLQIeagCd7ClGGQ0WC1mwsePEjbW190wH0H0L6KUc=
X-Received: by 2002:a05:690c:4b0e:b0:786:5be2:d467 with SMTP id
 00721157ae682-78e66d45ca3mr15244917b3.3.1765543574467; Fri, 12 Dec 2025
 04:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251208062943.68824-1-sj@kernel.org> <20251208062943.68824-5-sj@kernel.org>
In-Reply-To: <20251208062943.68824-5-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Fri, 12 Dec 2025 21:46:03 +0900
X-Gm-Features: AQt7F2owg67X9ZNKOIXuzDIfqmLKkjj8_msgVF95SsQ8FgSGWYFqbNql5MoYxeE
Message-ID: <CAHOvCC6B1q+1TLEw5WAQM+E_L2tQQArgq=Hy5JZ35m4_H7s_5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/37] mm/damon/core: implement damon_report_page_fault()
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Dec 2025 at 15:33, SeongJae Park <sj@kernel.org> wrote:
>
> Implement a DAMON core API for reporting page fault events to DAMON.  It
> is a wrapper of damon_report_access().
>
> This is a temporal hack.  In future versions that will have no RFC tag,
> only damon_report_access() may be used.

It's a minor, but git am throws an error when applying the [RFC PATCH v3 04/37]
patch file.  I am testing it by modifying it as follows.
damon_report_access() is
called by damon_report_page_fault(), so they depend on each other.

#ifdef CONFIG_MMU
void damon_report_access(struct damon_access_report *report);
void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd);
#else
static inline void damon_report_access(struct damon_access_report *report)
{
}
static inline void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
{
}
#endif

Thanks,
JaeJoon

>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 10 ++++++++++
>  mm/damon/core.c       | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index b9359c76a6f1..b8ebb2aa02c8 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -1017,6 +1017,13 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
>  int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
>
>  void damon_report_access(struct damon_access_report *report);
> +#ifdef CONFIG_MMU
> +void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd);
> +#else
> +static inline void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
> +{
> +}
> +#endif
>
>  int damon_set_region_biggest_system_ram_default(struct damon_target *t,
>                                 unsigned long *start, unsigned long *end,
> @@ -1027,6 +1034,9 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
>  static inline void damon_report_access(struct damon_access_report *report)
>  {
>  }
> +static inline void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
> +{
> +}
>
>  #endif /* CONFIG_DAMON */
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 89305d42e116..296117d5e7f7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1579,6 +1579,23 @@ void damon_report_access(struct damon_access_report *report)
>         mutex_unlock(&damon_access_reports_lock);
>  }
>
> +#ifdef CONFIG_MMU
> +void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
> +{
> +       struct damon_access_report access_report = {
> +               .size = 1,      /* todo: set appripriately */
> +       };
> +
> +       if (huge_pmd)
> +               access_report.addr = PFN_PHYS(pmd_pfn(vmf->orig_pmd));
> +       else
> +               access_report.addr = PFN_PHYS(pte_pfn(vmf->orig_pte));
> +       /* todo: report vmf->address as virtual address */
> +
> +       damon_report_access(&access_report);
> +}
> +#endif
> +
>  /*
>   * Warn and fix corrupted ->nr_accesses[_bp] for investigations and preventing
>   * the problem being propagated.
> --
> 2.47.3
>
