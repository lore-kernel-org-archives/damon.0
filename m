Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840525;
	b=SmzTEA+1Wqw1xHcVff0xPgk/ojmbl0eORT7Te/i78ox7WMe/Xsd4qZV/QAy1jIElsF1g
	 m1G8UdGl0LNNYKV1U6nDnfLq0Z+v79x1g7Ph/8EDaydMqAZd3V5bt/W8tpc39NbZV2Sr0
	 5LOkoGg092EvU6THN4xDDbuzYmMnqoLBhQe1uYpIMClmScBGrRwk+jV+soEmdHptH+1g/
	 GoWLdK8DkYwXwaLKxidACTnMlB+wL+GONrsgzRvRetzEm8jAOoHoLn2BFa5O8uxhXzXt2
	 yxTtxTCerK/5Ryc5NKFWyI7AWMRDbF4tfs8ty+6FUPROB7gkQaatEqdm/v3jfPqbMzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840525;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AdTomW99VvfVgE5W24KzmRdqP4Moe13ZETF0Fbj5rS4=;
	b=n2p/TNDUrGL86MffJesqFyoFAtnt4s2P+eBZk6aiM6hJGv7Sii2Yvyvmcor6/jkQiTiT
	 uub/fzSkPehPe/g6YYnFwBTBd8U+Vc798PX2+48DeOHkUG+pUKoRIsHvSDXnt9+6szvys
	 L3pdOI8siZJaYwHCzqajluNFNp5bX6wqJDnfwIrWXiu5TzYChGSy0Y24uZlqW43/xQ9pg
	 Q9iiwltblDMh1YDZi8i2ZsU10KWzGGs7fZg5ohOOw4FtNYalNELtWJwM+UpAvxD0Zk7m1
	 w09jUowDbmOx98P/2qbqt9w0CaIMIzdnW/Gqx2ONocNOKOuh522zEfCzxG+q3qR394g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVLSEKAh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB8606A330;
	Thu,  5 Nov 2026 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVLSEKAh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639F21F00919;
	Thu,  5 Nov 2026 01:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840524;
	bh=AdTomW99VvfVgE5W24KzmRdqP4Moe13ZETF0Fbj5rS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fVLSEKAhvrku33NQwqvpc1uvzIv9Ozs8WWw826VC/BFa80lLIcCQ+clssqoDbgDHF
	 YOVjVYcUcsWQsx+1v4R9hQVs268jZbcB+dOu6yvVMfGqaFUloURsGYbgXtFNa5RkEr
	 z32FsIuuUgthsX/hKkTTlpXakgqZPESIyl1XYKlaspyzQQ7Yw1LO/Zoz/Eq4+ne6wY
	 wZZaA46fjXPR/GuEGq+8xNhaInoyIYsZz0pzx2r3C1SBe4X7ckzHYntZnNxkouoYrB
	 JQJlNnAnqRFjtBKhlZT5zLLzcC7S3YxTYDlhmxz2U9wXaybF3lopHXk+OprHFmIC1R
	 An49kSjhTDREQ==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Daniel Pereira <danielmaraboo@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Docs/admin-guide/mm/damon/lru_sort: fix grammar and style
Date: Wed,  4 Nov 2026 17:01:57 -0800
Message-ID: <20261105010157.87652-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104202959.128646-2-manuelebnerli@mailbox.org>
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

On Wed,  4 Nov 2026 21:29:58 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Fix tenses. Split long sentences thereby improve readability.  Replace
> 'set as' with 'set to'. Replace [] with () to make the file uniform.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> CC: Daniel Pereira <danielmaraboo@gmail.com>
> ---
> Daniel thanks for the Feedback.

FWIW, it was a feedback to the reposting [1] for mm.git merge quest.  Sharing
the link for a case someone wonders where the feedback is.

> SJ, could you please reapply this patch, if you think it's worth it.

From the next time, please discuss on the feedback by replying to it and ensure
the discussion is completed, before posting a new version of the patch.

This patch is already in mm.git as commit e576f9950ada
("Docs/admin-guide/mm/damon/lru_sort: fix grammar and stlye").  Andrew, could
you please replace it with this version?

[1] https://lore.kernel.org/CAMAsx6epLXuUjaV3J0=SWAuLvajr4h58DTM9gL+LMmaCyjcxUg@mail.gmail.com


Thanks,
SJ

[...]
