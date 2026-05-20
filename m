Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379036EA8B
	for <damon@lists.linux.dev>; Wed, 20 May 2026 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302285; cv=pass; b=TK3ugr0h4rXSU7c1woIPp7HRHaYgKAMAlMqtdFZwpatPsBoGUYhoTP/Esi/nAiHncHQ7VSHByM3S61Rs1hCEjpl4PcaHHZpkMLTmXFmfODwPy7LtSkXrsiDQSLlowVc/mChRYdRIx4DdhUMlI7PJwLg1CPsN2Nt6i0pD2BzBNMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302285; c=relaxed/simple;
	bh=Lio2FLXwC0TpzoBc6WCWqG3B4AhXxFIkYmOF2Ye6W3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0Eelg0vi2L4wpZDBbikza3OTsHhpHy1no1q1TYNln3ZO3mArE27fGDQSOBNRxMVHjMJsRGA35jleYjGBSR+7gyrv23QD7WaXJ2KPSUq2fVPdKY0a0x+vXVhlCltZCPwAIyJYDHg5kEQdbKXi4nM5JqgO/0fnWDasH72UxB58Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr6uG6UP; arc=pass smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr6uG6UP"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-134ac81c445so3489180c88.1
        for <damon@lists.linux.dev>; Wed, 20 May 2026 11:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779302283; cv=none;
        d=google.com; s=arc-20240605;
        b=L39Oe7Z0IlLMDrWWDQEnGFLCvPTLQG4qxU7VIEMju1HHXNGL9MH3YsBFeYxmLnZQr1
         LTN5w2C1+QT5HbQ6bKA91uoXjsWpuEuCHDEfk52Rao3fiMPnFvbu0eB+b7mDM55wwCqr
         FUuANHn+xE6HK+VuXWu8y40iOYKrU3Hoduka7OjHasQBMSgoQ50gd6AC7zuKurYgbCDz
         lKhlhPOgtPZqsShM7ClWom6axku/HaPGNwuEseIYqCHvwKWO1/gEkOKJAVBC51S9aR6h
         cdTDzsTz0W36c5WqvNpKOwzcIieRJjiyUOfWjNhj0pDosGGGdIV+81+8JkMSzYdVxBvn
         sm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BAuf7MbQZyunGAyUzpAv9eVVSXT8WNUhWVQaJEfQARA=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=hO66z2c1MhTVan/O/M4ylDbz9GJDjKzT419ymu5Wu3s4RvDiPlI/aqSRj9UO9cuQDX
         RCmny3giSScla21MYc3vsGdK0ii8EHfS9N3z2CoY7OAwqjzeKe5EWPLvdmsGp8XZz0ox
         lHjWgRUkeh37Gs3nV2XEKtYiM8NG0yFbti4pQEe3/aHe7Q4rNYtFoT7eKZXWakE0mwhw
         BJFdiaKeIvrly7VaibmR9RvyUvHHYeyxbxBMrleYU0yZq1MfHp4JkFAtBp5AGvxKzUj3
         jskPU6KZa2Y66PuKrgJevPkUHHXDNgBx7uRQ2hnEeOiEObO0yAr41nunBE0Xl3EwCJOg
         CtyQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779302283; x=1779907083; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAuf7MbQZyunGAyUzpAv9eVVSXT8WNUhWVQaJEfQARA=;
        b=Fr6uG6UPhThMHQLKEtYrnX0E3woY7s0e3h14qTJmykJaCEPTIjrTe7mQa5XfsHbALn
         NYuaqOb3GYfyLVVRJncnihlE1rvhRDozKYITR8d15sF/fJ1R73q53VItsoq8LCTG0Gn5
         AkiEibiwUh8JRz8GwSBV9+kE731vq2LZN6WyXlAaCBPKdVirEMgupSKnGbgHGmx0gTun
         3u232ZwIf+xdMc9mth7NGX1ZJj0WQqLGleO8DIIqE3etpxJgoxiA5ipw98pyBSqLqOWo
         6ugNoHr6gz+r1MwlVB96OnzypJFvUrvXFdF8WPREGPNGpQ3puRTdUPQPrpo7OyAGuzEH
         QFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779302283; x=1779907083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BAuf7MbQZyunGAyUzpAv9eVVSXT8WNUhWVQaJEfQARA=;
        b=dWlvHcuMaAYUeW5NQTGHGW8svCxKyZtvunuzsb8tipEJT2IZFeZQi0LbY4wEwH/R/a
         MLpOAeu7MzG7eTuT+9ltBdyzCWHJdyXyHzE83d95w9g4MdjAwTlrGraele/aCDAunkJa
         kCnp6T0cRRW/JB5Xi1pSBELsQ+75jMRxI2LN8PRYPQ2RZmWPcEdGDiRTDtGlW+amN8cd
         PI3KviOw8TQB2m6h5wqmRYVTlyOiZ9mUGTLvN16S4HkIdnbGIy9w49h6fUTDQ6kQEYCG
         e6BSyEZt9PFCPYqpj6y/DNLX2YOXK+kkufjXf6fMGVpjAvGxMFA39Cq2ZXVIEfLh2MK2
         qDjQ==
