Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2AF48AE00
	for <damon@lists.linux.dev>; Thu, 11 Jun 2026 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210224; cv=pass; b=AduT/bN2Fx63v1FjvcYH8gIavEawWOgch50c1xmog6l1U4Hc4QerW5XPDDCv42a3AlRFGcuudHdxqL+mvfIwzdJ25ETDM+P/pXJYms+ZRRiNO+8CCNZeAhsu7fdxojQP+XApcJawBUHCKOU5BelHX+2CJApZN5195Brt44b88L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210224; c=relaxed/simple;
	bh=K58UcHo+B3aFwDsgem6xE8uiuWZd8lb+WbYUU9ocaqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt5iUbmYv6XIa8cP8l/6riEjM81thM62yRwOIlu9NbcTXSUQYyj7tzObMn88fJQy/mHUWBbmJxStjILtAncMwq7FYTyOL7gxhEkAObPBK6pA1T7mTaAeNXDGprJsBBLkdxjTbQGUoPHy9ygeNznef8c8mGcrM004NuEdCYp0ZAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8A8MiOx; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8A8MiOx"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6ce57a8b563so5071137.0
        for <damon@lists.linux.dev>; Thu, 11 Jun 2026 13:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781210222; cv=none;
        d=google.com; s=arc-20240605;
        b=lsLn5XYL9Q5+rQQ0q9Yy7dHlCav7uAcW1zQBajvN47LNkRY+xlTN+LXIcCdTYG1L6+
         8mD28RNJ5rCgG8ifVduydCmTEftoe196SBadrMJlMpXZqkO3F+uC1FDxpokiuN/7D3lG
         dwlPQZ+KnT59gplU2VIJQgdhY9hrBptc4lGJn7UwKoKrjHemLM5c5h4dkiaZHKNI3+Uo
         z62ABPIeQmIgvi3OSnyOgcrRyHWI0tuH8BLv/urBTeCR56x+mIEEaruYeDy9dl+BDN3v
         JFEP/JFIV4QFzvxk+2NSCXKPxCybuRRD5OBntGS/ezzhm3A+WWBk1HY4iw3ifvhCZsfi
         jxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+sd3cdzhpA5EXsMbu0XJlZwk0ZLWyDF9YQvcNfzR1z4=;
        fh=2YgeeGffSl0x66uTVsQN7Y4TI+Y7JHAW+UZLmLsYcRY=;
        b=NXGNk0DJnTS11gkvUGNDQRy6Tl+Oa67qLEKP5IGTLVFMOktmBnnG4lPyyK9kfElY5g
         4Gq1f4mVKi6VMqctS7BK9vT7/ajyVvDHdHM/sIPG2LM3Ud4I4Up+8e89qftOtlrnXw66
         O8PH2CCj8znMiC3eAbE9QpxjF360YjGRozoem6685BV1s8khuk/6jj5lWM/2yAgRytl/
         CO8tpFDtJh2CS3z4RfyaulIJNZd7cEiHvRcm9YDSGuxD4idTcdp/0VLMKXrKm2X+2SBj
         Yi9R1tkxAICcwdF8JSsu9b/W3DMUWI2UoVmj3L+lPtmLw/KyO91cd/IL3q+yngJJhfLz
         QKdA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781210222; x=1781815022; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sd3cdzhpA5EXsMbu0XJlZwk0ZLWyDF9YQvcNfzR1z4=;
        b=J8A8MiOxNcCc6aUr7TIEQ5J5UC5O30UrWY8pqOjvqB1VMDHfsTTnjZS8ShNGrByHMt
         skLhKwlRSyDVQKy5Ld3i63IyTjx90SNhsfz4sDIkomjFaOyj7bCAiT0LmP+xvq4iK0Rl
         +QUTWKpRMH1VgRrKiSiHL8e4v3nW3s4QYrmVj0aP8DyHrLhJ9Co/8htpdapESLWGEXSz
         PmgY7mUTDVnrRyWsUYgK+2uGGjrEyZV9+ZQIFhLzZsT4bhdbP4Bqv1IV/qW1rut2QVbn
         LzwQqkWhhZ3iMbH35prL2zvAxaUE1fVYBX68rQzXyGbK1dUrDE+cSHiE0AR2d9pOjkkD
         iPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210222; x=1781815022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+sd3cdzhpA5EXsMbu0XJlZwk0ZLWyDF9YQvcNfzR1z4=;
        b=DeP8jq8jMj4ZChQioyM8J7Yt1FFNfTFWYcGM7Es3wSq2mIx7fAerCBfck28MkIVbFO
         dZbAojNAY28Oj11Tym8vxhT0s5WIlXTX7jftDY3m/03RltbceDAXwlUNdZlfSO91uGDS
         diqga2dvShUXKGzPJn4rZ9Dy57AXaZCqZZqm6oI0a3dCorv+96NCtEofNE9ACBn9YPJE
         gjXd8DxxkUAz05KcfuSZz7MJjyLoSyYNF0TehcSFQIEUrJ/BtF5dbxlFKkLlbYucmTeD
         8EQfc3utSTcw1rmAjyRbScGFuVa1ilx20CifUw5lAXR1unBvlqT6ebq1j96+fgW6hPNA
         OuDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TP16qA24BCwAmGVNWErM7os1UeaFkiLcRY2EyfUVa52RsidoxtkFOLg33ZMAP8e215oo4/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKLkK7yR9+ke/gk71Uqf2c6ua0E5ZRDEQ+jghdn5ZWeBIIE2zJ
	u8x5KmJOKa+TTOUtZPDEYHO8+NaisFkFgCNUk8SVXXjUgHdJup/UwJ9LP7OlSrveylQ15f/sAuP
	32bvS9e1mxzrXGjFU+mTzUYHL3gsLn9ZV+uow
