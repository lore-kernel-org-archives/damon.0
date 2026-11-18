Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967371;
	b=qqzL4lmVk649Mooe3AKFj9CLpwzo093p6St6gqR8qzukPxqaL4DsC5i/AqPblHhQuspO
	 AMchEe6kCNnlF6bGih2ghAaeM8yovWtmAuvOZ6xtVKvrifklYyIavzF6egU2SRKCdYjrI
	 yZikb23oQHMC40/XvVCcV+0pEwxU8IcPbbR/Mpz0oEr8z26dVHA6rtrPykpPCEXzc65QQ
	 L1lCXfT2Fq3buXH0H97SIQ797Skjd16AWNctgoO7jh8Bwa5/LZapTaZUBEwWgpJOl5uzI
	 f9HhG3HU+ueK7zNYz6NDjJoAqvUtnvGwmnaRDIcupiJHIM53HM4Orn+H/4q434dhonw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967371;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BzRw3magrNAp/PBSLA8AnhF9lX+dGyqPalNhhDXQaV8=;
	b=lN4R4cKB48Z/4px6ZEH6pYa0wOsv3lHhr5vHjj8uLuawvxqdRXoX/oQtAGkeinrwaV8O
	 CYydk/PDLOePcZD8XVB92/vFjltjKx/v9ymdgx30XxIROvmgdhKzZvzjoEjqRDGIVczja
	 60PziRcpczFsBmLgOj5sQWgJYzK3XJHwGLHUo3TiBcT644vUsq3z8267IuhZtg6UCvYuC
	 TMqnu3m7vS39oMd9gZkdnOCg5lvHYR/Nv2+UM6rlSfXPouP7nXgEO7JlYPGfg1o8MQwwo
	 X7MXQSoRMtHx/AxqBwQzMrqZwdLdkoxTKBE9VF5q5WMQca+Q6KM1I1rsqzWBnSGzg7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E72qajSD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BD606A32C;
	Wed, 18 Nov 2026 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E72qajSD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8221D1F000CA;
	Wed, 18 Nov 2026 02:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794967370;
	bh=BzRw3magrNAp/PBSLA8AnhF9lX+dGyqPalNhhDXQaV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E72qajSDmV3nOkafXwYqu3Uc3T5gIWylsZU9YvxKQVwiIhLcTxa3a5rOZnPL218kE
	 FmTgscjfO6sxYoKxHeUbYExEnIPBjXt1EeQDQ23yIhOR/bsklCyJ/wBb/nalfYJGQP
	 uuNCoTfDK/QrOlu8UfgLTMjCLGKY6iRpu0qASXvwnyX00OffUvPlZ1UACWH0TaZQss
	 kfJZXHvYNw2miYdeXZoAI27anCIDcYNVT11qnRKtiWuvOQZTUQ4wHOYMzX1/OmgxJe
	 xPsMAE8Ol7g1R54aMSVgOx43m7RGL5gasmVXHMrYoFUkrWrqt15hgGUFPYj8pp8Gb2
	 NmPS6m8mJXPWQ==
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
Subject: Re: [PATCH v2 6/6] Docs/ABI/damon: update for sz_ops_filter_passed_last
Date: Tue, 17 Nov 2026 18:02:42 -0800
Message-ID: <20261118020243.97414-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117-damon-sz-ops-b4-v2-6-439888fa04ac@uber.com>
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

On Tue, 17 Nov 2026 23:22:20 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> Update DAMON ABI document for the newly added DAMOS stat file,
> sz_ops_filter_passed_last.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
