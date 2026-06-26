Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A103F789C
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482074; cv=pass; b=ZO123IGi9IkEb99tYEnOk3obQHFc93u/aehO2wP6kOQmREOfOKuax2trA6BKjErFia7bKx5GfkL8EINK3Ta6KrPZviRK1Rwg0yE/UysWgjplwGYgWqH7FPo8r2mod933i13BYa6JulpecY+/S48g14TAfp17yrpDiAx+LfKvKWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482074; c=relaxed/simple;
	bh=2kujxcsx4SBcTF16/vnx9rx10+HFQ9s0MPTG4nlD3x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCJ+x0LBadMnBymq6q2kYJeFmL781TtHkOQYMeHuESpi+L1iRmvoOOvgpLKtveFgQCgVW96DpBsvjTF+77jmOG+bdl+PJxyeN2hyrAMGs0mM+ncpjY0oazHjRQntJctBaaqfcbIcK/hVFMA0CRWTpaEMjsU9dgT8rQY88ABiKrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlX+meIr; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlX+meIr"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ce0f17a69cso8372466d6.0
        for <damon@lists.linux.dev>; Fri, 26 Jun 2026 06:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782482071; cv=none;
        d=google.com; s=arc-20260327;
        b=Jn8MT4s+pezSyDJKHuzi3+bCNFKCxbgvTezcOHDCBRZmkeUgASbq5b8rn60JiO+Equ
         oMRo+HbUYIsBsYNhKtlTvCMmbSZyja+raH6HHKngp78rwTkcs4uDtLopTC8ikLG2rlHP
         4iCio6OSfvBD23a8+QfAb4XLf77OL4VxPr4e7EbPjTFnfJQg6Konfq1ecG6cX0m1hTzj
         qeZ8XpI/bTBkZ5W5GOPTSR12CqoMYZlKhdugxHJVM0DE+qcD/y93eaX2q5iXHR0nhj7x
         IOCWVAtKclPu5JlyXDeOhqvmMZsUIlcy7T/uz8L1/keYqHat1rgdlKbNa77ki5AXBVlT
         IHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VjHNiP0IoRwlBG7ewKYx5rusZ8lcYYfVVLXImxvlHaA=;
        fh=40VfBhx/NTiIuflYLkcfFxqzGHT9CtAuyhwf2rRpmCM=;
        b=o50a3gc/2HUcDniowL6ABKFe+f/Gm3SUh29VlQjJCsW2wc7XobGBUfaU10CQZyaarC
         d4SxJOzi6VBWHfbdI390k38K7PEkOcBn89ealSB+XJVhV+lZ2SNtG7CGuep+DyBIyaht
         wbFm55wYmVLV4RuEqapvESxeg/G+sO2y/LOd248m+m+UcCAsnBjIgMWu//UdtJ3hkpKc
         KLuVs1aXdohA6++/ttjf95W6sBIeKevsycLsSKx8hqhgWvGlaH4nerzzFrIjglzjtW4P
         jf5+Cnn3yVyJJ8xkOxcTZkBW2LKz9CfgLD5sc75vR9r50yLGjC6cywYhmYCumniszDVE
         n6Ag==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782482071; x=1783086871; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjHNiP0IoRwlBG7ewKYx5rusZ8lcYYfVVLXImxvlHaA=;
        b=IlX+meIrpM5SZeyjN9ocht781Aj02B4vTi6I5uWUwhUhnmhS/qUxgeEaWZOBLt5iMW
         qAQnKCzmmPqj9sjwQHL7rxfIUlx5A+4rTO5WU8vLTwVX2k/X3iRChDNJC5UhcP7ft92K
         D441kTzt+yLYV0nXhIe7An7aK02R7V7JIXWfpYn66aDgBfQcXZVPRkTx9D0rBT5RzzVg
         GsHi+tDWA+k0GVYw148v9rggBc2RQhvXJjwDNjcOoid6IS6sVbTy/xl1ZLvgNAg1ED6I
         Zlo32N9yvD+EB/5xgPFuxSSs0NxXoP1A1uGuzT55q0Kz42VATSw2akf7JUNepGaH9XGb
         llbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782482071; x=1783086871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VjHNiP0IoRwlBG7ewKYx5rusZ8lcYYfVVLXImxvlHaA=;
        b=D7TED4JJ5zmEEjMAMWTB5m2L3AdfT/1yNuXW7G8+qHaO1894cuNjVGB+cGWUfTduGE
         ZQ+z37AYhVLb46jrsyNNum2PPHQa9SsEK8QvDmSwn2cTsDB/4k1eKie2X6KQvVmE34L5
         fTf6mVNX6BlR343axFiMgnekhCpcOonbriy3rULzK8nwErVaM7V1b9Serdpo6TtElVO/
         Tz+yBOl4BmKJsW48040OwlsoEmev35i8ro+1omM75uOF9gv1ZQ/Q9VdeILjZLAj/U3lW
         C+GCRhFqDBHeS02AFYSQmsgv9fPrvc1QPA+FD1nQ1ft0XrS9IqASDs+OTdaI8fcj6Id/
         s74A==
