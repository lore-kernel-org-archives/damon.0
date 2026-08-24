Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66D3EE1E9
	for <damon@lists.linux.dev>; Mon, 24 Aug 2026 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584999; cv=pass; b=r+GFEWBIxQ5K9KJal4kAwaKVvSP43ebR5j/MPTT/ZL+Qy4kPIgI0cdSvTewIIb7ly0E+SU2Xddic2l9VmoQEtWFp6m/igiyDekxMDUuEv5hVioRZcRjT3CoumPEsg5fUsMhS2V4GEbeIExG/cDIn0MsSQX5yj3RXf7u70bMu7/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584999; c=relaxed/simple;
	bh=w4M3PCOM2gpUz97sjX5Lbk112SdjbcxEFkrd/Swveds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNWzfbiN8hi2T/k5BBKw5CekToqYTp31mYGKRlJcXCvxnF1/NHbRGMOMA6T7WF7wkWIe1MsMyV7V/p9+HZpSEYGNB0yUoeXt3Lv2tOhRFLFOiS+J2Nikf/+U6jXG0cLHLGDPqbd/oCeS9oA7Ej8IaTgIKQgplerA3L8dkGqeYh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6YvktUD; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6YvktUD"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so6593130a12.3
        for <damon@lists.linux.dev>; Mon, 24 Aug 2026 08:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787584995; cv=none;
        d=google.com; s=arc-20260327;
        b=s9wFsDscbBbzx96oqkoq7R+ngIm2kxRAjS+683uVvJtJlldUM/m2c5rV2v1DJXdcL9
         4dwsqJMTlbkl2w4fthwBpPBBj0V2ug2LnbJknXptE627xE1Zskl2GsPYVeuu0YMWrubg
         +lQkYPUcNUNXzC1qTCNK0UrYYS/86RtZ9WiaQ5+1Oqi3X5hBLC6SdzBFU5HnjizLxq5V
         lPJ82ZRveb7QQ/6AqgBtBUBKp4BUBQe7+pcOxGi7y8HooRm/e+LD4ukUrGQt13Z2wxYd
         RaemNQnX8fJl+7VfmByqgW4AY1Is3yr3exwDZH1HoX++HTSpawm24IdSFJH5XCVWlQ5W
         FzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jH77beqs+5zKV6amTfBDwxpeesgjCtaEPDf8Q4m2/ZM=;
        fh=/PTN2LY8P4X9sHVbUBWO55svL6VFhLz4Nuk1ztXeoC8=;
        b=Lf95Tj5b8FHDxT+FqjULB3u5GFO+X0Z1Rvxlp6EGKRM0W6wxSHekbqVOrszFCuxj5C
         cil27MkjoRTE1wMKwcc6WRCYiYgsICLBe6DjRkcolg/REvQZQjpwDyGvvVy7LG4NZY1V
         SC741rkQuWH+sg0xSKY3JBiWZvb7OzOFtUpWYcxnhnUvPy3lADqYLKQrXASqB/dAQOCR
         ZljD0s0RncIC8LvDTWkdgygZ30YGq0H7qM58Y5HXfP3S1i7js0gQ2IvXWeBbpnfHEkcU
         vZVm5LdcMWSpJIcpZ9/Yb5kYpbFi55a/s6/GxFQNHUN/aWO6lPg22lKXKKzVS7ebv/a7
         8p7Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787584995; x=1788189795; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jH77beqs+5zKV6amTfBDwxpeesgjCtaEPDf8Q4m2/ZM=;
        b=M6YvktUDnCdmLfpD6wxFNdAwN/XZSbfIX92pBamzEsqCl9q+3Zztxc3PrDVTAYoYhP
         K083Jmdm3BpYZnf1O+d/x7+FBSBQkZOXcXTZ0tg9j7Rkqzl+50CC2cLIPzHy25NeP7nz
         cRgrdo3C7KawuAs4fohIUI9EI2Zh9kuq8Z0Wvpu3wdLDZ8odIlG0zT5dXXezH7yMVyVr
         0CkJzoWCKadPM5NbUPRONokqm2KLMtMzNhhHayM0u8CtqJ6fQmpX2qHfiRd2sOGCrj98
         pB5xLG4gtjX8IaJcn2Ths/loEdMPEpl3uvroR8/OIz3uVY8nSWkDOs49JY62F/XWaEq7
         NLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584995; x=1788189795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jH77beqs+5zKV6amTfBDwxpeesgjCtaEPDf8Q4m2/ZM=;
        b=sCl0o/5kYb6UXTJTQbzq8Eh3U2REtTPe3M2yGSMcc4qG31Qjb36yXIkhGpHIuJHJOy
         LSB/8s8Z4Wj+xqSZRSRO6zqW+t6cB4pY4UJCcHxVnXZdngF0FdkoxAdQJm8SAvQrOGsz
         VpAuUn9KxqXGAFncN1QrQnQA9S5mQrzdI1XYLSnmZ6gYYyz64kunrZbnTNHgDo6ikfcT
         gtwPY4ELqFiTfogmKbc42BKptVCsPgBUNakD+QHariiX92TUNEm5l/g/Cz8VNBep6kJI
         Tms3mJUokR9D8Zbo2jsAt8MSlH5z1AfP1euFIH9V/s3RqTA4mnxOsfHAaj/fbt6upZo/
         1yBg==
