Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989FA7260D
	for <damon@lists.linux.dev>; Sat, 13 Dec 2025 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765585897; cv=none; b=PlV33qtYwUshamBiXedEZSVfR82NLu9u5AY8eiuHK6BWLIrwY3ys62VEpJuFoF7VlDhFKyYZlByTciV6dLT9V8SDobyyEbu6Me90CRSRamDbO8zoQx6Q2WrdyY2rzkr2UuGzjfhAY8LLRey88wIGYWHxIpirjJ4AA38mhdWlsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765585897; c=relaxed/simple;
	bh=NDsCaMenXLtU/qtPTu2piFl4uYMCQ+E4fGYDKSMSeDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYupbKZfTWwrdAEj8sSgVU/fEN5lsvLOkf7otsctfoIeGfmH7BbSjEpHl5PtfPLDGHRwtOBgojb+SXOYDVQFkWLKU6B8LVL9lwPC6fVFpKyOjZk6d1boZYIfqItXsn1h+XSWfKOnjMiQLm/yA4uU/0ZpS0G4KRQlDnVaAOzIA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpFEmEyG; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpFEmEyG"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64471fcdef0so1248631d50.1
        for <damon@lists.linux.dev>; Fri, 12 Dec 2025 16:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765585894; x=1766190694; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEcwbKwfTOFD0jwPGTk2/X+40kQERA+omCUm1l1+tM8=;
        b=GpFEmEyGVy0R0klJqOGZ71ZFDVMFG/gYK/UngwPoWGdyaaxeP/JE2vCuuoXjb4Zw9v
         ADbYqqXLrPpW5LDJ4itn/pDCci2W+Vjssi5fQf5yywcCPaZjJ/R9ryr8t0PbDPwgmh/R
         sVcCTeKB2VLgtJ7HXdfjQj6KxoJO4rZof9jlSAiF8AAHkDHcOSBS0E90V6uBscrrGDkB
         TEt0h0Kg6wBapN8wqPu9RsasMWF6h5+iztx5mhjTaj0MDokiL6XWImYnluFUPQ6Lt2lI
         z3XqU5i++5HTF89snN0Fk0qUc2u9FqFUPABUQMSZwBTLVisSSOYqrl8PEbthnXL4RLs9
         4LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765585894; x=1766190694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UEcwbKwfTOFD0jwPGTk2/X+40kQERA+omCUm1l1+tM8=;
        b=O3ivflySMlE9xnZ4nm9/poxyKsYGozXOh3lk7DbJGCArM5FtudRxIdnwW0fFyo3pLa
         sZ/gUAhFYyzMkHE4KNgqxN30UtblMysQkVjKeuQW8JZj8kc+dOxyFT9YAkY3NdWc2Fp7
         7RR+bjG8dpfDjr9fTUPfYmtZHrzzlB7VTSXpMS8NUk7QsfIt0nMqDHrJ58HUwS7DPKPU
         dtmvzImOddJ8ZbKzjKf/OSR0ET30JTgWe45y6VNsZL0qH26MFhw2j9S8eWl2xN2bL9Qf
         Oi1VUXry3vO64LFCccJCWG/WctVu3SLj3vRKAt9LSztRmCOyP6BYmmiK2Fs/owpfpB44
         wYgw==
X-Forwarded-Encrypted: i=1; AJvYcCWCkyAiO0verept/TNnDZ4tam4la+qkBnx+oecP+HI1Zv5yY0ZeDjHviWCbQ9+ablC17hdlBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2XzC84d6q13TaL4Js6gUhLXaQY0QfFe0j7x8TO8y2xM6GdjRa
	YLw2fzN86TbpLYpUbtWnFl/XDqQzkpvK+IOYt0W9fvJ8J11pu8DhkfoL2DJsjPs0xFyt1nfySn5
	wTyZdUiknrTtnRgv+EIdf+kg2njsxV5A=
