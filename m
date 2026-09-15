Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583F1E515
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432125; cv=none; b=ctN13392NBrqCXnYyh5M9pALWu7zwhZOHBPUgkztvJo2yt5E2RdbkdS6ZYyAj5yN8O9pEZ2vfRxXNC7W8bADvXI+WD1YMfpWkFquzLGmdvjVwWOELqS8FzwJ62HwRKhX+9O06EciI3TPPsAamk7dIXCEU6nTsLErMLRFcqPUDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432125; c=relaxed/simple;
	bh=PTkL62gasPKSL1udOtT88tHHkgf2hr2Qc9HIKXxnIqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPjvcMI9g3PWqJbwI9gmSrTiMBZ3oPtC17p6McvNCAsUKYxzXxIbpfVaZbt3chtR0A61oS5dmv0nAZHt+DP/E7JKsDBVv/EQagW0AZxPA9I0KtX5MAAFMH3xTw3i7KIWYIx0+4bDDf82fsPPfH8WUYG94w1W4C6agqus4WARDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK3X0I0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK3X0I0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D94D1F000FF;
	Tue, 15 Sep 2026 00:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789432123;
	bh=UqLvGi9RD7qINvX2Zb3ISJuj6Gh5D9tq38HZDv24EM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hK3X0I0Lmube4dVvbjOzqRQOzBfAEW9WHlkZLcjYRD2dhvBbrYtZduvYQ8nfZx2Hg
	 X8grAnmwfrylot6YmXa/uWBvGfeYuiQM2RHKRHxAR/jVTX5UgUsJnRsfymc0jLyW39
	 Z/SILDyUmSiGmFuz6D6qmU/rlNfEUq9HQO82r1KAGAGKThPh5pZtF2WFhpJHpjOENZ
	 oPcCDWIm4PV/fokbtnO2SCvkTqwnMJ5SnGm3fxJHy5hnKC7ySznb2sobwO9eqf2I3f
	 EbGc/08iMXnzZxFwzuTXLaW4thauo3Gzwh3fqS3Ido0zaGaozJ8EEoO2tbJw8+iSH9
	 NpfG15+ULe4wg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC/Discussion] mm/damon: Implementation for paused kdamond
Date: Mon, 14 Sep 2026 17:28:35 -0700
Message-ID: <20260915002836.101895-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914153640.8481-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 23:35:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ,
> 
> I noticed that the current implementation for paused kdamond is
> periodically applies online parameter updates by kdamond_usleep().
> 
> I'd like to know if we should change it to waitqueue to achieve a lower
> power consumption?

I'd like to make a data driven decision :)

> 
> Previous Discussion
> ===================
> 
> I noticed that when you introduced ctx->pause [1], Sashiko asked the
> same question, and your response at the time was:
> 
>     "sample internval is 5ms by default and recommended auto-tuning
>     setup makes it hundreds of milliseconds.  So I don't think such
>     change is required."
> 
> I'm curious that, did you think it wasn't neccessary to change it to
> waitqueue when it was introduced, or it wasn't neccessary to do so even
> after it had been introduced?

I guess I thought so when the quiestion is raised.

> 
> Asussmption
> ===========
> 
> This is just my assumption, not a real use case I knew:  When 'pause' is
> set on an Android device, user might want DAMON to stop running
> completely when the screen is off, thereby reducing the load on the CPU
> without losing important information such as regions and age.
> 
> The current polling may make it harder for the phone to enter idle mode,
> resulting in some unnecessary power consumption.
> 
> However, pause feature is only present in the stable version v7.2 or
> higher, and since the latest Android kernel is 6.18, this highly
> unlikely will affect any Android users.

If whoever comes with a data that require changes, we can discuss.

> 
> [1] https://lore.kernel.org/damon/20260321202858.98091-1-sj@kernel.org


Thanks,
SJ

[...]
