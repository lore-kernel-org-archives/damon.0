Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC41991CB
	for <damon@lists.linux.dev>; Sun, 17 Aug 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755451012; cv=none; b=XedRJ+gvQRKbTDvFvdxLpia1j3Z3GXD9ZktAkVWRyuikaRRXjRwfZgX6OQqEQrMUhl3eQepokd0QAjL79/AV4Tkg6ghAgsmmh9GUDnVVqEACg1WjFH7Ea2JNSqJYLFk9SZoGItxD7Ace5YqUFWilxSkdoxCTzUHcrZede2dsHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755451012; c=relaxed/simple;
	bh=aj2zVl+t+vb0SmFNzFYJnQsEZZaPzlT3JEU0nf6FpT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGYdZJdv1feVcd1wxJGamOADZhJ2aUoDtgDqz0LfR+IRCJ5Z1rzPWaSY/YrO+3z6JONZN8X3vmZVCMuJ7umVMECBU07vHHoCHfnXJg3slgyCBSsNaZ3/aMmgYIdMXEeXkTt9+G5bA8kBJz1yMSk7T9kuGEXsEBcWNk83PuqEevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjgzNzKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjgzNzKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B11C4CEEB;
	Sun, 17 Aug 2025 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755451011;
	bh=aj2zVl+t+vb0SmFNzFYJnQsEZZaPzlT3JEU0nf6FpT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjgzNzKNtUylIF0UxOTfPcKWdtPOtR497jM/kfaFp2qeEX3AlfhI9Vlz8j8NrIHcW
	 m5KnCMnwR1BNxbmZ0Hwa7oWhzrjbnIZajOVlHd+4KvVacFXHXQjsQcUhFCB5+OjT0t
	 e7lU0jOdpNkyRwwwoM+11ETStSrpd+nLmTVtTZZXze5R4hGz3TzN98EBrBAkum3sNF
	 W/Hid6iPgBQ3nZHysdZ56cNtxREyrGozh0l+1Jd/sq7ESHuGashCixbRvWkZE7x7Av
	 B9w3HH/11oG7ygnsrLpFAlGE6DBpScuHCPZ5j0AirIVn+VGFKwIIT1RM7XsMDls+tl
	 7BwsWv57L7RcQ==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/damon/tests/core-kunit: add damos_commit_filter test
Date: Sun, 17 Aug 2025 10:16:48 -0700
Message-Id: <20250817171648.16272-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250817021348.570692-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Sun, 17 Aug 2025 11:13:48 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Add unit test to verify that damos_commmit_filter() change dest value well.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> This test will be succeeded after this patch [1] applied.
> 
> [1] https://lore.kernel.org/damon/20250816015116.194589-1-ekffu200098@gmail.com/

FWIW, the subject of the patch is "mm/damon/core: fix damos_commit_filter not
changing allow".  This patch should be applied _after_ the fix, since the new
test that this patch is adding will fail and make 'git bisect' complicated,
otherwise.


Thanks,
SJ

[...]
