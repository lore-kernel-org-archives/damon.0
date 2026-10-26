Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025789;
	b=Qld1RLIaFfUGKSS5sqXqKD2uyenmZiu0GyZkTGppUET2499d6gEwo7KQJ6Gv7DuXE61/
	 xO4GB0fHczl96Rn97Kt1AQ39oV3In0kwtwGuFxSIMGFA9t9hcykzWcpM4bNtZfv/RUSpP
	 4d95iWZRzzHdNBGstiS8Mc9mUos6iL2Hcz//MsQq6sIbbcvVt7Nq2KuS4L4AWrr4hSDhE
	 f6pEIgXqGIIXsoWUm8ZVQpBDnaFi2RkUIl3S9DrhVUw50uxOsgWxlHI4SFYztyqhQg2jT
	 Lr342piakhI/6vaSvGYIu8ZcUdJXtHl68pS4f/s2mMeydDqTU8VzR7N0vvQK32ieqSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025789;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RrYs5r78deoBJ9Dw8ytqmVZU3I9/wl2AOXZaDAj5RqE=;
	b=HMXCozFGvQEbDffo1bKAFlJ7fNW6xC6d3B+3PXq6kaHS+QnNbH1AvZmw76rpAJ+J+h1G
	 yc0enAfUVivKAqEqbhQst/juNKj2bmnVInThNL+IixP+9GgQ0q9RWfd+jGMuKb1A48fUe
	 +qn9By5V9owK/LlzP7vdxxf5BT+RDrST1QV2T9HvozI5niEe9E0liZLMF6zOmCOw3JGUT
	 C5w+dDdR+FXCC8FAlbbe6D752zuQ68HZsgbCuPC1ig5EgjacpZHSHBLl2biR9EytKjWYn
	 UwZ9VfeLUIfBWro0UYe/gAZRagkGIqaf52VhZRFjkPTJSavYTPu2/TJidccK1AXCEDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D20H8oLN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D4606A31B;
	Mon, 26 Oct 2026 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D20H8oLN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515111F031E1;
	Mon, 26 Oct 2026 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025788;
	bh=RrYs5r78deoBJ9Dw8ytqmVZU3I9/wl2AOXZaDAj5RqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D20H8oLN6BZpOOZUJ1qL0Xv4S4dpsgiCPtzFIyu5ruJIuvlTihAIxGVsuxWioWI/m
	 ULjJ47lKnw0OBl0+YT1jJLLiSw07yLju/PazLSV8+7gLtByV5+DmnK/KwxpT3gupX7
	 jI0Zjp505x3PCsm9T/ZoT8pDgk2D+1RIM/XizPPiBRLmJrqwYHv6D2DqEUc1ZvObSi
	 rJz9G1Ll7LG0xLaZOaui9AUvC8FvmLOYpLgT1PlksU+Uaj+ROciQOQXojTPMHGpaA1
	 nUuvK0DP/PQ5k4ln1IBTRhXC5a4XaaYhyAIThMDoqfkRZ4zLDq3o2YhMmrR4Sc4XIv
	 1hJsjE/64cDhw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Docs/admin-guide/mm/damon/lru_sort: fix remaining grammar
Date: Mon, 26 Oct 2026 07:42:55 -0700
Message-ID: <20261026144256.150394-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179301327249.2.16817896016779044743.damon-docs-grammar-4@gmail.com>
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

On Mon, 26 Oct 2026 22:14:36 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Manuel's recent grammar fix for this file, now in damon/next, covered a
> good part of it.  This should take care of the few mistakes that are
> left, like "should automatically activated" and "Make DAMON_LRU_SORT
> reads".  Rewrap where the lines got too long.
> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
