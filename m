Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AEF3B52E2
	for <damon@lists.linux.dev>; Fri, 21 Aug 2026 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787329938; cv=pass; b=AJ8IPLRNCG+c5uCygIaK7yEllOUGVRLgJvtep8lGuG4FmS0dZVoFrdC97CGvUN6gXKZq2PcKWv45ydMwq+mu8dTLgS/qc4koRzqhrTJ8WQchxKl6W3Fi61q/d2AEl0RK0bXixagHBfqvyeoqfzHgEq0kVxjeTTHBeb61uvDYhpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787329938; c=relaxed/simple;
	bh=GR3jitzuEK6kbLhbeRalr0pMmm+B53ViUUVAq1gI7w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekW45WZUf7DsmQNYr7esA5Mh4WLvH4g9Rkta6gxEMlkbeccxwIffoqXEZVJ+Ge8O5MhGIOzsqgqKuaxXJquSAt72l8z/rtDoy6kJjj6M8mCxR3tsUsQ5NLAoM119lXtr6onkYpPCv+z6gtmsfmKuzEfM0nq/SVILzSv2qE48uNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzBdfgws; arc=pass smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzBdfgws"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38dc4f9462cso362165a91.0
        for <damon@lists.linux.dev>; Fri, 21 Aug 2026 09:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787329935; cv=none;
        d=google.com; s=arc-20260327;
        b=nsQ5qkk+S0pp5YOxDfNITfi18x7n0M18vJey1jN7HjUf3yVMG66SILwfZwa/nCimHa
         sTsmNws10HHyv2hiF3O874ZvMUCDhXSPHycRJ/i9oytoDLKGBTbqktzV8p4mekgApoOC
         NsKMplBsEbRMuoq5YnJ3hC7/9KOIAQYzEQeAq4mMYu7bYfJXXGP9z+Kv9a4nBR+L9oPS
         Y3lsykvoGyPZ3EqvzuPKAyvdJxik0h1PL9a6FtHx+RKSf2SIuwxz3n8EdcjZzsVk1Ask
         +pDl/0AmNW8b68ekg0emz+u2hHQryKlyoHu9jdjv3Vx6TK14adHHCshgwa5Sm+5C1HK4
         P/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uKrunJMg40NjeuxUGrFsyHBAkzDtHd4//4PJzcyrA7w=;
        fh=oSIXT8yBzCWtMIll+ckvVZBdiwu/pR3HbHH270butZI=;
        b=oUAPbFmQJSybDjw0qJgqb2aCzceH0lHqvIREggIoc+/E5hNNdr8SuwlhsoOXHj+NOA
         7LfNllFEHSzwky7kS+u6brwfOZ3N7GfUdRB6TpLvtOH4VPsH5oYSete3+dTuTjyGzVLZ
         s9nsSYeXwBxhLKQy1/hebmvL3OzRil8l7PcYwC6sUCiwccDR6DeTjoblnwuFbB+hmLWj
         sP/lODGokivo6Y80yoCUxfqnxK9mSLRg5/lS/JT8trTrWNwh8rCz2coOmTgQnp90xbCj
         Xhhu6ij1KihSB6xAu1cYuFZFGTr6t32Cu0B508t5gn2Yb6h4hIB2CPsEBBqjQZAUlV0R
         nuxw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787329935; x=1787934735; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uKrunJMg40NjeuxUGrFsyHBAkzDtHd4//4PJzcyrA7w=;
        b=DzBdfgwsL+agyXNqjlbqL5yVXG0gN5GxZwHHOl1JDZNi0aEhQIZqCSNsHU2uF1gvPw
         wsdG5xlixEgihIRtcW+OYFk5YfcLzLWnRLSsnphinvRuvh5Ju3Bb+mGQzMGMf024sYtP
         0faUFTQNVrd6aLcMIpEw/XOOZbvNdJsQFWIYGWzl8O6NKy1T03hX8SwNJ9eUGRFbBrer
         FSYdk2NQ12qcan+VODEpmTbCIgXryD5TVgR3v7hqVdUCd/EIkK0HBrqvPvMnLNaQDgq0
         MhoPVepMHiyQQZhzf/LSPoP2rlGXp4Dk6rQwH1m7K8jhq/7f8Vvldb7L6AdZUYMz/RI+
         zDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787329935; x=1787934735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKrunJMg40NjeuxUGrFsyHBAkzDtHd4//4PJzcyrA7w=;
        b=kLhjjstyjwBQNRtZahO6lcVXC23HR3wos8qETrYaIEuqlpDPivzaWLkFc2LdQlyilm
         PFjWQmPSCCxjMLCn8Kz3NXdVFM6SbcaRyfLnU5MoMR4t5xTUUwv/0EZaKToyuVnq8I4F
         Z93/zgVg/RR+P+HHlG6yJqa6QlXveyMPhW9GBmUBv0nQxvDbrdBvLczcijtneFyU6Rw3
         mdq9c4Nne7qFkcmpufAdHXDDb7+5crBPUFXPwh6ipe3KPanyQHzRnA09Pi72sEsT/dqf
         ALc15LSaWi25LvZ9zoSJzFybMtHgQJ6mbDu2UCcU5lfsw5N9R2lOgHe36ojbfmLFFCPu
         H71g==
