Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142D2C0282
	for <damon@lists.linux.dev>; Tue, 26 May 2026 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831988; cv=pass; b=K56i6EyaFrjBA7FLrGsX3AbVleQKQuscPRsoVvGzYvXZptxYTesLUqxqOwcJGX3hoJCLYrPe2HlIWiH+Lk6pptohhEqiwLye6CG7wTrKod4Okz+GSvsCr9QdHoAPVhuhYJm6JEv+Yvc8BXjLFCjoFSlX0T3iiLwSQuZGv+JKMok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831988; c=relaxed/simple;
	bh=ddzrNwONQY+XrH+IkW+6G4yIfhc7C5OfBhJMwaTPSEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFGG1GrWMdOpjPLDnsBhULD5VxZI5z0CMSR9AyPSm0srA4J4LpVCJn5YPik0T7eoYwVquJIiBzbIQ7CkrWG29rMPtiAWk3wOWsSZowigpO1h3wwve0LQPGps8H/KW7UGpQETFOb/KnEXRhPB0pm/6s3/fer7dOekc/It+7AjQKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9/XrzHQ; arc=pass smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9/XrzHQ"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-134fe980658so12669657c88.1
        for <damon@lists.linux.dev>; Tue, 26 May 2026 14:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779831986; cv=none;
        d=google.com; s=arc-20240605;
        b=dQ0HX2AgLRb1Ljcwjab89jt+tfJEN3yBLh6F/F56lKZJYYxERe2hejTrvEl7LZ+Lmx
         xwb2dkwLCck37/tRE2fxWDtbYBqGrZDLZKBQtIe/HJZY/R6rpb382YT3Dd/Trin9EyMn
         70/o9LFaHnwYE11OTdpDLgIYB3+KpydO39VqiqStaEiywSW8un9TvYCVIcPzbldCYOqa
         hz53S1BMrLAy2CNC11qlNQp0bEGjVCfhc7AR6GYUi0Ksy5+Up+CI9uT96hgw4TNlhdoY
         VgS+acZfaJ7TX5CVOv2ocBWKkiOljwcCKAsaRdOlsDa3CF2YlF+TB91drxhNNvvBCt7K
         EuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UyF9zrno4EZ6aqrn8tRShs8dlRKXHHAr4OP+mYm1Ai0=;
        fh=9dJppuZvIgLIvlk1ld5EpoI19U+bvF29Q/J0oK4vlQI=;
        b=eNRkn1NXVyjXBO3MyBoyPQtUhz+1dmI8bCO0F54bZBFEauICix1XqgOlHlY62gYnyH
         1Np5Rh4KZqfUpBZR7li6vFHrq7AMeXa7LtlphViXPMe57GxRYzTQNQ/g1VRecn0kSWwV
         OMK/DnoLg8Jyx54yDFx0o7qEXgKKgeV8I9GhiWBg0OBTs5RdN0Kp/AELOh78mTywlyI9
         XkwkKt35/hQ0xrBjLbH8eo2eiyl0dWbrfzbQW2/CK4Zj9rpkZcS7umtFOkAvkX7xwsQ7
         X176n5ayDEusm/r4BXOmPfYcuSF1CFjbk5fWThTINGKjFi4WFwau+FAkyqISBzh6znPZ
         DdwA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779831986; x=1780436786; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyF9zrno4EZ6aqrn8tRShs8dlRKXHHAr4OP+mYm1Ai0=;
        b=H9/XrzHQkpTl/tNOeNH/PJLVqcb00ii7EesHpKxkbk97n997oyPqqzfjSlmWahii5r
         ftnm3kC2S6rgaotJKD0dM4A3+j837KyoQUMCffkUKuNLCa5XF4h4z4vAmo1T5cIEy5Fw
         QtUv7aRIgjA6ufJIhdUxojf3nE/HlQCjfXAR2qTjxyczHKuaC0Z+OTR7rY4u+/7xH9WS
         /6LoyZi7x/2kGGyF5NNAyHwhWetwBZhwu07Bne5fqfDZbJ1nHNaoiwTZoHLSqEY5gWLA
         HekXKo1g7S8O9Cz1eL6d/E94kz54MYX5OuBBOigvQj+fqnu9reSFjoyc99raM+/PYzhn
         28PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779831986; x=1780436786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UyF9zrno4EZ6aqrn8tRShs8dlRKXHHAr4OP+mYm1Ai0=;
        b=W6Dlt/1CJ+gNiDOoNDb7CwtELBZyq6BuUVAji9XqbuTuQRUyMbCqNrzMorAjEsFdVl
         TmThmzyBq63xDPzFiGAHmCfQhvP1VGi9g//U68o8tYhcpfh1bFWFaHO9XXcysIauAtGl
         bINjABolcn4xoWhbEbuesj685fnIT6vL7DNPIJzqomRgRh51GICL9qWO4h6fDIXNrl94
         LXiOeEtZLZTG7Bbk2hLWSNIcTGDjCb35Dqe3gAEqKemylqbw3/FZZdX/cxKcYlDJ406y
         o+tHtJD9921KN40uSF+oFUXga2kkHbPB/0pXYYn7Jg+CwUR16jj+Sys9tPTcd0dg7LN6
         TlpA==
