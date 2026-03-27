Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7D22D7B5
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621139; cv=none; b=V+MFDXhmvf/EkrmmipLoShvCS0QHSGVE+8bzyPlyUYEyxccfIsdVbfGj3ob/0710p/lvu7YB5idpMz0/5CM9LrZ2feGh5Q/Eg95qn6h89LuiFBteh1KykBIV1A3t7HG3+1/RszTB4MpLLlECdsLs2ob8l+2rK8AOMseG57L7d84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621139; c=relaxed/simple;
	bh=WO0V06oBGtjE9ScW+EyWlnGevQJTkxKvoZsa7KCDZ4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbX0xnHMasTBD3cV+EVLaa3gfUCB4hCmvrbuXGj1tlF0NCO9LVB+Id8DKaLbgv8HDhUqVh/zWpFxfTdLg3icI55YrwyoDg9Ld+Tdnycii2Uy+YCQ0G85bgD2ik/xTXi72xMwAQMZ9qPkvjRePi7mQFomov15GFYjSU7tnw2+MF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLrBsEBg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLrBsEBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22163C19423;
	Fri, 27 Mar 2026 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774621139;
	bh=WO0V06oBGtjE9ScW+EyWlnGevQJTkxKvoZsa7KCDZ4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLrBsEBg38zlFp7ThZWOUD67yqC7JeCBh0emG5Z9ZDL+O2VQa8hk0dObW+jQaDdnF
	 Up+pmqQP39kCpQe5uxIJacajFB1dBWqXWt7eIRF3AWqaPoFwS4kWnRBXQ9Q2S43nii
	 LabEDo1Lj8hD7/Q0tf6JGktauv1EDLO7imU1ohVtBj45xSq1XPP0vBmETu2P7J++q2
	 DV2eR7ModkjM0KrCx2jKDKVFsHiHV816NqANyd3fmUCe3+q3S1SKE6AzDFxWcv978/
	 sX6nTqfBHDPNi7jmhi6txz3GPF++rOcrqaSKL9WOnp6I8SRiT771Hgu9dkBLd9reyg
	 jD9GwhLSVu9FA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC v5] mm/damon: add synchronous commit for commit_inputs
Date: Fri, 27 Mar 2026 07:18:57 -0700
Message-ID: <20260327141857.4484-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327055051.61731-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Mar 2026 13:50:51 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> On Thu, 26 Mar 2026 22:08:22 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > [...]
> > > > > I will add a patch in v6 to validate 'addr_unit' in addr_unit_store() to
> > > > > reject non-power-of-2 inputs immediately.
> > > > 
> > > > That's because kdamond_fn() has recently changed to exit the loop if
> > > > damon_commit_ctx() fails in the loop for any reason.  Refer to commit
> > > > 26f775a054c3 ("mm/damon/core: avoid use of half-online-committed context") for
> > > > more details.
> > > > 
> > > > Adding the validation in addr_unit_store() would work, but it could be a kind
> > > > of whack-a-mole game.  I'd prefer doing the validation of all inputs in one
> > > > place, just before the last damon_commit_ctx() call.  DAMON_SYSFS is doing so,
> > > > by making a test context and try committing user input to the test context
> > > > before doing that to the running context.  How about doing so here, too?
> > > 
> > > Thank you for the suggestion. I have now added the check
> > > '!src->addr_unit || ! is_power_of_2(src->addr_unit)' to
> > > damon_commit_ctx().
> > 
> > No, what I'm suggesting is not adding more checks, but reusing the existing
> > checks in damon_commit_ctx().
> 
> I just realized my previous reply might have caused a small
> misunderstanding. My intention was not to _add_ a new check, but to
> _move_ the validation to damon_commit_ctx(). So that patch will only
> modify damon_commit_ctx().

I don't really understand what you mean.  I found your patch [1], and still not
clear.  Let's discuss on the new patch.

> 
> > 
> > And, now I think bit differently.  Given the purpose of this patch is making
> > commit_inputs synchronous, I think making more complete validation check is
> > somewhat that can be done separately.  So my suggestion now is just keeping
> > this part just as is.
> 
> Understood. I will keep this series focused on making 'commit_inputs'
> synchronous, and prepare the validation for 'addr_unit' as a separate
> patch later. Thanks for helping me scope this properly.

Yes, let's discuss on the patch.

[1] https://lore.kernel.org/20260327062627.66426-1-aethernet65535@gmail.com

> 
> > [...]
> > > > So the issue already exists.  But let's ensure the fix is merged before this
> > > > patch, since this patch adds another exploitable path that can consequence in
> > > > whole param_lock deadlock.
> > > 
> > > Should I wait for your fix to be merged into damon/next before I post
> > > the next version?
> > 
> > As long as you agree about the mainline merge order, I think you don't need to
> > wait for my fix.  Please feel free to post next version.
> > 
> > FYI, the latest version of my fix is available [1] on the mailing list.
> > 
> > [1] https://lore.kernel.org/20260327004952.58266-1-sj@kernel.org
> 
> Thank you for your confirmation, and your fix. :>

You're welcome :)


Thanks,
SJ

[...]
