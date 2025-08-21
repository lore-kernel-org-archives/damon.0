Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198571C4A10
	for <damon@lists.linux.dev>; Thu, 21 Aug 2025 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751423; cv=none; b=NN/SliXUYT6tBGRaij3jzz0GV127IOr7PV38YdNloWm8z2QekLfanoe9OHa16E8Ux6roQEs0V5HreBgwxzFMu53bAoYl0Mwe6GWr9xkHnzuqcKxGCfw51D3zkA0kFT96LYBrgl7nNdaFZkYF0HHjB+gD7WQ+Eo+HIU91m5rQqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751423; c=relaxed/simple;
	bh=xTIj6V7ezcR4MueDpk20MMc3TrV9FrQYrRp10XWNvZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4obGCx6pVCUaw8IsDs09xumItNwZsVlmRfICGH8/s5xJ4O0yzlahIoNFpntJYLi1dBvES/yK82RiP74jZtB5FBpR7OVOSIpTBPM2/u3gxAygYEAkSIM0zh3Qt5mGOUvch9jNt/iFTlGzKrBIkiQFHZ4PrPwzXjR5G5LykSE7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLjO7bin; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLjO7bin"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74381df387fso172340a34.0
        for <damon@lists.linux.dev>; Wed, 20 Aug 2025 21:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755751421; x=1756356221; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWvhKp65AxyP1xwVvIS8MuCmDuU/KsXcWzjgpycsbII=;
        b=GLjO7binc+WD8TH14IIBp07yBJdVWgwxxicjPDo86G3MEmi9nsPS1dMbbpE/HGAE7f
         BJpvXZDu/XFIaJnTPy400smxRZaVIjsi/lYwpcy99zXXFMN+/wWzPm0vzGRCnc+3u9ys
         2DAlypUbwdXjSIc6oXVBTlhNHQU+vFKs1Ys/tVF+m+IsW2Ye0KdMpzWKTEAWSq5yAOOk
         YWpKHvIs/OIUur1B3jGeEFgHjChbdi1sXv5JeLPs/+XQU2fzOYIRAcWMicJ9S2PNLOi+
         ixosSt7Y5N/a9RtWWp8dWivlbjuAGqKiNZwqh/OudyjX9viSJM6tysL7g3KUs1/Pw6+A
         PfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755751421; x=1756356221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWvhKp65AxyP1xwVvIS8MuCmDuU/KsXcWzjgpycsbII=;
        b=YCjqPjpc1kj45eeFi8cvB7ZUV4OS/wK4dewGlow/7vPlHpQZfuQNy+I7Vwu5B4uqcD
         8UUkDT4X4xD8LZeyGDz5izwgctgckNcbmqRqfSOpUZ4u/c7vW3TUSpZ93kgoPrDp1H7b
         3bXfG5MYSnWSqnEqMVoTCF+Ji51gE/A6EPHutRXLevYdFkSOZDDI0kP+TQCZC0DhN5z3
         9ayd8x9Pfxc/8ukjeXmQOasVurG4mGKe+N2fmdvhWncDGESaE3vKSodzTq7mjmZVzndR
         L1VKYXiPxj0gT24XwU/srjbIfDSrLOFaPKIyBaWLx56CleJzYMq3tyxGbFe/bAEq0Jf+
         Wn2A==
X-Forwarded-Encrypted: i=1; AJvYcCW6fNe8Ci3inVTgDXO1fM8MELWzdDN4OxooOB+OO3mHObQHDsgB4Bs8qwr404rdr+2UnTcf8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEX+vQfpZz9MlubD6dqPhOajOuGlTu+bYfAC9Ns94wLbX12/FE
	h4KWglj5YToCCByNISayx7G9DZbZrifbDmHo4KQtVlQpjUshla4tZ2Xz2sacSpJoV6LJ5wRRwWv
	FF3u+vVxKg6UJdqKgOam4dbwFny3Ttxk=
X-Gm-Gg: ASbGncvWbqIR0Phv/bPIyQOVh0NMoH2XBhimPVZji8kEenmzF4c1REUhMFmAWOAlULU
	pmRNzsH5IANn/H2V17z4ZEtX16H1cqIwTT7TzP9VLXkYVfMmtKc9tiCqAz7jOMnfQ9HNns5Am7s
	juam0cB7AOXcC5KLfqX/UgfdEuUAFq1t3eH2HJDHbKazrA3fKhmvB8w4vqxb0oO7cHhNF/jvNwM
	7Ow
X-Google-Smtp-Source: AGHT+IGjprBbj/E2Wm4laG+alOgDHLSfMegvi1WsGOjDb1e3hjmUvLF5JnP1I0EZQkV5dEYbsLY1up+jOJ8PGChnNH4=
X-Received: by 2002:a05:6820:1b87:b0:61d:9adf:eecc with SMTP id
 006d021491bc7-61dab25dee0mr434089eaf.2.1755751420981; Wed, 20 Aug 2025
 21:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABFDxMGmVgswVoZFgBz=7xqA59M7fMt0jw2QHqWjm-W9tZktWg@mail.gmail.com>
 <20250821025423.90825-1-sj@kernel.org> <CABFDxME5ZEAn+6=0GRWybTi-xBzbhhz7U38pMni3SdKjA+Aj-A@mail.gmail.com>