X-Gm-Message-State: AOJu0YwNGc+2ck2knl21cTBSXRGDykQCmmMw0MILjgSltJ2BTGhWIBwU
	ShaZsgN4/lTXnASCBBg8CZwtNZu00QsQdmqQJErF0Kx6i9NPnW9e0YnhtZSyWLWtSIM6nA1SMJa
	rc5Bk31WE7t7h7LjiL3RdAKs+NV0/ers=
X-Gm-Gg: AfdE7ckHPUnzPy+Fyqu4HEm/XGOdOfmZ0Qa/BRGPwzEHNePj1XLQOliOsLwkRMLbxj+
	T4hlt4ddUv2vcLZTn/l6RgS7u7+kz2gqJw2EkMjpvLsoeK0R327ysGzZ5wg0PSY+VwO9k4mFfux
	yH3wu4HVqx4dt85TvCsyRQGlVMq0yJSG9Qf4UtwJEHP4IIGBpBBqQ+0YvVsOrZukM7XZSNFhJT3
	ntVFCC0xk7sJbE2ytZRKXmInEizK+3r4aRqqc9E44ZEc4eJzWUwywnMHLoQZFEAyrNYfoQd3fgq
	Ks4vfFsbol0rUEhyJT8/Y1y3
X-Received: by 2002:a05:6214:3213:b0:8db:1179:d180 with SMTP id
 6a1803df08f44-8e6d8103a36mr123617816d6.23.1782482071286; Fri, 26 Jun 2026
 06:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622134933.35773-1-akinobu.mita@gmail.com>
 <20260622134933.35773-2-akinobu.mita@gmail.com> <CAP-5=fVyAskTbcB-pJbcNChq8GJnQ_098EfsnZzcO7O9A-8x4g@mail.gmail.com>
In-Reply-To: <CAP-5=fVyAskTbcB-pJbcNChq8GJnQ_098EfsnZzcO7O9A-8x4g@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 26 Jun 2026 22:54:20 +0900
X-Gm-Features: AVVi8CdklkvDlugov6HgfVnIoohUA6wCsjPFgkazexlVbIHTJ002frAvg-Q5_n8
Message-ID: <CAC5umyj6jXucmjUa2c-QMVxMZMV8wskzzcBAGTm4+C_HtuBTNw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] perf python: Add access to various members of evsel
To: Ian Rogers <irogers@google.com>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, sj@kernel.org, 
	ravis.opensrc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B46=E6=9C=8824=E6=97=A5(=E6=B0=B4) 3:10 Ian Rogers <irogers@goog=
le.com>:
>
> On Mon, Jun 22, 2026 at 6:57=E2=80=AFAM Akinobu Mita <akinobu.mita@gmail.=
com> wrote:
> >
> > This change is necessary to specify the same PMU event selection as the
> > 'perf record' -e option from DAMON's userspace tools.
> >
> > For example, a Python script like the following will allow you to obtai=
n
> > the values to be set in the type, config, config1, and config2 members =
of
> > perf_event_attr by providing a symbolic event name.
> >
> > import perf
> >
> > if __name__ =3D=3D '__main__':
> >     evlist =3D perf.parse_events("cpu/mem-loads,ldlat=3D30/P")
> >     for evsel in evlist:
> >         print(f"{evsel}: type=3D{evsel.type} config=3D{evsel.config}",
> >               f"config1=3D{evsel.config1} config2=3D{evsel.config2}")
> >
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>
> Thanks Akinobu! I agree we should expose more parts of the evsel
> through the perf python API. I refactored this area recently so that
> we could better support perf.data file usage (the session API).
> There's a long series here that is merged enough to mean these changes
> will need a refactor too:
> https://lore.kernel.org/lkml/20260419235911.2186050-1-irogers@google.com/
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n2449
>
> The main change I made was avoiding copying evsels in the python API,
> as it adds many complications, and switching to reference counting.
> This means the Python `evsel` can no longer directly access inner
> variables and now requires an indirection. So in:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n2290
> ```
> static PyObject *pyrf_evsel__get_attr_config(PyObject *self, void
> *closure __maybe_unused)
> {
> struct pyrf_evsel *pevsel =3D (void *)self;
>
> CHECK_INITIALIZED(pevsel->evsel, "evsel");
>
> return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.config);
> }
> ```
> Note how it is `evsel->core` rather than `evsel.core` as it was before.
>
> I believe you can copy-paste the code and tweak it for config1 and
> config2, but I'm afraid the previous evsel_attr_member_def approach
> won't work.

