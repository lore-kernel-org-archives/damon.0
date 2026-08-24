Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB58407590
	for <damon@lists.linux.dev>; Mon, 24 Aug 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584183; cv=pass; b=aqQkp0vV4Lj/8Al1pBVSMDNKxuRpveWqmfjiMeRmSpe2l686TaFhy84IIcxu3C8z2xumnuAZ0B8tgCSNIA+gjqb5216Iql9nOaDqwnoNuA1b1zPdSUqTZQVhY9o57/k6pPgKaQlHgsh+Rn9ADhPP3kLB1OHaRkOmtL94ykifqcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584183; c=relaxed/simple;
	bh=jV6t4K1f7KF57ErfkTlsXbCkvry3AsToveZsXjsa/0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLzbdAuZ0JahmAQ16OgPxk4TboDFZ4cCBc7zkY908f7rO5LAk0sOZN+Vwum3Dmmd5QjXvN3b2GCuMDzStxPUFDLvD0MRVmb0qpIDespEqJvVwmehA36Oa3lraFN0rlp+UsGRPfz/pdY5G37ugkZmtf3AL0r44Ni6yPJGa8fvhEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7VZkWvd; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7VZkWvd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b966dd74so16418145e9.3
        for <damon@lists.linux.dev>; Mon, 24 Aug 2026 08:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787584179; cv=none;
        d=google.com; s=arc-20260327;
        b=ob01kkejPXoP0xOwp18TtqhNoCv3rX7WLP2Nyo4Sbcl/tAjaMGqcE2Yqx0wLa4CGAy
         uPVrDd5r2Sn7y+EV97V/xXiJr5FUHOmig/91TcbwBJLdz/ZMd5RZi9JxN6B/KIWLVsjF
         9M100wx4cLPOQhSFFY3IeB2xkOEtdajgAlirnW4W1lN8yo/Z6V4tNeKvJ8isZkQUMu/z
         RevpMvjIEHqkq0jQCur1yyCKQZRGoK45nBTly8af1zlXBKg+6zb1U5q7zKXcI525+v2n
         O03+HGyPzvLh+4T92CiIVkPvs3J2BwMNE8CDfoWZW85glBw421B/nGsbytF15TtII76n
         qCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xCITwuJY/5I+fZvxebAJG0MATII2H/0d6uwBA3oASW8=;
        fh=HQugyFGOUKcIsNyU/PGfLjs9rIHSPcijYoReC4De170=;
        b=FM1aekrk0e0m9S3Pytq+qWFOzpa9Iuml+bFJOVz+Tl8Tyzu8NtqVhwSIxZ83kF6jWC
         9ZFfYsjBnBORHKPQoqNxsd1bwSN+at0W4edw9Sz/cLzc10nTsO3b3za5jpdgHXZwfv9C
         U+Z7c+wiKRq687yX6fKdddmkDr/W8H6fWOtkngEO21SRUiiNPPwteYarlzZHUVN/cbAg
         PkOXEFHUjw1CCQr9+X8r8JlTUYfSmFwqCnzPjIeKs+XdhstBSnkZka1mxuM/DmtlZAQP
         a8aPrSNgTrgsG1C4t97iqRZ2UV39XAAe3GCqWW2hg/txHNyk0yZJHS0JNL9O9hyDkWoT
         onFQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787584179; x=1788188979; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xCITwuJY/5I+fZvxebAJG0MATII2H/0d6uwBA3oASW8=;
        b=l7VZkWvd/0ogVNX3JaEymgJ9GH/hc9DrIwcTw/tWi8G7b1+Dl8ABfIVRstF1EaNAkq
         nUMo2v51+JqNx0mbfB5k8GzUYVEmd2nk7xULgfGgDxQKO6T/zs+vRaUQ8+LKnWeSx/UM
         o7peRSvDVarfSYTjh7+zC9jGV3jfN6KQMueXxkJDo7W+mlbeF7nqLPYsNc81jGddbpJg
         g86WnFPFP5vXetcxd4x3iztrgeyQ36e+zCucaiIzUlYza95b2MUbJAS8xW5ouvBVsDiX
         GDNE9zUT7SlJlC5xQgka4qfyoOZ0Na2EOAzZ0eDEeWIDcr9K3vYm7IcxXdxprrOHqWGf
         Qnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584179; x=1788188979;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xCITwuJY/5I+fZvxebAJG0MATII2H/0d6uwBA3oASW8=;
        b=SAG562gJZ2NeIEmuJAsraKJVL7oIARJSgJQX8YyMq3rLdW2xkV3QP9ZgJxg+5frH7T
         rh/LP5jg3OgdhXeeaZccRBUjGjwL+g+vvjyAPENgHacjzlj82jbf3rhneuCT+uV6XesQ
         tyeo44eVHgjEgpUle70ZAs8o3UmRoOZEIJ63f7nteoaFb7IohLDd0krZym12Ao5qydAX
         XPmsD5p+yJevs0To0pcc+DWCoBfzpeNgAolKcvwOXGf3xSprAlpggLjcmejOYQxcKeFg
         0WYFAj8o8MljcUtA0p6aNf/9CF/Q7R/EmVlJ8qfP3T3BwjUD2s2fIcxG3DQZtkDZHstj
         0ZFw==
