Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07256EAE7
	for <damon@lists.linux.dev>; Sun, 21 Dec 2025 02:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766284977; cv=none; b=tQ8xxx2n1V88JAJXCRWAkKabmvW/kddye+qeL6ZctjU4PQrkWrAkkBGlOJjM25NRDuSS9Z370+2OOeSIAv/Ygm0BbO38TXFTPHh7wUyrqRYFTZZ0exzBkxd3JtynomL89soRaN+CgssR0ks9iUr6WauV3CrbJAHBOEIwM02/ZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766284977; c=relaxed/simple;
	bh=qg3rCA32P5g0yT//1rOfUN7DoNvd2Bh5kfzmxXDw1dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTxeONkbAKrA5ifAp0IFOgqDrIsrAz18G5GPFfP6xNXIy7YYHoeRz10aaY/D1lJ/lL03FFu9sYZrVnWVJdEMJOgQss1IyKdD+uyLnBlzlzM+ALxFQk7EV6pApRY5qwTPq7DPoIe/mu9KIkN72x4QXTKow5QGVEI57vqi4nWZypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX039R0v; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX039R0v"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64476c85854so2571125d50.0
        for <damon@lists.linux.dev>; Sat, 20 Dec 2025 18:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766284975; x=1766889775; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mASPxYKOqc7H+5C/K07231nqEoxZ70HYhMINN1HdRuY=;
        b=IX039R0vMiHgjgPN2vcDJg7aNwapZM1cQf1JyY4PuD8xziVanal2ldd5G5o7uIYKvO
         u+vD0cbwCsPNdPj/1MotYA6dtfNM8J9bYW3x9+ocD1cwph3rBrvJyGqwP8FTJwxf41nm
         bQWhSdoRRug1unxcIBV8GWkTuwIzu4PJaQJWCdDIjDfUFc+JHjhW+u0PGKDOfhEwQ9l/
         K8s5bPI5EzN5eolWAAktPWhICOxBpLOL23Z/BA4QEsqDr8eWm+bwG69CcomDGn8U9CR+
         B3k+VYSYcAYlhbjkqAzUU7JHWGHSVVCtZ+Q/qDtj+aXPxdIIW+zMYli1fMenC/Vwew1B
         SnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766284975; x=1766889775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mASPxYKOqc7H+5C/K07231nqEoxZ70HYhMINN1HdRuY=;
        b=WrRnLU00wW8QwEryfXYWRDRWtz4XkXH+R4tRQP1EohIMH8/2TgSqZSEluy9Qh+2Dm4
         O7BSXxDbtd9wIxqiH5afrkdDSGjgBrh1ErJ3lmFVn4ADhuSWqNVOcdIA0NdKJxyL/Chu
         nbOn2JLdOqbKlPZp5tfQIY2pse3Lkbpihf0TTGBAdiW0L3vhOA56GDxEO6rB4pp7S0VG
         Vkk7bn4Vv8ulLWSAm9IxvjtEppTZmZcIRVY7fcxAbPOpf7sZkRrKx7676C48QEmtkXXH
         r2nQg30lvN0ZBzAHHneBt6oLCQQ3DVJlW/N/YKh6XEql5Yo59gYqA00SYwH195pAJQtz
         BKOg==
X-Forwarded-Encrypted: i=1; AJvYcCWUCAmavj3z2yJFuKByfTifrNe/Wl2SD5WXybSW0nH5i1nF5t5nUB1nmM35DpD7UXY2oLYX5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPNZTxF3e7Ym+0cie8NGZUoEBLY9bJ97u5Vyjrzvy/+8xeS6X3
	4//9H/tXf4UXcTAUGHWezvYE1mNXONifbzK69ScTg2kmDEvWQC3VuR2DZWbkB99nbl1lXA/v9dl
	5VtLlPbh58UPSKuxG31W9+3ZmbRfAfdI=
