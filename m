Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4530C16C
	for <damon@lists.linux.dev>; Wed,  3 Jun 2026 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494576; cv=none; b=YIGxGypEJyE38SoW9AniFZjMZ9fMC6CFIEktO+7YNFWHP8c0lUC5ajpyQWfdy4B1syyvMHBrvZrDWFhqFGBt69ZpuZ8sSL+z51U3i2M1nHoSzmupE9Os120YBN2ZDPlMugLr7DhIVd+buB/nypVEmD7HJ2gGIqkbNOP0+B3N1Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494576; c=relaxed/simple;
	bh=Gii4SEbwE2l8MHw7SrZ1AQ4HeMBtArqvxgdc8J0nn7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmpJ5nXxJfqokYZeQQpYTzhlA65EW3ncSRu8Zmz61XuAareiQcKBesFRzJhtlHwviZR2//jKdUvBufn4BBiBjgxLCT5O4UL9rZsipQOqmuveihbv1kZgLukVrogWXv7IIZniFCxPh7LFRJNIm8DBV9cVkrWXITzbVXtcgtHkEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMcXIYuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMcXIYuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E232A1F00893;
	Wed,  3 Jun 2026 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494575;
	bh=ynA7Lkds5Qk50Xaiq3xfg4qh83ca4m9FlkJgWKCZKcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lMcXIYuMARtXeBPER6bCFMgG5pmNbyqJkmgacN+gKgj4hpMLfx3Bc4nkRTfjPSLD0
	 3wL9DXXox5j6jxrLGSpsEDN7aCMvEOh4uIXILL1iNXhP+clQWm86V7MudwNuHUtL4M
	 updoSmhfcpLe0bnN1xaWx4avRtzLlB6l0tJnVHUfYc2InDBmzmn7oeZhIybB+R8gSu
	 uNf3RqBpZ5NpsxL3VHRebEHxjUQmogJ/NHjfx7pbReoFpRXsS5+peXM+lxuwcrfS1k
	 7JFgqdYVsgVZ00tMIllbyGBX+XwHIOvynJU5EbrsLiYbzIm521yrDLmBUi5TGgxkI8
	 H/s3mnlMHFQrA==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: use kvmalloc for target regions array
Date: Wed,  3 Jun 2026 06:49:26 -0700
Message-ID: <20260603134927.62746-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603112306.58490-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  3 Jun 2026 20:23:06 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> damon_commit_target_regions() temporarily allocates a single contiguous
> memory region using kmalloc to store copies of all damon_regions of the
> damon_target.
> However, if the damon_target has a large number of damon_regions, the
> total size may exceed KMALLOC_MAX_SIZE.
> 
> This problem can be avoided by using kvmalloc instead of kmalloc.

Nice catch, thank you!

> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree.  We are now quite close to next
merge window.  We (mm community) want to focus on making mm.git more stabilized
and therefore ready for the next merge window, rather than adding more changes
that are not really urgent.  I understand this series is not really urgent.
Hence, Andrew might not add this patch until next -rc1 release.  In the case, I
will request Andrew adding this to mm.git after next -rc1 release.  Let me know
if you think this is really urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ
