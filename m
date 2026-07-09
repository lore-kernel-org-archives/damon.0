Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560C1BC2A
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555573; cv=pass; b=tP5FjAMqaFs/fCv2z5zog8z9QfuGpZeqO1xTU9uWTm01O86WCwCj5C7Kfqk30Eljt4ZVO2v8sToJlQa3T1cmYyt7Qh4lRDfh8vAISRXebdSQbaUmiMd6f+GwaDRoqpYNn1URE9PpvVjK7lxYr0GmM2jluzrkuxSzF6REdZr7pmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555573; c=relaxed/simple;
	bh=4EuRdo8+QeN+yDW6A3X+o12IBSIMc42jYmwxuetdwEg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ectcbYsfKEyznwB4TtSXoHlxTKHxNZoMy1avPICSWYYPpFNn0Y/86UbazTYLxa7fz8F79tM0Os0ZZLPWx0EhUmoQmhRECtQB/OoEm93fAtvm9IV3txwnks3vPnmx0PBa3PfLM+g+WuaKxcp8MlaKTnqWjnL/5TUUUMv9S3nqh2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKtvWcaU; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKtvWcaU"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccf2360620so9963645ad.3
        for <damon@lists.linux.dev>; Wed, 08 Jul 2026 17:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555572; cv=none;
        d=google.com; s=arc-20260327;
        b=GjSRalhnG1lEZ8wDMUX1OL4L9ZKfMREgWp166WwheRbufYTf4e+2+G9IJbqT1seq2Y
         DFN1WOB+Z8cd3Qij2a/1tCLr5bc7V3QXeUgXfM4jl/0rM/Zq/lDAo77qcFsEBGGXlF3b
         jUH/4EKerofVHseESVweass/Um0Fk/fSLcP0GHof/hlsEoa6sFBzcN+MPublohjBEddr
         DFtaqnbfTxDqq82Tx50Mh/lxdxr3c815kp/vilmjspl85he7JUFg4lG2ueT+BCtjaNue
         140CT3QwZ+I7ysGzJOUM018HUmlWrq0WwTxVm0xAbV9LBKEmUxy4zd4cN8nhvUfXcqgG
         56ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
        fh=MC8aymcUOB8ggeUqLTX1MNSG0EuScKvypbkb2BoDJNo=;
        b=ghzhYpxzw1jiEDQk8ntAdHfSeO3Vpbl+hQGJFgXll9XgwqUayevXmOLMCctsAtWVqL
         pTj8tFIAOlemJ9Umwq/vufG7xj7FFvl03w6ubM/vL5rgaMB2n0jgkBK+rLxRYpZYRl21
         mKT2sgzj+jbmtxgbiQI6SOUm5ksIKYN3sjFdTkZBEf3GKYUa0uiiTXGbkwwxt/7fVeKw
         6uXhwrp+Ci7yM4oztyT1OzOiFgolmwWFjbyt2xXvHgKH0fVElVX8kwnjpr4kuQv1hHPg
         QNV8y2cUJtPGmXNvduAbrkwlLDFaY/rUw9ohacFG0DYUYjTZmcaJ6iXwcF0e8P8ssIq/
         KoMQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783555572; x=1784160372; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
        b=XKtvWcaUeMg37vNhALFpyIhrbaZf5r2T1KGTcH7mIQ88xMehpr+Gv0Tu31bihIsb5x
         OMdZXajFAnXwtfczv8SHsVuP6JGoBo34OJljB03Zqn807vm5XGFW/H3M1bNtOsF4jlOt
         ZDMpvdPf3EE5xH4HRvdmUu+/jHSuJ7uxHfuboG2vNnR0csggcQ9d77WKp0EBx8AtuEab
         A6X1aIyPJ7KzhdXh880J6ld2TfyJ5r02PHuzlwThux4aajKFIA4mfJH1R2ZJk+jf8vHv
         +u2ol16KYg/zpSVPxjez1KKyQPicmonSuyfwCky1NVRsp/sFx/USbFABsb7lgtCIaE1O
         DuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555572; x=1784160372;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
        b=nweDls/gWBHOVMCVnk76hdtn0vf/mRDXqJ5KN9BDlE6n2S22mWP4f9NlWNCLYGSu1F
         yOcfNZPT/ET4A+wUBthUThyfowQ6Xbpe34FA+TmTCx6PQJhKHB/3RtBSbNUzKyxkitS2
         xYH/YJL4ptZfzTf4Z6O86RJJeAHaI9MBrwUvj4WwrZ/diKCTBfKi4glQaU+58JiR5aD6
         NMTNTgI0JB2sYwwrzafCn/gvwmpLmyvzlK+xSMS9ZYSRK8mvBum5FhheggCY2EUVXr+t
         MlV5yAi4+LoCY88FHcxHuq+QrmDx05FWGzu3NRNfQlATtWuJxgiHbgie0HQLdvhVaFOj
         Mgmg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+XhFf336ZZdLHTv1MUvC3fuEy76Etgxrv5oUAacBtBofMPD0GZwXvf99ujCsLvRbxAqLNog==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAL+JTenitelzhOj3n7grxbOSer5Jf+Ysf5EkuXYcFEqHJNxEZ
	PGxF+blMm2V/nu/Egtub1NEUvlPhWIKSJ6z1XpHcZeabL1VJEnrBTFZrJpD4ki24GshZkD+1gTb
	lJcgetReyWYi/SDQFxDZfZqivwlycoMXtnaOqeyzJ
X-Gm-Gg: AfdE7clFNWO/aB8/DGbl2cWfcRHPo43VWqZ0aebfOhC8Wz3VEU8zL5e2FX9ALc219Zf
	qQop1p7cFo44UQiWXPhGdQiq07ECpqFhULsorpFcLZg/5bfel0PxVEPhP29EA0EmXa5MLvPx95r
	+N03dFRaAHZPspxJHxxlBd7hLOR+KpdZv+kz8WUW4nKoTe84PlxnchqIwpXvy/anQQg7b/3c/RM
	pFKOF2WTZvJznvPH6yUeU58DtKpbeq44AUNCucSJHx0ULJSbaDag4LoBKDRpzJjR8ExTmi18MCa
	z9nAj+kJiLmUgfhLpXrrCVRubmsY7gyQgHIjUq94lebrgLR4HdSkWoXvSow=
X-Received: by 2002:a05:6a21:1f88:b0:3c0:9c19:b27b with SMTP id
 adf61e73a8af0-3c0bcce9940mr4979424637.73.1783555571036; Wed, 08 Jul 2026
 17:06:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org> <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 17:06:09 -0700
X-Gm-Features: AVVi8CdcseowPqFId5ObGoqB8gTqCLO4QEXGH1ZjH1-pjTCLGI84NpwTLe_LrAc
Message-ID: <CAEvNRgEV9VkWHULS4g5hVHu3T6=YZ89HJmkv6rS0+hK=5UFu6Q@mail.gmail.com>
Subject: Re: [PATCH 19/30] mm: use linear_page_[index, delta]() consistently
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, 
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

Lorenzo Stoakes <ljs@kernel.org> writes:

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab6..f0e5da490866 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -440,7 +440,7 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
>  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>  					     unsigned long addr, pgoff_t *ilx)
>  {
> -	pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	pgoff_t pgoff = linear_page_index(vma, addr);
>  	struct inode *inode = file_inode(vma->vm_file);
>
>  	*ilx = inode->i_ino;
> --
> 2.54.0

For the guest_memfd change:

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

Thank you!