X-Gm-Gg: Acq92OGHBSSUaExCLTSMSfQ2svwrpf7cK2pskM+g/U6xSId10vfWNE4XrWHNEyinXY+
	bSGN7YiOTnsCvUvqAdEJ/mUkW+lEDX/rA9MdQkbhDAhxMPzhi26gM7WwE88sVEkHH1uNM1JJ3b4
	LVEwMkKJDBtIo6K4rRJPb+OC4pfOu+Ese1D/TPN/gpRXdLl0gBoh4vF0IgGYTpu7zJif/82QBIk
	RiLLAxCh3mmMLzRbNd8cjXbQN5PsZ5LVBuge7Z249EQYleMdR2Vn+ch4AGxb/xp5vbLaAxvF1Va
	JpiJlOPLYA==
X-Received: by 2002:a05:6102:26cb:b0:631:4d32:a86 with SMTP id
 ada2fe7eead31-71d5c67f824mr916400137.7.1781210221808; Thu, 11 Jun 2026
 13:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAF+TLO0TOKr3nef9RnbBuZ8A-jNpV1po26t1BO6JbSqMhfABvw@mail.gmail.com>
 <20260606003627.88973-1-sj@kernel.org> <CAF+TLO3a2MBVp3-7jm3BPjuT8jhx4yzdWxuA_QPQ9YPVEj0XZw@mail.gmail.com>
In-Reply-To: <CAF+TLO3a2MBVp3-7jm3BPjuT8jhx4yzdWxuA_QPQ9YPVEj0XZw@mail.gmail.com>
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Date: Fri, 12 Jun 2026 02:06:51 +0530
X-Gm-Features: AVVi8Ce2REi4mUqmiQKXLcfNq0RParFt0ik2l5LBrnYnygRVam7OLZkXJS6yVMY
Message-ID: <CAF+TLO2PX71_-9nKBEAJ50+NpjNkgipig6=9OLsvbgZtqF2yew@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/damon: add regression test for damos_walk()
 vs kdamond exit race
To: SeongJae Park <sj@kernel.org>
Cc: shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello SeongJae,

Noted on inline replies - I'll follow that format from the next response.

Following up on this thread with progress.

As discussed, I dropped the userspace selftest approach since it
cannot reliably trigger the microsecond-wide race window.

I wrote a KUnit test instead, added to mm/damon/tests/core-kunit.h:

- Creates a damon_ctx
- Sets ctx->walk_control_obsolete =3D true under walk_control_lock,
simulating the state just before kdamond_fn() exits
- Calls damos_walk() and verifies it returns -ECANCELED immediately