Thank you for letting me know.
I think I will be able to handle it once those improvements are merged.

> Thanks,
> Ian
>
> > ---
> >  tools/perf/util/python.c | 50 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index cc1019d29a5d..3f108b405ee3 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1241,11 +1241,60 @@ static PyMemberDef pyrf_evsel__members[] =3D {
> >         evsel_attr_member_def(sample_type, T_ULONGLONG, "attribute samp=
le_type."),
> >         evsel_attr_member_def(read_format, T_ULONGLONG, "attribute read=
_format."),
> >         evsel_attr_member_def(wakeup_events, T_UINT, "attribute wakeup_=
events."),
> > +       evsel_attr_member_def(config1, T_ULONGLONG, "attribute config1.=
"),
> > +       evsel_attr_member_def(config2, T_ULONGLONG, "attribute config2.=
"),
> >         { .name =3D NULL, },
> >  };
> >
> >  static const char pyrf_evsel__doc[] =3D PyDoc_STR("perf event selector=
 list object.");
> >
> > +static PyObject *pyrf_evsel__get_freq(struct pyrf_evsel *pevsel, void =
*closure)
> > +{
> > +       return PyLong_FromLong(pevsel->evsel.core.attr.freq);
> > +}
> > +
> > +static PyObject *pyrf_evsel__get_exclude_kernel(struct pyrf_evsel *pev=
sel,
> > +                                               void *closure)
> > +{
> > +       return PyLong_FromLong(pevsel->evsel.core.attr.exclude_kernel);
> > +}
> > +
> > +static PyObject *pyrf_evsel__get_exclude_hv(struct pyrf_evsel *pevsel,
> > +                                           void *closure)
> > +{
> > +       return PyLong_FromLong(pevsel->evsel.core.attr.exclude_hv);
> > +}
> > +
> > +static PyObject *pyrf_evsel__get_precise_ip(struct pyrf_evsel *pevsel,
> > +                                           void *closure)
> > +{
> > +       return PyLong_FromLong(pevsel->evsel.core.attr.precise_ip);
> > +}
> > +
> > +static PyGetSetDef pyrf_evsel__getset[] =3D {
> > +       {
> > +               .name   =3D "freq",
> > +               .get    =3D (getter)pyrf_evsel__get_freq,
> > +               .doc    =3D PyDoc_STR("freq"),
> > +       },
> > +       {
> > +               .name   =3D "exclude_kernel",
> > +               .get    =3D (getter)pyrf_evsel__get_exclude_kernel,
> > +               .doc    =3D PyDoc_STR("exclude_kernel"),
> > +       },
> > +       {
> > +               .name   =3D "exclude_hv",
> > +               .get    =3D (getter)pyrf_evsel__get_exclude_hv,
> > +               .doc    =3D PyDoc_STR("exclude_hv"),
> > +       },
> > +       {
> > +               .name   =3D "precise_ip",
> > +               .get    =3D (getter)pyrf_evsel__get_precise_ip,
> > +               .doc    =3D PyDoc_STR("precise_ip"),
> > +       },
> > +       { .name =3D NULL, },
> > +};
> > +
> >  static PyTypeObject pyrf_evsel__type =3D {
> >         PyVarObject_HEAD_INIT(NULL, 0)
> >         .tp_name        =3D "perf.evsel",
> > @@ -1255,6 +1304,7 @@ static PyTypeObject pyrf_evsel__type =3D {
> >         .tp_doc         =3D pyrf_evsel__doc,
> >         .tp_members     =3D pyrf_evsel__members,
> >         .tp_methods     =3D pyrf_evsel__methods,
> > +       .tp_getset      =3D pyrf_evsel__getset,
> >         .tp_init        =3D (initproc)pyrf_evsel__init,
> >         .tp_str         =3D pyrf_evsel__str,
> >         .tp_repr        =3D pyrf_evsel__str,
> > --
> > 2.43.0
> >
> >
