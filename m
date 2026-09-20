Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005593E40F2;
	Sun, 20 Sep 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909990; cv=none; b=IU89yaT7xyYVoByjntshNQtHn+y9BibiZfgRexKp3BA01LeG24ofhkk+AdvzGC1okUboe1gZdfO1fM1vcXzdOMxYYV2vNJVf040iSo3B53Rs/h2AEN+UmbibE0IwTFlU5iwl45gMlZ3oHRxvE7T3IcqWoad5AC9BZH44dnZrDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909990; c=relaxed/simple;
	bh=o2pdwhMeRimlcFmeKbTvylW3D2mzBAAa+DZot940NZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huKFaaG587aCMGeT5fMmpa2cJaVZDyQQLstWkf90yefYEGGknVED8tHUkn0/tVpThpBxsTAb3u70GbG8qBoGCPilw6F6svj2Uxgfgnm5Mtx+CZBYxunX82rwop2qLfNp5HCeZU64leoUKdYezK2dLDzNy68bePsSdB8XCGxAolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrzDEdbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrzDEdbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8301F000FF;
	Sun, 20 Sep 2026 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789909984;
	bh=r5ELjAIpHRlkJUa+hT8eIBelfH7GALLeX3V3acfUJV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZrzDEdbiJrUZQu4+qtloEJwle/dju3mnN+1+3mgPOxiGZGJlvJtg99A5W5ZFI8iTc
	 4+opUMM/1qODOwkO1h6WOh016hXxSC4u1q7B7CJeq5ImGW7Utc3riH/cno7TgS1Tup
	 3ds8NZqrrU6QT5RQM5evslOcki8VeDW+zBf791Xh1DjNhFjt9wsrfAw9ou8QY6N2ud
	 xrLv9Wuj8DSWslkGGuTdAOLAyMUPJji4Zvz4HMthGNQZK81iPV/3lAEgwmG/BpA5YN
	 9+6S4523eJKMYQ+7XUw9WQjzg7vfbzZuPCf0FEW28aoHAlliZGbbuZ5DGVBGMbhukL
	 BfMotXd26bfsg==
From: SJ Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] mm/damon/api: remove unused NR_DAMOS_* enumerators
Date: Sun, 20 Sep 2026 06:12:59 -0700
Message-ID: <20260920131300.48929-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e0c63f91-4d33-469e-a584-f97fdf8c3cc5@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 20:34:48 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> On 9/20/26 6:00 PM, SJ Park wrote:
> > On Sun, 20 Sep 2026 09:20:28 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:
> > 
> > > From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> > >
> > > NR_DAMOS_ACTIONS, NR_DAMOS_QUOTA_GOAL_METRICS, and NR_DAMOS_WMARK_METRICS
> > 
> > More than 72 columns.
> 
> I learnt from submitting-patches.rst that
> 
>   - The body of the explanation, line wrapped at 75 columns, which will
>     be copied to the permanent changelog to describe this patch.
> 
> But I'm also fine with the 72 columns rule for damon patches (or for mm
> patches?).

Ah, thank you for pointing that.  Let's use 75 columns.


Thanks,
SJ

[...]
