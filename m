Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794776120;
	b=RxDE8TH8KH3aqTlN0LOH0nxuK7Q6svTXStFRzS60y1Aookd2eAY4rCk0xUKE8q1185Vh
	 RpM/gOnjVNhNaZGuT0gZoy60hX25uoKQtLHE6g8TOijivXNXYS+9E1CwUa78KqbXjMI2m
	 sLQX4i3iTznbaxLfBczmr4xkloeYe3NiUmI1Lqg6u2nMfAcmqtcQjogyuHLUzBKPxdUWx
	 slSPIe136N6/cZ9csQml+WTp8PID5zbWc6UsOVGhBBIZ5WBjqq9WK9IJlgbfbFkuVQf44
	 f85tFigrIwZlqL/Z9zCrE3RichFqJsyshMDQvQE2Gbp9HduiLL8pThL90oFB0GQ374w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794776120;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=52d/RCwDfD/DgbGrt4TUXt6ka8m/3NLeYGrtNO6HoqY=;
	b=VlnwcdS8qv76ZvB6CTXMKxe7UlzpFYEl3F+rTWYw3FjdRm3NoltziLqIw4Z+bMdKd3E1
	 akpe3cSTBobdhned8Dn+MRq49w7OppfWBqDP94xNa1Fxj9FeXukbi8l9hLSiHm2YQbfDo
	 4dAxZpwqRfZ/6JYyhHoOoalrQ8WmCtH+NpL+JhUjCbDUvydNU9ki4W7JNFOrgthDGpw9d
	 YOdTBIg1uSt0kkZEFXDBBwDQBK3MvHxzzTqOMyF1XJJvJEIfYlaXCOlDJpvM40c6mrVSQ
	 trwpo1ypb2kA2hv0fL3mQBq35xfXd1TaHn+cJ13NjWrd0uVmgw83of3ffzL5lKelJgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfkGcQAA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE2606A32F;
	Sun, 15 Nov 2026 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfkGcQAA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4342F1F000C4;
	Sun, 15 Nov 2026 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794776120;
	bh=52d/RCwDfD/DgbGrt4TUXt6ka8m/3NLeYGrtNO6HoqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GfkGcQAA1lblP0vFE18llod9rgiJgby6+DewN9r52r9T2qVLRlusFD2na9MaXyzCx
	 0JCStUgLSKo5/jbQtgZKnNOvbugHkSjSP33tmhRkEFpKTQXyQCG4bgqQTra5I9VC53
	 zFuTuW+z5ic6VK61ybqjl5SBqyiFy6DuSyrMscIRHTVlAvijG9Na+l1K87Tk38GVAE
	 R3/ouO/zf7NpjMs5qtaPHv0CUAMRihvf/kyHu2wC/bMIOvncd0mHvYQiDhAcjFDNnx
	 DNdan1AeCtrOlHqR2L0T10jvVkj+RSFeFyU3tl6pUO3wBl5bLnU/uq7ig0jxqf37oY
	 gOsDlHcep9vsQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/27] mm/damon: let users report their data attribute findings
Date: Sun, 15 Nov 2026 12:55:12 -0800
Message-ID: <20261115205513.99979-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
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

On Sun, 15 Nov 2026 12:28:18 -0800 SJ Park <sj@kernel.org> wrote:

> TL;DR
> =====
> 
> Build a system for letting DAMON-external entities report their data
> attribute findings to DAMON.  Let users report their data attribute
> findings to DAMON using the report system.
> 
[...]
> Ongoing and Future Works
> ========================
> 
> This is a part of the "beyond page table accessed-bit DAMON extension"
> project milestone 2.  This patch series provides the initial and
> essential part of the data attribute report system.

I forgot adding a link for the project.  Please refer to this thread [1] for
more details, plans and status of the project.

[1] https://lore.kernel.org/20260525225208.1179-1-sj@kernel.org


Thanks,
SJ

[...]
