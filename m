Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18383FF1AB
	for <damon@lists.linux.dev>; Tue, 26 May 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805779; cv=pass; b=ZxzsHcyeZB4sVXKdl1hbg82eX+Rebm+MdehDYsZqhSEmugXAyIzC42U4ffx6cbl0vVtFSoS8OcXHYB+Spl12/qX+kK50Pp+aQ10MlKX0FQU5YN9Dja1xSVpjo3fRiEu4xkASTDK8AxVa2mGUS6ucN8NcBbatAl9obmPf2bVGt0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805779; c=relaxed/simple;
	bh=hxeBxk/Pf2MKsi7Xzv7GqCPggn/5tdRzoDYceIyMOhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRqU6lkELmh4sHIBsf3qaYHP/3QgQNVX6ii4BNXZGrWMUHxWztmcCRdtirtD+p/50DSqFiK6mCUTYZfvOTXdbfgCfD6EPOCxx/AobKviG23Lo3DBD4ydb6OX/AgUMOdW2oy0JyVaMJfOIQsvTzl1BYrIrI7iHDwiS3ndpzVk/v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1x0cQtP; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1x0cQtP"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b7105dfb35so138733086d6.3
        for <damon@lists.linux.dev>; Tue, 26 May 2026 07:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805777; cv=none;
        d=google.com; s=arc-20240605;
        b=iQBbasMkfD+UqNV5jyAOsLbqlZjWSx7q8sefGiPwe0DhiO0Om4vFJmq8DnlgXfc1XO
         QeqX0JNEq+Gn602V24H7YGHx4kcNaTf5unHSnBuPxwsot3DSJCD/c0V9L403eDWmrEBx
         +z5QE6g373Tt71GQ2rvuaYfQDSREO2m6Lf6mOUZ8QB4aU7YbE6UNaynhFiS371NU6ohy
         a2Zyc9IGkEovA11YGhHgo8sS7pgN/LFz6324V48ioF6FhE7ULAA39xtxqnQGcEIAq420
         cVxwGweKqleXf1xFLjYhU5c6XLTWn9dKu61Hn5YU9JdkL7JbCDbwi5nq1JagbVFDkOEU
         yCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7/I4nRdXaOykS/aBj915UIUPQyjM7oJx9rlT3PiXiwo=;
        fh=ZQE7o5YwL6D9GsxHB1Z/QeI0fV/n51lyjX5M+zLZ3Eg=;
        b=ZE1LxUD4HzqsO/nybjT/GNvXExbr6fevBpmAYL0dbGRYHGvko7P6LzZikrvvJHG3VI
         EveTGGBRKa4aQq6R3D+R/b9JHRKphGif6RfW6qROOIzBduXJd9EZMAI4K1+uxhSuPtbX
         UAJeKmLECNGlng5A7QXaV/KRLw8pJTpX2d1sDuMeIqOO1IHE45zZcfVRSHBslOTp2E12
         ShVsTKKVQcidO+MvgCkM7BZ/GSaXFn8f1ynBjdWzZGWemyxTDzegFhukHpS7pAIP9Rnl
         jiQEii/K98K7StIfNaR5DWZ8LgjKSMhcIzgO3HvcbgraXq18bXp53XY26+AnSnAaNCxC
         /GYg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805777; x=1780410577; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/I4nRdXaOykS/aBj915UIUPQyjM7oJx9rlT3PiXiwo=;
        b=A1x0cQtPYoGJm6alYJ8UTbn5zNTzaNENroE1L2r+LniA6Jes6qQ/M/jwiyFeaVC/5f
         Drd63PKR+uHGAZWQoIt9RGLXY3rWATpda2+7XJaW3jAHExwqQ64AFe2mcucqWxMaqK3N
         7URBdBjm9JNU77Ef/lFjx+ek6tZujApO7Lt+zW8S8MKkvBDgklvE1WlAIRDzw9HpXuDi
         sTRvIFKKDGVTHT4WODw+oYJDsdECg+UJ+YCQUxMugntGn5Vi7sWe2jyjBiR5W7UOQe6P
         i2o7WQYnzUSUEbrt8KusIVXriVUp5y0ZEkbchNazay4aYhNOYCMbK7ZhVmhvlOajHJ2m
         8VQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805777; x=1780410577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/I4nRdXaOykS/aBj915UIUPQyjM7oJx9rlT3PiXiwo=;
        b=pE3aNv4+FbMZJeAZNDulE6/4SVPVzPRsV60gckgaCVZgejD9R0rfT/O9wG79CagZks
         5VbdExjB2e5ZKnKWmJnax2R+HfqNjq1hD5/uYKccEhUBVzI1WQT926Mzb3ai/Isi3BFP
         HGmjabDsmGxo8sFnON9ZNGeDufuXqc7ubXIU3fwPlQKS+bW65WvLkEeGsmsHhBe2NnNC
         eeMzD40U4cUr2znzbdp2en5aARrNSEyKXgQrK0QKENfqLVcQ5vdkzE0f9uU2Q0jcal4v
         vh7WpDgYqvaRnXd1Kuqgw+EWplGEdsc1r9ye4qIDLMugkTV9t1u7MFu855Duy7AXiXCZ
         o8Sw==
