Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E9390239
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238240; cv=pass; b=jjhU+1A7bI6D6EhrTs3U6Y/H9R/mu3aFNGHvF9EuY7UL+Jv8JEqA8AQ0+e0Mone/LIIWa0yhgrTgn/AhCJemiIKQgCOedacApvcPPZnrlzkft2AKEE12H6zdxLxLOFGmuKZbndOv4YX2Aq6ljegXeUby7iYezK9uBXAKeJVNeMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238240; c=relaxed/simple;
	bh=gtEtA/1bnlJadumPvs7pL49nsw17aLwbOXX60YN3LT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHekyVrbyOBL+9fgfPrtoZ8vIOlN+TQYCz3V41YWb+dFyTr5c91DQwQSh6TQDp0faCmd5t9nx3wcqJhsH3/9yCRUnHcDMgocIB/I/EteTjDgl4ue5BOz/eLvtL7QFz+5Qxv+ICDnpMqNapunpr3O8YH9S9OsUFWgBRwUxc8Ew9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+dbZ1X4; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+dbZ1X4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so7795ad.0
        for <damon@lists.linux.dev>; Tue, 23 Jun 2026 11:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782238237; cv=none;
        d=google.com; s=arc-20260327;
        b=KAvQGZii9AviFOKzFAOIO7aaN31lKNC4wYM5Wvp65NyHh9P6YSr7G3ncqoGMe/rDJs
         OeOm8vocHpghwt/53iN30XqSRV+o2l/DO5HjTp/c+OCFqFOkzdbAqUvJiHylvqRfU2tG
         /oMY3MeSYxIzRkQbyMFII0Dka7Em5NfOVHvzwRRxe11ysWf8HDexu/ZVn0qdLBY0T9fA
         RPvbSQhGJDhivP8x04XnRvyiU7jLSTUbV9OlkN9sJCTjB0r044mOXiDa5JrzrxvY6Z9X
         U0r/DDOeSPLInhhfhJM6Yn18qgCqo9COj65cvoJKQeQf5BFajts9zBma533CQSEsTKdd
         zRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PYUZIf/xO4ROpWjr/J8Svhai5QstrZTR0FAs3E0usJk=;
        fh=Fy/riBA8e29KqADpNTTx6PXenOR2Ajecq/y+xKEZJdQ=;
        b=FK7nL+F5fDJvklAoG62edUIewYyqL+nBdQ4jGOMcBc8JjAZ0YmlbV4ZfIjUtrDM3Gt
         G/9qTFdDcp00Zh7+bxck/N7ZsC4fEnaKVSMd2dr6yFWd+1Oe/E0TAckY8YWvNfZYB/JR
         ANGecX0w8inXH0zcg9I+F8/sPCSaN0FDq6bpW8ZdXt/aWxJTavsu2VHdMYmAkLp6nNGM
         NuOzmbR/Ux16iu7T9tNeRbiRFi+YtgVjEcq4v/fgoot2gm8974Fc9Awp8DM8cKROR1KY
         7G/0OV8il/7A42u3dBoJUGB8qtkD2Xi+2cZbVPLNb6Yl7E6eMYMdP5z1mmGv5RwxlHHj
         189A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782238237; x=1782843037; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PYUZIf/xO4ROpWjr/J8Svhai5QstrZTR0FAs3E0usJk=;
        b=p+dbZ1X4yidiXyGxfJySyudEg8irIXh8Sly+zyU4ZLuV8adTagB78LpxpbiVXKjBrt
         e1I/KS1UXJJFYT1XjUlJ079xtYoi59b5qhgxF7LfbImsR8e9qzqYkOI3yidj1L/hhYuK
         aA04ZGSZWJ4JEa4mEOPETe1O1EwujBVigQ4aMf6o76jgPOG+mokzDLcBm+gUqGL9sziz
         HbWytt3YAfsoao17ijFSx9gdq8J8FHJN5TGdyc3bVwbQotHnQBe7I4KyPG0rLWz1Sdz+
         Il4/O1NoDb8faU2Qle22luSNAcx/ZxnCNDsGDtmyXBLjTRo6A5gz6RE2hVLsCNjE6hgi
         HWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782238237; x=1782843037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PYUZIf/xO4ROpWjr/J8Svhai5QstrZTR0FAs3E0usJk=;
        b=ZEgRv0TseXbLNXJ6bW+ZynEb6K8bIoGb2gHotuIodXcEnkHriE+SZmudbYtx0CZVu7
         yn83sTwWA1dVcue9HodzTB7/exZPN7mvICZtPxfJYojOvcXWZtDfXj+y9UNVAnLieh0Q
         pPkO/3tN7qmtsEgv8zdCd8FltxRwpAYjV4zZCq1wLtPz3tScuvGP8gsH9kMabjb9Jvqa
         9GbM8yaeTxIr8AVRP8Jqw6qoPMQOGlup7fpd7Ov55bLPER3Us0yqDlqz8SC2ner0wwfK
         c5fMhWglbNWr7Ri6aihEZzZPcoCxHXnkA5Lw7zzq8x8uqarx9uNLXE5QRYbkDSj7CNBT
         qNIw==
