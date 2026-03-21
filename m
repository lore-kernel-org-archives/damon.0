Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E113277C81
	for <damon@lists.linux.dev>; Sat, 21 Mar 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774112407; cv=none; b=r4HuiwB284C2ynsLQXvhWvxz10yHlTT8F26gFLaywwSTGDjn6cEAEdBRsAFXTkO6fsGuZ7UQYLQgeK44iP2ryEOUR1mKsrxrspGnUfxOzykvnbRl3lHlyyvCKqylrwCgFvePWQL3xQyhT8BHaKhunhCtGR2vAIbOYNU96WeVxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774112407; c=relaxed/simple;
	bh=eCmvNHuziGX7LpG5TC/FzLyTEMjUA4/4sz21VSdCK2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZq8rJ0pgo2i5tkEIxaUCg+YjmWyEd35ncornSDx+cv7RrT/HiQcC1pI2iK2nfIJnmsz0vB6nZnM3QMmqhfxJeVqtiwg1CDW16GxQA3jNWSyZRblmtPMZUrobFNu1N0R8WVwfDK97KJk3IiaVEdW1Ff2wHIc6dT8iQmLAryjquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsGAaC8L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsGAaC8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB866C19421;
	Sat, 21 Mar 2026 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774112406;
	bh=eCmvNHuziGX7LpG5TC/FzLyTEMjUA4/4sz21VSdCK2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsGAaC8LkGN5P2wQQ/ruWYpiDvyVrUt86oFOVU0UYoCugrxgans+jwT6qFQRR9nrk
	 +l6Ein0ah7v1Bu5WWvv6uVAsayI7iRSsbq9IXQidGiowFMyY2sPcELB+Crpa5SdNlj
	 etAmvAtcJKTwigu3Kb4920xZf/dkdCjF59+IcpH6tkzNc2SQnP4r9apNf48KXT3nTP
	 2ZqQEY6fxaQun2EatGV+pJmRjhBnJHvKflu5/Qe8D/dxxIkC6RgYF7XEzVXrFO9xEE
	 2DzM6MjisdkgdaUMnWyqh/KGLS0mfeaVfoxYNhAWZhCeKBo05Z1w7bmv2t86Tq1h3p
	 r9GmAdzkJgX8w==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/lru_sort: add synchronous validation for commit_inputs
Date: Sat, 21 Mar 2026 10:00:04 -0700
Message-ID: <20260321170004.84505-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321002642.22712-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,

I saw the v2 [1] of this patch.  So I will skip reviewing this one.  Let me
know if I'm missing something.

[1] https://lore.kernel.org/20260321140926.22163-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
