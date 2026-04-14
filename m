Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4425332E;
	Tue, 14 Apr 2026 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145070; cv=none; b=MK79gyd8H5bkN2a9oAgBvfWGTjU05lxZyFwOkhyCSA74Ht1byOmXkJeHWaYXRd6lCCdBXAV8okSgB8WmVyXB2IiAf+VypJc/JXAGEmKLwg6DR0tPyHvMhALwUCQBsAlMuT6KHuyO+6D0b2FSe62Da19qlZKkn4d1oxVF6UIN7eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145070; c=relaxed/simple;
	bh=g/+F/QbX1zjCLTtq9nQIK2PoeggWzfTxbvqrEl/rsxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4ET6gUh2m9L99ovauL3Bi1LnLdvkjYW1imWcrjW52T35Kh7tmd66/nKOdT5PCbhT5LzvR0qZhTzuhxnPxkO9DDOLwPBdFGMZvnjjKMIWJP+QXwpnbR3Xe4mxVteVRrthkhj7ZUTCuJXOuPXDacWKiiCxR+B0LcXB5rvOLWQuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb3Dh9r+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb3Dh9r+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C36C19425;
	Tue, 14 Apr 2026 05:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776145069;
	bh=g/+F/QbX1zjCLTtq9nQIK2PoeggWzfTxbvqrEl/rsxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cb3Dh9r+W+uy0GWfhQUrZrxaP/wXOX1wnE0xZ45BDJcg4E1jKkj5qtaBlLK0/aFrJ
	 HGafWySSJgu97/7EOWiCQmOKY/d2VSNA1cWk+F5bYINUr60tFtepu6/xKHpPR9cvEb
	 Ce2lzgr5mileqPUNU/KS/zR+mwFIHiwvaw2JLTuOVroMhsQCTEi+PJlMo2RH7UXmFn
	 YcB7uP1dxZzLno6nuAUuNHSOuL/xfn2OdFAt5YUyZVgLNLPHdsu+YdoTGHoT27cEeq
	 SWNBmjxQk2xwWrNjbzYceRL4UvnFSumWeLI8hXfxfwvVQ/jY1wTfz+l3QRsEdi/mQ+
	 wOBuWqOPt1gww==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Mon, 13 Apr 2026 22:37:41 -0700
Message-ID: <20260414053742.90296-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414045002.88110-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: Sashiko found a bug of this patch; I will fix it in the next revision.
Sashiko also found one issue in the existing code; I will work on it
separately.

Forwarding full sashiko review in a reply format with my inline comments below,
for sharing details of my view and doing followup discussions via mails if
needed.

> # review url: https://sashiko.dev/#/patchset/20260414045002.88110-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit fc6c9ec12df0df57fcce5c90c7a0604cddb1cc78
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/stat: add a parameter for reading kdamond pid
> 
> This commit exposes the PID of the DAMON_STAT kdamond via a new read-only
> module parameter, kdamond_pid. It intends to set this to -1 when DAMON_STAT
> is disabled.
> 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > index 99ba346f9e325..21fa04d95eeac 100644
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> [ ... ]
> > @@ -260,6 +269,9 @@ static int damon_stat_start(void)
> >  		damon_stat_context = NULL;
> >  		return err;
> >  	}
> > +	kdamond_pid = damon_kdamond_pid(damon_stat_context);
> > +	if (kdamond_pid < 0)
> > +		return kdamond_pid;
> 
> If damon_kdamond_pid() returns an error code, doesn't this leave the global
> kdamond_pid set to that negative error code instead of -1?
> 
> Also, if we take this early return path, does this code leak the
> damon_stat_context allocation? The error path just above it correctly
> calls damon_destroy_ctx(damon_stat_context) and sets it to NULL.

Nice catch.  I will fix this like below in the next revision.

'''
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -223,8 +223,12 @@ static int damon_stat_start(void)
                return err;
        }
        kdamond_pid = damon_kdamond_pid(damon_stat_context);
-       if (kdamond_pid < 0)
-               return kdamond_pid;
+       if (kdamond_pid < 0) {
+               err = kdamond_pid;
+               kdamond_pid = -1;
+               damon_destroy_ctx(damon_stat_context);
+               damon_stat_context = NULL;
+               return err;

        damon_stat_last_refresh_jiffies = jiffies;
        call_control.data = damon_stat_context;
'''

> 
> >  
> >  	damon_stat_last_refresh_jiffies = jiffies;
> >  	call_control.data = damon_stat_context;
> >  	return damon_call(damon_stat_context, &call_control);
> >  }
> 
> If damon_call() fails here and returns an error, the caller will handle it
> by setting enabled to false. Does this leave kdamond_pid holding a stale
> positive PID instead of being reset to -1?

Nice catch, but not this patch's fault.  I will separately work on it.

> 
> > @@ -269,6 +281,7 @@ static int damon_stat_start(void)
> >  static void damon_stat_stop(void)
> >  {
> >  	damon_stop(&damon_stat_context, 1);
> > +	kdamond_pid = -1;
> >  	damon_destroy_ctx(damon_stat_context);
> >  	damon_stat_context = NULL;
> >  }
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260414045002.88110-2-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260414045002.88110-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
