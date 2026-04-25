Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4440DFD5
	for <damon@lists.linux.dev>; Sat, 25 Apr 2026 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777120401; cv=pass; b=MFb+FO5Ry970ZTkXqQ1jNCwW4Xa/iChxgIcwm3VDiFK2e8bKOdBrXALn9daRwHgjOCv4corI6if/UWlHa9USfZNDf5io7h7QzZbQkhyKPqcN+hkUChUmi+EvHy8VTZutqzqXKwSmB/KGyqLXkRoVvJJ0Yct7SMuVB5mbSRxEAuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777120401; c=relaxed/simple;
	bh=W5dPlWs+XG9nZfy5TnoKIlvfdFg2ADTJ2GTCqdJZktc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6Jw1ph6bHmUV8a19CRhL4eCZbUkq+wbw6KHy0S32ldekkfcm7xe/pf8Pby4sXYN8b9+ErDulo3Js7GUqCBKWwG63KcdB2KN2sUv6lAYucXeIFdaKKh1SwY4YHYgRINUDJ9nAKpZ4ErJLKdDMfRHSVKUZu7MWgIRY0U7oEfSyWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2Pm3SSi; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2Pm3SSi"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d876329bbso97950451cf.2
        for <damon@lists.linux.dev>; Sat, 25 Apr 2026 05:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777120399; cv=none;
        d=google.com; s=arc-20240605;
        b=Mpc4dPH/Is17cUZuEn31lgPFARPWBjrvQ0zfyYDpoCmNhAJFcGBT7ZsFHhq30qyUou
         rbQSBP1GtZJlkOqoFksKNLROQI8b2riZdXEebR1xx7AJ5uMBol6L11jaTpSvVro7QtlO
         ibI0tJbqXhpx+VukDG/aUv5pljuAd5+fzkNvo3bsnw3gefzoWaylHe8cICaXylbAIeec
         XjbLtAyTkNVQ6TR2dIsdNU7ehUlyC3HbJ9Mw/8bMy4MN2qXwAKoXOorqgQSHBws6/U2+
         hiHgUeuspHD6FisnySbxjgZDEUJOu5BCLxUFzeO+XFQ8TJzKqdtE2fvN1d3z24uvCKo4
         kBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ftgocb40oPxcjjaNTJyGl+Q8Zs5puERTVT80QqciM/4=;
        fh=Mf9DINRRmhThOYETEReLQX7AM1T+ry1aGtACQzu4Fyc=;
        b=U9Ijq+ZP8yvD9aN9LyC68LvjNw3bRd84ZJ4RaRa3vF65AoBsIASpBq8YAPeTsCru5J
         19FAFBhfs9zyV8qWHw8mn8/pt5kUIHqgT8LIZUmaeHvNEfl9MXWe3oeNAsCaX5TMpeDo
         GvWcQrWkhJAteT6su5yXXtTAfCOB5rnmWpR5iuqcVuP6FBvCJXnDvxhymI7Iy0GEJWWj
         6U+MEDkZppdEM2WrVFls9uHQ+oGV9HJYCkA/L44x5zC8SxBiFohoWP92OPR7vj4g5zud
         ENhIpjhinM/MQ7EliPdFXwzBzFrq9XRH4zl9Otl432YkSUfMJ88N2OJYNquxHH5yRBZl
         DIKw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777120399; x=1777725199; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftgocb40oPxcjjaNTJyGl+Q8Zs5puERTVT80QqciM/4=;
        b=a2Pm3SSiN4ffGsm4dafHVJ6Osd28OgWzc4UxxVdi+JXF4JhXyrMX68+DQJGCnvVjg2
         4NQnoYQSDR49La6ygh/6AMOjSGAzNPLeXojIbKBX4cswH2mrPa1dgd8Rdmx4sIcVv+Kh
         CMoApKWIQ0oFiLLf2TcEgZEMtNOgZEdIM1a5Hb/5uCUilHLFe2MqkIMsCd7ClYLNJKcQ
         k3fQV7U8NcHS6d6D48IjTz2Rz/0f44Ie6YjlqKBNUr0YCOCDsEXpBliu57HdT/z8sNy4
         +vrpv6Zf3IORAPlOsfOw8HBP7uUUD53bnnLAbr51tRxTWn8kBkFycHrE/rlpJsICjrqM
         VFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777120399; x=1777725199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftgocb40oPxcjjaNTJyGl+Q8Zs5puERTVT80QqciM/4=;
        b=a6KomHR8BKgTVEY4CdpteERXGK8bL0X96OaHvycYv7PjxfO8ohRrWpOn9g4VhjVpTr
         piM6DkIw5bP9cGXQxotqG+bgFc2+cwOwb/VNui5eBj7AhO6/l59WekLfjASeGF1VuRbq
         Tl2ryh0k0xpvgR5lP2OpEwM86NPh0wxN4e6Ov8AGsznDlSTwbnGYQY8aZ6Pe71qxdXb4
         uHHc/oEL84lwNIDkLvWagpjdXA4xK6RrbGy6z0eMt0B3V65tls7gplAxnV6xE3FjEdN2
         +RIESgI9sB+WckwE3yY+mo5sgZwoqKF6Q+ktea8Eqqdur0GI0a3hhW/NXJi8fTZ/EOr8
         dHOA==
