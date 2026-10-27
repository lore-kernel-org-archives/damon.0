Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111023;
	b=287cJDE61Uc2MkyvHxpqxfEsRtWeAl2h8cz7BhZG9iYsW8zEoVKqk6N5BGOwBmjRcCFf
	 PL/tVMpkVbwls1JWBur1MwUnT9snYLOdTbYHbv/MaXEaFSGrZqxNehRtJavLjaBX8VgCM
	 ZsQEV9BWpj2Qmjc69z6wuh6M16C8HkPx7Tf1r3AhdsliMxnHlmDYiwWH4Mo60FGVr3x+H
	 L32p/ArVS65lwjYH07ckWVtBEccX5Y7XINaKTXGOQwBGkqf2neBbjNEAHF8Dsem3/4dEc
	 JFfTpP3WMWG8cUY5PVX0ViN15p+fjPd6s85IfnDVSB3u9A23ecwGp6xcgPzdQBWabbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111023;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fRAq9FfSqjqKfqwoQMFQDgBK7w2lxGvz5g71khIm8Ew=;
	b=Lxy5EzhLv6GUsr6vn5kmIVRSRM67h3r0QVQPUk4QlSdVPVNWLOtD9jAPGRllkHbqy3xa
	 wd+hJ2fieBM3AUjcwDa0AUwoUeLc0exP092j88bQFyYY48SCD9mVTfT7tgHTCi9svHm60
	 x1Zg/+R13KvdqJ7fvi9NAJ8Ja7v3/QlXB8n62FYj3h1PoVU7/9rKbHGEMUMjmBSM9SW6f
	 9uegAfabD3oWqaXpS9xa1BhLWj99T6YUGvKzYLvL+lnjYb3hn2BzjmqJMYZoDJpRWCCty
	 8wOrwk8Of29qYokH+kiBaaeUCmqTsGkxmN/LCeV6PFYVvikbmzPHGO0xQYjxRtkuymQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuRcQirF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152EC606A336
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuRcQirF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85151F01825;
	Tue, 27 Oct 2026 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111022;
	bh=fRAq9FfSqjqKfqwoQMFQDgBK7w2lxGvz5g71khIm8Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YuRcQirFUbcIvtq3qtGR8tQ/R072ZaSixMh4qFnJsDaBjAWUV9VzJ0g1HGPlx7iji
	 GzW0LuocbO3K331zn0i/3amTYhKSafAIvzAfGJuDy5ptFWs8L8PHQDBShyl8fe0/Ue
	 +FTXNU1dBNijDA0nJFsRxN66u/9bfOCZYkFNPbru1x66TtFTUTkTRezbjUuNZ9t3JP
	 xPgBMn9N9XywTS+yoILwyI2SXNdnIGtXGOxoKuHLpV4lhvG6YCbJke9fAudKNKraM+
	 d7jSpzwb4tzHgXe/Q9z1DYO8PKr202ggjPbv8n9IiLmAt7t8oqCQjgH71kgPs5IHYU
	 TJ8HOww8V3NIw==
From: SJ Park <sj@kernel.org>
To: DaeMyung Kang <charsyam@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Subject: Re: [RFC PATCH 0/3] mm/damon: fix overflows in score and ratio calculations
Date: Tue, 27 Oct 2026 07:23:34 -0700
Message-ID: <20261027142335.153506-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027135932.2301646-1-charsyam@gmail.com>
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

Hello DaeMyung,


Thank you for this patch series.

However, I prefer reviewing only single patch series per sender at a time.  A
discussion on your other patch series [1] is ongoing.  So I will skip reviewing
this series.  Please don't post other new patch series before the ongoing
discussion is completed.

[1] https://lore.kernel.org/20261027035431.1007584-1-charsyam@gmail.com


Thanks,
SJ

[...]
