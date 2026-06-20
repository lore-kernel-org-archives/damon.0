Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F840D58C;
	Sat, 20 Jun 2026 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781915181; cv=none; b=ihTMr9ABxYQM6NK8Mz1QwTw09SEHGQLv4isMclAVPVKvass2RuTAvEj15IwPywTQ6+CFE4RAp2xuJn56oijF4tMC+7xTh9smEO+49vdSHi7G8Snh5uVljF19PpIAV0WGqqQLotkM8Lp07FlOZJhvVNKE/l/uAHZ3YTFlXg+k3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781915181; c=relaxed/simple;
	bh=qshRmq/ifJbCSEl/x3HGG83qmJTlJl4dwjy59qBf4+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4wm9IS+Bn5qIb+QNu/uH6waJTI/Irlz5XLa+qoc4/nNU0kXfz3ITWGg8eQ8xBMeNl2mSXUAGnCBZrXz27ROwpFFs7ihjunHnl34PpV6Pu/71SN3Jqav8Gq5W6ZNphI41cf0eFrLTfyEouQ6tPklwLjexHzbOaJLwn5of9o1IVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4aEPDJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4aEPDJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EE01F000E9;
	Sat, 20 Jun 2026 00:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781915180;
	bh=8FJsFf5tDWMJpwZf95TZEFo1MEhK5Db8dJyqwo4G458=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4aEPDJAQLWXcRoyplVdChmZsgbMzjVPbU3ST4SlJ8ow+h0Bfq3NeMBWY/24uZjBu
	 W5Nob1AcPx4rlxviSg4a8l+Q9W/Y0FwPAdP9r4S00ZgcDeyO6zU7eCOmARhG8qebWj
	 qL6zfPoxrpzFbvMX9c3JAV6uwVnv/DfjWJ+6NiTrAtlyq1GkHmu4vQzqAh3C2Oq7Ke
	 YZXW1DiBC8xHlgACPHGSYpozPyNJmL5Md7kqSQf4hge4NMWOVhwEhv2THrPklDdMX7
	 ++UQJuQBRvOcQ2y7SQa2Wl5zhlqCchjcHnAkdzBTcGYvSHV7p9LemdG5gAsEU+r5e8
	 7I38EuvL5Z+Fw==
From: SeongJae Park <sj@kernel.org>
To: yahia <yahia.a.abdrabou@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/damon/reclaim: fix initalization and parameter issues
Date: Fri, 19 Jun 2026 17:26:13 -0700
Message-ID: <20260620002614.83004-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619234606.221163-1-yahia.a.abdrabou@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jun 2026 02:46:04 +0300 yahia <yahia.a.abdrabou@gmail.com> wrote:

> From: yahia ahmed <yahia.a.abdrabou@gmail.com>
> 
> This patch series addresses a potential memory
> leak in the damon_reclain_init() function and a
> premature destruction of ctx if there was no error
> in the damon_reclaim_parameters() function
> 
> yahia (2):
>   mm/damon/reclaim: fix destruction of ctx
>   mm/damon/reclaim: fix potential memory leak

Looks both patches are unnecessary to me.  Could you please explain the issues
in detail, and if I'm wrong?


Thanks,
SJ

[...]