X-Forwarded-Encrypted: i=1; AHgh+RrJq5qCXC5yrd2wlqNPQ9BHLe7m1CyXwayW/k1hLz97ZqD96bTPkz+OHfQPzF5VEQ2JEZ8z5w==@lists.linux.dev
X-Gm-Message-State: AFuF++nqufx9lOkbwUyAJNrvWhFbgQEqFw4P1IA0XZ5i8rOOb2pGa9ia
	XGT/HhQqtniXplkvU4dopp5P5hMp7GeF+x2ChlngTk+JRJsO8xcX4KR2F1/Wjse2aC+f0qszrFl
	/IL93/MNe0oU3O14KIgnLHx8coN2mrtY=
X-Gm-Gg: AR+sD12AsOP2OTOAOzLP7NcCkJXGTLRCmPioWOWlyCVlsdJzxZgNYMqLywxyKU7cxmn
	5W70C/LRdS4vs9M4LduVyf6NzxYUkAqsA7ZkmlKMQD3Yjb6R3eV+XF1Sh4ISoug/jH8GoEY3hqs
	H5AYxztJOSMo5dbjZtV0J7lYh5NpzXFk12jJMRPKern/XbDl2C/A6SLl2DG3nr9DiZHEItPzhOf
	Fhd8BzY0ufcDpaP705s3WtV7rGJjSZNCjKMfv6IJzz1DqJbWQiDo74P+17crTrPIrwnkORdrZV1
	lnBXv/X+HXlC0DS7XxTv2f8b4Hqyx4Xm3MsOc5V5l0BHAg==
X-Received: by 2002:a05:6402:3705:b0:698:8847:e2f8 with SMTP id
 4fb4d7f45d1cf-6a582ba7883mr23687259a12.15.1787584995174; Mon, 24 Aug 2026
 08:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALa+Y15zNhpubyH5GQgu_BHesrwRdH0B8k5cqT3o_U0h5A2e-w@mail.gmail.com>
 <20260822003237.88274-1-sj@kernel.org>
In-Reply-To: <20260822003237.88274-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 24 Aug 2026 23:23:03 +0800
X-Gm-Features: AcwNN1UfGZhL6wlAt_EY1z_vCXyRGndLOrHHNLYnegIDLisoABbScauoZxjolc8
Message-ID: <CAN_Opa9dQsz0hA_-+SS7hyHHtrYu2esK2Cp5X=G-YNFr5vgVZA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
To: SJ Park <sj@kernel.org>
Cc: Ravi Jonnalagadda <ravis.opensrc@gmail.com>, Kunwu Chan <kunwu.chan@linux.dev>, 
	akinobu.mita@gmail.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, bijan311@gmail.com, 
	ajayjoshi@micron.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 8:32=E2=80=AFAM SJ Park <sj@kernel.org> wrote:
>
> On Fri, 21 Aug 2026 09:32:02 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > On Fri, Aug 21, 2026 at 2:55=E2=80=AFAM KunWu Chan <kunwu.chan@gmail.co=
m> wrote:
> > >
> > > Hi Ravi,
> > >
> > > Thanks for the detailed reply.  The fan-in diagnosis makes perfect se=
nse.
> > >
> > > > Your series is based on the v1 substrate, and the way an event is
> > > > configured is the part that moves most.
> > > >
> > > > [...]
> > >
> > > Glad to hear v2 is on the way.  The probe-based model is actually
> > > something I encountered while building the AUX backend. When multiple
> > > sources can feed the same region (e.g. PTE scanning + SPE/IBS), the
> > > question of how to combine their reports becomes interesting.
> > >
> > > For example, CXL tiering may care about physical-address locality, wh=
ile
> > > per-process monitoring may need virtual-address attribution.  How do =
you
> > > see probe weights being determined =E2=80=94 is that expected to be
> > > scenario-specific, or is there a more general principle behind the
> > > weighting?
> >
> > Hello KunWu,
> >
> > SJ can answer that authoritatively -- the probe and weight interface
> > is his. Here is my understanding which SJ can confirm later:
> >
> > Weights are relative, and only among probes. A context can hold up to f=
our;
> > each report carries its probe index and credits that probe's own hit co=
unt,
> > so two PMU-based probes in one context are scored in proportion to thei=
r
> > weights, and that is where a scenario-specific choice belongs.
> >
> > What does not mix is a weighted probe with the other two sources. Any
> > nonzero weight switches the whole context to probe-weighted scoring, wh=
ich
> > turns page-table access checking off -- so SPE cannot be blended with P=
TE
> > scanning, it replaces it. Page-fault reports carry no probe index; they
> > credit the region's access rate but have no hit count, so under weighte=
d
> > scoring they are not part of the score either. Both coexist with a prob=
e
> > only at weight zero, where everything feeds the same access rate and is
> > indistinguishable afterwards.
> >
> > So for your case I would read it as: PA locality and VA attribution are
> > different targets and different address kinds, which points at separate
> > contexts rather than one context with tuned weights.
>

Thanks, SJ and Ravi, for the detailed clarification.

> Thank you for detailed response, Ravi.  Ravi is correct.  Physical addres=
s and
> virtual addresses wouldn't be able to be monitored with a single DAMON co=
ntext.
> The user may need to have a DAMON context for physical address space, and
> another DAMON context for virtual address spaces.
>

This also corrects an assumption I had about how the DAMON access reporting
model currently combines different sources.

I had previously understood the new push model as something that could
be combined with the existing pull model within the same context. I now
understand that, in the current design, probe-weighted scoring switches
the context away from the existing PTE-based access checking rather than
blending the two.

My previous understanding was therefore off. Thanks for the clarification.

I'll update this point in the blog I'm currently working on, which I've
been writing on and off for almost a month. I'm using it to document the
evolution of the DAMON architecture and the transition from the
traditional pull-based access monitoring toward the new push/probe-based
reporting model.

Thanks,
KunWu

>
> Thanks,
> SJ
>
> [...]
