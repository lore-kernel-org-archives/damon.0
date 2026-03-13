Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4878F2E
	for <damon@lists.linux.dev>; Fri, 13 Mar 2026 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387368; cv=pass; b=fAsJWoAe3Bn3Omg3JgMDbS836kJ26Agvl9M7T+/m5aKSqbpdNqnmIUGGMS2ipayhAI8HeQsMyszbLHH/dhS0nfV2R2YLKC5bcFrqUbbFmezYrYozB5wiZ9w3AYUix/C0zv1b8v36nL/MebtHBdUJHWOpTatTrki6bbZMty3va0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387368; c=relaxed/simple;
	bh=7BxtYs5dP+32hJKRwxcmECjtrK5HGmje21ZkLZYDnwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nyqvfsovwg6AlVs8IrNPp7CeMxYwDMISYQ24O7lyjeR/SdGuFLB65T/PaawwKFRdsOOtXaZrpf+STDYsiE9GKljjg1Tg9gSFHzXSnzkZ8go5jpj26Nw+CQi23bJ5av6SMzNqL8NAFxn3b65KPyuRUjcGpcoOvtZldYYUek370pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4oy7ucE; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4oy7ucE"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a06bc2f1bso33456746d6.1
        for <damon@lists.linux.dev>; Fri, 13 Mar 2026 00:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773387366; cv=none;
        d=google.com; s=arc-20240605;
        b=a3D4JcEd0fbqYkdY0CNFDo7Yw6qL1/jJe0yZSqRWL9vCYvLo8i+J3IvHEN65c4wt8g
         h29sYImgVvlNxtapKlngzsYKJcjt+oRucgt5H2lx82vUAyzX0pivEdOH4JSLszoQylvK
         v5t/+Mnkh23cHs1RcoEtC41xGUgjC2UqEJC4/tCNNh1HYFJbKqbbLe9PZwPezTV8E4ZR
         xrCjsjFiPbqTZ0vRgp6FINb6ur2f4SplpeHCuopvyf4nvLuny5oTs5JVfc64E7iGoONF
         EZDCkiYQcNhA+vtzsjVQwucbEinWO1d0IqnaFbpDXnThHjs0WalqiVb1fwVd9JRHszPz
         gnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=32TxknKsQkST11pmGc9amAGrsMnkaZG1pTJt8u4XR6Y=;
        fh=Mf9DINRRmhThOYETEReLQX7AM1T+ry1aGtACQzu4Fyc=;
        b=Jp5WQtVy2xWbsWmeJ//nvEh1uHvP4gFumx7z2qgcc8INrNtZX7ymvtOuJ2a+IN3fwE
         nODEz7s5hlUlU9vIDYF274CUYp5kIDwdFjV0oJpBt/G6y4Yvt0B+SrrdTLwJCmJkeKH+
         nWj2BT5bcOXRMfMVLedTJbRIGJPHa6TFSjLfx9TJZoUqIsKDYE+QzFZvQ5hsO50hoe0L
         tBNFIQveEPs/B3LpC0Y0RfvrUXs/mkDhKnpMb6s75+WpWPkmnmOXS6C03rwkoypcxJXq
         kQzV2nNqD73DpwXOKndWhrngW4YtkcMzjLgPPwn7MYkTaME9HfKgkE7yclkxbJyg74Sd
         gV6w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773387366; x=1773992166; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32TxknKsQkST11pmGc9amAGrsMnkaZG1pTJt8u4XR6Y=;
        b=h4oy7ucEOSlU1SUGgP/wqiOV/bci2tALuBysS3/rV7C0FYYT5zVwkIRe+u4iy8ZJrJ
         A4rrPRQwLxKH4YxM8e5TAp2bao/q3F17aJp1ilW6o4YUi53YOV7q2KKA8ID+Zy3V0k6K
         /wOyEgD+TDhPmZsW9qBG0dsA2EAvquQ6SXn0HSVABueSCJZe3mqOFti1nsbd7/No2tjU
         sg2sXzav0pX0Mg3VUMoW4ErZ0p0ITN3RD1ObCT91VJQskdT5uD/LIod6fGoiVeesOiON
         VbiMONPvF7kagt8hK9te/MNNO0kSUGmUx/8JI0LgkymAjcYbzFkIA7eyQP15nVJuMyvB
         9w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773387366; x=1773992166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32TxknKsQkST11pmGc9amAGrsMnkaZG1pTJt8u4XR6Y=;
        b=oegWK8WLxYVtmIfVDU1KSHcjejcxgMBhxPOIY3qp6pJZ2kDvLEoNGum95U/Fz1HPCQ
         8h8CgVnQQbgwUCNKxRMamQ/ezuXH0c0Izck4/IKZdrMJJTDNea5p4PzWMAeckidh2a2A
         t9fvz59iSkWApxuN0eoaVjM8RadFljJKgq9F29WNamUMzXJ877KNwv1n6HJCulW0fhI5
         urf1Bcj7KIE4S/bO6E6UGu47LumcjX5nmOFfw2L5eqUjtqmJAC8gQNoCLcD8Ind3SM/b
         iSa1zHV2V1dWqG34O+uGz85c81mXpwXLbhxgHDnWiBs7+x5JX8LRkjWkwuEM77oKZczE
         Ob+g==