X-Forwarded-Encrypted: i=1; AHgh+Rq86EXjFnN7BYZ4wYOuB839wFNtY4IpXukPZXjNAMT3MET0TKEajXihyedYNZV1KlcUfikriA==@lists.linux.dev
X-Gm-Message-State: AFuF++mnIPBC/gGyvgThyntuJnSjhqx2oHJyFjXYDuUmQNxCBIzGk5Un
	Kz7YxM5xBkY6FfkkA+jcmm14/SHWidffsWd3dIOY1slAfwGx+ppVF0KYBV+LqcRKxfCep8qrQVv
	7nrqAy52JKUZJfof5YBHRe4shi+yNCWE=
X-Gm-Gg: AR+sD12ZVXP1ICSWK7SLGAcNs/IzFmwoMQ0qZ/6m3ZrTG9r1aa5q6ozQT2ofs1FWnDM
	h0zG6NvYjXmYGIUcZI6jqxD+eryhcBtOCzF7XeeSjqkLQtcNz7I3GHiTb1Zh6pW0WqZ+BLXy1sR
	E67DtbKj/Fpge87N7AE0/KNF5/8xuMFvfhn8m5YxhvUQz92n8SEcwcqa4T30g6IlzEYQ27SrVzl
	10mWXKRO6azaRji8I7ujQK+DkmLk5Sp5+UJyFttvaQQpJoZwZmNDp3aBd/EzSF4WrOAZCQ85928
	NKfomijsuXEFw544rWdg3Lb1+v3mIcMtRMYGtrtdy1onMQ==
X-Received: by 2002:a05:600c:4ece:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-499c19e973fmr212050255e9.9.1787584178832; Mon, 24 Aug 2026
 08:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260529165640.820-1-ravis.opensrc@gmail.com> <20260818073546.832476-1-kunwu.chan@linux.dev>
 <CALa+Y16xODsaFZDfh7ZeP3gWbycK92gvP5N8_NFpOvW=R2BWbg@mail.gmail.com>
 <CAN_Opa_h2W1hRimy2YXPC4EgueCi2UNwnZ5gSYV=cr8M7yfCmA@mail.gmail.com> <CALa+Y15zNhpubyH5GQgu_BHesrwRdH0B8k5cqT3o_U0h5A2e-w@mail.gmail.com>
In-Reply-To: <CALa+Y15zNhpubyH5GQgu_BHesrwRdH0B8k5cqT3o_U0h5A2e-w@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 24 Aug 2026 23:09:26 +0800
X-Gm-Features: AcwNN1Un4mBIKrUBo5pV6pSoeblVjDHYRZMA2eMa4t47pkuOoxnZ-4altPzxyQc
Message-ID: <CAN_Opa_JorKoVcyhPPLOnFOOGOMCd0r4Lr-eU1e1OraRq-FAMg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, sj@kernel.org, akinobu.mita@gmail.com, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 12:32=E2=80=AFAM Ravi Jonnalagadda
<ravis.opensrc@gmail.com> wrote:
>
> On Fri, Aug 21, 2026 at 2:55=E2=80=AFAM KunWu Chan <kunwu.chan@gmail.com>=
 wrote:
