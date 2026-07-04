Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AA2C15A5
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783190414; cv=none; b=SwhjPeRQLp6DiHciexNS6TYumUH+WoZcZPEVdMykze5+DMUo2bhaOqwP0GcaxcduGR4S6OpOXqfy9iMgnNm+HRCh/+NtRG8hzfcH9Is+uTaaJNPzgV7kYLXrXln7H8okX4FDvAtrJLnlY3/+5yU2yGOzwxg9top6mOYYzWXP7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783190414; c=relaxed/simple;
	bh=ncQjFNQeQDOrftmOTA1jJmDkGlzAebn3ehpYmcQi3j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5Jfebhnj/Iwm2jiPCQJytDT0u46n7NSPRzOjN9oTNRu0sJtczZ7jqd3RNT744BthShIHgQhaShn7hbsMix85NKtwyzDw0Q4fFZPMO5YOMIBxjtBKvQhwoPrD1xPAPHcxVaYRvbDsj7b6zF+FzqrUwydNSkzL7/prsoCVvJ62p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VosSNRfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VosSNRfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708941F000E9;
	Sat,  4 Jul 2026 18:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783190412;
	bh=lMuB9oS5l+GjUXMf8o+cEf3CF6aavr8Ykxm2vMgSg54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VosSNRfrl9OliQV+Iq13rBqzFzxkFT7fgmyPxD+awP2gMh5pKCYMQUVcTA0ThzLKF
	 jYzorPoSAcWwYvVc0MJ74Or8R38WFsTLzgbZRyAoAlNUkYHCKe6VbBZyPXystQ/i5l
	 MdBFTKjEASb6SU+5VSjC9JnIGIu2Gm8A9tWMqJGtXhJsIpOnkyDjiI/n8F4pvrR+E4
	 yTh2JXwbqYvws4nv9H850Hc0XWphhhVitVWnzleS9AyxjyHMNHh9HE7jdR/bij7E/c
	 DG99lNy7IMDoSCOvOAL7DJysNuxgg1X7U3XmJhKhG3mymGH61jXISekxKJ30IeYQYr
	 Wwh/A4iFJyPgQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 01/11] mm/damon/core: stop ctxs in damon_start() before returning an error
Date: Sat,  4 Jul 2026 11:40:03 -0700
Message-ID: <20260704184004.133933-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704182050.5C01A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 04 Jul 2026 18:20:49 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Calling damon_stop() from within damon_start() while holding damon_lock causes an AB-BA deadlock with kdamond_fn().
> --
> 
> commit 1cec89c3cfde2c1ab34bcccb4767280aac126514
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: stop ctxs in damon_start() before returning an error
> 
> When multiple contexts are passed to damon_start(), it starts them one
> by one and returns an error immediately on failure. This commit adds logic
> to stop any already-started contexts directly within damon_start() if a
> subsequent context fails to start.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c6fc35be633b3..45aa9acef4e30 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1836,8 +1836,10 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
> >  
> >  	for (i = 0; i < nr_ctxs; i++) {
> >  		err = __damon_start(ctxs[i]);
> > -		if (err)
> > +		if (err) {
> > +			damon_stop(ctxs, i);
> 
> [Severity: High]
> Will this cause a deadlock if a context fails to start?
> 
> damon_start() holds damon_lock while iterating through the contexts. When it
> encounters an error, it calls damon_stop() which synchronously waits for the
> previously started kthreads to stop.
> 
> However, the kdamond_fn thread attempts to acquire the same damon_lock
> during its cleanup phase before it can exit:
> 
> kdamond_fn() {
>         ...
>         mutex_lock(&damon_lock);
>         nr_running_ctxs--;
>         ...
>         mutex_unlock(&damon_lock);
> }
> 
> Since damon_start() is blocking on the thread exit while holding damon_lock,
> and the thread is blocking on damon_lock to exit, doesn't this result in a
> circular wait?

Good finding.  I will fix this in the next revision by calling damon_stop()
after releasing the mutex, like below.

"""
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2182,16 +2182,17 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)

        for (i = 0; i < nr_ctxs; i++) {
                err = __damon_start(ctxs[i]);
-               if (err) {
-                       damon_stop(ctxs, i);
+               if (err)
                        break;
-               }
                nr_running_ctxs++;
        }
        if (exclusive && nr_running_ctxs)
                running_exclusive_ctxs = true;
        mutex_unlock(&damon_lock);

+       if (i != nr_ctxs)
+               damon_stop(ctxs, i);
+
        return err;
 }
"""


Thanks,
SJ

[...]