X-Gm-Message-State: AOJu0Ywr2luOdUmXZFC5cqygMUJOidzhBeEwguRjB9fJYaICfUgACqY6
	K2tX3m7V7ON8gfuGHudR4sx0+4c9B+VFxVQlob0OvWSwLkd5hTYM+wPHyYlLyBNnsLnyTL7DeXm
	m/rI2enSms29ZyV3Z8Q0T4Ntp6lcV7QI=
X-Gm-Gg: ATEYQzzigpV8gEmHo/vgamMloXFFcb45TCL+MDVCuB/rqUJyqRYUepzLfwiN3DYoNNs
	ldK4q+i3pmxdg7c6s79PzmCNEGwlZfNLLW121E/l/B3Pp/V18UhEa2Akh6eQ7H+m+cDtQnoNC4Y
	F+Ux0fkzMLPcdO8B+JNPrrwbyK216sJWz+EUxsjJ2IhKs9JyPmpq+KBSHXRqO7hpg7VkAxkEKRI
	Pw9NKH0IAfr+PiMEvFT+KDhWA5gVLe1lCiZ/ydYwqXAOf4pIU4S6Aq7z2VgVCSs5jstu826I5Ye
	kxjdVvhhI3wMVV9fI0n4WFeEskw0bvT0iWJ0PYti30OkSw==
X-Received: by 2002:a05:6214:1c41:b0:899:eba1:3c09 with SMTP id
 6a1803df08f44-89a81f8bdf2mr34497536d6.39.1773387365944; Fri, 13 Mar 2026
 00:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309010009.11639-1-akinobu.mita@gmail.com> <20260311005132.90285-1-sj@kernel.org>
In-Reply-To: <20260311005132.90285-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 13 Mar 2026 16:35:55 +0900
X-Gm-Features: AaiRm52QpcGUfYd4NuQv_irj7bLW-qi_sfUP7PumQCf3RpjSIeWLeH2MzEDQdgE
Message-ID: <CAC5umygtmi_rHUbayYn=EMFg=0ztZH1ot73KzsaHTy+yk-a=Qw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] mm/damon: introduce perf event based access check
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B43=E6=9C=8811=E6=97=A5(=E6=B0=B4) 9:51 SeongJae Park <sj@kernel=
.org>:
>
> On Mon,  9 Mar 2026 10:00:03 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > DAMON currently only provides PTE accessed-bit based access check, this
> > patch series adds a new perf event based access check.
> >
> > Since perf event-based access checks do not require modifying the PTE
> > accessed-bit for pages representing each damon region, it reduces the
> > overhead of monitoring at a fixed granularity of the page size.
>
> Based on my understanding of this patch sereis that I was enlightened fro=
m the
> conversation with you on the RFC v1 and kind comments from perf community=
, I
> agree to the points of this patch series.  Extending DAMON with h/w featu=
res
> like AMD IBS and Intel PEBS is what multiple people shown interests.  I b=
elieve
> it can benefit multiple users.
>
> I hope this work to be continued until it is landed on the mainline, and =
I will
> be happy to help.  Probably not exactly in the current shape, though.  I =
think
> this is still in an early stage.  And for the reason, I will comment on o=
nly
> high level things here, rather than diving deep into each patch.

Thank you for your helpful comments.
I will continue to work on this project.