X-Gm-Message-State: AOJu0YwljQLK0W2OxkaXQFK6NjnU4Pq0uX2vlc4+018v4t+1cSDSSrl6
	wFXENnd/nZuNX8yH4kUvl2fE2/bn3wiTTLZ1MeXfPVffFpk+kRk/9Dc0b1MspZNn9Xe0OrnGu+k
	66jQ36BEzx3SvmWv/lSViZW0xekhpEA==
X-Gm-Gg: Acq92OEgtq1J9Nys+7yPGUIHOmwHZE+HoaUPYnk4+jblLya1gqEuJaaXRiR4q5ufAte
	on9z05mmhx9IWMqHRBUp1io2S1y2djZEd89RXILqpwZ3Q98/N/hHjnT/M9YdE88w+Gv1AJ35u5I
	3dzpO6Xw204D5JdDW6kg81qoGAn15fEU9stSNnRTjxKwi/2eaDGxLfJ2QPGGjMADG+OqDIkT850
	YRx+0jdEMxtTFZEO304gfZgXoUvNMKSU4vzkT2d0HRk3Ptfxiqicl2dzZPnXXO6uUyqVMXu33O4
	JRoCuaPf6o/Dazbq
X-Received: by 2002:a05:7022:6b9b:b0:130:9b78:b17b with SMTP id
 a92af1059eb24-13504a4fd4amr11166328c88.38.1779302282639; Wed, 20 May 2026
 11:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260516210357.2247-4-ravis.opensrc@gmail.com> <20260517184705.4652-1-sj@kernel.org>
In-Reply-To: <20260517184705.4652-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 20 May 2026 11:37:50 -0700
X-Gm-Features: AVHnY4JJcjwwRzJzIvyxW5twV6UCxEviLZFBxwk7zstZSFSrNzLAY-O0iJAod6c
Message-ID: <CALa+Y14AKLXSP8HhOMQomXczok-BS7aderfj_tYG9qdS9bKgvg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] mm/damon/core: floor effective quota size at
 minimum region size
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 11:47=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Sat, 16 May 2026 14:03:55 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > The CONSIST quota goal tuner initializes esz_bp to 0, producing an
> > effective quota size (esz) of 1 byte on the first tick.
> > damos_quota_is_full() rejects all regions when esz < min_region_sz
> > (default PAGE_SIZE =3D 4096), so no regions can be tried and no
> > feedback reaches the tuner =E2=80=94 a bootstrapping deadlock.
>
> That depend on whether the goal is already [over]-achieved.  If the goal =
is
> achieved, the tuner will think no change is needed, so keep the
> effectively-zero quota.  If the goal is over-achived, the tuner will thin=
k the
> DAMOS scheme should be less aggressive, but it is already effectively-zer=
o
> quota, so keep having effectively-zero quota.
>
> If the ogal is under-achived, the logic will iteratively increase the int=
ernal
> esz (esz_bp), until it exceeds the min_region_sz, and finally start makin=
g some
> effects.
>
> So, unless the goal is already [over]-achieved, there is no deadlock.  If=
 the
