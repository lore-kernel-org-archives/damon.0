Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC82C21C5;
	Thu,  4 Dec 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860516; cv=none; b=IEy8DRoKrJJZEmU6D7I9LtVkHfVDRcEWi5SL/aaE5w9U2Bn7gs4BKEi85nKW65IE7ydLyQvNeba3R4zQdEBjHaE6WkWzZK9qzEqdl0OrddT2qrL1Z0C++I/DR63PQcgkBwS+HZARN/8MFILJap1IEav0vGBTJAyiiTxdGIrq/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860516; c=relaxed/simple;
	bh=pR2jWjpjbwh4nwMGO8dc0JFboTlxP3WCMbfFWA/9guQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSgOeJ4drHll7HlYud1oaun2UlXGy/NyNCNQ4mExNb1qeTrrSLLhGzzUYlfOIUDKqJ3G6lbUslCmBQAUYVWpvGtNZcjnLsczqyORlKciEEqJxcVvYXuUMFYHWLH43gEE7jZioVsXJysH64NKGuWeemYFD+bSX9xbTLY294EOQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JugDzLsA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JugDzLsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F2BC4CEFB;
	Thu,  4 Dec 2025 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764860515;
	bh=pR2jWjpjbwh4nwMGO8dc0JFboTlxP3WCMbfFWA/9guQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JugDzLsAwewUuWm3RGfQrZU8thoOaR36Rclgz6nb5R1ak0sG6BBGpUJ5bx2X7JKc5
	 slbsVm2TAbf5qd9yifylxOoIS6NVdzgclPhu661zbciYKVNb/PomDtNEefoRE1Bt8s
	 sPevnXvV258BpJwwvlt6MSRFQPlJIOA2wqStB8TAUQskOJH9s5zTDsiAszajhY0840
	 BlZjbynt2Cu5vvMwemEMnbi3Hv4kGId99C/6EboJU9e47hfGI7bkbkpgq+LwK6ISgH
	 9aA2MkwnTFn5ZKasx9YB9PaZO5GZdHNBG4ja0eME+zfat/3FWHFQ1H3ls5/0MK9va9
	 YQfX5PYSoRAhw==
From: SeongJae Park <sj@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: avoid damos_test_commit stack warning
Date: Thu,  4 Dec 2025 07:01:50 -0800
Message-ID: <20251204150151.83380-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204100403.1034980-1-arnd@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  4 Dec 2025 11:03:54 +0100 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added damos_test_commit() constructs multiple large structures
> on the stack, which exceeds the warning limit in some cases:
> 
> In file included from mm/damon/core.c:2941:
> mm/damon/tests/core-kunit.h: In function 'damos_test_commit':
> mm/damon/tests/core-kunit.h:965:1: error: the frame size of 1520 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> 
> Split this function up into two separate ones that are called sequentially,
> so they can occupy the same stack slots.

Thank you for catching and fixing this, Arnd!

> 
> Fixes: 299a88f6ec13 ("mm/damon/tests/core-kunit: add damos_commit() test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
