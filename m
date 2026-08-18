Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A15347BD4;
	Tue, 18 Aug 2026 04:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028962; cv=none; b=oJ3CkelWoqEZwg26XfAPxV7RWj69lfF0D9mH+sKw3ExsXvwjELQgsKJLQb04FpFgTlPyBJHUQmg+ASZ+1mkzzZt2Uc8lwcsmCCPuwkLnhVrb4GZIN0PST4eBO2m6LP09cQUlkWrEkC/TFaOE5mTHjwQHK2FoRmtVCT9SsimHo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028962; c=relaxed/simple;
	bh=iUlYH+qy1IXaVSK086QkzLa1SqIfEIzV3WzQzCWENBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKp1JAxoTqDuMNKxWmscKn9XR1tK0hoYERYVLQAUVQ1BaMWw7/+/yAn8GdKptEVUKPDe3B+DaqEZ38mSHbBacx+SN6Y/ivAwh8GNoPudNv1cw1wwBo5ag8guREvsBaKMgsU7BHJ/3b7rAh96iDlBxh9uuMPyGCRxHW4R8YYLyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEA27Vtf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEA27Vtf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE38D1F000E9;
	Tue, 18 Aug 2026 04:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787028961;
	bh=vdlfN25XAKgFUitCj8lI1oQIUQ1SvqTjbVdFyVZb26Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kEA27VtfaClVxed/T8zuh7xSAo5X9ncPa9FdCPTgz+n7if/wcZLgJ1WH+vyQXgP7E
	 GN2c7TazsbTI3MMIjBFjOcLgfKCCxUxZq3c9kVZ8so84Pg6VKcd/8CrTaBqoZJGQGI
	 HasBfZPqn1rXoVTNnE7RGxk90uQrBKWEmzuC0gG/Rv6qYPa1G2UsDAwwsMse/x4pK8
	 tFrqqEwB+dFVWcxnuu29Yj95AIefoM01enwcilVD8o4JNNoT2SvZ6U52Z5gS+pPSxK
	 9GFFNXNZbufM5Z+WYVgbEqyigfMlODjf3sm5g4D1jzr4czVs1tZHjLNw0UdXCLrjo4
	 IR1/QT5HYteJw==
From: SJ Park <sj@kernel.org>
To: Jason Angelov <jasonangelov@ucla.edu>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/core-kunit: test damon_valid_probe_params()
Date: Mon, 17 Aug 2026 21:55:57 -0700
Message-ID: <20260818045557.97267-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818034552.11975-3-jasonangelov@ucla.edu>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 18 Aug 2026 03:45:52 +0000 Jason Angelov <jasonangelov@ucla.edu> wrote:

> damon_valid_probe_params() makes damon_commit_ctx() reject probe
> configurations that could overflow a probe_hits counter, a single
> (weight * probe_hits) product, or the sum of those products.
> 
> Add a kunit test covering each rejection at its boundary:
> 
> - samples per aggregation interval: U8_MAX is allowed, one more could
>   overflow a probe_hits counter
> - single weight: the largest whose product fits in unsigned int is
>   allowed, one larger is rejected
> - multiple probes: each product fits, but their sum overflows
> - no weight set: the validation is skipped

Thank you for adding these tests.

> 
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
