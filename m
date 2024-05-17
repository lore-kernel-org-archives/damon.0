Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2F1D53F
	for <damon@lists.linux.dev>; Fri, 17 May 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935997; cv=none; b=ibfEMuzhzbRJ76WQCKZEreejiH2EHjURc2TP/P5ZQxMCJaPjVdgjvWxLHtNquHRrr62U5AtIAgxksus3N2EaBsrK75F8oWcBGdjGthuYlVXW+c69AktLKf4nc5IbW/Ir36ZKLuD85QsaqTE1wE9raNTAnHOudS7aLRHco+jLjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935997; c=relaxed/simple;
	bh=XrDZ2khBHaMtsbW3DKfVfsmfyIUUQMmLqt5TAhl53cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qifIqUTbZT3wr4KT7VhY1bFvOS+acXD0s1Ehsu88zCV9yYUB1u2QXMECJS6oy2vJQ14q7d3+UOCdHGOsjOjvnb+pfRsco4A64BREuoanGm6qa8HQsmzC8vE69/M/iQTEZicD+1ksVktz2++jkpjd+RbyLIRtgqxo9za93vq1pnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POjK1r/f; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POjK1r/f"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-523b20e2615so2131895e87.1
        for <damon@lists.linux.dev>; Fri, 17 May 2024 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715935992; x=1716540792; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUnKK06+m9zxF848R1qs8HU2+D2Pu7/Qze/DSdxTlEg=;
        b=POjK1r/fKb4D9ctjb6gKRkewxsKk8AgDB6zwxc1dZUnZtJJYXHs4rua/53mulzkqvN
         knopGCfwXhDnbRXRZ+4NGNwiNwNnXNrBp6A+c+qgL0tlUja216yCsjs5gXSHHu4KsQoX
         11eT0wOCFX89MmlCgq2e6CpMHWxJ5XXzqoClIBfdCo9ye2HGemmDbMJLnFkNQGUGpsj2
         EsWXMY0T8hdgdxNgkUMVTMGWUzHshKSHunAPpt003jSNdWHXRfqRFDNvMc8nxSMvLNEz
         tjE/oGT6NwsUuX58M/rryui0L42TTgyON9+YDn0rbmHnvgMLco4QkjTrE0sAx6+yGmFX
         sC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715935992; x=1716540792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUnKK06+m9zxF848R1qs8HU2+D2Pu7/Qze/DSdxTlEg=;
        b=tZJW/SGXuajyefe7p9Zx5AV8HfPlViiJ28OzuPGVQ/HvRlQilAHVJIxWFt5I99HJG1
         Ze0EfGc5eK6dr0OErSc4caLHmLbjzNEk8IjD4JO4Lt7BV2UB97tC2t3JS9rXs10bU7d9
         q/Km4ezmrXBqNBD5TJ0ftWvp7pA5Bc/O/3bOUOv7PeU24zLN3Cr+M3Ypm1QdANyjTC1h
         L2amFBDNhKpTUiSooLLvmYmJO9UeSuj4W54l0wKU4jUmYDIxYWtqFSzxr1JaXwcUCSNf
         mi87vd5QbeeSrg5sU4ZDM6YLi39tXQWiFeriJwAL4ajGUBLCF5/mM6RGy0o3qY7mTdVW
         QK8g==
X-Gm-Message-State: AOJu0Ywz/uQtXzHFHsXn04+qSpenK58bm2aHQFH2uhCabOXsr1XeUp91
	hxTFWHtSiwc6oW32C86ayhydkQhuiTofTbne/FaOvVnQJqx2ILpl
X-Google-Smtp-Source: AGHT+IGUGh68rD9VDYg5VoPspmITc/Dg5WaWIbDgsVs4E0iJoDyb8ifLul6q44yypgR7DR/ARf//Lw==
X-Received: by 2002:a05:6512:2003:b0:51e:25d2:453f with SMTP id 2adb3069b0e04-5220ff72f1dmr10395650e87.68.1715935992194;
        Fri, 17 May 2024 01:53:12 -0700 (PDT)
