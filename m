Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96AA2A1BF
	for <damon@lists.linux.dev>; Sat, 16 Aug 2025 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755307855; cv=none; b=gYA8EWqZ6zMWScEOeb95xb2893ZMSepFmUZ1uPyIbsNXiOOsVFdUVrZnKXAiSXZTnwiXi3ucqCxW9jPc0w3cGK+GjtrZa+cZf3f2NV6ifV+LiseA8X6s8IrNcqhul0/Gn4PqBsvlqSkXy26mT4ZgJl1ps8LZhvf4IIpZFWJ8SrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755307855; c=relaxed/simple;
	bh=pQWtgI8U7BAMILhy6LTh4M+Q6fGS0HdlrLeznBw1Xfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WO5N75fPU2PjUYyP1BTQdTeS/7GdKoKQCYpVkPQ5nFeDXaggGVkQZxhxufb+6sXcoygHl+Z9JRPW3ghV5pEgq/rQr3ILEJtcL45IoT24x1jZqfm7OqJQ8zr5WblkIlCSgarQGLRPOorcdbAVVPM18ftLstMgCx2aGkoe+mupk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuUd7loQ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuUd7loQ"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30ccea8f43cso1898817fac.1
        for <damon@lists.linux.dev>; Fri, 15 Aug 2025 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755307853; x=1755912653; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/CwBn+YcCO6JV4jisWik5fIvA0H3kWFj1sB20Yoeko=;
        b=OuUd7loQLx7O6cPkOFsrUX1gthq64yGaMC20YwObasXghh/vlYHYT4ixHj/2XbHmy9
         mt/TCydfBWEwkdv2KF+z9SeiC5f7d7XZHTQj0qFpQUIOBh83K0SF0Xfb+a7PnG0Bcm10
         DbmcogKjdrMRtDuOnr/X4Z9YbSPAmZXfGxmk2yGOdom2F2N6DRe73ULVN8Y78RWP2k3q
         i4oP8jhb+dgP+6HAqcBlWULk5y0qxXdb5qBa0OXKlmXnvUkR6IoiZ/l1JNOn2HAdVshP
         mHma1VMYwPfMRZjktgyiDJ8qmqoLnYXgLcDWEAY/bASFkPC6jBnuLchEelhiaSKklCpS
         MIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755307853; x=1755912653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/CwBn+YcCO6JV4jisWik5fIvA0H3kWFj1sB20Yoeko=;
        b=Qxn+1l3a/5AQVStsmsfn2hXNMLOyTb6De55SsP8EDXLaWv6McEPLZ0riZCaQzLCnxB
         EYXUZRRAJji12iEvmTt6io+bgyZgbieyHufhKmAPkZfWHsPFyzAdZ+CV5aiB3ulTb7F2
         rUG6IqJH+k7dniTuOsqF4PS50BwiYqDWPQS3MwY3DpNcDd4o0Hu5qlD79DUJok739sFE
         rcgiseTdn/ImdcMvlnXU6c3isLI6KQ6uFk22dhVCJQj8yK1ku7G+bpLy0IZJ5jYuWYeh
         g/qF8IgKrk0T9/Ubgz5fwOfGZ6+3tk7R3mskzXn29itgz9pDtQ0YnKlr5GBO7zejWyyn
         UgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpBt0/t1ShhwYeey9FpBtSytUqOZni9nquvUvrEUZKvbgJ4+nKekITVSS4pESZVVh+1jE0LA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWmTpn1rRAmSZjlnkxg0uzgqOtZN98MDzcBi+e00bwRAqNJLEJ
	raz+d1nxbveZlU5V03DCYHO61FYW2Cjia8/DOKUdH3FxynLCLQ5vpw8sEoXNqiicMSq0lQQvTeb
	Jq3AJeEdfb/zUhUJnxLq6Bl7YGzbJ7V8=
X-Gm-Gg: ASbGncsPF/6aGViR4uTQc+wzEqu35M7y5hUJqggDgPSEEmN7JE1UCWfJhTlLvFOfcND
	st4///0p1lZTGgflCtFmvF4dbZJq+GXKIQit/Juu7LZw7MPXkNxDQZNgAUuxytXHmEGUbiEy88x
	uAKvqaR6komeXyVzGY6qH2NeMkC48MmvIYkkRErFFD0fRsHS9VdvzUkKp6TapIxBg0Hrq/RIwkZ
	MVS
X-Google-Smtp-Source: AGHT+IFTL4O6BM7sru0nNSKWfEL5peva6qbLK5rXN51+T2LoeUfhLq7TftPFhhVyDrpMjVJ/Rgpuz3PQzRnrnzVW6EM=
X-Received: by 2002:a05:6870:4207:b0:30b:9a9c:72 with SMTP id
 586e51a60fabf-310a8fdfde0mr2870218fac.0.1755307852845; Fri, 15 Aug 2025
 18:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250815094029.133063-1-ekffu200098@gmail.com> <20250815170948.16297-1-sj@kernel.org>
In-Reply-To: <20250815170948.16297-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 16 Aug 2025 10:30:40 +0900
X-Gm-Features: Ac12FXyE1zepZtOUbqgmIaJ_8ZeEVtEiL0AQlMufTTlh0_lT6WJNYTC5ksCGeLI
Message-ID: <CABFDxMG+3trM45T_1L0_dv0ibQC2j_XXCeGEwY5RR8a8HZmoYQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/damon: change wrong json.dump usage to json.dumps
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 2:09=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Fri, 15 Aug 2025 18:40:29 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > To print drgn status to stdout json.dumps should be used without
> > json.dump. Change incorrect function call by typo.
> >
> > Fixes: 441f487d6ebf ("selftests/damon: test no-op commit broke DAMON st=
atus")
>
> Seems the fixee commit is on mm-unstable now.  Since this commit ids on t=
he
> tree is unreliable, I usually add a comment, like below.
>
>     Fixes: 441f487d6ebf ("selftests/damon: test no-op commit broke DAMON =
status") # mm-unstable

I'll keep it my mind.

> Also, add the destination branch on patch subject prefix, like,
>
>     [PATCH mm-unstable] selftests/damon: change wrong json.dump usage to =
json.dumps
>
> These are only my personal and undocumented conventions.  I'm not sure if=
 this
> helps others, but it would help me.  Please consider using these conventi=
ons
> for DAMON patches in future.  I'll document this on DAMON maintainer-prof=
ile
> document.

Sure, I'll follow your convention. Maybe If I don't follow, it just
means that I couldn't understand your comment and future document
well, haha.

> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> > ---
> > First I'm sorry that make you guys work twice. This is fix of my last
> > patch [1]. I'll be more careful next time.
> >
> > [1] https://lore.kernel.org/damon/20250810124354.16456-1-ekffu200098@gm=
ail.com/
>
> Thank you for clarifying the context.
>

The pleasure is mine.

> Thanks,
> SJ
>
> [...]

Best Regards.
Sang-Heon Jeon
