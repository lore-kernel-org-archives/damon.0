Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC81319CD1D;
	Mon, 21 Apr 2025 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255241; cv=none; b=cqZ/weQcqTkjzdER+bPJVXpf22Vih/kOxB3hJhkrN65vgmKshVjldwNb0iewDey4tZbdsBs0MAbIK96o1SwIlyb3bwjy/j40JlgWfKBUmutSKj4oQTZUsc/Dwp/kHb9nZIFYPZHnhEon7DL5TnfKAFUCco7qVH9J/qoJ70zI6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255241; c=relaxed/simple;
	bh=L2QeuNUgwI7Gd2iCx1Otutdq2RC3Pmna5zNKrB1copo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urqgi9km/JzuvMLRniqNZe6wREJpoB8vE76nVkBPJhbKZ8IUVtO7XTVRSbnB8PUgTWdYpE6WG3IG6MOQObUIKWm7t/Hj1tsT03KEFncHIi+dHDQbk1KgJWORtX3yG491CRnnq46/TIcPSSyZjiQCxWwLP4iVUaTczfqvHamwwxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1GPo0pA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1GPo0pA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A7AC4CEE4;
	Mon, 21 Apr 2025 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745255240;
	bh=L2QeuNUgwI7Gd2iCx1Otutdq2RC3Pmna5zNKrB1copo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1GPo0pAwE4RzaCZPxkGujfg7uYcbl+nno+KUrwCSPpNttvW6eirsM2/8r1faktiO
	 64P9L4H+sSRF83EMEFf9VxpVxsi/b/uzs/BwdH/lYoQ0apqzrrOr6xuwBJqV8WisOg
	 rVdC3hijsDjZy6sIfxHlYcJ+AIKpCJ4zaKOfKvSePbEeskYSeiSAHDmdqDZad8hFw6
	 9vWSTQL2YXMitUAky273DCqsLHOM0EWF5iXq3AFLMR0Xzvpsnzqte2N1/obK10aGjM
	 +P85tk3MltrmKtWKYKQCu76qdWfXm4nenImb1/Z7yInWJWroY+ShO88dgdJBDQqBvG
	 pdBNmG/TOxXZA==
From: SeongJae Park <sj@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and size_add()
Date: Mon, 21 Apr 2025 10:07:17 -0700
Message-Id: <20250421170717.35698-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250421062423.740605-1-suhui@nfschina.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Apr 2025 14:24:24 +0800 Su Hui <suhui@nfschina.com> wrote:

> It's safer to using kmalloc_array() and size_add() because it can
> prevent possible overflow problem.

Nice finding, thank you!

> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
