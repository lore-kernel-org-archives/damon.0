Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841710F4
	for <damon@lists.linux.dev>; Sat, 24 Feb 2024 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708749493; cv=none; b=kH7HuFGdapyfF6Z2TdTbJRL7g0bOKFviAZqHaBduLKzqpj8csIRjX0ETMj64Y4yNYk+Rdi2A5hPPhY3isZYqgtVn12rFTMGk2B6iQNu5mw/OjSM1cZe/4nFwtn41Lwy7z0Q6DxWZt9bq9xr6ucJ+Q2gz7D17Yc51hfFYkHZjAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708749493; c=relaxed/simple;
	bh=wPm12rcEg9Fw8WpU7yQ7B/mL8nmn23fQ6tJME/I8d78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qf5Pm+OxX9f0dSXOXbFZbYDv7sm47x0DOjAyLsZopPL4o102zSuRisBGFLPbVB9XpqgYUoZkfyIyXj8HCg/nc3XhiYT/DLEEFw6tO3BPK5Ch0iWlDt6S2b54k6MENb2PM1t0j6cOHuHb5lREicAoGWk9FbvfMc5hBEPlOiNsB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZTAshOz; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZTAshOz"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5c40f874aso760543241.1
        for <damon@lists.linux.dev>; Fri, 23 Feb 2024 20:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708749491; x=1709354291; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWzQINguLAHnwR7gEMC59aXOARD1GxeU+Zpu6O8lb4I=;
        b=QZTAshOze699U45oAoqw0KCYNdQEYs/84/56HGJ3jnEvqr4itDsJmgVpsSchHF0iDq
         k9WXVJkb9yU+RlNcCN8LedweQ5v3e9L3jh+8mtmPlozhQQFbUgBNEc10EM4MwGo3ObkB
         7YUorYXq5ngRrRSXOOdz2dKTfV7rgIlrPAz25R/+NbtITKHVTtW7j2+mQKGRltpOj9YC
         ih4oBkf+eeKQI+3mOXFt3ltwjjKHKug4fRqnWdNLzD1anW9zGZBKTb4O3+F3daxtVkoK
         9AiWPVTsQNqAvQH9dBg5c7Ui4W8UmmnMSRvk23anDzGjqt4gE/vcZAx4uKvxLwBNksEn
         vSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708749491; x=1709354291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWzQINguLAHnwR7gEMC59aXOARD1GxeU+Zpu6O8lb4I=;
        b=tJJqtRfUi6Z4MT50Rd6rvGO/sds7pxY63WXd3gcbIOCmfo4EYQbXKg1KLQDaovzdaY
         1TsUqzMRVmZXEizP7Q9NExq8xgmtSSrDQyhRIDJkzcoG7IF+ypWw7McM3aNUannZ1WmP
         GSBleIDoRVStBEte48fs0tY19Gp7gEMoFCdPM7Agcxb0ZyaaTSZtNaVFvYbXi59ITHFL
         /gLD+ujK2rS6+E4NfazTD7gkLDMa2WWmWypWeLOS07O2JcsXGFv2Wp4YSXipcQ1fH72s
         T24GGpOz0Lkvz4cxI/VHvNy1dXRqsnfIZsbrIsypSec0Vdmo0KTwy+ZgOz/buJxBR3Dv
         Gwjw==
X-Forwarded-Encrypted: i=1; AJvYcCVe/rmeYZoiT5u0BWFK7tSihJyj0SyskibzgX1kV1P21UeBAwlMYqDIV8s1oX5SFWGiXzxjekHLt+xk3ZesotHbz+Z3eaA=
X-Gm-Message-State: AOJu0YxTUC0qJBkBxU4nyQsNY8XFjBfJdHssYIBxUEJbxf0K7HpiS/sU
	BwJ8nuin/gC6dOKPszvSGr1hBlPGxcIgBunt8Emml4B4tg4i/6cEyY9N3PoXLstXAFk/YQQKrOl
	fsRSJUEYmaQFRtTAM8W5f26HTjms=
