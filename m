Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A7C8CE
	for <damon@lists.linux.dev>; Tue, 26 May 2026 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779753920; cv=pass; b=dG4WIIsgcGvqHscBmiA+jaXzjqouevWTJ7gTtk90OYbZMezUwNiJYoWM9df4nCQfiE/YhgVCNquAc/x42NxnMgrCjU/KtHKQ0j62Yzous/oAxfcGooSOYPZqwsXI9xPb5ye5ucIuCSHvEOaGMZNxojcQsUfVbqDjFmEblj6jpa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779753920; c=relaxed/simple;
	bh=kWv7HLOBUzZVc47EwDAKstRNfMdk3HO2cKdu4jwKeN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/keTbSmyp/FnqpGFpRD3218ftrUNwQaUEHosrFniJAoALweCoJGno4HRVA7AI9MUq21jFfRzDwiErb8aI5VqJt3mEuaVuozfR41i/TpUMBMfm6Brs5r5gjYS6XoZaIh+Ot8tyFSzwkKZ2STYEXqn7h45G+F9JJ241WvLWwtHHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9O42mBc; arc=pass smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9O42mBc"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1331e851faaso5153276c88.1
        for <damon@lists.linux.dev>; Mon, 25 May 2026 17:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779753918; cv=none;
        d=google.com; s=arc-20240605;
        b=TWrM7HjWHH803rW6O6YnI9Pi8zkjb9+NNf8cvqNbTrPQeNGjNNwAa6snwcnBV9/Gws
         m2sUOVzcPsuxbaB7rnNzYomlwJYULyLbPQ736P6+uJVYTxCrwxAnjFGqszsBEHlGIPgR
         JrIIvInxBfcH4nwdu/DCOPzW5XkbAa9JAjfR4AdmyIXQAAidGhAUfqF9BBFY+Fu3s21E
         j+TI0Hlo5WSQnjfgkQ8tB9DRy7fpxv15MrmAQUlr58KSqOx0gasS9h0T1njh7/odAUfu
         3tB1QJlQCl8j97zkUomesiv2BP2ijPzLi3O7e7QUhD7Lic7T88ww6j2Wpsgsb/hkmRx6
         qHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NincQHHUkFRFpZCpbw98WAPBg+k0sO/KWp+Cuwbg5yQ=;
        fh=X9IF+1SwMo5Fo+JBPAl/l8mdKheMMVN0o4mKRDZM57o=;
        b=eSS7ItXlFEY7mNwS5BmmB/mjYJfp9hEGXnrnOCZ06vmClT5FE8qNbvNlXotVhTrQ9+
         vepaRzQTR+YsKMu41MSgytz3xeq4cb1cGxxWgU9lj5ybwCC6Lh66/U6RHNnGDU7jbQ8d
         28Sb7jZ7GUisMtvPwRmDQ09Z2gFfzqIDIql6R5KMLYuW8lfN489Jf05ayjKnTKVi027M
         FZTANmjjbw0obY5zdGCiVmMjpwIMhsj2vEri7qHp95AB6JiRycdggWtEnwLVIpnNKIol
         0Hq9xva970InIINv18hGKywLDO2bfqKx81bVWf2hQIsXCXXOwgAsbv/k6UzyrYrwyyM8
         4WNw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779753918; x=1780358718; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NincQHHUkFRFpZCpbw98WAPBg+k0sO/KWp+Cuwbg5yQ=;
        b=R9O42mBcEOrPo1JcuPoLRreJLawAs6TlKG7Xe22yHxFXwJKrRwpVYM6PPjsIEiU5pl
         hfFWMwgp0sG9FTp2bugWqXykhJ7D6jU59yRwqflhj9JAwam/nk6wcJdf4vC3akrYOHzv
         7AxPaFdAbD0yp3lBbFKlF04pW6tZk6CDZS2bmuN0/B22IHTcG92WWBc3xfprw8wJdQPz
         ZUyjgpwUyPeJlijP1/bLeRcYtpU4g29SO+saYVV68dRGFamTJRqv7elleHrO2IiAeZUX
         7cJzuyJmzwlTp8KDTIYboyxvrYYEFHcpXbTbfJlxuhQjRhjF9wbEkVXJyHCrAgb0JVKj
         YlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779753918; x=1780358718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NincQHHUkFRFpZCpbw98WAPBg+k0sO/KWp+Cuwbg5yQ=;
        b=ZqgOVyTLvS7XrU7M6jo9Bc0maiRsFfmBdiWtD6xISEiddDjB4cc7WUqzTXrVAe5ke7
         50Yp0gj13WSdXQFOs9Sc3WPleFMsDUoQ5ipbXh3uamuZyUwwxZvpAihwHsguTGS+BDso
         9jaSb7p7n3f6Rw7Xvlfd9D7UAu5ulVNx3Spf+afROiaLKRTcs04zsDVBLE1p/6LhbyDS
         BAiqhBR1Suyf2wRG07tLndKDlKpm5sqmZlzavwc4uq/8TS4N+sJSaE95NHRYDPt3nPA0
         fh/9ZbuYOAyQK/9ZSi5tG8dl3uqB3/R6lJ5jaRud3qKj56j19WdGuDwFcZDZNOHT4lJ/
         meiw==
