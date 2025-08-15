Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D630F522
	for <damon@lists.linux.dev>; Fri, 15 Aug 2025 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278748; cv=none; b=iZdfgwpcn3DeuSWjlMLMFGMAnRsqzIeWQnstFY/JKOEocwz1BqD5yxNHRf2D3dpXb3lguyAwNeZ0WmeaFmisGSmnxHiD6AeQBdVy2IoiX//4MbwYt+fEKF/3aiclUQMbwos+jCJrRoxAgrjF6rSX0T/bB5RmpRpgaawxoq1kwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278748; c=relaxed/simple;
	bh=msGWC1/RAZgteUgYi93sQRCDJCKwtZbfv2QzEL6uo3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TW3v5AOrs2KzQ2WehId24HtyiNRN53Z0JkVRZh/0BSGwe62pnifz48DKT1TjL4i1mGHCq7c3/+ePkd0qubE2oUlDn5ZHHKBWklNyzWZ6VeWjcKkVBkTdVQyejIJgud5Ns+76bQFi137aHbBlvANtbVpTqZ9NqxI8M74ZGWe938o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No3wDu4e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No3wDu4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B03CC4CEF1;
	Fri, 15 Aug 2025 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278748;
	bh=msGWC1/RAZgteUgYi93sQRCDJCKwtZbfv2QzEL6uo3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=No3wDu4ePfXF5qKNrBOEU0BcU6rHhpqx3CuOPn6mEUvyoonDg5qO2qEgRwWrADzK9
	 bsGYwaGn6VRDZQ/pdz8fG+qA8TLawAIezHHabhToPbksyUaIpUycHwSNrJA24nLrRm
	 7GWsCcW0XAywWvn+YECqFp0b87RtjAQL25LRAq1R8gQjStkuQ/HUOk+zWlpd0H4fdJ
	 28iYdihGrMfdsnOs4BicidthVZCVbiRMYocpDhUJtnzaH0SlmRfULaA7KMcydWk2jO
	 +8JkZi+biZ+aKvgSuSFsMUct+QeenvfogVW58tqTsGUGEJMLTdGeyf5lchWIkPuuCU
	 t1Z+f3lVVQNAQ==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stablee@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: fix damos_commit_filter not changing allow
Date: Fri, 15 Aug 2025 10:25:45 -0700
Message-Id: <20250815172545.16704-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250815094059.133769-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 18:40:59 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Current damos_commit_filter() not persist allow value of filter. As a
> result, changing allow value of filter and commit doesn't change
> allow value.
> 
> Add the missing allow value update, so commit filter now persist changing
> allow value well.

Thank you for finding and fixing this!

> 
> Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit function")

At the time of the commit, damos_filter->allow didn't exist.  I think below is
more correct.

Fixes: fe6d7fdd6249 ("mm/damon/core: add damos_filter->allow field")

Also,

Cc: stablee@vger.kernel.org # 6.14.x

> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> While fixing kselftest, I found another bug and succeeded in
> reproducing. I think this patch is similar with previeous patch [1].
> Also instead of sending patch with test, should we check which is better:
> a seperate patch or patchset?

Separate patches are better for me.

I'm not sure how you will make the test, but I'd usggest making the test as a
kunit test.

Please refer to mm/damon/tets/core-kunit.h file.


Thanks,
SJ

[...]
