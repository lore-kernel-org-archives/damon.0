Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D74DD3B0;
	Tue, 22 Sep 2026 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059342; cv=none; b=h7UowtMoMHCLRKSenaazRNDHFaYX2+Gy96aJZvRH73IdbCeSmqhDPazAdLKHmOEnuTQBq7QpJmrvJRnCwncHMYc1WBmpAUck/9z/qE14yIcRBz+mRIkmoTu4LgrWVKxGP1de/iuERq7H90S+CHuUlv4whAdOi7adv8G0Kl6dQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059342; c=relaxed/simple;
	bh=wF+zuapSGH7x+ykVD4gtT1JS39Abc3EEjtJtJqD3+ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgFvKDejKy0DUPzJ5Xqwmd0vl3u+2UaYGYGABclEgFRPEn/xALeqYggkCD2mtZyxMAsJRSujXsda+t72fdchWd1vh92GQ2sBh+M4+Upnd3p9ZPMgJxCgp9pYQ0mBrmue6Q6CWOoQ4qYp3ZnEAIXTiuAuUOpaNrO8yHwpABeQcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqYXHhid; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqYXHhid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA8B1F000FF;
	Tue, 22 Sep 2026 06:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059340;
	bh=72H2Bkb5mUqaSJjeGrEpofY5BjystviOexJPm4F/szs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HqYXHhidXFx7y5MntdUqFH+xU4Aw4aZkMmgOQpBuiNXHaSLERGIsW2weQZ7UyZUfS
	 wrgtp2bqYW/8XpUQbrbbk9O91DCc4Id5BvhPLTm7CHlYdMgA8RPHusNn13bsLoO+e1
	 bJdLiSCWrJR4zdWLQ04iU0VwjtxsXNhtP46JxdbJXhZfxJZdBnclU/CE9naOQAiS1n
	 lOFTd2/9FWxa3cY84wowbnJrfsDs4Kvhr3aN1SLkupjHDyrxNKZJWKqUaBqcadfEY8
	 IUGrog+BGh6Mxh/VjtXchvGOhyroYR9MxQM0f5FFTrowfc38MItVe4S5PJWQ7tMUAC
	 +413mYZWdHErg==
From: SJ Park <sj@kernel.org>
To: Zhijian Han <hanzhijian1991@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj38.park@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix typos in comments
Date: Mon, 21 Sep 2026 23:42:15 -0700
Message-ID: <20260922064216.43053-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922033618.2862687-1-hanzhijian1991@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zhijian,

On Tue, 22 Sep 2026 11:36:18 +0800 Zhijian Han <hanzhijian1991@gmail.com> wrote:

> Fix spelling errors found by codespell in mm/damon/core.c:
> 
> - "widnow" -> "window"
> - "makrs" -> "marks"
> 
> No functional changes.

Thank you for sharing this patch.  However, same fix is already posted by
Adrian already [1] and accepted.  So unfortunately we cannot accept this patch.
Please set the baseline of your work with recommended ones [2] from the next
time.

I also found that you posted another bigger typos fix patch [3] that contains
this patch's change.  That's confusing.  Please post only the bigger one or a
series of smaller ones from the next time.

[1] https://lore.kernel.org/20260921151547.78472-4-sj@kernel.org
[2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
[2] https://lore.kernel.org/20260922031843.2857104-1-hanzhijian1991@gmail.com


Thanks,
SJ

[...]