I built and ran this on a kernel with commit 33c3f6c2b48c
("mm/damon/core: fix damos_walk() vs kdamond_fn() exit race") present,
and the test passes along with all other 28 existing damon KUnit
tests:

  ok 29 damon_test_walk_control_obsolete
  # damon: pass:29 fail:0 skip:0 total:29

Since walk_control_obsolete is a field introduced by this fix, a
kernel with the fix reverted would not compile this test (the field
would not exist). So the usual "fails before fix, passes after fix"
verification does not apply the same way here - the test directly
validates the new field/behavior introduced by the fix.

If this approach looks reasonable, I plan to send v3 with this KUnit
test (replacing the userspace selftest from v1/v2), along with the
commit message format and other minor fixes from your earlier review.

Please let me know if you'd like any changes before I send v3.

Thanks,
Sailesh Nandanavanam


On Fri, 12 Jun, 2026, 01:50 Sailesh Nandanavanam,
<saileshnandanavanam@gmail.com> wrote:
>
> Hello SeongJae,
>
> Noted on inline replies - I'll follow that format from the next response.
>
> Following up on this thread with progress.
>
> As discussed, I dropped the userspace selftest approach since it cannot r=
eliably trigger the microsecond-wide race window.
>
> I wrote a KUnit test instead, added to mm/damon/tests/core-kunit.h:
>
> - Creates a damon_ctx
> - Sets ctx->walk_control_obsolete =3D true under walk_control_lock, simul=
ating the state just before kdamond_fn() exits
> - Calls damos_walk() and verifies it returns -ECANCELED immediately
>
> I built and ran this on a kernel with commit 33c3f6c2b48c ("mm/damon/core=
: fix damos_walk() vs kdamond_fn() exit race") present, and the test passes=
 along with all other 28 existing damon KUnit tests:
>
>   ok 29 damon_test_walk_control_obsolete
>   # damon: pass:29 fail:0 skip:0 total:29
>
> Since walk_control_obsolete is a field introduced by this fix, a kernel w=
ith the fix reverted would not compile this test (the field would not exist=
). So the usual "fails before fix, passes after fix" verification does not =
apply the same way here - the test directly validates the new field/behavio=
r introduced by the fix.
>
> If this approach looks reasonable, I plan to send v3 with this KUnit test=
 (replacing the userspace selftest from v1/v2), along with the commit messa=
ge format and other minor fixes from your earlier review.
>
> Please let me know if you'd like any changes before I send v3.
>
> Thanks,
> Sailesh
>
> On Sat, Jun 6, 2026 at 6:06=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>>
>> On Fri, 5 Jun 2026 12:44:50 +0530 Sailesh Nandanavanam <saileshnandanava=
nam@gmail.com> wrote:
>>
>> > Hi SeongJae,
>> >
>> > Apologies for the delayed response.
>>
>> No worry!
>>
>> [...]
>> > I agree that a KUnit test is the right approach since it runs inside t=
he
>> > kernel and can directly set walk_control_obsolete to simulate the race
>> > condition reliably without timing dependencies.
>> >
>> > I will drop the userspace selftest approach and write a KUnit test for
>> > damos_walk() functionality including walk_control_obsolete. I will ver=
ify
>> > it fails on a kernel with commit 33c3f6c2b48c ("mm/damon/core: fix
>> > damos_walk() vs kdamond_fn() exit race") reverted and passes with the =
fix
>> > present before sending v3.
>> >
>> > Regarding other feedback:
>> > - Will use correct commit description format with subject in brackets
>> > - Will remove the Fixes: tag
>> > - Will add blank line before _damon_sysfs import
>> > - Will add changelog and link previous versions
>> > - Will share revision plan and wait at least one day
>> >   before sending new version
>>
>> Sounds good.  Please consider using in-line reply [1] from the next time=
,
>> though!
>>
>> >
>> > Please give me some time to study mm/damon/tests/core-kunit.h and impl=
ement
>> > this properly.
>>
>> No rush, take your time.
>>
>> [1] https://subspace.kernel.org/etiquette.html#do-not-top-post-when-repl=
ying
>>
>>
>> Thanks,
>> SJ
>>
>> [...]
