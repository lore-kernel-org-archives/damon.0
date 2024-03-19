Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7A4C90
	for <damon@lists.linux.dev>; Tue, 19 Mar 2024 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710809502; cv=none; b=LR8kWj2IgDjSi6+1kytGrKaRKFEE6sEfLyd5UCZsYj/g+LO0T6pjiXT1FfNpk2HdhAR+dxJk15+QReKShDdWRtfS4RQUhXxKbPKAHt2TIYmoRvxboYP5ZSQhE6Lg0Z9JuoTAfiC09Nb6S2YPGkKmVQvqk1A/AOSgkeevyIk8z4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710809502; c=relaxed/simple;
	bh=HBeMcQvgxDv8cJ7fNi77ty7lDhfxxyKirL3rYdRCbzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z99Wwr9gBqcn9EqiIbI18TL+f/9zIjRx7nYBwiCFAjr7NYYV0zyQbaWn3EGNf4t558AeO2U/69iIcsTkOppp/sxWe5EvFEfUraUGR1ZL2GubdlA3E7FtSizB+mrkamMRcg1vJ/5iSXF0tcxRLFsofT3NrDDijzvC4CuHEK6Queg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVFnJE4g; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVFnJE4g"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4140eed8a4fso32865e9.0
        for <damon@lists.linux.dev>; Mon, 18 Mar 2024 17:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710809499; x=1711414299; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubavkzthuO7FFM43XgPG5WP9PAb9aevt0/P5aVLiPkg=;
        b=kVFnJE4gWmLFKVsC4zIEe+0BWhdGhrgfcBQL+r0d8+EqvBIhQbUu+b11Ra/Lg2zFAU
         T+oQ3hnRn/gm98sDWdKam7qenFQ8yJvdq5r9n3IWy2SB9d+7wUoq7dy0kFNxsQ+T+QI2
         wsfHekRlKoxzAZCCsDvRB7gZT3JM1zatBbvNa7CifA1aGB60yqBOMC0Rb6x5BHw9RvVe
         B1Ooo7tmHPWH6+ssIpqziO5PcbkR21wTgrvNwpzZqUCrJIM6XsAAqBeIdhHZull9bBtA
         GUf6UIDf9U9Yt5JpFmNkItUbOPXWUruxwqd+Kh/7vIxqpFdoW60unqFP9iFyI5j1JEo1
         uX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710809499; x=1711414299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubavkzthuO7FFM43XgPG5WP9PAb9aevt0/P5aVLiPkg=;
        b=YuGyVpLOV7PgLS6noimR1r6+jwS/NUE6BE/QANpgxZP3riaIL0BeFMhLP88ibbnOq1
         DxS1OfCUWpLL7zNWNNKWY1gFh8rSFunYtJfHeGrwubdm2gTmVbVViCthpjpf5IK6WpIe
         PLVQlXMaXi2KXD6r69QRtGtta2RLenjt62byaK//Fh7GCJ9E4ZBnEefZmoL9Bfar7eIe
         ZgL6SNlIG6VRNe/DTBbYVQBvv4dbFvLcq0FdqT1kTKpoDucv8utBSiEWdxBhCiuXxgc5
         /iIsV74zzEjdJTUZ+2HqlBVPMTMSWI3DWxvMRem8eRnRnPuX2LLKQAY6mDtBhkTlf+1l
         Bk0g==
X-Gm-Message-State: AOJu0YyHNGlJzfA3jhDuS/vtc1WqEXprD3CaNlZx/UcDWvq+Y32HTOne
	eugO1bBHrY3bAqwbW2If0Tx5CDf1FOZCrw20MiQvfZdIjDKlNNLNVwjhmOK2rGtL5s69UjYV6cf
	v6gATZDIzoBra92C6+x6DFClXN4HWjW+Uf5xR
X-Google-Smtp-Source: AGHT+IHfRln6v044hZGAlSuMPi3J0FOHg5vrtS307mpMoHwBCb0TtGiONlvOul2Ord2/xXZWPGRPnOrWFfjX4JJ6H5s=
X-Received: by 2002:a05:600c:1da0:b0:414:8b7:638 with SMTP id
 p32-20020a05600c1da000b0041408b70638mr97055wms.4.1710809499211; Mon, 18 Mar
 2024 17:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240318132848.82686-1-aravinda.prasad@intel.com>
