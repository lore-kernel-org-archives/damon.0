Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E2A38B12C;
	Mon,  6 Jul 2026 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348175; cv=none; b=W+2Y0M7uttSQKRgR8aCPMHgxAZiqx9DuCxvqdrj1pF5YhaF8NKL0T5udwn+EPkLpOuIMIjAbsO/vkoWZCC5vlCVBRr6s6NZ7Qq9mYdDdPixfvgytqG5zTVkI6eMjy9t6V/YMwbX0l21i+DWc+3oXVyRPQBGdbmnuRUdRxpwauQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348175; c=relaxed/simple;
	bh=IUBZBC8jM7ZqaMmrXQsElfN9XQ4z0aBp3JH2Ym6ekd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vm5BnJ7TjHVkUd48yFeMzzUWl5CnvP5Oml2+BeNOYtvGsiQ0Aq1oVv/d+jf/qhMcZGeXsh3aQ+66oIhKJor9xUXBkY7lBL2t0VC9paCZ4RZqyxMjO5oBkfW/33bhoP7dTmplSlKC69s17ornFCAmL00gI/fi1PSQ2Ci0hVOHaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grXeyKe1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grXeyKe1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CAD1F00A3D;
	Mon,  6 Jul 2026 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783348174;
	bh=SBCRhKZI583zCcBg/zj8+qNKFcYvMBYzCOYKUJEwpkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=grXeyKe1dw9UXQJWwPd6e3WCw6WWVG0VN47dubQw6EL4/mx1gGIZFP0Y7ME+5KYvg
	 yh4G9UUzszbFR9q6qW54Ebyek9BAoIZdFx4ki86ozkUCuuwL51TC/y9akZ/3zwYOU7
	 rvEDsZVMIZJQ1WmsEOdhhwYtFFIRn+y4ep7jdesJaUBrlejcJ/0Mb7a0JG0mBFWaxy
	 3ms1xNB/vSZcHE4wvEn60qP6Lani3uBhMi70R3IlllVow2OsZbZRzp8zZYx0CXEqiL
	 QD9EbcBaUV78/0ezFV2bfY87Qh1e1kKdYA5c+wfav83OKa+jftcPWonwPF+jxqaoKp
	 NOJ7lHhzO0bHA==
From: SJ Park <sj@kernel.org>
To: wang wei <a929244872@163.com>
Cc: SJ Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/damon: check correct path in ensure_file() not_exist case
Date: Mon,  6 Jul 2026 07:29:28 -0700
Message-ID: <20260706142929.93146-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706134305.5224-1-a929244872@163.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Mon,  6 Jul 2026 21:43:04 +0800 wang wei <a929244872@163.com> wrote:

> In the ensure_file() function, the "not_exist" code path checks
> whether $dir exists as a regular file.  However, the intent is to
> verify that the target file ($file) does not exist, not the $dir.
> Testing $dir makes the existence check effectively useless --
> it tests the wrong path and thus never catches the case
> where the file is unexpectedly present.
> 
> Replace $dir with $file so the not_exist verification targets the
> correct path.

Nice catch, thank you!

> 
> Signed-off-by: wang wei <a929244872@163.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
