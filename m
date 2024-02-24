Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B44C62A
	for <damon@lists.linux.dev>; Sat, 24 Feb 2024 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708811679; cv=none; b=XE+TGV0dTPafnWMxX+zWOIypHg74KrJ5AnWvAqS3Glyc6RSF0IRifTrRvaT+1r89zFNb06xfYgQZjfU6ReSB43GxQdhVYnUh5PQVRerbfF7pfMOBoyO8i0kddonqtiQdVkCiE3+4A2Nxv+jCcAHpI5Fh30/2C/o7VWqXpvj5+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708811679; c=relaxed/simple;
	bh=C7M4IDcO/itpux2RkO408k8t768INtVRRFqA+25EYaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERzN50SQK1dxQb4eZ3QFbEmR6VIC9ubVN/nPq/GY6Mty6nJ1UiPxffGTSe0jlkZuZ861U8QnNBAJZmST1lZnfzujC0LlRW0fc+QfM04v1tvOGkYICks6RP6Hx3TnlEcNdjDvOOMnXDrFGfyJiqYsDfokBuAP2kfU/GBojmc5Ylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMEwwTfF; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMEwwTfF"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c18dcbc635so1398773b6e.1
        for <damon@lists.linux.dev>; Sat, 24 Feb 2024 13:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708811677; x=1709416477; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNOM9oiyBitDobU/S8OlbO7Mx6TfDFV84HlF8D6VIPo=;
        b=cMEwwTfFCAWODlB0xxZBTvuHuN8G6KDXB3KbgVkNbQVm+E8tIW2DrUA90CHIz35aDi
         F0JfCfEPMmbWlXFB3nAoP8zgRjyBWbfwqFD9fOJu25lCvZ80r9WmmWj4Cc6m4WxV1SEg
         u4rZ/x8Ygl4IOsI/+7V535SKK2i4HaMwEGByQb//AqhJ8JoabHVaU8FWHOI0pBD6L1qn
         +uszSXB/LdHRxxURKagSOlKzFaIegPkfkATUaWTUUsNXiWeoMwY2PrytelE8f7SEcM4X
         Y5nRncqUlu6H15HHn88D7QQUw2MALos7lfnpnLBYfLoa5Ulhn2NEcmRn/AaiK1R/KmoW
         s8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708811677; x=1709416477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNOM9oiyBitDobU/S8OlbO7Mx6TfDFV84HlF8D6VIPo=;
        b=IeLP9oEi4U11IJGpM9B//LWlwp5TbkLPViT4bnwhBzg34ULfFd13aL+COFrV0XrqDg
         KkDJERkl9tuNlaamX486NgsWMXY/hOISSssp1C6lT2pwtmib8WdfiJ3F06jBih7IutL4
         ZkceRD1ZlDjIZjDOW1PAROvDO9rFTbhLWmjb52P2gzV9aKVHAxgjwBXFj86NmHosoNS4
         aaM/bPgtgoBjOOJphRt5RAilIrG3U17RJNF+WEYko06AmUMuHaOTeqI0ivmNrQQby0Zs
         41soOh8+FiQfQdGBtLCznCErnAhedAahialglG0rntDXpwUqp53hMM8IWLCPXlVYk1H4
         S9MA==
X-Forwarded-Encrypted: i=1; AJvYcCW0fc4uCE/rtviq+/78nMosIW20AJvzvW31kSW5tXVl8qDT9AybWCrOBm/zdRo5Pdrc5G/sdj254T3A1e0uzK7MHOVlZ1w=
X-Gm-Message-State: AOJu0YxDZDLcXclfWpoCWQ3XUFV6h52h0x1o3wkeX5mmUVo1L15I0f+M
	lI7lc8gS06hSFUMop+W33FxrwIoygBl4hgdg/qT4o3Aq2Psj/2fSuraggYAAauW0kORMkf1uTfi
	uq57x6Q7TPtNI90+hklY096P78Yk=
X-Google-Smtp-Source: AGHT+IG0sB1MzcqzE2cuAijnJKjDK/eWUOZNo7lYgzsErvz7w9e4P5P+H93n+t7i0y3btQP3MfNnA97f1gq2FTKQbbg=
X-Received: by 2002:a05:6808:1249:b0:3c1:8590:58e3 with SMTP id
 o9-20020a056808124900b003c1859058e3mr4035948oiv.57.1708811676021; Sat, 24 Feb
 2024 13:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAGsJ_4w5JF8zjsM=vEiArUpnvN9LjAdnUn98mEUJSAhg4Y9XjQ@mail.gmail.com>
 <20240224205453.47096-1-sj@kernel.org>
