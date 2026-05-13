Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FC2D5436;
	Wed, 13 May 2026 04:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647871; cv=none; b=UUQ5R+lQbniVLDKkPVYJ45wXFPWy68du5d80WNK08UALC1kWhFYggPVwaEgr631hKixHVfmZ6MrrPMMUJ7x5CV6H7r56ukG/lUGWBFCld9KIDY43DZ5NHJK6UuOlGgagsLd0DLiuErGhbp2ZBhKMkG1lGyVV8oChIj7cdy+ADIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647871; c=relaxed/simple;
	bh=9Tbss+22L66mb/2fdV6MWgqXfYkdw8ChYubl+Qc9BbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAIhHV4K1zFTMQG745NxACrjdVziUZZrW4lRKbHHRCSMCL08qjVObxuAoMgLKwBUhhltppiELxeNmTMVqo+G3XBXhPd8ztavmoM5VAmNpVhWcsxWVpDQBPW7ZuPRYnFBb9z+/0tOt33kPkwQeMjG1/NAgsopn3RnuulCBt1wakk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpxwIUTj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpxwIUTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0557FC2BCB7;
	Wed, 13 May 2026 04:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778647870;
	bh=9Tbss+22L66mb/2fdV6MWgqXfYkdw8ChYubl+Qc9BbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YpxwIUTjpbhtckPk4FTGHuz8EAzpVS0ZSQ3+Z/uDp0gPNOgmn2pM9q9zlrXILKBEx
	 jN/9v64u/QFOZTiqONFGJQfCrvT3gsokTbi7CP35RS8hCh92bH7q7scQzMrNhBqfwi
	 meT3whhkIUIxHB+9c+qSqRZK00vzye2xT5OQ/DReyzzETeWUdjRH9sX0Zo/Mmg4GHQ
	 LM3ndNw6Jzlsn4A+S8N4lgzaQT6B0CNInELAIPP4gYp/ZRWxX1PxhvMnz2WbiiyXez
	 KpfCIbDkmHyGwRbTABKdrrcr67cPOjaspr0QxWwkQ25TFnM0tHDR2qiosoAdWgK1BP
	 QCeqe0+0ZBqlA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Tue, 12 May 2026 21:51:06 -0700
Message-ID: <20260513045107.194019-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513044700.193786-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 May 2026 21:46:58 -0700 SeongJae Park <sj@kernel.org> wrote:

This is a wrong patch that mistakenly sent.  Please ignore.


Thanks,
SJ

[...]
