Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926420;
	b=W0rtMBRVFeWyHfwc0kJgs6ClF06rLbCrVcb+tr2nD2W7FK2YpyJYGc3Dq/47XKzJDWvk
	 o7yiYNqi3CcbeKuus66f2cKhlHuSiBnK7ZfGzQeXCgAn6DSL9U3bobqEPfpplDuUljQVE
	 1kD8fh3YIVYwK7vgKB9CTlpa88921jCuB9+m6xhEGDsbr6E/JalnC9fA7OD9gJDqR6BfP
	 gDSsVzYREMQN/Xe/VpjPaoDBe9CY7xeqNkYsNceLkGF1LEuTzz9gWqJERdlHdOlq6z2s9
	 p1922HM9cqbFfOiseINDAKy9KHH0s+Zw13ut3X7jKUy5Tgo1JWvrvDUlxNVE8iigYgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926420;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Is3YZDsuf4kkEHdqcvbool8F9PgEbG1uxT0GybnHP8U=;
	b=lXXA9TX9yHDx9Z2woOHRE+2rMsOflxAwQLxcKn2e3hbJGUq2uywoWgJ5EEJLYkeFtD0q
	 Y3WiaunOfoAOhGoQa43kf9/0LVL7gxXO+86NCycsDCIFd9JrcjCNZEowA9FeIlTuSqjk6
	 KpX2vnYU6GLfZ/xPa8EFlgOvT9sWDGRTVt6p3vMT1mSJg+0/R6ox9pty2938e+FA1As95
	 aNuOfkpWRdOzfjvLh1GYlFlFAtYQYs5xWjv7qx0ZKsduX54v13zSuLUOAWZ9b5NLRVyIH
	 pYFUBINCfyZIYNiYu6cttQ5E+1DAYJFzGEIVN0VjpwlVT5BzSTtDQ68nDbNpaIXjYPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGIIRE7y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD13606A33D;
	Tue, 17 Nov 2026 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGIIRE7y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BE61F000D0;
	Tue, 17 Nov 2026 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926420;
	bh=Is3YZDsuf4kkEHdqcvbool8F9PgEbG1uxT0GybnHP8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iGIIRE7yfPORHZlp7Lj3Bag4dvQuRrC62XSY1s6WDTNwavLC1O5g6mPe7yWCoHU3e
	 3lEfcY99mbdwW+mnBqYQSsmlvkVMxihpUSe0nnnqdhHjz5PunFqtuPY9ErjUAg2xVH
	 7w8V7WwU1lHBrFBefjZxu++osEVkRbISir5i0SwSQFxhRTwJV5fMFvRnORd1/ajyV+
	 iWzJH+wRMnP+rbZ3UF8ffi6FtwgL2yPFkfAq0sWebH+jMNJ3vevr0bFvTdnzk3TG8J
	 yuOEfVjkgJXF9EpoKL0KQ3HYTYwuj8/WKuB586Z9/OGkOmk0kaKm2m+mpRU3L4owa8
	 uAiL/0CdbhMrA==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/damon/damos_quota: skip the last sample when counting exceeds
Date: Tue, 17 Nov 2026 06:40:12 -0800
Message-ID: <20261117144013.121872-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117-fix-damon-quota-selftest-20261117-v1-1-c65d687d3def@gmail.com>
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

Hello Aveline,

On Tue, 17 Nov 2026 17:25:36 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> damos_quota.py expects qt_exceeds to be increased for every sample whose
> tried_bytes equals the quota.  The kernel increases it only when the next
> quota window starts, so the last full window may still be pending when
> the workload exits.  The test then fails with an expected count one
> higher than the actual one, e.g., 15 < 16.
> 
> Do not count the last sample.  Also drop the sorting of the samples, so
> that the last one is the latest.

Looks good to me, thank you for this patch.

> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