X-Gm-Message-State: AOJu0YxDC8pW6yqRirbPEkZ8YvuU0xuPcRJIYxZnb3Vi7dwj6lJLmmQS
	M7jMLaoAhHnsPW6d5LDmJraFK+1TnbKV9rpoWdBaFkALq4TqkcxyLjMQiqRGDAEJUXs5HK6WnT/
	3ulLgsLkaORvYO4geKkMWVnetBWqjBYM=
X-Gm-Gg: AeBDieu+I1/qSko14EOF8dUBZsaT/l+lfLPgTn7K1Z7ayf/pe3WF0oAFVkJ53lCoZm5
	WUQGCgOaYedu3AryzCBUymBiaA4q2/bBtAghdeG8E+y/mPJfcWCKGU+hV+8h48U9JicVls7s0Cj
	jLr6ZckakzTGfRW6Ew4FkLd96R/L5AqQfmIt95LrRteo0zZcnJbhpbavVH3apVdH0p9/dXR2F/L
	Ye4GQG3SB/BtFHE1a5UDD+NbxWtTuVtdI2AKUW9PwoYE3SU+IxFLfe8GWzbefkFgjtLeNRtt9Dy
	tZ2IJ3eeAFE371sbz+2dr010t/IjFD6XsdsK739MXtur+g==
X-Received: by 2002:a05:622a:2513:b0:50e:6183:beea with SMTP id
 d75a77b69052e-50e6183c685mr377965061cf.23.1777120399039; Sat, 25 Apr 2026
 05:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAC5umyiikHr4doYKW5Gy4uv6M0_HbBZUSd9kM+L+kCrKYKEuXw@mail.gmail.com>
 <20260424233136.6716-1-sj@kernel.org>
In-Reply-To: <20260424233136.6716-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 25 Apr 2026 21:33:07 +0900
X-Gm-Features: AQROBzDpdq2IBRfcCGSRDznfqt-u3WmGMUNbHZ7CJx35Af7LgQxOJzS7FHuggi8
Message-ID: <CAC5umyjcFm-iw31kgYP0Z61z7N=vMzkZKsvGZpYmNwNw3R_gHw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/4] mm/damon: introduce perf event based access check
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B44=E6=9C=8825=E6=97=A5(=E5=9C=9F) 8:31 SeongJae Park <sj@kernel=
.org>:
>
> On Fri, 24 Apr 2026 12:27:07 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > Hello SeongJae,
> >
> > 2026=E5=B9=B44=E6=9C=8823=E6=97=A5(=E6=9C=A8) 13:34 SeongJae Park <sj@k=
ernel.org>:
> > >
> > > Hello Akinobu,
> > >
> > > On Thu, 23 Apr 2026 09:42:06 +0900 Akinobu Mita <akinobu.mita@gmail.c=
om> wrote:
> > >
> > > > DAMON currently only provides PTE accessed-bit based access check, =
this
> > > > patch series adds a new perf event based access check.
> > > >
> > > > Since perf event-based access checks do not require modifying the P=
TE
> > > > accessed-bit for pages representing each damon region, it reduces t=
he
> > > > overhead of monitoring at a fixed granularity of the page size.
> > >
> > > As I also commented to the previous version, the high level idea make=
s sense to
> > > me.  I think this can be useful.
> > >
> > > Also as I commented to the previous version, I understand the page le=
vel
> > > monitoring overhead reduction is the main purpose of this patch, and =
it makes
> > > sense to me.  Nonetheless, I like this mainly because the perf event =
could
> > > provide more detailed information including from which CPU/thread the=
 access is
