Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DE214AD0D
	for <damon@lists.linux.dev>; Mon, 18 Aug 2025 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558108; cv=none; b=AfQRIATUQMRxwSedfxC6/xBQ2mzJgQhKQEFizVYv5v5dzE7BUbrSOHORq992hTeBbB9mJnTREZs/8ysFYfbpOSRihpnqvwWpGMkdYVX/T5cpgoYndjMtRRoUDq6xipB8Jx3VG+guIcK5ZGJ8atYlU2s7Ep+gp2WHev+TvwNZ3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558108; c=relaxed/simple;
	bh=e3daVw9VGOXj3R/V1W0E5XdXB4FzvZf9+xPmzhbSgJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ge5rdNpkVCj+8etAQY0GyJVh1kL8SxuTo3ufEoCTP7maBM35NTzQMm8p5N5lz0+ySWKCnHqTZsptUOFUu8QhEymml4H33BNV5PHJAnGSPgSLZY94I/ZLt49lsX6kZikp6nvEsvopGpL48jr0brwve9b0t+Rf2PeQcl/kbljQs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6P9ffV6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6P9ffV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8864FC4CEEB;
	Mon, 18 Aug 2025 23:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755558107;
	bh=e3daVw9VGOXj3R/V1W0E5XdXB4FzvZf9+xPmzhbSgJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6P9ffV6a8+xy8VK8inrRcDrU7sh4cLGHJvj3DBzBzEJi/Phxuq4GeIEFYfyLR7eJ
	 EoN/NNte+BRjkWbshztJPm0ed10d0ju1uKqJWadfmwcSUF/oI0TnvNxOioz2qJRHhX
	 1TZ7NcpGWRX4YcKpM8BmgtlMl1qJ1FZkPyivLc0e4ow9zkGYPiF/+VuWDsqr0Dnupo
	 n/23pLs+Be6vFqYX/RZpCzyicUfRbvoqsLokfEXG0704DNcEj6NbPLW1wZDkpGmq18
	 gKVDeGn4aqiVkO+FA9mfz5mB1k/QmpLc1g9Mj365pAWUrIeR5dCGsVpwi5yJo7tBuJ
	 csi7m+gdtGEYA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: set initial quota->charged_from to INITIAL_JIFFIES
Date: Mon, 18 Aug 2025 16:01:45 -0700
Message-Id: <20250818230145.4056-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250818183803.1450539-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sang-Heon,

On Tue, 19 Aug 2025 03:38:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> include/linux/jiffies.h
> 
>  /*
>   * Have the 32 bit jiffies value wrap 5 minutes after boot
>   * so jiffies wrap bugs show up earlier.
>   */
>   #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> 
> In 32bit system, if quota->charged_from is initialized to 0 as it now,
> it will not adjust event if reset_interval_ms passes for the first 5
> minutes.

jiffies is unsigned.  Hence the initial invocation of time_after_eq() in
damos_adjust_quota(), which is the only place reading quota->charged_from, will
return 'true' and the quota adjustment would be done without delay, unless the
scheme apply interval is unrealistically big.

Please let me know if I'm missing something.


Thanks,
SJ

[...]