In-Reply-To: <20240318132848.82686-1-aravinda.prasad@intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 18 Mar 2024 20:51:01 -0400
Message-ID: <CAOUHufZq9=3wtFtUg0y_=OJjBcG59W9Dw2gkSG1nOOfKP83EoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
To: Aravinda Prasad <aravinda.prasad@intel.com>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, sj@kernel.org, 
	linux-kernel@vger.kernel.org, s2322819@ed.ac.uk, sandeep4.kumar@intel.com, 
	ying.huang@intel.com, dave.hansen@intel.com, dan.j.williams@intel.com, 
	sreenivas.subramoney@intel.com, antti.kervinen@intel.com, 
	alexander.kanevskiy@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 9:24=E2=80=AFAM Aravinda Prasad
<aravinda.prasad@intel.com> wrote:
>
> DAMON randomly samples one or more pages in every region and tracks
> accesses to them using the ACCESSED bit in PTE (or PMD for 2MB pages).
> When the region size is large (e.g., several GBs), which is common
> for large footprint applications, detecting whether the region is
> accessed or not completely depends on whether the pages that are
> actively accessed in the region are picked during random sampling.
> If such pages are not picked for sampling, DAMON fails to identify
> the region as accessed. However, increasing the sampling rate or
> increasing the number of regions increases CPU overheads of kdamond.
>
> This patch proposes profiling different levels of the application=E2=80=
=99s
> page table tree to detect whether a region is accessed or not. This
> patch set is based on the observation that, when the accessed bit for a
> page is set, the accessed bits at the higher levels of the page table
> tree (PMD/PUD/PGD) corresponding to the path of the page table walk
> are also set. Hence, it is efficient to check the accessed bits at
> the higher levels of the page table tree to detect whether a region
> is accessed or not. For example, if the access bit for a PUD entry
> is set, then one or more pages in the 1GB PUD subtree is accessed as
> each PUD entry covers 1GB mapping. Hence, instead of sampling
> thousands of 4K/2M pages to detect accesses in a large region,
> sampling at the higher level of page table tree is faster and efficient.
>
> This patch set is based on 6.8-rc5 kernel (commit: f48159f8, mm-unstable
> tree)
>
> Changes since v1 [1]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  - Added support for 5-level page table tree
>  - Split the patch to mm infrastructure changes and DAMON enhancements
>  - Code changes as per comments on v1
>  - Added kerneldoc comments
>
> [1] https://lkml.org/lkml/2023/12/15/272
>
> Evaluation:
>
> - MASIM benchmark with 1GB, 10GB, 100GB footprint with 10% hot data
>   and 5TB with 10GB hot data.
> - DAMON: 5ms sampling, 200ms aggregation interval. Rest all
>   parameters set to default value.
> - DAMON+PTP: Page table profiling applied to DAMON with the above
>   parameters.
>
> Profiling efficiency in detecting hot data:
>
> Footprint       1GB     10GB    100GB   5TB
> ---------------------------------------------
> DAMON           >90%    <50%     ~0%      0%
> DAMON+PTP       >90%    >90%    >90%    >90%
>
> CPU overheads (in billion cycles) for kdamond:
>
> Footprint       1GB     10GB    100GB   5TB
> ---------------------------------------------
> DAMON           1.15    19.53   3.52    9.55
> DAMON+PTP       0.83     3.20   1.27    2.55
>
> A detailed explanation and evaluation can be found in the arXiv paper:
> https://arxiv.org/pdf/2311.10275.pdf

NAK, on the ground of citing the nonfactual source above and
misrespenting the existing idea as your own invention [1].

The existing idea was purposely not patented so that all CPU vendors
are free to use it. Not sure what kind of peer review that source had,
but it's not getting around the reviewers here easily. Please do feel
free to ask any 3rd party that has no conflict of interest to override
my NAK though.

[1] https://lore.kernel.org/CAOUHufbDzy5dMcLR9ex25VdB_QBmSrW_We-2+KftZVYKNn=
4s9g@mail.gmail.com/
[2] https://lore.kernel.org/YE6yrQC1Ps195wPw@google.com/
