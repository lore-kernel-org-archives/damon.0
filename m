Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CFA28DB3
	for <damon@lists.linux.dev>; Sun, 10 Aug 2025 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754804611; cv=none; b=tP0udE3kUgB2oj/uUmEB+C/Pjfb9AiJvs19K4W9yiPYEeqAB1N9kkTXb+SraoceEtQWiKOgAmBSaf+6Ts5+iQaR9kF6FewgNsK1ngeXiON8xasjbCjyIpd7AUH3gyz4FXCee7xgkd4HXqbxLGc8E/k0ZUCUM2pJqbuWOleNnRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754804611; c=relaxed/simple;
	bh=BKJfgSqIOY6Umz3NcP2Y6p7nrdejTMVfkick2WK/RQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBWWYARQz9dn3U9sqeP78hYn0wxtf5P99RiLIYtTSSPOwnDq6iqxQEikf/DCdEm9uOGcaQHQkxaNBp6J6av0BeItIVgaLmh7hjqlYKqDJPi/DXBxLuqNCnod2yFWdmajnHywztBCp/waxiX1Hd64qh4QB18QKvBXjfH+LRBK0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7H+qC1p; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7H+qC1p"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-433f63d7803so1120820b6e.1
        for <damon@lists.linux.dev>; Sat, 09 Aug 2025 22:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754804609; x=1755409409; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VF7q0WLeklegOu3HyhvX8CcabjELygMV30fjl5+vF4=;
        b=Q7H+qC1pO88T8U1HI1fXsI4xUwx9Xr7dkig5x7TMPXbzI3F0+c4qyHNTktFnNka16a
         V+fOvNP6PU5PHD6dVZR8SEbCoB+fKPpEd+3Nmv3mXeb2RaM9ghx/B/GBgOQnHYGOpL/d
         XV3D8C+ZuFidRVCZeAazyxNVOoF5I/bk0VMI5QVQt+mdmKVfxVHip8xzbp6jVuxWWf/z
         +xrQA+fA253cVYeI7TqbG52R8e8DgLH/8HcBULegUdWULphRiBatEt9cIqRY9DG+PZXx
         JluZa6NqXKS7cwC/wQiNydX7Zky48aJklQSqyBkB2N9zdlCafrRfJkxJaa9w+6U3vWV+
         SgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754804609; x=1755409409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VF7q0WLeklegOu3HyhvX8CcabjELygMV30fjl5+vF4=;
        b=jcAtLT3fzEOgX1gGEZi1ZJLCrs5rpwrr2kByUZi1x7oiykdX4fSu7e3R950yQqGTc6
         fvoiPM+AkyIY33aTi4KRxGO2eXtz6HbYOPhK297gmtA+qjl+HP35LHbnqbXmRQXlSTpg
         1F8R/KsG6zOXI+yZv/X4XFXxt+Oo82OkdMBuIU/bkuTi7AnJ0mx4AzyHMfRELWdw/p6L
         gs8Wu9qC7H2RX9K0UcGZc7Zz9J10iFDxfhrg7EdjGzyyIcAzN+e0GZcIAVAXCNXrcX79
         V6aNliYw7GQTAPT/iEMRlISWXPhnuduk2o17X72K+fGTg2MaOToKHMXpZCVtFBwU+rFs
         ucpg==
X-Forwarded-Encrypted: i=1; AJvYcCVc/FdtjISoh84FEgDoudoJzxfRHc36NSBVx1ZuNvXql16BdU2NrGAJfBbwGJRMjZH1CNe2nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzzh1NtmshXCaalhLfwvLZitelnVCIEpDMTqHxHByS6rvKhMLWk
	agrvbxnYOAkoclVdSZTCfAWjAJbf1ze6oVhfWMP+ibc1XDiCNqbQbbnrv2g+G//fMluhkPPsnbX
	XlwOXHJ1MGXymoqNmzFIxBcupDcKpfY0=
X-Gm-Gg: ASbGncshnk/ioxJf8DEcySWpwp/brYVkbMYER+bmtOGEHb3XyzaLeiJr1qVHSKHsAkL
	qYdXk2ZjAIWn5q7mCf14Ez3T4DBlLYJF2UhGRszA/EYLCM15LzO4PagtITbxLJ6Qe/96s+yYcrI
	G5wo3gSBqnthFKkwNvs/3GMVURYszmMAaJ6mEHMgGZjjCW+WJ+pBdhZiq1V6Y2w+dzw5/YtR8f5
	OnZdkg=