X-Gm-Gg: AY/fxX74k+uckcxCpcYxX7p+xdMmkh+BTlILdz9P46AM9t1EXMFX7lMh3u/pAtyUzl3
	TT5Vb8IIs/JDvFRxF9RPoFHwpngqhQr7BYJe8iJiWFL2caHeRQvR+pphvzaitMB/lOoHS7NxI4p
	E33R01HHCAhtebZwTjroCROukPH0rn+Pcx+I2DtMURlz6stE4lZF9NEvSIxCS0La8Zqhb5HN4ec
	PHJHNaEYF5AHKIKshakVgv4ziXb5LJbSGS3wy+4GpA8kXM8c17zrZwnFuxYRoZGLsf3636h
X-Google-Smtp-Source: AGHT+IEQZtU4xsWlPhjZ7QJTAV/tes6u89ouYxUdq4/62OSm+FOWxb8I8THQC5Se0CroX3JY/me34F5OxoNdNpC1NX8=
X-Received: by 2002:a05:690c:3505:b0:78a:722f:a7c9 with SMTP id
 00721157ae682-78e66df1f36mr66786637b3.47.1765585894226; Fri, 12 Dec 2025
 16:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC6B1q+1TLEw5WAQM+E_L2tQQArgq=Hy5JZ35m4_H7s_5Q@mail.gmail.com>
 <20251212224721.49478-1-sj@kernel.org>
In-Reply-To: <20251212224721.49478-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sat, 13 Dec 2025 09:31:22 +0900
X-Gm-Features: AQt7F2pfvDTP5FkaJvoXFOYDXn_3neT_rIxfDPvx0spF759PQGoNThkIDh55lTk
Message-ID: <CAHOvCC4jUGpyezSNMChyOCio-vTA=kK3CYS3O1CzEXxEiMjPyg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/37] mm/damon/core: implement damon_report_page_fault()
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Dec 2025 at 07:47, SeongJae Park <sj@kernel.org> wrote:
>
> On Fri, 12 Dec 2025 21:46:03 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrot=
e:
>
> > On Mon, 8 Dec 2025 at 15:33, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Implement a DAMON core API for reporting page fault events to DAMON. =
 It
> > > is a wrapper of damon_report_access().
> > >
> > > This is a temporal hack.  In future versions that will have no RFC ta=
g,
> > > only damon_report_access() may be used.
> >
> > It's a minor, but git am throws an error when applying the [RFC PATCH v=
3 04/37]
> > patch file.
>
> Interesting.  I can do 'git am' this patch without error on mm-new branch=
.  Are
> you using something other than mm-new as your baseline?
>
> > I am testing it by modifying it as follows.
> > damon_report_access() is
> > called by damon_report_page_fault(), so they depend on each other.
> >
> > #ifdef CONFIG_MMU
> > void damon_report_access(struct damon_access_report *report);
> > void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd);
> > #else
> > static inline void damon_report_access(struct damon_access_report *repo=
rt)
> > {
> > }
> > static inline void damon_report_page_fault(struct vm_fault *vmf, bool h=
uge_pmd)
> > {
> > }
> > #endif
>
> Seems this is not for fixing a 'git am' error but build error...?  Can yo=
u
> share what error exactly you are seeing?

You have been deploying RFC PATCH v1, v2, and v3 starting from 2025-06-29.
I am currently working with the latest version v6.18.1 (as of 2025-12-13).

$ head Makefile
# SPDX-License-Identifier: GPL-2.0
VERSION =3D 6
PATCHLEVEL =3D 18
SUBLEVEL =3D 1
EXTRAVERSION =3D
NAME =3D Baby Opossum Posse

When applying RFC PATCH v1, v2, v3 with the above version, errors occur
in several places in 'git am' as follows.

-------- [RFC PATCH v1] -------------------------------------------------

$ git am '[RFC PATCH 1/6]'
Applying: mm/damon/core: introduce damon_report_access()