Received: from localhost.localdomain ([176.59.160.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2c8fsm3209359e87.279.2024.05.17.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 01:53:11 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yorha.op@gmail.com
Subject: Re: [RFC PATCH v1 0/7] DAMON multiple contexts support
Date: Fri, 17 May 2024 11:51:51 +0300
Message-ID: <20240517085151.630844-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240516221735.82564-1-sj@kernel.org>
References: <20240516221735.82564-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi SJ

> Hello Alex,
> 
> 
> Adding high level comments first.  I will try to read each patch and add
> detailed comments to those as soon as I get some time.
> 
> Also, please Cc linux-mm@ for DAMON patches.  I'd also recommend cc-ing
> linux-kernel@.

Thank you for clarification, I'll add them!

> 
> On Wed, 15 May 2024 18:24:50 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:
> > Currently kdamond uses only one context per kthread
> > and most of its time it sleeps, so utilizing several
> > contexts can scale kdamond and allow it to use
> > another set of operations.
> 
> Thank you for this patchset.  I believe this change is important for DAMON's
> long term vision.
> 
> A quick question for a clarification and proper prioritization, though,
> since size of this patch series is not very tiny.  Does this patch series
> is for your real usage?  If so, could you please clarify your usage and how
> this patch series can help?

No, this is not for some commercial use or so that I could describe. It is
rather just a RFC, because I'm even not sure how much this can help
in real use cases.

> 
> > This patch-set implements support for multiple contexts
> > per kdamond.
> > 
> > In pseudo code previous versions worked like
> > 
> > the following:
> > 	while (!kdamond_should_stop()) {
> > 	
> > 		/* prepare accesses for only 1 context */
> > 		prepare_accesses(damon_context);
> > 		
> > 		sleep(sample_interval);
> > 		
> > 		/* check accesses for only 1 context */
> > 		check_accesses(damon_context);
> > 		
> > 		...
> > 	
> > 	}
> > 
> > With this patch kdamond workflow will look
> > 
> > like the following:
> > 	while (!kdamond_shoule_stop()) {
> > 	
> > 		/* prepare accesses for all contexts in kdamond */
> > 		damon_for_each_context(ctx, kdamond)
> > 		
> > 			prepare_accesses(ctx);
> > 		
> > 		sleep(sample_interval);
> > 		
> > 		/* check_accesses for all contexts in kdamond */
> > 		damon_for_each_context(ctx, kdamond)
> > 		
> > 			check_accesses(ctx);
> > 			
> > 			...
> > 	
> > 	}
> 
> The overall idea makes sense to me.
> 
> > To try this you can use modified kernel[1] and
> > damo[2]. I also have written few simple shell scripts[3]
> > to collect data for damo.
> > 
> > 	[1] https://github.com/onlyoneofme/damon-multi-contexts.git
> > 	[2] https://github.com/onlyoneofme/damo/tree/multi-contexts
> 
> Looking forward to the patch for DAMO be submitted, or PR-ed!

Sure, I will submit a PR for DAMO later. I supported only 'record'
and 'report heats' commands, so others haven't touched, that's
why I decided to post it there (because it is not ready).

> 
> > 	[3] https://github.com/onlyoneofme/damon-multi-contexts-tests.git
> 
> Do you have a plan to integrate this into DAMON selftests or damon-tests?

Not in the form they are for time being. These are just simple shell scripts
that set up kdamond to use multiple contexts and these scripts only
collect information like DAMO (but only as perf.data).

Anyway, I think we can integrate them with damon-tests with some modifications
to be able to actually _test_ if multiple contexts work.

As for DAMON selftests, I didn't touch them for time being, so they truly
need to be modified and expanded, but before doing that I would like
you to look at implementation first, because changes in implementation
could affect selftests, so once we agree on that I will implement selftests.

Also note, that I didn't integrate changes with debugfs. I remember this is
deprecated interface, but I'm not sure if compatibility need to be preseved
with it, so do we need to expand debugfs for this?

> 
> > Alex Rusuf (7):
> >   mm/damon/core: kdamond_struct abstraction layer
> 
> Let's make the subjects clear what it does.  For example, this patch's
> subject could be "add kdamonds_struct abstraction layer".  Similar comment
> for other patches.  Also, I think '_struct' suffix of 'kdamond_struct' is
> not really needed.  Let's remove it if there is no special reason to add
> it.

Sure, I'll change that in next version, thanks!

> 
> >   mm/damon/core: list-based contexts organization
> 
> I think this can be squashed into the first patch?  If not, could you please
> let clarify?

I just tried to separate those patches for them to be as simple as
possible (actually I failed at that...), but sure, we can squash them.

> 
> >   mm/damon/lru_sort: kdamond_struct abstraction layer
> >   mm/damon/reclaim: kdamon_struct abstraction layer
> 
> Does these two patches mean lru_sort and reclaim are broken by the first
> patch? Let's keep everything unbroken in middle of the patchset, to help
> bisect.

Yes, they're broken by the first patch, I'll squash them, thanks!

> >   mm/damon/core: rename nr_running_ctxs -> nr_running_kdamonds
> 
> I think this would also better to be together with the first patch?  I know
> this does not break something, but makes reading patch bit complex.

No problem, thanks!

> 
> >   mm/damon/core: multi-context support
> >   mm/damon/core: multi-context awarness for trace events
> 
> I think these two patches should be squashed into one patch.  Otherwise, the
> trace point is broken in the middle of the patch series, right?

You're right, I'll squash them, thanks!

> 
> >  include/linux/damon.h        |  48 +++-
> >  include/trace/events/damon.h |  14 +-
> >  mm/damon/core.c              | 497 +++++++++++++++++++++--------------
> >  mm/damon/lru_sort.c          |  31 ++-
> >  mm/damon/modules-common.c    |  35 ++-
> >  mm/damon/modules-common.h    |   3 +-
> >  mm/damon/reclaim.c           |  30 ++-
> >  mm/damon/sysfs.c             | 306 +++++++++++++--------
> >  8 files changed, 629 insertions(+), 335 deletions(-)
> 
> Thanks,
> SJ

BR,
Alex