X-Gm-Message-State: AOJu0YwZ3nC1U0NMksqNAm1cEx2/t7d5zaSHGc7SKyYis/PmmhHmIPqS
	nOZtpP4KyMCF8L8KyQ+F7vKt9x2xSUd12ZdDTEMEeOvwAtUZvdN/k1po3jAo7PWTUF8MSkQryc9
	zsO5Yx9gLGRUgmCzW6Om7tkhYxAgQ4k63rvWy
X-Gm-Gg: Acq92OEge01e/dGt08xgJx4Ib1JA3UZ6aUXCTfPsZn1KHV5xCp/pEA2KgMoaCcWQriU
	I9Dt0pEFl0bZS4mQ/t6+D8zoxlOgvG0NM7GrEha5vlIDITAkbsh5CBspizaVhAoxZd+RHiXphvs
	r2VPMWevpsEECifSbYx65oJriJZl3fP5Ab0dXt/IuZxk+DK0TjuZyJFFO/ibL3SgbRJPSRK1l1f
	13zlGm6QaQtprT+dhwDxvU1obilYlnrrUpdmI7CIn/dhgbzFVQFI8LD6ify5+hJMktDm4nRj9MW
	uG03tDQUSJFwj1+KIy2/879gnPoNCIhUSa0=
X-Received: by 2002:a05:6214:212f:b0:8ca:e41:ab8 with SMTP id
 6a1803df08f44-8cc7b53d8fcmr315593276d6.7.1779805776443; Tue, 26 May 2026
 07:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260525225208.1179-1-sj@kernel.org>
In-Reply-To: <20260525225208.1179-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 26 May 2026 23:29:24 +0900
X-Gm-Features: AVHnY4L9LD1JliG3S2pZ1XdkIUyjrt7M7STrEMXrD5E_fyqXA_u6_Qhsnsrt3-U
Message-ID: <CAC5umyi=YmRw4DdghTFGXD=v52TJXD=95W9ey9Cnf_FK6SP67A@mail.gmail.com>
Subject: Re: Roadmap for extending DAMON beyond pte-accessed bit
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, Ravi Jonnalagadda <ravis.opensrc@gmail.com>, 
	Andrew Paniakin <apanyaki@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae,

2026=E5=B9=B45=E6=9C=8826=E6=97=A5(=E7=81=AB) 7:52 SeongJae Park <sj@kernel=
.org>:
>
> Hello,
>
>
> TLDR: Let's extend DAMON for data attributes monitoring, andd then furthe=
r
> extend that for multiple access check primitives including page faults, p=
erf
> memory-access events and optimized AMD IBS-like h/w feature drivers.
>
> Ongoing Projects
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> At the moment, DAMON is utilizing page table accessed bits as its major a=
ccess
> check primitive.  Because of the limitations in the primitive, interests =
in
> extending DAMON to use different access check primitives, including page =
fault
> events and h/w features such as AMD IBS, were expressed multiple times.
>
> I started working [1] on the page fault events based extension for
> per-CPUs/threads/reads/writes monitoring.  Akinobu is working [2] on perf
> events based extension for lower overhead fixed granularity monitoring.  =
Ravi
> is working [3] on AMD IBS based extension for memory tiering.
>
> Xin Hao proposed [4] extending DAMON for NUMA systems in 2022.  Pedro Dem=
archi
> Gomes proposed [5,6] extending DAMON for write-only monitoring in 2022 an=
d
> 2025.  My page faults based monitoring extension is partly for their proj=
ects.
>
> Types of Required Works
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Each work commonly requires three types of changes.  Startign from the lo=
west
> layer, the required changes are as below.
>
> Firstly, we need to extend existing DAMON operation set (paddr and vaddr)=
 or
> implement a new one for controlling the new access check primitives.  Thi=
s
> part, at least for page fault events and perf events are not overlapping =
and we
> could work in parallel.
>
> Secondly, we need DAMON core layer change for the reporting-based access =
check.
> Page table accessed bits are set by h/w and DAMON does nothing about it. =
 DAMON
> wait until h/w sets the bits, and later harvest the information by readin=
g the
> bits.  In other words, DAMON only "pulls" the information.  For page faul=
ts and
> perf events like primitives, we need to hook the access events and "push"=
 the
