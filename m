Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B1188CD5
	for <damon@lists.linux.dev>; Thu,  5 Sep 2024 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725516863; cv=none; b=jmGJ4NhAEHXndtE9LQRof7TStdjp2MUp2QyezCyokAVfxVQ62DRzvvoN5ZYST2TRpVegcZ8r0cIiEGU3znpf2cs41spEmAo24noE9OCUoga3pNYhi+gBWjWEKj9DNUDWXYc8ijKXDPyPAQ6TFE26spaLu8AZFE/RWQPdH8tTqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725516863; c=relaxed/simple;
	bh=5rzzsv4/aAbX0mppnaqfpSYmkTTMG1fugX/siXgMLQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2mk6jTQ1OWxZXSy5/oRDW5vW0Z3GYqYIO3bhK7bRnAqlarHmCwIX804m52gbaueEV/4pysb6gEqy9nYcHNbb6ot6DwoYyvOCuz3jfAQNQADiUyZR+hB5yWt7x9u7HNPrFKTebhOr1epaOPU5Vptj+H1OoyhI+FigJFSbn4e6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtjDAKBl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtjDAKBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB80C4CEC4;
	Thu,  5 Sep 2024 06:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725516862;
	bh=5rzzsv4/aAbX0mppnaqfpSYmkTTMG1fugX/siXgMLQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtjDAKBla6A9SBeMyt98be1oWu14IxGjNHMBX+lh3LdVg2LveImRxEEd91y648+5v
	 zfPc5/mthilIOQIr5l3rqe6Cg9rjSomWtiScl2SMP/p74aVs59euYZaZgDImfsms7S
	 /UCcspNPaakavQMTyXIKJG8kxaCPfHJiZjpeGq5y52erfBvMMIi13Y5ZpwC4kmt4pF
	 nbyn3yGvB36/N9fzY7ZNbWkcMNcpxnzk4E2dr4xO78o/HqtW8OVr2eLhprLwFkFjrs
	 dft3aTpRbFXhtUbfIDvuLGYisca/YVkUyMhgenYSpiuJ77VZsGcqKdbMhR41oYkpAs
	 49WnUjW1q67dw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	damon@lists.linux.dev
