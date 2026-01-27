Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67324293C
	for <damon@lists.linux.dev>; Tue, 27 Jan 2026 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477406; cv=pass; b=Q5fyq3ZLqaGmuuSjchnHW6i8rU3rO3P/n/vjbnU7kLt7OsRo6P2NNmoAaZ5N/xRfgoKN5sk6L5pmCEK3+0/XYrxaX5QnRVS9e0+6TJI65uQRd2O+P8Dys+Q++Dw6aOy8fc5tGir3e9OIglWW0ZnR5B0v0ftg12a825jNv/Yb938=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477406; c=relaxed/simple;
	bh=wWU1Br1gMMbVBs8vjV5Fek1PDS28zAdpQL8VlZ3x8wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nbc9LvlBAi66N/ZsDmE5L9q8E/j8FTLUoMWc2L49K8Nf0kIVOLmZ44V4nZaSyHNBiH0Zr0ArdSFwFi+c6y+xeTIY+R1qVtSpwt/5QjvYOr+X46FqZZ/ocUl/XubmHIViC3voArF074nCk+FajleKn8w8tUB2mow0pDQYNGW5oPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCqIAf8o; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCqIAf8o"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5029af2b4bcso26645101cf.0
        for <damon@lists.linux.dev>; Mon, 26 Jan 2026 17:30:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769477404; cv=none;
        d=google.com; s=arc-20240605;
        b=NlrQJlbAlju+r9DROMZMC+Js0UYWMajoSY3f2/jyyPmM5CIiH4kjMzqsxW8t0RX7wk
         ShthJ4P2dMlQXoRJbTD9QUJkGovvpjA6adK+29HjwCQY6POduhC/0KhhUUxstULvI9Yg
         k0po/RnthfFq05EKvCe3jYhxFfMyePR3f2qJ5MajtZ7yTX8YfLUl2o7A80pRmuYh21nY
         8MO9NTd3IlEYQejAfp7BSZlsYo5N9Ple9LOmHjPvROjj7sj2AR6FFEDX1dFXWDHCUNwh
         8/PeGclRc8TlXwIJBOoZeH1Yy2LgfqCG6M5raVMOsH92aPS00R7t5OShv+re9Dx3aezE
         bhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AkdZUmq729C+/HHkLyC6q7PDD0Lq0uLxloB1AHeYPbw=;
        fh=LuNIxDwrU8tBU0lHgCDdCWufQL5TCnYVCcwzLcZSFis=;
        b=CMPh4CLPdoLQocTntGPwZmA8tjgP1NJ3nlVc6TC/ZKOj5dmCOfoj+8rnHLX7bDcx+X
         XqxnqVUx3LLTcUhYac1LWEEjPyy/tr0jfZfiwj2qJJKHHgj0uEqzYBS8EATHC1EeOtv+
         cmtBIjiwoQK6sdUuwegZQnFI8edjtIZC3WKDK1tXYDo70nhf/njKpyixHalNJSYR58j6
         GDRqTHTGBvsLXexDVobgIqHdQoXAuylMKpZFFFQhp1G05bDNnG4tENBAbMxklr9t9yRL
         8GK9PssPf6XfVNJzB7LNCQsTCBho8WwAGmz7zbttUoH6OVIIHd78AVRk5kHi++2g8Uuo
         vl8w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769477404; x=1770082204; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkdZUmq729C+/HHkLyC6q7PDD0Lq0uLxloB1AHeYPbw=;
        b=aCqIAf8oZRxCoW8nLtBvdgtssPECj0gybFMlj871RHGMgv8ePYROzv40nOCFsf/19Y
         8NPSfOxOTPbGtbqd7jbIjWQ0zmM1LrYsUI3/ehYKh1XWhGlhZO7fnMplYs6MYI5BVlHx
         cmll3dbs7tA9fQjkCCZ9pnN9F1fOsMuaCmQKoWVs/lNib18xKV7nYB8Z2z1+U9CMcetG
         z/EqXlVhVNmz9c5Yh0zMaBRjmz6PGu9OwPrC7ChHNnt7Qdc6GAch57aBTLRhX6xTTgRk
         TtBF+YpJKksPonMle0tNdfg20Tz7OMHCljzWtOLnI/HxjwotKh6DEVRrDoWhReDLzpTc
         eSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769477404; x=1770082204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AkdZUmq729C+/HHkLyC6q7PDD0Lq0uLxloB1AHeYPbw=;
        b=MKW8o9eo9XZP9w+7OLmACgdSKAbIcCcNLrsD/ls4njPXD16Arti39yB3BV6f7odXan
         dWhbMbzv1s/7n8rHTv0Sp4+mIv30V1wFSAAaA6wusDw2i0vxYaffaCTCCvXzsz612RAT
         OvEAn0WEuqj5RELjd9eD8j8fOe9EwpwL2eRPL04m/T6kP/tAxQGH1JrTq9FLuA1PL0+j
         xAaQRw7eB8GQ9dv7W372lf+EMfE3xC8tKhJbozbqRh9/aFTzhmfAEDTyU3skpRexSV86
         8RWTxY9qzJ0Wqwep2zro2PZcnra11Lmwn9XyU3XXemP7VhFa70Lg5BTWAyK+0Q9bWRfF
         +QoQ==
X-Gm-Message-State: AOJu0Yy//Azv7xVTuB6iqHhfCqmjckNlkpH5hDFoL40Wq0MbHtxzMtxJ
	vugP4ePT+kFX5u+XVMsTpFRnIDmSVKVKUwSWk0iIjNTha7cwyqrFxMhm8MfARwk40KAts963I+U
	zDkzRE1IqUYEZt2R04bKgtv7Tyvd+kiv9w8o24aQ=
