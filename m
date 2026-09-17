Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBBB30594E;
	Thu, 17 Sep 2026 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608506; cv=none; b=nkFdxsi/TmdGywTTGjFC+kcGhG/PvlsiyhamCMY07uMtn4FSZkTo9M2lL+W9diQlYGjFwqIB9kF4aK1NHA20rgxMP9+wNCZMukf/QC8ovV0AJ2y01l4AJgLQVVMZsg0qXlhsMEwyaxpYlobWaX2IY38Afb/2jEQKh7AnFvB/ACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608506; c=relaxed/simple;
	bh=rwfaP0A9WrZh81lO5ImmCRiHIlbsjwM1WjE6KWqyi3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUdSuUhPatHjJa1EGq+VLXXicyfS4ef+U9Zc2s6VIfOUaFk4REFGSYJ/dGLBbz2y5jo8YIe8RjzWS4ENp/GMB0NtmMChKSUw1Xr3GAtCSbQP9qnkrT6+hIs5enJLSEgEFPNFPNxfWmAUFV7FNwTis/jM5ufxPR42vEGCzkoLBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCUbDUZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCUbDUZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5681F000FF;
	Thu, 17 Sep 2026 01:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608505;
	bh=+h1LZVMHdLO/1F+KdKe54DtOJ0v+YLXQMJ2Sf1hTygE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gCUbDUZjCtGJH+c6yWWdXTaAuGUZiYJkbZDXlpJ3Jm1fF4sb99EU9A4qrB/wBCB+Z
	 a9oVpj9j5mC9MEn3QMOfphCCyMOqFrK5o+Hos1yumguo1UyA/BsWOkzpEO1bajm9cG
	 zHso1QXWI186VFn8kE2pK2SuilB6E0sbnNmMRmwQxGOCMeNQEcUxVOWin6f0CTCl0R
	 du7sHe7o7grMmm3yy62cobSOsxIWQfWX1p+utgYkkSND0rLv5cN57Qlyy4Josl5UeF
	 /m1J8dxyN9S7CnNc2UyqH4RQ5vfUK/4lg2FWD+26XgrAUkx8IAxXzUo7HMecR9Ieb3
	 IlRezqgx1lWOA==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] mm/damon/core: fix the size charged for a filter-trimmed region
Date: Wed, 16 Sep 2026 18:28:17 -0700
Message-ID: <20260917012818.101391-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917003553.2465523-1-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Donggeun,

On Thu, 17 Sep 2026 09:35:51 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> An address range DAMOS filter that partially overlaps a monitoring region
> splits it, so the scheme action reaches only one side of the boundary.
> damos_apply_scheme() reads the region size before that split and never
> re-reads it, so the quota charge and schemes/<S>/stats/sz_tried account for
> the whole original region.
> 
> Patch 1 re-reads the size after the core filters have run.  Patch 2 adds
> KUnit coverage for what the function charges and reports, for the trimmed
> cases and for the cases that must not change.

This series is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
ping me or directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
