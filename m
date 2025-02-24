Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B01957FC
	for <damon@lists.linux.dev>; Mon, 24 Feb 2025 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432927; cv=none; b=Yt6Rl4XVCVm/hk7J6Cfz64Bn9qKJl+I31wbXLqQdEvlZrQD7YZkTtZjo5F9U9O4pQd8QIripNKsiO5Mu7OPqdTOndDj2uDBDELWJbP/mdwOFrEKj4RMREanCKTdl2IODVrtWgz3/TLoaRudRfsHfIpuNOV9xCoPkj2dmueXjUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432927; c=relaxed/simple;
	bh=co7fykMeo4NZCzu1cQcSXbnbjB6C3fx8WwFBh2op7X0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5uOmmJVgAVNWlIb5p/Iap6hX1br2+u/jUQbxdTZGmCRmxTA/eWFJEyw+CRFsQWptccdQ9eC6vbW8Suol0S+P70uMzV6lmRqrOjRe4Vvhxaq0jen9vDy85FPitydQqxFrVSy03Ug/Dxkh0slOF8woOuYiJOgv1dsy2X3s7a6LvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyBEuhGM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyBEuhGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3B7C4CEE9;
	Mon, 24 Feb 2025 21:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740432927;
	bh=co7fykMeo4NZCzu1cQcSXbnbjB6C3fx8WwFBh2op7X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VyBEuhGMIckCiBV1CM5MjPnswV7ZLu4zkZHkce7f76I4ZcyvMjbNBpbmxjOORDyMV
	 sL81ZaZrPpz+r+H5WuIn0mkOA6PXbKrbKb+DzrW17Na0z6W+8U2Jgn6Tyq55fxxakI
	 njKcVXRMkXtbfpF5cURvWZxbATbhsQS5jmitCND1cIIEjAxVe5LNhyhyC1pWbyhSRa
	 6HgWe5ZJ0jf2f6Mhr8yQDYIG0KGn9zytHG5kBIl/uvFcobg1GikLwl56yK8bAzQrQO
	 hpTvaC67FZLQHi6hYn6/5FEMFxiyh7REuxFIoNkuwHWfg1HKZraFZiG2X427teFORY
	 U3Ti4BDjMsO2A==
From: SeongJae Park <sj@kernel.org>
To: bus710 <bus710@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
Date: Mon, 24 Feb 2025 13:35:23 -0800
Message-Id: <20250224213523.2501-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224200655.2254536-1-bus710@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi bus710,


Thank you again for your nice patch, but I think you're not very used to the
normal process of Linux kernel development.  Let me give you some comments
about that.

Firstly, if you post a new version of a patch, please add the version number on
the subject[1].

On Mon, 24 Feb 2025 12:06:55 -0800 bus710 <bus710@gmail.com> wrote:

> Hi SeongJae Park, 
> 
> I found a trivial typo in the Kconfig file of the damon sample module
> while I was trying to do some experiments with sample codes.
> The word "sameple" should be "sample", I believe. 
> Please find the diff below.
> 
> Since the title should follow the format of the project, I sent a new
> email to the mailing list. Sorry for the inconvenience.
> 
> Thanks for the interesting project! DAMON will be very useful for many
> projects.
> 
> Thanks,

You are using explanation body as a mixture of the two different parts.  Please
refer to the documentation[2] about "explanation body" and "commentary" parts
of patches for more details about what to put on where.

> 
> Ps: I found I didn't change the subject! Sorry this is my very first
> communication with the project.
> 
> Ps2: I see. It should go over my signature. Good to know for
> future.

If you want to reply to some of my comments, please reply as a normal email
with inline commenting style, not as a new version of a patch having Ps
sections.

> 
> Signed-off-by: bus710 <bus710@gmail.com>

Finally, please collect 'Reviewed-by:' like tags you received from the previous
version of the patch if possible.

Because I already gave you my Reviewed-by: tag, I don't think you need to
continue revising this patch.

I'd also highly recommend you the entire documentation of patches submission.

[1] https://docs.kernel.org/process/submitting-patches.html#subject-line
[2] https://docs.kernel.org/process/submitting-patches.html#explanation-body
[3] https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes


Thanks,
SJ

[...]
