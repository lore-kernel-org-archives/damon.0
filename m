Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497620B3D
	for <damon@lists.linux.dev>; Sat, 24 Feb 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804914; cv=none; b=DGkDcnWLynuXJBsV41gITGVteJ5KyMnvQsGftYulnKF7cKaptE7brMIVtuiPBcLfCDHsPrJ8m1jVU17zx3kcWploAi6BqL6ygzPLejZx/RpQPJp0eLuH9iU7ogdGVtF/o34/P/ucAhDLubK9M86oSQwX21w9BFJrS6z1zTiHsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804914; c=relaxed/simple;
	bh=FkkIX7ff0GH1hNUeJLjrSyJaFKKYMJWWsy5nkRfLtYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a05fXDAi6AX/lp0n+2HzAR+AVCUsXxPHrUw/6EmbadW8/ZWksF65qd6ixB3PJnWkkDz+eJ/ruLPduIvzrk7T2ZLO2TPt+mX+8I2qFzUs/366++gSqTt8gFbJWTqY38bhhPs8Tru+vcIktIhWVTwqEUbh81wrbb6afNzZ0ozqtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOllWcAO; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOllWcAO"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d643a40a91so1095229241.0
        for <damon@lists.linux.dev>; Sat, 24 Feb 2024 12:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708804912; x=1709409712; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhvY0oAhlso/vm21VK7DmsUYbiVSz8F5wQ+tQ3fpMMQ=;
        b=JOllWcAOWdm2QSOi+f5id80m3ReApVChEpeJsZmEY80Q+rFyxlhrCCcQZd0OFxre2X
         TBrUXxavpNBiayPMaDyKg9KK0uIHahIr+ZkQESFy50EJzpfyT5FpuVmP5Ke6EXOuEwWY
         5y+lXCpcOMAMmCMELfOrUE7ef2L7Agu5jlcpU/lix17VaUwKC/rqegP1IXhdXCcKnJKT
         8hsW/DNvyzYecdi6TsUQpydHwwytmTXlCnkCIEEmH5J7jErjL4zJPdb1ZQvYSNV60Y+O
         BAHAKFf68w1Ptpo5fE8JH+s4YeqhqEn3S/Mcek1PEbVIcBFV1WoT/thVtrYmrQdSLIGe
         XxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708804912; x=1709409712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhvY0oAhlso/vm21VK7DmsUYbiVSz8F5wQ+tQ3fpMMQ=;
        b=XmyTyAtjOocwy8Ma+fAictvW/XvRe5bMsKT856Kj/BCedhxpbUV9T94ZAVkkmP3VN2
         Ew0V5SpKT5R/oraTbRgbsKSosI3/PD/E1Vjka3wVq3FJonjyAo1vxznXQgUch5UWHjJW
         S/T0cjw5mPpHrETGcx4EyU0kY9H1nfjTORAHuS0Vr5hMbuC6jJVX7vKBy7PMKcCJo22l
         ZOwKXgs5RdrlegJwA+H/jfnpdV2Ze+YUpWxaB0m4yHudpyib31YWyXAkg9ybNCL2dvOa
         5i/PnLM3dPQcf4MDWb6bUaYpuJzhtUw94MHrIrw+iGznTfMKKy8SNc6p/9mk27TCoGZd
         y7zA==
X-Forwarded-Encrypted: i=1; AJvYcCUjq8Dre2Zc1SqMGpzYnVmnW/NEqq+GhpwXoI0vBvKDv5JWUuWHncH48r9GDu//0aAeCxn4eh459Vj9vIJqWGOcvShe4TA=
X-Gm-Message-State: AOJu0Yzdm+B7YE4upHeFGt4+OVDZUsTL+VFM3kJvZJQuY7nQ2Z3dSfeU
	PTcY3vaQiV01qJzZFFQjviM6YI3KCe3a4EvAoN5qC74gMLbSFt7y9z5jjBBViVfTAvQCFqSJuPf
	rK8euz67UR1y/cMSRaVjkRxmryRI=
X-Google-Smtp-Source: AGHT+IEOpO4xwFjEMMS4q1MPbiPIvWeVLimD16r3xLrW/831OCqy7UnLYv6Qc9PkJ5vDb9k1hoM7i5SGdG1bvcH+h6Q=
X-Received: by 2002:a1f:ed01:0:b0:4d1:3f5a:75ee with SMTP id
 l1-20020a1fed01000000b004d13f5a75eemr1790639vkh.9.1708804911975; Sat, 24 Feb
 2024 12:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAGsJ_4xZQGgzFxEMTJby5MBb22GKV3+X_pLdz1E-1m_hzM4x5A@mail.gmail.com>
 <20240224190724.45681-1-sj@kernel.org>
In-Reply-To: <20240224190724.45681-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 25 Feb 2024 04:01:40 +0800
Message-ID: <CAGsJ_4w5JF8zjsM=vEiArUpnvN9LjAdnUn98mEUJSAhg4Y9XjQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
To: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	hannes@cmpxchg.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 3:07=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Barry,
>
> On Sat, 24 Feb 2024 12:37:59 +0800 Barry Song <21cnbao@gmail.com> wrote:
>
> [...]
> >
> > BTW=EF=BC=8C
> > Hi SeongJae,
> > I am not quite sure if damon also needs this, so I have kept damon as i=
s by
> > setting ignore_references =3D false.  MADV_PAGEOUT is an explicit hint =
users
> > don't want the memory to be reclaimed, I don't know if it is true for d=
amon as
> > well. If you have some comments, please chime in.
>
> Thank you for calling my name :)
>
> For DAMON's usecase, the document simply says the behavior would be same =
to
> MADV_PAGEOUT, so if we conclude to change MADV_PAGEOUT, I think same chan=
ge
> should be made for DAMON's usecase, or update DAMON document.

Hi SeongJae,

I don't find similar clearing pte young in damon_pa_pageout(), so i
guess damon's
behaviour is actually different with MADV_PAGEOUT which has  pte-clearing. =
damon
is probably the best-effort but MADV_PAGEOUT isn't .

static unsigned long damon_pa_pageout(struct damon_region *r, struct damos =
*s)
{
        unsigned long addr, applied;
        LIST_HEAD(folio_list);

        for (addr =3D r->ar.start; addr < r->ar.end; addr +=3D PAGE_SIZE) {
                     struct folio *folio =3D damon_get_folio(PHYS_PFN(addr)=
);
                     ....

                     if (damos_pa_filter_out(s, folio))
                                goto put_folio;

                    folio_clear_referenced(folio);
                    folio_test_clear_young(folio);
                    if (!folio_isolate_lru(folio))
                         goto put_folio;
                    if (folio_test_unevictable(folio))
                          folio_putback_lru(folio);
                    else
                          list_add(&folio->lru, &folio_list);
put_folio:
               folio_put(folio);
         }
         applied =3D reclaim_pages(&folio_list);
         cond_resched();
         return applied * PAGE_SIZE;
}

am i missing something?

>
>
> Thanks,
> SJ
>

Thanks
Barry
