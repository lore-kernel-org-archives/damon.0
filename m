Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711737CD22
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222144; cv=none; b=dE5QZUt6d0t0f8/0JUlz4NyxvBLnWwHxObPSLQPDLRJa5ABX2u+1Vk82b2mgfUCwyx4jsYrFHtM6D1fgwZcBWmPQz6nR4DzYesZXppaKkXTPgWEfK7AdmoDjXAVpCTgXT6veeLaku1Xx73s5fRwifbGYO+Cd9SApCfrAg2xRFhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222144; c=relaxed/simple;
	bh=ApQEG9xoJYnYw7qN2W/ynT/sLOkJtWYPchZ3FY9jZQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tb+3qOTghdYhNAoVFXblS0MjkSYBfQWsv/SCp4cKYpOyPe9b7nhf2Qj2fqlxBXwfH01NK2GC1utpXQu8z+zPKa4/m0ITo0Dl9ywhhwixSWx5s63h31Jkfe2QgzSC/0rUDf9/1japLTjoIS9Y36WylpQwkvGW0drbvVGkBoF4wmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=invwhsBV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="invwhsBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5A01F000E9;
	Tue, 23 Jun 2026 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782222143;
	bh=axx5xGDorE2uqHVpW3aJeeG0z/8+R2NFGpAl5RY5R88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=invwhsBVjD72DmBGKDpFtTL+nFJaiR/nWinry6MqAeZUbJemHMPGaY4qOB+d9m2hU
	 6FVYFYaDsh/1doBYOzOEJUw3M1i9u1NuCScmIEq02Rlc4Ev6FGLiEclzytMf9VAGNM
	 /uf9yByYdOwzvwFmp8fgrQ0VYu5rps/UAUGHiEZLeu2NAuGFW/koHFRdWmxxJcpClf
	 NJjxqDTcoVjMJu+bnHvnVZE7HwPLT/1+UvPI06l4xdo9UEetEAD/YZuVaEPEV/PMjF
	 xZvikEEkb8W762d6tUUNHy0cmInn+2wTpU8BlWdj1Kw4Bz+YA4lKH/JPMe3CNwvLIT
	 EdhdnFkFEhoPg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3] mm/damon/ops-common: handle extreme intervals in damon_hot_score()
Date: Tue, 23 Jun 2026 06:42:03 -0700
Message-ID: <20260623134204.66401-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623013428.4A8D61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Jun 2026 01:34:24 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `age_in_sec` calculation silently overflows on 32-bit architectures, breaking age-based subscores.
> - [Medium] Multiplication of `r->nr_accesses` by `DAMON_MAX_SUBSCORE` silently overflows 32-bit arithmetic for heavily accessed regions, breaking hotness scoring.
> - [Medium] Weighted average calculation in `damon_hot_score` can overflow if large weights are provided via sysfs.

All of these require unnormal user setup, and causes only monitoring results
accuracy degradation rather than some criticial issues like panic or memory
corruption.  No blocker.


Thanks,
SJ

[...]