X-Google-Smtp-Source: AGHT+IHJxGMU/wk8QP5vJyCNj2dWjhPvgi4dMUxGNQQj6i6HmeNlJ8gTWRRCGf/0ap7DyAgfXV1rAyxSCplBWIqXv2A=
X-Received: by 2002:a05:6871:5b21:b0:30b:9750:3085 with SMTP id
 586e51a60fabf-30c20f8d5f8mr6278198fac.10.1754804608515; Sat, 09 Aug 2025
 22:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABFDxMH0LDLLdJf-t2DEHCD40EJDfcq35cJM-HS5GkLX7KqsHA@mail.gmail.com>
 <20250809173559.71327-1-sj@kernel.org>
In-Reply-To: <20250809173559.71327-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sun, 10 Aug 2025 14:43:17 +0900
X-Gm-Features: Ac12FXwPPpoJ3Atc3Fc0faMpuO09tCnt-cxUYqEXvY3Fy45GYsSbzi1FInUggjA
Message-ID: <CABFDxMG-2+VQvWNHqCLKy4jZXBJzsWPS9DOkV-gfYovF5Xo-Jg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/damon: test no-op commit broke DAMON status
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae

On Sun, Aug 10, 2025 at 2:36=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sat, 9 Aug 2025 15:39:41 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> =
wrote:
>
> > Hi SeongJae
> >
> > On Sat, Aug 9, 2025 at 7:05=E2=80=AFAM SeongJae Park <sj@kernel.org> wr=
ote:
> > >
> > > Hello Sang-Heon,
> > >
> > > On Sat,  9 Aug 2025 04:55:17 +0900 Sang-Heon Jeon <ekffu200098@gmail.=
com> wrote:
> > >
> > > > Add test to verify that DAMON status is not changed after a no-op
> > > > commit.
> > >
> > > Thank you for this patch!  I have some comments below, though.
> > >
> > > > Currently, it is failing. but after fix the bug it should be
> > > > success.
> > >
> > > To keep bisecting goes smoothly, let's introduce failing tests _after=
_ their
> > > fixes are landed.
> >
> > I see. As mentioned in another comment, I'll merge this patch set into
> > one patch. I think this comment will be resolved then.
>
> That could make the patch be unnecessarily difficult to apply on older ke=
rnels
> due to the test part.  Please keep those separated.

Oh, I misunderstand your previous comment. Now, I understand your
point. I'll separate them back and make two v3 patch(one for fix bug,
one for test) not a patch set.
Thanks for the explanation, I feel like I'm learning more and more.

> [...]
> > > > +    if rc !=3D 0:
> > > > +        return None, f'drgn fail : return code({rc})'
> > >
> > > Let's not add a space before ':', for the consistency.
> >
> > I see. I made so many mistakes like these; (I worked this very late
> > night...) I will fix them all. Thank you for checking this moment.
>
> I'm sorry to hear that you had to work on late night :'(  I hope you to h=
ave
> sufficient rests.

Never mind. just I went with that :) Thanks as always.

> [...]
> > To be honest, I didn't use kselftest framework while making these
> > patch set because I don't know how kernel developers use it.
> >
> > If you are okay, could you share how you use it?
>
> Sure.  I do below for running DAMON selftests.
>
>     $ sudo make -C tools/testing/selftests/damon run_tsets
>
> You could also run DAMON kunit tests like below.
>
>     $ ./tools/testing/kunit/kunit.py run --kunitconfig mm/damon/tests/

Thanks for sharing. I'll try it with my vm environment.

> I usually run all those together with additional tests, using DAMON tests
> suite[2].
>
> > I just build kernel
> > with custom patch, and execute output images by vm, and setup env,
> > then just execute tests(it's so raw.. i know)
>
> It's ok.  No one fits all, so different tests are needed for different ha=
cks.
> Please keep using whatever works best for you :)

You're so right. Maybe I just want to learn some tips from the experts. hah=
a

> >
> > Maybe is there a kernel build option that automatically includes tests
> > to output image? Or just a general or smarter way to execute the whole
> > test?
>
> To be honest I'm also not an expert of kselftest and kunit :)  You coule =
refer
> to the kselftest documentation[1] for more details.

Thanks for sharing!

> [...]
> > Thanks for reviewing! Have a nice weekend. I'll do this job after my
> > personal schedule finishes.
>
> No worry, take your time and fun! :)
> [...]

:)

> [1] https://docs.kernel.org/dev-tools/kselftest.html
> [2] https://github.com/damonitor/damon-tests/blob/master/corr/run.sh
>
>
> Thanks,
> SJ

Best Regards.
Sang-Heon Jeon
