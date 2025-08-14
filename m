Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F121C9ED;
	Thu, 14 Aug 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187472; cv=none; b=iD9/UQA7jceKrlBBSOrYw1Ce2pOTvSv1UX8vH4utfILyqK7yriFUE8wAAR/7FtRlhOtEC4tIiHNYBgw1s8pxwF6mBOuOPbVeUUxtSyn/Mx/4vRtKgXx25TtBx+vZSWxxleXSzC9ef+tP5WTdnMy5RvK5ZSpOUqmHaEcmr9hnUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187472; c=relaxed/simple;
	bh=0DvQEAd0ldq1r3dzwWT+fSNKJ5CZVR01NTIGwBUpIL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcCQCZyjag5YGSLL8Psp0TTZBqYDgb4Byhd4dXT+3D7S8wWjB/U5ox7+sgbOneanWBfyqbQxKzmMcFXo0JeqTwbTxwOR8K/mEkA629U4tDopr7QFa/+lunXb8IGb/qsh1XLnpO3sxtZUycRwW6XEvjUYy1zkgitn7Nfke/h0QvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1FZCpuG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1FZCpuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A5FC4CEEF;
	Thu, 14 Aug 2025 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755187471;
	bh=0DvQEAd0ldq1r3dzwWT+fSNKJ5CZVR01NTIGwBUpIL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1FZCpuGsRG6LoTlMwU47Eq1G/89Mq76dfMn5sDX6GxTtkW7JNlOaLZUkB5MKsNdj
	 tWPnUMIbJXcHZJIM1iyPIKOoOHX+C9A5o1jV/5Z1gtA2k/qUqEttQ7gQb/YftF4t1R
	 +btu+JJB2uMxtwXvZngJ3YbUH48zMUM1QcM4NuresbPlclmygvx621Q2ACOq/Cvuww
	 w8ZGVHpeU+pKv1JSkOPjXF9ahETOkyKl1tUbvWLeslO+kzJ+GdZWZWdM0xRQvnQJaC
	 gsK9PNDoF6d1mKs+xG6UQoMftDoi7dygOlOAMkJAXRHfUGtiHPaXqB6n4Bt6PNtwzr
	 iwlOqwVRkPz8w==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 00/16] mm/damon: support ARM32 with LPAE
Date: Thu, 14 Aug 2025 09:04:29 -0700
Message-Id: <20250814160429.67476-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ee37ea36-7298-4174-b146-fd62b24ef345@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 22:07:12 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> 
> 在 2025/8/14 8:57, SeongJae Park 写道:
> > On Wed, 13 Aug 2025 10:25:44 -0700 SeongJae Park <sj@kernel.org> wrote:
> >
> >> Hello Quanmin,
> >>
> >> On Wed, 13 Aug 2025 13:06:50 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> >>
> >>> Previously, DAMON's physical address space monitoring only supported
> >>> memory ranges below 4GB on LPAE-enabled systems. This was due to
> >>> the use of 'unsigned long' in 'struct damon_addr_range', which is
> >>> 32-bit on ARM32 even with LPAE enabled.
> >>>
> >>> Implements DAMON compatibility for ARM32 with LPAE enabled.
> >> Thank you for working on this, Quanmin!
> >>
> >>> Patches 01/16 through 10/16 are from the mailing list[1], add a new core
> >>> layer parameter called 'addr_unit'. Operations set layer can translate a
> >>> core layer address to the real address by multiplying the parameter value
> >>> to the core layer address.
> >>>
> >>> Patches 11/16 through 14/16 extend and complement patches 01~10, addressing
> >>> various issues introduced by the addr_unit implementation.
> >>>
> >>> Patches 15/16 and 16/16 complete native DAMON support for 32-bit systems.
> >> Overall, looks good to me.  I have a few change requests including below major
> >> ones, though.
> >>
> >> First, let's squash patches for fixing problems made with patches 1-10 into
> >> patches 1-10.  If you don't mind, I will post RFC v2 of those so that you can
> >> pick into your series.
> >>
> >> Second, let's keep DAMOS stats in 'unsigned long' type.  This require fixups of
> >> patches 1-10.  If you don't mind, I will also do this in RFC v2 of those.
> > Instead of posting completely new RFC v2 of the ten patches, I think posting
> > fixup patches as replies to this thread might be a better approach.  I will
> > make fixups first, see what looks easier for working together with you, and
> > either post entirely new version of the patch series, or send individual fixups
> > as replies to each patch of this thread.
> >
> > And one more questions.  What is the baseline if this series?  I cannot simply
> > apply these patches on mm-unstable or mm-new.  It would be nice if you could
> > share a git tree having these patches fully applied, since 'cherry-pick' is
> > easier than 'am' for me.
> 
> Hi SJ,
> 
> Thank you for your detailed suggestions on the patch series. Please allow me
> some time to thoroughly review each of your recommendations.

No worry, please take your time :)

> I haven’t responded
> to every point immediately because I’d like to first attempt updating the patches
> accordingly. If I encounter any questions or issues during the process, I’ll promptly
> reach out to discuss them with you, very appreciate your patience and guidance.

Sounds good.

> 
> By the way, this patch series is based on linux-next(commit:2674d1eadaa2).

Thank you for sharing this.  From the next time, please use mm-new[1] as a
baseline for DAMON patches if there is no reason to not do so.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