$ git am '[RFC PATCH 2/6]'
Applying: mm/damon/core: add eliglble_report() ops callback

$ git am '[RFC PATCH 3/6]'
Applying: mm/damon/core: check received access reports

$ git am '[RFC PATCH 4/6]'
Applying: mm/damon/vaddr: impleement eligible_report() callback
error: patch failed: mm/damon/vaddr.c:610
error: mm/damon/vaddr.c: patch does not apply
Patch failed at 0001 mm/damon/vaddr: impleement eligible_report() callback
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC PATCH 5/6]'
Applying: mm/damon: add node_id to damon_access_report

$ git am '[RFC PATCH 6/6]'
Applying: mm/damon: add write field to damon_access_report

-------- [RFC PATCH v2] -------------------------------------------------

$ git am '[RFC v2 1/7]'
Applying: mm/damon/core: introduce damon_report_access()
error: patch failed: include/linux/damon.h:104
error: include/linux/damon.h: patch does not apply
error: patch failed: mm/damon/core.c:24
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: introduce damon_report_access()
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v2 2/7]'
Applying: mm/damon/core: add eligible_report() ops callback
error: patch failed: include/linux/damon.h:590
error: include/linux/damon.h: patch does not apply
Patch failed at 0001 mm/damon/core: add eligible_report() ops callback
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v2 3/7]'
Applying: mm/damon/vaddr: implement eligible_report()

$ git am '[RFC v2 4/7]'
Applying: mm/damon/core: read received access reports
error: patch failed: mm/damon/core.c:2560
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: read received access reports
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v2 5/7]'
Applying: mm/memory: implement MM_CP_DAMON

$ git am '[RFC v2 6/7]'
Applying: mm/damon: implement paddr_fault operations set

$ git am '[RFC v2 7/7]'
Applying: mm/damon/sysfs: support paddr_fault

-------- [RFC PATCH v3] -------------------------------------------------

$ git am '[RFC v3 01/37]'
Applying: mm/damon/core: implement damon_report_access()
error: patch failed: include/linux/damon.h:110
error: include/linux/damon.h: patch does not apply
error: patch failed: mm/damon/core.c:20
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: implement damon_report_access()
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 02/37]'
Applying: mm/damon: define struct damon_sample_control

$ git am '[RFC v3 03/37]'
Applying: mm/damon/core: commit damon_sample_control
error: patch failed: mm/damon/core.c:1278
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: commit damon_sample_control
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 04/37]'
Applying: mm/damon/core: implement damon_report_page_fault()
error: patch failed: include/linux/damon.h:1017
error: include/linux/damon.h: patch does not apply
Patch failed at 0001 mm/damon/core: implement damon_report_page_fault()
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 05/37]'
Applying: mm/{mprotect,memory}: (no upstream-aimed hack) implement MM_CP_DA=
MON
error: patch failed: include/linux/mm.h:2848
error: include/linux/mm.h: patch does not apply
error: patch failed: mm/memory.c:78
error: mm/memory.c: patch does not apply
error: patch failed: mm/mprotect.c:651
error: mm/mprotect.c: patch does not apply
Patch failed at 0001 mm/{mprotect,memory}: (no upstream-aimed hack)
implement MM_CP_DAMON
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 06/37]'
Applying: mm/damon/paddr: support page fault access check primitive
error: patch failed: mm/damon/paddr.c:14
error: mm/damon/paddr.c: patch does not apply
Patch failed at 0001 mm/damon/paddr: support page fault access check primit=
ive
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 07/37]'
Applying: mm/damon/core: apply access reports to high level snapshot
error: patch failed: mm/damon/core.c:2745
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: apply access reports to high level snap=
shot
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 08/37]'
Applying: mm/damon/sysfs: implement monitoring_attrs/sample/ dir

$ git am '[RFC v3 09/37]'
Applying: mm/damon/sysfs: implement sample/primitives/ dir