X-Gm-Message-State: AOJu0Yy3bdZ8GxFJtd3OdhI0MZHaOj1zx0BKRV2bwP3tUBFJ2a1+LUTW
	wMjfWr9FiMlxt/dyuvX8ramzve/EWtO2/hNI+rj8ymtAtQ7bmphMF9KIeiMT7wa6w6keEiaTGDg
	1qPCdWWSPJ67oNltvHqgxtc+u4256pQ==
X-Gm-Gg: Acq92OHpXcMyOOiedtG8psUtbMJ5yk+mRjmrmtSN2+dZ4dUv4IqZwbtaRzAKktVgv/J
	nZerRAEPgZsgGlKPdgRBDitg6bW/sswZYLNxC3TD0+fF9jt31lrck4kd7DuZtijOTV1eaZZwPBi
	Nir/1YgEwZ5SbA5HXadqEsfRw+oTgRVbba5eQejjpXYrcBTW86RoQLsFplApqo1AG5n1816nJNM
	dT4Hymhx+kgRnp9IyZ4/tV6YEPkmqBrum6KvOqxUwr2TER1m9qXsg8QAh+G07YE0A5cD9ZM+Xr7
	3C8Vquo=
X-Received: by 2002:a05:7022:610:b0:136:c2fa:32d6 with SMTP id
 a92af1059eb24-136c2fa37e7mr2419192c88.7.1779753917284; Mon, 25 May 2026
 17:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALa+Y15fsgb1SU1xBq6BHsgk9QSJr39L5CZSCahpRu7udGuwKw@mail.gmail.com>
 <20260521003247.84337-1-sj@kernel.org>
