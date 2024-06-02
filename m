Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCFB433D0
	for <damon@lists.linux.dev>; Sun,  2 Jun 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342304; cv=none; b=p6mZh18dDVp8tE7EVBCsyiVhfDmzlXWLpRZdLbMgOk1ZgMTUPIkylP4QzAqq9hWaxtMuUoagy7ZFxV87OCI2kXKBYU1JqubFfvqQG1BF9xpvmoY6W1yrtZyToTVxul5rqsOP41PGL07v+uBtOiLZDdZkfd8NzJHiDZkO7mqre0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342304; c=relaxed/simple;
	bh=rNBnPWcv/UT24JI/E+LCM1Eixw1GOAQgxs2uWjTqgKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDkkbXCaeQeMYSvUPRdpCN7UQg1vidNckftfTgKplzci6r2myIxvM2uJroENMI3nnU8lprPzyUfen2K/q8AYQiIMqJcki1z6vefVE+wRmizLv9xhBN4m1A8TpPltlaGDkGihu/Rk/knmtsTRpW0sc5yxuarx8hriiOd/9Dy+j9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsINLlEN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsINLlEN"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e72b8931caso40051811fa.0
        for <damon@lists.linux.dev>; Sun, 02 Jun 2024 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717342300; x=1717947100; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ef+jPbCl/Q2MIEYpCmzzicRwWRwVQMPXcaN6w64uiM=;
        b=VsINLlEN6jp+yp2RZu31n72GuHSGNCwF8i/OYbHRcvR3aWPhssLcybqj//7k2Upcl+
         bWReKlE9Vk/3zGCyul9PU7tGWxqaRg/mB3ELpTNTFXaCYnm/itt2hrDNFQ3ztCGhHjXj
         PKYjrDSJuPtKZjTk/QhEZDZ4/tUZahYABNDMMmPGKu6mrZIxY+jEFUtSDUzYFVKLSN9e
         K1d9Dd5778Y8W7WPjUgeJ72rr6NEJ7cVZQXrZHX9JvVO7yu1XkmmbfYIS5wYW4mkIMve
         h2Vn1dzZeNYSQswjl3V5OTXIiyuxB/G3J+ccdNIpK3EInJlaEDkAMiRbeWg/SPW3SUNE
         0vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717342300; x=1717947100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ef+jPbCl/Q2MIEYpCmzzicRwWRwVQMPXcaN6w64uiM=;
        b=KwCblKvExmffqdI91OmqXy6URHVATJEzBHbWhlvXzyyDxc/jO+4c6Ft7qb77kO5EkZ
         Cht2ICMQBwD1da7NltHu8w4l+p8SVph7DUmZyVYYZRRKfRJHM9kyJ4e8aHOfO5Wrf0Zx
         hF00RzHSmvmpKne6z9fbYDGDMrZZXsP/BBkkfCY5Cd1SR/HHD8/oQOAPe3+iqtKl7pz7
         XPNvTAuDUNRz4FPSTlxp/G7YwzrVTKgKHnDrfAifQZjZk9lDRT4PZlVcWBrzolZfU3Jk
         8Pz+EI12/ZTtChoP38PCIZSj3/STCduZrkzac/BMrT+hq1BOjFJdF+Sl/7mrkhvbMUm2
         aXEw==
X-Gm-Message-State: AOJu0YxcggRjH0NkW3qm9Av5xFQPl/cQHenefiW6mlraRQ8RgOlz/OwS
	YvOU4CXxjhkowZ/omH+bpyYHSMqVjRn64SZCWY9FLOmcmarpCmff
X-Google-Smtp-Source: AGHT+IFIStiDV5vU5Y0oUwFpyaRIxaKDE45IOTn0TWg6IK6lX2Mk28N1js/u5dlXb1ju4AViWHXdqA==
X-Received: by 2002:ac2:544c:0:b0:52b:82d5:b36a with SMTP id 2adb3069b0e04-52b8957fe73mr4228460e87.2.1717342300040;
        Sun, 02 Jun 2024 08:31:40 -0700 (PDT)
