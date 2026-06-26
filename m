Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FE3BB118
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482198; cv=pass; b=BhXa4ZHsfnCECVKrdwiROB+DZo8M0cbbGlK0HVYGHxnky0+jIHch0RV6tJOid2UMys1R36BPop0ejl3LcNfEZ7HRKgmU3pPxLXnugXZmHyl1PmS6R6lLmufzVqj0G+rL199z56TGUkzc1rM6EFmvvxXDVaX3eFdzKzAF4a3CMRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482198; c=relaxed/simple;
	bh=YVDL1aGMn8IULAzLPaQ63t5D6FVvaCLO75OWrWADPZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUFM9eVb0MRFVIuL2n+V2vzrBPreZWSNRD35pDZiZ2VMZD56uo3pOdGjA6UErzVIww1V+EWXqN2/BTx8bPdL6r0oaV2wectj1UF/qg/iRU1jHrX9cTKT9v4MoGgV2wdr4EDOfCwSdbDFw0r+Vfkg5bcxr8ZyDw9AapgFChqG24Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEmalyDt; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEmalyDt"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8dea42b5497so11082836d6.1
        for <damon@lists.linux.dev>; Fri, 26 Jun 2026 06:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782482196; cv=none;
        d=google.com; s=arc-20260327;
        b=WQx6VKHyojwpnxsNNpPeHmrM0XZ1OJLiVm80JDN8Qngxwt+SNT0fMn/bNJvhNdmNrn
         73D597PvUxy/0pA039M8XC5EIgaqswSanss4b1kTgt22WQwyEN3SrVzVarvTmxRHQr1D
         pSbLkQmhISgBs2VtSNSVPQA1EGWVdBokyJ3ojK6oZSPFWiV5mIMafgrvqr/hlJP2RCFy
         /FA/CYHoUjKUJ5J5dRpPKMzRETtyq81R4eUO5RF6BhN4S+hY66UW7EkUP5pV5nrrvIyZ
         yg7Q1weIQGGb1ZJl2Mx0TOpd7XXCmaC5QZ+2xoGZBA+VZRvZJ4I9R6W3xaPJWaIvWMCD
         f+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j8UgPLpU59EN9jrvEy4338bhTXSBs+KvINqBsOxg3n8=;
        fh=9/H8MzIoRJ+4tm3tDGzNkpk8SKR80b2sLi41+uvnoiA=;
        b=C1lvBxxDLU1cs3Xy6m33JSCqRE+06tuzn8Gkh/hQWOygY0eVAh5SZjQd2xVBwDKNRA
         x3fH8EBxAC7TeTF6fsXrLP0r3n5VdK0zgCkUeCPgEfsOTfcjc9y/C/qPeGE0ivAJZxjc
         9gKxvKO/cS4c3QnsfJMGy2yFBM0mQj+x82uvPBFVnGf7bBstcC1AY7uPn8BPCMhDuOdl
         DgtFG9w83Tj7Gv6nyifL9Kw9bDchPXN0bYt2vNMTgMo1rEDRbX7RqnKnk/X57F+BpG46
         x+btp1p/4+5xYhCE1hHtoygCr1oJmzDM+8eW6RqOrnMvIrNo+O6uHTZSrK7oN5wLHZUi
         SSRA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782482196; x=1783086996; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8UgPLpU59EN9jrvEy4338bhTXSBs+KvINqBsOxg3n8=;
        b=GEmalyDtFK3Ftj4j4XNrnxlJ/HfSQzMljNJXrLzI7INuq2J+XStYS+3aS0mrpb0efx
         Avr7oNxQwXs2PYkrhOvFoc3l5Z6dr53sK2886UWNZUODcqtqq8eSjBWKF4jvp1+Ahh3/
         pIFMLsnvD/VJflqO5Wq41wwP78aep3K8xgcQsavcJkgm541V2zVv/HjSO0kpYnTOf6+B
         N8TcrYl3bEqgCYbI0SfkjYiYDG55PEyR7oIO5wRpp6ACZ3d7XbLGSbrHCRsDn2lfJ/SI
         bA2hAvdsA3wBwJZYxXORpfdTePjd1dUpKYhv5zX3SonhhfsvIB/xy4ZU2f0ji2BmOPgZ
         Cgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782482196; x=1783086996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8UgPLpU59EN9jrvEy4338bhTXSBs+KvINqBsOxg3n8=;
        b=bUAz9n2Jg6iw4U4DbPmRc4kxnM81my0mZDS60IBcPqbDfnMp6/LMd4hWpB+cP3OphQ
         YXsKNAUijkw7S4zF/cKtUfC6PZQbR72l6qYhlMskWlsPss7VZKlGvzAwHz2GXP/FWjWV
         5Gj8N3/xIRDbWUNJZMpoTRwTL7uBGC4D00fQrbUrof2bLTzY333z1cWIKdS9dWuXPhic
         9MyuGvbwtxnoyo09qoaax1dslzsJ/r50wP7fqe74LA6uRb1WZjrwfLOwio6V1altu9+e
         mevRK2LlB83H5NBcS6OWm4o2xxSzXZj+7M/LbHUp2F6Z6uJD0Ya9qr6gMfZO9me4nQZu
         6iZg==
