Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C262F12C6
	for <damon@lists.linux.dev>; Wed, 25 Feb 2026 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044123; cv=pass; b=LkUj7pDjFM3XTAtME7ACb9bjZzt81cpDtKz10iwrpdyOBAvJRml3t4t/bSiG3pIGCKSVaqiKSfdSGrWy4QinN7iHxHVKPzi5a6HG7LwLvkxhWlSSqe82bgwL2ERBVaDHlbx+nU8DPL4dyIfNM/CY/d8XqBZu+9+AtoJoSIRGfnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044123; c=relaxed/simple;
	bh=7F2jVLV2QcUTyy7TAzNWNIYvIdo/cqTKdGiIvRmLNW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFsCRHV8nwTqXMrLM9pMoMqKbV8p/xVbgq8l7Vs1iNr1LIvADxD2xOA885u2bdo9H5FcGi5VX1jdwAxrG/KPA7vkbLgM9i9Ibh+QdqV01kF0nidN8svkiEsc+S4VvdsoCuZ09tW0Rzbt1ALvRCrpqDJub1o4p35MCKkkqNomWhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lepimerw; arc=pass smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lepimerw"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1277e072e2dso638877c88.0
        for <damon@lists.linux.dev>; Wed, 25 Feb 2026 10:28:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772044121; cv=none;
        d=google.com; s=arc-20240605;
        b=Eglm1tYc0SZGx9uA+iG3cD+KVYtBqo5CGyqWdFIS1LafuQnaSqbCtMBHMwj00HQT4L
         X7NiuiWsYFG215k1kZOURUIfjyKlHKgqajM9hy/eBvCEwFe4lHo/enRasAAeNzyZeBuj
         MgdVFYj8E3ybFPCpJXeoNJ+4i+3YcFpj7QXdJlVABgn3VHKMgLQRMXoXCtB5oa+sL8Qw
         zwXI+egH+QH2Q0pBxkV0rYX0O4lXwxLZdM/RnyczCgfbOCBN5VK9U1MyB0wDijyTr+Tg
         T9Wig03NMlcdqxRKSKfG8tm4YZfccSObSCx7SNGXHm4fFQYTtv37x8yiyWCJTlRk8YZr
         pBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b+vs7qWH/PosxazHRVXXbHEySPzv3IencMxP7YmTfGQ=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=NcW6kukE/K/86rLpMJYllVx3M55c9tSmlXb2ANoXbG5NuRJnOnAlajKNTXqie5LzJh
         RCjKPOMkoTpIMzuv8lHiTE5amM+DDsztJKwNG1+Wo+BAHp1+sNB2V7xfYnf8G3BcTnlL
         d5kl2DO09knEAQjuIWBJp9fAjtPcZY2y2mVdNsVrDOGHYWu9olDbg78MrB3Way9Avrgb
         8mRg9Lj4i4OiSaB9as+awC/h4oREC2qQrHwR6fJnxWe1/hH1voRTlpruUOCh+uj7OJUa
         l+QiUOSC9n7WwaEZ6BfVOeWeYLFmsWKsTdYdwpcsQ5SeDIrXwpoUnshxtbgLkrV+Htu4
         wBVA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044121; x=1772648921; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+vs7qWH/PosxazHRVXXbHEySPzv3IencMxP7YmTfGQ=;
        b=LepimerwKaAldBoRxguXaVZivOMV3cqmXMJwERlwR1i9/7ljOCK6wEzgfDnquDs6bF
         2aORhHKCbrD9nv4DoeD7hVdoYTjF7L96EYyGgRKz4m/ZxvhKMoYeN3tQ0Kq3jF7GneWR
         Qai5fV5VJyT+kT6HXuUqcvmSaRUyFPIMRgYqxpbT/oYvF8PxtL72+GlwMTFgSI7+MiHX
         7JKoTh1sKCmEM+ZkAyi/RCu6yxdEFBK8N4cGFUL9vtb/XFZQ6ec3jR3/V/ZEE8S3fi2s
         pO5Mw1VeWrce+DrAoxvOxHbGw2HoympK8dke5DnNsl99O6Eenw2Lp0bw1gjKGJBxOv0F
         ZlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044121; x=1772648921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+vs7qWH/PosxazHRVXXbHEySPzv3IencMxP7YmTfGQ=;
        b=a+GbccU5mXDrd8zFgQLHzr0lleA5pdcvKSiq5QVike+o8TglPZncUo1hFaSRvOgazX
         DbpeidZcgtTFaeAcQzhm0BbvDQMqM5sDDk+69ao/ji8cGh72dLLJ8yWygn6lfww6svbG
         dDoWCV9M3TInUyzOZQY3FEeZrOPUJebwBk3he6BlKpJgc/DqA4z5h6WbrMayJM2m+EJ5
         oKuh+zJ/MIFQ6YBXUp8x93D0Ar+E+NAHI/hvjsz6CRPmQ6qRLrm657Kr5buCZpc9GNq4
         jgKjxxx4p7AefsMIBBzYomZnnTTaKSFtVgxkNziKggBFcDxiqCN4dwusY0EEmaUCBQkM
         GSvg==