X-Gm-Gg: AY/fxX4OfKsBip2SuQXEGtsaUd94nZMus556gL1AV2zzvaIVSRhdGWkFxHV/5PjcqZd
	zwV8DQz1bJv4x/IMF3/D7sn6iyDHLU5aauOYFNXtk9spYNqNt1XeHWBPyxNUJ+BICIJitxFhra+
	H2BJf+lK3GnrdpLGRMMrRo/cErkMV3QA9voyEXVC/Tt56XAV4TwVgWLlR3F2KMMv2xjxqRNRDEw
	qSizYS15/orCom+ZeBx7EDNll+1KkaOnr5gEXYCfEJIv27yscUwhAms8FGNxeCaHTpxsaVm
X-Google-Smtp-Source: AGHT+IH+6jj8oWEsdcBAceDbVJFPTAVOMQ1Uqc7/7BwQVG/cqzh4mZc/wn2oR9YZg5gDrUw36Mpl7rId7/1IGwr++Mw=
X-Received: by 2002:a05:690c:c1b:b0:78c:3076:ddb1 with SMTP id
 00721157ae682-78fb4096c72mr127542157b3.55.1766284974757; Sat, 20 Dec 2025
 18:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2c8dd0de-e650-4a74-b1f7-61ed81c03d26@kylinos.cn> <20251219114633.41156-1-sj@kernel.org>
In-Reply-To: <20251219114633.41156-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sun, 21 Dec 2025 11:42:43 +0900
X-Gm-Features: AQt7F2qA0QBKJ-NgNQCsAIsclgVskRlqTk5U6Nx24EGndjvZ_2ncyEAWOkPiAw8
Message-ID: <CAHOvCC7=t0iHEC-BQPZcF+KiKcc2tVyxNOLMifZQ=JwH2GwFpw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
To: SeongJae Park <sj@kernel.org>
Cc: Enze Li <lienze@kylinos.cn>, akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, enze.li@gmx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Dec 2025 at 21:52, SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 18 Dec 2025 21:46:37 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
> > On 2025/12/16 07:16, SeongJae Park wrote:
> > > Hello Enze,
> > >
> > > On Mon, 15 Dec 2025 22:20:55 +0800 Enze Li <lienze@kylinos.cn> wrote:
> > >
> > >> This patchset makes DAMON's advanced memory management accessible to=
 a
