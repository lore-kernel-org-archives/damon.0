Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BC224AF9
	for <damon@lists.linux.dev>; Thu, 16 Apr 2026 03:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776310554; cv=none; b=kANIoa3n5Jtp7JLrU/4NzKZ0M7mMsjKpJDWhJO4uF+L/MgQIBI3F3Zh6ukeUTzqFBnhiOI2tu9LQp4cNMKNtufJ2O2OoGw9g3oUkGimTEPUABI5Ka8lKVKoPq6tMJlwIkea3R4rgxdZmbmqSqVkmjTVv1iF2nHBYOT1XeCuFY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776310554; c=relaxed/simple;
	bh=Gvpuiwv2Vc8R1SqlfaL2jWj2yV+PpcVw312s7u7nI4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixm2kqyyU9P2YYSeTQdG3JEEdUmHOl1It75jspAMqibNfMXxmOjUI74OU+WMlKRpClOC6N/hitRWQdftBEvbHO+dsgma6V7MGDHg3JNMgaln33MGXGfbYl5fZvFPX9M1D6uezGmV8YouZ8YEoNMSeC0udQDFP6pSwDkL6DkLXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs0nHane; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs0nHane"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB403C19424;
	Thu, 16 Apr 2026 03:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776310554;
	bh=Gvpuiwv2Vc8R1SqlfaL2jWj2yV+PpcVw312s7u7nI4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bs0nHanepSdwso8WcNkFSET90Kq/CyEJBGTTKDfn+57TNckFfqcTVLCurTh9EURDY
	 VVOCv997b68Tpp3/udDHWrCDYWbiPzm53F/SazHcGZZSJzSR7Lfj1zMmY9F7x7vjv7
	 FHxr9Uh1uSFpYNpRg0i8sudLQvEO2yQKByiXny6aU7zqYGf8hlvSs0wydPArh9Q1qZ
	 EfJUqPF6ZgCtmkBwLHyilgAHBSv3JeOWL+JkmDgFWwZk0Uxe8klumVYtxHEqFAnSky
	 /U66rFQQsqNUs5PVQu1DDTUV/io8rHudS9DWsI97JkavLeJzV69Z1pEL170SJ7nJsa
	 Su6wjxfHQXKVw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Wed, 15 Apr 2026 20:35:45 -0700
Message-ID: <20260416033546.87941-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416005936.7F477C19424@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TL; DR: Sashiko found good point.  I will fix it in the next revision.

On Thu, 16 Apr 2026 00:59:35 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [Medium] Stale `kdamond_pid` exposed to userspace if `damon_call()` fails during startup.
> --
> 
> commit 46eb0a4278ccd2dec190db28b78b0766b8865901
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/stat: add a parameter for reading kdamond pid
> 
> This commit exposes the pid of the DAMON_STAT kdamond via a new read-only
> module parameter named kdamond_pid, standardizing usage with other DAMON
> modules.
> 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > index 99ba346f9e325..4901e9a7c3398 100644
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> 
> [ ... ]
> 
> > @@ -260,6 +269,14 @@ static int damon_stat_start(void)
> >  		damon_stat_context = NULL;
> >  		return err;
> >  	}
> > +	kdamond_pid = damon_kdamond_pid(damon_stat_context);
> > +	if (kdamond_pid < 0) {
> > +		err = kdamond_pid;
> > +		kdamond_pid = -1;
> > +		damon_destroy_ctx(damon_stat_context);
> > +		damon_stat_context = NULL;
> > +		return err;
> > +	}
> >  
> >  	damon_stat_last_refresh_jiffies = jiffies;
> >  	call_control.data = damon_stat_context;
> 
> If damon_call() fails right after this and returns an error,
> damon_stat_start() will pass that error back to its caller and the module
> will revert to a disabled state.
> 
> Does this leave a stale kdamond_pid exposed to userspace? The newly added
> documentation states: "If DAMON_STAT is enabled, this becomes the PID of
> the worker thread. Else, -1." Since the initialization fails, the module
> remains disabled, but kdamond_pid isn't reset to -1 on this error path.

Nice catch.  I will do the kdamond_pid setup after damon_call() success, like
below.  Also, I will remove the damon_stat_context deallocation and unset when
damon_kdamond_pid() failure, because it will be deallocated when
damon_stat_start() is called again.  The change will look like below:

--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -222,18 +222,19 @@ static int damon_stat_start(void)
                damon_stat_context = NULL;
                return err;
        }
+
+       damon_stat_last_refresh_jiffies = jiffies;
+       call_control.data = damon_stat_context;
+       err = damon_call(damon_stat_context, &call_control);
+       if (err)
+               return err;
+
        kdamond_pid = damon_kdamond_pid(damon_stat_context);
        if (kdamond_pid < 0) {
                err = kdamond_pid;
                kdamond_pid = -1;
-               damon_destroy_ctx(damon_stat_context);
-               damon_stat_context = NULL;
                return err;
        }
-
-       damon_stat_last_refresh_jiffies = jiffies;
-       call_control.data = damon_stat_context;
-       return damon_call(damon_stat_context, &call_control);
 }

 static void damon_stat_stop(void)

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260416002149.87090-1-sj@kernel.org?part=1


Thanks,
SJ
