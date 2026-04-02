Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A322FF22
	for <damon@lists.linux.dev>; Thu,  2 Apr 2026 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090429; cv=none; b=jmabbs19EZVHb5Qpy7cYUlBXOwMiplLLco5zMjZPKtRn2unxeuF3opVKvzfNKKOIBzsDu9bx5fQlUA9zWFCOpLnEvVA12wkSr8XXLL76Mll4GfNQ7de4nkr+oCaXmzG01jpIojFLuMtiiSwVjc4NafGBAfvFtm73tqIkkGTiZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090429; c=relaxed/simple;
	bh=JF8+debzMCtcQ9RFsdSB1opffxjgjYKLJ5l4rkKwMYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uk+7cMuTV53X9h0PPGzvrScwP2Ygsk3ArTe5t6yxQHqVHTpZUhXB5BzVI2664V25i9DNpCSVeRX+i3nKp/2AtEArXGLekJ87Noa+SAzNjbrw3hHcwCTEn4FvFSRr/Cy20TRNKAgQWySXpJTHoChd6aMag5bSpMwZcYEvZLVlqto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raO0q6T+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raO0q6T+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1549C4CEF7;
	Thu,  2 Apr 2026 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775090429;
	bh=JF8+debzMCtcQ9RFsdSB1opffxjgjYKLJ5l4rkKwMYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raO0q6T+cev2ccGk4Aul8Z47OvE3wCTq2XfWf2aSKSUsJqrvGkZSXMyLXkA/VfCtB
	 zshh84DRoKZF3VxKwMNYT1gvHASfTLdBTX44fkGLBjX3IS40tY9VOp+HryWJPOGMR0
	 +qB1DLNMr4qH6HaPJSOj3PdQSIfeG+icC2tqPsaZC4v7Hsqs6BdB1AAlLxWg/1hTPW
	 tAisz9gWShnDDqDoxqxUNDjI5OqR5hAu4pCIuzp5n3siq1g9G42O3JE/4EGlTkItHh
	 bLdwetdsmUL+9iCQmYaueHjqJRhD/EMUVmr3cLCTIrBtI8eqaL9vkPcboYsYz6vFnL
	 xOvIi73SwB+6A==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Wed,  1 Apr 2026 17:40:27 -0700
Message-ID: <20260402004027.64439-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401082354.12467-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  1 Apr 2026 16:23:54 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> First of all, I apologize for not completely answering your question,
> and I will be more careful next time.

No worries, we all make mistakes, or simply have different tastes.  Thank you
for adding clear answers to my questions and generously accepting my
suggestions.


Thanks,
SJ

[...]
