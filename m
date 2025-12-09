Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A2B640
	for <damon@lists.linux.dev>; Tue,  9 Dec 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282856; cv=none; b=auRs3HE+DaVPw+v0/lQaXSU8+EkQiqVzY8DCymfKKyM9W9y5t8D+U8DMXHV+AiqO7NjXGy54MvO2d8/mQ8wOZDju9X6IYFK1ym5A6I74NtL/y3lVR31Blf6OEDzcO6MYDt5ZMLpYowP463xawTq9ZW7IA8npmZC7mJ3tTlNNJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282856; c=relaxed/simple;
	bh=6/XzLC5xQ7qjV+MI0HW10BmFLLIdWlZ5rSh5/pBkqU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbZmVETxnNkmE1mBwMqH0BnPLtfHr2HXVcW6/3J8ctMWS5zDvSV9cDiXdobeLnuHMRI6D7o6MDrb0C5tko/qRlnfT5EbZwO2HG68+j/wZhxYd/Uo+NboKWa0M1cU0R/5iQ3yNM0w5yNCn2dBIV/3cxpLYEZ8QG1DmDusdzYwV6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAFVDCHh; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAFVDCHh"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7881b67da53so50211647b3.1
        for <damon@lists.linux.dev>; Tue, 09 Dec 2025 04:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765282854; x=1765887654; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XZJ/q2HbA4FuEYRTrl5RlRoMHzWJPZwJ2pv4mVX9pX8=;
        b=QAFVDCHhh+7/qsMESW+ksfJXOUeOxs8j8khzJluGk4ZGmt+CycxTL1UF7xDtHPx08l
         yd8FAQ4c2qzdXR+1hxSBMAcORlv2WwUKnN4LcaMgKuVACX6Pmj5i+ceDhO/+cP8t/WjM
         BAFGsGPezCdtxCaJxBYBbl5VziRYtcpNbiLgJy1DGVMSMHCYOrObunQ7dB74k909yYFw
         CyeUJC0SCLG5l9rIGF/HYy7onX4APPSR80c6YsOr60t2zAuhMSyn0AEFMMOSEYkuzDW/
         RGSf2DHDvKcaTPdq5OtUpoH9vmZAFvtyvs3mw/Ppvx9rFjGQJ4Q81J2uwADNjr/t0hny
         KWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765282854; x=1765887654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZJ/q2HbA4FuEYRTrl5RlRoMHzWJPZwJ2pv4mVX9pX8=;
        b=WwWpwty1r+1tSUEkVqgjF/pjHacaT4afHMMPFB3ftM1A1uNpyMUsSFiim0lYDVgDo9
         lcgwMELce01JxuGHsLO+1F9PmF1wbgLpTYxozQ9jqRUNcMImzDxiSj+xXn1h4X8JnZAa
         q3Mn9uzf8L+qTkJ034lDxxAJJY1lLCbrugr1E/cnxri1RoV6A0Bee5xt2EvD9FN1BBnp
         4Za/UGJeSFGK3KvtR5C9EYQlZ2mPf+IIiwaAzf0RlY3KVZgVgtetUuqLiTZXqdfP6wJn
         RhBjGg58VFALPgEbqWJTN0YsO7UIxnoqqkA1LhcMoxFtOtoM1AOUxU7bQgs3y2EQxO0Y
         j75Q==
X-Gm-Message-State: AOJu0YwCD1nHS45wY58x1No99ajNJX6GwjtMLP+FkpAUjWowzd8HQtAD
	XsS3mujSDkGBJxQVXbuI+rd7tsHd7adXEs3Ux81QtYGW/x4pdQ4m/Xcyhk8gJqaGTnj99QkIf/S
	kjk68QQuKmaaZiZEh0HwE5jiGWs2ZKm8=
X-Gm-Gg: AY/fxX7ob+KUZ/EZ18nOe2/im8N6y4TqvVnlwNMZ3GDJmH4B/EZa7Ea0eqf3HjpTRta
	lwRGsR7JAFSKF6D1uDD0vNNSTnVZwOYeV7HF9rZHPZIXuf8a3lp6hSYx95BmTso3LN8YBXO/vAO
	JfYVAAk42Pyd2l0SkKz5ImfCGwoNvcrLwM97kEStteJX3eqbnOyrEsYkPVmzkfCTK4qeU+NZMp6
	vs1tkK0XrM2ty58ZpsyR7rWxMpD60t+VrVd6xBM6NuSzXIk+RVbybfYNTkfuWM91k7nsiLy
X-Google-Smtp-Source: AGHT+IF4qVNyyFQhAQ44HrKZTO+BDYWue2tjOtQ0ldbioOqiAYBKibcU6XKIYYlyd1/TpiMhH9iPXpGu0w3y1arhMa0=
X-Received: by 2002:a05:690c:22c2:b0:788:bd8:673 with SMTP id
 00721157ae682-78c33c16394mr103464237b3.44.1765282854027; Tue, 09 Dec 2025
 04:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251206224724.13832-1-rgbi3307@gmail.com> <20251207023625.44177-1-sj@kernel.org>
In-Reply-To: <20251207023625.44177-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Tue, 9 Dec 2025 21:20:42 +0900
X-Gm-Features: AQt7F2q9hsT8FOu7rr45aQ_Azbmj4EMMy0e-8Rt-6hhhTyywnYIFfVlP3APSEdA
Message-ID: <CAHOvCC6_-h1jQkZMbtYDC_jrB490jzp1t1Fx-_mhYnE7tqvzbw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hello, SeongJae,

Thank you for your detailed feedback.
My patch has the advantage of removing the use of
the damon_call_control.dealloc_on_cancel variable.
Other than that, I agree with you pointed out.
It's not a patch that significantly improves functionality,
so I'm fine with doing whatever you decide.

Thanks,
JaeJoon

On Sun, 7 Dec 2025 at 11:36, SeongJae Park <sj@kernel.org> wrote:
>
> On Sun,  7 Dec 2025 07:47:23 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > The damon_call_control structure is used by all damon modules.
> > In mm/damon/sysfs.c, it is dynamically allocated with kmalloc(),
>
> It is only for refresh_ms handling damon_call_control.
> damon_sysfs_damon_call() doesn't use kmalloc().
>
> > and in
> > the remaining modules, it is statically coded.
>
> I try not to use dynamic allocation when possible and *reasonable*, since doing
> so eliminates the chances of bugs from dynamic allocation handling mistakes.
>
> > There are many daemon
> > modules and they are designed to be used only when needed.  It is more
> > efficient to use kmalloc dynamically whenever needed as in damon/sysfs.c.
>
> I agree that is more efficient in terms of kernel size.  Nevertheless, I don't
> think it is a significant improvement, since it is only single data structure
> per the DAMON module.  The total number of DAMON modules is only five.  Two
> among those are samples.
>
> > Using damon_call_control dynamically and consistently has the advantage of
> > eliminating the dealloc_on_cancel member variable condition and reducing
> > code size.
>
> Disadvantage of this change is that it is adding four more dynamic allocations
> that we need to cautiously maintain.  It is not significantly increasing the
> maintenance overhead.  But, the advantage (kernel size reduction) also seems
> only modest, if I'm not wrong.
>
> So I'm sadly have to say I don't think this change is really needed.
>
> Please let me know if I'm missing something, though.
>
>
> Thanks,
> SJ
>
> [...]
