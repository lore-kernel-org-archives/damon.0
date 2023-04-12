Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E16FD2
	for <damon@lists.linux.dev>; Wed, 12 Apr 2023 16:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6775CC433EF;
	Wed, 12 Apr 2023 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681318688;
	bh=qEym68sXMMO79/ef6jwH0/WMRK6ifej8V9kh6pO6Nks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdM4KzxIZkv1ULAS4OtVgKDbS37cSTSOjXacui2q0LZoYz8GktC3FJqekjCS2V5nl
	 QYdkMKav/YAvgww2sj5HqyV3XZXd1NJ7JhMZyTX2m88azi37Ki/QxQBU3mBS+8V4v8
	 oaa45whwzZtUoj+N0RgTvdGlMBqEtT7c7beP/1K1qZPif8PPDXfb1EbDx1xlEjSEnt
	 5hEqr2pMWId3pE3bZs3YVpPeYQ7vyO7V4ihViEGvEzcxBdEHJAa1v6VoRwY11OrT5O
	 xoZwIFVbm/FXFGHQ9/HliNnPl/kqsDrZ9ji9FSvA1kBKxYL0lM+Mitz70Abyy5sFbj
	 m7g8t5e30YEmQ==
From: SeongJae Park <sj@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: sj@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCHv2] selftests: damon: add config file
Date: Wed, 12 Apr 2023 16:58:06 +0000
Message-Id: <20230412165806.80672-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412092854.3306197-1-anders.roxell@linaro.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Anders,

On Wed, 12 Apr 2023 11:28:54 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:

> Building and running the subsuite 'damon' of kselftest, shows the
> following issues:
>  selftests: damon: debugfs_attrs.sh
>   /sys/kernel/debug/damon not found
> 
> By creating a config file enabling DAMON fragments in the
> selftests/damon/ directory the tests pass.
> 
> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

checkpatch.pl is warning as below:

    WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
    #20:
    Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
    Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

The reason for the warning can be found from commit d7f1d71e5ef6 ("checkpatch:
warn when Reported-by: is not followed by Link:")'s commit message.  Do you
have a link to put here?  I guess the report was made inside Linaro, so might
have no publicly available link.  Maybe better to add some notes or some funny
tag like "Link: N/A # no publicly-available link of the report" for convincing
the tool, but I don't think this should be a blocker for this patch.

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  tools/testing/selftests/damon/config | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 tools/testing/selftests/damon/config
> 
> diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
> new file mode 100644
> index 000000000000..0daf38974eb0
> --- /dev/null
> +++ b/tools/testing/selftests/damon/config
> @@ -0,0 +1,7 @@
> +CONFIG_DAMON=y
> +CONFIG_DAMON_SYSFS=y
> +CONFIG_DAMON_DBGFS=y
> +CONFIG_DAMON_PADDR=y
> +CONFIG_DAMON_VADDR=y
> +CONFIG_DAMON_RECLAIM=y
> +CONFIG_DAMON_LRU_SORT=y
> -- 
> 2.39.2
