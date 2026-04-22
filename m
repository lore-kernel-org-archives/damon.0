Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7F1DFF0
	for <damon@lists.linux.dev>; Wed, 22 Apr 2026 04:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776832315; cv=pass; b=W9hzFHDZMrCYVtye3fjoRQgnPMLQl2nTcXwxZnVM4OgSRL8HWQPutiIlGoG5vYa5XBk6JWW+C/Sl9jNeBsD7jQvD9qludIu7XwVThnrM/c804rXlBiCtGDQxJMOIqXCFq33H0Pi0IcRVE8+ZMMtZAFB+cErZ7X1nduyfnFP+Pv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776832315; c=relaxed/simple;
	bh=/MfMMgmG6js11kCMFFcl1O1cZNr3pzYMwCZo5M2TubE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9Aw88rZUk+xsrB8Imm3k4vGZaVazt9cxKnRhYJ+y/yGmEV3AH8jLQtfPcDjddQdBhc520GUhLzHy8PbvOPKk/GOGyuVO8PNIYK/1dmwrrzrvtgmVaogKkns1kj0UC/Mb4RuhjdazOAoVKSgcNfh+dgJGzQpuigvyF6MYV9YWgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVn8oLo9; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVn8oLo9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f69a286dbso3897667b3a.2
        for <damon@lists.linux.dev>; Tue, 21 Apr 2026 21:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776832314; cv=none;
        d=google.com; s=arc-20240605;
        b=JuH2CVi8NrWf4zSB1v9wxyAH5fnE0uDYb5tl7hGSLTN0Cg4j3BGxiK23eBcLt5a7ZH
         OPopLqv7WpXBJWk1cqhng9JXnwBwVwrarRlczng4SsP+CmpYDAluJSwYxEwiUvEhiuqz
         7D56gOiD4pEdBWBYG10JsZCxL4Vp+Kv9tm9PrmmzjRRjGv+UU2F+J4Kwh9FWrcmB4ECM
         YF2YbdCO3MF34JLaMxdJmQnXqhPS8fmWGnyzk4TqPPmnv2v6vdvwQBaF3VNlPAj2lKLW
         EgQpzUxWHC13Gp29xOtOtl1Tv12qPZmGWHx7kjpPYCgvh1lhggCG1C7Ot20GJxrS6OmA
         Ki9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pKpbukl/csWxCpNtEhbFAtgYuBh9hrYOWhmgDtMm0XI=;
        fh=R7suOjqei5m2m1b6lVdPEIOEqNVEGFs/D5AyAe3eXZk=;
        b=ZTTgg/UpPBjOGw4i61VeeltGQR0ehhUjlmMAEgtk2d+x/2mjMOhBCnr97wx2FrX20z
         paQX/2dMCQCWnuCFalGlYsGk5p6bMlGGwYEz6rWC77axmVZfNSwL3DYQBPGQHfiJWl2L
         u7hN5Jg9MouW78L6tLsKLRuj3jLcB/lY3tOIwY+h+uygpWubOMAdeevTKoP90URKR0EE
         1tss1n8yqnQVaFSHw0Q4IgXjNjuRoeW+LQMmfVS5X3hBG6g2ff6i0UcOKXRITeC6mV4S
         GfglirXTBC6TtYi/dX4ed5uWH2QZAu72Ixd+zVlFjTJ/43zy98XH0mKD/XBhMOniHV4o
         9Eqw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776832314; x=1777437114; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKpbukl/csWxCpNtEhbFAtgYuBh9hrYOWhmgDtMm0XI=;
        b=gVn8oLo9H81BzHGcWnbisL7+q108lcknrOteupUnqwsYCDJ/hTRCotTptUMdAmTHm1
         A5q/vEEnG3HMnSPFPWhsP35TRzLRjyTmekwtlJ2EYXYnuQwk3e1Tky64r/LyI2CAdfiN
         ZyOMFj5pj5RL4BqYd+EhMyZxeTbHT1pMTAX3DFEty6FsfP03Ow7pgulzxkCdGfOns+fC
         qdybnFeEfuaJ+oACIcjHJCK7260mbD8kAPfoEjCDwpXYWQslbdYQOp8kwmwkO+X3R8Hx
         MQcd/ouE3xyjXhUYJSvKxq6HcYtftWojCjzJeqFHOCHP7BWyuN6Mmm7v+nyhtPUoxkgo
         6n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776832314; x=1777437114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pKpbukl/csWxCpNtEhbFAtgYuBh9hrYOWhmgDtMm0XI=;
        b=da4iyAMr0oWpW1xM/Cm53Xv0fi0tRTlFvZt6SMJfOMbnNDJUo82CqkTzMU7Gqr0//w
         KBc6q73FdUXDOoJWwTdRYkIIWCKrogp/dfat401rxSdZOKwS6qZo8hNGFkfxtu49VAfz
         pOMqWdacPNLNPJKN0z6CWl/nSJI5jD+4py44Uqn3WsZvCtaIHK5q2ENYvuaTMs8hU7HH
         4WG7fsZsBiO2TuZLe/V1V5GeCia32j3xPShzhJt+7l9n8cniyfMwbDPsJVHNhwLlk6HA
         VnJXH30KLLRSXtXHGVGHmYAPVjZRL2cfEQ3YfbZ+DDq8bxfUNatMP1r9pQZZCk08lUvF
         8qBw==
