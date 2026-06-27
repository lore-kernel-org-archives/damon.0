Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9C1991CB
	for <damon@lists.linux.dev>; Sat, 27 Jun 2026 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782593200; cv=none; b=rqaQnprunXObGI4Kh0O071s+eIychHpGovSTCwgsZ01k9Su8iuXAC5ui7fyPxFJg0lEuwnWVdnxKkOS55pkTkzDCng1WHrgGFrH5kRxWL2vUNMnqNw/xEGkSssJ6COXDoR6ueeaiYFkLReik284b8py98bjeDB2zDOwqSYijTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782593200; c=relaxed/simple;
	bh=E46NzVMZp249ovOBAdtw8nIXT2oHykYORXg46nDjT0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPq5YoFQZjzTxxPtcK6pRZ0faZCvNxioNRgs3TPhL1bLTYm/lQkABa53dOxN9YMitpvVmkCnhPPzInxnME4+vybamgo+7UTEICQWP+zSlAjqH7bWodlUt4rtU2UgnZggCrVU5+KPZOQAf7D5+5MqzRvnbJ/TVHhsOCe4jLdTqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvieQjPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvieQjPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EFD1F000E9;
	Sat, 27 Jun 2026 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782593199;
	bh=Zposj+FBfKVzIAk0XpYcwhBkiZp2j+t7Zh/fJmoE+28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvieQjPZe7qId7BOAmdCuAYTcW2qMfGzXZxNEj2dzqNt+X2zvXELARJ8NOUcS6Ryf
	 VxHUUTanSzdf76RlibUbfawcaP9wjAjoPYTi3YgJUD3BlEUW3YL42Z2P6fDQNLDSfp
	 HbSiR9CQNfhRX2ilwhWfdNRv2yylTkZD78O5nGGFwEToFGj8kVC900cUpQxYu2ikMQ
	 rKZPvkYJq5q+7sO69BE8d8WdLpKianFymQ7G8y0GCKg96HGnsygifJObE/ZwlgJg+E
	 Aj/XyFdVOmkOzALF6oMPgVP+P+VjedJlZ2bWo/4a9ViMaI2clbnD51JSROKyb3T3Kc
	 YO+/GXuqWBJFg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: s/SeongJae/SJ/
Date: Sat, 27 Jun 2026 13:46:30 -0700
Message-ID: <20260627204630.25614-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260627200028.E75DF1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jun 2026 20:00:28 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unintended Code Deletion / Copyright Removal

These are intended change.  If someone thinks this is problematic or wants the
commit message to be updated for more clarification, please let me know.

> --
> 
> commit 7824bc7fc9af6bcdbf6c2338af2a70179e7f0325
> Author: SJ Park <sj@kernel.org>
> 
> MAINTAINERS: s/SeongJae/SJ/
> 
> This commit changes instances of the author's name from "SeongJae" to the
> preferred name "SJ" to avoid confusion.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 6f7edb3590ef9..8bb28d5682dd8 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -1,8 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  /*
> >   * DAMON api
> > - *
> > - * Author: SeongJae Park <sj@kernel.org>
> >   */
> >  
> >  #ifndef _DAMON_H_
> 
> [Severity: Medium]
> Was it intentional to completely delete the Author attribution here instead of 
> updating it to SJ Park?

Yes, it is intentional.  We can show who wrote it using 'git log'.

> 
> [ ... ]
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 2e95e3bac774d..a9e187158067d 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1,8 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * DAMON sysfs Interface
> > - *
> > - * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
> >   */
> >  
> >  #include <linux/pid.h>
> 
> [Severity: Medium]
> Does this code intentionally drop the copyright notice rather than updating the
> name? The commit message only mentions substituting the name.

Ditto.

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
> > - *
> > - * Author: SeongJae Park <sj@kernel.org>
> >   */
> >  
> >  #ifdef CONFIG_DAMON_KUNIT_TEST
> 
> [Severity: Medium]
> Is it intended to remove the Amazon.com copyright notice entirely along with the
> Author line? It looks like this might have been an accidental deletion while
> searching and replacing the name.

Yes, intentional.  People can find I was using amazon corporate email account
when I submitted the patch.

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
> > - *
> > - * Author: SeongJae Park <sj@kernel.org>
> >   */
> >  
> >  #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
> 
> [Severity: Medium]
> Similar to core-kunit.h, is it correct to delete the Amazon copyright notice
> here as well?

Ditto.


Thanks,
SJ

[...]
