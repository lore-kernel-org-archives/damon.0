Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC43C4B93;
	Tue, 21 Jul 2026 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616072; cv=none; b=LfHwu8+utoU9G2x4Tv1RmO8Cgp/AkBHzwl1yeGdqr97izcD99iJ1IWlfrC45CuhMRBqQdnSB5SqdzfdxOaXRgi3WaMaX2N+LtTwsYUusCvf7N2cyoCAQ/W8TSvrP3GBK7sh4quWHCW8y83j2gbsUotEipZkSOjm2ixTFtPC4bL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616072; c=relaxed/simple;
	bh=yD1X+bOhprt9Ce0R03/zPBjujXOIt9eVNKfL+WV+CT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQFZLV5H5k+BFjxh0AxbnkTVQsvsCKh/Zx0BCDin6uWSnE9qxg60WuF+Po9rGW+nAdyC7IpIW+IOHk6v0DNKx03bvWMtHxbDbidF5OJ7PDOQ40C0pcyz8bTPctqVrXhoiFzUhr3EyCPOvOHNJO8LKi4V/NzwACFuF4CMD/06Y9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTiZGmzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTiZGmzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372371F000E9;
	Tue, 21 Jul 2026 06:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784616071;
	bh=dOHrExRuWAF3V9Vp4izbIbOaYSPY1V+m+7eA9UxNOs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kTiZGmzZz3UketVn5wFBEYl1u3hPtLyHVEEOz4TULPcMK8jBb99DiCJjEo0c5Jcvk
	 ybN/XDXNCuR2DLNeCcLaLqvXV7j0dJ8KPUD3hCNet8cDB2iZYHTBSmf54HtRXCs9lT
	 l+T0nwHVrwvjECzB6Hnjts1BDzAwiNNFNstCzKCDuZRM9OseOrWsCJ+9n2+XuDQnQD
	 wYkk3UXA8sbfsTj2fzQwDTl000B/BWPTWREbcZKEB4Pa4UUUYK9Et1PVkFpDzIpzcJ
	 C8ZlF67xWrbQOl4ZdnFznWQF2umYIw+dHh6mRpsfaDIWy4KJXJuv9352pwX4YP8gIT
	 yvSkkJLoaDKfQ==
From: SJ Park <sj@kernel.org>
To: longlong yan <yanlonglong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	shuah@kernel.org
Subject: Re: [PATCH v2] selftests/damon: Add missing NULL checks after malloc()
Date: Mon, 20 Jul 2026 23:41:03 -0700
Message-ID: <20260721064104.182094-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721060542.326-1-yanlonglong@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello longlong,


From the next time, when someone asked questions to your patch, please answer
the questions and keep the discussion until the next action item becomes clear.
Please don't post a new version without making sure such discussion is done.

Also, don't post a new version of a patch as a reply to the previous version.
Post as a new thread from the next time.

On Tue, 21 Jul 2026 14:05:42 +0800 longlong yan <yanlonglong@kylinos.cn> wrote:

> In low-memory scenarios, malloc() can fail. Without checking,
> the test will dereference NULL and crash, causing the test harness
> to report a failure that is unrelated to DAMON functionality.

'test harness' means the DAMON selftests that internally runs the access_memory
and access_memory_even programs, suc as damos_apply_interval.py, right?  Could
you share more details about how the test harness report a failure in the
situation?

> This is a false negative:

Shouldn't it be called false positive, as this is a context of tests?

> the test should skip or report a resource error,
> not crash and mask the actual test result.
> 
> Add NULL checks after each malloc() call, printing an error message
> to stderr and returning -1 on failure.

The above description reads like this patch makes the DAMON selftets skip or
report a resource error.  But I don't show how that works.  Could you please
elaborate?

> 
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> ---

Please add changelog on the commentary area [1], with links to the previous
revisions.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ

[...]