$ git am '[RFC v3 10/37]'
Applying: mm/damon/sysfs: connect primitives directory with core

$ git am '[RFC v3 11/37]'
Applying: Docs/mm/damon/design: document page fault sampling primitive

$ git am '[RFC v3 12/37]'
Applying: Docs/admin-guide/mm/damon/usage: document sample primitives dir
error: patch failed: Documentation/admin-guide/mm/damon/usage.rst:65
error: Documentation/admin-guide/mm/damon/usage.rst: patch does not apply
Patch failed at 0001 Docs/admin-guide/mm/damon/usage: document sample
primitives dir
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 13/37]'
Applying: mm/damon: extend damon_access_report for origin CPU reporting
error: patch failed: include/linux/damon.h:115
error: include/linux/damon.h: patch does not apply
Patch failed at 0001 mm/damon: extend damon_access_report for origin
CPU reporting
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 14/37]'
Applying: mm/damon/core: report access origin cpu of page faults
error: patch failed: mm/damon/core.c:1585
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: report access origin cpu of page faults
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 15/37]'
Applying: mm/damon: implement sample filter data structure for
cpus-only monitoring

$ git am '[RFC v3 16/37]'
Applying: mm/damon/core: implement damon_sample_filter manipulations
error: patch failed: mm/damon/core.c:561
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: implement damon_sample_filter manipulat=
ions
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 17/37]'
Applying: mm/damon/core: commit damon_sample_filters
error: patch failed: mm/damon/core.c:573
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: commit damon_sample_filters
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 18/37]'
Applying: mm/damon/core: apply sample filter to access reports
error: patch failed: mm/damon/core.c:586
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: apply sample filter to access reports
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 19/37]'
Applying: mm/damon/sysfs: implement sample/filters/ directory

$ git am '[RFC v3 20/37]'
Applying: mm/damon/sysfs: implement sample filter directory

$ git am '[RFC v3 21/37]'
Applying: mm/damon/sysfs: implement type, matching, allow files under
sample filter dir

$ git am '[RFC v3 22/37]'
Applying: mm/damon/sysfs: implement cpumask file under sample filter dir

$ git am '[RFC v3 23/37]'
Applying: mm/damon/sysfs: connect sample filters with core layer

$ git am '[RFC v3 24/37]'
Applying: Docs/mm/damon/design: document sample filters

$ git am '[RFC v3 25/37]'
Applying: Docs/admin-guide/mm/damon/usage: document sample filters dir
error: patch failed: Documentation/admin-guide/mm/damon/usage.rst:66
error: Documentation/admin-guide/mm/damon/usage.rst: patch does not apply
Patch failed at 0001 Docs/admin-guide/mm/damon/usage: document sample
filters dir
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 26/37]'
Applying: mm/damon: extend damon_access_report for access-origin thread inf=
o
error: patch failed: include/linux/damon.h:116
error: include/linux/damon.h: patch does not apply
Patch failed at 0001 mm/damon: extend damon_access_report for
access-origin thread info
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 27/37]'
Applying: mm/damon/core: report access-generated thread id of the fault eve=
nt
error: patch failed: mm/damon/core.c:1712
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: report access-generated thread id
of the fault event
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 28/37]'
Applying: mm/damon: extend damon_sample_filter for threads

$ git am '[RFC v3 29/37]'
Applying: mm/damon/core: support threads type sample filter
error: patch failed: mm/damon/core.c:570
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: support threads type sample filter
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 30/37]'
Applying: mm/damon/sysfs: support thread based access sample filtering

$ git am '[RFC v3 31/37]'
Applying: Docs/mm/damon/design: document threads type sample filter