X-Gm-Gg: AZuq6aKLJM7Ko5+b7dhHPpvhQ43Qn6eeuZcyqK7J6ysdJHyfMT3Gntyu0KVwZkiGVy2
	vAkGUu6afsZ7VJ8hdLjyp4lR3KGBsZ3Mo1DZ/Y4JX69oKT7W6fuLUjFQ5NC2n66p+ry3rPoEvvB
	zQeZ1G0yAcJgTQ3TMhYyeJ9jJV2KL64j5zm6eeP1GioI/bNuRzSRQdBemMDEY3idwC3SKC55hHV
	RS5g1EsQ2yYa6yONbnAxP3BQS6lHyEqu2qTXr5w4OagWHuYnkTDsmDVqBC9N+lsHMu4utm7lwxy
	e1E4liG3C4Q3A97+ujnpvKQ=
X-Received: by 2002:a05:622a:14cc:b0:4ed:b83f:78a3 with SMTP id
 d75a77b69052e-5032f9f1145mr789191cf.47.1769477403920; Mon, 26 Jan 2026
 17:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260123021014.26915-1-akinobu.mita@gmail.com> <20260124023917.78649-1-sj@kernel.org>
In-Reply-To: <20260124023917.78649-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 27 Jan 2026 10:29:53 +0900
X-Gm-Features: AZwV_Qg7dy6CPOpvJ44XedsxYFvuj5HF5GokewWVnrIi9S4TVnQwWjIprdK0fRE
Message-ID: <CAC5umyjmJE9SBqjbetZZecpY54bHpn2AvCGNv3aF6J=1cfoPXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=8824=E6=97=A5(=E5=9C=9F) 11:39 SeongJae Park <sj@kerne=
l.org>:
>
> On Fri, 23 Jan 2026 11:10:10 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > DAMON currently only provides PTE accessed-bit based access check, this
> > patch series adds a new perf event based access check.
>
> Very interesting patch series.  Thank you for sharing this Akinobu!
>
> I only took a glance on the patches, but my understanding is that this se=
ries
> modifies DAMON to be able to enable perf events of PERF_SAMPLE_ADDR type,=
 and
> utilize the sampled perf events in the perf events buffer as the source o=
f
> DAMON's access checks.  In more detail, I understand enabling PERF_SAMPLE=
_ADDR
> type perf events makes the perf events buffer filled with memory access e=
vent
> information with the access destination address.  The event will be sampl=
ed
> based on time (e.g., one access event per X milliseconds).  And probably =
that
> sample data could include more information includign the CPU and the proc=
ess
> that executing the sampled access?  Please correct me if I'm wrong and ad=
d more
> details I'm missing, as my understanding of perf event is very poor.

Your understanding is correct.

One thing to note is that you need to specify a PMU event that can
obtain the data address at the time of sampling.

In other words, it must be a PMU that can be used with "perf mem record".

> And one quick question.  Can this work on virtual machines?  I'm asking t=
his
> question the for following reason.  I'm actuaally working on a similar pr=
oject
> that extends DAMON for page fault based access events sampling [1].  The
> project aims to use page fault event rather than other h/w features such =
as AMD
> IBS or Intel PEBS, because my understanding is that such h/w features are=
 not
> available on virtual machines.

I haven't tried it on a virtual machine yet.
As mentioned above, if "perf mem record" works on a virtual machine,
you can specify its PMU, but it may not be supported at all.

> > Since perf event-based access checks do not require modifying the PTE
> > accessed-bit for pages representing each damon region, this patch serie=
s
> > also includes a feature that allows you to set upper and lower limits o=
n
> > the damon region size to enable access checks with finer granularity.
>
> I was also thinking about extending DAMON with AMD IBS or Intel PEBS like=
 h/w
> features for this kind of sub-page granularity access monitoring.  So thi=
s
> makes sense to me, and sounds useful!
>
> >
> > Using these features also requires modifications to damo, but these are
> > not included in this patch series and are currently under development i=
n
> > the following branch:
> >
> > https://github.com/mita/damo/tree/damo-perf-for-v3.1.0
> >
> > Any feedback or advice on the patch set would be greatly appreciated.
> >
> > Akinobu Mita (4):
> >   mm/damon/core: add common code for perf event based access check
> >   mm/damon/vaddr: support perf event based access check
> >   mm/damon/paddr: support perf event based access check
>
> I find your patches are introducing new infra code for this extension.  I=
t
> seems bit specialized for perf event only, though.  I'm concerned if futu=
re
> extension for another access check primitives cannot reuse the infra.
>
> My DAMON extension project [1] is for page fault based access monitoring,=
 but
> it also introduces a framework for general multiple access sampling primi=
tives.
> I'm wondering if perf event based extension can be implemented using the
> general acces ssampling primitives infra code, and if you already conside=
red
> that but found it is not feasible.

If such infrastructure code exists, I would like to use it, so I will
consider it.

> >   mm/damon: allow user to set min and max size of region
>
> The min size setup makes sense.  I understand the max size is for disabli=
ng the
> regions adjustment (merge/split) mechanism.  IOW, for fixed granularity
> monitoring.  Users can do that by setting min_nr_regions and max_nr_regio=
ns
> same [2], though.  So, max size setting seems not really needed.

Yes, if fixed granularity monitoring is possible then that is sufficient.

I have tried setting min_nr_regions and max_nr_regions to be the same.
I understand that the region split progresses over time and results
in fixed-granularity monitoring at the minimum region size, but since
my configuration has a relatively long sampling interval, it takes
time to reach that state.

So in the patch, when adding a new region with damon_set_regions(),
it will be split by the maximum region size.

> Again, great RFC patch series, thank you for sharing!  I'm looking forwar=
d to
> your answers to above high level questions and comments.

Thank you so much for checking out the patch.