X-Forwarded-Encrypted: i=1; AHgh+Rr++9CbM6J1JhjwzFJZQj+8AwyZjtweWUS0ngZSvjtdGWr8ql4+x8tIaS2tKd8yWJ10Ah3ZXA==@lists.linux.dev
X-Gm-Message-State: AFuF++kZijtoVRzOBTR/NFrq7vdPtpzBukMuXK3IkaYJGWIsFgaUCw5o
	dXonlp/H0LZQGjGn7gwhu754pa7sTDlauXhvJKvwnvlqL3gVdar5CKgN2BLTGycSSVakGS5EKAz
	P16pprwvyU+QiDYNcyEQLujQTjXeqxw==
X-Gm-Gg: AR+sD12HZ8/theg369gDEd8AeiAJ8KfAigQwZ5ZMGs1oYh5P9oq2jv3OGCbTjlMxm9Q
	gPqF2cOMVg2mXvm+7JUik80kIvfG3tMvoLxHYNhjBJ020aWNm36GQTFKfahThJLWPr8OyKFINzR
	V18OnRbnkR+VZHLl+tmq2GMVmy6gHDmN8fSMHR2ZpZHTY+c87z6TiINJJcvYpRwekj9401u+s3R
	Md+i83SzNPUpXpCsIogdzM5dbfZKzcbe2xy7u3Z6jeOrjJoUdxjPn72YamfksiRR+MuVZ/cblq1
	sPS8lFWBQLPfQt9XvaED4CkCKulAqY5m/3JY0287y4ajOlBKYztrCHckR44=
X-Received: by 2002:a17:90b:55cd:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-395c35f0a85mr14515030a91.13.1787329935050; Fri, 21 Aug 2026
 09:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260529165640.820-1-ravis.opensrc@gmail.com> <20260818073546.832476-1-kunwu.chan@linux.dev>
 <CALa+Y16xODsaFZDfh7ZeP3gWbycK92gvP5N8_NFpOvW=R2BWbg@mail.gmail.com> <CAN_Opa_h2W1hRimy2YXPC4EgueCi2UNwnZ5gSYV=cr8M7yfCmA@mail.gmail.com>
In-Reply-To: <CAN_Opa_h2W1hRimy2YXPC4EgueCi2UNwnZ5gSYV=cr8M7yfCmA@mail.gmail.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Fri, 21 Aug 2026 09:32:02 -0700
X-Gm-Features: AcwNN1W_2JZ34i4ktwhmNpUgZM8oH3GEFi2Bi6orDDuwSTf-FJjTXej5NTLTNnE
Message-ID: <CALa+Y15zNhpubyH5GQgu_BHesrwRdH0B8k5cqT3o_U0h5A2e-w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, sj@kernel.org, akinobu.mita@gmail.com, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 2:55=E2=80=AFAM KunWu Chan <kunwu.chan@gmail.com> w=
rote:
>
> Hi Ravi,
>
> Thanks for the detailed reply.  The fan-in diagnosis makes perfect sense.
>
> > Your series is based on the v1 substrate, and the way an event is
> > configured is the part that moves most.
> >
> > [...]
>
> Glad to hear v2 is on the way.  The probe-based model is actually
> something I encountered while building the AUX backend. When multiple
> sources can feed the same region (e.g. PTE scanning + SPE/IBS), the
> question of how to combine their reports becomes interesting.
>
> For example, CXL tiering may care about physical-address locality, while
> per-process monitoring may need virtual-address attribution.  How do you
> see probe weights being determined =E2=80=94 is that expected to be
> scenario-specific, or is there a more general principle behind the
> weighting?

Hello KunWu,