In-Reply-To: <20260521003247.84337-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Mon, 25 May 2026 17:05:06 -0700
X-Gm-Features: AVHnY4JrstSX8sPAVPbrXAIWWUvcSJkyLCkHpYdCefAqgqndyn1dXmWz0xR_I-A
Message-ID: <CALa+Y167W9Cs0zFh6rnbDgk91cMvtofSxuAu_-M3dWwiSkbTKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] mm/damon: hardware-sampled access reports + AMD
 IBS Op example
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com, bharata@amd.com, Akinobu Mita <akinobu.mita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 5:32=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Wed, 20 May 2026 12:01:43 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > On Mon, May 18, 2026 at 11:19=E2=80=AFPM SeongJae Park <sj@kernel.org> =
wrote:
> > >
> > > + Akinobu
> > >
> > > Hello Ravi,
> > >
> > > On Sat, 16 May 2026 15:34:25 -0700 Ravi Jonnalagadda <ravis.opensrc@g=
mail.com> wrote:
> > >
> > > > Hi all,
> > > >
> > > > This is an RFC, not for merge.  The series exercises and validates
> > > > damon_report_access() -- the consumer API SeongJae introduced in [1=
]
> > > > -- as a substrate for ingesting access reports from hardware-sampli=
ng
> > > > sources.  The series includes one worked-example backend, an AMD IB=
S
> > > > Op module (damon_ibs.ko), that runs on Zen 3+ silicon via the
> > > > existing perf event subsystem.
> > >
> > > Thank you for sharing this great RFC series!
> > >
> > > [...]
> > > > Why a hardware-source primitive complements existing primitives
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [...]
> > > > Both primitives produce a view of hotness that converges to the
> > > > true distribution over the aggregation interval.  For systems where
> > > > the address space is small relative to the aggregation rate, this i=
s
> > > > the right tool.  On large heterogeneous-memory systems with goal-
> > > > driven schemes asking the closed-loop tuner to converge on a target
> > > > distribution, a complementary lower-latency view of accesses can
> > > > tighten the loop -- reducing the time DAMON's nr_accesses takes to
> > > > reflect the workload's actual access distribution, which in turn
> > > > reduces ramp duration and oscillation amplitude during convergence
> > > > of goal-driven schemes.
> > > >
> > > > A hardware-sampling primitive provides this complementary view:
> > > > hardware retirement records each access at its natural event rate,
> > > > with a physical address per sample, independent of TLB state and
> > > > independent of the unmap/fault path.
> > >
> > > Yes, I fully agree.  Different multiple access check primitives have =
different
> > > characteristics.
> > >
> > > [...]
> > >
> > > > Demonstration
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [...]
> > > > In both regimes, convergence to target is quick, and the workload's
> > > > measured DRAM share then holds within 1.3 percentage points of
> > > > target with standard deviation under 1.3 percentage points, sustain=
ed
> > > > over runs of 15-30 minutes per target.
> > >
> > > I understand this demonstration shows your AMD IBS-based version of D=
AMON is
> > > functioning as expected.  Thank you for sharing this!
> > >
> > > [...]
> > > > What's in this series
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > >   Patch 1.  mm/damon/core: refcount ops owner module to prevent
> > > >             rmmod UAF
> > > >   Patch 2.  mm/damon/paddr: export damon_pa_* ops for IBS module
> > > >   Patch 3.  mm/damon/core: replace mutex-protected report buffer
> > > >             with per-CPU lockless ring
> > > >   Patch 4.  mm/damon/core: flat-array snapshot + bsearch in ring-
> > > >             drain loop
> > > >   Patch 5.  mm/damon: add sysfs binding and dispatch hookup for
> > > >             paddr_ibs operations
> > > >   Patch 6.  mm/damon/core: accept paddr_ibs in node_eligible_mem_bp
> > > >             ops check
> > > >   Patch 7.  mm/damon/damon_ibs: add AMD IBS-based access sampling
> > > >             backend
> > > >
> > > > Patches 1, 3, and 4 are general infrastructure that benefits any
> > > > consumer of damon_report_access().  Patches 2, 5, 6, and 7 are the
> > > > worked-example backend (paddr_ibs ops, sysfs binding, IBS module).
> > >
> > > I didn't read the detailed code of each patch.  But my high level und=
erstanding
> > > is as below.
> > >
> > > Patches 1 and 2 are needed for supporting loadable module-based DAMON=
 operation