X-Gm-Message-State: AOJu0YxO9omfMyrsKqAy0u/8uDmBFVJblGs6+Q9OOBZDZHIFnVdb6yD5
	Hu9FtR1/uqUcUgkYF3TInx6+29TK3b2sZwmeMfI4tJpFSDuk1sk3atUlLwRZollRVsvOx/2FQNl
	klKyHI4ylgNGwH3KCZrp3Fi7p9JVpUQ==
X-Gm-Gg: ATEYQzxoV/8ugehXTD3aKKoajJHg3YIGUqwLtPuNaPKBXFRw08p3f/JJzBJwcEFmXQs
	hbwAjIcBL7DTom8ALWEXvrGJawnyl6a993QtcuyjO2eud8d33vSrZTIWRK92C7aBAB5RIOo9zd3
	5M7gR/DzWHpKmEUrKUrcJRnqCwJMZqeB5XCj82SY0kP9TBM6pw4HhZCbATjmysmsSskHMmTLLsL
	HyMgVB9FapjnssY1E89rWkDmTIIn12Tr4ERVNAe+HAmra8yQtKcOayUZGdTI6KVw7VDJK01JNqf
	6E5uNvI=
X-Received: by 2002:a05:7022:322:b0:11b:a8e3:847b with SMTP id
 a92af1059eb24-12789062f85mr18156c88.5.1772044121482; Wed, 25 Feb 2026
 10:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260223123232.12851-3-ravis.opensrc@gmail.com> <20260224015453.56879-1-sj@kernel.org>
In-Reply-To: <20260224015453.56879-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 25 Feb 2026 10:28:30 -0800
X-Gm-Features: AaiRm53PZ7CQTO2nNmE87UPyau54sbWlAb_SIOGk1iCbJaNIOH0-q30nKNVvXfw
Message-ID: <CALa+Y15BbvgKttRRxrNrr38y3Pt4A+MP8tfQZZ7LVyoUS+_0fQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/4] mm/damon: fix esz=0 quota bypass allowing
 unlimited migration
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 5:54=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Mon, 23 Feb 2026 12:32:30 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > When the TEMPORAL goal tuner sets esz_bp=3D0 to signal that a goal has
> > been achieved, the quota check was not actually stopping migration.
> >
> > The condition:
> >     if (quota->esz && quota->charged_sz >=3D quota->esz)
> >
> > When esz=3D0, this evaluates to (false && ...) =3D false, so the contin=
ue
> > is never executed and migration proceeds without limit.
>
> Nice finding, thank you for sharing this!

Thanks!

>
> >
> > Change the logic to:
> >     if (!quota->esz || quota->charged_sz >=3D quota->esz)
> >
> > Now when esz=3D0, (!0 =3D true) causes the continue to execute, properl=
y
> > stopping migration when the goal is achieved.
>
> But this code is written in the way because the current code assumes zero=
 'esz'
> means it is not being used and therefore be ignored.  This change should =
be ok
> for your use case, but could introduce an unexpected behavioral change fo=
r
> other users.
>
> One easy workaround would be setting esz_bp with a value smaller than 409=
60000
> instead of 0.  That is, esz_bp is the bytes in bp, so setting it smaller =
than
> 40960000 will result in making it effectively zero, e.g., like below.
>
> '''
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2623,7 +2623,7 @@ static void damos_goal_tune_esz_bp_temporal(struct =
damos_quota *quota)
>         unsigned long score =3D damos_quota_score(quota);
>
>         if (score >=3D 10000)
> -               quota->esz_bp =3D 0;
> +               quota->esz_bp =3D 10000;
>         else if (quota->sz)
>                 quota->esz_bp =3D quota->sz * 10000;
>         else
> '''
>
> But maybe there is a better way to cleanly fix this.  Let me take a time =
to
> think more...
>

I understand. Please take your time. I'm happy to test whatever approach
you come up with.

>
> Thanks,
> SJ
>
> [...]