> > Furthermore, this patch series also includes a feature that allows you
> > to set a minimum region size for each target, enabling you to monitor
> > at any fixed size greater than the page size for each target.
>
> I'm not very sure if this is really required to be a part of this series.=
  Can
> you further share more details about what is the benefit of this feeature=
, and
> if it should be coupled with this patch series?  It would be great if you=
 can
> share some test results proving the arguments.
>
> If this is really beneficial but there is no reason to couple with this s=
eries,
> I think merging this separately first or later could also be an option.

Indeed, this patch can be submitted separately.

The purpose of access monitoring with a fixed granularity greater than
the page size is to reduce overhead when the total size of the memory
region being tracked is large.

Also, we want to be able to track hugepage sizes for some targets, so a min=
imum
region size setting is provided for each target.
For example, when memcached is started with the --enable-largepages option,
it will attempt to use THP.

> >
> > Using these features also requires modifications to damo, but these are
> > not included in this patch series and are currently under development i=
n
> > the following branch:
> >
> > * https://github.com/mita/damo/tree/damo-perf-for-v3.1.8
>
> Sounds good.  No rush, but also feel free to send patches or PRs for this=
.  It
> is common to support DAMON features on DAMON user-space tool even before =
the
> DAMON features are merged into the mainline.
>
> >
> > Any feedback or advice on the patch set would be greatly appreciated.
> >
> > * v2
>
> Let's keep using "RFC" here.

OK.

> > - reintroduce damon_operations->cleanup()
> > - introduce struct damon_access_report
> > - use struct damon_access_report instead of introducing struct
> >   damon_perf_record
>
> Thank you for doing this.  I hope using not only the struct but the under=
lying
> infrastructure, though.  Let me comment this more detail below.
>
> > - remove maximum region size setting
> >
> > * v1
>
> Ditto.  Let's keep using "RFC".
>
> > - https://lore.kernel.org/damon/20260123021014.26915-1-akinobu.mita@gma=
il.com/T/
>
> Thank you for sharing the link.  This is helpful for me at reviewing.
>
> >
> > * TODO
> > - Currently, it is possible to unintentionally specify a perf_event
> >   that cannot obtain either PERF_SAMPLE_ADDR or PERF_SAMPLE_PHYS_ADDR
> > - Check if it works in a virtual environment using vPMU
>
> The above two TODOs make sense to me.
>
> I'd like to request below things as main TODOs.
>
> First, I hope the benefit of this change is described in more detail.  Th=
e
> current description mentions it is more lightweight since it doesn't need=
 to
> update the accessed bit.  But, PMU-based monitoring should also have its =
own
> additional work.  It would be nice if you can describe what additional wo=
rks
> for PMU-based monitoring induce, and why it is generally lower than that =
of
> access bit modification.
>
> Having a more clear motivation, or expected use case would be nice.  You =
don't
> neeed to share real details of your use case.  You can anonymize sensitiv=
e
> things if needed.  But giving a reasonable and realistic use case will be=
 nice
> to understand where this can really be beneficial.
>
> Sharing a test results showing the benefit will also be very nice.  It do=
esn't
> need to be huge real world test, but some reasonable amount of data that
> collected on a realistic test setup could be very helpful.

All of the TODOs you suggested are useful.  I will try to share the test
results and comparisons with access bit based cases.

> Second, I hope this patch series to reuse the DAMON primitives extension
> infrastructure if possible, to reduce possible future duplications.  I'll=
 add
> more details about this below.
>
> >
> > Akinobu Mita (6):
> >   mm/damon: reintroduce damon_operations->cleanup()
>
> Thank you for doing this :)
>
> >   mm/damon/core: introduce struct damon_access_report
>
> Again, thank you for doing this.  I understand this is an answer to my pr=
evious
> question to the RFC v1 of this series.  I was asking if you considered th=
e
> infrastructure part of my page faults based DAMON extension series, and y=
ou
> borrowed the main data structure of the series here.  But, I hope us to r=
euse
> more of the code, since it is more generic from my point of view.

The plan was to start by reusing structures and gradually make use of
infrastructure.  Now, I have a better understanding of your DAMON
extension series
and have no major concerns about migrating to it.

