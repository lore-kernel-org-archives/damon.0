Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC12EC09B;
	Sat, 21 Feb 2026 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771704951; cv=none; b=TYv4SDy/krFHbS3xgScO8yIkzb7Sy4d542eOr52wdFUraD9ArIDK4whIhzWD8Ps0xGg8Ea2v/PpxNx70Yl65ZBLGDia4+PpXj1Sn+I0868zgJ/FLHEgqqfAJL5VAtOUiopgGylY6yYKlVuVKzH5jYMYJ/tCuJCl39J04kCelcWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771704951; c=relaxed/simple;
	bh=u2lzxOaYu+TQWqH/uMkeTj5YiPDYlTP3c0J6MrqedxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKc0fyxiC10zPdTpaiiV3XgwH+ivTQT7/nR+IKIq2gLZLOG/Gv5Xphdd+QbOgRil0z97yKV355OFBZ/NCqHbgHN/OFrhjZ8vV0022CSmS5/epDMQRVCHJJ1hFlTjXZU9vLfoZckz3ENEu+y1KEKy/flaKD6goYe0Yn7dD375GXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCo9fZp7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCo9fZp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9048AC4CEF7;
	Sat, 21 Feb 2026 20:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771704950;
	bh=u2lzxOaYu+TQWqH/uMkeTj5YiPDYlTP3c0J6MrqedxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCo9fZp7C062sLKYnb7OW4C65uQt6vV7Su9amxqp2y7NcpX+SyTXVpfozk1KgWegU
	 vT5Fe75M1tJ1r/ok/yqcLxI03o6uWH646I8Y9U80iRIU54YLnzYDLIk0Bq70FwuUAE
	 P5laELfTfIeCqXu41bRPZcwZQ2Q0tVg0Vz1B4DfkOX8UA+rCuX5sT8ZhG96Y5klgRK
	 PHeXXaXQrinXAHLypUo64nJTtBLvJVTsw2JmnEmwBAqPkpyIbC3NTyFsJua6WLX2jz
	 s+d9W4ReAiCDFe4J/3p4GuU0eYLzEoankF9Uc4XkVkbwSqloEDPC5xh1Ao51A6mP8N
	 4SLvhdPfDO4Cg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 09/10] mm/damon/tests/.kunitconifg: enable DAMON_DEBUG_SANITY
Date: Sat, 21 Feb 2026 12:15:41 -0800
Message-ID: <20260221201543.99335-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-10-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 21 Feb 2026 11:36:26 -0800 SeongJae Park <sj@kernel.org> wrote:

> CONFIG_DAMON_DEBUG_SANITY is recommended for DAMON development and test
> setups.  Enable it on the default configurations for DAMON kunit test
> run.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/tests/.kunitconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/tests/.kunitconfig b/mm/damon/tests/.kunitconfig
> index 36a450f57b581..144d27e6ecc5c 100644
> --- a/mm/damon/tests/.kunitconfig
> +++ b/mm/damon/tests/.kunitconfig
> @@ -13,3 +13,6 @@ CONFIG_DAMON_VADDR_KUNIT_TEST=y
>  CONFIG_SYSFS=y
>  CONFIG_DAMON_SYSFS=y
>  CONFIG_DAMON_SYSFS_KUNIT_TEST=y
> +
> +# enable DAMON_DEBUG_SANITY to catch any bug
> +CONFIG_DAMON_DEBUG_SANITY=y

And this makes kunit for DAMON fails, like below.

'''
$ ./tools/testing/kunit/kunit.py run --kunitconfig mm/damon/tests/
[11:57:20] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
[11:57:24] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=8
ERROR:root:In file included from ../include/asm-generic/bug.h:7,
                 from ./arch/um/include/generated/asm/bug.h:1,
                 from ../arch/x86/include/asm/alternative.h:9,
                 from ../arch/x86/um/asm/barrier.h:6,
                 from ../include/linux/list.h:11,
                 from ../arch/um/include/linux/time-internal.h:9,
                 from ../arch/x86/um/asm/processor.h:4,
                 from ../include/linux/sched.h:13,
                 from ../include/linux/cgroup.h:12,
                 from ../include/linux/memcontrol.h:13,
                 from ../include/linux/damon.h:11,
                 from ../mm/damon/core.c:10:
../mm/damon/core.c: In function ‘damon_verify_new_region’:
../include/linux/once_lite.h:28:50: error: expected expression before ‘)’ token
   28 |                 bool __ret_do_once = !!(condition);                     \
      |                                                  ^
../include/asm-generic/bug.h:185:9: note: in expansion of macro ‘DO_ONCE_LITE_IF’
  185 |         DO_ONCE_LITE_IF(condition, WARN, 1, format)
      |         ^~~~~~~~~~~~~~~
../mm/damon/core.c:127:9: note: in expansion of macro ‘WARN_ONCE’
  127 |         WARN_ONCE();
      |         ^~~~~~~~~
'''

I changed BUG() to WARN_ONCE() on the last moment of this patch posting, so I
missed this failure.  I will fix this on the next revision.


Thanks,
SJ

[...]
