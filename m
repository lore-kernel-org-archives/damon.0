Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21681519B4
	for <damon@lists.linux.dev>; Thu, 14 May 2026 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734050; cv=none; b=i4GZMUbvPWii8iyo9F2xASv1lNaNYbrGO7nPY7W7UZa1q27ml6bAhzYVVDrFScF/qp/DmOpCqEWjra1r9qDXTsek++dDutjBgBvAnw2UlaKlcVQO5Bsg1CHbKCofQHFkyN94hwrcGA8XXOZbW1+KMSjI0NaoekYMMk929NTiHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734050; c=relaxed/simple;
	bh=hWLBz/di0Zz3TQruy1+UK9kfm16vWLQwCBND+qlkNng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5jDLO86VfaeHf0zT9mGCZmDcUdkjhysSQXng5uxugvtFxaibKUlKVauF97XJ1DKpvBm5l2zuhDNCEpc4OWbyNJBKTCDQ5wzdN6wLaCi0gTiC2xx60n2nTd3N/AW0TtTN5z7PEH5wK29rkUm/JBa1O++EfGkk1HOHzIHFjGHXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e55GBQll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e55GBQll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59956C2BCB7;
	Thu, 14 May 2026 04:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734050;
	bh=hWLBz/di0Zz3TQruy1+UK9kfm16vWLQwCBND+qlkNng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e55GBQllrBpp3Upe9RbNP//wwXVMqF889HLXgv43ZZauD4KF7/yg41yeDbruWMYAM
	 WbdlYtPMWOgDCF0Y1yOMH4ehmEubV2Vt/f46tTTbM9Vp2yOK0eXCKfjjUbl99UfVak
	 tjImFTeZ8i5Ipl1AbgSBVSHiJ9fqrPjhlI6FN7nTqQyRJPY6s4sF3ssGtj8AdrtM4b
	 lW9JWD4MvP3nZyn4wAF8xs8MtsKeyvAlQPqSmtxACYgX4z5gKq8AO/sh93pQHyzmBn
	 ttNHjbiFa4E61bdXr/3xF9NHpCpA8lYUZNIr3n6V0JGecg6ZSe8lODx1xz97X2lPIV
	 f8ElT2cZZMHTw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y 2/2] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 21:47:28 -0700
Message-ID: <20260514044728.95643-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514014945.766F4C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 01:49:45 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit fixes a state synchronization bug in `mm/damon/lru_sort.c` but misses the identical bug in `mm/damon/reclaim.c`.

I posted [1] that fix for mm/damon/reclaim.c.

[1] https://lore.kernel.org/20260513045238.194161-1-sj@kernel.org


Thanks,
SJ

[...]