> > >> broader range of users through two complementary enhancements.  Firs=
t,
> > >> it exports the necessary DAMON core symbols to enable building loada=
ble
> > >> kernel modules.  Building on this foundation, it then introduces the
> > >> 'prdm' module, which extends the concept from the DAMON sample code
> > >> (prcl.c) into a production-ready, user-friendly tool.
> > >>
> > >> The key strength of this module is its out-of-the-box simplicity: by
> > >> simply specifying the PIDs of target processes and enabling the modu=
le,
> > >> users can concurrently monitor memory access patterns across multipl=
e
> > >> processes and trigger proactive reclamation automatically.  This
> > >> significantly lowers the barrier to using DAMON, allowing system
> > >> administrators and regular users without deep kernel expertise to ea=
sily
> > >> apply sophisticated memory optimization.
> > >
> > > I agree your points about the problems and the direction for improvin=
g the
> > > situation.
> >
> > Thank you, SJ!  Glad we are on the same page. :)
> >
> > > However, we have a module for such use case, namely DAMON_RECLAIM.
> > > It was designed for a reason that very same to what you described abo=
ve.  One
> > > key difference between DAMON_RECLAIM and prdm is, to my understanding=
,
> > > DAMON_RECLAIM works for the physical address space, while prdm works =
for
> > > virtual address spaces.
> >
> > Yes, I have studied the implementation and architecture of this module
> > quite thoroughly.  However, there are certain limitations when
> > considering it for production use.
>
> To my understanding, DAMON_RECLAIM is being used in multiple real world
> products.  I understand you are saying there could be limitations for som=
e
> different production uses, and I agree.
>
> > To my knowledge, few would perform
> > indiscriminate page reclamation across the entire system.  In most
> > practical scenarios, people prefer to protect critical processes from
> > being swapped out, while applying page migration and reclamation only t=
o
> > less critical or performance-insensitive processes.
>
> Thank you for kindly explaining above.  I agree such protection of critic=
al
> processes could be useful and required.  Nonetheless, to me, it sounds li=
ke you
> could also do such protection using DAMOS_FILTER_TYPE_MEMCG.  Actually th=
e
> feature was developed for such use cases, and I recently met some people =
who
> willing to use DAMON on their products in a way very similar to what you
> described.  I suggested them to try DAMOS_FILTER_TYPE_MEMCG.  Have you
> considered using DAMOS_FILTER_TYPE_MEMCG?
>
> >
> > As we all know, frequent page migration inevitably introduces some
> > latency to process response times.  Therefore, the ability to target
> > large, inactive memory consumers for reclamation addresses a strong,
> > genuine demand from real production environments.
> >
> > > Is the virtual address spaces proactive reclamation is
> > > what you really need?  If so, could you please further describe your =
expected
> > > or planned usage of it?
> >
> > Consider the following scenario: a host machine runs three virtual
> > machines -- Machine A, Machine B, and Machine C.  It is known that
> > Machine A handles massive traffic, while Machines B and C have
> > relatively light workloads.  When memory pressure arises, besides
> > releasing caches, the system can utilize prdm to perform precise page
> > migration targeting Machines B and C, ensuring memory usage remains
> > within a safe margin.
> >
> > The data below, collected from a test environment, demonstrates the
> > effectiveness of prdm.  After enabling prdm to monitor the two
> > lower-activity VMs (2316, 2284), I observed that the DAMON-based prdm
> > successfully migrated 5.5 GB of pages to the swap partition.
> >
> >  PID USER  PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> > 2253 qemu  20   0 11.251g 3.822g  32.7m S 4.989 12.28   0:48.75
> > qemu-system-x86
> > 2316 qemu  20   0 12.191g 1.524g  34.3m S 5.322 4.893   0:49.05
> > qemu-system-x86
> > 2284 qemu  20   0 12.092g 1.184g  32.5m S 5.987 3.803   0:48.10
> > qemu-system-x86
> >
> > root@localhost /s/m/p/parameters# free -h
> >        total        used        free      shared  buff/cache   availabl=
e
> > Mem:    31Gi        12Gi        15Gi       5.5Mi       3.2Gi        18G=
i
> > Swap:   31Gi       5.5Gi        25Gi
>
> Thank you for sharing this nice explanation use case.  I think this all m=
ake
> sense.
>
> >
> > >
> > > If the virtual address spaces proactive reclamation is really what yo=
u need, I
> > > think extending DAMON_RECLAIM for the purpose might be doable and eve=
n simpler
> > > than introducing a new module.  How about doing so?
> >
> > Before developing prdm, I had considered implementing the same
> > functionality based on DAMON_RECLAIM.  However, I gradually realized
> > this would make DAMON_RECLAIM overly complex and less
> > user-friendly=E2=80=94especially given its existing module-specific exp=
orted
> > interfaces, which could confuse users.  This approach would create
> > significant barriers to promoting wider DAMON adoption.  Consequently,
> > building upon the prcl sample became the preferred choice.
>
> I agree DAMON_RECLAIM already have no small number of parameters, and add=
ing
> more may make it look even more complex.  But, users may use only paramet=
ers
> that really need to be set for their real use case.
>
> For example, if we implement virtual address spaces mode in DAMON_RECLAIM=
, I
> think we can simply add target_pid parameter that works very same to that=
 of
> prdm.  If it is unset, DAMON_RECLAIM works in the physical address mode. =
 If it
> is set, it works in the virtual address mode.  Adding just one more param=
eter
> that doesn't break old usage doesn't seem that complex change to me, at l=
east
> in terms of the user experience.
>
> As I mentioned above, yet another example would be using
> DAMOS_FILTER_TYPE_MEMCG.  For this, we may be able to add a parameter for
> describing the memcg of critical processes.  Again, adding just one more
> parameter that doesn't affect old usages doesn't seem too complex changes=
 to
> me, at least in terms of the user experience.
>
> Meanwhile, I agree adding a new simpler module could make it easy for new
> users.  But, I concern if having two modules for DAMON-based reclamation =
will
> make users get difficulty at finding the correct one for their usage, sin=
ce
> they may now need to compare two modules.
>
> For the above reasons, I still feel extending DAMON_RECLAIM is a better
> approach in terms of user experience.
>
> I'm not saying DAMON_RECLAIM's user interface is perfect.  Especially its
> documentation may have many rooms to improve.
>
> And I'm not very sure if the virtual address spaces reclamation is somewh=
at
> need to be supported from modules rather than using DAMON sysfs interface=
 or
