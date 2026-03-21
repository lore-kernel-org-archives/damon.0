Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272140DFB2;
	Sat, 21 Mar 2026 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054926; cv=none; b=iCpFidn+bwJpLe+bo5joAU589DVmMPrUq76mNtZK+u5gBNLf1o6AnGpusefqytpdh2ClDqOTKekQnhQgHG7uviGDL1e4MwJcppPwuWUvHNsQT3SIwsQKbClzgVOZ84ZjccErArGoq4p+JOXyJ1NLgAk0gSYSpaNw1R5XJS1CaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054926; c=relaxed/simple;
	bh=0yYB8TFfBq7hSyyiDU6/wS7/MxpcVDUgHb7ZxIWACZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMNnX82WFXaApxAD3PtBhpKSGsnrWv95KA8d4aNBl69/r+PGAeJ7ypUDBb745hBe2PSnl5p6/uIDRQh9MM1eESphiW6gAzJp5IuiH5UuK37iWz+dG212Vbgp8LPjdB49vkGuI9MGkwsNpLLSJ3ikLx5gfriOQBKbAcXZZ/hCyyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMpMpIhY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMpMpIhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC03C4CEF7;
	Sat, 21 Mar 2026 01:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774054925;
	bh=0yYB8TFfBq7hSyyiDU6/wS7/MxpcVDUgHb7ZxIWACZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMpMpIhY+oJin9kFaNMgEx8u1rCcFnwjvNXXicnucVhUrhHq92rJfctXXDBpMFS6N
	 wiiKMbngcuEeCcNZIkz76p5WAgzgjnlKFdoG6Jw1qxKegJDCq431XVWWrkml2BJP8t
	 YAuf+cCK/e1U2bd1CLuyIiB8dmtjHSHIcl8Xiw4F/Izdv3v+63VoRFvgR918XTieVu
	 /elS6A9JwPTFaHxiQYSq/azAydQg1+N3Of8aLJSibOISuGAYKPtvi29QJe3MYev0S1
	 czivg0DIhShYu/K9QgeDXNQDUiFAYVCA49XubWxPrZhRUyvBTX8hk1N2jDg3rnuA9l
	 jkwiy35UJdR2A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
