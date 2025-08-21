Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE330EF76
	for <damon@lists.linux.dev>; Thu, 21 Aug 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774432; cv=none; b=a3NX4o6GuRR+Bc7lKo5orjHnywvHL97cXjtxNJXfyIhP+0TWtw3Olvycj36SwvzidGY1Nqwrg6mCoaRQPrkFlRJ8LisvZcxC+2KeijFBuvuerjm9ckT/oB/ZlZY2XVfkV/qWuaa9gOYVi4cX/YX/v+V0af77+RCiGx4gbdphfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774432; c=relaxed/simple;
	bh=lq+gs4RnuDDIrP82JMtaZi5rTxofYTYlCI5QlunDzIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtVunclJ/dN/0wGeTho0v2wB/ccA8QFAZg9bh03Lv36E6CiTfeuFMAKbCnt4bfj7LkG+i6H6hs6uz89496daSqFyztXNOS7SAb/0TwP4zb2ylcwDor+zlzGoyJsrRbYGbh9Ou2rocq4ky6NCz9Uaesn4nurpnAuQqLiO0pb8OTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6x4TAuQ; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6x4TAuQ"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61bd4a44e07so152631eaf.0
        for <damon@lists.linux.dev>; Thu, 21 Aug 2025 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755774429; x=1756379229; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiIZ6lQmGLvY+69EJfMpz5tBA2tanpZN8rHbO7rGKac=;
        b=Y6x4TAuQie2kJbWvs58Y4+JirQRNwxKtdG7pNWpJY2uMxW238UPSABau9SNNMn7aaT
         ArMN4jsTh7L1GrBQLqw8BIThBpcL+ChJOv+K+qeuhYVv50nB/VI8iTumMFYAhXEtrfLJ
         eMbMlZlP47NVjIis+noz/hrbpyXXKQt2a+OKfy01Y21lZ25c5ZgivUIPukS9OVAwe7aR
         XiD528R/8BC0UpYHIlFBApgEpycOi4PTSfN5HdHqTHtKQes9x3cFT6UPuwdDAj778RQp
         30LJ3Ljn0cr5hpyOXQr88DbpNaxv8A9Gj2E13ZmUYvFYVniQiA7RtVVO3URDRTrYOB/h
         QbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755774429; x=1756379229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiIZ6lQmGLvY+69EJfMpz5tBA2tanpZN8rHbO7rGKac=;
        b=VXg9cd0c+7lCDba9sPzX9u2SzbDewMpJ7IWIHHhWeueGyCsgyjYp2nPjf6er5E24Lj
         nXPx4QV2rkJjGSVuqgLidtPYhU26Sqz0Ebz7vtL4an2/7mfv9iTymkkBjZlc1QwFDclg
         5hfrh7BuIqbaONX1v6cB5r/Jf8B4EplyAcGUaxMWPknFQYjp7ylGjO//WHPh0jqkBg51
         xWNve1p7p0BN+PcDuZfM/pDyGVHC35lWg3zDprgU+wjJ7/jQ5dYBJkHX0Ub+bLq+Th1z
         2xXK0mCHsfyKW/V+9shrhicJ2CoiCpbjqVYcjx07mDH8lLPMci4YQHHWVU+aqv7Gfoyh
         NTfA==
X-Forwarded-Encrypted: i=1; AJvYcCUpQ/f+W8lWFova4bz3OVa3H7nI3RAxmKTfqI94cHZGWc1473dUZL41pqkg1r0TeoqmDPxpPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMJZCAyczd7hDh5+LYyO5rfFzhL1LH2j0p2cvvSZ1hKdVXHHTV
	yAHqSOGZVn6ztu2H4sZwO6xiubB4i0usEdJslC9AQJLp21qcdWEKZksJlGRgi0pSqrKsK/bqEPl
	Ux2cuvlO78ak3mswMXYnyRfhNx/unubI=
X-Gm-Gg: ASbGncskyD2y+6i2CoVYG198IleUvRDIiLJ1PD3YJjChIpicmcShUpYNUloYBoZ2IqI
	3H5JzkerD4yXPPdaZ0oE6nwIj8y3fceUC3QFVy1QumrBYXIl5qLWwQNjg+R+DYMG9fZVf9+smfR
	AMUCELA/sN1mKi0T/Laj7WpdVKbNv3D9xOGBZlrC/vsvU8sR9b/dgpm+W/jjURigm2I/ASm5bcj
	VRLQbSL/NTuFbY=
X-Google-Smtp-Source: AGHT+IHDLck68A4uwh4SnafV/XdhO0tvddlIcwAPIaIuldKdKV8FYfx8DQctiAAl9nm4vwx0UEGSyaMl0wGd0sRiAZE=
X-Received: by 2002:a05:6820:60f:b0:61d:95ee:b387 with SMTP id
 006d021491bc7-61dab39122amr828362eaf.8.1755774429258; Thu, 21 Aug 2025
 04:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABFDxME5ZEAn+6=0GRWybTi-xBzbhhz7U38pMni3SdKjA+Aj-A@mail.gmail.com>
 <20250821054148.53746-1-sj@kernel.org>
