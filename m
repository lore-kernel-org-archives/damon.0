Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877635CBD5;
	Tue,  3 Feb 2026 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096921; cv=none; b=FINfoG/GFO8nkqw1WJehC0RhWFn71sSwrYwTHxIi1e7OFq/qqmjRiK7uoKnfgWJFI8m/jUttBygbC22K/to5AULDvVZrv2G5DPmMqwhwmNH5butmuCIY5ctxL1o7dEEq/i6fWqd3oEmOTX0IQvy3gMSU4nH1zHKd+h6vugnAySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096921; c=relaxed/simple;
	bh=4rPxl6OOP6sNccgj3vhJcnJxxzSSyqrvjl9HaMBD1j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7NX6Tt2RaZdwhAi/VIStY5pZLojC+Y2CYKwLDsfX2f7VAai7Y9oVEEdvyoUeEYenBZoFRYuFn5C/BCDTbUTcyi2g6o/kUts8C38WPa0T+rYeoCRGeTSTvAfpwTlfKYS9o/+xWvbrgpyh1SP9TZPjMcJnkCL2B5/tZrJIH4uQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWth5Gk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWth5Gk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B863C116D0;
	Tue,  3 Feb 2026 05:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770096921;
	bh=4rPxl6OOP6sNccgj3vhJcnJxxzSSyqrvjl9HaMBD1j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWth5Gk5KeVbwGf/muRDw7eEJYlaNSwLqCCCb9ECwm26tdnENHiCzbn/wdbr0wbgE
	 yvmYQd/MuUkz1CFM05NPGBc46/uN/NQjGiXonOkYxwhZT1CbpUNOCti1dyVXGeimXT
	 UwZvMVmmuDjfrbCAdutZ3vuouBvU9z66vJosrMVQ/SsFoCsbFl2KQPQAlnghrnmFkk
	 bPLIbxewq8VlpQRrKcyUeC7Fu27fDBngZFJYAlEMpk3+N13D7Cg4gWGyL2i9TE8rKo
	 eToeSk+qJqrmq3VlZs7nInxGA1jixZuMu+esioGY5/4h/AtPvXA0TUrNCVFJixlyBy
	 6ahifE5tTCQ/g==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 4/4] documentation/mm/damon: Documentation for the dynamic_hugepages module
Date: Mon,  2 Feb 2026 21:34:45 -0800
Message-ID: <20260203053446.68919-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202145650.1795854-5-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's use "Docs/admin-guide/mm/damon:" as the prefix of the commit subject.

On Mon, 2 Feb 2026 14:56:49 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Documentation for dynamic_hugepage DAMON module.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
> ---
>  .../mm/damon/dynamic_hugepages.rst (new)      | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/damon/dynamic_hugepages.rst b/Documentation/admin-guide/mm/damon/dynamic_hugepages.rst
> new file mode 100644
> index 000000000000..a6afb0910661
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/damon/dynamic_hugepages.rst
[...]
> +How It Works?
> +=============
> +
> +DAMON_HOT_HUGEPAGE spawns a new kthread which will monitor the applications in
> +the system. The monitor thread will calculate the moving average of the sum of
> +utimes of all the threads for all the processes. Then, pick the top three and
> +launch a damon process to monitor the hot regions in those tasks.
> +
> +Since we don't know the minaccess number in advance, we set it to 90 initially,

minaccess number -> optimum value of the min_nr_accesses value ?

[...]
> +Example
> +=======
> +Below runtime example commands make DAMON_HOT_HUGEPAGE to find memory regions in
> +the 3 most active tasks. It also asks DAMON_HOT_HUGEPAGE to do nothing if the
> +system's free memory rate is more than 50%, but start the real works if it
> +becomes lower than 40%.
> +
> +    # cd /sys/module/damon_dynamic_hotpages/parameters/
> +    # echo 10 > quota_ms
> +    # echo 1000 > quota_reset_interval_ms
> +    # echo 500 > wmarks_high
> +    # echo 400 > wmarks_mid
> +    # echo 200 > wmarks_low
> +    # echo Y > enabled
> \ No newline at end of file

Please generously give a new line ;)

My high line comments including name of the module, the expected use case of
the watermarks also apply above.  Same to my comment on the third patch of this
series,  I will do more detailed review of this patch again on the next
version, since I presume the high level idea discussion is the main goal of
this series.  Correct me if I'm wrong.


Thanks,
SJ

[...]