In-Reply-To: <CABFDxME5ZEAn+6=0GRWybTi-xBzbhhz7U38pMni3SdKjA+Aj-A@mail.gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 21 Aug 2025 13:43:29 +0900
X-Gm-Features: Ac12FXxIn6O74TtxGWb4mmUw96J7yYYLAjMBUSDDJprJWR81IQ6dIXiEhH5f3OA
Message-ID: <CABFDxMEYXpQRS0fMdE-qoVMHym2Cp+2Uh+pXwB5h0MdvWGdiew@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Restore missing CC) + Andrew

On Thu, Aug 21, 2025 at 1:29=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> On Thu, Aug 21, 2025 at 11:54=E2=80=AFAM SeongJae Park <sj@kernel.org> wr=
ote:
> >
> > On Thu, 21 Aug 2025 10:08:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.co=
m> wrote:
> >
> > > On Thu, Aug 21, 2025 at 3:27=E2=80=AFAM SeongJae Park <sj@kernel.org>=
 wrote:
> > > >
> > > > On Wed, 20 Aug 2025 22:18:53 +0900 Sang-Heon Jeon <ekffu200098@gmai=
l.com> wrote:
> > > >
> > > > > Hello, SeongJae
> > > > >
> > > > > On Wed, Aug 20, 2025 at 2:27=E2=80=AFAM SeongJae Park <sj@kernel.=
org> wrote:
> > > > > >
> > > > > > On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@=
gmail.com> wrote:
> > [...]
> > > I think that I checked about user impact already but it should be
> > > insufficient. As you said, I should discuss it first. Anyway, the
> > > whole thing is my mistake. I'm really so sorry.
> >
> > Everyone makes mistakes.  You don't need to apologize.
> >
> > >
> > > So, Would it be better to send an RFC patch even now, instead of
> > > asking on this email thread? (I'll make next v3 patch with RFC tag,
> > > it's not question of v3 direction and just about remained question on
> > > this email thread)
> >
> > If you unsure something and there is no reason to send a patch without =
a
> > discussion for the point, please discuss first.  To be honest I don't
> > understand the above question at all.
>
> Ah, I just mean that I need to make a new RFC patch instead of
> replying to this email thread. I'll just keep asking about previous
> comments on this email thread.
>
> > >
> > > > >
> > > > > In the logic before this patch is applied, I think
> > > > > time_after_eq(jiffies, ...) should only evaluate to false when th=
e MSB
> > > > > of jiffies is 1 and charged_from is 0. because if charging has
> > > > > occurred, it changes charge_from to jiffies at that time.
> > > >
> > > > It is not the only case that time_after_eq() can be evaluated to fa=
lse.  Maybe
> > > > you're saying only about the just-after-boot running case?  If so, =
please
> > > > clarify.  You and I know the context, but others may not.  I hope t=
he commit
> > > > message be nicer for them.
> > >
> > > I think it is not just-after-boot running case also whole and only
> > > case, because charging changes charged_from to jiffies. if it is not
> > > the only case, could you please describe the specific case?
> >
> > I don't understand the first sentence.  But...
> >
> > I mean, time_after_eq() can return false for many cases including just =
when the
> > time is before.  Suppose a case that the first and the second arguments=
 are,
> > say, 5000 and 7000.
>
> I think my previous explanation is not enough. I just want to say,
> time_after_eq return false, but user expected true case; And I think
> that's the point we want to fix.
>
> Maybe I can change my previous question like this, "Is there any
> situation, that charged_from has been updated before and even though
> reset_interval has passed but time_after_equal() returns false".
>
> I asked this question because I think that kind of situation can't
> exist and minimum version of Fixes patch(5.16) uses esz in the same
> way as it is now. So I think that we shouldn't use "stop working" in
> the commit message.
>
> As I was writing this, I thought about your comments deeply again.
> Since you describe the current state of esz as a bug, I think you
> might want to write "stop working" to comments, because I think you're
> thinking that some fixes patch could change esz initialized value
> (also reasonable, I agree)
>
> I think adding an explanation of the above knowledge is good to help
> newcomers to understand DAMON well. Also, Could you please check the
> above question for a more detailed commit message?
>
> > >
> > > > > Therefore,
> > > > > esz should also be zero because it is initialized with charged_fr=
om.
> > > > > So I think the real user impact is that "quota is not applied", r=
ather
> > > > > than "stops working". If my understanding is wrong, please let me=
 know
> > > > > what point is wrong.
> > > >
> > > > Thank you for clarifying your view.  The code is behaving in the wa=
y you
> > > > described above.  It is because damon_set_effective_quota(), which =
sets the
> > > > esz, is called only when the time_after_eq() call returns true.
> > > >
> > > > However, this is a bug rather than an intended behavior.  The curre=
nt behavior
> > > > is making the first charging window just be wasted without doing no=
thing.
> > > >
> > > > Probably the bug was introduced by the commit that introduced esz.
> > >
> > > Thanks for your explanation. I'll try to cover this point in the next
> > > patch as well.
> >
> > If you gonna send a patch for fixing this bug, make it as a separate on=
e,
> > please.
>
> I didn't mean newer code changes, just commit messge. As you said code
> change should be created with another patch, if it has another
> intension; Also, i didn't have any plan yet. I'm trying to resolve
> this patch first
>
> > [...]
> > > > So what I'm saying is that I tink this patch's commit message can b=
e more nice
> > > > to readers.
> > >
> > > You're right. I'll try to make the commit message more clear. I'm
> > > really sorry for bothering you.
> >
> > Again, you don't need to apologize.
>
> Maybe, I just want to express my gratitude :)
>
> >
> > Thanks,
> > SJ
> >
> > [...]
>
> Best Regards
> Sang-Heon Jeon
