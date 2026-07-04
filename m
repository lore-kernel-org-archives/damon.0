Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71110785
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783190546; cv=none; b=Y5J8yloiWGGRUlVX++CVEXYe3ognl0RVWdj/3xSeuMVCmxfYQ82k0EaSvEA3bQd/U3g2+A/KuFriZOW4EKPqb+QlmGukgvJ3/JqLdD26rJWsPReKe5rhQZEhTYn+W5wvbj0/iIubCChOplU4I3geZMGjkd/yLXIS6AogeJqsV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783190546; c=relaxed/simple;
	bh=vlClLxNS2kOSKKQUggbF7D89E62HPRCVTGH3NpIMN9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWHr+nu4QmZZRQlficwXy1eiNqraHkdC1YiZJZDSUZNXCJxy5AEacEeGsh8/W8OhJ+p71RoraVoWZNk8uqLCMYQN0XYqIl9Kwj0gL+5fpn+yz8T4xnBQl7ybXA0VhxeUiWFrvbsOu2uEPg2TyOKDqVVsQ+89yC8BjR+yHR29Ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAKouvQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAKouvQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB371F000E9;
	Sat,  4 Jul 2026 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783190545;
	bh=655KdQOSF6mTNA0WVuZ4tM0WHz3CovItZ3kjt4gYdbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZAKouvQWS7PuKGFDtNgK5jijhCc2W/oK08hZUs4iiufOXknMT9DbRA/WZKdoSNQg8
	 g7yQhmDtyVWOIW/1kygps/Z4Xvl6YkUMDH7vVt5SDOe72ZMjQaBuX4+phejQQXop9Y
	 jh8nnvz3MNGXyPkdpV+7SvHT0bYqnvWdLP4FKkheUBcIROmXDWACIAVrYqy7tEleHf
	 HzDUa53eP+DLVB6zJCV3gtimfpFNtpUYCpNxqS/Kqw0wT12/enDe1AriLgNEcwoqVf
	 irAr5oXOdkvoY90sHd5KVmU6+OIUDPxtddijygBzcbhVgwnnOGLTd5PhoMP7UfEmZF
	 9jSrMfvWXghgQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 02/11] samples/damon/mtier: do not stop first context for damon_start() failure
Date: Sat,  4 Jul 2026 11:42:17 -0700
Message-ID: <20260704184217.136391-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704182406.0C6AE1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 04 Jul 2026 18:24:05 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ABBA deadlock in damon_start() during error recovery when rolling back successfully started contexts.
> --
> 
> commit c411cd45182c74c483bd6bd5d58aea28123f720d
> Author: SJ Park <sj@kernel.org>
> 
> samples/damon/mtier: do not stop first context for damon_start() failure
> 
> damon_start() was able to fail while keeping the first context running.
> mtier hence stops the first context in the case. damon_start() is
> refactored to avoid that. The error handling is no longer necessary.
> Remove it.
> 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index e567f4edd80ea..90881e8bd441f 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> > @@ -193,8 +193,6 @@ static int damon_sample_mtier_start(void)
> >  	if (!err)
> >  		return 0;
> >  
> > -	if (damon_is_running(ctxs[0]))
> > -		damon_stop(ctxs, 1);
> 
> [Severity: High]
> Does the refactored error handling in damon_start() introduce a deadlock?
> 
> Since damon_start() is called with nr_ctxs = 2 here, if the first context
> starts successfully but the second one fails, the error recovery path in
> damon_start() could trigger an ABBA deadlock.
> 
> If damon_start() calls damon_stop() on the error path while holding
> damon_lock:
> 
> mm/damon/core.c:damon_start() {
>     ...
> 		err = __damon_start(ctxs[i]);
> 		if (err) {
> 			damon_stop(ctxs, i);
> 			break;
> 		}
>     ...
> }
> 
> damon_stop() blocks until the kdamond_fn() thread exits. However, kdamond_fn()
> attempts to acquire damon_lock at its exit path:
> 
> mm/damon/core.c:kdamond_fn() {
>     ...
> 	mutex_lock(&damon_lock);
> 	nr_running_ctxs--;
> 	if (!nr_running_ctxs && running_exclusive_ctxs)
> 		running_exclusive_ctxs = false;
> 	mutex_unlock(&damon_lock);
>     ...
> }
> 
> Could this cause kdamond_fn() to hang waiting for damon_lock, which is still
> held by damon_start(), resulting in a deadlock?

Yes, I will fix damon_start() it in the next revision.


Thanks,
SJ

[...]
