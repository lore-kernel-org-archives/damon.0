Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBF2A1BA
	for <damon@lists.linux.dev>; Sat, 13 Dec 2025 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765589849; cv=none; b=bWMNwwoglPueX62aPnXkbHCNiW/hNVDfDAjLEFqN6PfZbF05M19jywMsjlYVuGhN+iRO9IO99FEhTS/GXYhjRyT/r4PP0cphRpAbbRDZoAjjq+FUBCyg9RSENcZWi1TRM+/EMuptimuMBAEKV0yaqpYqrZQuN5xxZ46WHedQK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765589849; c=relaxed/simple;
	bh=jfdBsMHJ7yki8Lg6hXR6vlG4FbRIXYEeY4phnmAqAbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJmqLsaBZxmxWSMvvnpWQ6nv6Wj/UpK4Ge0ty4R2jGewl82QIYDJCPDT2u9/kFrHtLPN8HeKvdIypnuK/8CYsZdidI7x9/njmfXp+DYTUca9jPvVMxnkPF4rp0S899Cl/y9IQ9we7U+mg+00h876md1ySYli6aIq+URtRidPXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3AzURhi; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3AzURhi"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-642fcb38f35so1645266d50.1
        for <damon@lists.linux.dev>; Fri, 12 Dec 2025 17:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765589846; x=1766194646; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csAfRwOb+6hGQnPT+25Zp2eP5dk+D8F+hnBaGvdyJOU=;
        b=V3AzURhiOuMFYvS4T/tjSWAzcmn37WAKsgtrrEqTtP1mkTGr1LfpWqeHKv1UvOV+Le
         ILA3ng32ICCbaTwi88vK1VuYrPQ81Efov089X/HtDlhipWeGWobqh/3v2hzC3vtrCcLf
         tHcA2ud5Vqje7i1SMMRgMX4RtE/WdeIjCE/Fw4Mwx9cm6hGlBVO11uT7bKAd2Ny8HNdg
         2ghptacZRBjSUvjKiuTfPGqE8vurBdtqGtvjamPJjheX0gG6G4ErXsjmvWW1mqlanl2u
         GieT2CMykFWwDbNNo338iR6j90B50fPIPW3HPtzI0NuD15qpVBZS7dyWwXI+euiTXs9R
         nhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765589846; x=1766194646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=csAfRwOb+6hGQnPT+25Zp2eP5dk+D8F+hnBaGvdyJOU=;
        b=Pu4+jNFul1TiR4ESuB/Yeg7WtI7U9dGjrenyWEGM/upf3WZoyw0Tv/kGPs3LBaEYk1
         SawdhxhiWdm0TKMsSeey+w+M34Y0QVDnfZqxG38wmS8I4XPp2UL7ENdOrNc59F8tCGyo
         D8YoVZRS6ziQK2jI8woG9PwTwDxxClKvDTRACEZRKkPsqIan+rtVXaW+pworBCCSY6O4
         tW0NslMl1p/dB+6kjnt498WN1Qz9MIUcWuEZKhEhfuid56fy/ceq/9AjGENL0VneCrCl
         Msar6cakCHlyqQoZneXR6flOdjB2G56pXR74sfTR9VVk/VK2B/qbBirrdQO0bY7L1RV6
         tvIA==
X-Forwarded-Encrypted: i=1; AJvYcCUuDMnxX4sU/ijD3CQDLPKFeXVYCrobbeX9/L9FSU/wRy0B9kmSn5O7scp9MUg5W+UtYDStig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzFSDCE0cCs8P7DxFl3iyi6C1WkVeIFBSQlyP2H2lr8xNO2Nou
	79CxJtynKcvOg0Sbuxed+Oric1s+2lwWUfXhj8/e0azeOHEiAn4To33FqXNBdTlDZiO3Obn6Bsf
	7WM2dvJgEtca0ULbzbOZbv67gHe6SetzQH+7QfQ0=
X-Gm-Gg: AY/fxX5m1dhvFb8qLyIP4IaAJzx0a/ixCXO3udqegshkX5zaL6TVYsAMF84zxNdrEy2
	r2WRI1UqssiHEGbQ9I+GqFoG7u384SxeCD6BY8W/GGqRy9U8tV8wtpzQssM4DUfM2DUtRvCpxC/
	17kuJ9FJkBmUdLJ9h0quGYozzS6UZXG8jwPzgW75OdXmjZGFXHftxRTSL0iNLEdXQLmoRY5OEJp
	1+YdlRzNWMH8wZHkKudCw7sW/TC5cVTql1KOQ66LniBx0XoAjFSA0gKzTlobvGovR7HeWKo
X-Google-Smtp-Source: AGHT+IHwifFUh7ghZ7Sb2I67Rfsfo8yTZn4nkMEXK+s046YgWD01E/NmfDNjVDBefF/mtE2oIr3GKkZDMqdj3mL0lOs=
X-Received: by 2002:a05:690e:1488:b0:644:2e68:d1a0 with SMTP id
 956f58d0204a3-645555dba05mr2603842d50.32.1765589846413; Fri, 12 Dec 2025
 17:37:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC4jUGpyezSNMChyOCio-vTA=kK3CYS3O1CzEXxEiMjPyg@mail.gmail.com>
 <20251213005639.50513-1-sj@kernel.org>
