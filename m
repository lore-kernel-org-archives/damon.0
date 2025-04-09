Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323611C5D7D;
	Wed,  9 Apr 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220202; cv=none; b=L9niqXHqtCWakTGj1eeCsfP9LWgTeZzaz7VWo7soyFITnlWGx1YMad1Ibdh0T8gfD71Yv1WbXhfRP2LZ99XUcaxEeqF+XH/XVc8HkuzHq2RMIRZ+sqbD9LXVakYXYwmkPy7I+SJw6XJinY1bpBqlVkxzDzLgof/ZrMVMUyG44Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220202; c=relaxed/simple;
	bh=50s0u84qBzXTcFhLSJ+9RpG7BuXy6/iac45+z3TFUng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkgVwohUVwYXW+i2/7FzB2MWquOAdPOg17D3orOYhx+Qp7uuUQ/i7+iJN0BJSW0avKQqC/OUrNbw85bzg3zibzsldocVa2Wuwne7PHcPs+6I+uJaB8OkKBJZYP5Z0U/8gh+WCz9VSwl8RokuM2vK5TXIsF4Np2W9ugBmOIWemeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmQR9jtP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmQR9jtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758BDC4CEE2;
	Wed,  9 Apr 2025 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744220201;
	bh=50s0u84qBzXTcFhLSJ+9RpG7BuXy6/iac45+z3TFUng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmQR9jtPoDZeujaeiwqLrcWlv4KznDTPtNUZKG6ARIZY3tf4l0spuOirtcKACEIfk
	 VH2KhumQmgCPxpab032HDSUJEvjrfH6eaADRbp/ZzGFWcamzXT70cS9qMfLArm8t8i
	 HdCNwq7Kg2ViKp0zipUnKpaBdamjm4CeU62GrzayMmmeAcIVbGT2Rz55IvovUn2rBM
	 2n86EsoNCh5mAyiOg34nPLi/UBMf103r06BENCx/0OinNhLv/C6ya2weGwHm02SQyh
	 71dY1/BJoopZZCN39OWvSHPBWkcZQ7WAO6bv2PJ4PvyV8+fMl/HskEK/tL8/7ZzU36
	 djj8vYrS3ln5g==
From: SeongJae Park <sj@kernel.org>
To: zuoze <zuoze1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring above 4GB
Date: Wed,  9 Apr 2025 10:36:39 -0700
Message-Id: <20250409173639.52133-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <0e82b335-09ce-4a0d-809e-f55405ac7953@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 9 Apr 2025 15:01:39 +0800 zuoze <zuoze1@huawei.com> wrote:

> 
> 
> 在 2025/4/9 10:50, SeongJae Park 写道:
> > Hi Ze,
> > 
> > On Tue, 8 Apr 2025 15:55:53 +0800 Ze Zuo <zuoze1@huawei.com> wrote:
> > 
> >> Previously, DAMON's physical address space monitoring only supported
> >> memory ranges below 4GB on LPAE-enabled systems. This was due to
> >> the use of 'unsigned long' in 'struct damon_addr_range', which is
> >> 32-bit on ARM32 even with LPAE enabled.
> > 
> > Nice finding!
> 
> Thank you for the kind words!
> 
> > 
> >>
> >> This patch modifies the data types to properly support >4GB physical
> >> address spaces:
> >> 1. Changes 'start' and 'end' in 'struct damon_addr_range' from
> >>     'unsigned long' to 'unsigned long long' (u64)
> >> 2. Updates all related arithmetic operations and comparisons
> >> 3. Adjusts print formats from %lu to %llu where needed
> >> 4. Maintains backward compatibility for non-LPAE systems
[...]
> > 
> > But, this doesn't seem like a very small and simple change.  I think we can
> > find the best approach together, by understanding impact of this change for
> > short term and long term.  For that, could you please also share how prevalent
> > 32-bit ARM machines with LPAE are, and what would be your expected usage of
> > physical address space monitoring on such machines, in both short term and long
> > term?
> > 
> 
> Thank you for your feedback. I agree this isn’t a simple change, and
> the current approach might not be optimal. Let’s work together to find
> the best solution.
> 
> As for the prevalence of 32-bit ARM machines with LPAE, these devices
> are still widely used in our product application. The main goal for
> enabling DAMON on these devices is to optimize memory usage. During
> usage, we identified this optimization point, as well as overflow issues
> with bytes* and other reclaim statistics interfaces.
> 
> These devices are still in frequent use, and given their large installed
> base, they are unlikely to be replaced in the short term.

Thank you for kindly sharing these!  And I agree the devices could still be
actively used and wouldn't be replaced in the short term.  I believe making
DAMON supports those devices is really important.

DAMON aims to support multiple address spaces that not limited to only virtual
address spaces and physical address space but any imaginable case.  I hence
prefer keeping DAMON core layer independent of the underlying hardware as much
as possible.  I therefore still hope to continue using 'unsigned long'.

Of course, 'unsigned long' wouldn't fit all cases.  32-bit ARM with LPAE is a
great real example, and there might be crazy future use case.  In other words,
this could be identified as an issue of the operations set layer, which
directly deals with the given address space.

I think another approach for this issue is adding a DAMON parameter, say,
address_unit.  It will represent the factor value that need to be multiplied to
DAMON-address to get real address on the given address space.  For example, if
address_unit is 10 and the user sets DAMON monitoring target address range as
200-300, it means user wants DAMON to monitor address range 2000-3000 of the
given address space.  The default value of the parameter would be 1, so that
old users show no change.  32bit ARM with LPAE users would need to explicitly
set the parameter but I believe that shouldn't be a big issue?

What do you think about the rough idea, Ze?  If you don't mind, I could
implement the idea on my own and get your review/tests, or help you
implementing it on your own.  I don't care who implements it but eagerly want
to make DAMON supports the real use case well.


Thanks,
SJ

[...]
