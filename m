Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7B1993B9
	for <damon@lists.linux.dev>; Sun, 10 Aug 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844247; cv=none; b=Xc6EcHFWXsfiDSvfPcCSlZfL8LRbhX/ZYV3VA9zRiyVM0lSeZuhLBscevvzOziqe8LxXVGVD2y2cX55N/X96JyLQWXL3wDGokVyO54TUrWh2EauqqcxzwYJFyaQgclo2AmQsfTpedPjgCRs+2myT0dR5ojAUxGGon1YsJqpKmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844247; c=relaxed/simple;
	bh=yv03zHw8OWUgZcj0WGN8WFz8nwwf4x0jz+fmzulm8FA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IkxR8Gvj0H7eZ8pk3Ghv6543LH0d+8GTtJgXE77x1lIv7Ws5aoSxdUOlkJs4CDIdKP+uxKpgxUqueZko+75oOGYf86OgoP+miA8e0mIv3vlW8ON1QGo+ckeDMm6nZKGuX/twADtF0ebADa5H6PgwC+V0vLklbtLISV3CvkA5qnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr4QrMgZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr4QrMgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584AAC4CEEB;
	Sun, 10 Aug 2025 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754844246;
	bh=yv03zHw8OWUgZcj0WGN8WFz8nwwf4x0jz+fmzulm8FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xr4QrMgZsMV1cZjajPJEX44VF09NHLO6RjODWop99Rqyrt/gtNdxOxBkRzr2CRUgD
	 YynpiNmfKtIXmKy/F3UmeRrqcm/z+DX1JNAgsrjhka0ADNcTGXLZ5f95nl5A1vlSTh
	 0qClUFsfGl0YKNleRU0rqCiZKp23Q2RNn6u7uFuk9kv4pXf5OwFnGDz8FnQ09r8hP7
	 7KnjCI0lGMjKo/TRV4e20kvTcsHZlfUFRVxBQfM0E5oys26KTh+zeIg9b1bxUJRj8X
	 lGaWmswhgJlC+rOp8Iohjn79re4huEw7n6Qv8ITDVPrja6kABfQUlsJNGtR/YFO9iA
	 kMyjwDOkei5KA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] selftests/damon: test no-op commit broke DAMON status
Date: Sun, 10 Aug 2025 09:44:04 -0700
Message-Id: <20250810164404.47412-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250810124354.16456-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Sun, 10 Aug 2025 21:43:54 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Add test to verify that DAMON status is not changed after a no-op
> commit.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

Andrew, please note that this patch should be applied _after_ Sang-Heon's other
fix[1] titled "mm/damon/core: fix commit_ops_filters by using correct nth
function".  Otherwise, selftest will fail until the fix is applied, and hence
bisections could be distracted.

[1] https://lore.kernel.org/20250810124201.15743-1-ekffu200098@gmail.com


Thanks,
SJ

[...]
