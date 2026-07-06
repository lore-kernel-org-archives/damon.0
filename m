Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BC3914F8
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348563; cv=none; b=L8a+TXY8SGgZ9Hqq1QLc9bPRaW66FkMXh0fs3lVSaS6jcLEzO9HUjSTzIgQ/hFOeygwvPNIju0EGh5eLOtgef0WFKP+ZhQf4MVxd4ntnrIe2oDW5bcxxTY3f2k93JsSOJDiXGUOMZIUnQfgvVyNKBCmX/1rcnee4gBIzkxGXhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348563; c=relaxed/simple;
	bh=ogtovPKx4puWlMZ5seGTkT9y656Ef5pabF+iEceDYqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IS7hbNxTUNMyMt2p954opcCQxq5j5Yp995H1Zbrdi9ljCt4jDOKxWE0DU2aHxsi+vA+HxyMyVlRc3GWLFVsNoHEWaVrfoA/DHN2LYOBhqg5+RK8/lE3GjThEFput/eqcrpglVcPytKJ2juwWUTvw1L2CAlsF1d94ArXZuDxa6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLPyRf2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLPyRf2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44451F000E9;
	Mon,  6 Jul 2026 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783348561;
	bh=X6k/zCKHzJ1ANmNrfnYPEnou+eSkFvzQaZMoc6l6jnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iLPyRf2QZW44tDJc9DwGWj4LFq0GbhjkqAfp3xu1BUXjbSQccqSdn8z10yvzhGCbE
	 Z/7kALsdPu19U9PiPa4U/8+gGV7aOHStR0nadBoPEDCmjCkFVxV+PrpexDKnqE58PI
	 wE1rkGrut3zxsPZubSjOtyIxutQQ+Vtv9LVwta9AwNOmfG/sJ9vuvtPKTaL71vdREe
	 bTeZcqeUQBh0THgNNKtklaQrr223cNw3HWZ30OYGev/PfRzZsM4Xa/fY2G4uJ9Lm7w
	 cPfnwkZh8QCGvymsbCKfJCv97cog2d1ofy9MyXi4LWhGdJxtU1p/+xiYaSTjw0H0Mp
	 QIPZIq2NYIHGQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 08/11] samples/damon/mtier: stop all contexts with single damon_stop() call
Date: Mon,  6 Jul 2026 07:35:52 -0700
Message-ID: <20260706143554.94084-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706142148.B2B1A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 14:21:47 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing synchronization between module initialization and the module parameter sysfs store callback can lead to Use-After-Free and NULL pointer dereference.
> --
> 
> commit dbce89ab1942b321167e83b5cb17dfd9002ce893
> Author: SJ Park <sj@kernel.org>
> 
> samples/damon/mtier: stop all contexts with single damon_stop() call
> 
> This commit refactors damon_sample_mtier_stop() to use a single
> damon_stop() call to stop all requested DAMON contexts. The previous
> implementation used two separate calls because damon_stop() could
> theoretically return a failure, but it now always stops all contexts
> successfully.
> 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index 90881e8bd441f..ac9c24b92ead8 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> > @@ -200,8 +200,7 @@ static int damon_sample_mtier_start(void)
> >  
> >  static void damon_sample_mtier_stop(void)
> >  {
> > -	damon_stop(ctxs, 1);
> > -	damon_stop(&ctxs[1], 1);
> > +	damon_stop(ctxs, 2);
> [Severity: High]
> This is a pre-existing issue, but could a concurrent sysfs write
> trigger a use-after-free and null pointer dereference here?
> 
> When the module is loaded with the enabled parameter set to true,
> damon_sample_mtier_init() attempts to initialize the ctxs array. If
> initialization fails, such as failing to allocate ctxs[1], it destroys
> ctxs[0] but leaves it as a dangling pointer.
> 
> Concurrently, a userspace process writing to the enable sysfs parameter
> triggers damon_sample_mtier_enable_store(). If this write observes the
> global enabled state as true before the initialization failure resets it
> to false, it proceeds to call damon_sample_mtier_stop().
> 
> When damon_sample_mtier_stop() calls damon_stop(ctxs, 2), it loops over
> both array elements, calling __damon_stop() on them. This dereferences
> the pointers to lock ctx->kdamond_lock, potentially causing a
> use-after-free on ctxs[0] and a null pointer dereference on ctxs[1].

Wrong.  mtier is not a loadable module, so this race cannot happen.

> 
> >  	damon_destroy_ctx(ctxs[0]);
> >  	damon_destroy_ctx(ctxs[1]);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706140628.87414-1-sj@kernel.org?part=8

Thanks,
SJ

[...]