X-Google-Smtp-Source: AGHT+IHp9Sx8VFdiBM+QCSw+J+CxLbnSxfj37mb/rgk6L0LXAUDXBIoUtYMlXePo4C+f/QF7I7RrA5lTl90W2rTfIxE=
X-Received: by 2002:a1f:6283:0:b0:4d1:34a1:d94f with SMTP id
 w125-20020a1f6283000000b004d134a1d94fmr1516295vkb.6.1708749490923; Fri, 23
 Feb 2024 20:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240223041550.77157-1-21cnbao@gmail.com> <ZdkXpcAB6xWj2geh@google.com>
 <CAGsJ_4zPVNcP-7YQ8wkxmZu0xLkaQ-hyh98Ot0+RpyXm9o1krQ@mail.gmail.com> <ZdkpRavkakwCnoIg@google.com>
In-Reply-To: <ZdkpRavkakwCnoIg@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 24 Feb 2024 12:37:59 +0800
Message-ID: <CAGsJ_4xZQGgzFxEMTJby5MBb22GKV3+X_pLdz1E-1m_hzM4x5A@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
To: Minchan Kim <minchan@kernel.org>, sj@kernel.org
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, hannes@cmpxchg.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 7:24=E2=80=AFAM Minchan Kim <minchan@kernel.org> wr=
ote:
>
> On Sat, Feb 24, 2024 at 11:20:36AM +1300, Barry Song wrote:
> > On Sat, Feb 24, 2024 at 11:09=E2=80=AFAM Minchan Kim <minchan@kernel.or=
g> wrote:
> > >
> > > Hi Barry,
> > >
> > > On Fri, Feb 23, 2024 at 05:15:50PM +1300, Barry Song wrote:
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > While doing MADV_PAGEOUT, the current code will clear PTE young
> > > > so that vmscan won't read young flags to allow the reclamation
> > > > of madvised folios to go ahead.
> > >
> > > Isn't it good to accelerate reclaiming? vmscan checks whether the
> > > page was accessed recenlty by the young bit from pte and if it is,
> > > it doesn't reclaim the page. Since we have cleared the young bit
> > > in pte in madvise_pageout, vmscan is likely to reclaim the page
> > > since it wouldn't see the ferencecd_ptes from folio_check_references.
> >
> > right, but the proposal is asking vmscan to skip the folio_check_refere=
nces
> > if this is a PAGEOUT. so we remove both pte_clear_young and rmap
> > of folio_check_references.
> >
> > >
> > > Could you clarify if I miss something here?
> >
> > guest you missed we are skipping folio_check_references now.
> > we remove both, thus, make MADV_PAGEOUT 6% faster.
>
> This makes sense to me.
>
> Only concern was race with mlock during the reclaim but the race was alre=
ady
> there for normal page reclaming. Thus, mlock would already handle it.

yes. in try_to_unmap_one(), mlock()'s vma is not reclaimed,
while (page_vma_mapped_walk(&pvmw)) {
      /* Unexpected PMD-mapped THP? */
      VM_BUG_ON_FOLIO(!pvmw.pte, folio);

      /*
       * If the folio is in an mlock()d vma, we must not swap it out.
       */
      if (!(flags & TTU_IGNORE_MLOCK) &&
               (vma->vm_flags & VM_LOCKED)) {
            /* Restore the mlock which got missed */
                 if (!folio_test_large(folio))
                           mlock_vma_folio(folio, vma);
                  page_vma_mapped_walk_done(&pvmw);
                  ret =3D false;
                  break;
  }

BTW=EF=BC=8C
Hi SeongJae,
I am not quite sure if damon also needs this, so I have kept damon as is by
setting ignore_references =3D false.  MADV_PAGEOUT is an explicit hint user=
s
don't want the memory to be reclaimed, I don't know if it is true for damon=
 as
well. If you have some comments, please chime in.

>
> Thanks.

Thanks
Barry