In-Reply-To: <20240224205453.47096-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 25 Feb 2024 10:54:24 +1300
Message-ID: <CAGsJ_4x5JcpsdobM88ZnZA4B9nHBEdAfpNcdyqxa5fMDqEMrHQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
To: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	hannes@cmpxchg.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 9:54=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sun, 25 Feb 2024 04:01:40 +0800 Barry Song <21cnbao@gmail.com> wrote:
>
> > On Sun, Feb 25, 2024 at 3:07=E2=80=AFAM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > Hi Barry,
> > >
> > > On Sat, 24 Feb 2024 12:37:59 +0800 Barry Song <21cnbao@gmail.com> wro=
te:
> > >
> > > [...]
> > > >
> > > > BTW=EF=BC=8C
> > > > Hi SeongJae,
> > > > I am not quite sure if damon also needs this, so I have kept damon =
as is by
> > > > setting ignore_references =3D false.  MADV_PAGEOUT is an explicit h=
int users
> > > > don't want the memory to be reclaimed, I don't know if it is true f=
or damon as
> > > > well. If you have some comments, please chime in.
> > >
> > > Thank you for calling my name :)
> > >
> > > For DAMON's usecase, the document simply says the behavior would be s=
ame to
> > > MADV_PAGEOUT, so if we conclude to change MADV_PAGEOUT, I think same =
change
> > > should be made for DAMON's usecase, or update DAMON document.
> >
> > Hi SeongJae,
> >
> > I don't find similar clearing pte young in damon_pa_pageout(), so i
> > guess damon's
> > behaviour is actually different with MADV_PAGEOUT which has  pte-cleari=
ng. damon
> > is probably the best-effort but MADV_PAGEOUT isn't .
> >
> > static unsigned long damon_pa_pageout(struct damon_region *r, struct da=
mos *s)
> > {
> >         unsigned long addr, applied;
> >         LIST_HEAD(folio_list);
> >
> >         for (addr =3D r->ar.start; addr < r->ar.end; addr +=3D PAGE_SIZ=
E) {
> >                      struct folio *folio =3D damon_get_folio(PHYS_PFN(a=
ddr));
> >                      ....
> >
> >                      if (damos_pa_filter_out(s, folio))
> >                                 goto put_folio;
> >
> >                     folio_clear_referenced(folio);
> >                     folio_test_clear_young(folio);
> >                     if (!folio_isolate_lru(folio))
> >                          goto put_folio;
> >                     if (folio_test_unevictable(folio))
> >                           folio_putback_lru(folio);
> >                     else
> >                           list_add(&folio->lru, &folio_list);
> > put_folio:
> >                folio_put(folio);
> >          }
> >          applied =3D reclaim_pages(&folio_list);
> >          cond_resched();
> >          return applied * PAGE_SIZE;
> > }
> >
> > am i missing something?
>
> Thank you for checking this again.  You're right.
>
> Technically speaking, DAMON's usage of MADV_PAGEOUT is in vaddr.c.  paddr=
.c is
> using not MADV_PAGEOUT but reclaim_pages().  Usage of reclaim_pages() fro=
m
> paddr is different from that of MADV_PAGEOUT since paddr doesn't clear PT=
E.  I
> was confused from the difference between vaddr and paddr.  I actually wan=
ted to
> document the difference but haven't had a time for that yet.  Thank you f=
or
> letting me remind this.

Hi SeongJae,

thanks! I bravely had a go at fixing the damon's doc[1]. as it seems
the fix is anyway needed
no matter if we have my patch to optimize MADV_PAGEOUT.

[1] https://lore.kernel.org/linux-mm/20240224215023.5271-1-21cnbao@gmail.co=
m/

>
> So, your change on MADV_PAGEOUT will make an effect to vaddr, and I think=
 it's
> ok.  Your change on reclaim_pages() could make an effect to paddr, depend=
ing on
> the additional parameter's value.  I now think it would better to make no
> effect here.  That is, let's keep the change for paddr.c in your patch as=
 is.

thanks! it seems everything is quite clear now.

>
>
> Thanks,
> SJ
>
> >
> > >
> > >
> > > Thanks,
> > > SJ
> > >
> >

Thanks
Barry
