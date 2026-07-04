Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73332D9EED
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783193850; cv=none; b=VibPKMaC14+2HkhWOSy4tgO5Y34kMip+TxhSzJqI1AKzeOjrU9ycZlvSbMJ7FIhiP0aYjoiBluqq7yfXa0THCFqsCA9wOo+9GAw+8fqWtRCoLutDr1LHTj8hP00U3Gta7TIf8pRu7lGIP1LaZrikatKA1KoFwQ7Mn8j/ysk6UlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783193850; c=relaxed/simple;
	bh=ZgnfMSlweiAvPo6HX8Scj0oJ7MZGNm2M3M5fJD/OKQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POi6Rsl/JUHU/FdArr/yfBBbpDubyItV34sQ4Eq5p2Im4ycrBl9uplC4g9aUMILCge67PPWGeXgXuOjYPas2Nnfo6V4ieuMprkYtLujrj0uyXgZThz8WvdnyafYJC9/EnytZcFOkKHPEVp68TD5X+0w0TSQfRnbVCu4QhNK5/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/LpwhTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/LpwhTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618671F000E9;
	Sat,  4 Jul 2026 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783193849;
	bh=ZgnfMSlweiAvPo6HX8Scj0oJ7MZGNm2M3M5fJD/OKQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X/LpwhTlpVRCaffldV/uIUhW5fUo+NJyJUpxUUV2zJT5EF6uHgwd8anpFlWo0VvMS
	 /U4VsN6zQgCzrOZq347GsWNHefV4VPXJ3L1Z4MTqIJQG8mjEddd+OM0PUsUaRurEKn
	 s4WgJxW2fEx5D0QmJZIsiIzsqooETULp1zXHbtE6G5j2o2cML62pC+lI5u8TP96Ro9
	 KGQh51F7v8NZTM4u8K6dGE0FDJakwu0LUdXjFUtak+rLl4KLOEahu/tTWsarGHJEWI
	 wIyV+ojhQ++DVa8I0PeQJTsyH7tAq3i1wiM7mgsMFGFzBztWz8JxClD1OfrPXp9z0e
	 YwXVOYGJtT04w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 08/11] samples/damon/mtier: stop all contexts with single damon_stop() call
Date: Sat,  4 Jul 2026 12:37:25 -0700
Message-ID: <20260704193725.1365-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704182056.0C3621F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 04 Jul 2026 18:20:55 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] AB-BA deadlock in `damon_start()` error path with `kdamond_fn` over `damon_lock`.

I will fix damon_start() patch in the next revision.


Thanks,
SJ

[...]
