Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6A1AF4C1
	for <damon@lists.linux.dev>; Tue, 19 Aug 2025 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568336; cv=none; b=V9SrOSa/gU2b9rV8GEozZh7OIY4r8q4yWCqNAwcLdr7wADRU4J727mgYkMgJ9IoNYoSi8wC4NxubybrLoWfK91VvjGeBR4LwxY9LslBnoXOLzaAfrp9A5ZOJ0cLanAy7G5k2ueyYCnZRDhe305I/VKx6Sl3kM9EWIwA8YyWWi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568336; c=relaxed/simple;
	bh=6K63xJ77gojyLRxYONU1Uu4QuokgxEYFJ2TLa4Lum0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1O+5lEgMuERpsVR9KZZ9GlGCbZpaqFd7yiieJO9P3kXNs+e0QHgYGJDZI6MTuZxSpAHn4cFlAfbvMlm/1N+P6MHVlkBK5z31WU8FrdA0cdstzaowKlwnJWXJHJTOTGU8b6b9PyyNgU0uhV2Ul0P2Whk1tsUuwEMNrXrJ+op/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm/tusdd; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm/tusdd"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-743749537caso5058467a34.0
        for <damon@lists.linux.dev>; Mon, 18 Aug 2025 18:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755568334; x=1756173134; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy6uQBBJZOu90duUviYfM/tFuTR0b6VxvWeIO4FqXiA=;
        b=Tm/tusddzu3mkekz0XhTWy0RZNhSR6lPRn+eq9TcALjDaycc9/P4NFVX7h7OrXf0gl
         HLG7jXzoD60ug0NAHSMwpCYkCPSN9OMpQYEWvJ4BOPEBMoWvWKU40FVDbW6nJw3hBjWl
         dtpcLkITG482f+IKzcDDTpRYxVmDfRDJo0baucg15w/MCuju6P/IDkD0u628l8sVEwtQ
         WeEPwl12+HNtpO1ragn731AkxBT4n/itdA8jP20A/l4lpWIleqqxiX9Mk/ZtUGTQsDxO
         9+Q+tseCQG0zVXx57oTC17goyOku1JYHS0qqaJBJck+ee2TRALpUjrPFV45KUZUQrAml
         gHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755568334; x=1756173134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy6uQBBJZOu90duUviYfM/tFuTR0b6VxvWeIO4FqXiA=;
        b=Bge+ZlWB+Jz5t1R4214Ah8cPc1gyqPiUrzzeX99HTf8O8U6E5jYBO9dR3H0etWkpZ3
         +b4CQfSAoGFlaOPl84cVrPSPrv0zGYkFEyZ1Q2HWyiTZFtn50T8V14R+AILos5fxAIX3
         WodepkxOwDxst9XF5BhpFj4iq1CLgsBNVx2/EyagGC1w7ch8g7OHOFlPcFCOlo27K3Td
         vJP5qkKt0rPfr1KnP1n6zsQbPCY3wS4KjP/XgGFUzsxZolItevnVvIkb7elAe7QuEwRP
         Hm5t5qYh7DKbhJObf95MvUCJKKpLm8b3gompXbK+HwPyDR4t6QVwgK/7ibF5xE6ksYNw
         7t0w==
X-Forwarded-Encrypted: i=1; AJvYcCWM3KqAh9ZojfHP2TM0UcwATa3i7hDFmMY+7Xb2HzImRmDxoKjt5rMF690t73p7DnR7krL0tA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxeepuahii+H4NZ74c7pyJihsZruqaTEHedY+zlj3M4uanCeF2U
	rJ6blkC9BJPybF1QFHWZn/d+0bZpTBdcnS/x4G2HvgUrUkDn7E/foezklkd0v271kR1brcOS5kE
	OlPSBmqf3OOitgdcqr9BKVtCO53oBrD0=
X-Gm-Gg: ASbGnctpez96eWYxoJNgdaG+dy+p4tZMcYHzJaORvb7RwBnZMfGJ+bYKiIQgu4t97sN
	JxtwsHbsrLMPZMR1Hnj9k6hJiuyKi/Ix8fpl+qTPUjmuZs2aszhi3wgTt0ExkVENUCpQDnnadQM
	i0ffIX0CZ5RW5iUEPn257wo8eUAhzs4leT+E7RB4ppUgZBzBYcWOZE1LDzaL8UCI7Xi0YMt3cyd
	OYu
X-Google-Smtp-Source: AGHT+IG9GhsS9CQPc9TayGTtEA1ZqeFFdhPJkEk/ZWx2MRBkIosH2hvOMBt/2DyXIa8r0bBGSnUCZ0gKGrkCBDmvp28=
X-Received: by 2002:a05:6808:5086:b0:431:5a87:9c69 with SMTP id
 5614622812f47-43726627f49mr381384b6e.1.1755568334293; Mon, 18 Aug 2025
 18:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250818183803.1450539-1-ekffu200098@gmail.com> <20250818230145.4056-1-sj@kernel.org>
In-Reply-To: <20250818230145.4056-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 19 Aug 2025 10:52:02 +0900
X-Gm-Features: Ac12FXx-lHCpra_72VeklX3c1NYMJwWZcvBHmF-nFaASawfI22MuxutaIrrNiQk
Message-ID: <CABFDxMGRO_Mh-c1RvB3-SWAN2SJZK64qb==sOqb-MhtX56_E-Q@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: set initial quota->charged_from to INITIAL_JIFFIES
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, SeongJae

On Tue, Aug 19, 2025 at 8:01=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hello Sang-Heon,
>
> On Tue, 19 Aug 2025 03:38:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> > include/linux/jiffies.h
> >
> >  /*
> >   * Have the 32 bit jiffies value wrap 5 minutes after boot
> >   * so jiffies wrap bugs show up earlier.
> >   */
> >   #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> >
> > In 32bit system, if quota->charged_from is initialized to 0 as it now,
> > it will not adjust event if reset_interval_ms passes for the first 5
> > minutes.
>
> jiffies is unsigned.  Hence the initial invocation of time_after_eq() in
> damos_adjust_quota(), which is the only place reading quota->charged_from=
, will
> return 'true' and the quota adjustment would be done without delay, unles=
s the
> scheme apply interval is unrealistically big.

Yeah, jiffies is unsigned but to cover wraparound in 32bit,
`time_after_eq` casts intermediate value to signed value.

#define time_after_eq(a,b)    \
    (typecheck(unsigned long, a) && \
     typecheck(unsigned long, b) && \
     ((long)((a) - (b)) >=3D 0))

Here is an example with INITIAL_JIFFIES(HZ is assumed 1000); a =3D
INITIAL_JIFFIES =3D 0xFFFB6C20, b =3D charged_from + interval =3D 0 + 1000
(just assumed value) =3D 0x000003E8 and a-b =3D 0xFFFB6C20 - 0x00003E8 =3D
0xFFFB6838; (long)((a) - (b)) is interpreted negative value in 32 bit
system.

> In 32bit system, if quota->charged_from is initialized to 0 as it now,
> it will not adjust event if reset_interval_ms passes for the first 5
> minutes.

Also, you can easily reproduce the above situation on a 32bit system.
If my explanation is insufficient, please let me know. I'll try to
find another explanation.

> Please let me know if I'm missing something.
>
>
> Thanks,
> SJ
>
> [...]