> > > made, and whether the access is for read/write, to my understanding. =
 Please
> > > let me know if my understanding is wrong.
> >
> > That's correct.
> > Once the integration into your new monitoring infrastructure is
> > complete, those things will become possible.
>
> Thank you for confirming!
>
> >
> > > >
> > > > Here is a method and its results for comparing access checks using
> > > > existing access bits and new perf events.
> > > [...]
> > > > Using accessed bit, prepare_access_checks takes 7 seconds and
> > > > check_accesses takes 5 seconds.
> > > [...]
> > > > Using perf event, prepare_access_checks takes 0.01 seconds and
> > > > check_accesses takes 2.6 seconds.
> > >
> > > Thank you so much for sharing these great test results with the detai=
led setup
> > > description!
> > >
> > > > ```
> > > > $ sudo $HOME/damo/damo stop
> > > > $ sudo $HOME/damo/damo start --ops vaddr \
> > > >       --perf_event 5000 0 0x4 0x1cd 0x1f 0 \
> > > >       --monitoring_intervals 5s 60s 300s \
> > > >       --monitoring_nr_regions_range 1000000000 1000000000 \
> > > >       --target_pid $(cat /tmp/memcached.pid)
> > > [...]
> > > > Note: damo's --perf_event option
> > > >
> > > > Using these features also requires modifications to damo, but these
> > > > are not included in this patch series and are currently under
> > > > development in the following branch:
> > > >
> > > > * https://github.com/mita/damo/tree/damo-perf-for-v3.2.2
> > >
> > > Thank you for sharing this, too!
> > >
> > > >
> > > > The option newly added to damo for perf event-based access check ha=
s the
> > > > following format:
> > > >
> > > > `--perf_event <sample freq> <sample phys addr> <type> <config> <con=
fig1> <config2>`
> > >
> > > I think we may need to discuss more for final interface.  But I think=
 that
> > > could be done later, after the kerenl ABI is fixed.
> >
> > My current patch introduces a set of kernel ABIs (.../perf_events/<P>/*=
),
> > and if I want to control another field in the perf_event_attr,
> > I would have to add a new ABI. This would be a significant
> > maintenance cost.
> >
> > Instead, I would like to provide a single bin file where the
> > perf_event_attr I want to set is written as binary.
>
> I'd prefer having single file per parameter, as sysfs is designed for.  I=
t
> allows keeping the input format simple and therefore easy to maintain and
> extend.  Of course, we should carefult at adding new parameters, though.

Another idea from Namhyung Kim [1] is to fix the events
specified by the CPU architecture being executed.

Of course, we would want to control a limited number of
parameters, such as sample_freq.

[1] https://lore.kernel.org/damon/aZwLDAxf9eP0lPdD@z2/

> >
> > > >
> > > > - `sample freq`: A higher frequency improves access accuracy, but a=
lso
> > > >   increases overhead.
> > > > - `sample phys addr`: specify 0 for vaddr and 1 for paddr.
> > > > - The remaining type, config, config1, and config2 settings can be =
found
> > > >   as follows:
> > >
> > > The values look bit human-unfriendly.  I wonder if we could use more
> > > human-friendly values, e.g., 'cpu' for type,
> > > 'mem_trans_retired.load_latency_gt_1024' for config, etc.  Not necess=
arily we
> > > need to fix this right now.  Let's keep discussing.
> >
> > I'd like to do it that way. These processes can be handled better
> > from user space than from within the kernel, so I'd like to achieve
> > this from damo with the help of the perf tool and library.
>
> Does existing perf event ABI also take that approach?  If so, I think tha=
t is
> fine.

On Intel CPUs, you can read the mem-loads and/or mem-stores
files as follows to find the value that should be set to
perf_event_attr:

$ cat /sys/bus/event_source/devices/cpu/events/mem-loads
event=3D0xcd,umask=3D0x1,ldlat=3D3

You can find out which bit field of which member of
perf_event_attr should be used to set these values from the
corresponding files in the format directory.

$ cat /sys/bus/event_source/devices/cpu/format/{event,umask,ldlat}
config:0-7
config:8-15
config1:0-15

This conversion from symbolic event name to values that should
be set in perf_event_attr can be done, for example, as shown below,
so I think it should be implemented using perf in some way.

import perf

if __name__ =3D=3D '__main__':
    evlist =3D perf.parse_events("mem-loads")
    for evsel in evlist:
        print(f"{evsel}: type=3D{evsel.type} config=3D{evsel.config}")