X-Forwarded-Encrypted: i=1; AFNElJ/8UOjwsXpRoULU3HTt4bBuP5cGXkTvy2yt+9ca7TyuGjWrWICHybahioEY/33gJPK0tFTrxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEeolqFiMwJhUfAIX10Fuqzc+QwIzgp8MfVo1tQk3Ao2ZPfimt
	Bce3JPSy34GjQhA8j7Z5UmwNXgvTFWMyqyXT7hnqiAQaXLxLElbwbtbd8LOzMcerLNCTiirSpEl
	yCIvXwyR3sOSkSxY7C/21JqwKXxJi4Q==
X-Gm-Gg: Acq92OEHCE+TvoDILt9rdwlzgTmQ0pwD+BchonV8FAq0aD9jTK4l+4+89GoV3zzyMoh
	NCALiCFkoYu/nTpLcStVfLB9OFDxkTWrmEeRFM5sbowVKZb6D/o/1LVZ8amIHagLnR9QJUq4KEG
	0EX0Ehtec62pQbwB8HIjg6/f4TDDDRQ3WW7v/2l+XKNOuCo8UBN2CzAWK66qRQ5Jc1JcPdnRWwN
	3zf5vxRRs0Nqg5VRd+o4QvsXEjKMRkSim297tAn3SQB6MRsBzZubqRUb3J3g8Ue4s1pUNWo3GXa
	40llp2tINxGjjzAr
X-Received: by 2002:a05:7022:60c:b0:12d:b8e5:5d6 with SMTP id
 a92af1059eb24-1365fa38dfemr7447246c88.24.1779831985881; Tue, 26 May 2026
 14:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260525225208.1179-1-sj@kernel.org> <CAC5umyi=YmRw4DdghTFGXD=v52TJXD=95W9ey9Cnf_FK6SP67A@mail.gmail.com>
In-Reply-To: <CAC5umyi=YmRw4DdghTFGXD=v52TJXD=95W9ey9Cnf_FK6SP67A@mail.gmail.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Tue, 26 May 2026 14:46:14 -0700
X-Gm-Features: AVHnY4Iz9P3Hg5fJ6BYbkUcWv0crMhRoLmgf07HroQS-krrCbDFx7M3uZUf43Vk
Message-ID: <CALa+Y150x1ATN8xSJegyS=r9f8ySOFf+KuqmiDoE41vQb-Ky4g@mail.gmail.com>
Subject: Re: Roadmap for extending DAMON beyond pte-accessed bit
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev, 
	Andrew Paniakin <apanyaki@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 7:29=E2=80=AFAM Akinobu Mita <akinobu.mita@gmail.co=
