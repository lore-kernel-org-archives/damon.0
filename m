Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794764030;
	b=DVOfcEfViuvMWzS/RLo+nVYB/rKTUY3/rDsD1p9rU93ikp5l8sK72JK6W/yK6e1eVAJg
	 V/LxDcfisnw8bg2MC3NVpqLhsaXTw7PvnCNzLl01AeCS9dUKpXgf5g8TPXYPELh6rCvNk
	 F3TyznUCunebrK61KbzsOdHtD4+YDJX3P9CqbLkGKjQ3zU4MYEcwjHRO5jx9JbUEBIeaa
	 kdRrxlufc3OPNfMA4tV++/7N6KKRaG1wL5hSLjxiZUoSvg6HNdwdrCSmuapjn0Ct3mFb0
	 2Kk39gX1PY5sMUhiPs5Br9eu+Rge18UQx7JC97JfY5UPInx4lYZbQJc9ThzYwotgvSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794764030;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oGZSQK36dQO1d5WmaeXJ05lPFIpl1QQYBwK+/5+t2vQ=;
	b=sdUj8DeZWhqE5aUxmpbqhEp6KSBo/EkH5h92f91JtZLkqVTJhnzqeNzfj61o2BwUdWmi
	 yetbTw8DUgjXm+57ZM/nb5Gi4OU7qi/4x/F901n6TXrqjcqpdu077Ua7iv/+Rx2EvY2EQ
	 95RE8aQB/XQUjtBPNPdj63rEtvimCO9X1hI7rEq4sUnBwdYCGWb/byQjTmGQuDHCGOmbL
	 dwQ7+0mmA64YKJWHnidPfWxwEwOTx1XeEeRcuiMbgzr+ZXH76s9HnGtxonixQYrhwFVzH
	 SvHYs+GSXvGF1AcmU4KakAgvhMdTklzRl8YQwG04Iq1rmHhySv1bhHeMX+UlC/H40Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1EuXLLm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FFE606A31A;
	Sun, 15 Nov 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1EuXLLm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAB91F000C4;
	Sun, 15 Nov 2026 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794764030;
	bh=oGZSQK36dQO1d5WmaeXJ05lPFIpl1QQYBwK+/5+t2vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A1EuXLLmgt9jXZn2tSu3WzLjEbZru4Lcta2QCZYFNqTUj0Zah/bIhU5rNG6q5iby2
	 S5JWxRB6HxLhaBMdF/px4nMxQXtcwZmvommDDJGFYcbroMNZgakb7tWLKL5t6Bcnuq
	 LnezLGbUFkNd2L2hqZ54EjeGEqQ/g057yYHc3kdPemIyCqAmfU/gBnyBmOdYwpnkP7
	 q8J4CJtNZdQMoYaArjtUHNmyOSWwRUIgxFVrHfK6WPGNlk00If5pDJS3nqpnv4yv2P
	 DYKvJ1jQ9DHtk3hArDac4OYuyiQmoddZSjfBoAS0WPNT+aiV8DfAuGpBPBCNVTFrdQ
	 Hy6XkPeBAQLpQ==
From: SJ Park <sj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Aveline Noir <jm5905938@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] mm/damon/stat: avoid 32-bit overflow in idle percentiles
Date: Sun, 15 Nov 2026 09:33:42 -0800
Message-ID: <20261115173343.82437-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114181034.2665113-1-devnexen@gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello David,

On Sat, 14 Nov 2026 18:10:34 +0000 David Carlier <devnexen@gmail.com> wrote:

> Hi SJ, Aveline,
> 
> The value stored a few lines below has the same problem on 32-bit:
> 
> 	damon_stat_idletime(region) *
> 	(long)c->attrs.aggr_interval / USEC_PER_MSEC;
> 
> The product is the region's idle time in microseconds, held in a 32-bit
> long, so it wraps once a region has been idle for more than about 36
> minutes, whatever the intervals are. The cold-end percentiles then come
> out negative or wrong. Doing the multiply in s64 with div_s64() would
> keep the sign and avoid it.
> 
> Hope it helps !

Yes, this is helpful.  Thank you for sharing.  Would you like to send a patch
for this issue?


Thanks,
SJ

[...]