SJ can answer that authoritatively -- the probe and weight interface
is his. Here is my understanding which SJ can confirm later:

Weights are relative, and only among probes. A context can hold up to four;
each report carries its probe index and credits that probe's own hit count,
so two PMU-based probes in one context are scored in proportion to their
weights, and that is where a scenario-specific choice belongs.

What does not mix is a weighted probe with the other two sources. Any
nonzero weight switches the whole context to probe-weighted scoring, which
turns page-table access checking off -- so SPE cannot be blended with PTE
scanning, it replaces it. Page-fault reports carry no probe index; they
credit the region's access rate but have no hit count, so under weighted
scoring they are not part of the score either. Both coexist with a probe
only at weight zero, where everything feeds the same access rate and is
indistinguishable afterwards.

So for your case I would read it as: PA locality and VA attribution are
different targets and different address kinds, which points at separate
contexts rather than one context with tuned weights.

>
> > 2. The 67.9% drop rate is fan-in, not sizing
> >
> > ---
> >
> > [...]
>
> I completely missed this.  The observability framework showed the
> symptom (67.9% drop) but got the root cause wrong =E2=80=94 it's not a ri=
ng
> sizing issue, it's a fan-in problem.  With a single kdamond thread
> draining the per-CPU sources, the samples effectively get funneled
> into a single ring, which explains the numbers.
>
> The per-CPU drain approach using `system_percpu_wq` and `queue_work_on()`
> looks like the right fix.  Our AUX backend already carries a CPU argument
> through the ops, so adapting it should be straightforward.  I'll take a
> look at your v2 branch and re-test with the per-CPU drain.
>
> Two questions:
> 1. Is `damon/perf-rfc-v2-08-20-26` ready for me to rebase the
>    AUX backend and observability framework on top of it?  I'd like to
>    validate the per-CPU drain fix with real SPE hardware.
>

Yes:

  https://github.com/ravis-opensrc/linux.git
  branch damon/perf-rfc-v2-08-20-26, tip 9c0410564596

That is the branch I used to exercise the AUX path. It carries all five of
your AUX kernel-consumer API patches unmodified, and from the SPE series,
patch 1/4 plus the generic half of 2/4. 2/4's SPE backend and parser, and
3/4 and 4/4 which test them, are SPE-specific and I used an x86 box
with virtual PMU.

The branch is force-updated post fixing two trailers please re-fetch
if necessary.

None of it is meant for my v2 posting.
This branch is only the vehicle for testing the AUX report path.

The SHAs you will care about:

  808519650a7a  the per-CPU report side
  e3323a3bdc75  your AUX interface, ported to the probe model
  1c347519c626  parse each CPU's AUX buffer on that CPU
  9c0410564596  perf/core: balance the AUX buffer reference on kernel
                release

1c347519c626 drains with one work item per CPU in the event's cpumask, via
queue_work_on() on system_percpu_wq -- system_wq would not do, being
unbound it silently ignores the CPU targeting.

Two things came out of a quick test in a VM:

- spe_backend_init() calls perf_event_setup_aux(), but I could not find any
  path calling perf_event_release_aux() -- spe_backend_cleanup() frees only
  st->win, and your kerneldoc says the release must happen before
  perf_event_release_kernel(). Left alone on my branch.

- 9c0410564596: the explicit ring_buffer_put() in perf_event_release_aux()
  is one too many, since ring_buffer_attach(event, NULL) just above already
  drops the event's reference.

> 2. For the probe-based configuration, does the `prep_action =3D "perf_eve=
nt"`
>    model preserve the same event lifecycle?  Our AUX path needs to create
>    and bind the event during apply, keep it disabled initially, and enabl=
e
>    it when kdamond starts.
>

Yes -- created disabled during apply, bound, then enabled. Per CPU, on the
kdamond turn-on path:

  perf_event_create_kernel_counter()   attr has .pinned =3D 1, .disabled =
=3D 1,
                                       so the counter is installed but not
                                       yet schedulable
  ops->init(event, cpu, perf_event)    your backend attaches the AUX buffer
                                       here, via perf_event_setup_aux()
  perf_event_enable()                  only now can the PMU be scheduled in

So the buffer is always attached before the counter starts. If ops->init()
fails the counter is released without ever being enabled.
kernel/watchdog_perf.c uses the same pinned + disabled-then-enable pairing.

Sanity-tested both report paths in a VM.

Best Regards,
Ravi.

> Thanks,
> KunWu
