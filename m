Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06164371893;
	Sun, 22 Mar 2026 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774201682; cv=none; b=qNDYCAFPcdmz4ELMt0CvdA7uK7PDNXJTJwlqJb5C4aRcwlhm69eMoR4xNrzqktAHMFnfv3jTsdIafDiFeK9JGaMYJsvZMEeR0dWK+6vIKUY4sF8CLh13ssmj/GNLT2XSCPIhgam4eLwnONXwHvRve7O6G/blf7KFSL3/QpcKAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774201682; c=relaxed/simple;
	bh=zi3o3A260ASJFdf+1Gp2lU6cqFj7MS9SWJuu1snHJdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIMa94jPfQkv51ogKv0loGpG5lhg+nSYmJANX1GwiKToEfwLenwsJpQzVXF7PMvqYVqesb8vX2LaSjdJL0z+gCSY5rJ6qF+XUiDwi2mVvJYyPKL5q9vDIYoFKn2Cv1GhQu1DtRNssIMj3+uuFFrsu9VsND+W2p/Mf4mNltnIghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+Gc/NZd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+Gc/NZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7906DC19424;
	Sun, 22 Mar 2026 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774201681;
	bh=zi3o3A260ASJFdf+1Gp2lU6cqFj7MS9SWJuu1snHJdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+Gc/NZdkBJCF0cxaFYphh8WKAL1S9TP1n6tKc/WY0IXEU2ApipB8DRMs36wMSTux
	 u2WDazdplVo1gqG865TFto3CjqY7YDphPYq6D9zCop+VMaoKSD+7e5miZi98vI1+jJ
	 bU3hkpmEarDbts0j6t5NFaCPD/8c5MwCNIThZOCYM70ltK+JwPv868JzeUZKA+Wgy8
	 xfSvV2Y2iSn1+7cSUVP5N2xFfeJbaU2nUx3klPhIGHddrCvNth2piIyrG6lwaG9u5s
	 u8z91nif8wtU1urGowZM7c7QDOZSlS/67x/Bi8lfillLJBwIPrvUYXmAiVjIs1AgUd
	 CqMICrC1hCOuQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v4 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
Date: Sun, 22 Mar 2026 10:47:57 -0700
Message-ID: <20260322174757.84332-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322171534.83470-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 10:15:33 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260322155728.81434-11-sj@kernel.org
> # start of sashiko.dev inline review
> commit 67adf8e7b8416252faf583e176f0e8424fd4fb95
> Author: SeongJae Park <sj@kernel.org>
> 
> selftets/damon/sysfs.py: pause DAMON before dumping status
> 
> The sysfs.py test commits DAMON parameters, dumps the internal DAMON
> state, and verifies the parameters. This commit pauses DAMON execution
> during the state dumping to avoid races that can result in false test
> results.
> 
> > selftets/damon/sysfs.py: pause DAMON before dumping status
> 
> This isn't a bug, but there's a typo (selftets) in the subject line.

Oops, Sashiko mentioned this in the previous one, but I forgot fixing this.
I will fix this in the next spin.

> 
> > diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> > --- a/tools/testing/selftests/damon/sysfs.py
> > +++ b/tools/testing/selftests/damon/sysfs.py
> [ ... ]
> > @@ -193,18 +193,55 @@ def assert_ctx_committed(ctx, dump):
> >  def assert_ctxs_committed(kdamonds):
> > +    ctxs_paused_for_dump = []
> > +    kdamonds_paused_for_dump = []
> > +    # pause for safe state dumping
> > +    for kd in kdamonds.kdamonds:
> [ ... ]
> > +    # resume contexts paused for safe state dumping
> > +    for ctx in ctxs_paused_for_dump:
> > +        ctx.pause = False
> > +    if kd in kdamonds_paused_for_dump:
> > +        err = kd.commit()
> 
> Is this if statement intended to be a for loop?
> 
> Since kd is just retaining the value from the last iteration of the earlier
> loop, using an if statement here means that if there are multiple kdamonds,
> only the last one might have its state committed. 
> 
> Could this leave other kdamonds un-resumed in the kernel?

Ah, correct...  There is no multiple kdamonds use case, but let's make it
complete.  I will fix this in the next spin, like below.

'''
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -226,7 +226,7 @@ def assert_ctxs_committed(kdamonds):
     # resume contexts paused for safe state dumping
     for ctx in ctxs_paused_for_dump:
         ctx.pause = False
-    if kd in kdamonds_paused_for_dump:
+    for kd in kdamonds_paused_for_dump:
         err = kd.commit()
         if err is not None:
             print('resume fail (%s)' % err)
'''


Thanks,
SJ

[...]