> >   mm/damon/core: add common code for perf event based access check
>
> This patch is introducing a few of sysfs files under DAMON sysfs context
> directory, namely 'perf_events/' and its underlying files.  The files is =
for
> registering perf events for the access monitoring.  I don't dislike the b=
asic
> concept, but concerned if it is too specific for only perf events and the=
refore
> cannot be easily extended in future.
>
> The faults-based DAMON extension patch series [1] implements files for si=
milar
> but more general concept.  It defines a concept called sampling primitive=
s.  It
> is the low level primitives for access check.  It could be access bit che=
cking,
> page fault event, or something new, like perf events.  It adds
> monitoring_attrs/sample/primitives/ sysfs directory, which can be used fo=
r
> selecting what primitives the user wants to use.  I think perf events can=
 be
> defined as another access check primitive, and the sysfs files can be add=
ed
> under here.

I agree.

> I was also bit concerned at the fact that the filees are effectively expo=
sing
> perf_event_attr struct.  That is, I was concerning about stability of the
> struct.  I now see it is a part of linux user api, so I assume it is a st=
able
> api.  Could you please confirm this?  Also, adding more clarification abo=
ut
> that fact on the patch would be nice.

Since `perf_event_attr` itself is an argument to the `perf_event_open()` sy=
stem
call, I think future compatibility will be maintained, but I also have some
concerns about whether the interface provided by this patch is optimal.

Also, as mentioned in the TODO section, there are currently almost no
restrictions on the PMUs that can be specified, so it is possible to regist=
er
PMUs that are completely useless for perf event-based access checks.
I have one idea under consideration, and I plan to address it when I send o=
ut
the next patch series.

> >   mm/damon/vaddr: support perf event based access check
> >   mm/damon/paddr: support perf event based access check
>
> My understanding of the above two patches is like below.
>
> 1. The perf event samples are added to a circular buffer whenever it is
>    generated.
> 2. At the end of each sampling interval, the ops reads each sample in the
>    buffer, find a matching DAMON region for the sample, and updte the
>    'nr_accesses' of the region.
>
> For this, this patch series implements the circular buffer for storing sa=
mples,
> and xarrays for finding the matching DAMON region for a given sample.
>
> The page fault based DAMON extension patch series is doing something simi=
lar.
> The first patch of the series implements the buffer for storing access sa=
mples.
> I think the perf event samples can be stored here.
>
> The seventh patch of the series implements the logic for finding the matc=
hing
> DAMON region for each of the samples in the samples buffer, and update th=
e
> 'nr_accesses' of the DAMON region.
>
> Because the page fault based extension's infrastructure is quite general =
for
> any future types of the primitives, I think it would be nice to reuse it.
>
> The infrastructure is quite simple and not optimized for performance.  Bu=
t
> optimizations can be made later.  I'm more interested in the long term
> maintenance of the interface.  And I think the page fault based extension=
's
> infrastructure is easier for long term maintenance.  Of course I might be
> biased.  Please let me know what you think.
>
> If it helps and if you don't mind, maybe I can try to implement this seri=
es on
> the page fault based infrastructure and share it as another RFC patch ser=
ies.

I'm starting to get a vision of how to incorporate this as sampling primiti=
ves,
but if you try implementing it and share your results, it would be extremel=
y
helpful.

> >   mm/damon: allow user to set min size of region
>
> As I mentioned abovely, I'm not sure if this is really need to be coupled=
 with
> this entire series.

I'm happy with this patch, as it's much simpler than the last one for RFC v=
1.
Next time, I'll send them separately.

> >  .../ABI/testing/sysfs-kernel-mm-damon         |  10 +
> >  include/linux/damon.h                         |  63 ++
> >  mm/damon/core.c                               |  77 ++-
> >  mm/damon/ops-common.h                         |  39 ++
> >  mm/damon/paddr.c                              | 105 ++-
> >  mm/damon/sysfs-common.c                       |  11 +
> >  mm/damon/sysfs-common.h                       |   1 +
> >  mm/damon/sysfs.c                              | 399 ++++++++++-
> >  mm/damon/tests/sysfs-kunit.h                  |   2 +
> >  mm/damon/tests/vaddr-kunit.h                  |   5 +-
> >  mm/damon/vaddr.c                              | 654 +++++++++++++++++-
> >  11 files changed, 1332 insertions(+), 34 deletions(-)
> >
> > --
> > 2.43.0
>
> [1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org/
>
>
> Thanks,
> SJ