> > > sets (access sampling backend).
> > >
> > > Patch 3 is needed for supporting access check primitives that can pro=
vide the
> > > access information in only nmi context.  It can also speedup the acce=
ss
> > > reporting in general, though.
> > >
> > > Patch 4 makes DAMON's internal reported access information retrieval =
faster, so
> > > will help any reporting-based DAMON operation set use case.
> > >
> > > Patches 5-7 are required for only the IBS-based DAMON operations set
> > > (paddr_ibs).
> > >
> > > So I agree patch 4 is a general infrastructure improvement that benef=
its
> > > multiple use cases.
> > >
> > > Patch 3 is also arguably general infrastructure improvement, as it wi=
ll make
> > > the reporting faster in general.
> > >
> > > Patch 1 is not technically coupled with paddr_ibs, and will be needed=
 for
> > > general loadable module based access check primitives.  But, should w=
e support
> > > lodable modules?  If so, why?
> > >
> > > Patch 2 is also not technically coupled with paddr_ibs, to my underst=
anding, so
> > > should be categorized together with patch 1?  In other words, if we a=
gree we
> > > should support lodable modules based DAMON operation sets, this shoul=
d be
> > > useful for not only paddr_ibs but more general cases.
> > >
> > > Correct me if I'm wrong.
> > >
> > > >
> > > >
> > > > Patches worth folding into damon/next
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Patches 1, 3, and 4 are not specific to IBS or to this RFC's
> > > > backend.  Each is preparatory infrastructure that any consumer of
> > > > damon_report_access() will need:
> > > >
> > > >   - Patch 1 (refcount ops owner) -- any modular ops set, including
> > > >     out-of-tree backends, needs clean module unload to avoid UAF
> > > >     on damon_unregister_ops.
> > > >   - Patch 3 (per-CPU lockless ring) -- damon_report_access() cannot
> > > >     be called from NMI context with the current mutex-protected
> > > >     buffer.  Hardware samplers all need NMI-safe submission.
> > > >   - Patch 4 (flat-array snapshot + bsearch drain) -- the linear-
> > > >     scan drain is O(reports x regions) and exceeds the sample
> > > >     interval at high-CPU x large-region products.  Bsearch brings
> > > >     it to O(reports x log regions).
> > > >
> > > > If these belong directly on damon/next as preparatory patches for
> > > > damon_report_access() rather than living inside an IBS-specific
> > > > track, we are happy to rebase and resend them that way.
> > >
> > > So I'm bit unsure about patch 1.  If we don't have a plan to support =
lodable
> > > modules based DAMON operations set, we might not need it for now.
> > >
> > > For patches 3 and 4, I agree those will be useful in general.  Noneth=
eless, I'd
> > > slightly prefer to do that optimizations at the later part of the lon=
g term
> > > project.
> > >
> > > >
> > > >
> > > > Relation to prior and ongoing work
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > The IBS sampling pattern in patch 7 -- attr.config=3D0 to use IBS O=
p
> > > > default config, dc_phy_addr_valid filter, NMI-safe sample submissio=
n
> > > > -- is derived from concepts in Bharata B Rao's pghot RFC v5 [3].
> > > > The attribution header is in mm/damon/damon_ibs.c and the patch
> > > > carries a Suggested-by: trailer.
> > > >
> > > > Bharata's pghot v7 [4] introduces a different IBS driver targeting
> > > > the new IBS Memory Profiler (IBS-MProf) facility, which Bharata
> > > > describes as a facility "that will be present in future AMD
> > > > processors" -- a separate IBS instance from the one this RFC's
> > > > backend uses. This version of driver based out of v5 [3] is an
> > > > example of how DAMON can be benefited from AMD IBS Hardware
> > > > source and validates importance of IBS information indepedently.
> > > > It is not meant to be merged in the current form.
> > > > @Bharata if you see a path where IBS samples can be consumed
> > > > by DAMON at some point, will be happy to collaborate.
> > > >
> > > > Akinobu Mita's perf-event-based access-check RFC [5] explores a
> > > > configurable perf-event-driven access source for DAMON.  IBS has
> > > > vendor-specific MSR setup beyond what perf_event_attr alone
> > > > expresses (e.g. dc_phy_addr_valid filtering on the produced sample,
> > > > not on the perf attr), so the IBS path here appears complementary
> > > > to [5] -- operators choose based on whether their hardware sampler
> > > > fits stock perf or needs additional kernel-side setup.
> > >
> > > So apparently there are multiple approaches to develop and use h/w-ba=
sed access
> > > monitoring.  Akinobu and you are trying to do that using DAMON as the=
 frontend,
