Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955329A5
	for <damon@lists.linux.dev>; Fri, 24 Jan 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739297; cv=none; b=b6xpV3Ph30DftNGJucShdi/75diSvtgFV5LKH+6mJbIEjlzsNOVRpT+157dUE8X9a8hJyk5uG5O/UUHCVk1qCKj/x0kM4hh4DBmQeD53h6ABAOMRh71RTOIz2odgauwSscYfRxJVAhwnRIKv3WjD8TcOOA07SeE6z020yHVhlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739297; c=relaxed/simple;
	bh=RCsXLbFbcjK2A6fcIC5BQ9KCXqNv0ytMI1iNPhTI6Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSM4kozVHdc3mh8fIj6k6NL99ZyAukWQwBZno8PpAAKu04aS1x/Zh0KzygH5RGs2eItRQJnJO+P/r/sHC4jyKu/LC+g7hhP4xzPF9D+V8SQ1HqxzMq/t+m/Gzh5qAaLHY0goZkEudd+++Pg6oxZHW7sd1ONBYKS88Z4m9dzIaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IkEMUyOD; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IkEMUyOD"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6f75f61f9so326037885a.0
        for <damon@lists.linux.dev>; Fri, 24 Jan 2025 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737739294; x=1738344094; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JpBMlffQq/AmVURDmJqZIAknLMu8Pltvl96VGpNVI6w=;
        b=IkEMUyODKOUC5IGwVWf0rmT/wirPxBXr5GiK17MURqOtgtbVQ2EoAUPfGpP10j/MkD
         qJjkrQnAX10OZCRiq12yXdzocTKdMiuRNoQH/zyqVafZqmvU0y+V/psL2YyRwonI3GUA
         sslx7avBMk7lSKrhEuK9Osbl0bRmojwuli6zSEUpzamic7EufHVyzfk0QrdPBr5b+xAZ
         PKJFabFRUsx+bJTo2AoxIe0Mlr6oqxhY2HmCuedS0E8XqwtXT5UugFw7YG7RRewPBWBQ
         tSfh37YdixQRIaJxDeeNNq0PXUxng5jIPofiLI7Z9Gucp6JgSy3eqyURRWG0B2JD4sPi
         mOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737739294; x=1738344094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpBMlffQq/AmVURDmJqZIAknLMu8Pltvl96VGpNVI6w=;
        b=BiZDl5uN0nP6vD+IVXYGGvu+jwMnDOHPJR/hU3oRQsRP0Y6rq8ct0afCHAKsqiM9cU
         B/nicE+z6kv962ctDsueSRo3F/i4iNkZCfVOmRwteUx4+Pq4oMt6nkcHUk1c8x+2I366
         jJDCeEgcPiVK8RgKi6C3zdqE3OhTLS8EvTfS4JskaUpOhsatnSMQgfuIIZM2eOoH4hH7
         n3xKWfGA+vXAGPqzNbbwdwZULG0U98zNmVJvtwA5ocnprJy6rLWSzaiz3NCRienpdtAI
         QZsBqxcwyBTZ3eZpENHvpN/JX8ie2SfSgr+RilbDJbZ0bCa5T1aWICPhW3mMPJYhNLot
         QSTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/2RhpLoeKzYYQqTl0tZ4S+jdqfdyd9UJzc77k/YzLAzeSytEAw5e2IH3si9zXfb3WuWHBhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIjqW5q+0qp5vzuPV6XurLCnfhbYDc1MdtirTT4KR+ng7kYIvz
	BKhDZYB0VqSyr/wfheZfI/xzLWYgdXuRi9BC3pW1NIT/rwIOe1KYtAfw5OnDp4w=
X-Gm-Gg: ASbGncugpmTjtTO/v4ZI7OvraAJ8DEA36Ipmj39nNgxrwPLPYPPXfd0nqXkuIZ4ZX+Q
	hijPctbj7wXwoTwDiB4r67ZaQRY7zKiy8v0TruhC966cxyVlJhWBLD/rtIHi/kunjudZaaFMyAv
	kMj1ffFo6XgEkhFKqqfz3eYcGMbbNabf5r9jjdaslz7JSEhTIqoKQesIWjXtWbsmBUI01aQHyUj
	PaWOcGaJhEPbDcSbnBku49ZonOc+/OdHMmKWBgMQAKV4VVjwzAdGOlXRLWWaDn10cmselOMikGn
	WeqS7ZqqKf7Qf7PxAY8XM7yALsKtxrbDuC5P3x4OKdBghJgqAJP4VaHZwRl+cv0=
X-Google-Smtp-Source: AGHT+IH3fhXb3bOkGIW4xZiUVxwtmeBpzr0Mn/GhdnkWq3CbqtmVe+oX1U58/Sxdrz8CjUkPr8Greg==
X-Received: by 2002:a05:620a:24c8:b0:7b6:eab3:cdd1 with SMTP id af79cd13be357-7be6325dc77mr5522744185a.49.1737739293908;
        Fri, 24 Jan 2025 09:21:33 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9af0d1efsm112515585a.101.2025.01.24.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 09:21:33 -0800 (PST)
Date: Fri, 24 Jan 2025 12:21:31 -0500
From: Gregory Price <gourry@gourry.net>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Raghavendra K T <raghavendra.kt@amd.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>, Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of
 Future