X-Gm-Message-State: AOJu0YyFkXB2RfG5btv9bsUFFC0/wk8mYV6nw6rnT5A7w0qVQsm+mLvt
	g4Wi9XPBmRIqSgitm0gRbJJFa6LB+B/51UL+sYngUdHs4055GhNdBVH87XBEPziC1eXOeDjUoVp
	syiZQmtIxLQJ9p9ix4wTSnQBiJX0U6p8=
X-Gm-Gg: AfdE7cm0oPAcLAoug5Ul4dOFlHW6MpYgrj5suK8KPHKc/garYthzkF0DNhsICHE2LVk
	5dwcYyLvvuOGN6Ljw9kBJPJ8UUQ7C8e8wDpJjB+mSgrceR/gkBPw56anutB9iqhak8pV+DMfjEI
	KrraXsyevHgI1bfiZ2dRqb+fku+Snhl5tikYBoNefhJHZWjrKB9v60V1T2fXKaBNe2tEd6QhkJv
	ETcuzzaWMfPlV6X9oUumE5d6B1dR2ncsQuGYlH4HEurCH2I2k9aJi0VzqAZuuIi+zu0g/kombUZ
	dc7Q2L6QLYJCX/zOwnLqeD51Y5FYsUyPvZE=
X-Received: by 2002:a05:6214:300b:b0:8aa:a025:78e3 with SMTP id
 6a1803df08f44-8e6d5fa1841mr110765616d6.6.1782482195752; Fri, 26 Jun 2026
 06:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAC5umyi0v8Z3Frtr4yL_LRZu9O7wWF1HZfVbutagORde_i-7XQ@mail.gmail.com>
 <20260623134951.67000-1-sj@kernel.org>
In-Reply-To: <20260623134951.67000-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 26 Jun 2026 22:56:24 +0900
X-Gm-Features: AVVi8Cd52BvgGNRDlWuqiJtllEEyQt-RK1HSoMYDsqisgeQtuaev5JOT6AjbT5w
Message-ID: <CAC5umyj0qTqR0HpHux6+G6bvGCQqtM8CVVXSZSCt66OtJU7+AA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] damo: support perf event configuration
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	ravis.opensrc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B46=E6=9C=8823=E6=97=A5(=E7=81=AB) 22:50 SeongJae Park <sj@kerne=
l.org>:
>
> On Tue, 23 Jun 2026 22:29:42 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > 2026=E5=B9=B46=E6=9C=8823=E6=97=A5(=E7=81=AB) 0:24 SeongJae Park <sj@ke=
rnel.org>:
> > >
> > > Hello Akinobu,
> > >
> > > On Mon, 22 Jun 2026 22:49:31 +0900 Akinobu Mita <akinobu.mita@gmail.c=
om> wrote:
> > >
> > > > This patch set aims to make it easier to specify the perf event set=
tings
> > > > proposed for DAMON by Ravi's hardware-sampled access reports patch =
set [1]
> > > > from the damo tool.
> > >
> > > Seems this patch is built on top of the per-CPU/thread/read/write mon=
itoring
> > > patch series [1].  We made a plan [2] to use another user interface, =
though.
> > > The plan is, making the interface ready for page table accessed bits =
based
> > > monitoring by LPC'26 (milestone 1), and implementing the perf event b=
ased
> > > monitoring on top of it, by LSFMMBPF'27 (milestone 2).
> > >
> > > So the eventual damo part change for supporting perf event based moni=
toring
> > > will be quite different from this series.  I guess you are sharing th=
is series
> > > not because you aiming to merge it as is right now, but just for shar=
ing the
> > > code with other stakeholders like Ravis, not me?  If I'm not wrong, I=
 will skip
> > > this series for now, to focus on the milestone 1.
> >
> > Since I will align with the final user interface later, please focus on
> > the optimal interface for Milestone 1 without worrying about that.
>
> Thank you, Akinobu.
>
> >
> > > Please let me know if you want more of my feedback.
> >
> > However, even if the interface ends up being completely different from =
the
> > current one, I believe that enabling configuration via `damo` using
> > symbolic event names like this would still require calling the perf
> > python interface (`import perf`) from damo and modifying the `perf` too=
l
> > itself; could you please check if that approach is acceptable?
>
> I'm bit concerned at having such dependencies.  I'd prefer making DAMON s=
ysfs
> interface uses a symbolic names and just use it from damo if possible.  I=
f that
> is not possible, could you share more details about why such changes are
> required?  I'm still lazily delaying studying about perf events, so pleas=
e bear
> in mind with me.

Theoretically, it might be possible to initialize `perf_event_attr` within
the kernel based on the symbolic names of specified PMU events.
However, doing so would require implementing logic to read
`/sys/bus/event_source/devices/<pmu>/format/*`, as well as duplicating
functionality within the kernel that is currently provided by the `perf`
user-space tools.

However, if we limit processing to only the minimal format, such as
`pmu/config=3DM,config1=3DN,config3=3DK/`, described in the explanation of =
the
`-e` option in `tools/perf/Documentation/perf-record.txt`, it may be
possible to minimize duplication.

> >
> > Thank you for your continued excellent work on improving DAMON.
>
> Thank you for your grateful contributions, too!
>
>
> Thanks,
> SJ
>
> [...]