> > > and already made the working prototypes.  There were more people who =
showed
> > > interest and will to contribute to this project other than you, too. =
 I 100%
> > > agree h/w-based access monitoring can be useful, and I of course thin=
king using
> > > DAMON as the fronend is the right approach.  I'm all for making this
> > > upstreamed.
> > >
> > > I was therefore spending time on thinking about in what long-term mai=
ntainable
> > > shape this capability can successfully be upstreamed.  I suggested
> > > damon_report_access() as the internal interface between DAMON and the=
 h/w-based
> > > access check primitives, and apparently we all (I, Ravi and Akinobu i=
n this
> > > context) agreed.  Akinobu thankfully revisioned his implementation ba=
sed on
> > > damon_report_access() interface.  Ravi also implemented this RFC base=
d on the
> > > interface.
> > >
> > > After making the consensus with Akinobu, I was taking time on the use=
r space
> > > interface.  When I was discussing with Akinobu, my idea was extending=
 the user
> > > interface for the page faults based monitoring v3 [1].  But, recently=
 I decided
> > > to make this more general, so proposed data attributes monitoring ext=
ension [2]
> > > at LSFMMBPF.  The patch series for the initial change [3] is merged i=
nto mm-new
> > > for more testing, today.  The cover letter of the patch series is als=
o sharing
> > > how it will be extended for h/w based access monitoring in long term.
> > >
> > > I of course want us to go in this direction.  I believe you already h=
ad chances
> > > to take a look on the long term plan and didn't make some voice becau=
se you
> > > don't strongly disagree about the plan.  If not, please make a voice.
> > >
> > Hi SJ,
> >
> > One layering question I'd like to flag before the plan is written,
> > since it affects how this RFC's substrate slots in:
>
> To my understanding, this RFC reuses the damon_report_access() infrastruc=
ture
> that shared with the per-CPUs/threds/writes/reads monitoring series [1]. =
 My
> plan at the moment is to keep using it.  So from high level view, I think=
 the
> final picture would be not really different from this RFC.
>

Hi SJ,

   Sorry for the delayed reply. Was away for a couple of days.
This resolves the layering question for me.

> >
> >   In [3], .apply_probes is a periodic per-region classifier driven
> >   from kdamond_fn after .check_accesses, in process context, that
> >   applies a (folio -> bool) predicate to each region's sampling_addr
> >   and accounts the results in r->probe_hits[].  damon_report_access()
> >   on the other hand is a per-event delivery callback into a per-CPU
> >   buffer, called from the access source (NMI for IBS / PEBS / SPE,
> >   process context for page-fault-based sources).  These appear to
> >   me to sit at different layers - delivery vs. classification.
> >
> >   The reason I want to confirm this: NMI context for HW samplers
> >   precludes the operations .apply_probes can do today (no mutex, no
> >   kmalloc, no sleep, no folio lookup that touches pte_lock).  And
> >   the data shape is inverted - .apply_probes asks "does region R's
> >   sampling_addr have attribute A?", evaluated on the kdamond-chosen
> >   address; an HW sample announces "PA Y was accessed at retirement
> >   time T", arriving asynchronously and needing to find the region
> >   it falls into.  If access events end up routed through
> >   .apply_probes in the long-term plan, the IBS / PEBS / SPE
> >   backends would each need a deferral path under it (per-CPU ring
> >   for NMI-safe submission, region mapping at drain time).
>
> It will not routed through .apply_probes, but work in a way similar to th=
e
> damon_report_access() based design.  That is, each (sampled) access event=
 will
