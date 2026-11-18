Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966828;
	b=fN3XK9yX51Rw6MUOGvtr/hmTqw6X8EFQdKr6IbVx7YSXZ7VeBdEsb9JzxGXJmCwXTXM2
	 NQ+wlp+Q/fTAh9QtgOQ/KgMVZ46RwNahEaloz9G/8Rp7cpb4+5DSXn41WXLNjb03O6U26
	 CFfh1UItc9CV0W2758N41ndIDTRr9WzvYXBCu4kuirDq2RzEU44A4xE+oIfFO/WylQVra
	 2uDlwME7REx60zmrB6C8bVfrCybSh8vMDlmIkm/BHw88Ust2HXoVgsieD0DUWjySUDXnw
	 KqO0G/43L4YZsIkAyxj7y+0lyXQ/xULu8P9Ln0sjSkTk7vHUJ69Putim+nQ1yolvrXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ftEokabaZG7Wg3nlwTH07C9whZDOJt3FfBUJuOwVvUA=;
	b=zfDmPXxfeOn1uSck8UKKZD0Cd/1NwP7AJFeLoDcjaMoytuNYgWrxZ2JOg4Cm1ZGQzZjD
	 v2dguSCmmDr+A4WsTTcxdKhi4veRQxGr/V+8b9SmRTRhRvOH66ri47Pu20/rXaOR9ApHQ
	 fEdU7x7qNWGXxYvMTeE4BQK8nTVPOTgVZquciZurffLyqjRzZ7JBnjdwzlsKT8rHbIyFQ
	 1xG4+8yD4JICplK5jpbx7s8mAi0x4IEVO9evrB4zKB9CgmajkrEdakx9zNCgXKzHIWsIr
	 u7geuj9jZhftdfT2buPaj48v6B14IPiSYcEmXzKnKf8kDyHtPQgcIm/0AVgb/9zI/4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K9DazTgq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B7606A325;
	Wed, 18 Nov 2026 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K9DazTgq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9357F1F000C5;
	Wed, 18 Nov 2026 01:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794966827;
	bh=ftEokabaZG7Wg3nlwTH07C9whZDOJt3FfBUJuOwVvUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9DazTgqbQKHgVajtXTFzbTQKVx12pPjQm+tfHT9KrXHFThADgzFOKResZyT2ZDKi
	 MS7XL0zgHSMNNDLts0JOvcdaQdpg69P4Q5Tsgm2/Vwi5DDCbL9mL+kw8w7faod1z0U
	 7AGnvNzmm11g6BXEUaARQsIL6jVGHW/mPcDhHFbENnVe1CK+5/lH1CB5jBOkhXHRz1
	 UXianG+0TiuHCri9qBivWl3l1JMd8PrWA4H4cjGi9eKuVgHcuXG6e8HnNVg10pKQlB
	 U/cll1ahEQV13mj5UPGsjAdVkrHSx8uZi/Sj/BPFi50TlKOaGVkO1uqOv7ma/L8VfP
	 hZy3vqyeQ6UPw==
From: SJ Park <sj@kernel.org>
To: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mattathias Pinchover <mattathias.pinchover@uber.com>
Subject: Re: [PATCH v2 2/6] mm/damon/sysfs-schemes: add sz_ops_filter_passed_last file
Date: Tue, 17 Nov 2026 17:53:40 -0800
Message-ID: <20261118015340.96006-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117-damon-sz-ops-b4-v2-2-439888fa04ac@uber.com>
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

On Tue, 17 Nov 2026 23:22:16 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> Introduce a new DAMON sysfs interface file for exposing the newly added
> DAMOS stat, sz_ops_filter_passed_last.  The file has the same
> name as the stat and is placed under the DAMOS stats directory.  Like
> other stats files, it is updated when the stats are refreshed via
> refresh_ms or the update_schemes_stats command.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
