Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AA3C063B;
	Fri, 20 Mar 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020131; cv=none; b=dnzJI3/tZ600ADkHNe1TdxMX13uVgJVzAaECWZ0ABZrl2DIJZY67QIhv76b46nOaG/N0nl44YvatF7yIeAXrSwOw4H3Lexi1OaGRP1D9ISM4vzwaHFMaYPccIX+OcIEH/1cEX0t0yaOwA3TS5aSaD0Qr4zo57OKbQJe53mLADY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020131; c=relaxed/simple;
	bh=Lhl4uGbjNhDWWUkPCE99I5Yld9BxJ5atQzzo7ZYDh7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlsndTZkdKDIEs/ZCvumdxI+KtHj/ogvuUuw7EnVfl8gpa2tfkDQlW05DqLKpIhxEaz5iABWQPK5+s1Cba18cE3AiBg1xyWxApKOQO8eVSta60R9rv5O/dzJgNUcgbfg44A9D+HkCt+2EznAGu1H/Ar0eiW7hjnGhQ1BkhTKHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmPl7NqM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmPl7NqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4224AC4CEF7;
	Fri, 20 Mar 2026 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774020131;
	bh=Lhl4uGbjNhDWWUkPCE99I5Yld9BxJ5atQzzo7ZYDh7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmPl7NqMwKwM+PqkVjDPfPJ83uH8zAmoGL/nROJ00W0n4NVR3iYAy3jTFACEolNvb
	 bdtPOYOMV3jic7BQ7k6fANgCrSeWw4QYX0/styqsI7cwo0VRvyB3O8K1s9xtkIf01P
	 pdE0kTSuXUUfoP4WEgQtJZoUdIM4a8L4I1VxYEALoyM1ZLFxpEpdzWAK+gamlY+hSu
	 xm7uSwqSnTQqNTWNsijfHOXdTaRdkLgqGJWhnLh3wgy7OHA7tqtw2SGjvZkmo1ytr8
	 0XpTdSA3RkdDn+YS8xUZsSoPD/rqtlSwStQJOltyxLpeUMRkjCfOwimEqc97XsWli+
	 9Oz+N7PCRnL6A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 07/10] selftests/damon/_damon_sysfs: support pause file staging
Date: Fri, 20 Mar 2026 08:22:03 -0700
Message-ID: <20260320152204.99275-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-8-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Mar 2026 22:21:50 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON test-purpose sysfs interface control Python module, _damon_sysfs,
> is not supporting the newly added pause file.  Add the support of the
> file, for future test and use of the feature.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  tools/testing/selftests/damon/_damon_sysfs.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
> index 2b4df655d9fd0..120b96ecbd741 100644
> --- a/tools/testing/selftests/damon/_damon_sysfs.py
> +++ b/tools/testing/selftests/damon/_damon_sysfs.py
> @@ -604,10 +604,11 @@ class DamonCtx:
>      targets = None
>      schemes = None
>      kdamond = None
> +    pause = None
>      idx = None
>  
>      def __init__(self, ops='paddr', monitoring_attrs=DamonAttrs(), targets=[],
> -            schemes=[]):
> +            schemes=[], pause=False):

Sashiko comment
(https://sashiko.dev/#/patchset/20260319052157.99433-8-sj@kernel.org) and my
reply.

: Since this line is being modified, could the use of mutable default
: arguments for monitoring_attrs, targets, and schemes cause unintended
: state sharing between instances?
: 
: In Python, default arguments are evaluated exactly once at function
: definition time. If multiple DamonCtx objects are instantiated without
: explicitly providing these parameters, they will share the exact same
: object instances in memory.
: 
: When the constructor later executes self.monitoring_attrs.context = self,
: it overwrites the context reference of the shared object to point to the
: newest DamonCtx instance. If multiple contexts are staged concurrently
: relying on the default arguments, earlier contexts might inadvertently
: write their sysfs files into the directory of the last created context.
: 
: Would it be better to use None for the defaults and instantiate new objects
: inside the constructor?

Good points.  Orthogonal to this patch, though.  Also, there is no such use
case of this class to my best knowledge.  I will consider such change later,
though.


Thanks,
SJ

[...]