X-Gm-Message-State: AOJu0Yz6116XjdbIgmlNZ1uByefYDPAfpKBE+0dPO5Iz+SIUGuKmgQ62
	J/YXwDxy9gNojTDO+1RD/fRyoePHPq7inqQQc+Ow7m9P0zhUHa/qcSvgt2uNA9ql2JwGp/H28C0
	iyN7581DD57yZWxD3BCzVrPcticsqWunsvjdfp6of
X-Gm-Gg: AfdE7cl+vl2ABDlvqYby+bfZzP4RfaNMQmzWEo7BvBSA8hlXuOCLb6eJ/ZDWfSBAUus
	55mzlX0oPjOuUE9QWVu7FZ526CWiEWzvVvHOkBIqN0M+hyNZgUom4Fx1bXHw5CAvJ3JecNhThFx
	bXtPfmaVFUYfsfff7VW0TyVjUGeBvRFyhJwB7Xlnwk+qrilhhXaVmUtJinQw3kt27mZ0BaVpzbT
	PaGgntgcBgl3YkVxyiSfdUnN6xvmh0jz4+moFRsrfoYgkjLF2XxqNMBEMGzhHWy53t2LYAA2w==
X-Received: by 2002:a17:903:2441:b0:2c7:ba0d:dd4b with SMTP id
 d9443c01a7336-2c7e0967b17mr198555ad.29.1782238236327; Tue, 23 Jun 2026
 11:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622134933.35773-1-akinobu.mita@gmail.com> <20260622134933.35773-2-akinobu.mita@gmail.com>
In-Reply-To: <20260622134933.35773-2-akinobu.mita@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jun 2026 11:10:25 -0700
X-Gm-Features: AVVi8CesPbUpGDhyVpDgdk0MbQUWRo8HG5p-Gvg90gzS8O1Ugf19-59vTEDO9Yw
Message-ID: <CAP-5=fVyAskTbcB-pJbcNChq8GJnQ_098EfsnZzcO7O9A-8x4g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] perf python: Add access to various members of evsel
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, sj@kernel.org, 
	ravis.opensrc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 6:57=E2=80=AFAM Akinobu Mita <akinobu.mita@gmail.co=
m> wrote:
>
> This change is necessary to specify the same PMU event selection as the
> 'perf record' -e option from DAMON's userspace tools.
>
> For example, a Python script like the following will allow you to obtain
> the values to be set in the type, config, config1, and config2 members of
> perf_event_attr by providing a symbolic event name.
>
> import perf
>
> if __name__ =3D=3D '__main__':
>     evlist =3D perf.parse_events("cpu/mem-loads,ldlat=3D30/P")
>     for evsel in evlist:
>         print(f"{evsel}: type=3D{evsel.type} config=3D{evsel.config}",
>               f"config1=3D{evsel.config1} config2=3D{evsel.config2}")
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Thanks Akinobu! I agree we should expose more parts of the evsel
through the perf python API. I refactored this area recently so that
we could better support perf.data file usage (the session API).
There's a long series here that is merged enough to mean these changes
will need a refactor too:
https://lore.kernel.org/lkml/20260419235911.2186050-1-irogers@google.com/
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n2449