> information to DAMON.  For the page fault events based extension [1], I
> implemented damon_report_access() and related infrastructure for this pur=
pose.
> The implementation is quite unoptimized.  But I believe the design is goo=
d
> enough for long term maintainability.  I want us to use this framework.  =
We can
> make it works first, and later optimize.
>
> Finally, we need DAMON user interface.  For the page fault events based
> extension [1], I introduced access sampling control interface.  The idea =
is
> letting users control the access sampling in a more detailed way.   At th=
at
> time, I was thinking it is long term maintainable and Akinobu and I could=
 reuse
> it.  I still think it would work.  But, I recently got another idea.
>
> The new idea is extending DAMON for general data attributes monitoring.  =
The
> first change [7] for making it able to monitor not only data access but a=
lso
> general dasta attributes including anonymity of the pages and belonging m=
emory
> cgroup is recently merged into mm.git.  As the cover letter of the patch =
series
> is also explaining, the work has started for light-weight per-cgroup acce=
ss
> monitoring.  But, in long term, we want to make data access information a=
s just
> one of the supported data attributes.  Then, we can further extend access
> confirmation coming from different primitives as different data attribute=
s.
> For example, in addition to "PTE Accessed-bit" attribute, we can add "per=
f
> event mem-access reported" attribute and "AMD IBS access reported" attrib=
ute.
> I think this is long term maintainable and therefore want us to use this
> interface.
>
> Roadmap
> =3D=3D=3D=3D=3D=3D=3D
>
> Assuming you agree to use the data attributes monitoring interface, I sug=
gest
> us to do the work in below roadmap.
>
> Milestone 1: PTE Accessed bit as one of the data attributes
> -----------------------------------------------------------
>
> I will work on stabilizing and further extending the data attributes inte=
rface
> and internal framework to be able to support PTE Accessed bit.  This may =
take
> no small amount of efforts, but hopefully doable by the end of this year.
>
> Milestone 2: First damon_report_access()-based data attribute monitoring
> ------------------------------------------------------------------------
>
> Once the first milestone is completed, we will add the damon_report_acces=
s()
> and related infrastructure changes into the DAMON core.  On top of it, we=
 will
> further implement the first data attribute that utilizing the reporting
> infrastructure.  I personally think the perf event based one is a good ta=
rget
> at the momentt.  I think so mainly because the perf maintainers didn't sh=
ow
> special concern yet.  We can discuss the target again after the first mil=
estone
> is completed, though.  Hopefully this is doable by the LSFMMBPF 2027.
>
> The timeline is just a gut feeling.  It could be done much earlier or lat=
er.
>
> Milestone 3: Parallel extenstion for other primitives
> -----------------------------------------------------
>
> After milestone 2 is done, we have the user interface and the infrastruct=
ure.
> We will be able to further implement our favorite access check primitives=
 on
> top of it in individual schedule, without blocked by each other.
>
> Collaboration
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Milestone 1 and damon_report_access() part of milestone 2 would need to
> primarly done by myself.  If you are interested in this project, reviewin=
g the
> patches that I will post for the milestones and doing some testing would =
be
> very helpful.
>
> For the second half of milestone 2, I may need more help from Akinobu, Ra=
vi or
> someone else who may experienced with the first target primitive.  Maybe =
I
> could develop the damon_report_access() part and post it on the mailing l=
ist,
> and the other collaborator could further develop the first target primiti=
ve
> extension on top of the patches, like we did for vaddr page interleaving.
> Let's discuss the details after milestone 1, though.
>
> Request For Comments
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I would appreciate any inputs about this roadmap and plan.  I'm primarily
> curious if the plan and the timeline makes sense to Akinobu and Ravi, who=
 are
> actively working on, and might need to wait for my milestone 1.  Also if =
there
> are people who interested in this, please feel free to add your inputs pu=
blicly
> or privately, in your preferred way.

The roadmap and plan are reasonable, and I have no objections.

Ravi and I need a damon_report_access() interface that has a per-CPU buffer=
 and
can be called from the perf overflow handler for each project.
Can we expect that the infrastructure to achieve this will be implemented i=
n
Milestone 1 or 2?

Alternatively, we could start with the current simple implementation and
improve it by integrating each other's optimized implementations.

> [1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org
> [2] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.com/
> [3] https://lore.kernel.org/20260516223439.4033-1-ravis.opensrc@gmail.com
> [4] https://lore.kernel.org/linux-mm/cover.1645024354.git.xhao@linux.alib=
aba.com/
> [5] https://lore.kernel.org/lkml/20220203131237.298090-1-pedrodemargomes@=
gmail.com/
> [6] https://lore.kernel.org/damon/20250129044041.25884-1-pedrodemargomes@=
gmail.com/
> [7] https://lore.kernel.org/20260518234119.97569-1-sj@kernel.org
>
>
> Thanks,
> SJ