> goal is already [over]-achieved, why we would want to make DAMOS do somet=
hing?
>
> Am I missing something?
>

Hello SJ,

You're not missing anything; you're right.  Stock DAMON's
feed-loop tuner ramps esz_bp out of the seed quickly under an
under-achieved goal -- on the order of ten-some ticks at the
1000ms reset_interval the in-tree DAMON modules use, so the
floor isn't gating anything that wouldn't bootstrap on its own.
No deadlock.

I owe a clearer accounting of where this patch and patch 1 came
from, since the same origin story applies to both.  Both came
from a parallel debug effort and should not have been carried
into this set.

The work that produced this series came out of an effort to
enable hardware-sampled hotness as a DAMON access source -- the
companion AMD IBS RFC

  https://lore.kernel.org/linux-mm/20260516223439.4033-1-ravis.opensrc@gmai=
l.com/

-- and to characterise its closed-loop convergence with the
existing CONSIST tuner on a heterogeneous DRAM+CXL setup.  Early
in that effort I was hitting random NMI-context hangs on the per-CPU
report path that prevented runs from completing, and while
debugging those hangs I wasn't sure which direction the
convergence anomalies were coming from -- the sampling backend,
the report-ring path, the tuner shape, or the quota controller.

I made two controller-side experiments as scaffolding while I
narrowed the problem down:

  - A per-tick growth cap on the goal-feedback tuner
    ("max_delta_bp" at 5%/tick) to slow how fast esz could grow
    on a transient.  That cap stretches the bootstrap above
    from ~13s to several minutes, so I added a floor at
    min_region_sz to short-cut the bootstrap.  That landed here
    as patch 3.

  - A separate access-rate seeding helper (clear-on-migration)
    for the goal-feedback loop.  Some early versions of that
    helper left the access-rate fields in inconsistent states
    and damon_moving_sum() landed in an underflow path I hadn't
    seen before.  I added a saturating-subtract guard to that
    function.  That landed here as patch 1.

Once cpuhp-related fixes on the per-CPU sampling path landed
and the NMI stability problem was actually resolved, the
convergence anomalies were tracked down to the sampling/ring
side, not the controller side.  I dropped the max_delta_bp knob
and fixed the seeding helper to maintain its invariants.
Patches 1 and 3 were carried into this set even though their
justifications had gone away:

  - Patch 1: with the seeding helper fixed, stock callers don't
    reach the underflow path -- the invariant holds at every
    aggregation boundary in stock DAMON, as you noted.  Belongs
    with the seeding helper if and when that work goes upstream.

  - Patch 3 (this one): with max_delta_bp dropped, the slow
    bootstrap doesn't happen -- the ~13s ramp is fast enough
    that there's no problem to solve.  Once stability was
    sorted I also moved the closed-loop runs in the companion
    RFC to the temporal tuner, where the bootstrap concern
    this patch addresses doesn't even arise (esz_bp saturates
    to ULONG_MAX immediately when score=3D0).

Apologies;both should have come out when
max_delta_bp and the seeding helper did.

Dropping patches 1 and 3.

Patches 2, 4, and 5 are independent of this scaffolding; I'll
reply on each thread separately with the relevant context.

Thanks again for the careful review.

Best,
Ravi

> I'd like to discuss this high level thing first, before digging deep into=
 the
> details.
>
>
> Thanks,
> SJ
>
> [...]