> >
> > Hi Ravi,
> >
> > Thanks for the detailed reply.  The fan-in diagnosis makes perfect sens=
e.
> >
> > > Your series is based on the v1 substrate, and the way an event is
> > > configured is the part that moves most.
> > >
> > > [...]
> >
> > Glad to hear v2 is on the way.  The probe-based model is actually
> > something I encountered while building the AUX backend. When multiple
> > sources can feed the same region (e.g. PTE scanning + SPE/IBS), the
> > question of how to combine their reports becomes interesting.
> >
> > For example, CXL tiering may care about physical-address locality, whil=
e
> > per-process monitoring may need virtual-address attribution.  How do yo=
u
> > see probe weights being determined =E2=80=94 is that expected to be
> > scenario-specific, or is there a more general principle behind the
> > weighting?
>
> Hello KunWu,
>
> SJ can answer that authoritatively -- the probe and weight interface
> is his. Here is my understanding which SJ can confirm later:
>

Hi Ravi,

Thanks for your detailed reply and for sharing your understanding.
The probe-weight framing clears up the part I had backwards.

> Weights are relative, and only among probes. A context can hold up to fou=
r;
> each report carries its probe index and credits that probe's own hit coun=
t,
> so two PMU-based probes in one context are scored in proportion to their
> weights, and that is where a scenario-specific choice belongs.
>

This makes sense. I had initially been thinking about using the weights to
tune SPE against PTE scanning within the same context. I now understand tha=
t
the weights are for combining multiple PMU probes within a context, rather
than blending PMU reports with the existing PTE-based access checking.

> What does not mix is a weighted probe with the other two sources. Any
> nonzero weight switches the whole context to probe-weighted scoring, whic=
h
> turns page-table access checking off -- so SPE cannot be blended with PTE
> scanning, it replaces it. Page-fault reports carry no probe index; they
> credit the region's access rate but have no hit count, so under weighted
> scoring they are not part of the score either. Both coexist with a probe
> only at weight zero, where everything feeds the same access rate and is
> indistinguishable afterwards.
>

The "replace, not blend" distinction was the key correction for me.
For PA locality versus VA attribution, using separate contexts therefore
makes more sense.

> So for your case I would read it as: PA locality and VA attribution are
> different targets and different address kinds, which points at separate
> contexts rather than one context with tuned weights.
>
> >
> > > 2. The 67.9% drop rate is fan-in, not sizing
> > >
> > > ---
> > >
> > > [...]
> >
> > I completely missed this.  The observability framework showed the
> > symptom (67.9% drop) but got the root cause wrong =E2=80=94 it's not a =
ring
> > sizing issue, it's a fan-in problem.  With a single kdamond thread
> > draining the per-CPU sources, the samples effectively get funneled
> > into a single ring, which explains the numbers.
> >
> > The per-CPU drain approach using `system_percpu_wq` and `queue_work_on(=
)`
> > looks like the right fix.  Our AUX backend already carries a CPU argume=
nt
> > through the ops, so adapting it should be straightforward.  I'll take a
> > look at your v2 branch and re-test with the per-CPU drain.
> >
> > Two questions:
> > 1. Is `damon/perf-rfc-v2-08-20-26` ready for me to rebase the
> >    AUX backend and observability framework on top of it?  I'd like to
> >    validate the per-CPU drain fix with real SPE hardware.
> >
>
> Yes:
>
>   https://github.com/ravis-opensrc/linux.git
>   branch damon/perf-rfc-v2-08-20-26, tip 9c0410564596
>
> That is the branch I used to exercise the AUX path. It carries all five o=
f
> your AUX kernel-consumer API patches unmodified, and from the SPE series,
> patch 1/4 plus the generic half of 2/4. 2/4's SPE backend and parser, and
> 3/4 and 4/4 which test them, are SPE-specific and I used an x86 box
> with virtual PMU.
>