Received: from localhost.localdomain ([176.59.170.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d894c3sm969583e87.249.2024.06.02.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 08:31:39 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yorha.op@gmail.com
Subject: Re: [PATCH v2 0/2] DAMON multiple contexts support
Date: Sun,  2 Jun 2024 18:31:02 +0300
Message-ID: <20240602153102.926789-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240531193307.71424-1-sj@kernel.org>
References: <20240531193307.71424-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi SJ,

> Hello Alex,
> 
> On Fri, 31 May 2024 15:23:18 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:
> 
> > Currently kdamond uses only one context per kthread
> > and most of its time it sleeps, so utilizing several
> > contexts can scale kdamond and allow it to use
> > another set of operations.
> > 
> > This patch-set implements support for multiple contexts
> > per kdamond.
> >
> [...]
> > 
> > ---
> > Changes from v1 (https://lore.kernel.org/damon/20240515152457.603724-1-yorha.op@gmail.com/)
> > - Compatibility for DebugFS interface is kept
> > - Kunit tests build/execution issues are fixed
> > - Patches from v1 are sqaushed, so that consistency between patches is
> > kept
> 
> My request was to avoid unnecessary temporal changes that will be removed in
> next patches.  Some of those are well removed in this version, but I still show
> some.  E.g., nr_contexts field.  Also, this resulted in two big patches.

This makes sense and I actually wanted that as well, so I tried to separate
them in previous version, looks like I misunderstood your request.

Anyway, don't you mind if lru_sort/traceevents/etc. will not function
correctly without applying the whole patch-set? I mean if we use the
approach below, once core.c is modified at least lru_sort and reclaim
will not work correctly, they even will not be built.

> 
> I'd also appreciate if you can separate changes into smaller ones of logical
> single change.  For example, changes for lru_sort.c, reclaim.c, and sysfs.c on
> first patch could be much smaller in my opinion.  Traceevent change can also be
> separated from patch 2.  Some of multi-context support seems mixed in patch 1.
> 
> I'd suggest below patches flow.
> 
> Patch 1: Introduce new struct and control functions for the struct.  Don't
> really use the struct and the functions.
> 
> Patch 2: Modify core.c to use the struct and implement multiple contexts
> support.  Minimize changes to core.c users.  Just keep those work as before.
> Don't implement multi contexts support on sysfs.c or trace events at this
> point.
> 
> Patch 3: Update sysfs.c to support the multiple contexts.
> 
> Patch 4: Update trace events to better support it.
> 
> > - Added/Fixed comments about data structures/functions
> 
> Also, you don't need to put version history under '---' marker if it is a cover
> letter.  You can put it on the body.
> 
> > 
> > Alex Rusuf (2):
> >   mm/damon/core: add 'struct kdamond' abstraction layer
> >   mm/damon/core: implement multi-context support
> 
> I will try to put more detailed comments on each patch.
> 
> > 
> >  include/linux/damon.h        |  80 ++++--
> >  include/trace/events/damon.h |  14 +-
> >  mm/damon/core-test.h         |   2 +-
> >  mm/damon/core.c              | 509 ++++++++++++++++++++++-------------
> >  mm/damon/dbgfs-test.h        |   4 +-
> >  mm/damon/dbgfs.c             | 342 ++++++++++++++---------
> >  mm/damon/lru_sort.c          |  31 ++-
> >  mm/damon/modules-common.c    |  35 ++-
> >  mm/damon/modules-common.h    |   3 +-
> >  mm/damon/reclaim.c           |  30 ++-
> >  mm/damon/sysfs.c             | 303 +++++++++++++--------
> >  11 files changed, 872 insertions(+), 481 deletions(-)
> > 
> > -- 
> > 2.42.0
> 
> 
> Thanks,
> SJ

BR,
Alex
