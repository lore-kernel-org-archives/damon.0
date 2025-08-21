Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3E244685
	for <damon@lists.linux.dev>; Thu, 21 Aug 2025 04:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750558; cv=none; b=dioveeDd+jWO4/GqrvWSbjy5UqqBbJEu2VOuvnjwfE+6MFUE01qSeFemYKxkJiw+dSE6xBOfND+FoXcXzNPS0DQshvL1dKaCTB+SPVhpf7+9ZSpZNUhbrcPMYQBOoUjFurpIOZSr//2R/D+nY7O1DOCP4xMKKDL6P8P/7QXhVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750558; c=relaxed/simple;
	bh=gDRx4mwUvt6KBsgpUBrSflpnqWBTOrb8Y4evN/1DHnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEeMWCMNtxXXFgaM0BEVGqr45zQSIaV73APBnBdqzeks4hC6baJJzJG6aYOy7gEDSGvDqe2JSCAg9IysshNmF6/St2dZbHngQ4bKDHzEu/OML0/OBGwKuzpVFwQ6y/1kaOQGxKDRfcaBepV1yJYpWBUn0grdZQ7dOoYfjO78nNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juuCFAPr; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juuCFAPr"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61beb53bc95so262337eaf.0
        for <damon@lists.linux.dev>; Wed, 20 Aug 2025 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755750556; x=1756355356; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A9C6Y9ZJgiMsi/J5YHom1KPP5jSn1ZRQFc25n88ZJs=;
        b=juuCFAPrNlLSE2tzJA87uVBQNB8Fg+Sp6yZdkp1F5T3UZ91VNxLf5zKGSCSG8mkcKv
         FDdB+0FRzk75t4SgEOc3gZ+VM6UI3J+O3F/wgcyXLzmeUk/epXdgxVq1OjfhsrHVRle9
         sikCLGS0vSeJaahM4BP8QZRbvrrnb+NN7C14c49iR+sUngeBH4KmZ6xrdTC1/VdAJnl6
         lKPUcYIs8qhx42w3mB3LaurzuKHTDScwmX7Yi47GFoT3nbunYbet5YWMUVB4G3uF1/gk
         Y42CMB5FpleF6BpEBZTmQDEXhN2I5tZeFH3cGqtwTiQ9j8T/QWJAvbDYyMioZisIZiHj
         4FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750556; x=1756355356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A9C6Y9ZJgiMsi/J5YHom1KPP5jSn1ZRQFc25n88ZJs=;
        b=mUdGc6qyFrZlUKUYmtYL9uD7PqL/2DtDJ3t+Z4GBwClKsSQPU9ERwI2loWnxxZGJ7J
         87bZr0QainRzCe8XrvC44zkgAhjd+GxrvW2y3SG1c6HUO13V5MomxKCMRLsuyEYvL23u
         u51Br9qhcB+LyYDZW7eYK5Ltz4xt/+MH6U05GBwrk2qeMXWSfSwTXNmaXZROxYH9NCYp
         zolFaYmtlyuOGL107EQ1XTapUNbwV7Vz6GhlijkA0IcGSR97qS/oKsBz4b4EsIkJ+kXC
         MZqJetS7uUYBZ4EoHH15j/qdljkDjKJwgDjuiBJiKM9sSaURflVKfFCVO9qv0mJVDpZq
         EH1w==
X-Forwarded-Encrypted: i=1; AJvYcCWr27leGhv3crdkvFNREH1G+F8dmX0gVeYaTlT7bPwkoOxXb6ZdG+sDtL6LB7uMoE4FIvy92A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzD+uzvcwwD2rkLsniIo/pJX3IF6xTy8cLqe1UHOKLdwK1+QM0q
	uNs81sXQE96CfKJHgp+zS7ZTvIVZsNZBKfFNJBSdZu8ZRvzEQ7daWFtyb91Klydnz0jdU8rO8dr
	5J9iLndGjMiLRGcZzmaYuzMYc3z1Omc4=
X-Gm-Gg: ASbGncupjSbAoc8tRQr2v4toat4LCXZIekQ4FiedalYwTFC50Ky9xR5n3QHbbc65FqJ
	nol4j+vn3wDPH3EWfL1JTDHGl1KBc3t4PvQ8OqrxRNREd0HZ5Nmgj5MzBQeMpzYS+tehVs8qc8s
	rL9TcGfOP1VMqXratgctvA0C/2yJOiiBrt0wR1YlMMRIYU5Xj8VSNW//1UKkNOXgytKzc18jil6
	GI6A75TRtYETUk=
X-Google-Smtp-Source: AGHT+IFDjBecc8GcRKMiu+HH3tdyg2aCQxSoKPoBmiKjiHISG5ASpJZTZMSnkG+iLjHlpiuFK45BniXIU9XuY1I+13I=
X-Received: by 2002:a05:6820:620:b0:61c:648:5f96 with SMTP id
 006d021491bc7-61dab2967d9mr478856eaf.0.1755750555517; Wed, 20 Aug 2025
 21:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABFDxMGmVgswVoZFgBz=7xqA59M7fMt0jw2QHqWjm-W9tZktWg@mail.gmail.com>
 <20250821025423.90825-1-sj@kernel.org>