> syncronously call damon_report_access() with the access information.  The
> information is stored in DAMON's internal data structure.  The informatio=
n will
> contain the access destination address, the accessor CPU/thread, whether =
it was
> reads or writes etc, if available.
>
> Then kdamond will read the reports in the data structure once per samplin=
g
> interval and assess if each region got accessed or not since the last sam=
pling
> interval.
>
> So my plan is not to reuse .apply_probes, but in terms of who consumes th=
e
> information, it is not very different.  Accessor will produce the informa=
tion
> (report), and kdamond will consume those.  But this is how
> damon_report_access() based structure is working on, so my understanding =
is
> that your RFC is also not very different.  Am I missing something, or do =
you
> have any concern on this structure?
>
> >
> >   Happy to be wrong here if you see a unified shape that handles
> >   both - just want to surface the constraint before the plan is
> >   written.
> >
> > On the loadable-module question for patches 1 and 2: agreed it's a
> > genuinely open architectural call, not just a paddr_ibs convenience.
> >
> >   - paddr_ibs (this RFC) targets the existing IBS Op facility on
> >     Zen 3+ silicon via the perf event subsystem and uses a
> > vendor-specific
> >     overflow-handler filter that perf_event_attr cannot express
> >     (dc_phy_addr_valid in IBS_OP_DATA3).  Bharata's pghot v7
> >     [pghot-v7] introduces a separate IBS driver targeting the new
> > IBS-MProf
> >     facility on future AMD silicon via direct MSR programming -
> >     not perf at all.  These are two AMD-specific HW samplers with
> >     non-overlapping silicon coverage and non-overlapping kernel
> >     paths.  A distro shipping a single kernel image to a fleet
> >     with mixed silicon needs runtime-selectable backends, which
> >     obj=3Dy can't do across exclusive `depends on` chains.
> >   - Akinobu's perf-event RFC v3 [akinobu-v3] is a useful contrast:
> >     it stays builtin because it's a generic configurable
> >     perf_event_attr passthrough, no vendor-specific code in the
> >     overflow handler.  The tristate case is specifically for the
> >     backends that need vendor logic outside perf_event_attr
> >     (IBS dc_phy_addr_valid, future ARM SPE record-format
> >     handling, future Intel PEBS DLA quirks if they need
> >     kernel-side filtering beyond what perf delivers).
>
> I'm still not familiar with IBS and perf events.  Please bear in mind wit=
h me.
> My understanding is that there are vendor-specific knobs for IBS that per=
f
> event is not supporting.  So far, that makes sense.  And are you saying t=
hat
> you have to write paddr_ibs as a loadable module if you want to support t=
he
> vendor-specific knobs?  If I'm understanding you correctly could you furt=
her
> share why it cannot be done as a builtin module?
>

This RFC's IBS backend does not claim exclusive use of IBS.

The reason patch 7 ships as tristate is precedent and reuse: Bharata's
pghot v5 posted its IBS driver as a module, and I matched that shape
during development so the two consumers could potentially share IBS
plumbing instead of duplicating it.  Patches 1 and 2 exist to support
loadable ops modules generally.

More clarity on the right shape may emerge once Bharata comments on
the questions below.  If pghot ends up being the sole in-tree consumer
of legacy IBS Op, the loadable-ops question can be deferred to whenever
a second primitive actually needs it - patches 1 and 2 dropped, patch 7
made obj=3Dy or folded.  If both pghot and DAMON consume IBS, the
modular shape earns its keep.

Bharata - can you please weigh in on the long-term home for legacy IBS
Op (under pghot alongside IBS-MProf [pghot-v7] vs DAMON-side backend).
Related: any thoughts on the operator-facing knob to pick between
consumers when both are present?  Happy to align.

Thanks,
Ravi

> [1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org
>
>
> Thanks,
> SJ
>
> [...]