X-Forwarded-Encrypted: i=1; AFNElJ+V5oYXcfdiPBnfuqn4HeUR3IRdEM52eLIuMNY3NhIoqPkVBfZwIks6RJunzL/M1fbhWSdibw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzA9XZ2HQO7KnfBpWKejWGpC8wPbx9p1ozvYKVc4KViSFTcFgNE
	SVs0ccr2siTYf3wexUr+Zx6CJx+H7VBFctB1kmYf8e9KitYUPSvtY4ijS0hCyU0zA+BQbwzoqVl
	M4EKGVldmXy4+N3xOGgdZUYEiDt5k02A=
X-Gm-Gg: AeBDievV3CugO7YUa5dxcj98y2dXB1yLb4UYX2/c9QJ0+wrkJIgGtWRCUW4IVm7T6uy
	Q/RscIzelfnWPp4vkdAAW5s/QhzpqQXCnA/XUpUqHMZ1tkQt6sIy34pxqSsAAIzxPSO/S9+vys3
	sJclODMNOfg0Ak39klXEO49Ay+WFtf+YUjKdGXdR0eIK2PK8pDw6z3bdB1yTikEXRjtUVpWs1jq
	ambd15eWa7lWFcVfaaAqgRYCmfu0THS9sglvmJlIRgJFTpH/j8o+bZcV3+5toGXlgGF4JTi1ht5
	b82G7l4U6JpdBYlxQC8=
X-Received: by 2002:a05:6a00:80c6:b0:82f:8e9f:bdd5 with SMTP id
 d2e1a72fcca58-82f8e9fc333mr16084294b3a.1.1776832313733; Tue, 21 Apr 2026
 21:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260421070632.161808-1-qjx1298677004@gmail.com> <20260421234730.2917-1-sj@kernel.org>
In-Reply-To: <20260421234730.2917-1-sj@kernel.org>
From: junxi qian <qjx1298677004@gmail.com>
Date: Wed, 22 Apr 2026 12:31:43 +0800
X-Gm-Features: AQROBzAIFaiXid7kxspoe9kHcMj4Dl65yuqKyQFsVGoaGj2cu0HUaj3kNW0odis
Message-ID: <CAAkLyHRCUS7=YEQRrLyRXX5X10pHDGA1e2gnKQsLvGkcqUy2Ng@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix use-after-free on memcg_path
 and goal path
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SJ,

Thank you for the suggestion and for offering to help.

It would be great if you could finish the remaining work. Please feel
free to add my Co-developed-by: and Signed-off-by: tags.

Thanks,
Junxi

On Wed, Apr 22, 2026 at 7:47=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Tue, 21 Apr 2026 15:06:32 +0800 Junxi Qian <qjx1298677004@gmail.com> w=
rote:
>
> > Hi SJ,
> >
> > Thanks for the suggestion.
> >
> > I checked the show/store race further and was able to reproduce the
> > memcg_path_show() side issue on a KASAN kernel.
>
> Thank you for sharing this, Jinxi!
>
> [...]
> > I will spend some time thinking about how to fix this properly.
> >
> > If someone more familiar with this code would like to work on the fix
> > directly, that would be greatly appreciated, as I am not very familiar
> > with this part of the code yet.
>
> I think you could protect the memcg_path and path load/store() parts with=
 the
> damon_sysfs_lock, but using mutex_trylock() instead of mutex_lock(), as I
> suggested.  If you prefer me to finish the remaining work, please feel fr=
ee to
> let me know.  If that's the case, I will work on the fix while adding
> Co-developed-by: and Signed-off-by: tags of you on the fix, if you don't =
mind.
>
>
> Thanks,
> SJ
>
> [...]
