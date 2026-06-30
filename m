Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886DB32FA30
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782791656; cv=none; b=GdtfrK3R9KNOGxppIzCEUUcoJFBgGWDChfIPgmJMDEGe+kqO8ncrHcQJK0sTLdHTZPZYicWdktmgiMD67+iN2rrnf31sQ0pBi0RXE2Q3iWpahDKD6k/kgnWRGaggC5QkR5p0dmS6xkQHuOzANq/FTJ5Iu7GhA2OA5cky317Nu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782791656; c=relaxed/simple;
	bh=+jqyZTgo5GBmBrrv1akKlZxgPpcliJtqM0BiaPPLerY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anCM63IKUff1Gov8PHMIezSqJx0xAJuraml3xeibAkujJX7mzwc98PI0+67tjV0ph1lHduGc2LccO6wCbfD/B893NRboSziEL4Dyq1rCLxQncoyZi4mKE4zWwudP+0QJ7aHQ5mUKCYbz5/R7pFuFKe/RE+0pfui0mJAtyfnv+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjPPAzyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjPPAzyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E951F000E9;
	Tue, 30 Jun 2026 03:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782791655;
	bh=cH5os8POeGEP5DIHBLSx9NLSUKRf/AGBhoWEzxgoLyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjPPAzyK3qNco+lI7m4/v3IQtTdPljhxaeJtkQh3uOvayf2XbGzsW7MXvR4e+Pr1q
	 /j8U5/T2WwUMAOnDeuyqU89cA1hmdYoVRGQvdrnnkc1szMLlnYDRLGTii8yNUDkLB8
	 HevEK4/lqplAhQMWDeGhjp6Gs4L9sJnSCJPZdK3/Yxb+GxEgXMK3OX1ism1Y9XinZb
	 1cTPyYDjMvkeB78h/qtDqj3WhjbwGmYsayYn/8Xxc6tlgRn/urx8fgimuhWA7rFRg4
	 BirW2eHxALdPT2EIMXtIMn4UqpjLpNhpJk2Ld3JaCj6uo9uIKqfGVoNQ2NEgj+CWY7
	 ++k+NTlDk294Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2] MAINTAINERS: s/SeongJae/SJ/
Date: Mon, 29 Jun 2026 20:54:11 -0700
Message-ID: <20260630035411.146557-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630014230.B10B81F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 01:42:30 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unjustified removal of third-party corporate copyright notices.
> --
> 
> commit 01dda7537f36dfeb49164318c8fee42788b1510a
> Author: SJ Park <sj@kernel.org>
> 
> MAINTAINERS: s/SeongJae/SJ/
> 
> This patch updates the author's preferred name across the DAMON subsystem,
> including sysfs documentation, source files, and MAINTAINERS. It also removes
> copyright notes from these files, stating that they can be confusing.
> 
> [ ... ]
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 1cfb8c176b873..fcf7c7fadb5fe 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -1,10 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  /*
> >   * Data Access Monitor Unit Tests
> > - *
> > - * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
> 
> [Severity: Medium]
> Is it okay to remove third-party corporate copyright notices like this?
> 
> While the commit message mentions removing copyright notes because they can
> be confusing, removing another entity's copyright (Amazon.com, Inc.)
> without explicit sign-off or authorization might violate standard kernel
> legal practices and risk copyright disputes.
> 
> Should these specific notices be retained unless there is explicit
> authorization from the copyright holder?

I'll reconsider if a human raises a concern.

> 
> > - *
> > - * Author: SeongJae Park <sj@kernel.org>
> >   */
> >  
> >  #ifdef CONFIG_DAMON_KUNIT_TEST
> 
> [ ... ]
> 
> > diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> > index 563fbc7e3f448..61f844336ffb5 100644
> > --- a/mm/damon/tests/vaddr-kunit.h
> > +++ b/mm/damon/tests/vaddr-kunit.h
> > @@ -1,10 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  /*
> >   * Data Access Monitor Unit Tests
> > - *
> > - * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
> 
> [Severity: Medium]
> Does the same third-party copyright removal concern apply to this file
> as well?

Ditto.


Thanks,
SJ

[...]
