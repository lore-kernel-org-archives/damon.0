Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C81A23B9
	for <damon@lists.linux.dev>; Sat,  4 Apr 2026 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775334648; cv=none; b=AS891p6Ilo3qplQscn7XGQ/tmNxqj4QtWhF5aYP4LpfHB68zgB+R3mwUdw050WEgVBWKOeT8UtfUQgunXcvZo1Qclpzi8az33ShQyZdfIoY1Q7vd+wcP2DjtXr/3p/zKoMMcsXRt74xQCNe2xXa7YEOCMROOv/QKXJ2FL1S06aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775334648; c=relaxed/simple;
	bh=eyo7n4gEymA/anCOsd3jdjhMzGS2OqiPLSgYmJnzpss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5FfXHAiXonCGrQHfWvS11vxORAhg7BJSA7ix2lF1kzFPSylqADug4IUVMAZ6tmqqi34mm1ouIvOVXSuwkNHS0AMIL7rjLnCZsskATvBSZhJw5Yzy2StuvJ4Vikj2PaT8hIDOemaafbuY2mz7Oe7JIZVM2eFuSB4ERpcljjPWQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyCj31tI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyCj31tI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18E8C19421;
	Sat,  4 Apr 2026 20:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775334648;
	bh=eyo7n4gEymA/anCOsd3jdjhMzGS2OqiPLSgYmJnzpss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XyCj31tIAacXS19WGcdqw44RoN76uMuppNOsyscTfV4QRF2xieP4DTjIOPVmlrSAH
	 WkHplbMoOZP7cBGzgouaWtjmPQ1PVvQ/ubOYyhfayJH4/d0Ufp9YvoRtsgTmOFcaNe
	 6Kr43RvwqcZKeDGCoN7aDCwgdizJXHtjyUK5Eu8/hVE9yFRS1QO9iXhfwTqwIrv2AL
	 mpAZtSIbxduxR/xB7uiMA8TJV4xPZX3DcAg74DpXXIz1WccJGPpTViT2fHpuHwUhfN
	 vZKtrv0YJwnVQzVjFluTO1jNEmZCLSvkmymRDXpUY9r8+8RT11ef+rWeJcI1uW+28W
	 wvXutwVHglfIw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Sat,  4 Apr 2026 13:30:43 -0700
Message-ID: <20260404203044.86655-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404091122.6255-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  4 Apr 2026 17:11:22 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> On Fri,  3 Apr 2026 09:19:06 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > As Quanmin also asked, clarifying the unexpected termination would be nice.
> 
> I will clarify "unexpected termination" in v4's commit message:
> 
>     "Unexpectedly" here means the kdamond terminates without the user
>     requesting it (e.g., not by wrtting "N" to 'enabled').
> 
> > I remember I suggested adding stable@, but only if you think it deserve.  I'm
> > now not very sure if this deserves Cc-ing stable@.  As I mentioned before,
> 
> I think this deserves Cc stable@ because:
> - The issue can be triggered by accidental user misconfiguration
> - It causes kdamond termination and hard to recover/restart. Once
>   triggered, kdamond remains in an unusable state, and I have not found
>   a way to recover/restart it through the sysfs interface without a
>   system reboot.
> - The fix is small and low-risk
> - It improves user experience on stable kernels

Thank you for elaborating this.  I now think this deserves Cc-ing stable@.
Let's make sure the user impact is clearly documented on the commit message.
Also, the code change itself and the current commit message is not clearly
explaining how the real problem (DAMON cannot be restarted) can happen.  Please
add the description in the next revision.

> 
> But I'm open to dropping it if you think otherwise.
> 
> > there are multiple patches to review in parallel (you are also having such
> > multiple patches in the queue).  Please don't expect I will follow full
> > contexts especially when a single person posting multiple patches in parallel
> > every day or two, and bear in mind with me.
> > 
> > Sorry about the limited bandwidth from my side.  You could also simply slow
> > down your pace, though.
> 
> I will try to adjust my pace. I've also noticed that the quality of my
> recent replies/patches hasn't been ideal, and I will try to be less
> rushed in the future. Thank you for your understanding and suggestion.

Sounds good :)

> 
> > For stable@ Cc-ing patches, more clearly describing the user impact would be
> > nice, and helpful for judging if it deserves that.  Could you please elaborate?
> 
> I will add a "User Impact" section in v4's commit message:

Yes, please add this kind of message that make clear what is the user impact.

> 
>     User Impact
>     ===========
>     Currently, if a user commit an invalid 'addr_unit', kdamond may
>     terminate abruptly. Once terminated, it cannot be easily restarted
>     via sysfs, pontentially requiring a system reboot to restore DAMON
>     functionality. This patch prevent such termination by validating
>     parameters (addr_unit and min_region_sz) early.

You mentioned it cannot be restarted above.  The above message sounds like
there is a way to restart it via sysfs, though it is not easy.  Please make it
clear and consistent.  As I also requested above, please add the internal
mechanism of how that makes restart unable.  This itself doesn't explain it.


Thanks,
SJ

[...]