In-Reply-To: <20250821025423.90825-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 21 Aug 2025 13:29:04 +0900
X-Gm-Features: Ac12FXxwmBhLAYwhb250Nr3Mb1TYmrDdE6eHzv4fHnin_s3-I2GxsKQVwH7Y8BI
Message-ID: <CABFDxME5ZEAn+6=0GRWybTi-xBzbhhz7U38pMni3SdKjA+Aj-A@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:54=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Thu, 21 Aug 2025 10:08:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > On Thu, Aug 21, 2025 at 3:27=E2=80=AFAM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > On Wed, 20 Aug 2025 22:18:53 +0900 Sang-Heon Jeon <ekffu200098@gmail.=
com> wrote:
> > >
> > > > Hello, SeongJae
> > > >
> > > > On Wed, Aug 20, 2025 at 2:27=E2=80=AFAM SeongJae Park <sj@kernel.or=
g> wrote:
> > > > >
> > > > > On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@gm=
ail.com> wrote:
> [...]
> > I think that I checked about user impact already but it should be
> > insufficient. As you said, I should discuss it first. Anyway, the
> > whole thing is my mistake. I'm really so sorry.
>
> Everyone makes mistakes.  You don't need to apologize.
>
> >
> > So, Would it be better to send an RFC patch even now, instead of
> > asking on this email thread? (I'll make next v3 patch with RFC tag,
> > it's not question of v3 direction and just about remained question on
> > this email thread)
>
> If you unsure something and there is no reason to send a patch without a
> discussion for the point, please discuss first.  To be honest I don't
> understand the above question at all.

Ah, I just mean that I need to make a new RFC patch instead of
replying to this email thread. I'll just keep asking about previous
comments on this email thread.

> >
> > > >
> > > > In the logic before this patch is applied, I think
> > > > time_after_eq(jiffies, ...) should only evaluate to false when the =
MSB
> > > > of jiffies is 1 and charged_from is 0. because if charging has
> > > > occurred, it changes charge_from to jiffies at that time.
> > >
> > > It is not the only case that time_after_eq() can be evaluated to fals=
e.  Maybe
> > > you're saying only about the just-after-boot running case?  If so, pl=
ease
> > > clarify.  You and I know the context, but others may not.  I hope the=
 commit
> > > message be nicer for them.
> >
> > I think it is not just-after-boot running case also whole and only
> > case, because charging changes charged_from to jiffies. if it is not
> > the only case, could you please describe the specific case?
>
> I don't understand the first sentence.  But...
>
> I mean, time_after_eq() can return false for many cases including just wh=
en the
> time is before.  Suppose a case that the first and the second arguments a=
re,
> say, 5000 and 7000.

I think my previous explanation is not enough. I just want to say,
time_after_eq return false, but user expected true case; And I think
that's the point we want to fix.

Maybe I can change my previous question like this, "Is there any
situation, that charged_from has been updated before and even though
reset_interval has passed but time_after_equal() returns false".

I asked this question because I think that kind of situation can't
exist and minimum version of Fixes patch(5.16) uses esz in the same
way as it is now. So I think that we shouldn't use "stop working" in
the commit message.

As I was writing this, I thought about your comments deeply again.
Since you describe the current state of esz as a bug, I think you
might want to write "stop working" to comments, because I think you're
thinking that some fixes patch could change esz initialized value
(also reasonable, I agree)

I think adding an explanation of the above knowledge is good to help
newcomers to understand DAMON well. Also, Could you please check the
above question for a more detailed commit message?

> >
> > > > Therefore,
> > > > esz should also be zero because it is initialized with charged_from=
.
> > > > So I think the real user impact is that "quota is not applied", rat=
her
> > > > than "stops working". If my understanding is wrong, please let me k=
now
> > > > what point is wrong.
> > >
> > > Thank you for clarifying your view.  The code is behaving in the way =
you
> > > described above.  It is because damon_set_effective_quota(), which se=
ts the
> > > esz, is called only when the time_after_eq() call returns true.
> > >
> > > However, this is a bug rather than an intended behavior.  The current=
 behavior
> > > is making the first charging window just be wasted without doing noth=
ing.
> > >
> > > Probably the bug was introduced by the commit that introduced esz.
> >
> > Thanks for your explanation. I'll try to cover this point in the next
> > patch as well.
>
> If you gonna send a patch for fixing this bug, make it as a separate one,
> please.

I didn't mean newer code changes, just commit messge. As you said code
change should be created with another patch, if it has another
intension; Also, i didn't have any plan yet. I'm trying to resolve
this patch first

> [...]
> > > So what I'm saying is that I tink this patch's commit message can be =
more nice
> > > to readers.
> >
> > You're right. I'll try to make the commit message more clear. I'm
> > really sorry for bothering you.
>
> Again, you don't need to apologize.

Maybe, I just want to express my gratitude :)

>
> Thanks,
> SJ
>
> [...]

Best Regards
Sang-Heon Jeon