> DAMON user-space tool.  I implemented DAMON modules including DAMON_RECLA=
IM,
> DAMON_LRU_SORT and DAMON_STAT for users who willing to enable those alway=
s, and
> therefore want to avoid runtime controls.  That is, users can use those m=
odules
> by modifying the kernel command line options.  My expectation for DAMON m=
odules
> may not well documented.  If so, it's my bad.  I will try to recheck the
> documentation and make that more clearly documented.
>
> For virtual address spaces reclamation, however, runtime control is essen=
tial
> since you don't know the pid of the processes before the runtime.  In the=
 case,
> I think using DAMON sysfs interface or DAMON user-space tool could be a b=
etter
> approach.  Have you considered using those?
>
> >
> > >
> > > And, even more importantly, why it should be a loadable module rather=
 than a
> > > static module?  Do you have a specific use case that requires it to b=
e a
> > > loadable module?
> >
> > Yes, loadability is crucial for operational flexibility in practical
> > production environments.  Beyond some obvious advantages, I would like
> > to highlight a key scenario: system administrators can load the prdm
> > module upon detecting memory pressure and unload it immediately after
> > reclamation is complete, thereby eliminating any overhead during normal
> > operation.
>
> I agree always having prdm in kernel is an overhead.  But, I think the
> overhead is not meaningfully big.  Also, as I mentioned above, my intende=
d use
> cases of DAMON modules is for cases that willing to simply always use the
> modules.  If runtime controls are essential, I think using DAMON sysfs
> interface or DAMON user-space tool is a better choice.

I also think the current DAMON design structure is suitable for DAMON sysfs
and user-space tools.  DAMON sysfs can run multiple nr_ctxs, so I think it
would be a good idea to consolidate it into this.  As Enze mentioned, DAMON
was originally designed as a kernel loadable module, but I was curious as t=
o
why it wasn't run that way.  When executing the damon_start(**ctxs,
nr_ctxs, exclusive)
function, nr_ctxs=3D1, exclusive=3Dtrue is passed so that modules are curre=
ntly
executed only one at a time.  Therefore, there is no point in running
DAMON
as a kernel module, since you are not running multiple modules simultaneous=
ly.
I'm doing some more research into why we run modules with exclusive=3Dtrue.
One more thing I would like to add is that I think it would be less
confusing
to move lru_sort and reclaim to the samples/damon/ path.  And it would
be
a good idea to organize the core sources toward
mm/damon/modules-common.c source.

>
> Someone might argue DAMON sysfs interface is unnecessarily big compared t=
o
> prdm.  But, I have to ask again in the case.  Does the overhead really
> meaningfully big for a real world use case?
>
> > Furthermore, it supports zero-downtime updates, meaning that
> > improvements targeting prdm can be deployed via a simple module reload,
> > avoiding costly system reboots.
>
> So I'm not really convinced at needs of prdm module at the moment.  But I=
 agree
> your above point is a good example advantage of loadable modules.  Also t=
here
> were private requests to support loadable DAMON modules.  No one among th=
ose
> were for real production use case, and I understand you are also doing th=
is
> work for imaginable use cases, not your real products.  Please correct me=
 if
> I'm wrong.  But as the request is repeated, if you willing to convert exi=
sting
> DAMON modules to support loadable modules build and expose required DAMON
> functions for that, at least I wouldn't oppose.
>
> >
> > Finally, I would like to add that designing prdm with an extremely
> > simple workflow -- load the module, set the target PIDs, and enable the
> > switch -- will contribute to the promotion of DAMON, allowing a broader
> > user base to benefit from the DAMON system.
>
> That workflow is definitely much easier than directly using DAMON sysfs
> interface.  But, for the reason we have DAMON user-space tool.  Using it,=
 the
> workflow can also be as simple as prdm, like below.
>
>    # damo start $TARGET_PID --damos_action pageout --damos_access_rate 0%=
 0% --damos_age 2m max

Where can I find the damo source or documentation?

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
>
