Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDDE5111A9;
	Mon,  7 Sep 2026 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799303; cv=none; b=eb7b0KfVD4JhmirVbe7zDqnY79eJCV+ApI4yISHHPEP0c0wNqRZRCS7xIC8sEpVFfd4IvaV1gt43ajAESjhrfuNlGCYvpB7G1pfHh0poBLMeu0ClrYrzIbP20sCdflW26vCRAO9j7HrAY/SUtPS5EeYqvfPRS1ZdYkxLz2aOO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799303; c=relaxed/simple;
	bh=ZjLOkSlLdR1jfLyWVz2vCCLaVWUaujxowOpu71YW9MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku/U4ui+DufUFag18rywD0iiTIFMJJ0u8KoqEkRA57nsNe79MvCI9H843gMG5Vh8Sz2uDDKzqnmwkwNoCTQlYIv0bgPuzEaSFaOdskvDbupqbkb55aiwRAHYqvdQk7+N6QoegD1uJTj2Ps8Hjqz+Ygzp3bOjA4hC/yWvouRZPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeZrNCGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeZrNCGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CCE1F00A3A;
	Mon,  7 Sep 2026 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788799302;
	bh=2o2i19ypzRp1zZlcTwsPkK6eNqVdjfCbynSxyeXYXvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jeZrNCGs4WD65/u5voFDVJu2Ma65oDUNgRc93clYuDP6GSkDO2JtRtD2xncF6rOI2
	 2f+OLlBmoWqRoayX9iKMhoc20b25cThk2jBb0mFWXneLqCuC/JOxRzaWbZxaNP8SLS
	 9RzCNa1AVLdPFVE5wULRVgyAMqn8BqnXPzPi1xzLaM46f9g/uC3JH41cFZExF7CSeN
	 ySRjyaJmg3l3UhFQM3zwMaWmasvYp9sGVi09quy7ghOxmFTcDDCoV36uR+Ycea6QGJ
	 +YMFqmJ2PRvtm3nilju2fFUKWf9Hxf/VfAQQ1K7x+lOMHjH/cJST+XvjoMnWt0AErK
	 z99k0CK0c7IbQ==
From: SJ Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	ekffu200098@gmail.com
Subject: Re: [PATCH] selftests/damon: stop kdamond on error exits of no-op commit test
Date: Mon,  7 Sep 2026 09:41:34 -0700
Message-ID: <20260907164135.97543-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907123455.67246-1-zenghui.yu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 20:34:55 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> 
> The sysfs_no_op_commit_break test starts a kdamond via sysfs, but its error
> paths (e.g., drgn not installed) exit without stopping it.  The leaked
> kdamond then makes subsequent tests, e.g. lru_sort.sh and reclaim.sh, skip
> with "Another kdamond is running".
> 
> Wrap the post-start logic in try-finally so that kdamonds.stop() is
> executed on every exit path.

Looks good to me, thank you for fixing this, Zenghui.

> 
> Fixes: 10725cd2b09a ("selftests/damon: test no-op commit broke DAMON status")
> Assisted-by: GLM-5.3 OpenCode
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
