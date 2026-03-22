Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44179175A6E;
	Sun, 22 Mar 2026 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774139702; cv=none; b=bZm+U4JdyBnTMMq9lB+4I4fg7FxGeGHTU8wJeZw3BDst96lZahcps5kV2qaSRS0e9Z7EhUZ90qCv+i8AkwbZZn3vXCmv06vpkaA5mJEAO3p6LpxnS/6gCKweyD5Mu+dk/CuV/IHDFGSlhZGiTLQhGsd+P0wTAkpoXLtRv8Xi1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774139702; c=relaxed/simple;
	bh=Wt/h4AN1e0QgCx7j7jEnWZz6uKMuHWliIpQ3bGwhTuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqj6NV8R4bpaqLbXR9KP9WeAlxFFwvAglzt//e2SYhJ+4Hvjk+pVe76B6dkNuLLgsC9OVHoOFK10l2RPBlScPBj6nwe1C+XHC9OAs0zoppAgXpuFhUgOebFC706jocbQ0qOMUNTertLnmblzAPnAIQ7lt/lhPNMG74AqSmHuKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzSLKcIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzSLKcIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD47CC19421;
	Sun, 22 Mar 2026 00:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774139701;
	bh=Wt/h4AN1e0QgCx7j7jEnWZz6uKMuHWliIpQ3bGwhTuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzSLKcIfyc/SrR+kVqO4Lun+8kTCE0KKvE3gmizGnjA0xvJb2HSNoygbYUeljY0vk
	 ASWiT3mbHNpJtJznhjJAfDUe37meu3KnXynUv6N5vXRtO3XbXP1V6YGF34/er6aK1s
	 uMV7dmcC0zYn47Y3bZ8wjmBF8EioBKQJFfoVtCtZrkz1b9bfQLMZtln2pCIACyTpPB
	 WUmW9n6mBNbRWxPaN1PXSNROr62McwR/uAEevlOmws9Xt17Gwn5H39ZLc85CAsu+sg
	 GC0cnjWplQKx+1MFFO0tjVA+QPJl3zODOjBcYYBVGawL3htOzPR8IYrlIkby7SzrP5
	 AaSPEC7JhJbGg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko) [PATCH 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Sat, 21 Mar 2026 17:34:58 -0700
Message-ID: <20260322003459.86313-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321202858.98091-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Mar 2026 13:28:57 -0700 SeongJae Park <sj@kernel.org> wrote:

> TL; DR: I think this needs a few changes.  That can be a fixup (picked by
> Andrew) or respin for v2.

We already have 436 patches in mm-unstable and 40 patches in mm-new [1].
That's 476 patches in mm-new.  The total number was 392 five days ago, which
already made Andrew concerned [2] a little bit.  I also agree the concern, so I
will stop sedning non-RFC non-hotfix DAMON patches until v7.1-rc1 merge window.

That applies to this series, too.  That is, I will post the next spin of this
series with RFC tag again, tomorrow.

[1] https://github.com/sjp38/mm_git_dashboard/blob/master/summary/summary.md
[2] https://lore.kernel.org/20260316142636.0c29d431b1c8bf03e01c3630@linux-foundation.org/


Thanks,
SJ

[...]
