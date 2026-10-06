Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1339794A;
	Tue,  6 Oct 2026 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269739; cv=none; b=fMmBFGNGrv1znZurf2aVjBzmmGDQCMqs0JZteOeT7aWNnTW49ZTpZg5CXfyjPoR4o/drFaomv9kj7lfjtJE1dKWCEAb/ggwVCB8JTpp2fJyKPRo9rSCcBdxZb+Idwdml0pzJVguL/+hmTQ1UqKRcnHslTuy/2w09mPTQszO0gT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269739; c=relaxed/simple;
	bh=kg555qd2o9iW14YtriD42/NRhqbdpohb9LIbbMVaYU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRIPqcGt4SbIlwHnaee+TdqET6f22W5muk+kPS0yU+o+a9TWOIGrWVUj0T8T1AYkcblrOD+jtCk9JoW0mFaklxJ9fE0FJOcGJF8h5rhOHujLcgn+Cj9qI+QvBISU0QtJ02xLKtDTIaJeJbse8dtLxYn4vR0iKjPaZE5QVgOR3CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvCl3lwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvCl3lwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B211F000FF;
	Tue,  6 Oct 2026 06:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791269737;
	bh=COdJjkB8RgloxA5/tpxvNWdRqdglfQ2PJBNFE8IfdV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bvCl3lwH+wReRHRgeMmv6HNtPsXxtmTS3xTrV6iyy1sU5LYGWjzBTyl4LjrgF4T1u
	 FHX4MJcHEnVG+kZWYnt9HMUVZwI1A2O53GBFzYqHmdTy5ErHJ4mYpKQjbsHWu64gMK
	 9QwV5RjdhsPBw3YLgkCVx4aZh1TTsOftAJqR1v01fME7MN6WIpeh9b6crJBvSD0c2d
	 YYyIMZx1K51T1LqOATBAbsmwpXA/8JNZ4CshVg/Omu27hWCTN0YIy+fuShv4wNqntU
	 aF/RVi0+GgrxCYMhvEefdyIm9ru7tmNCtTw8TW8iqAQLpZ1towr2uZ5cDPHwqf/DFs
	 8NHlgZR21TJ+A==
From: SJ Park <sj@kernel.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	ahuang12@lenovo.com
Subject: Re: [PATCH 1/3] Docs/admin-guide/mm/damon: Fix various typos
Date: Mon,  5 Oct 2026 23:55:32 -0700
Message-ID: <20261006065532.41913-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006061549.627-2-adrianhuang0701@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  6 Oct 2026 14:15:47 +0800 "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com> wrote:

> Fix several spelling mistakes found while reading the DAMON
> documentation:
>   * trusworthy -> trustworthy
>   * DAMON_RCLAIM -> DAMON_RECLAIM
>   * charget -> charge
>   * hetmap -> heatmap
>   * colun -> column
>   * evelenth -> eleventh
>   * idlee -> idle

Thank you for finding fixing these, Adrian!

> 
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
