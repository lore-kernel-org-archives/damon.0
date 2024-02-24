Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D35211C
	for <damon@lists.linux.dev>; Sat, 24 Feb 2024 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708806819; cv=none; b=dLTXXc3SiieMEXPfobrA5tpu7o5jZc/9mxxfmup0I8nx/OXayh0nUqleaVXTkdXDVThL9+4ctJCXVe9ZYB0Q5Y6wkmAsRJxBq5kLkni2KOGFs+JQebt2hIiQbX7kCHL0EfrmzRb8PvuYBZ5IE4FuxEz2bYxyjK5gBUXbJVQEgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708806819; c=relaxed/simple;
	bh=9oS3KrPJR07eSxCrD6jaIgwpwSu3635rB9ytLH2uYY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpDTWlhYyd08VfmqOOXE3VM5WnoDeEPJlw3MCj5dkyMSD6HkLSs3sXmcfLLSTV+NF8SbCS12RHo1GUhp31Vxh05fFgWkl5K3aci7Vi5zYsUCHJiAeD4o4IS9VlZy8yq1kBfkmuVLGg9EDtztiNCHgNnLJP1VrFos5x0ebcmLUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyHNJcre; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyHNJcre"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso1560218276.3
        for <damon@lists.linux.dev>; Sat, 24 Feb 2024 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708806816; x=1709411616; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcEB/B/u9FuYrsGK1/CrqSDGAOGwcMBuWBx3Xthh5/I=;
        b=EyHNJcreyKIr0CC/IPxqoP0rHnEiVKNkNdeUWKqtLIhBbA0rXBbUXMApXe5bXMA30y
         12Kg6nmZyILye9+z+UEnfRq2oMI9ju+Y1XfITv1GN7bhvueMtbq7DoDvbi7CdSVA+eEK
         obCKImn7nW0OoeKrfOnkGFRvdXVcxA1Nf47F+1V4rvymBLAxPIlHRSa+YKlNc+pFjU8w
         3MGflZqlFaM8KKZyzjUGTa9XRxzAG5EWrlRWXMCwa7vFZB6HDSp7KPHgtXtUWgH/jlDZ
         nyJod+voGSEeX2S/wBDWSkKqQXVp0O7jXXeYWuSQN+6FtbUjr9ONh7++JPjAnRxZhowh
         AL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708806816; x=1709411616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcEB/B/u9FuYrsGK1/CrqSDGAOGwcMBuWBx3Xthh5/I=;
        b=t+LRXQN5F1rreYl/Q5I9e+GNswJnJE9RFipWUifML0//trhT/FsWS4vkgHlW29SoWi
         R0kHGgL72R8VO6Yh6OV6c7MhZtJVUlPwJvRHYAKlJ0TVu1IPsehLHeWGc55ogThZy349
         PbqeNVkdEi5BzR/Ucr4Ebfv21P8fgygCITnUPvGQtltUZfhY/7WTEmZMAgfwxoI083He
         oqRG3/8xl22Z6A+eWHZjg5Pt9fb6b6g29lpe7Z6GOmK702SJuGQggX/XXnz1TbDuBiF8
         GnN2MfLoWh1IecrJ2STNL6dykEdAglft0/7+12aYu1l8KkLlYZAUJ68oeUYFChyqKUr2
         VR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3Wj5/ZKI36JouxQpqx/vA1Xlk7cau8cVGClivWeKEG853MAhQ2iF9t5X2HNAh31kufyzFQPGdB5vayjHeLbY0AbX/3A4=
X-Gm-Message-State: AOJu0YxWdQiKBJo0f67lC4Gn9kr6LgBXod5Qnv04/KZHdjfyECO4FD+T
	iCISkKunJ+YZMOHr6xrrlZe/PGVu2kJPz1bUBOA8aDG+QBOJIzeGoi7I2xPSbgM3S41VhmWMjM0
	bjG0VpIJQkrySKDxu9HM7v1UYNbo=
X-Google-Smtp-Source: AGHT+IHVYeG4sdxyYLY07ymIs/jw3wT3riBpDFnsIG97UyYCih8PQUJ+OgjP21HKGNOKC9IYaojcfsNRV1cDDc/ZQPY=
X-Received: by 2002:a81:9957:0:b0:608:7c7e:9d59 with SMTP id
 q84-20020a819957000000b006087c7e9d59mr3149810ywg.38.1708806816591; Sat, 24
 Feb 2024 12:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240224190724.45681-1-sj@kernel.org> <20240224201221.46450-1-sj@kernel.org>
In-Reply-To: <20240224201221.46450-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 25 Feb 2024 04:33:25 +0800
Message-ID: <CAGsJ_4w4wnbryJaAKRtNGNMg_YTGkeG3QwL9_JkT=wtwq1+_+Q@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
To: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	hannes@cmpxchg.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 4:12=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sat, 24 Feb 2024 11:07:23 -0800 SeongJae Park <sj@kernel.org> wrote:
>
> > Hi Barry,
> >
> > On Sat, 24 Feb 2024 12:37:59 +0800 Barry Song <21cnbao@gmail.com> wrote=
:
> >
> > [...]
> > >
> > > BTW\uff0c
> > > Hi SeongJae,
> > > I am not quite sure if damon also needs this, so I have kept damon as=
 is by
> > > setting ignore_references =3D false.  MADV_PAGEOUT is an explicit hin=
t users
> > > don't want the memory to be reclaimed, I don't know if it is true for=
 damon as
> > > well. If you have some comments, please chime in.
> >
> > Thank you for calling my name :)
> >
> > For DAMON's usecase, the document simply says the behavior would be sam=
e to
> > MADV_PAGEOUT, so if we conclude to change MADV_PAGEOUT, I think same ch=
ange
> > should be made for DAMON's usecase, or update DAMON document.
>
> Thanks to Barry's nice explanation on my other reply to the patch, now I =
think
> the change is modest, and therefore I'd prefer the first way: Changing DA=
MON's
> usecase, and keep the document as is.

Hi SeongJae,

thanks! I actually blindly voted for keeping DAMON's behaviour but
slightly updated the
document as I set ignore_references to false for the DAMON case in the RFC =
:-)

--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -249,7 +249,7 @@ static unsigned long damon_pa_pageout(struct
damon_region *r, struct damos *s)
 put_folio:
  folio_put(folio);
  }
- applied =3D reclaim_pages(&folio_list);
+ applied =3D reclaim_pages(&folio_list, false);
  cond_resched();
  return applied * PAGE_SIZE;
 }

MADV_PAGEOUT comes from userspace by a specific process to tell the kernel
to reclaim its own memory(actually focus on non-shared memory as it
skips folios with
mapcount>1).
The range is a virtual address and the app does know it doesn't want
to access the
range in the foreseeable future.  and the affected app is itself not global=
.

In the DAMON case,  it seems the range is the physical address.  if
the pa is mapped
by more than one process, it seems safer to double-check in the kernel
as it might
affect multiple processes?

Please correct me if I am wrong.

>
>
> Thanks,
> SJ
>
> >
> >
> > Thanks,
> > SJ

Thanks
 Barry