Message-ID: <Z5PMG_F9wJXCb8ri@gourry-fedora-PF4VCD3F>
References: <Z4XUoWlU-UgRik18@gourry-fedora-PF4VCD3F>
 <20250124021153.103622-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124021153.103622-1-sj@kernel.org>

On Thu, Jan 23, 2025 at 06:11:53PM -0800, SeongJae Park wrote:
> Hello Gregory,
> 
> > 1) The cost of checking promotion candidacy can be problematic
> > 
> >    In my microbenchmark in the last RFC version, I showed that while
> >    the performance upside (~22-25%) is substantial, there was a
> >    non-trivial cost associated with injecting even a single global
> >    boolean check in the file_read() path.  This was unexpected.
> > 
> >    I can probably optimize the disabled case with a likely() clause,
> >    but I did not expect such sensitivity.  This tells me injecting
> >    an unconditional call into DAMON may be too much overhead. 
> 
> I cannot agree more with you about the point that the mechanism for finding the
> promotion/demotion (and any access-aware system operation) candidates should
> induce only modest or at least controllable overhead.  Actually it was the one
> of biggest motivations of DAMON design, and I haven't imagined adding
> unconditional calls to DAMON here.
> 
> Nonetheless, injecting an unconditional call here should be avoided for not
> only DAMON calls but any expensive calls?  I'm also not pretty sure what DAMON
> call you are thinking about.
> 

Just any call, DAMON or otherwise.  The explicit check injecting ~2-3%
overhead on my microbench was a simple

+       } else if (!folio_test_isolated(folio) &&
+                  (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&

If this is causing additional overhead, call me skeptical that trying
anything more complicated will turn out better.

> > 
> >    I would need to explore this further - including whether it is
> >    feasible to inject such a large dependency into swap.c
> 
> I understand DAMON is not small in terms of the code size, and has many
> limitations that makes it unusable in many use cases.  But, again, I'm not
> pretty sure what kind of DAMON usage in swap.c you're thinking about, and
> therefore not easy to understyand what part of DAMON is considered as a large
> dependency that concerns you.  It would be great if we can make more concrete
> example as a result of this topic session at LSFMMBPF.
> 

It's not a matter of code size - it's a matter of tightly coupling core
components of the kernel to extraneous ones.  Adding additional
dependencies between components increases overall system complexity and
makes it hard to reason about the behavior of the system.

For example, in the prior snippet:

+       } else if (!folio_test_isolated(folio) &&
+                  (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+                  numa_pagecache_promotion_enabled) {
+               promotion_candidate(folio);

This amounts to

if (some condition && feature enabled)
	mark a folio as a candidate for promotion

The promotion_candidate() function is contained within migrate.c and
uses (mostly) migrate.c mechanisms (from a task_work).

All you need to understand the behavior is between swap.c and migrate.c.

If instead you aggregate this to DAMON, understanding the behavior of
swap can require you to understand what DAMON is actually doing with
this information.

Now you need to understand swap.c, migrate.c, AND DAMON.

It makes it more difficult to reason about the system when something
goes wrong. This increases the maintenance burden for maintainers (and
onboarding complexity for anyone new to the kernel, for that matter).

That doesn't mean we shouldn't consider doing this - it just means that
benefit needs to outweight the complexity/maintenance cost.

> FYI, I also not having specific idea for helping unmapped pages promotion for
> now.  That's my assignment that I will do by LSFMMBPF.  But, a few things that
> I naively thinking DAMON might be able to help unmapped promotions are,
> 
> 1. Using DAMON for profiling how much hot and cold unmapped pages are in which
>    tier, and use the information for unmapped pages promotion optimization.
> 2. Using DAMOS to target-promote hot unmapped pages while using page
>    faults-based promotion for mapped pages.
> 3. Using DAMOS to promote both mapped and unmapped hot pages.
>

This missing the scenario where DAMOS/DAMON is not suitible for
deployment in someone's environment.  The kernel should still do
*something*.

And that is kind of the point - we can expose more complexity to the
users with DAMON, but the kernel should be able to do some reasonable
promotion action without this additional system.

> >    but I
> >    also see value is making tasks handle promotion as a form of fairness.
> 
> I agree that could be good in terms of fairness.  I want to learn more about
> the significance of it, though.
>

Fairness in this scenario is simple.

If one task is causing an outsizes number of promotions to occur, and it
causes some ASYNC system to handle those promotions, it is effectively
acquiring more CPU time via that ASYNC system than other residents.

Trying to charge this time back to the noisey task is harder than just
having the task incur the cost of migration.  But doing it inline can
cause the task to slow down.

So it's difficult to predict how it's going to pan out.  Need evidence.

> I agree.  DAMON allows combining multiple different mechanisms with its core
> logic, so I beleive it migt be a place that can aggregate the different
> identification mechanisms.
> 
> DAMON's access monitoring results based system operations feature, namely
> DAMOS, also has its own aggressiveness control logic, and resides in the core
> layer, so could be used consistently with different promotion candidates
> identification mechanisms.
> 

Without data this is a nice thought, but we have existing mechanisms
that work and can be improved - lets not disrupt that.

Finding an aggregated promotion solution helps everyone move forward
without disrupting development in these areas (and makes the different
indentification mechanisms play nice with each other).

Trying to also create a voltron "one indentification system to rule them
all" is a nice thought, but it's heavy-weight compared to adding a folio
flag check and a call to mpol_migrate_misplaced().  We need to respect
that reality and not regress the existing mechanisms by trying to
over-engineer a generalized solution.

~Gregory