Thanks for making the testing branch available. I'll use it as the base
for the rebase and testing below.

> The branch is force-updated post fixing two trailers please re-fetch
> if necessary.
>
> None of it is meant for my v2 posting.
> This branch is only the vehicle for testing the AUX report path.
>
> The SHAs you will care about:
>
>   808519650a7a  the per-CPU report side
>   e3323a3bdc75  your AUX interface, ported to the probe model
>   1c347519c626  parse each CPU's AUX buffer on that CPU
>   9c0410564596  perf/core: balance the AUX buffer reference on kernel
>                 release
>

Thanks for this detailed information.

> 1c347519c626 drains with one work item per CPU in the event's cpumask, vi=
a
> queue_work_on() on system_percpu_wq -- system_wq would not do, being
> unbound it silently ignores the CPU targeting.
>

Understood. This also matches the fan-in issue you pointed out earlier.
I'll keep the CPU-local drain model when reworking the AUX backend.

> Two things came out of a quick test in a VM:
>
> - spe_backend_init() calls perf_event_setup_aux(), but I could not find a=
ny
>   path calling perf_event_release_aux() -- spe_backend_cleanup() frees on=
ly
>   st->win, and your kerneldoc says the release must happen before
>   perf_event_release_kernel(). Left alone on my branch.
>

Thanks for catching this. I'll trace the cleanup path and make sure the
missing `perf_event_release_aux()` is called at the appropriate point befor=
e
`perf_event_release_kernel()`, then re-test the lifetime path.

> - 9c0410564596: the explicit ring_buffer_put() in perf_event_release_aux(=
)
>   is one too many, since ring_buffer_attach(event, NULL) just above alrea=
dy
>   drops the event's reference.
>

Thanks for catching this as well. I'll keep `9c0410564596` when
rebasing the AUX work.

> > 2. For the probe-based configuration, does the `prep_action =3D "perf_e=
vent"`
> >    model preserve the same event lifecycle?  Our AUX path needs to crea=
te
> >    and bind the event during apply, keep it disabled initially, and ena=
ble
> >    it when kdamond starts.
> >
>
> Yes -- created disabled during apply, bound, then enabled. Per CPU, on th=
e
> kdamond turn-on path:
>
>   perf_event_create_kernel_counter()   attr has .pinned =3D 1, .disabled =
=3D 1,
>                                        so the counter is installed but no=
t
>                                        yet schedulable
>   ops->init(event, cpu, perf_event)    your backend attaches the AUX buff=
er
>                                        here, via perf_event_setup_aux()
>   perf_event_enable()                  only now can the PMU be scheduled =
in
>
> So the buffer is always attached before the counter starts. If ops->init(=
)
> fails the counter is released without ever being enabled.
> kernel/watchdog_perf.c uses the same pinned + disabled-then-enable pairin=
g.
>

This lifecycle is exactly what the AUX path needs: the AUX buffer is
attached during `ops->init()` while the event is still disabled, and
the event is only enabled after successful initialization.

> Sanity-tested both report paths in a VM.
>
> Best Regards,
> Ravi.
>

I'm looking forward to the formal v2 as well. I'll continue working on
the perf-side changes so that the new model can be exercised with
hardware-sampled access reports in practice.

My next steps are:

1. Re-fetch `damon/perf-rfc-v2-08-20-26` and rebase my AUX backend and
   observability framework onto the probe model, including the SPE-specific
   backend/parser and tests.

2. Integrate the per-CPU AUX drain from `1c347519c626`, using
   `queue_work_on()` on `system_percpu_wq`, and validate that the fan-in
   problem is gone.

3. Fix the AUX lifetime path by making sure `perf_event_release_aux()`
   is called at the appropriate point before `perf_event_release_kernel()`.
   I'll also keep `9c0410564596` for the `ring_buffer_put()` fix.

4. Re-test the complete lifecycle and the per-CPU drain on real ARM SPE,
   including stop/restart, CPU hotplug, and failure paths, and compare the
   observability counters with the previous 67.9% drop result.

I'll report back with the results.

Thanks,
KunWu