$ git am '[RFC v3 32/37]'
Applying: Docs/admin-guide/mm/damon/usage: document tids_arr file
error: patch failed: Documentation/admin-guide/mm/damon/usage.rst:67
error: Documentation/admin-guide/mm/damon/usage.rst: patch does not apply
Patch failed at 0001 Docs/admin-guide/mm/damon/usage: document tids_arr fil=
e
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 33/37]'
Applying: mm/damon: support reporting write access
error: patch failed: include/linux/damon.h:117
error: include/linux/damon.h: patch does not apply
Patch failed at 0001 mm/damon: support reporting write access
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 34/37]'
Applying: mm/damon/core: report whether the page fault was for writing
error: patch failed: mm/damon/core.c:1732
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: report whether the page fault was
for writing
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 35/37]'
Applying: mm/damon/core: support write access sample filter
error: patch failed: mm/damon/core.c:1336
error: mm/damon/core.c: patch does not apply
Patch failed at 0001 mm/damon/core: support write access sample filter
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git am --abort

$ git am '[RFC v3 36/37]'
Applying: mm/damon/sysfs: support write-type access sample filter

$ git am '[RFC v3 37/37]'
Applying: Docs/mm/damon/design: document write access sample filter type

If I build the kernel with the above status, I get compilation errors
as follows.

/home/arm64/projects/kernel/linux-stable/mm/damon/sysfs.c:758:25:
error: =E2=80=98DAMON_FILTER_TYPE_WRITE=E2=80=99 undeclared here (not in a =
function);
did you mean =E2=80=98DAMOS_FILTER_TYPE_TARGET=E2=80=99?
  758 |                 .type =3D DAMON_FILTER_TYPE_WRITE,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~
      |                         DAMOS_FILTER_TYPE_TARGET
/home/arm64/projects/kernel/linux-stable/mm/damon/sysfs.c: In function
=E2=80=98damon_sysfs_set_sample_filters=E2=80=99:
/home/arm64/projects/kernel/linux-stable/mm/damon/sysfs.c:2014:26:
error: implicit declaration of function =E2=80=98damon_new_sample_filter=E2=
=80=99; did
you mean =E2=80=98damos_new_filter=E2=80=99? [-Werror=3Dimplicit-function-d=
eclaration]
 2014 |                 filter =3D damon_new_sample_filter(
      |                          ^~~~~~~~~~~~~~~~~~~~~~~
      |                          damos_new_filter
/home/arm64/projects/kernel/linux-stable/mm/damon/sysfs.c:2014:24:
warning: assignment to =E2=80=98struct damon_sample_filter *=E2=80=99 from =
=E2=80=98int=E2=80=99 makes
pointer from integer without a cast [-Wint-conversion]
 2014 |                 filter =3D damon_new_sample_filter(
      |                        ^
/home/arm64/projects/kernel/linux-stable/mm/damon/sysfs.c:2027:33:
error: implicit declaration of function =E2=80=98damon_free_sample_filter=
=E2=80=99;
did you mean =E2=80=98damon_sysfs_set_sample_filters=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
 2027 |                                 damon_free_sample_filter(filter);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
      |                                 damon_sysfs_set_sample_filters
/home/arm64/projects/kernel/linux-stable/mm/damon/sysfs.c:2032:17:
error: implicit declaration of function =E2=80=98damon_add_sample_filter=E2=
=80=99; did
you mean =E2=80=98damos_add_filter=E2=80=99? [-Werror=3Dimplicit-function-d=
eclaration]
 2032 |                 damon_add_sample_filter(control, filter);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
      |                 damos_add_filter
cc1: some warnings being treated as errors
make[5]: *** [/home/arm64/projects/kernel/linux-stable/scripts/Makefile.bui=
ld:287:
mm/damon/sysfs.o] Error 1
make[4]: *** [/home/arm64/projects/kernel/linux-stable/scripts/Makefile.bui=
ld:556:
mm/damon] Error 2
make[3]: *** [/home/arm64/projects/kernel/linux-stable/scripts/Makefile.bui=
ld:556:
mm] Error 2
make[3]: *** Waiting for unfinished jobs....
  CC      kernel/time/timekeeping_debug.o

I am analyzing the source code while I am correcting the errors.

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