In-Reply-To: <20250821054148.53746-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 21 Aug 2025 20:06:58 +0900
X-Gm-Features: Ac12FXwihon6gThYHt62W99b3GivzmKJ4uU22wv-CFXcXYs_nLemAr_4GPQ0U3U
Message-ID: <CABFDxMHgOPt5zx3q=KRxGGfp86R4V0AgO+FrHDftqLYoG20BWw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:41=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Thu, 21 Aug 2025 13:29:04 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > On Thu, Aug 21, 2025 at 11:54=E2=80=AFAM SeongJae Park <sj@kernel.org> =
wrote:
> > >
> > > On Thu, 21 Aug 2025 10:08:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.=
com> wrote:
> > >
> > > > On Thu, Aug 21, 2025 at 3:27=E2=80=AFAM SeongJae Park <sj@kernel.or=
g> wrote:
> > > > >
> > > > > On Wed, 20 Aug 2025 22:18:53 +0900 Sang-Heon Jeon <ekffu200098@gm=
ail.com> wrote:
> > > > >
> > > > > > Hello, SeongJae
> > > > > >
> > > > > > On Wed, Aug 20, 2025 at 2:27=E2=80=AFAM SeongJae Park <sj@kerne=
l.org> wrote:
> > > > > > >
> > > > > > > On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu20009=
8@gmail.com> wrote:
> > > [...]
> > > > I think that I checked about user impact already but it should be
> > > > insufficient. As you said, I should discuss it first. Anyway, the
> > > > whole thing is my mistake. I'm really so sorry.
> > >
> > > Everyone makes mistakes.  You don't need to apologize.
> > >
> > > >
> > > > So, Would it be better to send an RFC patch even now, instead of
> > > > asking on this email thread? (I'll make next v3 patch with RFC tag,
> > > > it's not question of v3 direction and just about remained question =
on
> > > > this email thread)
> > >
> > > If you unsure something and there is no reason to send a patch withou=
t a
> > > discussion for the point, please discuss first.  To be honest I don't
> > > understand the above question at all.
> >
> > Ah, I just mean that I need to make a new RFC patch instead of
> > replying to this email thread.
>
> Why?
>
> > I'll just keep asking about previous
> > comments on this email thread.
>
> You said you will send a new patch instead of replying here, and then now=
 you
> are saying you will keep aking to this thread.
>
> I'm confused.

I think I miscommunicated something. I'll just follow your suggestion
below. it's the same as my first thought (discussion here, new patch
after discussion finished)

> [...]
>
> Ok, I think this discussion is going unnecessarily deep and only wasting =
our
> time at clarifying intention of past sentence.  Meanwhile apparently you
> understood my major points.  To repeat, please clarify what is the proble=
m and
> user impacts, when and how it happens, and why the solution solves it.
>
> Let's restart.  Could you please rewrite the commit log for this patch an=
d send
> the draft as a reply to this?
>
> We can further discuss on the new draft if it has more things to improve.=
  And
> once the discussion is finalized, you can post v4 of this patch with the
> updated commit message.

Good Idea. This is the draft for commit message. Also, Thank you for
your patience and understanding.

Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
include/linux/jiffies.h

/*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
 #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

And jiffies comparison help functions cast unsigned value to signed to
cover wraparound

 #define time_after_eq(a,b) \
  (typecheck(unsigned long, a) && \
  typecheck(unsigned long, b) && \
  ((long)((a) - (b)) >=3D 0))

When quota->charged_from is initialized to 0, time_after_eq() can incorrect=
ly
return FALSE even after reset_interval has elapsed. This occurs when
(jiffies - reset_interval) produces a value with MSB=3D1, which is interpre=
ted
as negative in signed arithmetic.

This issue primarily affects 32-bit systems because:
On 64-bit systems: MSB=3D1 values occur after ~292 million years from boot
(assuming HZ=3D1000), almost impossible.

On 32-bit systems: MSB=3D1 values occur during the first 5 minutes after bo=
ot,
and the second half of every jiffies wraparound cycle, starting from day 25
(assuming HZ=3D1000)

When above unexpected FALSE return from time_after_eq() occurs, the
charging window will not reset. The user impact depends on esz value
at that time.

If esz is 0, scheme ignores configured quotas and runs without any
limits.

If esz is not 0, scheme stops working once the quota is exhausted. It
remains until the charging window finally resets.

So, change quota->charged_from to jiffies at damos_adjust_quota() when
it is considered as the first charge window. By this change, we can avoid
unexpected FALSE return from time_after_eq()


>
> Thanks,
> SJ

Best Regards
Sang-Heon Jeon