Date: Fri, 20 Mar 2026 18:02:00 -0700
Message-ID: <20260321010201.82092-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320154134.99740-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Mar 2026 08:41:33 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 20 Mar 2026 08:29:39 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Adding Sashiko comment
> > (https://lore.kernel.org/https://sashiko.dev/#/patchset/20260319052157.99433-11-sj@kernel.org)
> > with ': ' line prefix, and my replies in line.
> > 
> > On Wed, 18 Mar 2026 22:21:53 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > The sysfs.py test commits DAMON parameters, dump the internal DAMON
> > > state, and show if the parameters are committed as expected using the
> > > dumped state.  While the dumping is ongoing, DAMON is alive.  It can
> > > make internal changes including addition and removal of regions.  It can
> > > therefore make a race that can result in false test results.  Pause
> > > DAMON execution during the state dumping to avoid such races.
> > > 
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > >  tools/testing/selftests/damon/sysfs.py | 31 ++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> > > index e6d34ba05893f..704729c7a318e 100755
> > > --- a/tools/testing/selftests/damon/sysfs.py
> > > +++ b/tools/testing/selftests/damon/sysfs.py
> > > @@ -193,18 +193,48 @@ def assert_ctx_committed(ctx, dump):
> > >      assert_true(dump['pause'] == ctx.pause, 'pause', dump)
> > >  
> > >  def assert_ctxs_committed(kdamonds):
> > > +    ctxs_paused_for_dump = []
> > > +    for kd in kdamonds.kdamonds:
> > > +        for ctx in kd.contexts:
> > > +            if ctx.pause is False:
> > > +                ctx.pause = True
> > > +                err = kd.commit()
> > > +                if err is not None:
> > > +                    print('pause fail (%s)' % err)
> > > +                    kdamonds.stop()
> > > +                    exit(1)
> > > +                ctxs_paused_for_dump.append(ctx)
> > > +
> > >      status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
> > >      if err is not None:
> > >          print(err)
> > >          kdamonds.stop()
> > >          exit(1)
> > >  
> > > +    for kd in kdamonds.kdamonds:
> > > +        for ctx in kd.contexts:
> > > +            if ctx in ctxs_paused_for_dump:
> > > +                ctx.pause = False
> > > +                err = kd.commit()
> > > +                if err is not None:
> > > +                    print('resume fail (%s)' % err)
> > > +                    kdamonds.stop()
> > > +                    exit(1)
> > > +                # restore for comparison
> > > +                ctx.pause = True
> > 
> > : If a kdamond contains multiple contexts, does this loop leave earlier contexts
> > : paused in the kernel?
> > : 
> > : Since kd.commit() stages and commits the state of all contexts associated with
> > : the kdamond, when kd.commit() is called for the second context, the first
> > : context's local pause attribute is already back to True.
> > : 
> > : This would cause kd.commit() to write to sysfs and instruct the kernel to
> > : pause the first context again. By the end of this loop, only the last context
> > : in the kdamond would remain unpaused in the kernel.
> > 
> > No.  The pause field of the earlier context is set to False, so later
> > kd.commit() will commit the False 'pause' again.  But this finds a good point.
> > There is no reason to call kd.commit() for each context.  It is more efficient
> > to be called for each kdamond., thouth currently we support only one context
> > per kdamond.  I will update the code so, in the next spin.
> 
> I'm wrong, Sashiko is correct.  I missed the last 'ctx.pause = True' in the
> loop.  I will fix this together, like below:
> 
> '''
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -201,16 +201,17 @@ def assert_ctx_committed(ctx, dump):
> 
>  def assert_ctxs_committed(kdamonds):
>      ctxs_paused_for_dump = []
> +    # pause for safe state dumping
>      for kd in kdamonds.kdamonds:
>          for ctx in kd.contexts:
>              if ctx.pause is False:
>                  ctx.pause = True
> -                err = kd.commit()
> -                if err is not None:
> -                    print('pause fail (%s)' % err)
> -                    kdamonds.stop()
> -                    exit(1)
>                  ctxs_paused_for_dump.append(ctx)
> +        err = kd.commit()
> +        if err is not None:
> +            print('pause fail (%s)' % err)
> +            kdamonds.stop()
> +            exit(1)
> 
>      status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
>      if err is not None:
> @@ -218,17 +219,19 @@ def assert_ctxs_committed(kdamonds):
>          kdamonds.stop()
>          exit(1)
> 
> +    # resume contexts paused for safe state dumping
>      for kd in kdamonds.kdamonds:
> -        for ctx in kd.contexts:
> -            if ctx in ctxs_paused_for_dump:
> -                ctx.pause = False
> -                err = kd.commit()
> -                if err is not None:
> -                    print('resume fail (%s)' % err)
> -                    kdamonds.stop()
> -                    exit(1)
> -                # restore for comparison
> -                ctx.pause = True
> +        for ctx in ctxs_paused_for_dump:
> +            ctx.pause = False
> +        err = kd.commit()
> +        if err is not None:
> +            print('resume fail (%s)' % err)
> +            kdamonds.stop()
> +            exit(1)
> +
> +    # restore for comparison
> +    for ctx in ctxs_paused_for_dump:
> +        ctx.pause = True
> 
>      ctxs = kdamonds.kdamonds[0].contexts
>      dump = status['contexts']
> '''

The above fixup makes the test fails, for the obsolete targets.  The fixup
needs another fixup, like below.  I will add that to the next spin.

'''
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -200,11 +200,12 @@ def assert_ctxs_committed(kdamonds):
             if ctx.pause is False:
                 ctx.pause = True
                 ctxs_paused_for_dump.append(ctx)
-        err = kd.commit()
-        if err is not None:
-            print('pause fail (%s)' % err)
-            kdamonds.stop()
-            exit(1)
+        if len(ctxs_paused_for_dump) > 0:
+            err = kd.commit()
+            if err is not None:
+                print('pause fail (%s)' % err)
+                kdamonds.stop()
+                exit(1)

     status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
     if err is not None:
@@ -216,11 +217,12 @@ def assert_ctxs_committed(kdamonds):
     for kd in kdamonds.kdamonds:
         for ctx in ctxs_paused_for_dump:
             ctx.pause = False
-        err = kd.commit()
-        if err is not None:
-            print('resume fail (%s)' % err)
-            kdamonds.stop()
-            exit(1)
+        if len(ctxs_paused_for_dump) > 0:
+            err = kd.commit()
+            if err is not None:
+                print('resume fail (%s)' % err)
+                kdamonds.stop()
+                exit(1)

     # restore for comparison
     for ctx in ctxs_paused_for_dump:
'''


Thanks,
SJ