In-Reply-To: <20251213005639.50513-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sat, 13 Dec 2025 10:37:14 +0900
X-Gm-Features: AQt7F2peAf6ZXv8embAaS15t1cFvNlEzS6J9k2Rhhus4lzgna_Wm9102lTI4V_Q
Message-ID: <CAHOvCC6Bt-PcxhT=TJpukSyPyj-9e=dP--aQ8YR9JVKYJ913=w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/37] mm/damon/core: implement damon_report_page_fault()
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Dec 2025 at 09:56, SeongJae Park <sj@kernel.org> wrote:
>
> On Sat, 13 Dec 2025 09:31:22 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrot=
e:
>
> > On Sat, 13 Dec 2025 at 07:47, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Fri, 12 Dec 2025 21:46:03 +0900 JaeJoon Jung <rgbi3307@gmail.com> =
wrote:
> > >
> > > > On Mon, 8 Dec 2025 at 15:33, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > Implement a DAMON core API for reporting page fault events to DAM=
ON.  It
> > > > > is a wrapper of damon_report_access().
> > > > >
> > > > > This is a temporal hack.  In future versions that will have no RF=
C tag,
> > > > > only damon_report_access() may be used.
> > > >
> > > > It's a minor, but git am throws an error when applying the [RFC PAT=
CH v3 04/37]
> > > > patch file.
> > >
> > > Interesting.  I can do 'git am' this patch without error on mm-new br=
anch.  Are
> > > you using something other than mm-new as your baseline?
> > >
> > > > I am testing it by modifying it as follows.
> > > > damon_report_access() is
> > > > called by damon_report_page_fault(), so they depend on each other.
> > > >
> > > > #ifdef CONFIG_MMU
> > > > void damon_report_access(struct damon_access_report *report);
> > > > void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd);
> > > > #else
> > > > static inline void damon_report_access(struct damon_access_report *=
report)
> > > > {
> > > > }
> > > > static inline void damon_report_page_fault(struct vm_fault *vmf, bo=
ol huge_pmd)
> > > > {
> > > > }
> > > > #endif
> > >
> > > Seems this is not for fixing a 'git am' error but build error...?  Ca=
n you
> > > share what error exactly you are seeing?
> >
> > You have been deploying RFC PATCH v1, v2, and v3 starting from 2025-06-=
29.
> > I am currently working with the latest version v6.18.1 (as of 2025-12-1=
3).
> >
> > $ head Makefile
> > # SPDX-License-Identifier: GPL-2.0
> > VERSION =3D 6
> > PATCHLEVEL =3D 18
> > SUBLEVEL =3D 1
> > EXTRAVERSION =3D
> > NAME =3D Baby Opossum Posse
> >
> > When applying RFC PATCH v1, v2, v3 with the above version, errors occur
> > in several places in 'git am' as follows.
> >
> > -------- [RFC PATCH v1] -----------------------------------------------=
--
> >
> > $ git am '[RFC PATCH 1/6]'
> > Applying: mm/damon/core: introduce damon_report_access()
> >
> > $ git am '[RFC PATCH 2/6]'
> > Applying: mm/damon/core: add eliglble_report() ops callback
> >
> > $ git am '[RFC PATCH 3/6]'
> > Applying: mm/damon/core: check received access reports
> >
> > $ git am '[RFC PATCH 4/6]'
> > Applying: mm/damon/vaddr: impleement eligible_report() callback
> > error: patch failed: mm/damon/vaddr.c:610
> > error: mm/damon/vaddr.c: patch does not apply
> > Patch failed at 0001 mm/damon/vaddr: impleement eligible_report() callb=
ack
> > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> [...]
>
> Thank you for sharing these!  We are working on moving baseline, specific=
ally
> mm-new in most cases.  And we keep under-development patches on damon/nex=
t
> tree.  Please refer to the document [1] for more details.
>
> And a later version of the patch series is for replacing the old version.=
  If
> you have no special reason to apply the old versions of the patches, I'd
> suggest to use only the latest version.  And if you have no special reaso=
ns to
> use only 6.18.1, I'd recommend to just play with the commits on damon/nex=
t
> tree that was used to generate the patch files.
>
> Nonetheless, if you have a strong reason to do work on only 6.18.1, pleas=
e feel
> free to ask help if needed.
>
> > If I build the kernel with the above status, I get compilation errors
> > as follows.
> >
> > /home/arm64/projects/kernel/linux-stable/mm/damon/sysfs.c:758:25:
> > error: =E2=80=98DAMON_FILTER_TYPE_WRITE=E2=80=99 undeclared here (not i=
n a function);
> > did you mean =E2=80=98DAMOS_FILTER_TYPE_TARGET=E2=80=99?
> >   758 |                 .type =3D DAMON_FILTER_TYPE_WRITE,
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~
> >       |                         DAMOS_FILTER_TYPE_TARGET
> [...]
>
> Makes sense.  Again, I'd recommend using mm-new as your baseline or play =
with
> the commits on damon/next, but if you need help, please feel free to reac=
h out
> :)

Thank you for your detailed and kind reply.
I am glad to refer to damon/next and mm-new in the document [1] you provide=
d.
I will continue to share the analysis with you.

>
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile=
.html#scm-trees
> [2]
>
> Thanks,
> SJ
>
> [...]
