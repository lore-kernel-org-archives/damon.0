Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733B355F22;
	Wed, 22 Jul 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729050; cv=none; b=a6N0IjtOPgVZcsopO5bBdlFLXDYD7SlqRlt8Qufuf4oxiQ6oPwftut4vDXECWkYw7ZmXKT6W8rdf6QL0jOAISfXv+nNeqBnxWKfmgZ0+q6VlhUgnM/fXmQ6DoWgWmyaB3xjAr02gdyJmXf1VMvvtKIPBM29xiPFS5Sp+4dBPFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729050; c=relaxed/simple;
	bh=F3ldbtro0kkERwUMJbvZUTO/IvATWZIEECXRnXODbBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tib/SGDPPpBPmHiUKXGlV7M6lf0znHNZMOEQaPD+bV3hhBLoelSPTanvXG6hLLtWPDY+e3T7goDJ0kcHqg3gMyOViIEbKmIsuJU5CayL6aYpx2CuBDWgfZZJXlNUpRlFYUOJ/WVbOPQLly1C1CxdFCeqvdQ0+ZkZWfwOai79OcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCVgnYM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCVgnYM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDD31F00AC4;
	Wed, 22 Jul 2026 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784729049;
	bh=5kH0UiDy6iA8qhgAkS2XGaRTI2kmVSqdkfcswAJ2RR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UCVgnYM0nzaYUeSvhwaSiiwHHGClKZGjt3YMsoI8Pxfdi/Mw8dLNHzK9Khk6TamXC
	 WINroK/kJx7WiB0fZivv2oi7jBx0JknQp1XAmRnX9EJhSMJ7vxTFLpAKKWxVoabIyc
	 S0cJ4+pQRIt+yno851PG2NhXii970/xxRuUrYlrvmzNYf3IP2NGpY33sqcpk0zGx0j
	 tE7lzO5IjbwEM4lG1jJ1DWVCzZx2nbwFBoMdKgafeNhAeZKLRAn/9K8nsSFvbjsL7i
	 xNqcFIa1/ZliFf5IsWM+jNtfIZhkTlCGQ3sARQGQKz9l3OU4G7bm8j5C8U+kODF9t3
	 V/GLOOqYq6tvQ==
From: SJ Park <sj@kernel.org>
To: Cheng-Han Wu <hank20010209@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/2] mm/damon/core: remove unused damon_targets_empty()
Date: Wed, 22 Jul 2026 07:04:01 -0700
Message-ID: <20260722140401.88772-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722113338.302603-2-hank20010209@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 Jul 2026 19:33:37 +0800 Cheng-Han Wu <hank20010209@gmail.com> wrote:

> damon_targets_empty() has had no in-tree users since commit
> 5ec4333b1967 ("mm/damon: remove DAMON debugfs interface") removed
> its last caller.
> 
> Remove the unused declaration and definition.

Nice catch and cleanup, thank you!

> 
> Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