Subject: Re: Problems running DAMON kunit tests with spinlock debugging enabled
Date: Wed,  4 Sep 2024 23:14:15 -0700
Message-Id: <20240905061415.1294-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240904175306.1862-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed,  4 Sep 2024 10:53:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Guenter,
> 
> On Tue, 3 Sep 2024 19:46:44 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 9/3/24 19:24, Guenter Roeck wrote:
> > > On 9/3/24 18:00, SeongJae Park wrote:
> > >> Hi Guenter,
> > >>
> > >> On Tue, 3 Sep 2024 12:23:50 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > >>
> > >>> Hi,
> > >>>
> > >>> when trying to run DAMON kunit tests with spinlock debugging enabled,
> > >>> I get the following error messages.
> > >>>
> > >>>      BUG: spinlock bad magic on CPU#0, kunit_try_catch/209
> > >>>       lock: mm.13+0x40/0x840, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> > >>>      CPU: 0 UID: 0 PID: 209 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00148-g178297ec52d6 #1
> > >>>      Tainted: [N]=TEST
> > >>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > >>>      Call Trace:
> > >>>       <TASK>
> > >>>       dump_stack_lvl+0x9e/0xe0
> > >>>       do_raw_spin_lock+0x63/0xb0
> > >>>       damon_test_three_regions_in_vmas+0x121/0x450S
> > >>>       ...
> > >>>
> > >>> This happens because damon_test_three_regions_in_vmas() calls
> > >>> mt_init_flags() with MM_MT_FLAGS, which sets MT_FLAGS_LOCK_EXTERN.
> > >>> Because of this, the spinlock is not initialized, which then results
> > >>> in the error message when mas_lock() is called during the test.
> > >>>
> > >>> Unfortunately, replacing MM_MT_FLAGS with MT_FLAGS_ALLOC_RANGE |
> > >>> MT_FLAGS_USE_RCU or just with MT_FLAGS_ALLOC_RANGE doesn't help;
> > >>> it results in various "suspicious RCU usage" messages.
> > >>
> > >> Thank you very much for this report with the grateful detailed investigation!
> > >> I was able to make and send a fix[1], thanks to the investigation.  Seems it
> > >> may need some more revisions[2], though.  I'll continue discussion on the
> > >> thread.
> > >>
> > >> [1] https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org
> > >> [2] https://lore.kernel.org/jy6263g6em4jsdhp6tknmh2cljpuvq652kvcet4ko3z2xt7pym@ltc5h5twsszu/
> > >>
> > >>
> > > 
> > > Some more problems. I tried your patch on various architectures.
> > > Unfortunately, that didn't turn out well. See below for some of the failures.
> 
> Nice finding, thank you for reporting this!  Just to be clear, seems this is
> independent from the originally reported issue or the fix for it.  Please let
> me know if not.
> 
> > > 
> > > [ I am not sure I understand the code in damon_test_nr_accesses_to_accesses_bp(),
> > >    especially
> > >      .aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
> > >    What happens if sizeof(int) == sizeof(long) ?
> > >    Unless I am really missing something, .aggr_interval will be
> > >    0 in that case.
> 
> I agree.  aggr_interval would be zero in the case.  And in this case,
> damon_max_nr_accesses(attrs) in damon_nr_accesses_to_accesses_bp() returns
> zero, so damon_nr_accesses_to_accesses_bp() will get a divide by zero problem.
> That is, the problem happens when damon_nr_accesses_to_accesses_bp() is called
> with zero aggr_interval, regardless of the architecture.
> 
> > > ]
> > > 
> > The diff below fixes the problem in damon_test_nr_accesses_to_accesses_bp().
> > Obviously I don't know if this is the correct fix.
> > 
> > Guenter
> > 
> > ---
> > diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> > index 0cee634f3544..8072f83b2bba 100644
> > --- a/mm/damon/core-test.h
> > +++ b/mm/damon/core-test.h
> > @@ -309,6 +309,9 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
> >                  .aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
> >          };
> > 
> > +       if (sizeof(int) == sizeof(long))
> > +               kunit_skip(test, "Test requires sizeof(int) != sizeof(long)");
> > +
> >          KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
> >   }
> 
> So, above fix would work, but I think doing the skip if the resulting
> aggr_interval is zero would make more sense.  Having more comments would also
> be nice.

Now I think this is enough fix for this issue, since this test code is only
place that can trigger the issue.  More detail below.

> 
> Nonetheless, if the issue can be triggered outside of the test, we may need to
> think a better fundamental fix.  And seems it is the case.
> 
> Sharing current incomplete findings here first.
> 
> First of all, users can set the zero aggr_interval.  And the problematic
> function (damon_nr_accesses_to_accesses_bp()) is called when user updates the
> intervals while DAMON is running, with the old intervals attributes.  Hence,
> users could trigger the issue by making DAMON to run with zero aggregation
> interval, and then updating the intervals to any values.

It turned out this is not the case.  Only the test code can trigger this issue.
The only possible callstack for the problematic function is as below.

    damon_nr_accesses_to_accesses_bp()
    damon_nr_accesses_for_new_attrs()
    damon_update_monitoring_result()
    damon_update_monitoring_results()
    damon_set_attrs()

And damon_update_monitoring_results() does not call
damon_update_monitoring_result() if the aggregation interval of the old context
is zero, as below.

    static void damon_update_monitoring_results(struct damon_ctx *ctx,
                    struct damon_attrs *new_attrs)
    {
            struct damon_attrs *old_attrs = &ctx->attrs;
            [...]
    
            /* if any interval is zero, simply forgive conversion */
            if (!old_attrs->sample_interval || !old_attrs->aggr_interval ||
                            !new_attrs->sample_interval ||
                            !new_attrs->aggr_interval)
                    return;
    
            damon_for_each_target(t, ctx)
                    damon_for_each_region(r, t)
                            damon_update_monitoring_result(
                                            r, old_attrs, new_attrs);
    }

Hence, again, only the test code can invoke damon_nr_accesses_to_accesses_bp()
with zero aggregation interval.  Hence fixing the test code and adding comments
would be sufficient for now.


Thanks,
SJ