The main change I made was avoiding copying evsels in the python API,
as it adds many complications, and switching to reference counting.
This means the Python `evsel` can no longer directly access inner
variables and now requires an indirection. So in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n2290
```
static PyObject *pyrf_evsel__get_attr_config(PyObject *self, void
*closure __maybe_unused)
{
struct pyrf_evsel *pevsel =3D (void *)self;

CHECK_INITIALIZED(pevsel->evsel, "evsel");

return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.config);
}
```
Note how it is `evsel->core` rather than `evsel.core` as it was before.

I believe you can copy-paste the code and tweak it for config1 and
config2, but I'm afraid the previous evsel_attr_member_def approach
won't work.

Thanks,
Ian

> ---
>  tools/perf/util/python.c | 50 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index cc1019d29a5d..3f108b405ee3 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1241,11 +1241,60 @@ static PyMemberDef pyrf_evsel__members[] =3D {
>         evsel_attr_member_def(sample_type, T_ULONGLONG, "attribute sample=
_type."),
>         evsel_attr_member_def(read_format, T_ULONGLONG, "attribute read_f=
ormat."),
>         evsel_attr_member_def(wakeup_events, T_UINT, "attribute wakeup_ev=
ents."),
> +       evsel_attr_member_def(config1, T_ULONGLONG, "attribute config1.")=
,
> +       evsel_attr_member_def(config2, T_ULONGLONG, "attribute config2.")=
,
>         { .name =3D NULL, },
>  };
>
>  static const char pyrf_evsel__doc[] =3D PyDoc_STR("perf event selector l=
ist object.");
>
> +static PyObject *pyrf_evsel__get_freq(struct pyrf_evsel *pevsel, void *c=
losure)
> +{
> +       return PyLong_FromLong(pevsel->evsel.core.attr.freq);
> +}
> +
> +static PyObject *pyrf_evsel__get_exclude_kernel(struct pyrf_evsel *pevse=
l,
> +                                               void *closure)
> +{
> +       return PyLong_FromLong(pevsel->evsel.core.attr.exclude_kernel);
> +}
> +
> +static PyObject *pyrf_evsel__get_exclude_hv(struct pyrf_evsel *pevsel,
> +                                           void *closure)
> +{
> +       return PyLong_FromLong(pevsel->evsel.core.attr.exclude_hv);
> +}
> +
> +static PyObject *pyrf_evsel__get_precise_ip(struct pyrf_evsel *pevsel,
> +                                           void *closure)
> +{
> +       return PyLong_FromLong(pevsel->evsel.core.attr.precise_ip);
> +}
> +
> +static PyGetSetDef pyrf_evsel__getset[] =3D {
> +       {
> +               .name   =3D "freq",
> +               .get    =3D (getter)pyrf_evsel__get_freq,
> +               .doc    =3D PyDoc_STR("freq"),
> +       },
> +       {
> +               .name   =3D "exclude_kernel",
> +               .get    =3D (getter)pyrf_evsel__get_exclude_kernel,
> +               .doc    =3D PyDoc_STR("exclude_kernel"),
> +       },
> +       {
> +               .name   =3D "exclude_hv",
> +               .get    =3D (getter)pyrf_evsel__get_exclude_hv,
> +               .doc    =3D PyDoc_STR("exclude_hv"),
> +       },
> +       {
> +               .name   =3D "precise_ip",
> +               .get    =3D (getter)pyrf_evsel__get_precise_ip,
> +               .doc    =3D PyDoc_STR("precise_ip"),
> +       },
> +       { .name =3D NULL, },
> +};
> +
>  static PyTypeObject pyrf_evsel__type =3D {
>         PyVarObject_HEAD_INIT(NULL, 0)
>         .tp_name        =3D "perf.evsel",
> @@ -1255,6 +1304,7 @@ static PyTypeObject pyrf_evsel__type =3D {
>         .tp_doc         =3D pyrf_evsel__doc,
>         .tp_members     =3D pyrf_evsel__members,
>         .tp_methods     =3D pyrf_evsel__methods,
> +       .tp_getset      =3D pyrf_evsel__getset,
>         .tp_init        =3D (initproc)pyrf_evsel__init,
>         .tp_str         =3D pyrf_evsel__str,
>         .tp_repr        =3D pyrf_evsel__str,
> --
> 2.43.0
>
>
