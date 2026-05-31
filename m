Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06862809;
	Sun, 31 May 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780245376; cv=none; b=dNRXmVRxzcoPbPfMPfxDaFLinwAgG1AZ6rR9MuZujcFa7bnO7fLrJ5TdiDddDht7+k7b2b/PEmHrceZAW18GimXgHMy5stB8bqEKbgEyI0wnhYAesPM3OhJ2J6WA94+Do39dVwzuhk6/X0Js3FJzgbWprWr+ACTQRD1M6kMtQP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780245376; c=relaxed/simple;
	bh=Oz325/TqPWSc9/h14p1oQ2MwsTDpjaFjfzfea6mB4g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fex27Xem1F/xo7FMPQqVI8pyvH7lrgxfUqyZ9pLQQwhyu2JYJeKi7XQJRYGe/ND5Y6rGB7bqWpCrxzinFdAU/7uVZOOH0K5AiIe+J0HcNjX6GeoGNB4lpbq38IySn3tXd0amBvckuqbOiBqgjW5wT/pgq9lLGF/2er5cNxftjiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEbwjG3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEbwjG3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D40F1F00893;
	Sun, 31 May 2026 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780245375;
	bh=SDD6tD/6kl7HLKjD6lcvgrwFf3qY0h09b+OnpA83jp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jEbwjG3YtCqiGX66HJp9b9X1dSeLuVMEnPhmiHWOPmET15hr3rreAYsinTBYl+VWO
	 udjp+Rraex35LS3OSuE1jQNLQkp5DFni2CmwrMp1iwOBaQIO2XGR5Sfp8C6x5fbYp8
	 3/0ZBvI9XhdsnYkTtXS6QYEM8wmbau+tyuVf6kgi4nExomjUqXUbKkbbAn1t0YMiws
	 TtPTUi1+emVG5BtjWXC4xxGXVQEHlnrCUEE3YqnoxwgvYPrSjj/Xex9mLvRWyTlOUo
	 kfSOt/EA/PJWA9CwwrflSahxgiK4O93B55nwHZJXkg4cYCwvBvR7DWkNOXSw/YqpaB
	 ipOBmL+Vmthdw==
From: SeongJae Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Cheng Nie <niecheng1@uniontech.com>
Subject: Re: [PATCH 2/5] selftests/damon: fix memcg filter path handling
Date: Sun, 31 May 2026 09:36:06 -0700
Message-ID: <20260531163607.99063-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531091724.84381-2-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conventionally, this mail should be sent as a direct reply to the coverletter.
But somehow this was sent as a reply to the first patch of the series.  Please
send all patches of a series as a direct reply to the coverletter from the next
time.

On Sun, 31 May 2026 17:17:21 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:

> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> A trailing comma in the memcg_path assignment makes
> memcg_path a single-element tuple instead of a string.
> 
> As a result, an invalid value is written to sysfs and memcg
> filter configuration fails.
> 
> Remove the comma.

Good findinng!  But, Cheng sent [1] a same patch earlier.  I believe Cheng is
working on revisioning it.  I think we should give Cheng more time for that.

[1] https://lore.kernel.org/20260529145248.84593-1-sj@kernel.org


Thanks,
SJ

[...]