m> wrote:
>
> Hi SeongJae,
>
> 2026=E5=B9=B45=E6=9C=8826=E6=97=A5(=E7=81=AB) 7:52 SeongJae Park <sj@kern=
el.org>:
> >
> > Hello,
> >
> >
> > TLDR: Let's extend DAMON for data attributes monitoring, andd then furt=
her
> > extend that for multiple access check primitives including page faults,=
 perf
> > memory-access events and optimized AMD IBS-like h/w feature drivers.
> >
> > Ongoing Projects
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > At the moment, DAMON is utilizing page table accessed bits as its major=
 access
> > check primitive.  Because of the limitations in the primitive, interest=
s in
> > extending DAMON to use different access check primitives, including pag=
e fault
> > events and h/w features such as AMD IBS, were expressed multiple times.
> >
> > I started working [1] on the page fault events based extension for
> > per-CPUs/threads/reads/writes monitoring.  Akinobu is working [2] on pe=
rf
> > events based extension for lower overhead fixed granularity monitoring.=
  Ravi
> > is working [3] on AMD IBS based extension for memory tiering.
> >
> > Xin Hao proposed [4] extending DAMON for NUMA systems in 2022.  Pedro D=
emarchi
> > Gomes proposed [5,6] extending DAMON for write-only monitoring in 2022 =
and
> > 2025.  My page faults based monitoring extension is partly for their pr=
ojects.
> >
> > Types of Required Works
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Each work commonly requires three types of changes.  Startign from the =
lowest
> > layer, the required changes are as below.
> >
> > Firstly, we need to extend existing DAMON operation set (paddr and vadd=
r) or
> > implement a new one for controlling the new access check primitives.  T=
his
> > part, at least for page fault events and perf events are not overlappin=
g and we
> > could work in parallel.
> >
> > Secondly, we need DAMON core layer change for the reporting-based acces=
s check.
> > Page table accessed bits are set by h/w and DAMON does nothing about it=
.  DAMON
> > wait until h/w sets the bits, and later harvest the information by read=
ing the
> > bits.  In other words, DAMON only "pulls" the information.  For page fa=
ults and
> > perf events like primitives, we need to hook the access events and "pus=
h" the
> > information to DAMON.  For the page fault events based extension [1], I
> > implemented damon_report_access() and related infrastructure for this p=
urpose.
> > The implementation is quite unoptimized.  But I believe the design is g=
ood
> > enough for long term maintainability.  I want us to use this framework.=
  We can
> > make it works first, and later optimize.
> >
> > Finally, we need DAMON user interface.  For the page fault events based
> > extension [1], I introduced access sampling control interface.  The ide=
a is
> > letting users control the access sampling in a more detailed way.   At =
that
> > time, I was thinking it is long term maintainable and Akinobu and I cou=
ld reuse
> > it.  I still think it would work.  But, I recently got another idea.
> >
> > The new idea is extending DAMON for general data attributes monitoring.=
  The
> > first change [7] for making it able to monitor not only data access but=
 also
> > general dasta attributes including anonymity of the pages and belonging=
 memory
> > cgroup is recently merged into mm.git.  As the cover letter of the patc=
h series
> > is also explaining, the work has started for light-weight per-cgroup ac=
cess
> > monitoring.  But, in long term, we want to make data access information=
 as just
