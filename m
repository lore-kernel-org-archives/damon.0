Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950D304BB7
	for <damon@lists.linux.dev>; Fri, 15 Aug 2025 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277793; cv=none; b=cVGd4j9qYUwyy908vhCedXJM/SrhQorcgI/9r9yXNk+b7BWREsToldbkj6p5Sru+m7Nf3ukOkx63XQwaNyCwCrwyFkFWDCrpalR4Og2KMkE0gPUm5JJUiL0X+08MUtqe15b+el8YAAyB/S74Kc10B0Ii4X+/KJLnoXjciyxWh/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277793; c=relaxed/simple;
	bh=Qu8pNllR704yd2oGMGGcH3W9TSkSrkz9APPlj1PqlRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJEiBcyR9XcGNQLgT3iYHQQxTLwWLlGriDTcw6bp4knyxm/Waj72f3mgLpVfZdtj18z6ikpeyeQnbdwI5i5xxPt+5QeXRWxOuKPXFzH7GOkOi6v0F5PJQAhj/5w8o72sYl4Qvz5qAI1c4hgu6qTTWik9XGUD1jwNP2+bDNk8PQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGxoWr/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGxoWr/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E762C4CEEB;
	Fri, 15 Aug 2025 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277792;
	bh=Qu8pNllR704yd2oGMGGcH3W9TSkSrkz9APPlj1PqlRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGxoWr/1P6Q3mr3Yv+WAyUlf5Ad/x3nmefYVfial3km//O8Xr7zbICawzTyr4VN5U
	 ZEKdXxv3g98hqKsKEzBGmfLdYJx+bpDvIRY3lx6bjX0JMdGHC4B/ug2ITzLncHZM5M
	 8r4u3AVsfLr5+sPt6bNuM8iwImZzM/7xduWMeaqyPxQQ0VATnFd52CK1wS15gCXIwp
	 IsOJbDgT6bEeAxuFUZ0ZJVTPG/VE8CLOU9Mb3uv5nCTRM81emMA2wT0sBVg2hmfj50
	 mMN5ydFRVef+iaQWpcDwsHH/MS3WsvvL+ab97kC3ZQOqmhaTAkpLexwg4L5fhp2FqZ
	 7xLGAy7OfrF6Q==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] selftests/damon: change wrong json.dump usage to json.dumps
Date: Fri, 15 Aug 2025 10:09:48 -0700
Message-Id: <20250815170948.16297-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250815094029.133063-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 18:40:29 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> To print drgn status to stdout json.dumps should be used without
> json.dump. Change incorrect function call by typo.
> 
> Fixes: 441f487d6ebf ("selftests/damon: test no-op commit broke DAMON status")

Seems the fixee commit is on mm-unstable now.  Since this commit ids on the
tree is unreliable, I usually add a comment, like below.

    Fixes: 441f487d6ebf ("selftests/damon: test no-op commit broke DAMON status") # mm-unstable

Also, add the destination branch on patch subject prefix, like,

    [PATCH mm-unstable] selftests/damon: change wrong json.dump usage to json.dumps

These are only my personal and undocumented conventions.  I'm not sure if this
helps others, but it would help me.  Please consider using these conventions
for DAMON patches in future.  I'll document this on DAMON maintainer-profile
document.

> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> First I'm sorry that make you guys work twice. This is fix of my last
> patch [1]. I'll be more careful next time.
> 
> [1] https://lore.kernel.org/damon/20250810124354.16456-1-ekffu200098@gmail.com/

Thank you for clarifying the context.


Thanks,
SJ

[...]
