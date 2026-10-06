Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54135CB95;
	Tue,  6 Oct 2026 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269918; cv=none; b=HG/516Hx9+VwRgXA7deie/ZwRt+7WVhLhfni75P/zo4/pPD7wqsy1W1Ck7xiGH2zn2KGwrA2u5weFufegqYNVt91nfMgUIWpQiJf/1MTOP0AHr6Ro59MHhoBv5Ro5Iw87oD8fpnT9+8V3KuU0X1+OGiTit1QzXYQdqOr9vfdCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269918; c=relaxed/simple;
	bh=Hl1VmZH4xnc8D3EvwrtTIteELf9CwrYwcqjF8fVk6zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZCirF9o7XU74S7qLbfo5HTrWIk3zvMNLvhSir8w7gZb+Rxcih3i5Y1cvD/6xvGgNiL08EFlbFd1zfzZ/pG6Y+SSEl6NxZIS94ymaEJWm9nHb3boHa7WI3FY7Bggimm+fksNSeWHha98oE3DQqYZY4kG3ZOGki09ANLD5+HCfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmxYwBNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmxYwBNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8201F000FF;
	Tue,  6 Oct 2026 06:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791269917;
	bh=5jMDWwuGt+jQZDR9Iyz1q8YOljzx/yRv9CuAM3sIWNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LmxYwBNv2vdo+Lt22Fbi+OrKJWuJvO6cgiMRz8f/tWa+V7XLK/jIVQav4JUG7YUKg
	 1/kaSZ54kuOZ7iYK8aputcV43g8ExD9olA2aJq5eNsBAUyEBwmrAxErGxul5aFI7MZ
	 0cqNFRDwYH6FYbtmO3BKjUakcGje0X7px7KxzbMQ4HzpQm7kcp/U4+nXX9h7oxatFy
	 bUY6NkMKv6vz7mGipiVcui0XV1Kj2cmsfimrn2GZTfoOoziPQ31Jh9faTMyHARnM0u
	 rVdOpw8qEYgV4BguzsU9zrImi9paa120ffgs4jXIPd09F2LqVreyQlDAvaI7Qd06YB
	 Zr6wFEcOvcrMA==
From: SJ Park <sj@kernel.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	ahuang12@lenovo.com
Subject: Re: [PATCH 3/3] Docs/admin-guide/mm/damon/usage: Fix incorrect option syntax in perf example
Date: Mon,  5 Oct 2026 23:58:30 -0700
Message-ID: <20261006065831.42201-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006061549.627-4-adrianhuang0701@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  6 Oct 2026 14:15:49 +0800 "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com> wrote:

> The kill command in the DAMON documentation uses an incorrect
> option syntax in the perf example.
> 
> Use kill -9 instead of kill 9 to correctly send SIGKILL to
> the perf process.

Nice catch, thank you Adrian.

> 
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