> > one of the supported data attributes.  Then, we can further extend acce=
ss
> > confirmation coming from different primitives as different data attribu=
tes.
> > For example, in addition to "PTE Accessed-bit" attribute, we can add "p=
erf
> > event mem-access reported" attribute and "AMD IBS access reported" attr=
ibute.
> > I think this is long term maintainable and therefore want us to use thi=
s
> > interface.
> >
> > Roadmap
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > Assuming you agree to use the data attributes monitoring interface, I s=
uggest
> > us to do the work in below roadmap.
> >
> > Milestone 1: PTE Accessed bit as one of the data attributes
> > -----------------------------------------------------------
> >
> > I will work on stabilizing and further extending the data attributes in=
terface
> > and internal framework to be able to support PTE Accessed bit.  This ma=
y take
> > no small amount of efforts, but hopefully doable by the end of this yea=
r.
> >
> > Milestone 2: First damon_report_access()-based data attribute monitorin=
g
> > -----------------------------------------------------------------------=
-
> >
> > Once the first milestone is completed, we will add the damon_report_acc=
ess()
> > and related infrastructure changes into the DAMON core.  On top of it, =
we will
> > further implement the first data attribute that utilizing the reporting
> > infrastructure.  I personally think the perf event based one is a good =
target
> > at the momentt.  I think so mainly because the perf maintainers didn't =
show
> > special concern yet.  We can discuss the target again after the first m=
ilestone
> > is completed, though.  Hopefully this is doable by the LSFMMBPF 2027.
> >
> > The timeline is just a gut feeling.  It could be done much earlier or l=
ater.
> >
> > Milestone 3: Parallel extenstion for other primitives
> > -----------------------------------------------------
> >
> > After milestone 2 is done, we have the user interface and the infrastru=
cture.
> > We will be able to further implement our favorite access check primitiv=
es on
> > top of it in individual schedule, without blocked by each other.
> >
> > Collaboration
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Milestone 1 and damon_report_access() part of milestone 2 would need to
> > primarly done by myself.  If you are interested in this project, review=
ing the
> > patches that I will post for the milestones and doing some testing woul=
d be
> > very helpful.
> >
> > For the second half of milestone 2, I may need more help from Akinobu, =
Ravi or
> > someone else who may experienced with the first target primitive.  Mayb=
e I
> > could develop the damon_report_access() part and post it on the mailing=
 list,
> > and the other collaborator could further develop the first target primi=
tive
> > extension on top of the patches, like we did for vaddr page interleavin=
g.
> > Let's discuss the details after milestone 1, though.
> >
> > Request For Comments
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > I would appreciate any inputs about this roadmap and plan.  I'm primari=
ly
> > curious if the plan and the timeline makes sense to Akinobu and Ravi, w=
ho are
> > actively working on, and might need to wait for my milestone 1.  Also i=
f there
> > are people who interested in this, please feel free to add your inputs =
publicly
> > or privately, in your preferred way.
>
> The roadmap and plan are reasonable, and I have no objections.
>
> Ravi and I need a damon_report_access() interface that has a per-CPU buff=
er and
> can be called from the perf overflow handler for each project.
> Can we expect that the infrastructure to achieve this will be implemented=
 in
> Milestone 1 or 2?
>

Hi Akinobu,

The per-CPU NMI-safe ring is already on lore as patch 3/7 of the
IBS RFC I posted earlier this month:

  [RFC PATCH 3/7] mm/damon/core: replace mutex-protected report buffer
                  with per-CPU lockless ring
  https://lore.kernel.org/20260516223439.4033-4-ravis.opensrc@gmail.com

A drain-side improvement is also worth picking from the same series:

  [RFC PATCH 4/7] mm/damon/core: flat-array snapshot + bsearch
                  in ring-drain loop
  https://lore.kernel.org/20260516223439.4033-5-ravis.opensrc@gmail.com

Hopefully these are useful while you wait for milestone 1.

Best Regards,
Ravi.

> Alternatively, we could start with the current simple implementation and
> improve it by integrating each other's optimized implementations.
>
> > [1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org
> > [2] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.co=
m/
> > [3] https://lore.kernel.org/20260516223439.4033-1-ravis.opensrc@gmail.c=
om
> > [4] https://lore.kernel.org/linux-mm/cover.1645024354.git.xhao@linux.al=
ibaba.com/
> > [5] https://lore.kernel.org/lkml/20220203131237.298090-1-pedrodemargome=
s@gmail.com/
> > [6] https://lore.kernel.org/damon/20250129044041.25884-1-pedrodemargome=
s@gmail.com/
> > [7] https://lore.kernel.org/20260518234119.97569-1-sj@kernel.org
> >
> >
> > Thanks,
> > SJ
