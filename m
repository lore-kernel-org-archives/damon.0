Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D911A683B
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335775; cv=none; b=M36XcpOHfJHyYPyUIPgoaW4f+UK3yKzDVCTW3OmvY9mKyYnARKqg5wXRImZTgFvpowXU2gUXX5jnbGAPTQwR3++8ceEAMLb/XcfQe5dIXYOAO/RFu2ozhlbUoSjNkJFQ95Et7qMxbHtrN9pV1s91bVh6DA6tGa5IeZeIZaZmPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335775; c=relaxed/simple;
	bh=YBd0ErdcH7TGGI0VTJokjtWZKRAfFb5eB4OLx4C+5kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh7Uj2SGndsvqzgDrChhCL4laLFcabAzWRxzCzkECBmvBPQ5FfAUBlPFOmICHiPbl64xB3PUHtD5670o8Csm3jnw0PPrILLm8VPbbpjZvyZwEcnnDIK9HcZbo2m44BnjhTnNFMI3Zi98Tk5GTBNaM1roZ4weEoxcUQAIIOESwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TS2aUBQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TS2aUBQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCDFC19425;
	Tue, 28 Apr 2026 00:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335774;
	bh=YBd0ErdcH7TGGI0VTJokjtWZKRAfFb5eB4OLx4C+5kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TS2aUBQQAH/zUgrn168LTCODhdp4lQI0lY+HWjE4wTd20MNo1vECxk8RxvBHrVrKC
	 Yy+F26kg9XcBayuzKaJ/c3/2qqKb1QdEHWL9xtozv3pbe5NONOAq2XDrt/6L22Tg+Y
	 zsfalbTrqhU0Ovlk7I/O9QA4JMbbSRAjNicaSpqhJnW3wURkFdDx8gnOJOLZjEMNHO
	 S2mvhvwgBnc11MmWLgn+HOFGeySJ9P2Z8dLYylXq37v+ulhJMJfcA3hHCoJVD+fetm
	 G8XzDfFxJel7sgep7kuOVfz/HxASrSj9tfFz2YmyIxGEG/ncm2K14aFM71/FwnAwa9
	 y8v/qzDFB7U3A==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 10/10] selftests/damon/sysfs.py: pause DAMON before dumping status
Date: Mon, 27 Apr 2026 17:22:45 -0700
Message-ID: <20260428002246.112905-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427210420.12AEDC2BCB6@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 21:04:19 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [Medium] Mutating the state before assertion bypasses the verification of the original `pause` state.

Not a blocker of this patch in my opinion.  Please read below for more details.

> --
> 
> commit 2c32bc147a1cb335e85629e00bb0efe1bbb44638
> Author: SeongJae Park <sj@kernel.org>
> 
> selftests/damon/sysfs.py: pause DAMON before dumping status
> 
> This commit updates the DAMON sysfs selftest to pause DAMON execution
> during state dumping. It attempts to prevent race conditions where DAMON
> could add or remove regions while the dump is ongoing.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> > index e6d34ba05893..b8d6e0f8fd90 100755
> > --- a/tools/testing/selftests/damon/sysfs.py
> > +++ b/tools/testing/selftests/damon/sysfs.py
> > @@ -193,18 +193,55 @@ def assert_ctx_committed(ctx, dump):
> >      assert_true(dump['pause'] = ctx.pause, 'pause', dump)
> >  
> >  def assert_ctxs_committed(kdamonds):
> > +    ctxs_paused_for_dump = []
> > +    kdamonds_paused_for_dump = []
> > +    # pause for safe state dumping
> > +    for kd in kdamonds.kdamonds:
> > +        for ctx in kd.contexts:
> > +            if ctx.pause is False:
> > +                ctx.pause = True
> > +                ctxs_paused_for_dump.append(ctx)
> > +                if not kd in kdamonds_paused_for_dump:
> > +                    kdamonds_paused_for_dump.append(kd)
> > +        if kd in kdamonds_paused_for_dump:
> > +            err = kd.commit()
> 
> [ ... ]
> 
> > +    # restore for comparison
> > +    for ctx in ctxs_paused_for_dump:
> > +        ctx.pause = True
> > +
> >      ctxs = kdamonds.kdamonds[0].contexts
> >      dump = status['contexts']
> >      assert_true(len(ctxs) = len(dump), 'ctxs length', dump)
> >      for idx, ctx in enumerate(ctxs):
> >          assert_ctx_committed(ctx, dump[idx])
> 
> Does this bypass the verification of the original pause state?
> 
> By temporarily pausing the DAMON context and committing this new state
> before dumping the sysfs status, the test overwrites the actual pause state
> in the kernel. Then, setting the Python object's ctx.pause to True for
> comparison means the test always compares True against True for the pause
> parameter.
> 
> Because of this, the test seems fundamentally incapable of verifying
> whether a pause = False configuration was ever correctly committed to the
> kernel prior to calling assert_ctxs_committed().

This is an intended behavior as I explained in a previous version.  We are
using pause for testing.  Testing something that being used for testing with
the test itself is complicated.  It would be good to have a test for the
feature for the test itself in a way, but not necessarily by the test the
feature is helping for.  We have at least pause parameter commit kunit.  So I
think this is not a blocker of this patch.


Thanks,
SJ

[...]
